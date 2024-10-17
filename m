Return-Path: <linux-kernel+bounces-369074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1139A18AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F09B22AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4F101F2;
	Thu, 17 Oct 2024 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aYmQyjv+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B899433DF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132454; cv=none; b=VmJJ9rH11cV/26+Av/TtvZsVQpdnaPbFFI1eCDD2ymuIVC8XAittmb+Q1uFnv4zIv1w/ScMZD1FhXL1sL72/X6t8NKuvR08wYGxgYNLS1rYNUG6VpPcA3kvn8Zxe7pr4adsdgXuoQuZ7YrsSeR/YUkZ4oQ4kCxzbgmLtFAIp6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132454; c=relaxed/simple;
	bh=GJhaVtiZLy15AyD3VfoJlUPHEaJahKRPUFuJ0X1aEWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sX7FgaI5siIOaL1HPM9VuXPw96Iy1CZfJdGbVhG+Vc3s92IP27DSj4uzl4g5SqvkO9w2fLiXh4RwaU7I9HT6TJTXcyo3JzsSbNtSFqdAtZfloQD9NeqMpPr09H4+E6+p+dvmQfwQMK3gJlPwwXtFOqe9vHmDuywYQ41EOdiWKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aYmQyjv+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5130832aso300406b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729132452; x=1729737252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzEWcgkyEN2xCGQzQYd58oYQmuoVm6jkLMq2U4NyvJQ=;
        b=aYmQyjv+J5WFyCQXX57mU/D6svwa4Cb7+LUkxfBbTSjrU7jFis4tc2ajNqB+jo5gLm
         SRakguYU/sOjO/PgIRQGoBksXuS6WJn37wXihvqBWAJagUG6YzzLzRQ64u5s1C+UpN12
         HcY1Lt69QRMC78o87DoBNUHyToey5+3W86UuSv4j48jZ6NK8khi04CGdEMzxv2rZUFQa
         00p/9OQIhIJFYVQrr2EdUUyBGeyGmLmU3Kta1PB27+cprVrdJextz6uZvpjaRmvlIhL3
         hOAx13jmK7Vocuy8j47lO8/lid7QN+ltep/TXFmZlJYFfK++ENPs7EFsITqt587ky70G
         EoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132452; x=1729737252;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzEWcgkyEN2xCGQzQYd58oYQmuoVm6jkLMq2U4NyvJQ=;
        b=fkfeABaclXfiUpqZQLU5X0PtoZ90l4l8Pknyp4KdwBlRDeVllh661uMxVOY/U46DXK
         7133iC6tjUQRsORVSRFS6hBkeyachZTY3C9YB/OZw2JimDUnd1V71AgdXwz4bFGA8mFa
         PuWMXqc4tdA1P3qE9D9pGff90zV9aSpIMXt3nZeLT3ytIndPYrbAIoQoKCugIGpnOj2Z
         UYNflsbxPCerHk3cxw4cOn6GE25Dl2kAcYiHAfFHTzrsIfWma3eaBj7m9eb4AIEgBtqV
         6mVcU/Y8sBg92fEPv9Q1qlIE+bYAaImtl1xBl8U3ZZD1UReLitQABmnKLwXflxcl1VYK
         Mk7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSw7girIuyki1UgPZFfuakCpk4A+gas/LR7Bu9W18TNPku1kMVCjaUKSXg9ZQvfOCqQEWb+3F8HM9+aWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZ8ZlAZ/rB8sg9MPvVqdu2Apu0x43YjXJg6i0ofjeI4hUYWYS
	dZnGQxyzVkCrSMq7XvEq0DJPjkny9PXPvRsedPb0+uNKKUcbBSEK0Exy1joZP5Q=
X-Google-Smtp-Source: AGHT+IEPlYb+DxeCpUtrmzvV4jpB/7wPYMRwmw1C+8y9sir94HhOaj5Up0Hc08t4bY8iVVhiJFRp+w==
X-Received: by 2002:a05:6a00:2e11:b0:71e:6ed:9108 with SMTP id d2e1a72fcca58-71e4c13db67mr26050685b3a.2.1729132451589;
        Wed, 16 Oct 2024 19:34:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774cbcf1sm3750124b3a.157.2024.10.16.19.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 19:34:10 -0700 (PDT)
Message-ID: <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
Date: Wed, 16 Oct 2024 20:34:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
From: Jens Axboe <axboe@kernel.dk>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
Content-Language: en-US
In-Reply-To: <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 7:50 AM, Jens Axboe wrote:
> On 10/10/24 7:46 AM, Borislav Petkov wrote:
>> On Wed, Oct 09, 2024 at 05:04:23AM -0600, Jens Axboe wrote:
>>> Yep, 0xaa00215
>>
>> Found something: I'm not handling the stepping properly, below is a big diff
>> along with debug printks. Can you pls run it and send me dmesg. I'm assuming
>> the box will boot with it.
> 
> Sure will give it a spin. The box is tied up with testing for now, but
> I should be able to run this later today and send you the output.

And then I totally forgot... Got it done now, but it still just hangs
after loading the kernel. No output.

-- 
Jens Axboe

