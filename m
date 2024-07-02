Return-Path: <linux-kernel+bounces-237254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF86C91EDEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685DE2859E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCE3D0D0;
	Tue,  2 Jul 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtDjdeYG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666D2D02E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895024; cv=none; b=CvBpAr8/vUjr8Bs+1/QHEf7LkbJ5JDIlO2KJktblRP7PXQLdhfKQG5Fhyk+g8u9GYzMT5b+u9GK/qj6Kgc0pnLAm4IP4Rk5TS7hTMtZhCIcEHnHplj5oXHxyyVPA5xKFAjK/X8yp/tMwWRyInFOeFgCX1XKEqzFp+oYtuySH2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895024; c=relaxed/simple;
	bh=COdofZI0yLe7Qei1B6Qkb1Szy1SP27VggR/s5mibXQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH56onhKUEN6h/KvmEHQnQuiDYJLvYRExc3Z2aEtVqSuAP5vK73YRDJ5AVE9ksUSUC1V07Rc84B4a6zy2r0zKh8vy7vlYuhgRZtFPSaoNSgZ1YJ7+McqLdp5EB6IuzGHu5Xi5assc089mznUpQ5JAmAZKjTdDvmtjkgzEkNza6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtDjdeYG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f64ecb1766so20080635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719895021; x=1720499821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wJUnGUJSkYxsQGi1RA4irnfeYuwiGT6Z1uOT3kzXFA=;
        b=GtDjdeYGK4BC0yJkyn3ns2mqWmG5FIqQFq7QJ09IvM441Zex4Zrtbo7cqrSP5liWev
         T3Kg8seqh6RwMarmSgWSE+gDjplF2ixQkzeIslLRiL52KTOBAiAofUPOIkPmIqv8OH/+
         aJAWfOe9t2igz0y7k/0ko0kSP/DRD3t9ZoKyW2BWVspF4LRsxQ4myVgyPiLK+APpLkWG
         mS74caXNzAYsauDctp2FuIzJBYwKPUu7NaSADBw2/atc6ePg/SzlKxFwRU6OXiR+Kzi8
         Zuw2OCwsroLJM5B+Tq/kUtzA+fBSr06sONK4qdHW2VdwfiJPRKdldOjRy6py35cbOnUd
         RYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719895021; x=1720499821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wJUnGUJSkYxsQGi1RA4irnfeYuwiGT6Z1uOT3kzXFA=;
        b=eRXSdygDEAbsAsCYKoxHhMP0lDcnZ0DAthXQYGNlVeKheRPzsz7NaR+F7FuLZuyE3t
         uN8mQ5uAw5NqYOucxuCWvLmak0KF9i59rkZvY80tANsP4HICvxfqiv9vr5Vm4iGPjU9b
         7Dp0ODuW1Bk2q3SVm8pIsWnbkDCPCNOT44qseU66/S24JeyuzgKJK0D4cOqlDiQLxSh7
         vBD55p391T1NkqntNJ7Vi26JMCFPrl7qJlkt46Mmx7fEx9LEr1/LDfWOQN108JCziIBh
         lLINpTw4icxIeVe2l353ahih4fFB7tZ3JN9UJl3zrXdtDjB9UNBM5pFEbaN1yixueF3c
         SXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9iDSsWQdz3qAkV6Ku0w+ioamdP3+uE/ElxKMY8oYexhLHXZGRr36YDHkm/Ix4esoRaoKrWzq+HGbgD/2S6OwYIgXvvimCWXFVCWE
X-Gm-Message-State: AOJu0YxlY5Qi6YmMNb6skQ8B1zYGIzqoGf4fEVl/Lxyhn4qFtYVtBhhe
	GvQkNvtYGImWxKWZp6OpB2SxFwLXDFS+JQzJUsqlWmb/8ePYCs7jgZ4YdjPtkYA=
X-Google-Smtp-Source: AGHT+IGg5crGPbSnlDPvZdZlEHxAc+4TJ6Al2n+BlUolTHf0JpxXwT5dxv/2p5/mvOy1DIjwWyg1Bw==
X-Received: by 2002:a17:903:41cb:b0:1fa:bcb:3da4 with SMTP id d9443c01a7336-1fadbc96936mr47120155ad.33.1719895021462;
        Mon, 01 Jul 2024 21:37:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2197sm73664065ad.63.2024.07.01.21.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 21:37:00 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:06:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: "'Rafael J . Wysocki'" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: docs: Add missing scaling_available_frequencies
 description
Message-ID: <20240702043658.jwumgakxplddqlnx@vireshk-i7>
References: <20240701171040.369030-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701171040.369030-1-rgallaispou@gmail.com>

On 01-07-24, 19:10, Raphael Gallais-Pou wrote:
> Add a description of the scaling_available_frequencies attribute in
> sysfs to the documentation.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 6adb7988e0eb..fe1be4ad88cb 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -267,6 +267,10 @@ are the following:
>  ``related_cpus``
>  	List of all (online and offline) CPUs belonging to this policy.
>  
> +``scaling_available_frequencies``
> +	List of available frequencies of the CPUs belonging to this policy
> +	(in kHz).
> +
>  ``scaling_available_governors``
>  	List of ``CPUFreq`` scaling governors present in the kernel that can
>  	be attached to this policy or (if the |intel_pstate| scaling driver is

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

