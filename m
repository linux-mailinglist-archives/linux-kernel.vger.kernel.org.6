Return-Path: <linux-kernel+bounces-231572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C3919A57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99017283D05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18844194083;
	Wed, 26 Jun 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc2BX4hm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774518FC9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439504; cv=none; b=thPrqbQ2L1rpyA3gnhsTwT9ugC5Swl7ZHlI8/OBk0chPBCDGX+894TKr2A4fkIkKDzryIxVO1w6G69IpgHFkj1N61fmPfDgbBsxLtZGB82Wvb3/ivV6o32gM8CeC+zPPjg+wJXb3kEDGmVi8o9ZTFMf4eYLbBBcdKkmD+21SB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439504; c=relaxed/simple;
	bh=GeidpkMqfXnmhd9aqbxghNPfqBZwUJOe5/GqBI/3L1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLsBf+WXVDtJbIkfoYrpsL+JO4QBVHMzaykCGhf42j44DQUZOxbXxHmGSPIM0uIM4lxoYV70bj0PZgLXAa8I9zibqKhv/LsprQ3ooVeASpdGZSNDp20WbiZR5OCPGFndaUBbdKU9Yj99tO2o3sBSf7zJVUjQy/h1yCmm5aUNRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kc2BX4hm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdd893e5cso5334039e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719439501; x=1720044301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siK38QYXuo8QNnveIrzt0+xpEIskBwlCTEZPBZd1FIQ=;
        b=kc2BX4hmsOTKEkgczm3lHq/1kHbGrttyfAb/h1u0h7kiNJdWZQuEhWp6lrP9Boilwp
         YsK/goR5UKvhZsYIKJ4w7YG613G1cF1uHf7B/ql319L7RD7mJ6d9moxcY8T8Hb7hQZrw
         0+cOPwa9O2tXoa24/xdL7gxaDkaJxpkOmSS4Mms8V1LzIWvi4ppM677kwn47ntg4IsuU
         2cxLavqZOXW5OedIT8pR/N/vaujYQSKGXetC6JIeBNyoTRqyE5/ICHP1xLoXrgXrJrU3
         F2/zNcQK+73965GPYFBZZqv/OtM6toW7UZLC3bKsWF/k6ovXNSa/gD28c/LYM4ycQKXg
         CTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719439501; x=1720044301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siK38QYXuo8QNnveIrzt0+xpEIskBwlCTEZPBZd1FIQ=;
        b=GNp1lurbESIoyvCUrtKTrKcImy4gcNXTLSeVT/lTM1H2wHEjfvTclLpUn1kk1C0B7d
         h/ZGIgsTQRKE6GnIP2j3PKweZHJJXgximohaBJt6t96yx9WfkNgh+IrLPQReex9+aiaR
         TwpnDAMN90eR2GSSE6VjjlKWp80x0lQ6ccVa1h0K5/Lw75dTLIfITB9Vf+h4UdxN5UaT
         i7h7CPYECLBCC8oJGOZtF9+He9FJM3L1Q9qdI7p1+1wLYP02F2ZlqKM9/l8EDb6EAIY4
         BAs5zX+9plVlW/XD1pmRRFWePcFLwSxdS2ocggE1Vx8ARAGgJ616Zq1Pg5JNJjKoGjIy
         1eaw==
X-Forwarded-Encrypted: i=1; AJvYcCVkZhAIu8V/BUpTnvAfnRZ4M5JXG46EfhYKg+Lw7eDQAIdYP+mWIr9wY8PyxmLMzjL8RG3EIPtj6UUGbJbwqG05IsIJfhFpWyuH9GD9
X-Gm-Message-State: AOJu0YzhhbMmBV9fzn5Of7mvKNbXLTd1z0wsuEuIeBFwjdomZDND9I4X
	ygJeBn52iXpD5ac1dV4CacUUz4AHrAtYzxewsKQp6/wu4p22FA/4RnYnxIAGF7U=
X-Google-Smtp-Source: AGHT+IEwz/vaLu2uYxfyNR2muYajgJEh9jDVu49ZK0TTgw/DHg5lzlZe+ZG9e4AsahaK9vSkvoqmxQ==
X-Received: by 2002:a05:6512:220c:b0:52c:d70d:5ff8 with SMTP id 2adb3069b0e04-52ce1832692mr11205312e87.1.1719439500695;
        Wed, 26 Jun 2024 15:05:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cf2e734aesm643291e87.18.2024.06.26.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 15:05:00 -0700 (PDT)
Date: Thu, 27 Jun 2024 01:04:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Kiarash Hajian <kiarash8112hajian@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: request memory region
Message-ID: <btcidskycmlkylupz6qup7z4yyh4obzibcjy2ii2biqu64vqw2@5ellx6lt6m2k>
References: <20240608-adreno-v1-1-2e470480eee7@gmail.com>
 <CAF6AEGsd6jfDqV-EOWr+oMjPpVr2S+71VYmp1JoY8xU51eeEEw@mail.gmail.com>
 <20240625175926.4xyzwjyx7oxcwnzx@hu-akhilpo-hyd.qualcomm.com>
 <CAF6AEGt5=bcni0K1ysot3-hVj9gWECJ5qP=M-sEDkRrAmEHFGg@mail.gmail.com>
 <20240625202308.prg72urp4mvtxzax@hu-akhilpo-hyd.qualcomm.com>
 <CAF6AEGs4i4mM9dpD3weG8GunHHfM0JESkzgX1Wd4PBDYatbQqg@mail.gmail.com>
 <20240626215218.pnbzy25c74c7a22a@hu-akhilpo-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626215218.pnbzy25c74c7a22a@hu-akhilpo-hyd.qualcomm.com>

On Thu, Jun 27, 2024 at 03:22:18AM GMT, Akhil P Oommen wrote:
> << snip >>
> 
> > > > > > > @@ -1503,7 +1497,7 @@ static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> > > > > > >                 return ERR_PTR(-EINVAL);
> > > > > > >         }
> > > > > > >
> > > > > > > -       ret = ioremap(res->start, resource_size(res));
> > > > > > > +       ret = devm_ioremap_resource(&pdev->dev, res);
> > > > > >
> > > > > > So, this doesn't actually work, failing in __request_region_locked(),
> > > > > > because the gmu region partially overlaps with the gpucc region (which
> > > > > > is busy).  I think this is intentional, since gmu is controlling the
> > > > > > gpu clocks, etc.  In particular REG_A6XX_GPU_CC_GX_GDSCR is in this
> > > > > > overlapping region.  Maybe Akhil knows more about GMU.
> > > > >
> > > > > We don't really need to map gpucc region from driver on behalf of gmu.
> > > > > Since we don't access any gpucc register from drm-msm driver, we can
> > > > > update the range size to correct this. But due to backward compatibility
> > > > > requirement with older dt, can we still enable region locking? I prefer
> > > > > it if that is possible.
> > > >
> > > > Actually, when I reduced the region size to not overlap with gpucc,
> > > > the region is smaller than REG_A6XX_GPU_CC_GX_GDSCR * 4.
> > > >
> > > > So I guess that register is actually part of gpucc?
> > >
> > > Yes. It has *GPU_CC* in its name. :P
> > >
> > > I just saw that we program this register on legacy a6xx targets to
> > > ensure retention is really ON before collapsing gdsc. So we can't
> > > avoid mapping gpucc region in legacy a6xx GPUs. That is unfortunate!
> > 
> > I guess we could still use devm_ioremap().. idk if there is a better
> > way to solve this
> 
> Can we do it without breaking backward compatibility with dt?

I think a proper way would be to use devm_ioremap in the gpucc driver,
then the GPU driver can use devm_platform_ioremap_resource().

I'll take a look at sketching the gpucc patches in one of the next few
days.

> 
> -Akhil
> 
> > 
> > BR,
> > -R
> > 
> > > -Akhil.
> > >
> > > >
> > > > BR,
> > > > -R

-- 
With best wishes
Dmitry

