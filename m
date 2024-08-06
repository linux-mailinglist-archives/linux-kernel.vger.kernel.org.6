Return-Path: <linux-kernel+bounces-276437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4C9493A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1BE1F21734
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA01D2795;
	Tue,  6 Aug 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OBi49lSe"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535131D1748
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955751; cv=none; b=kxGnqqQHR1H39wYL31sLri5nDCEmAARHe42PRZQlnEjVva3GhiwxA41/fG+ONZ9u1Mkys66BGic2RbXKfBhSvyLB0c1eHDEUNzhvM8gpTK7JUaYxzuc/48C8SmBtaEu+1GvBRXxu1P8dkqMlFbDqEzWFvN0ponfYuMXZG8KMiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955751; c=relaxed/simple;
	bh=cCHKtmZMWG5EuRXdTg7nfVOF5FzmMBB79fIHhpEkj/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz/sJ8OhOQw6YO1hkX5MpfgUmSWTSyHM1O/ysnz7fdiu7hWdDUMRBsOzB/7Bv5IBUS6aaGfzFCsCtnME8HiyE9omgccBKQu4Kda6Nte1zuGmg4aFudLYqRbdTSVfQ6RLH21CNjCnNpoFAoNUR2u1fXSyCOhdAfcKptkZL/2mtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OBi49lSe; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530ad969360so1082810e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722955747; x=1723560547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1nh4YKkk4IMpcnlyRV2vMP/rs/wYu0mGINEfgtlYvY=;
        b=OBi49lSe8519VYyTOwUu52M5uflJDOGlBXHO4oLCXss9WmwSzayDIs/0FAu1jTFVVc
         jgq+khHITyqxAgHL7fRa13cfzDT/exZpr4zjd67Nm1D+OHyBHA8Bqvv9Gw6CF57+rhaW
         BBLsX8iQB9XUlHeLIJ4x+ENwvj5TSSlCzgIm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955747; x=1723560547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1nh4YKkk4IMpcnlyRV2vMP/rs/wYu0mGINEfgtlYvY=;
        b=VvigYCy7K8dgLtu8OUzRdxjn3x9TzGKRb6oD+kQvQ56D5uRziLl9yW2H8zRDPlt7Ab
         113EiwooAuXi+UTtd3zPJCqbCnEBexQjtf/1EITmK3amPjPiPf40Y992S0SFUgH68PBn
         gqf/cow0ytqcZE/ownSQk2iJ6RjFP6E1Avvf+7m3FhZAgOpBqlLfEAiIFCP3WoR9FHDf
         ViqL817bhhCqCSpHtJX01VQC7+7ePVWuNmdaRtae8AZ2qkWGAq1tHm99VT/a/TMawFoX
         Qzuh7Osq2CIy+tE9WrXfmvnzq2+TgHG++b7tkYDmOPXJI0FZ51jU8fdutMJ4MJYJmxo1
         Sl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIPcisQJ6wndH7yMs11ZIr0wWkUEKbSczOzOfJY3TH3eB5CpO4/PQrSNl8Nmn1EXIgAakrbLh6OZmLmReWyB4OTb5dcEFcLFVa0VCA
X-Gm-Message-State: AOJu0YyU4RqilV1K+i+NZo6ibLi6iZURFWlkmBnqderNPW/Ocd0LL4NO
	TyHRml8nOTp805Sjt+imFYxEluYxBw3GEM63a7b0FW/NoYu+cqwv8SF0p99Lhtw0DkX7avV5Fnc
	fRx1GbQ==
X-Google-Smtp-Source: AGHT+IEhNr2kxVKqdEmtOaQJMt3mR0zd9n9oTQ1Pg7yzU7sTZhI23MDBSr9EYLTv01MKmxKXHPcU1g==
X-Received: by 2002:ac2:558c:0:b0:530:c1fc:1c32 with SMTP id 2adb3069b0e04-530c1fc1e55mr6703372e87.45.1722955747102;
        Tue, 06 Aug 2024 07:49:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7feecsm560493566b.176.2024.08.06.07.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:49:06 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so1039099a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:49:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeZTKIm12b+M3qENopXJQ0xomhcg3kPM3aOuJaCtQPxpwlZdJa0Nete1ZFoAtRlcnQwKpjQF562SAhz8OirD+cu+1ke/+0jOj+/YXL
X-Received: by 2002:a05:6402:c08:b0:5b9:3846:8bab with SMTP id
 4fb4d7f45d1cf-5b938469427mr8541227a12.14.1722955431683; Tue, 06 Aug 2024
 07:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
 <87o766iehy.fsf@mail.lhotse> <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
 <87bk25j1sx.fsf@mail.lhotse>
In-Reply-To: <87bk25j1sx.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 07:43:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
Message-ID: <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 05:03, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Or should I turn it into a series and post it?

I think post it as a single working patch rather than as a series that
breaks things and then fixes it.

And considering that you did all the testing and found the problems,
just take ownership of it and make it a "Suggested-by: Linus" or
something.

That's what my original patch was anyway: "something like this".

            Linus

