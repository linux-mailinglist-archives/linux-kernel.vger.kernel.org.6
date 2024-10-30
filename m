Return-Path: <linux-kernel+bounces-388080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6F9B5A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7711C20918
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71235198A24;
	Wed, 30 Oct 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S38ja08N"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7342C9D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258219; cv=none; b=TtVsXDS6CAiy4CQWjMDAzGBuOGPRr8f+8SXrbmZkR4LkkQSyEXF+ZEW12O7tmeNbgkq+SaHYgK2EDZ/GGClWfjOPjHDJls92WvI6quyqumJLeHC2aBULUsVTvGK5f9XxOxI5OvfzmKNtX7NMYTRDqaiuz/S5x6L4HDJ0/JErK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258219; c=relaxed/simple;
	bh=PBsAKVJ6B9+yamO/DhmcmMqn2Z2bULm0iLY0gTnNrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwxOqDS5Q/meGWRS7C/1/OACDsiTyF+HBhPR6P4Lu/80KVn3eKguSWPlIpdQHl7rGNOPrZ3Xbk+xX02xZG2LOU8WtL3+t+enVORHEgs2Umqpsr6U+xX4xmuWqXiftJTFRWNKVDkN0PR4KJ/Ju4K6F82V2P6lNgXpxw91tsojye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S38ja08N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so4775860a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730258217; x=1730863017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOkAHQrRWR68mUWgK22Q1GiCQ9kh+zI0wkYMgC8eCUQ=;
        b=S38ja08N+0W/g3FoJW9jruC/5aanjJGvzxnGYCQj4RXMlBTbh3U7pXxh70uGdhS8vQ
         oh9670eo3QNcOZR4QH3i6MSCp2I81QsJBXTSjeCoGjb+54d9hzRlEnT4mSt4CmKNQi0T
         wMO0sWvJkvm3mN5MlSKRdVr0vMu2vyzlBeECom5oO8HPSCtYcFdroye2DCK9eKkX0Yrv
         k4HujrcUdh5PNS8NViE3x2N6fFdWXTd4z0Zk6SBHcB6qip3yqcLZdCVRdN8u4u6rljTw
         QuKIx/Ki7wTBCvHPuPoKfetNHb063rKpqGjnqTHSIh4jJe0qhMd1wmzial4MuGL4vdvM
         qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258217; x=1730863017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOkAHQrRWR68mUWgK22Q1GiCQ9kh+zI0wkYMgC8eCUQ=;
        b=wc/Ir9nD6nhMi219ulXf3DhsOD92iuoeCZkc7SI5cZHnch4l6mPthQC+rNAlYm1E83
         9hMB+Jc7+kAQOCO8JpoA6wiHubXlD8Su9ggK4M5zjFiJhCMzlfiFtHQx4F2iVaZxM7VN
         Us08EOU4TmTL7/xLcfv4cHCtgYJ0n7jRZIB+PRLK3epLhbfqhWxKdcGcvi0j94Oj3G1g
         qoFjjT9ZHDgNBPqL8GRVqB8XIb1I+2scpsnPke6WcZFuefSvNq5z9BnxIPmkcU18Jj1b
         6Hj5skD7wxyJX4gSsv3+hUNPUYhkxjAsC7fVjZEQ/3QCZi5ykRF9txM4dxpp94iSXC0h
         odQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXJSXLZM8SOWIF/Hp3v3cuX4TSYSbIlyXZYTdlILaIcdoxbfagaFdo+6WuqnT/eE2SsHmXWs4hEC7hvaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGGxPtVb5y98a4t8zbAZ4CmZUzt/D1R+uLlDp/llmYvXtPi7j
	RHQeInAypHXLWlW6rRODjdDm5+X/FC/sfZzFF0WjntTZ3U30FjYHPiacpCWMMTI=
X-Google-Smtp-Source: AGHT+IHCWZPqicu+zBEO5ISCpJXDjDagWTSuQ1d4uht5fImHKQzKKPSKGEOWL+8DYHlMq7FTvt4Kxg==
X-Received: by 2002:a17:90b:50e:b0:2e2:e6bf:cd64 with SMTP id 98e67ed59e1d1-2e8f104a4d1mr15472363a91.5.1730258217352;
        Tue, 29 Oct 2024 20:16:57 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013378sm72539135ad.171.2024.10.29.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:16:56 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:46:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Markus Mayer <mmayer@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial
 command check"
Message-ID: <20241030031654.yfksespjetnirecb@vireshk-i7>
References: <20241029152227.3037833-1-colin.i.king@gmail.com>
 <51b6692c-4e71-4f4e-ac73-fc87b9f2ac5b@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b6692c-4e71-4f4e-ac73-fc87b9f2ac5b@broadcom.com>

On 29-10-24, 10:06, Florian Fainelli wrote:
> On 10/29/24 08:22, Colin Ian King wrote:
> > Currently the condition ((rc != -ENOTSUPP) || (rc != -EINVAL)) is always
> > true because rc cannot be equal to two different values at the same time,
> > so it must be not equal to at least one of them. Fix the original commit
> > that introduced the issue.
> > 
> > This reverts commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied. Thanks.

-- 
viresh

