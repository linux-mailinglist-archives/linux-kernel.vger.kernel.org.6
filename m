Return-Path: <linux-kernel+bounces-332964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F597C190
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669B9B22094
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457F1CB306;
	Wed, 18 Sep 2024 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbD8MhW+"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CC15853D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696094; cv=none; b=L5X/OegMLtvgmC/+0UUFUWNNKVwKFJYrmiFyblnTp10GQ3CnlAWRpiWR8hJcuLMCnSl3DCYEYRiu6GV0jy2i+8RCwUwpUgDB0YdOWltHn/75uJ3jhZEyM7pq1GYqrzzsrc0+BwZMWHkBw0F2P3RSnOxEsoJbnF9kuDBlcPDheto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696094; c=relaxed/simple;
	bh=K4ULRQGSX6v6Gt+d3hf0+R5LrIquVuMk6KwQTpR4jD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP/bTr8X2j5/dGzk4b7ipvYCgeNciXDjM/rQBN+pkvccUFaBNsHIdKH+boTl5SLKPLdoPN6qiLRYheoJ+usEBLzrxC7ZHBuQjvIF3ld2uNrrQ23/1MjymgDHKcitnFdVrSDsivQC5tZFN34Ndeii3QsnFv9TjRrdwztULSBCo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbD8MhW+; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so1583971fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726696091; x=1727300891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAYgv3oA/3JyPIun1hHuY9SsCmCAKJ8G9ItQHU0o4Y0=;
        b=JbD8MhW+dTRMaHr8r0n46jRAQvO3k4gW7ehr6PzWpL7F/7+EJCOS1CptDov2KN5KtX
         uZoV6YWzDamm/7QYTJAFebbMGHuIXPxmZt6Y5hx/FJAGFAwl5rFIFk/S1x56lL7BTpBu
         aa3K2izybwtYShDIKf/SB1i9jNSyYKnfBXEQiVXl17QJEjoE+P/D7kTWmi56wSXjKVDp
         c5ZbqkPMaWhAOXqfnqTGSBmQ8Ts7uD+QOOLhjq75+MMvS4Q6FOF6zYSiJIwAtDu12sp3
         f/eEuSwB3deWMEvB4AYU5D9Yq46aJpTPPr4fSmkqIEqMNNycS0LH4TPOF+5BYbE0++tu
         7gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726696091; x=1727300891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAYgv3oA/3JyPIun1hHuY9SsCmCAKJ8G9ItQHU0o4Y0=;
        b=KDym/hIawagaYgu1rq3zglIZXUUAHeLnrR6cIwCvz9Ue/WoH6Mht2WPPiHxcXw5PE2
         rEiKYpcJY7FgvI0pZShiMWuzuRUtHBlM/8vOgEUFUhAK6CD2Ax3DIvXaXHJkg8tDNVvi
         hOzVu1HhqOIcf1TsU89+FwoBfjjvMckYopgu1hHfxszK1ywF1598/mQ7/4lXFGIxJmWS
         9valtyX3cyi70DgNvh5FDjN+aDxT8XVluAikK18USmwySALv/73AUW5xwv91QbrnbvEY
         CYFOBR8LFHZOnEp8NRqY4JJqMBa8wLFOqhM51zujXPFsfW3GTOliftTwd85qHlIC0Ccg
         rtNw==
X-Forwarded-Encrypted: i=1; AJvYcCVbGJYFJW7UqEI8dACdd3UCdezf04qBIsBQN8aSntG9Ib2YVRri5HQC5yeTIgp+lScSfFwIUsEGToNKgh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzif4vJuXa9O9hH3wm32tK/EPRh/U2nblqDLzgZ6SCTzCTe5Gxh
	1AskaM9jWwudOTxv88YrtPzQLFbo3JT1ZOHCQa0lJAxSd1941nVB
X-Google-Smtp-Source: AGHT+IEcuLK5e8qPSjy2l4MZm4O4MJCxgaQ1oucKpx3mQ1dxWFPqhJIyy7c0Z88HNW1x4o/Cwv9a2w==
X-Received: by 2002:a05:651c:2c9:b0:2f3:a06a:4c5 with SMTP id 38308e7fff4ca-2f787f2fc40mr95364171fa.29.1726696090845;
        Wed, 18 Sep 2024 14:48:10 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37f66dsm14564851fa.81.2024.09.18.14.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 14:48:10 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <17b2ed36-3075-4888-8057-0a471e5df209@gmail.com>
Date: Wed, 18 Sep 2024 21:48:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Content-Language: en-US
To: John <therealgraysky@proton.me>
Cc: Borislav Petkov <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
 <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local>
 <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com>
 <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me>
 <96f609c7-f185-49c8-a9d5-a26bfd093b09@gmail.com>
 <KcA5fQwm2CimaycjqPqz-HP7y7Dyx3MbSNUc2F6eYqN5T48hLrFAUwiajYvOaat8Apn-dZvzQ2RAp2Ln-9BE2s1uYn7LwFdTX7NLqbBkC5k=@proton.me>
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <KcA5fQwm2CimaycjqPqz-HP7y7Dyx3MbSNUc2F6eYqN5T48hLrFAUwiajYvOaat8Apn-dZvzQ2RAp2Ln-9BE2s1uYn7LwFdTX7NLqbBkC5k=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 21:14, John wrote:
> I am not sure.  Are some of the other things -march=-x86-64-v3 driving them?

Looking up a full table, v3 adds more than just AVX.

x86-64-v2:
CMPXCHG16B
LAHF-SAHF
POPCNT
SSE3
SSE4_1
SSE4_2
SSSE3

x86-64-v3:
AVX
AVX2
BMI1
BMI2
F16C
FMA
LZCNT
MOVBE
OSXSAVE

x86-64-v4:
AVX512F
AVX512BW
AVX512CD
AVX512DQ
AVX512VL

Maybe some other enabled instructions could issue some benefit.

v4 seems to be useless for us though.

> As to the code you referenced re: disabling the SIMD extensions.  Do you know why that is in place?

Not really. There is a link above pointing to a bug report discussing GCC quirks. I am not an expert in that.

One day, out of curiosity, I tried to override it and build the kernel with '-mavx' (free performance, yay!).
Well, it didn't even start and crashed immediately.

I don't know if something has changed since then, but I guess there are reasons.


