Return-Path: <linux-kernel+bounces-555084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C1AA5A54A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2429A173203
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B61DF269;
	Mon, 10 Mar 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yozNS0AA"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EC1DEFD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639844; cv=none; b=TmlNtjYuWVzHtMh3bYfRkXZ4tT5ftOBRM0OovStDX0anH8k/ivRwF36O+Y+s0sPtsyncSNCaQ0MUMhShIe6rVHA39OyCKIYtWHkW/kIgPdMrwDMYXlSL5CKVk/GzPMBYqjX98dBEGS/cl2cd/Wie0TDprKJ+UYspv0m333Jsf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639844; c=relaxed/simple;
	bh=JMgtmwqbCF1crKu5gvghokge0/ISSw0obFY1lBovTyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQNMhGJnQpO5wa6jp8qgoOfnvVw4qj0sqvewfvhm2SSU3K+BSLPUpt9Scx4I7/zcf8ud0YUBoYwIH6RGNYn4FDmj9EsvWucByrv40MiI29E5nMN7D/7pXgDKjrus8n76sc+SnIZPOXDaLSqq3XCM7ASU8wOcJX0j/W428PEHiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yozNS0AA; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30761be8fa8so52688021fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741639840; x=1742244640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFIKZkaTfjlzWSNll4lqXgpcQhLW3KQ5qFxK5aL+7cU=;
        b=yozNS0AAdIEjVRKmRYq7iQt7ql0F92g/RzUVKg5rNwW5S7at61dY6H6NjSRvDro9ft
         qEZLd1W8ERt5VtTiWaN4rmCI6htz+qnhZkPjXrQxMTtUGYFuHtsE8sStUbqxY3hEkWgh
         0K+Es1nB7jb8hrYlsDEzEfuZ3qQfSNyExxGx9V7pYOeIEZE0ck6D1PYbDP6iUGhOaOXt
         4DfUDwA/qN/P9i9WDENVyufUslPI7dTotxsM2sV7MB8qG8mFGQbihZLGJd1ZXWLRDp+5
         zqt/GuMvAG/SavSJiImq5lHMRAcr9cKOE6LPgl9vCRRAbLVqWI8JzDD/W/rfdBBQ1oIK
         wdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639840; x=1742244640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFIKZkaTfjlzWSNll4lqXgpcQhLW3KQ5qFxK5aL+7cU=;
        b=Yxj28YzG4c4mVvmcA82nk0/jfeF2cxTct227ORQE1wdHAYChbvJBkhx8EdYrtJtgLJ
         A2hNzKT2dLBYbd3pBLciSLtYn6rPg+CiPvJIXNItNivljPlemzb07QJeX9Qin4ChruVR
         /JuwvDIntFCdjNZgVLKGhZ9c8HTqSwmNioTBCFNGVidTzvZcbyGi8cTV30AqC0xk0Tf4
         4T+mHBm8fATlNI8DoXd0lvsfjbNrT5eSN5KqgxitE/ZcrAB6BWzMya9oD9Bze2VPHuo+
         pzFXlXSpNDyIf7Y3V338b8mQRzsbqKiO823/3/NDFubC/3uYujlkcB0D56GDhjzFrZcO
         b95A==
X-Forwarded-Encrypted: i=1; AJvYcCXcI5KN3s4iBHRKvxp0xJRbT4XzOd4MuyCWKKAc4QLA2vs06HD7F6rrKzujiqDa9qJ/Ud3wkRKF788FkVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfaqt09fOM178aYA809qbLOBvz0iX03NHbfkaL5DQVyitIyp71
	kSsD88dOVKSr5UnVPAHqiB/p/cgVb9+vj7EwZJiivwOL+pV+v9RTsq/nhh+52jY=
X-Gm-Gg: ASbGncuZ9xvZM5ljEdKABwclCjo4onLcRXEG99hIz4Lfp0UdYC3PmnFWxEo+x7XQXmy
	qOJBJzalWQQ0bVosfgWzaS7YLOAezt9pL72KLL4p7ALefQnqoaBu0xAKuiFiGw9ODYJVBxrJEeg
	5i/mTEegN+JUGUCUD7dINwio6YtXI68Hm1/Vc72f5z2wMJq6vbs5qDAEKmk+RXbAPKz5GY/B2rB
	69q2VCZIxFtcneFXUK6+gLEEh6wokDjfl0WvBceeinNuqly5Rc9LE2HdKQyAlcmr9UaQnV2F+Pw
	NS8+h/LpCOx+i5I0QrlB+HyxyBJoYMlRXQP9pBKvvf6HjIP4inx1AAECmjlLO13bcvCRka2a++C
	subvzokA4ySV4exzr9s0S0hry
X-Google-Smtp-Source: AGHT+IGcrlELrZBnhqzie4iDaP6avVfnzS9Zwuy/y5VMLk7WTqgSbAIjxpbHVS4pswFb2Tc4oA719A==
X-Received: by 2002:a2e:bc27:0:b0:30b:bb45:6616 with SMTP id 38308e7fff4ca-30bf45e2500mr50729081fa.29.1741639839816;
        Mon, 10 Mar 2025 13:50:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ff85e23sm1362140e87.225.2025.03.10.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:50:38 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:50:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, dianders@chromium.org, 
	sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/13] drm/bridge: analogix_dp: Add support for
 &drm_dp_aux.wait_hpd_asserted()
Message-ID: <gnwqnapqlc7bym2nd55oif5lxxiibeme22upepbrgafilpcxxn@py5j7ju4rac3>
References: <20250310104114.2608063-1-damon.ding@rock-chips.com>
 <20250310104114.2608063-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310104114.2608063-8-damon.ding@rock-chips.com>

On Mon, Mar 10, 2025 at 06:41:08PM +0800, Damon Ding wrote:
> Add analogix_dpaux_wait_hpd_asserted() to help confirm the HPD state
> before doing AUX transfers.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

