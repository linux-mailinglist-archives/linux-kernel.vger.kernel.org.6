Return-Path: <linux-kernel+bounces-233568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE891B9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1A1C235EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5671465A1;
	Fri, 28 Jun 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JvjQF31Q"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA15146D49
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562507; cv=none; b=TUbut6FHddYAvULm4HhhFrbWEfX6+KvulHtyFkM6NGKP7p55gxpkWH/biRIckXrQ39prqww84nIdy2oHvnLitv1csok1JjY/OQTlDPoT8LuHe8OKh1uMpJuZOeJyEr53TfpywAAFa83yZGn+L0h0NvsrtnQuxOiidWvQu5/XQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562507; c=relaxed/simple;
	bh=pTUeXVvagiAOX0gsD6IPogOu/97cu9jgdrjcH3WYizU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EabnnEryA/QNvcIe1SoQ6R/x96AzJsDVOBHnWb1eUSJ0FhvOFvF8IhiSJrd/PAO5V+XdXcGrSKZUSWrPguznGQWURYAOLRktKnF6o6P67FvRDLgK8oOMJnp1cVSWUuC3tP7c8XUhrNyQ5Bf+GRXTdTE3JDVh0ZWGBqb59/XJ+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JvjQF31Q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a725ea1a385so35764066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719562502; x=1720167302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqLlOcQQA1EIzNXkhLBuQWSjSlMYijdUt29humv/fBI=;
        b=JvjQF31QMZOTMgD0gBKyooJDTcwdnDnrhdZ9Q26oC7EHz/qjJm3PB2FLNlbPAkbLHH
         LqahhRebSd+XRx716NeMuYGRN/ev48M3VU6jzC2oSlQPA8w25xQI/sehcFCRC7/AxuRL
         H9wrqX4lqr+UfFVsOoWy/3x+xpnDZ9XbEd+bfg3X/sRtO6u1WA4f/iFrzrfUKXLcyte6
         ojG2j9m2Nyt3cf2jBaFelt0DDAeMUUMBA+i/DLYgjb1OeS0QKVK9+TzK8qJWG68+BEJw
         c6YvmKiYcD6GXkqYkGzLxcB16/TkhMrkoMgB04hqPYMh+ncMRP+C92fdTzRviVMxm14y
         78VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562502; x=1720167302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqLlOcQQA1EIzNXkhLBuQWSjSlMYijdUt29humv/fBI=;
        b=en5YUtNr7TrBxTX0xC7M+FYOa3VszQ5HaHVXND4fmyo/MWTynCyi5xD3KFeMde1h83
         DXRH4yXy/x5EfWA0kaaJ86mN7eZdPWY6wXIonGyEWF1U2a7NqszXb2AvGnHl5mIf1UMq
         CY+f0OIkdZ+weByngKDEV4ONyWRuJAQjXowx2xcmX/0leUxEOKHDSAmFa9ymKkvjJwyg
         H8d7SJm+2e3XkyDspqJ0LkkXuvnanJRm3Wa5g5+PBcuvssyJ5r1//51PTiT7xEI4Cghm
         45WDl6z73tsGE77Hwci5N+GKWExgOr7qpbjzJUw9KuUG+j0fVi2LbQpMExW+VZfv3qKf
         FIPg==
X-Forwarded-Encrypted: i=1; AJvYcCXoKn/Vsu7fw3notOSmlgZ2IIGGxNnbbnN9rIQdyLa2XlLnyY4Dg3wbyfv9TdBIvJ8OfCkFSJJ+2nf4Oe4+T1AW7qEitoD/vIu5Sycc
X-Gm-Message-State: AOJu0YxB/R/CaR6E0w+z7oYCefprcEPAumYfDVd892Lu0aULjGMokf+o
	/4YobLj0fCABxFfWkYoZ1OI8nBlg0VTi/+uRnFCvwTCDBjblS+Uk4cFFyyLxQQw=
X-Google-Smtp-Source: AGHT+IFtrZNHvkM+1D5Qqnw97MEaBSYKkXSf4YD5eSBkUIwju0hMYrI/Lg+SsBts/4RTOO7DdYI2Jg==
X-Received: by 2002:a17:906:6a85:b0:a6f:9ded:3200 with SMTP id a640c23a62f3a-a7242c4e28cmr878310466b.3.1719562501987;
        Fri, 28 Jun 2024 01:15:01 -0700 (PDT)
Received: from localhost (109-81-86-16.rct.o2.cz. [109.81.86.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065241sm52910366b.108.2024.06.28.01.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:15:01 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:15:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: adjust the warning when seq_buf
 overflows
Message-ID: <Zn5xBNY-Z4eNTCAL@tiehlicka>
References: <20240628072333.2496527-1-xiujianfeng@huawei.com>
 <Zn5qELsJZ0CrdlZA@tiehlicka>
 <0e44be2c-7039-710b-202f-c452bfc3f1ad@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e44be2c-7039-710b-202f-c452bfc3f1ad@huawei.com>

On Fri 28-06-24 16:09:02, xiujianfeng wrote:
> 
> 
> On 2024/6/28 15:45, Michal Hocko wrote:
> > On Fri 28-06-24 07:23:33, Xiu Jianfeng wrote:
> >> Currently it uses WARN_ON_ONCE() if seq_buf overflows when user reads
> >> memory.stat, the only advantage of WARN_ON_ONCE is that the splat is
> >> so verbose that it gets noticed. And also it panics the system if
> >> panic_on_warn is enabled. It seems like the warning is just an over
> >> reaction and a simple pr_warn should just achieve the similar effect.
> >>
> >> Suggested-by: Michal Hocko <mhocko@suse.com>
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > I would just squash this with other patch removing it from
> > memcg_stat_format. But this is up to you.
> 
> Sorry, I might have misunderstood, if you can squash them, it looks good
> to me, thanks.

Andrew usually can do that even when the patch is in his tree. But as
I've said having 2 patches is ok as well.
-- 
Michal Hocko
SUSE Labs

