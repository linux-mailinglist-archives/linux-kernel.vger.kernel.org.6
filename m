Return-Path: <linux-kernel+bounces-334521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F497D845
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DC41F245BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8D14A093;
	Fri, 20 Sep 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REA+rg+l"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828717E918
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849285; cv=none; b=CNQXs3J43WdxSy4JzCV55lDv1XETMHq+YdEdcTEv2L3UcWk+I/0W+jAEC5muhnuGoGW1AwsBL09/v7JOa4hIrVB5EKxGmUZIPZu/rl6JY/s//eESf8cBdVmePsv7DButdCdrtaVyv/8pmKyMDH1vB5GXDKlFqucyigixDAxImaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849285; c=relaxed/simple;
	bh=CcmSPRMs7UNu1/7b0i3/D0RH/i0nF8VQwNOsaAjJF0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GobFITHZMbkLmzmWHFsmSYUHsQkDqJ9OOiKQgyb/glJNewzsYl5m1nHWFsNdHSyfLr6z7VDKG2MrW7L4G+/Kpm1H/SQ6w3E1ZJGhRiqmPL9N6/9JlSddRIehSUTixCsC2LlB4MbJWSdCFOFDibxrzfGJLda/1P/nXENQ5tkbfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REA+rg+l; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so2702491e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726849281; x=1727454081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+484yaUAM7Bqur487+xLmG9zEd0hBev6NunxbKIeA=;
        b=REA+rg+lfaL6i/srjxa38BGJR/OGU6VO6W0xekVQl3dqUJ8NUToDITVd7TAmzoKmoh
         C5SGglzEeNOj3wN5beltxk6LrqTVmZmeDFwleS5CvhZrUxwv90ydefUNtJ3f1xC3HBMP
         HeU+ZLA3B76I5RWcPJ8xfQh/w5rH6luf1+J8nVOjcXI3r6Yd4CuY38oRS8L/jHPtQGSh
         3R2ccktADB9eC0VH1q28kkGGsG5bMCnyTjJs0CvNDLvCFBsNwumbslFSN1XlvZ4TRwkj
         UlDxLdiNF8IuAyL49L1nbulrGNMMyQAyA4vhHdvTBuKAsqCeCsxHmYnCMrEa5DOEAerQ
         cCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849281; x=1727454081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n+484yaUAM7Bqur487+xLmG9zEd0hBev6NunxbKIeA=;
        b=Pp0Zum8Hlh7WO/rCvrHswTJr5Iz0sep5NCFY6WYI9lYkzaP0B1fuAklbWttAUmmmhW
         3pXpiKBEL2pdZFufO19ywFB+Ej0WZmGw+w/9l+odTSS0hlY1Rj5hBXNCwkdVOSnwaZVh
         Dq9J8UjRTb4ObnvoDSqdNRLt8IFKotdZYBt/j96gpdP3OjkaAf3uzYCDXiC7uGrbyYmI
         /8iSHb5tmg10zLj8HQUCOrbubH6KL0gEwQG8z9IYerojoIOJcQPZZOP9rNG2PfJCI0Me
         9JPuuaayGXuNy29OPkMfomKDLTJwyayChnyA/6bhsdcby/XA9n9MGeI/ScD1XtWltByy
         /ThA==
X-Forwarded-Encrypted: i=1; AJvYcCWjnjoPsCZtlW0Qoe7DC5M/T/XPEB9WZHRhRxblMhkh522gtPANwUdoDAk0DgizwoJuJm1pniBmxI2IXQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm+n6w83yXpXcaBY4H3qWLBbB3ctscIHu5Z5T1ZQMBO4jkopu
	xaEj0/S95R5NUHT0At26PCQsrY+IUNvO65aEM6gg4ni0FWOn43WeZJcbnxhAOe4=
X-Google-Smtp-Source: AGHT+IG7LsDitpApvLyICxw9texFBC0bExcUWUKBd3AdgrIkrscJOpeviiSnfe3TSFgFifCYaGCNeQ==
X-Received: by 2002:a05:6512:3b29:b0:536:55ae:7458 with SMTP id 2adb3069b0e04-536ac32e514mr2367040e87.40.1726849281394;
        Fri, 20 Sep 2024 09:21:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704ddb2sm2236913e87.104.2024.09.20.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:21:19 -0700 (PDT)
Date: Fri, 20 Sep 2024 19:21:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: quic_abhinavk@quicinc.com, robdclark@gmail.com, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] drm/msm: Remove unneeded semicolon
Message-ID: <qmjo32urtf4ftcjggyr3z4dr2alwiiw5si52lwvwz5vxpr22bf@bkrnk6oafagz>
References: <20240918023357.59399-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918023357.59399-1-yang.lee@linux.alibaba.com>

On Wed, Sep 18, 2024 at 10:33:57AM GMT, Yang Li wrote:
> ./drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c:282:2-3: Unneeded semicolon
> 
> This patch removes an unneeded semicolon after a switch statement in the 
> pll_get_post_div function. Adding a semicolon after a switch statement is 
> unnecessary and can lead to confusion in the code structure.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9852
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

