Return-Path: <linux-kernel+bounces-547684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0ADA50C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD21D3B0A20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F084253340;
	Wed,  5 Mar 2025 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voemq3OL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E7254852
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205926; cv=none; b=JtyZ04sMpjPQcyMEMd4ZEhhNUhaFFGsSQO6SH44ogo2ZreKWmleRM6b8QzgdkoallqDeetE34l9WuFVVtBOpHhLT/1OWyncPptfr8gnLXOpKJsedAAGRv2XeyOsikOrB3+ND2fpGaYwPmvQZHFII1NNsbDyqVXJpUpOmDkk0DtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205926; c=relaxed/simple;
	bh=4CKDqLzIqlkusxDxHpZZMECO7gNXzZWK4jTJVI47tFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ1ibrW46UN4yprmzoFESSGQ7ttgpdZaxggQe72hhUkEsNTXzGrUD7K8QNar8DvTt8YEh0yPNBumloH0DjwFIOMBMvpdSGay33Bk7CJfzVtegxKBLkRw6ZEv2klNYYg2Na8XJAWq2hA15EvKszEHgKLMppQqc3J0i7RfS0avHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=voemq3OL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549880cdb1fso44577e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741205923; x=1741810723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zYiNnGxls5NQwkni1gf5Kr7TVqL+dgRikHrlU+v848=;
        b=voemq3OLeNFt3QftTuFW5HbA4AcZQ0A4IXGAWR3AQITA1ew95UslvzgXVb0QwK4wtn
         NZ8bpVH/sD8ydIcX24DQ/iuyp4ZVlenMEGo76VhB+5/dbel21NxKIZxPrfW7op+CNuWi
         qKMcmxDThKFehCC6IKFhc2OHgv//AhtkZJKiCIvSusMfV+2ZDKJ+8V2z+I+MeCgNnuaE
         2q5Xb8gBoP2OzLkJzkmrsTrABlgNPMwlbvOvpVyAz1GjQfVurIy/JibkaJteJ4MW8E3n
         /9E6NHEr5yfpaGdzzikwItRlLIK6ds2XX3HtHG9h6Ur+7SK6MheNRPgwKPBUvABKwn2X
         pDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205923; x=1741810723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zYiNnGxls5NQwkni1gf5Kr7TVqL+dgRikHrlU+v848=;
        b=GrEl40KpZPWLybYTrj5Q7+hvThqfz02TTZRsuHkqboLy6k7wCGKNae8YzbFw6r/SHC
         SyAplDhYdZS67lBxiIlFNvtWu5+1iA5CSQrA1L8kgrd4jyIkV39h0ZLxLFPJd4p4uXyG
         zaxzju0Gmhz8dfHNLhDra99kYK1z0y61FVTYEkyDMxs5rRXxP3Q6+Z/GmXsBh98qsu9x
         BJNDZ35g80okkIl9zjPdKsZuKLjmHJ3Z0kaA5qug+wlcjwkxTJaOQBSrlsbMrOMUO+aC
         pVUf5cLvRJtp4RxYiqYHNmasgsflkERU7Yoqyz5mWvyIwpqhVb6gW0ddBBy2iosIW4iv
         ggSA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZyGidJ9d9Yq4udAqbqZIPqt+xwPDUOTChr2LVwdS08daUZRHJbORjLQYQQR9qe8binEiBGGVmSFcUJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsF0UleyQQ+AYdvn4tpqP5p6fPrkjCMMkpKn9NkrhMxhMXPgq
	7+Tjk6uq6JIynpXJTfFTIlG8RnFfZbpYgWtSlMMeUYnnluulRjLo9Tenvn6w7uQ=
X-Gm-Gg: ASbGncvOrWmKIINuSpL7en9H3l1H573jdzx4aUg9tqCDZYr3bn0NkDO35B6ZtkjRMud
	BaQtZpqelh979q16rbolSzbqGTxlCtk5a3BEwpLCeb4LJdDU9W26c+rjkWQXm3pKOzjzSFhwzm9
	8Mc9Mxp4sIuCOq2pW0wPpfbWUgdZIQuJnpeA9Ok8zFGJasiZOPWfGFXSQEPWCtoKaxNi7L4yXI+
	03/TKwJ0956Z9kp902LOkZHxRhbUh86WPqetyeSxwBJmhMHV7Z0IDHKEZKvoFsAp34Q8DCeVD3a
	k2Q6csJXsJ6DgDA1n0Q4bpxy6vubfCw+vKpdwMZvH4pMbyKebBie2zrDm2MnchfGP671R9lZHLk
	fYLFllY6tpnV91TU9+v8vos4M
X-Google-Smtp-Source: AGHT+IGfSQMVA0rAbvtw7eZZjQbZgRCizMe4yyJ2LJBgQ6PQ3Zg+lNGip7UTnXIZjwRe9hOTM1t+GQ==
X-Received: by 2002:a05:6512:ba3:b0:545:2d4d:36d1 with SMTP id 2adb3069b0e04-5497d33603cmr1885817e87.20.1741205922964;
        Wed, 05 Mar 2025 12:18:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494919b530sm1807328e87.141.2025.03.05.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:18:41 -0800 (PST)
Date: Wed, 5 Mar 2025 22:18:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 6/8] drm/hisilicon/hibmc: Add colorbar-cfg
 feature and its debugfs file
Message-ID: <2ajmcqbmqfra3ojqee2zhxvmcqzejytfirr4zumz4mkbekvtje@qxbe5e2lqcif>
References: <20250305112647.2344438-1-shiyongbang@huawei.com>
 <20250305112647.2344438-7-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305112647.2344438-7-shiyongbang@huawei.com>

On Wed, Mar 05, 2025 at 07:26:45PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> DP controller can support generating a color bar signal over the
> DisplayPort interface. This can be useful to check for possible DDR
> or GPU problems, as the signal generator resides completely in the DP
> block. Add debugfs file that controls colorbar generator.
> 
> echo: config the color bar register to display
> cat: print the color bar configuration
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - rewrite the commit log, suggested by Dmitry Baryshkov.
>   - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
>   - change binary format to integer format, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
>   - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
>   - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>   - using debugfs_init() callback, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  43 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  29 +++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |   3 +
>  .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   2 +
>  7 files changed, 184 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

