Return-Path: <linux-kernel+bounces-551118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A6A5686A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79B818899A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9C218EB1;
	Fri,  7 Mar 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6SzPXPi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D821E502
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352594; cv=none; b=dGgq4i0G1tWNN++t0/orZcskDzp+o9HXJPnKh/mTELhTO/VmftMLEaURAjc3k0vOY2wNlJoTQ2sGBULJJBQ0prMMrxKSAmCfnpXdNWUJZFDYTYyKQRQSNdQL4Z2k6YwUdJRSPDRtAr7/UAhie+yT61pBQg/52sEXQpZieGj/Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352594; c=relaxed/simple;
	bh=+NVJDw8txlGx3bbVRhOaYmuLRx1DrbEs+hvR/LyNqZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ5rIJzpGSLTfBj+1cZkvjVZ4x8332JMUY1nEDRUzPhjqUL17vM4N+TgHsnzpoPkjOcHjWEGHTq/mM/d8qHDhcRrlGY09dgMwAvHhFRs1maPwSQ2KEW/t5U73jAibVGYSMAgxhd2OEX6F+fj9eXmQnhTY0Lu448uFG1u7lQKNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6SzPXPi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf8632052so4343651fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741352590; x=1741957390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLeGgbjVBcAPCl3aG2E0GcrYM0Yzi9aa/3xxUloO+y4=;
        b=J6SzPXPin2gemJmU1So6rpg09vyqg2jWHjUv9lBJYCiwRvk96my3xuP/Ds/IIqq1ZS
         IwDwvcX8GLQRJiZ3+XjJoZ6jUIhcVwSemnrt4+PMDwEFVjrr7hKfjF3dZVq9Z9V1WOWS
         ujhSg9pbQwocHGVCmcIhiZdFJuoj5NB88E7Gf/3OWl+UZtESeZ5BxfhtTzL/f0JMR0l1
         zDrCNF/z+uGfHJwUUr7wEA5v4wRI4z8m9XhHsD807FqFfvTX/5LaC3aELpjLMoBqCNwz
         MV0d4L5QhqC4nytfwbyBEh+Ngy/NM+hoWUopi46DPtJi0KnvjwvZ2nL3pyX+dxDJiHWb
         uI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352590; x=1741957390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLeGgbjVBcAPCl3aG2E0GcrYM0Yzi9aa/3xxUloO+y4=;
        b=OFyn0YDYD8WcRH0DrYLE1B4VDxSAWyPXzytxSSWaKaqsgIRsZf0F2FE7ZUhtXBBSNG
         j4tc77NpyBKntu7NFLahoqUhsaZg+qskpJS7UuYBcG2Kmob4BY8XuqljtDdh1pHcw1/C
         G7z+BB0bN648nSncy07X/RE783zwycXItEb6MJJZM7pt+7KpfrPErinoU5XqAoM3ACcB
         Ln4qXKcz11IGoZqT9vZkkTVZTthSpvTL3cNOJf5edKrbNki5wwvyhs8Hv1AWWz3fibn/
         GtUhaDXGEaGOh8vc73ESfWkewO2ysgQlh22GDgwXPwRYandEFvCcxDVNsRnVcS5LKJgk
         zIpw==
X-Forwarded-Encrypted: i=1; AJvYcCVRicz7yUEQ1tqcsmpjL4tA4EXdGSnocaFAdvEGwaE+6BvB3mH4ZLL31g54Gjx88HuPeS5aJIJ2lLneVlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOXwS8cEBwLrLX/IMJ5rjswwkBbDsQU+nU1xsFWEdkgGuT/31
	2gZWmQe67cwS9yh8LA1sI15Fk6WtyeLm3JJB85wAeVMYGRJJVb2rAEe+Ji5qz2g=
X-Gm-Gg: ASbGncsNLpujDJKJKeQoJkplxOLloaB4y/W33r2N+YzoxULGW6aqYBPEMapMR0yaOyv
	aivgzPQUQ6GP8a/lZ/WWVry222YnjxZKFhsCZw216zKIRjUpAs2cStffmYMsZsiGWQU453U1Sw1
	trwAgBYz40J3QZpcRRJvsezuVHXcBMt9CNDmmBxGSvV+zU51GKJxhYs3VUkspfW3WYPeecY2kTB
	zESsAXQNI0G1wYQnr4L5fzXyapB0HAOc0s/h6CAPzCJZ1PFSvXM774mWBvD+UbedSaIXuPe5Tcg
	JyPD3Vb9LQSoz9wwOGL8onSdw9DHq36jZnn1jlBW5DomCE4QrOZ3w0ZCbrsJwbsVyPQjbjx1xq6
	TWZkAtmVOp+JfWI9o7GehkR2a
X-Google-Smtp-Source: AGHT+IGIJV0ELkHdf7lsKbA2N6s1XmXcUz7x/m7RVlnY4w+TAn+21DgF7ag+RAW2PzSo5ynAcv/AoQ==
X-Received: by 2002:a05:6512:ad1:b0:549:8f3a:f64 with SMTP id 2adb3069b0e04-549910b59b2mr1123534e87.41.1741352590041;
        Fri, 07 Mar 2025 05:03:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc0c2sm481749e87.162.2025.03.07.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:03:08 -0800 (PST)
Date: Fri, 7 Mar 2025 15:03:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 3/9] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
Message-ID: <qig57go45vj6hnnacak3qvuzapkgymf55bp7uobn5xvfjwgcir@ue4zm7dqqrnt>
References: <20250307101640.4003229-1-shiyongbang@huawei.com>
 <20250307101640.4003229-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307101640.4003229-4-shiyongbang@huawei.com>

On Fri, Mar 07, 2025 at 06:16:34PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add dp serdes cfg in link training process, and related adapting
> and modificating. Change some init values about training, because we want
> completely to negotiation process, so we start with the maximum rate and
> the electrical characteristic level is 0. Becuase serdes default cfgs is
> changed and used in hibmc_kms_init(), we changed the if-statement to check
> whether the value is 0.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v4 -> v5:
>   - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
>   - fix the format of block comments, suggested by Dmitry Baryshkov.
>   - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
> v3 -> v4:
>   - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>   - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
> ---
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 77 ++++++++++++++-----
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  5 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 13 ++--
>  5 files changed, 75 insertions(+), 26 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

