Return-Path: <linux-kernel+bounces-174565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76498C10CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EEC1C20E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3015D5AB;
	Thu,  9 May 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="FHIxmQjk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20415CD7D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263514; cv=none; b=VwY8ZEp0pC+JnRisflsi9mUdmA2EUQZ/tjYldIZGKT0+4+G8DTtKjer9edO6wmYboOC2rxpiupkW/XGhNgKSv2Sa0VR7Rrr1xpdjolinLvy3ygCwUYGMqfRinCoplNRU8sZ7tOltvNhGTpVXExw2yfDtf5xWrYYDELdVhHi3P80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263514; c=relaxed/simple;
	bh=0YdZl6Zq6//+zNC1b0gYUiB5yFvpiMGteATa5STZ6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/20uu+7Ge3oGOJYts53hh1s3AGIb+dP63tiQWqA4zclbAQ5b+9gHaEDDXa6/IAE/ZupAkJ3CROs81DoxCMVclpG5T1MZFRwpb9i5c6nGALTtm1/M1cMp1ULSHdItS4o/JvQ4LGPU2ZWezQeaxqZd63bteCd2P70XN/r6aSY4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=FHIxmQjk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43df23e034cso7233261cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715263511; x=1715868311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvn9rngIDL29d8F1SzHuLjz6VO7wTPtvUbwSUyJZyRo=;
        b=FHIxmQjkc7Ualuluw2fLfP7N3RZpwBpOH4wmseQW7FNB9X3FWNS1UPfB67weeQBBpv
         zy7Gezo5pdz8WGWStjpbhWXT80YlNDPFqyN4oS13TGfiaFywO1X+RiMBA9OQ3hJOOgkH
         CagMA18SFj9pSsh9y2lztZd+M0erjhxVfLE9ohUmAy5w5PzO3EZANFUmU5OfZ0dCX2ai
         nsLfk+HBoS4SlhYx06YS/sH/JPr55gJxmrWwH2xyEuipwS/9CnnfAlmKSUv4NAwnUiZd
         9teI53e5AjExu2Xya21omP81Ywj/A/Wh7N8uDI6O30bEJqxOv/gOvHvLub9m+xperc4a
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263511; x=1715868311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvn9rngIDL29d8F1SzHuLjz6VO7wTPtvUbwSUyJZyRo=;
        b=cZYF7YyfgbeU7RBODRgGr9aT5bJyH1OgT5Wghq1Cjj74FIZgSX38akd4KkFHUxeset
         2fyVa4hQRrpWke52tcigQSwVaF6acabVsUls0lSC6m7agom4K30XHn1WaRo9Lt7iHR7+
         U4dMDO9oky/NhK+w7FJFYjBJpb/+JTRcIkLSXuykImqV3CDXYWtK7sIOXPg6DFpz8OZu
         2WzoIetDtwDQ0/DqScNv6H9mDFnuJjiAlUjmvHwpY+aGkmWidhyXRK339Oz74TfRwJgV
         HXBc8HsZpsjjC3fAwUE+a/Iu4iBS0iab/kz+46Y//PpFJkkHkk3Ak8Ad26lFIPvNlS4b
         e4rg==
X-Forwarded-Encrypted: i=1; AJvYcCVibI0g15M03UR+XRmCZ6P9kheSksnSZWMDLXx5PXDyO63PVYfqUGTMiziGr3a9sE+3epte8A2dK9CF7jIHVnbg5pvjH5u4lln3wTdM
X-Gm-Message-State: AOJu0Yzx3D+HspDTR4PZg58WxN5ymiuF5/q/NDnC/X5yNZ/4Euxnq7QC
	vi8BvMaqp6B1opllBAcJ4OitzJ197yyYmkvEU1ouGeUotFYoPEP8poLyIohYFXPVb1FjnwFY9zI
	b
X-Google-Smtp-Source: AGHT+IGfjpV8KyyCSoYBb7jd/faTYT6XDBXmV2leln7rpsUs8MqA5s1oe086inZatvtDiGmDWFpCkg==
X-Received: by 2002:a05:6214:110d:b0:6a0:deb6:7b0f with SMTP id 6a1803df08f44-6a15cc96ce2mr42735196d6.29.1715263511394;
        Thu, 09 May 2024 07:05:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd3desm7259176d6.88.2024.05.09.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:05:10 -0700 (PDT)
Date: Thu, 9 May 2024 10:05:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <20240509140509.GB374370@cmpxchg.org>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507110832.1128370-1-xiujianfeng@huawei.com>

On Tue, May 07, 2024 at 11:08:32AM +0000, Xiu Jianfeng wrote:
> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
> make it return bool, false for failure and true for success.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I also slightly preferred the -ENOMEM version. But this is better than
the status quo.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

