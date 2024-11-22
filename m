Return-Path: <linux-kernel+bounces-417713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364969D5840
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB4AB23BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2178685;
	Fri, 22 Nov 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg8HnCzL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BE3B1A1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241946; cv=none; b=aCXnLZ1Ukt/tmzn9GwyWKpMs/qc+pWVUUXDsxgy2KAQ1D0sB7OsP9e3EnIAj/etD19Z/PvVy0sZ7oioD6wAez2aOEN6HK4TvohgynEJSzLyyMpVYWQhv4dcg8IntFsT0Ge/M7pcSbF55iXBhBlYhq/et1W8PArG3XN4LzAerkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241946; c=relaxed/simple;
	bh=Qup15IkH8HOsKdf0NaGUj9HXWq6TOIprAZFYmvTyTbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLhWV7xnGq2kjavvkbi0J/ph2YGBg4JyfBKkhpFZC7fmGU/m5i8HiJGEPrSpR1hvPEvMKGDbdO0NpWhKa4axPRwR9GsYr/FblYKeLFlW2AlEL6Ng06Xg1pRK88MAkJcok5pmNq24w33Qs1zR28GgyNMQW4+4Iy9VrX0IS0SXNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rg8HnCzL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so17760191fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732241943; x=1732846743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=490Vuq60Vu1lzedk2GTiclsdAMpFowtjFq9q2ZS01+s=;
        b=Rg8HnCzL5U4AMsruAnVGOxyDAkVKApsU4nX6xxmRhZQ+OIxQ8V7n79U4BnDBl1L+1l
         CfTca/SCusNPiX0X8NqNICsPz8nWR4qoRVa0j/rvrbjVnYFOZt/qZQkDc6nGKne/8cD/
         zqa1eviq+gtFU1QIx0BTxsaxgw+EEeL1hCpxs3kTNmFINrIvWLDYOKBRokaMIFJBQ2sz
         wqIVdIUhf1HT/woVkKcIAm4noWWe3Xlv1rY99TroNWq/lYvrVvLQmKoiSwoSSAMmZqFR
         NL7PyzfX3L9KMv09oWBeSAgUBuXy6n9bNTtJwVorUGK+XYsHV3E05jwRKvc6cuIT/Ohl
         Qc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241943; x=1732846743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=490Vuq60Vu1lzedk2GTiclsdAMpFowtjFq9q2ZS01+s=;
        b=N44Q6NXj6K4f21ILiN+R+XicZrTXk/ohAYdd+3pP/yLk6NJLHnP0POo/CdvuvM7GBn
         g3soTsSk+qPHdKdGf713C7ylr+8ysY8zbR9SnwJoF7b99vmls3jjc8vUvee+hVYGwFty
         7c/trXS0QFkDwrngKu0M1K5mHIvzViRh7R0O+J7atILMTMZoQv8Nl6Yceu5hgtB6la3R
         +e71IJ4fSxnXosUqvo3/AOBp7+zqNsFedpoRuLmZBj5wjw+BwSrgAxfAXk3xIt/iCBPi
         vfTmMxVF1nk0udYRPMfMzsYXHXJwT69Lyb6z7FjvFE7W9lejuQTPgYK3hWIV6qUlNJJv
         0AoA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmOsxD2bp6lt/3tAvIHx04/m/5ad422F1wMcYgMhH8nfIfw3m+60N9hnSjw8JMBVznn+fN3AnwEa3MqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6Va0VU/vMERo6FlSBf28kcL+40c3yXj01eQf9qqOYmv+1B/Z
	Ug5BYjIvMYD1CbgRU8TdGpwLPMmtwttD8nVA5ufZ4+1TE7SptCBhDiRKI1QW/ds=
X-Gm-Gg: ASbGncusE/2x0al/3joLVxntyp7zwpFV7ipjm5v8DSU1nmKFUdU/JGkPanEuISESrU/
	va1kRCz0Is9IZowj/G37rYZiBtKshOTg2HglwkjFwHPrCx0AXFEFXnYM/FfM/AdCXqd06paVfot
	o+dFJB7y3WTd8rOyZnT92g4f8hmk0f6IIZrQ6C3iAZ7nNXG/6f5YUkxzFDuSYsMP7BiMOtCXuy9
	wmu19zd51Mfqlj+O0HXDVnhGeMnDvtJcVNXs4JPpSbB9KLRAkmjXjzx5oP/LBYuP4CtMXtvbO+o
	aD64STNEsv0yJHbVgb6pt0tIPzeEjQ==
X-Google-Smtp-Source: AGHT+IHv/1k/72/coOAhCDQ5zs2M+V21u8dURd7yb/KTZ5CMbkmpxgJPkNqcuh4HIenSoFvz4zIL3g==
X-Received: by 2002:a2e:a914:0:b0:2fb:5ebe:ed40 with SMTP id 38308e7fff4ca-2ffa711e020mr2658071fa.15.1732241942179;
        Thu, 21 Nov 2024 18:19:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53769d8sm1306101fa.79.2024.11.21.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:19:00 -0800 (PST)
Date: Fri, 22 Nov 2024 04:18:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 4/5] drm/hisilicon/hibmc: separate struct of
 vdac
Message-ID: <aczenuy77k6ujfntx5lac5uqqxzroceyel2qwd6iuay3jnvbx6@q6mirgoustjh>
References: <20241118142805.3326443-1-shiyongbang@huawei.com>
 <20241118142805.3326443-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118142805.3326443-5-shiyongbang@huawei.com>

On Mon, Nov 18, 2024 at 10:28:04PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Refactored struct hibmc_drm_private to separate VGA module from
> generic struct.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - separating hibmc_vdac and hibmc_dp changes into separate patche, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410251136.1m7BlR68-lkp@intel.com/
> v1 -> v2:
>   - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>   - modifying drm_simple_encoder_init function, suggested by Dmitry Baryshkov.
>   - refactoring struct hibmc_connector, suggested by Dmitry Baryshkov.
>   - withdrawing the modification in hibmc_kms_init, suggested by Dmitry Baryshkov.
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   | 16 ++++----
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 41 +++++++++----------
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 20 ++++-----
>  3 files changed, 38 insertions(+), 39 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

