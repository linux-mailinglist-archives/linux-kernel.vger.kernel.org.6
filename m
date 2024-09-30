Return-Path: <linux-kernel+bounces-344953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D198B088
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85D51F23413
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB120184527;
	Mon, 30 Sep 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NCezBUj2"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009F21373
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736732; cv=none; b=JyDiZ3IDu7KoFFYGajCc+vBdqQB9tf+QbAlNYm9a5EQvAX6iexcEzO4n2d81WqIunplTjpBBCOqygivXqUCabe08FMpqXrjkMbC9T8pZnhZGyxnNgPqyJLUWloeFTJvlcUhFXsIHuQPfWDQ2sJt1a4slHbjpUK1n7MGpVWb7D5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736732; c=relaxed/simple;
	bh=7QYQmhSnHjlcJifdpZYQJWSthy0wPL6lXdY8KiFhI8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFt2fCOJfByKFCBzNwd3UfmN8ht2Mci7Dw9+dGqUK4tMkvuLDGvJ4hHVC0iYtu95yiUBDZVVgyEbhI7n3mCKd9S6FIfuRvVVddLrVKWW9L/SF/MP0VKtoXMY8FwOPR1QVDS5Qf9D9/ICWMqO9/2TTWUWOvZKkP6iqZZfEzO0iKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=NCezBUj2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso2560698a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727736728; x=1728341528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EuVj3DK9fvwy40gpX2bGV7WBUZ5x6gW+SeMAKNAGnFs=;
        b=NCezBUj2fGiVewby3Hnc3sr8/Ctmkb0twXoWMCtaym89IT61Nu4Xw4ufj4OqEILzDh
         c3PV0eK2pw3hELjKkkiny/oeeKys4OT4dVInWLinQ3WnAAV/SxuIDAz22hHxFAqh1Sge
         1/v9dP+l1AM7oJ9/zFv6Yabp9rZNsnEeByiws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736728; x=1728341528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuVj3DK9fvwy40gpX2bGV7WBUZ5x6gW+SeMAKNAGnFs=;
        b=Tj3rEYQSgHrr8EomFSGKhhRRI2C93pjUpKGAx3/C5OA1ghcJhgWhwu+gHOtS/LkfPH
         jJ4encmkEELTyMhIPuVuhdnS9SuvjwbyOJEgZTPk7flvp8TXoazZqni7ufD5C39czzIV
         +8tPqBeEyInqTGoWPwqCoS2fhBnSVNWxIJmdUTzLR/vowvlWiuHyPoOPQkoet1h+6b8J
         spCLimsoXuxLoSeYnSuuOFD/3uq7glRmUH7W0K7Gmdoq1bIwE88N3SI1S52F0FqASoLb
         DlXes46kaln+9SuM7ukt389T+jWxI97SRX70aP2H5SiZXswfSUMYSGS537Y8//FxmqK4
         oC+g==
X-Forwarded-Encrypted: i=1; AJvYcCUqkxkBu/UA4HrQbXFfO+k+4skeyAdvFoGWYlvdVjM5OnebUb0gjO6Ja49PVPZtQ9NCu593LSZFz03TquE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYRqINyDl4Vu6wfVErgRzqH/uvRybfIB3UUM7BQ9SD19S/qea
	vcX3TvX0draPVz9EEczgYE/4/T5TUs0gIe5znV+aOiP0i1KB7eXR8Gzhx57BNxE=
X-Google-Smtp-Source: AGHT+IErIS/9I9YEvOn9/uXlHkCYf21QbahKRCEkKDVtZevoOJYVosz4uXa6eodBnnNLQ0tE/+oNyw==
X-Received: by 2002:a05:6402:1e93:b0:5c4:1437:4159 with SMTP id 4fb4d7f45d1cf-5c88261a949mr11643410a12.28.1727736727741;
        Mon, 30 Sep 2024 15:52:07 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm5036007a12.19.2024.09.30.15.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:52:07 -0700 (PDT)
Message-ID: <7cfbdab5-6fa8-477a-8a49-da458a5e95b8@citrix.com>
Date: Mon, 30 Sep 2024 23:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240930223848.ulipiky3uw52ej56@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/09/2024 11:38 pm, Josh Poimboeuf wrote:
> On Mon, Sep 30, 2024 at 11:23:38PM +0100, Andrew Cooper wrote:
>> On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
>>> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
>>>> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
>>>> +	UNWIND_HINT_FUNC
>>>> +	cmovne %r10, %rdi
>>> IIUC, this works because if the "jz" in the CFI preamble mispredicts to
>>> the __bhi_args_* code, "cmovne" will zero out the speculative value of
>>> rdi.
>>>
>>> Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?
>> There's no encoding for CMOVcc which takes an $imm.
> Ah.
>
>> %r10 is guaranteed zero after the FineIBT prologue
> If the "jz" in the FineIBT prologue mispredicts, isn't %r10 non-zero by
> definition?

FineIBT uses SUB (and not CMP) to destroy the hash in %r10.

This makes it marginally harder to leak an unknown hash; you can't
trivially deference it, but there is a linear function if you know the
hash of the caller side.

In the bad speculation path, you're still overwriting pointers with a
number that is < 2^32, so will be stalled by SMAP if dereferenced.

>
>> , but I don't see
>> anything in patch 11 which makes this true in the !FineIBT case.
> I thought this code is only used by FineIBT?

Erm pass.  Peter?

~Andrew

