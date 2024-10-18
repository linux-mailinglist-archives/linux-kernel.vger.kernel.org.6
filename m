Return-Path: <linux-kernel+bounces-372073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949549A4420
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD471F24139
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DB2036F6;
	Fri, 18 Oct 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C+A+wuA5"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C5202646
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270103; cv=none; b=gHC2WDDRXQLZGsazKbqdV0gREzd1j0ftkEzDMMf4/51zlOQROY4L6IF75t/L9Ik1TEvZi8wf+KqHqn8g1X4bF+27fusGw8EdrFwpuvw5eXJYU5kaOixF0MnekwRgQKrJd2BGhLls8t7Bq4TCWYf8XPKLLW6aVMnzawbhV4TXdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270103; c=relaxed/simple;
	bh=2gVazl7nKYfRtqHkuznO7IlKsAos0KEtPsC/2T5xRuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkkJqxtRVWjpdM/0kGcTHtR4Uvi3nbetFnPV81hlMeeHEllVPJhU+gQMLOnESi13+OvveZ8Nbx7+nRJm032qXMMc1rD3q2ASqz4yxzayGk/+fNCZ5Hokezet5htqxsdR61Ak56NuEBCQN5bowymzAbh9azEWgM3KmJ70UKnGz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C+A+wuA5; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3bb6a020dso8944435ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729270100; x=1729874900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=av1dvVgxRINqjkfGwU1Y4hfZrkDbWWqwoh0Lu3GbIW0=;
        b=C+A+wuA5Pf+KZUiAG4ByHPvI4C5HJV57CdMq2+fU++HDuXDnYxXbHkVnKy16Ig6D8E
         nZUEJt67zgZ1izcrveadV4WFjtbuO0sRM8iiu2o34UoilTIBdjx054qsYbqR6CeSBwJo
         fusfb6zkR9YRsxLvyk0IHZGUEkmE0xmseqrsMYET29OcSz730Nm7wBXNPj2rcTIEbshV
         3i4u1J4tLlLtAFuFlyPJz6lYWHuIlcBnUkfsEC2vjaw2ZzsC/sbv6eK5zbWpxnkOgfpy
         0OPIJO5eiORB7psuxXV9/ZMoBPb48RjizGnMCaTBmaTPbgh3cJ/CAqMHaf7messTrBG4
         u91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270100; x=1729874900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av1dvVgxRINqjkfGwU1Y4hfZrkDbWWqwoh0Lu3GbIW0=;
        b=PNHNPkkRbjkDLw7buSX/sxKuDbHJTKSWDyIEzW0Jiw4ks/utAJo7pwLYUxHBWRL9/8
         2Aui/3SmeQCFCm+gDKD3/J/HXZ2B66YsatYpXvssntvRZpV9R68I/vwkuvkiMD3ThtBF
         eoUVWP3Ky/0/NTltOkEhLJjeGEg8vGDA8tFcBMlzQ8TYSmy0NEUq07ZMrjP3IjPAasDw
         qbmRZd2aIln0hgLUjeTBCvPJYDBRkWBmM+0qK2/y55gos7oSsAMMTaeGZJN0mHt4r+6n
         pr2frVH2GmKbRfBWZRPzjpEAnmSjZlBV3nPgz05v6t9Nj/qLzwkOMVwpRwJgzF9HR5h5
         1vRg==
X-Forwarded-Encrypted: i=1; AJvYcCWfQYt6leVTTPNAre9QYhDWgdczeF0bAWs2P72AO4HyKUyhM8G9UWlYG8V1ERSznrdZCmISv1Tlia6I0CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnuq/E/cnlbmrkwgXG1I8ugbxbMQZQns17UY92QLZMyamo8hBV
	l/c4nyhF4k7+NeZKlriAGTRnOZLwDt6GFUcIwbqTrqfGme0ynIXdV6Wwyrgy8NE=
X-Google-Smtp-Source: AGHT+IFAh+je2v03pVnvhk/+yEtAQabCicAv13KOXe033JZQY+kaosl7Y0Zvxqb4nHpim46gA7G2Pw==
X-Received: by 2002:a05:6e02:b2d:b0:3a2:4cc4:cfd with SMTP id e9e14a558f8ab-3a3f40742b4mr30344645ab.14.1729270100431;
        Fri, 18 Oct 2024 09:48:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c6d327sm493873173.174.2024.10.18.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:48:19 -0700 (PDT)
Message-ID: <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
Date: Fri, 18 Oct 2024 10:48:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 9:51 AM, Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 07:30:15AM -0600, Jens Axboe wrote:
>> At least on mine, the BIOS has an option that says something like "L3
>> cache as numa domain", which is on and why there's 32 nodes on that box.
>> It's pretty handy for testing since there's a crap ton of CPUs, as it
>> makes affinity handling easier.
> 
> Right, so two boxes I tested with this:
> 
> * 2 socket, a bit different microcode:
> 
> [   22.947525] smp: Brought up 32 nodes, 512 CPUs
> 
> * your CPU, one socket:
> 
> [   26.830137] smp: Brought up 16 nodes, 255 CPUs
> [   37.770789] microcode: Current revision: 0x0aa00215
> [   37.776231] microcode: Updated early from: 0x0aa00215
> 
> and both boot with my debugging patch just fine.
> 
> Hmm.

Funky... Not sure I'll have time to get a serial console on this
thing before next week. Like I mentioned before -rc1, maybe we
revert this change and I'll be happy to test patches as time
permits?

-- 
Jens Axboe


