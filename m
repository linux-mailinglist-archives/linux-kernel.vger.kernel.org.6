Return-Path: <linux-kernel+bounces-550605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBBA561E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7761418943C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1BD1A5B91;
	Fri,  7 Mar 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDSP2MZm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F35192B7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332962; cv=none; b=Bsr+XQDduafS+d2ROa7WwFG3UFfMV1UA2RjHCPvsfqC1kdZaoPelsCqlZXvLuHbu4hL0uPWU3lQlhEHrK6GXmC540KDpUv5EpLimSLnWbSnMY064lUYdyLG8xXYwEXXq56tcKpD6Q0XoDpZZ0TGf4mZFfmRwiDgqoLpOGjOSot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332962; c=relaxed/simple;
	bh=kS/wAfRICL8/Z1ZMuj8iqMdcWfGIpXLJLsnbid/srE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2GeHfilfUCC4yg7sfoHmDEQlOn97/5vvnxa4kNWzmTNSNL1CObhM5f/7RUc3pVv4y6WbBs3/notz/nZjCkg80f/Trp36PQp1ykQufnimirbZSqLcAKmZviGu+t01JdK/hxEJFj74mcIRsCUfvJVRcQxOwmpZvg42XcKPVLiDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDSP2MZm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2feb867849fso2476174a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741332960; x=1741937760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhlBNUmEkS2TvnlzidKmyqH88E53PRaLZAwbWIhiIM0=;
        b=IDSP2MZm/61dKg4Sl2nh51HyUI3RsJ+4KBa2mXo2CogXoTTDwbHVqd5nqgk0EFJu/W
         KItpBvxdtc2ze1s+wqQpZm4GZMoNDILx/5QNOle8U/JgYbyOL0mjhCXUkAExGj0OVB9V
         SvZ51uGy65zRFehFc5auiZ09GdO3rdsTCktAFftStRbbmYiBPSN223qHJmKKKEJU3tU0
         e0RPyhrhxI2G1J5GQ49dfHH4IMFxkLC9gI8/GlJCgiIpfXQs1ZP/WacEvoJiLqJl2Oe7
         gOu0wHRmqA+8hFYxaIO1gVP/0XGWYRaZSq48vkrZQFpJW7jOEV0mvJznElpM8PF9GGmz
         akPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332960; x=1741937760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhlBNUmEkS2TvnlzidKmyqH88E53PRaLZAwbWIhiIM0=;
        b=wl2izZZ5aT84Sjvm6X28STeyrX4Ck89roNtCiAtHRJRDkhGYPNA//VzQzXbQk2VMro
         q2W4yYYXai33Wd0+lkRmMyhH6F+VXVFOe+X1nH2/S3N9eTI1vkmcBvi5AVeEKvStdwTQ
         yle4DvImCGG+l6lScWg3Q40841kNQNpD/bl+v1dgGBAnJ064BzT3zWmve+S1KnckZC1C
         BzIQb0beEiyAEUOrfQRPmz16ZbvaU3+gkkseO4xMQgzqg8M9OJP2cG3nEOmOmaEXbzXq
         z38DBs2ysk4cC91gLaaQMDVe1slFDNiT3uSh1i83u2b83xaQq29hNz2yAjqlBuqhrwdB
         08Rw==
X-Gm-Message-State: AOJu0YzN84s2KuwzXl2KMaGTw3Af7ke59uNqPPrYa5Zyf4tHV0sjPVqC
	Ql8M3Aq1O4A+CTjg9M//TzCGujdDZ2MjnoX7KfRWVbOb91jc07TR5j3JCjjFyE8=
X-Gm-Gg: ASbGncsorybv3WkjlEngx+OlYNTccLGTn/FFI8+0GJydLeYMHtW9fZeOv5uMefeyps3
	2ySWzDUs013PUo2v2jsNXq1Co6zVJ9AteSOW3DsBrx7OrktsYgjw5LHSd8ICJ0aMvn7oNk3/s/J
	zi306nJS44Zjl/5Osq3OVj5xoknrNMKmMLkzuY5VwMN11gGpu7BJaPCZrOzsXopZGiBa1CKB9F0
	alO3QZh2A6moTZlimyTe15FFA/VvCkRX056Y+BbE2adifcbrSWvsT1B/NMb4M3K1os5eyx/aIKr
	5kzrq7OA2C3ckokjNVRGGe4h3MukIpa9asiTUZ45uy5qvg==
X-Google-Smtp-Source: AGHT+IGOdrCDjUOWOctY9ypzGe1WcTQ7a0Ncd/vIVHwKLYKY7sBgPHnDUOFGJi3BCT1sD2mGgZwdxQ==
X-Received: by 2002:a17:90b:38cd:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2ff7ce8e5dfmr4026503a91.11.1741332960217;
        Thu, 06 Mar 2025 23:36:00 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff94fsm4275750a91.36.2025.03.06.23.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:35:59 -0800 (PST)
Date: Fri, 7 Mar 2025 13:05:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
	vincent.guittot@linaro.org, yury.norov@gmail.com
Subject: Re: [PATCH 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250307073557.a2m7vq26n76phqix@vireshk-i7>
References: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
 <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com>

On 07-03-25, 00:38, Akira Yokosawa wrote:
> I think 1/2 would be better to be CC'ed linux-doc as well.
> Please do so in respin. 

Thanks for the feedback Akira. linux-doc is cc'd now for entire series.

-- 
viresh

