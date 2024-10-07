Return-Path: <linux-kernel+bounces-354244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F67993AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212461C21313
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC018FDA6;
	Mon,  7 Oct 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+ck2M7z"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DD190463
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342004; cv=none; b=eHx2PQR3m3rT+CF/Ru01BuwVAehQrCnflcG4UpA5/rDegQDrylqRrunK3AkqlEXm2RNkArtNddegUgm6JCPaFDappyOjHUUpGJED9ZgdS4XwtYOKYwu4WobvsPa7+e4jFmIVDeMlzjlR/EK9nx73tzGlWIFUCjhnVVVrfR6Pq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342004; c=relaxed/simple;
	bh=UG8zgwVPm5ZQUfG7gzwGYWUpH/if/I96hwXbiwo//V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BE+Z+lk+vcGzjvdX1zBUNMMc5NF0U3tCrjZ27YH5FKpaEhP+2sPLAlAHnNq1bZ4TqmLAHih3RK6ZXbb9t6rPTkpKk7kehjNK0EqekQhW5Nq49HYT1D/UWjyRL3M+XTdlJ+71gFtiwrOhmYZHAWWDTJ4/khnMIKBJwgLRU+LjM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+ck2M7z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so6838037a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728342001; x=1728946801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0jtSlmSXHsWBxmxqlK9SrRmGWM4KsECrbb0iEg3wtw=;
        b=F+ck2M7z8Zfv7WmZlN8aLrRr0ktysKbhaP90otYnGil2Pc0hNdFThQRqdn5jfqD5WJ
         62ZvLuMNi32t4pqOhdFYmLuDJrCaBNjBiAvr4Iqq1ZQSYpMSt2+7f3AFBj4DLiepZnHj
         2I7Q6LhWl84lajvS5IEqVsJv82z1PF3kh0UAiuaCbF2fK27jnCJ9zd87uCX8tsB4rM8/
         wFnTmbF5mcInPNKX2j3aq6PvS5BmHfN33DuUTdcGbZHg2lau/dMEEkokvkD6vCyGV+FF
         WmYjNTzDor4x7r7QypGarniZ7vGP8gMYeUVqzv0fNYZR0NrOTSEJNW8H0WO6jHju++fr
         WRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728342001; x=1728946801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0jtSlmSXHsWBxmxqlK9SrRmGWM4KsECrbb0iEg3wtw=;
        b=kYL1p2cqTutqUz9ILnoTRYhTQgdeLmQqZ9OTaHk4lN0dELzblkeYbn5O3cGZnbSILd
         oyp94v6gXcl496qE/V7MGLma8uAfzFZu1jOWSrl4Pl/gr6MLG+Ee7PBpVrkB7av0bZfa
         Gkf87ZxacEflnOr8ILPT3GwxKxhpYNHpv2L/KtN8vgsvIL/YqzhppmTCzYDvCA57fpIq
         FG2eMq50kjkQ5bAPwpRS7a6HgUj94aVw7WZrM2D/q08yBCINACmXcBX33uq4k1rayiUO
         47PHbiqJIn36FU9WaOVFA1Hmm8STAcln8tYWUMlMnpeSJHy3k2/L2PnI5NAsBq8/L2Ur
         gAtA==
X-Gm-Message-State: AOJu0Yw+GX1AcubPoSw0eBCOzmlfxyU7Hn6SFGzjZdc85lahxjwPqEDT
	SRxMpy7l1arp74eCJvOQRDZje2NBh0Mp4uKT9c/q6rutt0fAdMYZBxMjph6nHaf2sFrg/CMXn30
	BgF7XdQ==
X-Google-Smtp-Source: AGHT+IHQs7Ff4viqlzq1Jn8DxcIA8iPZjx5fJUNKJa7PKx5jm0dOp0qt5CxrYlv1eLhf8r6DD7jA1g==
X-Received: by 2002:a17:907:e93:b0:a99:3ebf:9371 with SMTP id a640c23a62f3a-a993ebf94bcmr748013766b.59.1728342001355;
        Mon, 07 Oct 2024 16:00:01 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5d007esm427648766b.29.2024.10.07.15.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 16:00:00 -0700 (PDT)
Message-ID: <4f738b56-dccb-4d6a-87d4-d43c9fae3a54@linaro.org>
Date: Mon, 7 Oct 2024 23:59:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the slimbus tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241008075433.78fb524d@canb.auug.org.au>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241008075433.78fb524d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Stephen,

Pushed wrong branch, this is now fixed.

--srini

On 07/10/2024 21:54, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>    0eb9dda9d1db ("slimbus: messaging: use 'time_left' variable with wait_for_completion_timeout()")
>    7d317b95d033 ("slimbus: qcom-ctrl: use 'time_left' variable with wait_for_completion_timeout()")
>    9b6e704955fa ("slimbus: generate MODULE_ALIAS() from MODULE_DEVICE_TABLE()")
>    9f5fd5e2aebf ("slimbus: qcom-ngd-ctrl: use 'time_left' variable with wait_for_completion_timeout()")
> 

