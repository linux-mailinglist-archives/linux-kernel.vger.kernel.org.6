Return-Path: <linux-kernel+bounces-384521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A79B2B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335261F2206A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DC1B0F3B;
	Mon, 28 Oct 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSsv9zo+"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECC8472
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107254; cv=none; b=G34L6xwCExxGsjVfl+hsZex1V3+zVueHoxntHJ0fCJ8OxnFa+uu1mkDQIBVHaQxVTE4CUxNYv6ubTzaU8VWfEHtxu19vHsgAVVNfQ5GU2K5fbWUNvC2MGU78bHcpt0jyoUVRd6quHXnXKgB+yD1JaOtyrnTM0ho3xtBwW/oeBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107254; c=relaxed/simple;
	bh=j9Yh3zrZUalX47mvMkgSXxAy2RuDtztZjtjGaLcmm+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv3cfglFm13w09XTDssgz7NI8++meYyUCW55tjA6lqgtc62TQjvd1R4yJ8dXO3scHkTigxMtskPoo7KtI4VIBIF81xqeol25rFuOa6VWmqML4k3ltdI7l5nkqNoX/bmgC/LbgoKS2WWnc8DpooADZxIB8q125Md4Nuq/2biwXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSsv9zo+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso35460571fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730107249; x=1730712049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPBuezFB3CXtTW5/lJNTKguPGRqG+lEFtQVwqgqjd4Q=;
        b=CSsv9zo+gjH62jHqC3592QZ17YJnAzndEYS8uph/04F3pRwA2p+oapcIwPvIAuU/Vq
         VSWiKLahxAdQyYrAbAtpynZuKOy3b6Pl9sAadhl040qjvdjQ/bsR8dMLae1LUZjLZdgJ
         R1G1jRv+2r5uoRn8+hf3XukCqddY3W36/hn2G6KZCZPA0yw9Dc46Rck1swcFxwquE4Jr
         ZaDJD4S2eG3/ryRnB5GmgcBkbaD2n8ZEPcj4bgvVdoPR2OMFpTYi+Z82F2hEAt3w5LK2
         lhNg8N3ijlkhdMC6BEIujMLWrp/oCEoLPD68vuFgSbS/IcNUOQymj+UfnDM380K7nsAK
         OENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107249; x=1730712049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPBuezFB3CXtTW5/lJNTKguPGRqG+lEFtQVwqgqjd4Q=;
        b=YxQLmaUA7YefwTN1aC7tlWRe2A5Kb3tS5GoCoPElAaw2PIY7r2FawaOAbF2NttCqrV
         txcAvsp3Sk1ZxT9/sLLzlYzd4561NcNG1gGv9rTsp1GwvFxZzC+GJ1ZklsMB31Zc0pRx
         /MSS8eNdHQC0d41PGwaCnZX/fi8fzOlEfX+TaekGebRDrY8wqjzfrXHrk87y3Nuz3SGh
         jL8QnAwCxGEtkBesvHzYf5jk/i7qN/HZ1ntAK20iMg8mzJO1hePjKkY7UCv4ZGf3nP6r
         jB7VqRqBNPTqwFJdZ4+nf7Oof7wELYDXfKJpPA6OFSXXMH3iNm0lOCvUKscRwe+gdsfe
         zmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR2qrcCatltELoAis6lCWsQ5re1lrjcUjJvzRW04ubKqbvuWgEmWvqTALxYsNxRBAeoY7VVaZmShiSK1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqjUtoXB+UpEC1tW3ZdjQ7PVPGWSW/coj7/o4dJxEVqYe2Jzn
	H7cPwUutiPeNQU/HBFEdfOUqq27ZmtTD33YJuyX7zxR3OYYGKmomgyBR94H4cA0=
X-Google-Smtp-Source: AGHT+IHMzC2RrBK1gDyjb7BDtN9UQMSMyOUaimH3SDT8yHY0Jieo0+u5sTv3iUOAiXJhLKZA5AAPKQ==
X-Received: by 2002:a2e:bea0:0:b0:2fb:5014:c941 with SMTP id 38308e7fff4ca-2fcbdf71340mr25188781fa.14.1730107249435;
        Mon, 28 Oct 2024 02:20:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507c44sm11199391fa.19.2024.10.28.02.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:20:47 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:20:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_jesszhan@quicinc.com, 
	mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	sakari.ailus@linux.intel.com, hverkuil@xs4all.nl, tomi.valkeinen@ideasonboard.com, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de, nfraprado@collabora.com, 
	thierry.reding@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com, sam@ravnborg.org, 
	marex@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v4 10/13] drm/bridge: Add ITE IT6263 LVDS to HDMI
 converter
Message-ID: <tjtbvn5ewlzs6wqkp2ffquiiebakhv2eg3vt4mzooeb6nibx4u@qhwx4hxvj6ou>
References: <20241028023740.19732-1-victor.liu@nxp.com>
 <20241028023740.19732-11-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028023740.19732-11-victor.liu@nxp.com>

On Mon, Oct 28, 2024 at 10:37:37AM +0800, Liu Ying wrote:
> Add basic HDMI video output support. Currently, only RGB888 output
> pixel format is supported.  At the LVDS input side, the driver
> supports single LVDS link and dual LVDS links with "jeida-24" LVDS
> mapping.
> 
> Product link:
> https://www.ite.com.tw/en/product/cate1/IT6263
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

