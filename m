Return-Path: <linux-kernel+bounces-267955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB9941DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CAC1C235D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631D1A76C6;
	Tue, 30 Jul 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wQFK7gsA"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379DC1A76C2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360061; cv=none; b=IZLAFNLb4zgHduPyDYmKlQ1hCZ+Hu9RpM5AKOGfeF8JU/0pyo03Z2W8DhbYDUYLl7LDEfcdxCD7cKAHrfJhVLndLZfXDGrK3c7ReoMjGcCYWyka23f6CYi8U92DZxDOeAdcglajlBySqjpypotHB1nsuy4DtMJRFOAVlgKRwogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360061; c=relaxed/simple;
	bh=gilmgvvnRDW48643Y2UQqpXPuH6u2i+zKRT3ZYJx3SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoorriymR9fBzuH43djznBMNrA1GSTeszgmMSvaUZOiYQS8e5CLttDs/F7wPmrER4aaCOsq8YEJlxCjhcEu+qANBRnLS1gIXuUl/4gvrcOdojo7bopmeXKxAHPzUzmz4+oVvK5yPmsnSXMKVOc3Y+f57WNi8YgsJ7OmwfFt91Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wQFK7gsA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d22b6dab0so327590b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722360057; x=1722964857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+nxyTl7Ekb0gD3rQGusn4XP3/PcsOH2OJ/B5lLVXyg=;
        b=wQFK7gsAW8CKgDsF3CUInyJ69Yqtn6POPn1rBUYotXvDyDAi1CegzDvGiNxywpr6K2
         AhbMRIMEoaiama2he7iFi41pVMhDrQDdH+yCviaC38DNpsKN8bU0yrvmI0P2alsOVt3J
         zMB7iBxXUwRYhQY4HmRD2xUAgwdduCrmRyO98Rz/8YoRx7l7mcmfdOOANaMMcntEr/dK
         1IfEFNaYFeCV9jDL4nbMq6KDzm+QP8sV69MRf2LTZcsdXte+fkGhyI+8DOSOH21S/QwY
         c0BDKJ6Ggt+CAES248f1qmOu57f6UdjFkseeqI5H0qv0Dlr+kbT91E3xYtFs+LDFHUuv
         THqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360057; x=1722964857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+nxyTl7Ekb0gD3rQGusn4XP3/PcsOH2OJ/B5lLVXyg=;
        b=oxWvQEew+lRjezgQC8LC6gy6Ni2r8oovUD/NpT+tkwcelVbATFcU/K69HL7QL42K58
         b5KeKT0ON9BsWk11RCoohENHH2bDP5uiaZNQBD9RnveXDYoDmlXsnIMYipeRzGNzdFhi
         qQGIA2eeYYv3KV/8DWdyZHnvDoSWusi9eUOSEU8Mnx6KFk3I6b89hMN1OtraWx92Eih/
         PogkztxDIxhy0wD+GO/yBEPPmnnjtnd5j+zO8Un1NnajLu5J4Mp1C7gcOu4z7sJEZa6O
         wYnrPC0tDzjJna/4lDHgY/4vxDJZAuzIrJoaRVZal73QnXjeZzhSVzwsBh2apPITp2vb
         URqw==
X-Gm-Message-State: AOJu0YxXewy1/zRq3EH8Zrq5pbOizaHCBri1yxO620pyG6CBkSO5k32K
	uen3We7qhRZuZeHfXXMAi4pDj8xx1wKDKkuuPh8NOrklTt9CKGcE7yUmsPQ6ygPaQhgmM5iiNpc
	I
X-Google-Smtp-Source: AGHT+IG/K+mLTBx+zlKkfcZIQegT8GleqF1JP5YGv6lWIb6O3LweSM1pIR+7r6ugQ0Yv/Wn1X1EuXA==
X-Received: by 2002:a05:6a21:3282:b0:1c4:c8ef:8e68 with SMTP id adf61e73a8af0-1c4c8efb405mr5426658637.9.1722360057513;
        Tue, 30 Jul 2024 10:20:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm8678503b3a.200.2024.07.30.10.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 10:20:57 -0700 (PDT)
Message-ID: <63e7adbf-0eb8-4d59-ae7a-689b9d9f69b4@kernel.dk>
Date: Tue, 30 Jul 2024 11:20:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 11:04 AM, Guenter Roeck wrote:
> On Mon, Jul 29, 2024 at 08:29:20AM -0700, Guenter Roeck wrote:
>> On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
>>> The merge window felt pretty normal, and the stats all look pretty
>>> normal too. I was expecting things to be quieter because of summer
>>> vacations, but that (still) doesn't actually seem to have been the
>>> case.
>>>
>>> There's 12k+ regular commits (and another 850 merge commits), so as
>>> always the summary of this all is just my merge log. The diffstats are
>>> also (once again) dominated by some big hardware descriptions (another
>>> AMD GPU register dump accounts for ~45% of the lines in the diff, and
>>> some more perf event JSON descriptor files account for another 5%).
>>>
>>> But if you ignore those HW dumps, the diff too looks perfectly
>>> regular: drivers account for a bit over half (even when not counting
>>> the AMD register description noise). The rest is roughly one third
>>> architecture updates (lots of it is dts files, so I guess I could have
>>> lumped that in with "more hw descriptor tables"), one third tooling
>>> and documentation, and one third "core kernel" (filesystems,
>>> networking, VM and kernel). Very roughly.
>>>
>>> If you want more details, you should get the git tree, and then narrow
>>> things down based on interests.
>>>
>>
>> Build results:
>> 	total: 158 pass: 139 fail: 19
>> Failed builds:
> ...
>> 	i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd
> 
> This failure bisects to commit 0256994887d7 ("Merge tag
> 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux"). I have no
> idea why that would be the case, but it is easy to reproduce. Maybe it is
> coincidental. Either case, copying Jens in case he has an idea.

I can take a look, but please post some details on what is actually
being run here so I can attempt to reproduce it. I looked at your
initial email too, and there's a link in there to:

https://kerneltests.org/builders

but I'm still not sure what's being run.

-- 
Jens Axboe


