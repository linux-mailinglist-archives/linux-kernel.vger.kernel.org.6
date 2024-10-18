Return-Path: <linux-kernel+bounces-372071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA699A441B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0A28538E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FF2036F7;
	Fri, 18 Oct 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RGUnS/yE"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB422038AD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270060; cv=none; b=h0aWkfr5Pd2p+1jUXe/c0PemMoCwuAWnlyQcYK/FL0bYMDqaYaxSz/OzTPyaIsZjRDhmtUEawwC+1lmHHHtRC9y0cMkW8HIFuO2nP2WRORYeYvaRyWMvHm0yqQRkuOUDZZ2Bx2RvR7Q+8FvmDnNteS4Q+WdJCMenf9X+BaRA3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270060; c=relaxed/simple;
	bh=xOigHZi6vJGJCP887ppV80pj6xxRD92G/nmgaWkqArE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqcy54YZOyFvh7lSRgtqFNblxzyoiNTQOtT64Z1LyFUEsMrTRjeLHlATyLbOwA1OpI+x5p1t+f24lFftr2ltAqgeFcxZNLtIP4LAMkdiEuh8fZnJE+mVFnJUh9260Fta5yVaaxcSVov3zasFcP3g8IzQP/oon562IzdV/9+uWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RGUnS/yE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83abe4524ccso27157339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729270057; x=1729874857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xrAsGY1eEGZc5Yu+CpN7tXZ0WTm20eWqNXI9YXSfRI=;
        b=RGUnS/yEMWUzU9ENZpfZBdw19LPJdoUJwXb5i83TMFZNAS2INDHjXRhibAQzAFSH/5
         LLKfxyz7sQzPvzW087xjwxPTP+bVoQ/qPc97Jj0fDYLEQ/tEzaHCkfBspojLtuP3mRdn
         qhTWc9euTgFScdI0006tPYvbwSO442hTwms8K/rkUiC3IR9ncu3/rmGllxBORyUArwW6
         wxYkOi/5CF96NCSko/dbv2MXCm+v8GX0AYx1lczgAySyrZZu7PiTzNXkJLGHa85jQ52t
         Ql/e5vpoYfSPxADJpN23gLfVwf0mZRsx09xnk8M+GaZ4mmrCXnyzIGtGJBi3ZB83MthU
         4dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270057; x=1729874857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xrAsGY1eEGZc5Yu+CpN7tXZ0WTm20eWqNXI9YXSfRI=;
        b=D9ZfV38kQF7GLroWPIBUOi14nLAZzfMwG0+/xb19vSmi4KZI5OA7DSxq3qU54cFNBo
         K7pzq6UMHVvELhLCE03OAfnNt6NFf1lihAWwdcsY/iNABp/3omEJzm+5MiyOcfaRUKNa
         LhaE18l6/OxZbKrL0zmPxKzW0J2stAVsg1ZgzgTznJVm2mU7UJgsEU1M1XfbRYIbgGL7
         Jreas2+vhgLzauDgPRQMzArB6aSOTlUJuhs4ugWRMljVXEx6KR4DxgIEFZxU7+TrDijW
         ovFm1dvje/ASav/13nvuOhUqRQHdHX88ro03D17ej3i9slShqQFZjmrcXqZj2b+1IQRk
         XINg==
X-Forwarded-Encrypted: i=1; AJvYcCXyC1ftbo+Erc+h529jzc9lTd0pDCrxdyXDB2tizfluegs254iZ0x5qvBaN4TWKCaiYOi404VUZo2ifa04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJbQnRxue9lzZyGzqRuXNSRnLVnJ/b72v26yRmtz+eAOzG2Sl
	6BWEEcjXnj5VuArdvabsUXKxIkHTRl8a9lK3JIdoiVVWz6/ZOZ5ipN153lFSbgk=
X-Google-Smtp-Source: AGHT+IGRZ5eg+vk3mqFXMeZHbFvptacsGMvZAkLKGH1anWYrHQLxW0thEDoHSVJdXnmUIcdGae9biQ==
X-Received: by 2002:a05:6602:2b8d:b0:82c:e4e1:2e99 with SMTP id ca18e2360f4ac-83aba64bf11mr384868939f.11.1729270057395;
        Fri, 18 Oct 2024 09:47:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c4efb1sm487582173.155.2024.10.18.09.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:47:36 -0700 (PDT)
Message-ID: <aaf25389-e0c3-408a-ae05-a166c1720bf8@kernel.dk>
Date: Fri, 18 Oct 2024 10:47:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <ZxKQux4I8We0Ax3-@gallifrey>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZxKQux4I8We0Ax3-@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 10:45 AM, Dr. David Alan Gilbert wrote:
> * Borislav Petkov (bp@alien8.de) wrote:
>> On Fri, Oct 18, 2024 at 07:30:15AM -0600, Jens Axboe wrote:
>>> At least on mine, the BIOS has an option that says something like "L3
>>> cache as numa domain", which is on and why there's 32 nodes on that box.
>>> It's pretty handy for testing since there's a crap ton of CPUs, as it
>>> makes affinity handling easier.
>>
>> Right, so two boxes I tested with this:
>>
>> * 2 socket, a bit different microcode:
>>
>> [   22.947525] smp: Brought up 32 nodes, 512 CPUs
>>
>> * your CPU, one socket:
>>
>> [   26.830137] smp: Brought up 16 nodes, 255 CPUs
> 
> (Probably unrelated but...)
> What happened to number 256 ?

Quick guess, maybe iommu was off, will cap it to 255. IIRC...

-- 
Jens Axboe


