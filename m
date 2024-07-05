Return-Path: <linux-kernel+bounces-242335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8F9286D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7408B1C220D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC29143C46;
	Fri,  5 Jul 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fEQcYaic"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667C148823
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175422; cv=none; b=aIxQvj5KY+pN3BTs057XK+fwhPBWaoJu3qM8NL4djF4Z8AsLbOIK94MH8VWOW6g8zOIpPiTMOfvT8L6gocSrO8FyZff9yTBEMCFV50/Mb0BXSrwSCDeclkqBcir+L/GeeYUTCJK5bAdLVx6cp/LpWQdghEzelPeegn+S6cYA3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175422; c=relaxed/simple;
	bh=Xd6u1+CbZljlQHW4wqx/TuMxBzFTf5S2V9fG33HBH2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw42ghani6x9B2nJJ489b5WTA2daS7hLxs9sMWVFe6oCHnN4zxeH7LJf8QR9Ah7Kb5pwgeSwEoJ+56ZfEES6P3sSICfrTv55IaQJnJEK9bJpzEfoU1R0QYCFMIfzdwHzTJ5J6ZSVqqDgl9FmgZ7O7fDXWhQIUxPlnqWOIeKvyfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=fEQcYaic; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so1890194a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1720175418; x=1720780218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd6u1+CbZljlQHW4wqx/TuMxBzFTf5S2V9fG33HBH2g=;
        b=fEQcYaic93eYo/XFepSQ/xBG8sbAD5kQtZAICeOEJty7PDpzpTCB26E2Mc2ErfMTDn
         KAfoWaA0W8O+tT6gURSMjtCbRO3dmfGMEhthoMSIa8KbdIrCMuC7u2E7xBxYzTJMaJ0x
         PHJGFgfUlJjy2P17LecjC0xriAnpO3ykmKKJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175418; x=1720780218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xd6u1+CbZljlQHW4wqx/TuMxBzFTf5S2V9fG33HBH2g=;
        b=FPfL04HoxpCay/oBab3wMufFYfTGf7WNqwXsFYMJuCedNyisXNKmehjstkKdT91ZoL
         ASnaZEXMpMbgsT/J8XOuIUBAtImUl6QVrFSd6jFb014s4St/rWaa+OG+3FaHfoSiCup+
         BwRXAtBe8XJKCzSz4zmyBli4vdWcSZP8fZUq6ucLAF4yHi6CCTspUUKd5UOSPGHQbwxI
         ZHkaTyX2t31f5cdtcpTSJ1WYFFIqu/FgNhQwUaZWW/aq02LL2aBrfbbQs3wSwv/AlGqR
         dSt8Xn+TZuuSna8nEJhq0IMbvElPtPvreK1BNKiYutHPxIw52scLLIkkr/p7dj+NRA+E
         HsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8DZb+MzjIlN3GmB3LxFHL8Ywe4OPSXRPKbO3TYBA4XdwHjsciOKgeiyX6YKO1IxNfKdv657YKopzmK/ccnDmJfnj76E0icrLLQQdH
X-Gm-Message-State: AOJu0Yw1DdOiKjxWulxRgLLo8Fmmx7vPbt4yl9KucI12seRG+BWGDzwL
	ZnZ/mraT7X1eAH+vJbUo7AQX8hO6wS9gEQPhJ572++0FJHySpePC6l6e9S4Dhkc=
X-Google-Smtp-Source: AGHT+IGera5cMW/Kt19ogDVNnY5F6C726jOXd3dxOsih7YK9D/ixV4+h1dtrLy7TOhnEDQ8exB7a4A==
X-Received: by 2002:a05:6402:2792:b0:57d:10c:6c40 with SMTP id 4fb4d7f45d1cf-58e59265efdmr3329986a12.7.1720175418558;
        Fri, 05 Jul 2024 03:30:18 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58e88a6c067sm1713083a12.38.2024.07.05.03.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:30:17 -0700 (PDT)
Message-ID: <cda57e5f-acf5-414c-8faa-d2496c02ced9@citrix.com>
Date: Fri, 5 Jul 2024 11:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: dave.hansen@intel.com, xin@zytor.com, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, peterz@infradead.org, nik.borisov@suse.com,
 houwenlong.hwl@antgroup.com, Juergen Gross <jgross@suse.com>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local>
 <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com>
 <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/07/2024 10:44 am, Borislav Petkov wrote:
> On Thu, Jul 04, 2024 at 07:45:00PM -0700, H. Peter Anvin wrote:
>> Except that that would be more cleanly spelled wrmsrns()... let's just
>> abstract the whole thing away and let the user use wrmsrns() whenever
>> serialization is not necessary.
> Just don't make it more complex and unreadable than it has to be.
>
> cpu_feature_enabled() already is patching things for optimal perf so even if
> PeterZ prefers the alternative, I say it is ugly and, more importantly,
> unnecessary.

You cite perf.  Look at the disassembly of the two approaches...

cpu_feature_enabled() might give you warm fuzzy feelings that you've
eekd out every ounce of performance, but it's an absolute disaster at a
code generation level by forcing the compiler to lay out both side and
preventing any kind of CSE.  As I've reported before, count the number
of RDPKRU instructions in trivial-looking xsave handling functions for a
glimpse of the practical consequences.


Anyway, none of this is the complicated aspect.  The complicated issue
is the paravirt wrmsr().

TGLX's complaint is that everyone turns on CONFIG_PARAVIRT, and the
paravirt hook for wmsr() is a code generation disaster WRT parameter
handling.  I agree that it's not great, although it's got nothing on the
damage done by cpu_feature_enabled().


But, seeing as I've got everyone's attention, I'll repeat my proposal
for fixing this nicely, in the hope of any feedback on the 3rd posting...

The underlying problem is that parameter setup for the paravirt wrmsr()
follows a C calling convention, so the index/data are manifested into
%rdi/%rsi.  Then, the out-line "native" hook shuffles the index/data
back into %ecx/%edx/%eax, and this cost is borne in all kernels.

Instead, the better way would be to have a hook with a non-standard
calling convention which happens to match the WRMSR instruction.

That way, the native, and simple paravirt paths inline to a single
instruction with no extraneous parameter shuffling, and the shuffling
cost is borne by PARAVIRT_XXL only, where a reg/reg move is nothing
compared to the hypercall involved.

The only complication is the extable #GP hook, but that's fine to place
at the paravirt site as long as the extable handler confirms the #GP
came from a WRMSR{NS,} and not a branch.

~Andrew

