Return-Path: <linux-kernel+bounces-445255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648649F1364
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D54284311
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E218D625;
	Fri, 13 Dec 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VvQgecTO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F17C21E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110051; cv=none; b=NA9YmCx5gw4QEnDBJSBUfxyWTrCTfj52D4OC6UDUUTPFwpzMCOxBXJK4ROWwotbWpJ50BLQOWX7fTz0HHLgYJZbVGLjMFay3lrjp2AjzhMh8lL1aiTsakA7nAvOHca2HfV4xkxL/h7UnnpkBRLDB2vpo6cCaCroq9Ga2osQCCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110051; c=relaxed/simple;
	bh=dkl1vjExkNHN467ZbYwI3PMG9/qjOxFzGlNy8WgFn7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCTp1CUk89ksYptPCKYmtsLIgqedj6eMZ0IsfIJo7R32MyCPouqROdZv+f7vW+iNiIeJWFpp3lo4FgGz+cyjy088eB4xjNVuPEcEByglCwp93hNA5jqmFgJn/XNhLUdRDNHMSm8GdJ7gr0YWD1Nhqw+owxTYrNVVTZ+CneTcTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VvQgecTO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1699291a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734110048; x=1734714848; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQS6Z9FyQjNjUvUa06jVeIec5yS1GziJ5Jhlo/w/K+Q=;
        b=VvQgecTOIHd6iyVFTb4/dACsvdQjoBYn3dhzY1aqiq3GZO54SZM1Q7hpfF5A+R5cgy
         RBHGxooVhhx4gipxDKDZMSvGnm//I+8DfiOtsc1OCx5XKVdB6mTEE1tJiljb5U0Zyr+7
         SZgF7uXHjU/EmSbBkh3lw31bozJyFS64eXOTdwz+h2ac25ONNIvStACX/5Tb8DqcyQu2
         MwK5IhbsJiWchOfsro78LQEG1emf0Z8In52ysQzUWT9J+wm5e5c7PIuFfDD93SIeOgVk
         s/0L8f6QbXCNx0dWZfO9WCENVVi/b8ifdvTxcS/067eeyZsN2Vr/IvxLBfbyT1yK5PNr
         7w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110048; x=1734714848;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQS6Z9FyQjNjUvUa06jVeIec5yS1GziJ5Jhlo/w/K+Q=;
        b=TfvGYvqL7bdo8dXOk4Ms5drCJnDZfo02xpNlXd+sQZDuSTnGtxKRUy2vfTSW1jtRpa
         B5x1DgcaFqS0Z7wIagVT5cpDjkvGYH+XQjfG+X8dqpIqw8ed/GWsWu2JdYiwCX5yYlHC
         XrzdWTjxgEQPHhsAa7Nd6lZ27bSEx6A7bvKMW4vAQO/6m7KLmS802FOmZsTmwH24ci24
         lOjJvopGIMtokv/2P6zlqAMmm7pEeOXTBTGPMGKwcqDPn7pClyePq8BRTxMyPuA9OOcI
         z6kIB4XQe0vXexa1sx2DbN1NLMK0hTWGTq7KXNvR3iCKyuP+lTqRyGQxiFRWFub1V7ll
         fLcw==
X-Forwarded-Encrypted: i=1; AJvYcCXDRBFT/g5UxPqpG5k0gbwUo5sxl223oBHKAb1p0KIGJtN8i1YXXmoDb1M2r8osHund1M3PIKYwTMCB9+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/HUVuIn88IlIj3CfvptpZimEydolJOods6ltEDVAQ/Xij7FX9
	0N8sG9mVSY4gTQbXULwxKfmXQFYhFbdo6W1DFBMSGcRcFmIYlfD4hcp82JyKs6U=
X-Gm-Gg: ASbGncvLh/DarEdJG64HrQtrPxmM/hGEdCagDQjZSqJEvFNdggtGw2QaYwcMkkG71Xn
	D90oP0LT8346o4uLXdHePyzQlccSWmTgTOkrvv+eWMiCiqxnXOTvifYNNd9f3d1KEVd99T1bp7f
	ZZdnc6i7GxoqKCmSSXQxaIiKrcaTe+Ec5GSQh0A+L422xSD0f8VI/FiQL1jvBB4UQ19HIrYKVdd
	lzNA/z/1Uf68B36tpcuFpp/BgiM8k/yZTwd67ThEUcyGfssEGBQX+M=
X-Google-Smtp-Source: AGHT+IHbDl/lD0XexKp/6ybZ9FGVzKKw50y42Xo2NTcgNMjdYLLe2IjXMvJ7b8PmucE3bj8DHntnnA==
X-Received: by 2002:a17:90b:5284:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f28fa54f36mr4916566a91.6.1734110048442;
        Fri, 13 Dec 2024 09:14:08 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a24349edsm11077a91.41.2024.12.13.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:14:08 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, rogerq@kernel.org,
 tony@atomide.com, linux@treblig.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: omap-gpmc: deadcode a pair of functions
In-Reply-To: <76a403e0-f801-4d68-830c-370e0291efe1@kernel.org>
References: <20241211214227.107980-1-linux@treblig.org>
 <173410830317.3067997.3764368773601763146.b4-ty@baylibre.com>
 <76a403e0-f801-4d68-830c-370e0291efe1@kernel.org>
Date: Fri, 13 Dec 2024 09:14:07 -0800
Message-ID: <7hikrncxpc.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 13/12/2024 17:45, Kevin Hilman wrote:
>> 
>> On Wed, 11 Dec 2024 21:42:27 +0000, linux@treblig.org wrote:
>>> gpmc_get_client_irq() last use was removed by
>>> commit ac28e47ccc3f ("ARM: OMAP2+: Remove legacy gpmc-nand.c")
>>>
>>> gpmc_ticks_to_ns() last use was removed by
>>> commit 2514830b8b8c ("ARM: OMAP2+: Remove gpmc-onenand")
>>>
>>> Remove them.
>>>
>>> [...]
>> 
>> Applied, thanks!
>> 
>> [1/1] memory: omap-gpmc: deadcode a pair of functions
>>       commit: 56d96fc5539003a95b8ab631a4ebb5d1b0a24885
>
> This should not go via soc tree, it's memory.
>

Indeed, thanks for catching.  That's what I get for trying to
review/apply patches first thing in the moring.

I dropped it from my tree, sorry for the noise.

What should've said was simply

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin

