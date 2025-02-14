Return-Path: <linux-kernel+bounces-515138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92FA360BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A0C3B128E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71269266581;
	Fri, 14 Feb 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="DyahSG8c"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0A26657D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544250; cv=none; b=KR45kdZSJb7BCVkJWSg8G1j1paFFsnHs3QhXHUevhghuUCO4oqT2vepLt4ke38TNFLob0RQLZaSYXevTCDeGDFj6DURG6R6dbj1uQB51LYTdwy8f4Sm+zCiVsNOpD7u5Rakcjgu4Eyq5oCFxk4x/QNgExRLYnJoRb2iRCX4XgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544250; c=relaxed/simple;
	bh=8f5lrx62gvWJsh/0RZ7tW7S9t8HtzyILj67RPVtwncA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCWuF3KY/Us/VkJt/idj9vXzv0nG7AxyAPUNeMO8l5hB81YlfnXZiqSuzfuZxl38HzU0ilKq+gvWXAyuKkUbhu0HbxpuhbfMWSfEjcz9VlC1/KkjfIGPJ2nzfd73CXv7JeAsE8Rp61WzpJ2VRcrQz7XcD7VNUD2LY5K6FxDOiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=DyahSG8c; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46fa7678ef3so22153801cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1739544247; x=1740149047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nm64wAClFiNYBGaeXW+Jy+0YKStQf2pFqHFb57LVGyg=;
        b=DyahSG8c167q3JiIMjNst5He36olai7P7QQUVjjUP/qjZ/qkw6o/3IV6Hg+AYkHbuB
         HHYJJGvJChGI6EpNhRKf0h4nnFXyAn+1AV+hBswMJxaXCZQnIRig+QZZtaM0YlU0iNwG
         ZCBEhPC4lPG8YjdBmoZOy7WHWoeQFEmZa3ZXPR2R0/XygqUlsKKtZJ7p1aU8vtTvQGGR
         oaE1xEilYRT8hOYdMytqREgYGYPQCVmIpqcTB1Qp5HojDAgvlaRTdAlHNPlfn975RBit
         8Q6sRchjYGApbqcKxGJrklTGWdVKW6v7Jso9e4ICBPZ9XO620lB4MqZGfu5IhM0D7tmD
         774Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544247; x=1740149047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm64wAClFiNYBGaeXW+Jy+0YKStQf2pFqHFb57LVGyg=;
        b=GXhi67VX8d869NRQxbR+64Y7SW6ebWgX9I3XVY2trWqzuO35CBucz6IGc+fS5bkig8
         cOpbYnRedh9WklhvJnubgMZAbZDaXe0hG4173T5FJBxJh1yr+Hl2NRHAHwHaoJ0gsM5F
         QSDncGX69N4VoLzdaV6Rj8mdDItZxJFJA2KFM/9CEwze4xqw+9afzjxuRYs7mYm4CzAP
         EqSV2Q9PFdc/j1umeMoMlv/smaf/Sie/mPUIsT1qny3LFba7kW8dMPr3YdY9At+fg02c
         uCkY0RZKaN6fz55ya0J9HwarKNOetKBLVN8eWI7BGwfHP8UG9tyMUs+0+J7eI3SJKlfD
         /LaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU5SjVXGD8EN8/IS3bh2zRHupdhSDHAZ7dV63WfxZxYpAM7wbp0psN8vEhdq3Q8zWVOdunG1kiLAFiZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHf+22JAR1gg0fylkRsip4MjBWFvGMtgNFjVZydoEB2h0mITp
	Sr5bSCg2LSzG7ZgosEz9ke3SAggAtkeyONA7tfqhaFAnTyWEaIh4fcSlZtwwOw0=
X-Gm-Gg: ASbGnctT6HBI+lyza3fFV/X98oWocsqOEfXEw9LaJ8Kv+ju4hVGx6uVz0zTHJL8YzOc
	UtNeYlIs21A9km3n9uC2DjXiiWTBvMLKD12vZfax5WWtWDaxNXcmlmHBdB9lsFZffAR68O1BzbV
	COdrR5M/jhNfzb1Efva7L53t51lUtrFkDYUmo2/E7GBtclxyXaLmSWL4r2kq+CCXNqSdSlQt7sr
	Vh4jebO2L81EFWwdfxNKY0pX8BIM7XxaP5cldolFcrx00gq28dfwgT7oX/+EcipvVKGOWnnLJdu
	wJieA2rX2s1rVvnEIInX
X-Google-Smtp-Source: AGHT+IGzD4tmaFdbKPAgw8y2G/S9CPB1VEBNfWCQGlYkIlxfwiitQKsGVA2pbWLHph9B27cyYKMs8Q==
X-Received: by 2002:ac8:7fcd:0:b0:471:a7cc:8106 with SMTP id d75a77b69052e-471afe31a4bmr179507901cf.20.1739544246639;
        Fri, 14 Feb 2025 06:44:06 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::5ac? ([2606:6d00:11:e976::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b06002sm18172461cf.77.2025.02.14.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:44:06 -0800 (PST)
Message-ID: <aae670db21a1de622cc89ac637c407bf6452c44f.camel@ndufresne.ca>
Subject: Re: [PATCH] media: imx335: Set vblank immediately
From: nicolas@ndufresne.ca
To: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com, Sakari Ailus
 <sakari.ailus@linux.intel.com>,  Mauro Carvalho Chehab	
 <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Fri, 14 Feb 2025 09:44:05 -0500
In-Reply-To: <20250214133709.1290585-1-paul.elder@ideasonboard.com>
References: <20250214133709.1290585-1-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le vendredi 14 f=C3=A9vrier 2025 =C3=A0 22:37 +0900, Paul Elder a =C3=A9cri=
t=C2=A0:
> When the vblank v4l2 control is set, it does not get written to the
> hardware immediately. It only gets updated when exposure is set.
> Change
> the behavior such that the vblank is written immediately when the
> control is set.

Not my field of competence, but won't this cause a flicker ?

Nicolas

>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> =C2=A0drivers/media/i2c/imx335.c | 19 +++++++++++++------
> =C2=A01 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index fcfd1d851bd4..e73a23bbbc89 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -559,12 +559,12 @@ static int imx335_set_ctrl(struct v4l2_ctrl
> *ctrl)
> =C2=A0			imx335->vblank,
> =C2=A0			imx335->vblank + imx335->cur_mode->height);
> =C2=A0
> -		return __v4l2_ctrl_modify_range(imx335->exp_ctrl,
> -						IMX335_EXPOSURE_MIN,
> -						imx335->vblank +
> -						imx335->cur_mode-
> >height -
> -
> 						IMX335_EXPOSURE_OFFSET,
> -						1,
> IMX335_EXPOSURE_DEFAULT);
> +		 __v4l2_ctrl_modify_range(imx335->exp_ctrl,
> +					=C2=A0 IMX335_EXPOSURE_MIN,
> +					=C2=A0 imx335->vblank +
> +					=C2=A0 imx335->cur_mode->height -
> +					=C2=A0 IMX335_EXPOSURE_OFFSET,
> +					=C2=A0 1,
> IMX335_EXPOSURE_DEFAULT);
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> @@ -575,6 +575,13 @@ static int imx335_set_ctrl(struct v4l2_ctrl
> *ctrl)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	switch (ctrl->id) {
> +	case V4L2_CID_VBLANK:
> +		exposure =3D imx335->exp_ctrl->val;
> +		analog_gain =3D imx335->again_ctrl->val;
> +
> +		ret =3D imx335_update_exp_gain(imx335, exposure,
> analog_gain);
> +
> +		break;
> =C2=A0	case V4L2_CID_EXPOSURE:
> =C2=A0		exposure =3D ctrl->val;
> =C2=A0		analog_gain =3D imx335->again_ctrl->val;


