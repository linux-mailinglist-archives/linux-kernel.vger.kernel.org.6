Return-Path: <linux-kernel+bounces-332432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A897B99C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5857283B93
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F8176FB8;
	Wed, 18 Sep 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAlI9tBw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6915DF6C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649478; cv=none; b=dVcSuyydMMzlHTtjxVMDCyL4vqGOjnYPhV1FAvSKlaAC4SPjmj8LQo0RpVJa6Mwg/gTcAonPOb08Ieo9c4lsjG0iWljg3oWfaZH65Fh5Y9bchwmgFijYxnOUC1ib52Md9M/RAoUBqnqZiT0E4jOE7aH2vn+hbaF85mvn5APdMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649478; c=relaxed/simple;
	bh=fCiYBvzE8HQpHO/D+2/jXclwsCH220wP8H7X/oq8J5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qk8JsGy8hwR6kia91Fr8VScd3KoI6aaCz9FBW9yHXEhqkjX9Ayct8BUzWpkLe5BDp4TodguvWaqqoIlhM46Iqdn2GoSBdtDx4Ms6ESE1ElvoVBZ7RlkTuEjNr0BXwFdg6JMMn1gbmuUGay1QroqntHJMj7q0/PpZgkpSHiM0EMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAlI9tBw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso4708248b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726649476; x=1727254276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJM6qWCGzJ+8E5E0h9/NelRod42l9eGsT9yRLTI9wTM=;
        b=QAlI9tBwja+9bz/6QMvAMbPu9HYXVo4JKew08D9o/d9nxbhJj4ZItgwfd8gdP0NmUr
         h2vfTNidmFshc8X3baA3VbxiOi9nXRWaNw0OPsKawuC0qzdLSIX2eFO7eAHg4TNIYB5S
         kWNhY6g0yR4PXzTfD6m5tO4Zopss38Z8nlai//HXg0X6w7pNAZUVBdyjybmcwVSfRKGT
         prgP6yoI3WgMb7KpmPwSjd45aEBa26BUvrh8lA/gB61zfDOTBJ8WrivHnmvXVLiWLyYa
         TyqFPqY/NHU+5OHcNQr2PwVezNpQAnUBj2FBghD/q/0qlQ4xwks1kOtLA5d2LuPcoeTc
         v2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726649476; x=1727254276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJM6qWCGzJ+8E5E0h9/NelRod42l9eGsT9yRLTI9wTM=;
        b=YRr5SrgeH8JkGQcrTSIDBYk5MwGYmPh7T7zYGXaOerfb80rW9mdYq1n93JmIovYuxj
         sTuNS2Qe3K7ay0vwt+6/Zgibw1HcvaDh38sASte1/3ePPrFNUWD0+xrOfHieyrbWjwij
         Q8AcaV/XpCRIKQ5qMcv307RfkOJ6ub+kSr73SjPWxP1cRDl12aYR9AcajEOBTvv0AU31
         ymjFCObkGEWY/M9S67sy4xwLpcjxjOReQXGd58nedrto3NueSqqm/NcsQzbQhajI7ilG
         2rYSb5Axf+B5TBiey21DNwOEm9gPLbu+uEZrb4U1C49e5jq51hKzeebXH6Hg5ncVrg5U
         AfSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPU+uJ/A9/Y9cxxy6TJQ0N14V1J7Nzs3xnwbmd3jRrCbqW9ShPV6QaYbu4kUNDTGResc4tdWM+jNLmH/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6kvO3oYdgMTYgrqG4oseZVXGdGuWsvFRr1HNPaYOXlKt4Rvp
	kcaBPLktKMmA5VlBeiLG0wF1rdwQKRDbrDN1Ca4DVHiLxOX4cjs7
X-Google-Smtp-Source: AGHT+IGZUwUXf9V2CaxVUb3TUe0VYOvXM4rrlwDHaJzgdEa8dYaZIeqRvGtaAvprxCTU6NiPxPk1uQ==
X-Received: by 2002:a05:6a00:1783:b0:718:a3c1:60f6 with SMTP id d2e1a72fcca58-719261ecd95mr30604688b3a.18.1726649475771;
        Wed, 18 Sep 2024 01:51:15 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab535csm6291420b3a.58.2024.09.18.01.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 01:51:15 -0700 (PDT)
Message-ID: <ee2345b9-ca4a-4103-bc03-9ee759209341@gmail.com>
Date: Wed, 18 Sep 2024 14:21:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mm: Fix kernel memory mapping for xip kernels
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harith.g@alifsemi.com,
 akpm@linux-foundation.org, rppt@kernel.org, rmk+kernel@armlinux.org.uk,
 m.szyprowski@samsung.com, vishal.moola@gmail.com, david@redhat.com,
 willy@infradead.org, nico@fluxnic.net, ardb@kernel.org
References: <20240731113905.3326586-1-mail2hgg@gmail.com>
 <CACRpkdZBWDf2t=xY83JePUR34K4qS1QnVivLELp6W779rLZf=g@mail.gmail.com>
Content-Language: en-GB
From: Harith George <mail2hgg@gmail.com>
In-Reply-To: <CACRpkdZBWDf2t=xY83JePUR34K4qS1QnVivLELp6W779rLZf=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

>>
>> Fixes: a91da5457085 ("ARM: 9089/1: Define kernel physical section start and end")
>> Signed-off-by: Harith George <harith.g@alifsemi.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> (also for patch 2/2)
Thanks a lot for the review. I somehow missed this mail and saw it only 
today. I have uploaded to Russell's patch tracker today.

Warm Regards,
Harith

> 
> Sorry for breaking XIP :(
> 
> Can you put these patches into Russell's patch tracker so he
> can track it?
> https://www.armlinux.org.uk/developer/patches/
> 
> Yours,
> Linus Walleij


