Return-Path: <linux-kernel+bounces-449086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC99F4995
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ED61881C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9161E883E;
	Tue, 17 Dec 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp8iozYX"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4213CFB6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433673; cv=none; b=aZvf7IsRXnmuugCueTygnELW4bsfGba6EKrhbXzPRMxxkvgSIikvRh9FK5CWhqM5EvacyYKgKEjcyM7ATS9WFTrx02fmFESKyDRspK/Zrv/2KPEVlG1Z2VoKTKq/yv4ifzHGbZHC2Dt3+TtGs3SqjRr3OASxJcX8aLNuMNAav44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433673; c=relaxed/simple;
	bh=9xMb13ehIBFD0OjFa8STg0scG8DNPG3wbZxfM1/1jmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i08ibzOFcLVjyMdajy1TIQQVyfhcKdCfupCCx6Z4/j04loPAfM91idqPz0zUnGG2dAhzwJzH8XSyx5Dm5Hwz0pqToWe83NHpFGQV031g1gBAIM4GQOJRZhINgpjHXfVVSt2vnxt5XenMZGneX8tUCsL5SyG2yIPpUoKkHoxrjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pp8iozYX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df6322ea7so7037442e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734433670; x=1735038470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYia6bkOtOvm8zyMUkFTLmAVFFk1rfM5TLia+8wKurw=;
        b=Pp8iozYXzN84zloMHejnDJ7x/ABHWYB1T97UgaxiaL8NulZ2UcaL+WGJwZsTJXErwT
         mBoKYOKOi1s2uaCEdtpHsJJEd42u6HUOae3awIrO3ihKplfmRUA452ZH2Vo9McCJ7fLL
         +ODIlNJ0z8vM8McL+FILiOgGIKC+o9YffB9l/zJGws4Bea9DyaZky8N6J7V+uwNKpppq
         0X12O8JkrvjQ5ge5c0u8nojFB9t9xcaYnp+OFRWHfJWNVguIaifN7pwSjVMo8X4QSFTp
         7AUanEwST3wF2vOr1JeGY9tao5cNlXC4ZtXEbqv1u73yG5sDe2/7oJQYpX4/KoICZsxi
         cQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734433670; x=1735038470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYia6bkOtOvm8zyMUkFTLmAVFFk1rfM5TLia+8wKurw=;
        b=aBvaHCZ0mW/KS5NGKO+SjcoC9MbpKXufNc+oYF6nYrh+EuwFvNs2K7RNcZOJLid69K
         UQzhCXBe2r463mwGo8eQG6u6R46AyIpuS0Z+lkkuHZhJiVtdAkXM2P1pOXe9YMCMG4pT
         +GZ3dMJlXTSRoav5tylJOz0dBST6gzQm/PJ6y0qDd2y+d5DwMcvWTfTEUK5A5O6zA+Sd
         5IEdRl4knBnCvUWubmxfQ/JK6D4XTA8cmDsDFHepa/C/wffQiAFZMGAUlrh441F+W4fQ
         qkhGx3ranG3KCFAnSieCH1S9/8QchuP7dFBKvMMHjDmWeVByNzE+ZY08yX+x95E3Znpy
         FvgA==
X-Forwarded-Encrypted: i=1; AJvYcCVrWc5c0FCpAeub6bTVr7/TwgDX0Ce6s2+dU1GpVfW6DFrSGkKcREG3Yi+uN/21ZTz1TPWRES+lq+iaAgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lV4eiybJ0fyE3SswvSgt+gN708hlnbrllcXOQ/7+350m+Xg7
	nKCsNO8rrOSRn9i5sOADMdOymyU3yIajtx83Ue38kpdBMn585Yk6l8G9wPTRbjU=
X-Gm-Gg: ASbGncsAM9v7ruthxGWNOWXEB7rKygJRUe/N8OTw6pk+Mt5TiMWIZCOWQQI63+BgD2n
	0eogUKkcwzJEWzkH1pyxQ9Nz24CFPRT6g9+EYDozvEbYB1Ak7LiOjH3fQpwLQs2Bb/tPLl/G2Op
	ojLkKEJfdJCQBmAfltqeKQKrpIm9P7INKvvLIVb6jPjHfNw6HCHf6AZjbTf0VZ9tyFLhtbXy/W/
	h8dArPjksI7ENbCg5aDeKdF5Mn/Y9RiN4olR7iQWI7zUpqBaFW/C6JnYsbDk8XmoD7clYbbHG1L
	PacjUGd80mMnwDBLFQ4ldKj2o6sMpGWR5K8Z
X-Google-Smtp-Source: AGHT+IF9wRRafyTuXG62lAlU9PV2hBrxozyuUj5pTu0s/yHqf/P45mfDC//C58CWkkxQbTLd1cCzgA==
X-Received: by 2002:a05:6512:4012:b0:53f:22f5:afdb with SMTP id 2adb3069b0e04-540905958a8mr5350614e87.35.1734433669649;
        Tue, 17 Dec 2024 03:07:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9db5sm1122725e87.88.2024.12.17.03.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:07:48 -0800 (PST)
Date: Tue, 17 Dec 2024 13:07:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v20 2/9] drm: bridge: cadence: Update mhdp8546 mailbox
 access functions
Message-ID: <z4cmwy6vh6nncq445hvm23n4ar4quciemvcj5zvofevulyofx6@w266vucwqv7s>
References: <cover.1734340233.git.Sandor.yu@nxp.com>
 <74bc3f2ff56348afd9d773589236ddf06dc3d45c.1734340233.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74bc3f2ff56348afd9d773589236ddf06dc3d45c.1734340233.git.Sandor.yu@nxp.com>

On Tue, Dec 17, 2024 at 02:51:44PM +0800, Sandor Yu wrote:
> Basic mailbox access functions are removed, they are replaced by
> mailbox helper functions:
> - cdns_mhdp_mailbox_send()
> - cdns_mhdp_mailbox_send_recv()
> - cdns_mhdp_mailbox_send_recv_multi()
> - cdns_mhdp_secure_mailbox_send()
> - cdns_mhdp_secure_mailbox_send_recv()
> - cdns_mhdp_secure_mailbox_send_recv_multi()
> 
> All MHDP commands that need to be passed through the mailbox
> have been rewritten using these new helper functions.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v19->v20:
> - remove mhdp helper functions from the patch.
> 
> v18->v19:
> - Use guard(mutex)
> - Add kerneldocs for all new APIs.
> - Detail comments for mailbox access specific case.
> - Remove cdns_mhdp_dp_reg_write() because it is not needed by driver now.
> 
> v17->v18:
> - Create three ordinary mailbox access APIs
>     cdns_mhdp_mailbox_send
>     cdns_mhdp_mailbox_send_recv
>     cdns_mhdp_mailbox_send_recv_multi
> - Create three secure mailbox access APIs
>     cdns_mhdp_secure_mailbox_send
>     cdns_mhdp_secure_mailbox_send_recv
>     cdns_mhdp_secure_mailbox_send_recv_multi
> - MHDP8546 DP and HDCP commands that need access mailbox are rewrited
>   with above 6 API functions.
> 
> v16->v17:
> - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
> 
> v12->v16:
>  *No change.
> 
>  drivers/gpu/drm/bridge/cadence/Kconfig        |   1 +
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 487 +++---------------
>  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  47 +-
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   | 212 +-------
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.h   |  18 +-
>  5 files changed, 104 insertions(+), 661 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

