Return-Path: <linux-kernel+bounces-422964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373FE9DA087
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF542851BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17161BC20;
	Wed, 27 Nov 2024 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="royk/s+X"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A3D2FB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673100; cv=none; b=WaR9s947PKC04nJbh/doIcBN+AVJfbT7Ft5LqAAYwKhKfzU/amivL+DyYLzruYQm51eWdTxT8DBU13Nh4i44dSSXwjCj65K2/C31omJZp8Cd1VN8tIzuIui0uUPMNnocGbQgQvyp8xSKXJFdJY7/xfg405kwDgpK7J9x0s1fdw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673100; c=relaxed/simple;
	bh=pz0PoGBG2TGLIXRoEcAfk0ZkUBn2JaHe2n9085ZKIsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xln8MVazqDrhlx6mNvPGXPAIzfG8/yqJa5u1HTsb6MiAlbHFHO4wMVRyRxnN2biZmcyE7zy4ZPsbsc07zBsYASVsIeIxEU2j3EhFBUuxNE9ucNGXDgZRGtZjxbMNCQKM5gijB9FAGq2nW/m3Nybg4QXgJudNj2SLBh+/9d9IBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=royk/s+X; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso253065a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732673097; x=1733277897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA2XgJnVXroms6cNVBPKOD3KfOJvAZhMOjIEuQSGkcw=;
        b=royk/s+XZhH770hfX6OuZBrBhqRe8HDU1acVmZpqOlE8zfGP/GJkIVYnWG3Oe3CZmU
         QH582yTbJa3TETrOplh6RROErEBaBDAl2kZJtbBOSGw5/69VPu8/7mLrIp4P3MYBHKe5
         KwBvER16MGaFjZ/xi5WbAOYGVJgJbDlYfA9U2LyyoUGFam0JdmUxGoSmb8Zgw/tE6hyG
         jCDU7DNakDheZbRkx7bg3/osMNIyf5CUP/XwZ+VNwHkwl6egDlcrCN+MaYj/n3mbPkHM
         871hLoZqTqzAnQRw17wbs7WAbuYllKQyEDEUm7ICAX0n9kgr00KSuZWFAW9D/88kgnEF
         5zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732673097; x=1733277897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA2XgJnVXroms6cNVBPKOD3KfOJvAZhMOjIEuQSGkcw=;
        b=rT2IBu9MscHppAajQsrGMC6CG3CPb6g5pBvBMXS0s1G44is3RVTvKbQkFrDZQXV5NQ
         Mllg0AE1cyzMOC/u12sNziwfhKq/M7udnrUdO94uTj4vYVLiF8/V32VyedyRdozjuDVO
         S3isMeffBWaJ4HJ0jiWpo4zQb/zCD0uhfPU21wpX21eS+wxPmuTyVGkSB/xgZ6r5TBHN
         CYDgDOoyxmNBV/6k3R6AL737QPccQUQKVP+0WQLapWcoVRkxWrYTunZeVmkyuQ6utfpg
         7yrTs15myMpbZw8nYKbCV55t8Icedf1w1nZ7GQyRiaGJ7C8VNon7IS1gtXDq4mExCmpp
         doBw==
X-Forwarded-Encrypted: i=1; AJvYcCVXgZFEgrAet/X95fdyiCbKmleMKcjuYysBwIgFv22GXMgWdx4VrFbU/DCIKMUilQpTeJDcKvXeKilqELE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzI9rWfXnz2J1uVX/HDEXfL3t9J0bGX2aiKlURmdg2oIEZDhq
	fs+0bAGL/zh6wxvmCwcSOQQ9wK+CdO3xiQFnNAbKRC/dSksV85GkVYoRnX7JUzf7NbjBPRc+Gp1
	xA38=
X-Gm-Gg: ASbGncvIp4ETnZGVVQWPD4MqP1gkU1qUh1kENsHG6U5c2Gvp3IGnFUBmubNfnMSekpd
	t0qAkmOCg42vOqDThCoKvEmNX4p1Zt2OWjOOh95xuknUw7OSEn7v68DgTdOQlrglvNt/WQBjUT8
	4tgqOvSOohkzcrMTLrHitf2A37yZDs75nQUNeZNAc1f272oLuky8YUIIzbXLCLNZsbWggSMlX/u
	zydURimg7Uw/1LbHdXrddkvQmssZTDloYJDhRlO7Mlj3nU=
X-Google-Smtp-Source: AGHT+IEGSLqkMoJQGCv7cJWbao7CN0MoMuj6jSO+T2QaJBisPZrRmSvgzRxmvtyW+14IYQvOddsosQ==
X-Received: by 2002:a17:90b:1d03:b0:2ea:4633:1a65 with SMTP id 98e67ed59e1d1-2ee097f5596mr2348297a91.12.1732673097294;
        Tue, 26 Nov 2024 18:04:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa47f90sm261661a91.14.2024.11.26.18.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 18:04:56 -0800 (PST)
Message-ID: <09429155-d611-4c95-9465-f0cc3fbcdf29@kernel.dk>
Date: Tue, 26 Nov 2024 19:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cred: fold get_new_cred_many() into get_cred_many()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20241126-zaunpfahl-wovon-c3979b990a63@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241126-zaunpfahl-wovon-c3979b990a63@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 6:22 AM, Christian Brauner wrote:
> There's no need for this to be a separate helper.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


