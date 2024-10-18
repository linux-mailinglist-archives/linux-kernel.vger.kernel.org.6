Return-Path: <linux-kernel+bounces-370773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D59A31DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C2B28442C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828EF3BB48;
	Fri, 18 Oct 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hh+34WXC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FA383B1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213856; cv=none; b=VjpK2Rzad75RUYuOC8P0M4X1XAGqtU/uD3fW8VPe8rBktuepGVyf7ho0D/1tHnsjMyOtM1A0snO2mxgQ0ArzmDBiz2v2WI/jvwt2hxwXek6YUgeRXrvbPg/hx/ejO3g3fCbMqvkwJVRtHjYbhnE8Srk6lu9vj82duXPWm8Y27JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213856; c=relaxed/simple;
	bh=1VIrtSxgY8rKreHAQV2DoUBJMcEEE1zFuleBgdCTLbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYJ7vpm+WsY38o9tFcR2Fo4h3nkfpRPfTKIiXsj0hCIDkP9kc2Y+E1ewMhjq7+UkAWkvp56qRYckdqst62a3+IiiC9iOzVaiJmVtl/mEr1L68edf9Zs9QFrwJTE88rEljQc9RFPjKIB1nwkvgS9XYu5ikSnbx3pihpApA740kaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hh+34WXC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c803787abso12429675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729213852; x=1729818652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4ueAE+R2BbaBKwX82wegCAV+sg2ok5k+jGwKThPv9c=;
        b=hh+34WXCqGxhbb9VTS4SjkMe1WL8siVPUKYhkyqXTAKMkke/AXieyUE1T8vhb5Xbmu
         e3CBBT3cPzdPdMjePG7pS1lXOH2Mvl0HQcl7v3B5JSRgIusfGZAZwqpQVqKnCXvpwGtv
         xjEB6Nro9WrW63aqvKFws/S0hIoR3xbSac8gq+h9ZHqNwTQSyz8Hi70yTP5j8wPiJKaK
         bBMxl4rdl9wlOezT92tsc8eYI2fKpWxilE16hBUw01FM31rwN2YTuDrr/G/Ex/KvaEFk
         0jCteGYYWZ6jabu3JkwpSWJjpjZKXHKRqPukXV2ZEZWgEY0RNMDCOSItlysweZFU52JS
         7mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213852; x=1729818652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ueAE+R2BbaBKwX82wegCAV+sg2ok5k+jGwKThPv9c=;
        b=ONAhwwg907HuSMV8yCtiCarxFj4/22zxf0EnREth/N/FdgPmFhSQAYF1mDfOqqQgW+
         kPetmn23qkNCNDWDJ/3FidsxYHg3Q2g0qYeZ0u32h5+RkxAaUSgJXAVT+yWnIhEn4rxt
         ZcHAJM4UcwyctCoTA28VdZmDGa3sgC6CMuA4iGDs9aZ4E0u8GavcrUDKncaFVAXu5eZx
         HoA7yxpAOf9nKAYVy4a0+tktSphu9WWvUjp4R9/E3+Cxg2jP9p1Sc8kmI9Gt83zL0Lwh
         pD/alQXGZVHkqVMTEGsoQ/NQqPoOey1jCRERKAKgcJ1csc3pVzaHr6I6TodopCHqytqc
         wTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKYcp1Iq58tjEtTi29NdF0s3tywtyKV7pmv6I8X44QGD4ZoACXBplCb1I30CzZGEjYxs2h9gityMYdme8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEooDVyyjozNtWBrUUlfSNU2wWb37h+SM1yrAU0X4AEmkHN50
	1mvG2TiSbNonHwLiWxiaDX+/O+TnBhesjqXmKjVSLwxbMw6f8TzWjitFf3JEewQ95y7zKpFhCa4
	s
X-Google-Smtp-Source: AGHT+IE5qzSuNWyYI3ZWF/RFxQ9ENwphZ4xm0wBJtOo5f6VDr8UUs77H1QMFtImQynZnCEcbjEZowg==
X-Received: by 2002:a17:902:cf11:b0:20c:ceaf:e65f with SMTP id d9443c01a7336-20e5c2b5866mr9549255ad.25.1729213851871;
        Thu, 17 Oct 2024 18:10:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f15ecsm2408795ad.204.2024.10.17.18.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 18:10:50 -0700 (PDT)
Message-ID: <3a4cdc4f-63e9-48b1-80b0-54c5d1eb3e7f@kernel.dk>
Date: Thu, 17 Oct 2024 19:10:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdrom: Avoid barrier_nospec() in
 cdrom_ioctl_media_changed()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Phillip Potter <phil@philpotter.co.uk>, linux-kernel@vger.kernel.org,
 Jordy Zomer <jordyzomer@google.com>
References: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
 <dd1712dd-1485-417a-81cc-482d7dd26a11@kernel.dk>
 <20241018005233.styuaj7eyn7b6nux@treble>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018005233.styuaj7eyn7b6nux@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 6:52 PM, Josh Poimboeuf wrote:
> On Thu, Oct 17, 2024 at 06:33:24PM -0600, Jens Axboe wrote:
>> On 10/17/24 4:09 PM, Josh Poimboeuf wrote:
>>> The barrier_nospec() after the array bounds check is overkill and
>>> painfully slow for arches which implement it.
>>>
>>> Furthermore, most arches don't implement it, so they remain exposed to
>>> Spectre v1 (which can affect pretty much any CPU with branch
>>> prediction).
>>>
>>> Instead, clamp the user pointer to a valid range so it's guaranteed to
>>> be a valid array index even when the bounds check mispredicts.
>>
>> It's a cdrom, and media change detection to be more specific. I really
>> don't think anyone would care about performance here, it's not even
>> a hot path for a cdrom driver. That said, I don't disagree with
>> the change, just don't think it'll make one iota of difference
>> in the real world.
> 
> Fair, though it's also about hardening as barrier_nospec() is only
> implemented by x86 and powerpc (see 2nd paragraph).  Most/all arches are
> affected by Spectre v1.

Yep agree, if we don't have full arch coverage, then that's a better
reason for getting it included rather than performance reasons.

-- 
Jens Axboe


