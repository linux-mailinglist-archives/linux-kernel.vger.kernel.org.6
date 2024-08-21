Return-Path: <linux-kernel+bounces-295758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538195A127
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BFB1C20D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC841474C3;
	Wed, 21 Aug 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mjze5nMR"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B2139597
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253095; cv=none; b=buLzPYCHAYYe9m1VD6qTW5xSEEnB6vKvz8mG9LVW7aclTv2RkCvQZOH7uODOGYaQhXtKWnL2ld5hQ5fgLjZnXRPudQnmsBUmsxR2Pg18oHZoV5Fu5GrbFsG0huJaflizZGkuBEf+yuZqU+NAd17AQo/Kja/GNqsDm2dUimbNvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253095; c=relaxed/simple;
	bh=WbVt8wycuPNiSdoilWbs5AfV6r1/zs8ly4CfovX8xHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMDhvvXxlNxg9XYgO/QsF9ZHbQz8R0nlYHabG1cFT0nEnOfV1KVF+z6pYXs3SncYRMl9TyixF7Z5U0ZiTjXySFnrFm4i8o+Vd/4YDMPXIk4Fh48QWrxjI5SGzqJYiGWD3OOpbMQ7Vn2dLzmD592M5Qx39gx/4mEboFkp+nPzQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mjze5nMR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5332f488c6eso6790626e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724253091; x=1724857891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWqVOnOMPwf1aUFvCVrFf4VPqF69Ewf7zmbruNVrIBw=;
        b=Mjze5nMR7TJZs2ycKZqPTDrjipdga6uzXBVRW7Br1GUgLbcqDCvZz/gA6bPRfSg+zb
         0q87cXlI88EhRnvR7XanWece0qFz/s7GfDAUK3UkMxmBdSE5fdaJbOhjcKmNFmyAfXa9
         h61r3FWQMooghONR4N+mtPmEKoRtzZGs45mNXNouY5GN3y8NaqjrDAIsTg05vfeINhe8
         uKcHmSO7oLnlO2oM6I6l+rmXghTWXuN/3eCwUeQ5rxTh9nQAVbtNxlJx+q0ddbw1U9ZP
         71XN7AzMa7ne7FyBBH47a0YR6OCAidNLZToCttWzz17OTocEuzhin7sbERahlL5+W3m0
         oOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724253091; x=1724857891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWqVOnOMPwf1aUFvCVrFf4VPqF69Ewf7zmbruNVrIBw=;
        b=eEu0G8+PsQVKGt3dy65lcsyQUhwbHsmj+MKIw0ynI2Agz0m31FE/IpOMafoiOkdaoC
         H7kaqjzhtWIulvwrwZv/NiHyq5crpvnlAYTZ5JZP/DQrQ4wuDIQgn3rF7PVmozVUUug4
         HsDagS7p/CczqSWpbLTyctMLC9AoHS4kTXKVib4YAX/svxafcgXaLe6GoLvluzGBP2EG
         zG4ts+e03w4VsXdJ2wSO1Aeu0UtI6MaJW9cJc7QCSvZ3b/3x+N/3FwbJhx5fcJOCN583
         Kt7sD+/x6284CPz6Q+ZwsJ2cqUZWzBSvNUhzuUoqofSkHlpQvfq4K84ZSGIi7LaNBdS3
         Y/LA==
X-Gm-Message-State: AOJu0Ywo+mRH+dHezTb2uQD2MnXjx1yjhDOvpW/+tRoFk9D12X8EscjG
	kDA194gxCXVJkibSw7qFuDlAPkVVfQBGcPxoG3MJc+8SwIit/QiuKUFpGLKIy5o=
X-Google-Smtp-Source: AGHT+IEBZc1XpipYGfwXvetKTPV5HGydbAotLpSgJ5YV7sPRC7Xfol3C+JOCL0qbpYT3+Do239Fwcw==
X-Received: by 2002:a05:6512:3b8a:b0:532:ec7d:9c67 with SMTP id 2adb3069b0e04-533485d6a4dmr2079937e87.47.1724253091045;
        Wed, 21 Aug 2024 08:11:31 -0700 (PDT)
Received: from localhost (109-81-81-250.rct.o2.cz. [109.81.81.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a867babbe22sm82370266b.183.2024.08.21.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:11:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:11:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosryahmed@google.com, nphamcs@gmail.com, ryan.roberts@arm.com,
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org,
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Message-ID: <ZsYDoQ7NybCcXADx@tiehlicka>
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>

On Tue 20-08-24 12:50:05, Kanchana P Sridhar wrote:
> This resolves an issue with obj_cgroup_get() not being defined
> if CONFIG_MEMCG is not defined. 

Could you paste the compilation error and which tree this is based on?

> This causes build errors if
> obj_cgroup_get() is called from code that is agnostic of CONFIG_MEMCG.
> 
> The patch resolves this.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  include/linux/memcontrol.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fe05fdb92779..f693d254ab2a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1281,6 +1281,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
>  	return NULL;
>  }
>  
> +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> +{
> +}
> +
>  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  {
>  }
> 
> base-commit: 7d0b0d4b77b368b2111fc8b4449e33dfb3c34087
> -- 
> 2.27.0
> 

-- 
Michal Hocko
SUSE Labs

