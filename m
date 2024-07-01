Return-Path: <linux-kernel+bounces-236944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401591E8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D567A283F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391FA16FF44;
	Mon,  1 Jul 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUyt9Owt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93F16F8E3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863537; cv=none; b=Lux/i8aQhnY92d9O5zUKxzIkDT6k8TkQinjSHyK4J+8PY7TwUEtbfqOkdH0WnTXt32+Id1Y3fjhn0boW9ewxktnD7in8BcMzW+HvgBhp31py2NCHD2X4QPdkkNyEonu4wdquk31XNu1PWHdjkRjZ1S3gIF8P3dk9lcCNGFYPUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863537; c=relaxed/simple;
	bh=H8delFYIAEjO+ZiSHwr9JeJ8MSblaIUUh8iXOXAfrOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUuKiim2iaZQL7BPjLJIpRz/JAsK5fmOr2NTvHUqC+uK9FlEQcpaRdylbpHLuZz7yc+uP01X/tz7XFjWJsDWj7ceIvsBqGHHYBsLkQ+KydPlXFMW7zVQZCAvcMBdICfUCf7L/0woJD+aeN2+aBZfDDFUbUb10n7dqT8AximGaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUyt9Owt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e7693c369so4509024e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719863534; x=1720468334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRHUkoGwpjNf6W9qmppc9hQKHNt+zygF+l53pGcNu58=;
        b=OUyt9OwtmL/2wdV2pmTB+YajlTimlcuW5/JAHYR0SP+gPc6uyaIr/WLRDhenyYxTXQ
         r3npugV59vWn4rN/Gm6ybycHZoiHwtInX/DSpIGDH4lijcIWnmk81AnM41xv0mpVi4mX
         CHFJYnBRk57dzJgRDXcSasUEO4RoKUJLIFuzVH/hD0LHdcUo2xssfaiAcTZJ2v2bh8nV
         b+4JUTuMI5DfTolcjat3cC9HssVmBMJU/cjsnnuhQaTgmyCL9MvuGyBk6ssyB5yIqJol
         1fI+IB/3+GyfOa1jZ228LTtsyMN5Lib6PObRiUBXJC9aQVI9Lrv3Kz01zp7nJBAuoCp6
         txGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863534; x=1720468334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRHUkoGwpjNf6W9qmppc9hQKHNt+zygF+l53pGcNu58=;
        b=Jdi+HxW5TOi1Zu8G0XfGEMEw7brlB1mjGmqrpRYDYELpPZmURqomzeBS7GzTijpJtG
         Fs1dGc6MCw3Iguc/54vjQXTnv7BwUi+8mIke0Zak+hLTc49ucS/7Q5LJGNeNMUTtyxdw
         JpldGLnCWCpcCEo5sEZ+vToSOFEI+36ZWwl8Xi2rE6HQAEeUz4EDzjxoAMHXTLpdEhHg
         5K4z8OhKjnc2JVGbRquYVA2UYUpsSy0nOP4T1iFZc5dhDd+vda5Y9Mv+ePrbqHvB6V5g
         RonbEYDEkvbEYPl4+2JwKjHJ8rHK3S24M3hT0oKtLwIVP6sR5S0ghp9r4soqO5lR8I7o
         2TFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGIY+ZYoTxUuF/vccHRJUhlBa+QAowoFmL1gUryKe/tJwW2TAYtwpesntAIFzfWatKArd8nbykcKl65h9OzMXHf87y8c69OBK3fOf/
X-Gm-Message-State: AOJu0YzVN8WAx+vic+Z2r8TTTzCAOtB04z5bq7f30yLE/OEjh+WTivcd
	0o2SjtosyIFY+H8vQJgVa60pHNM0dJVQLXVzo/NxaYBpnUP0UEyB7eFQw6VANYU=
X-Google-Smtp-Source: AGHT+IGpZG78DLYt7UtXr9ZQfMpLzTwgkoAHEXhLyaBaZvfF5SxznHfPGIkjInmqLnX5xJ/9v+HutA==
X-Received: by 2002:a05:6512:2397:b0:52c:dfe1:44ea with SMTP id 2adb3069b0e04-52e82643c41mr5319588e87.6.1719863533890;
        Mon, 01 Jul 2024 12:52:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2ea60sm1522272e87.218.2024.07.01.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:52:13 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:52:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, swboyd@chromium.org, dianders@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/msm/iommu: introduce msm_iommu_disp_new() for
 msm_kms
Message-ID: <b4kskldnis3m724kq6kpvqx4pnnjditxwy2jiiivkieqt25o6w@aj6ybxbvwq3t>
References: <20240628214848.4075651-1-quic_abhinavk@quicinc.com>
 <20240628214848.4075651-4-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628214848.4075651-4-quic_abhinavk@quicinc.com>

On Fri, Jun 28, 2024 at 02:48:45PM GMT, Abhinav Kumar wrote:
> Introduce a new API msm_iommu_disp_new() for display use-cases.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 26 ++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_mmu.h   |  1 +
>  2 files changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

