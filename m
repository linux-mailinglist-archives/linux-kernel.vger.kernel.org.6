Return-Path: <linux-kernel+bounces-169377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA23E8BC7D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00557B20D54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1A524AE;
	Mon,  6 May 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5/L5I2G"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916D50263
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978179; cv=none; b=S5C1dtTIh/o7Hd+RCKw54kEJUnd2mFZCmZatETetCrglFIJLNw4rVIa/YA01ZsjdYHKyYpMZ2+KsBXMj1Ba8IGqLA/0Dinb6n1cB4bel8e+OKOo1G4Vj/WzpQE7hlkTjxfo392R6+YcLwoY9Q9mNnznyb8vdGJiBlsynt83Xj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978179; c=relaxed/simple;
	bh=mnMA7ErfNqKPuWteFTyprk6+lWU7AKOkz4CgphnWuMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iejzmL4qgolwAF1D7MS+eu87mNX1ZVcMovbFwuaKFwfZVPFZGXavlhS8uuvE2+i4gvQ3u+iRXbwgyjtw/gseEqL6aPuoYpNGVtRyxmprO8GA//3dcvTRUk73aYhoA6mqoj62XO8uF6mb2XNNRuLvum+ytDB3OEk6ZOrUmI0eb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N5/L5I2G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ae4743d36so14893217b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714978176; x=1715582976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMA7ErfNqKPuWteFTyprk6+lWU7AKOkz4CgphnWuMk=;
        b=N5/L5I2GllA0Dh7PMn2QV5Iq4E5wNzZOujpo1zUQBHfJ5Uay94xJVaS2MwY3TGPexq
         bbKS4B/oAB4ZoQ1+FZ8sZ/Umh2OESCS+Db17QK9KyACU+pqaSyk74uuDFLbQuGNGVwJK
         DAseDjySFQE0iMzbXBDIonXFfvDyBlMMxLfKugpqA42Upomc/G6VHPaWklPG0MkyE77v
         PBm39Nv/w4SsG6/xT5ptHAO5OZMH5Fgp7TXnDr34dxiaVh0pESy8dd0CksTClWeryHZ7
         JXZtB8CncKk4y+p0Zk7bRo+HnfncJpPtzfQmdA6wVbKcxdZZxWzkx0AuDELywTyA4aGO
         M5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978176; x=1715582976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnMA7ErfNqKPuWteFTyprk6+lWU7AKOkz4CgphnWuMk=;
        b=Zo/op3bl0vWzYYXOYF2KCP5Rf+8UH6Vdo9jjxA/gYX2I2aeS34RzO//Eoq3szg/yoN
         EjcKXv4gm4qX5bioWIH39sJeczMyZPWtrO2t4ClHVTR6rE8HNCyWnMB6b0idhPCe6XPN
         hUWKKDS3ZL7T1BMZ6oCOu84nuYdqNveFUOZjBsS2S7R12pjLTyh2a58U1FtCulYiEelf
         AtSrZQtXztxPQs08oWmwoFBVRVowZmcG4i5MU4MKPVJIgKB/K8TuqAn1ss7bDCB7kv0i
         wzOkhM47f0tzJTtTzi+kPMwEHfGCgS0NEdK89BpswVc+HCiDt1Qx/tCztrg45yUTO/VA
         uaEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7rWfutE3Vox7hIRcn7MPXzCrXKIyma1Pv+PiMc6zw2JtGDol//Gq17kEZ+5EWz6NzLyJZEvht3Ny19E2xyYnXI4x3KWyXwIewfxQQ
X-Gm-Message-State: AOJu0YzWyuP9ERKjQ5n/Bzhx005+zN6t7duRz2v0HYDX35c5PvjMInFW
	gRyZH3533lpTI/fcfxdY/oKI17bFBfX+DcP1SueTt1oIRdwLE9WnsrFEdlBYZymcRVhXQ4BCkUt
	yNXc7Mcvt92BTx9q34qi++Ba4pft7UaFnD1Me5g==
X-Google-Smtp-Source: AGHT+IH0hH3+COymJPJl26UVpAMkDQL0eTyMe4aTaoCJoKbhPlu+pDGsv3OMsBrEFsgQa8L3URT8RtIK4gzEII6Co0U=
X-Received: by 2002:a81:8443:0:b0:615:1e68:9080 with SMTP id
 u64-20020a818443000000b006151e689080mr8502525ywf.26.1714978176344; Sun, 05
 May 2024 23:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503213441.177109-1-dianders@chromium.org> <20240503143327.RFT.v2.47.I2513fd6824929a17c1ccd18a797b98a1a1063559@changeid>
In-Reply-To: <20240503143327.RFT.v2.47.I2513fd6824929a17c1ccd18a797b98a1a1063559@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:49:25 +0200
Message-ID: <CACRpkdZgvHRb=KGUskiu5+=R=05yMQ_gqZ+ScP2oLpf6DibSfA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 47/48] drm/panel: sony-acx565akm: Don't call
 disable at remove
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:38=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:

> It's the responsibility of a correctly written DRM modeset driver to
> call drm_atomic_helper_shutdown() at shutdown time and that should be
> disabling / unpreparing the panel if needed. Panel drivers shouldn't
> be calling these functions themselves.
>
> A recent effort was made to fix as many DRM modeset drivers as
> possible [1] [2] [3] and most drivers are fixed now.
>
> A grep through mainline for compatible strings used by this driver
> indicates that it is used by TI OMAP boards. The TI OMAP driver
> appears to be correctly calling drm_atomic_helper_shutdown() so we can
> remove the calls.
>
> [1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.o=
rg
> [2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.o=
rg
> [3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.=
org
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

