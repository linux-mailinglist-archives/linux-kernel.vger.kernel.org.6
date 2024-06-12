Return-Path: <linux-kernel+bounces-211937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA390591E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334D0B21C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49CF181BAE;
	Wed, 12 Jun 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nb+He5Vi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E29180A91
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210844; cv=none; b=b01F+18EFB01Hc0leCmO5muge9v5njm5WATao7wFsg80DY+wWYkPrrwEjUvXVC15NqjZRIiPnsUykqNLkIFBV+mJerB3mHezs+1w9uutVB2RMVuOyFdGWyo2qRr6fy2pAwR5XM3Z0+s8nCJnlRlLh1FYAJtsfFeumWPg8ooGadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210844; c=relaxed/simple;
	bh=hyKQtIaovCsyWP0csv+18LsQLrk2+qXO3sWeddnPol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnRST1WJ4NtO33AG2M+ltWUSfyrVc/Z8MHKLwUn+iDWxZpH8bs9j6y4ALNfLwGguNzW+iLGu+wXIHm44GxOQPM8vRKORxM2qStc+4UdAudeZG/BG/w/gT0yTgaSPu4NO/H7RLi9aOvlqmIFlDXCc/TljKzYgQf1xa5P8TrfJY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nb+He5Vi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so78306071fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718210841; x=1718815641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyKQtIaovCsyWP0csv+18LsQLrk2+qXO3sWeddnPol0=;
        b=nb+He5ViKRQPWtN4koGSbYLItQKMtgGohZnnEDSrcz8AuP7llnKdd4rC0d5Aijz3GW
         9VV1zgtMH/1ryvtGEqMJHUo3OMBTDwLzZvugQoYArnQcwM49/byPQSDmOy4MFxtoMqtx
         EYOX7wHfF87udhakjobKLfEk292Dy0uUFfZU+KyS/JkYR6FTV2Iz5RRfkmk3AKJLl+/I
         D8iw03x+p0rQCb1t571zE8jjtCusCtR1ZArBnwZ3HFCjpmAmRa4LoM4+kVrUvQct72O9
         whAXZnB8POkLdphPi2XmW0ZnTWTVQpqRet2/arOBNksf14SXPLMjpvULA40g7V97/O3Z
         GrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210841; x=1718815641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyKQtIaovCsyWP0csv+18LsQLrk2+qXO3sWeddnPol0=;
        b=RUaM9O/F2XxZPSOUy+LJjDFt+0jZRG3TAO3DyHhwiDu8PBvM/HeFL5n7u6UDT0mpHt
         m7OIztow6owUTfMjiwZozX4jq5LjtK2TX5Qu70oAf3lm/x8XT20nvzy5oJ4sxzuJSzoE
         uWUMCxo5LZebnypZwZroco1uVyNlDdOfqKv5G33hsJmFKmH6d88Nf0/Nt5A1ayImJ/N9
         +wEgTcRjRSJwCNAyVqeVzwBhytuhqb/WX2Eban2E8hXblsvydKgAAR34BTEbPjX0pf+p
         Z7Oo2vR9Lx6B33AMlq2uLWIP0hlDq1hPZFWuiZpE3vJPwLkAq7IoOAyJuK8jEyjWk42E
         xZyA==
X-Forwarded-Encrypted: i=1; AJvYcCWM536X4Svpj6bVYsY6tsUWCUeNXA5+ILcAguzkJISm+dIWKRoc3+vStx4kyRCu8S3XFDqcCfsVFc2wB8kMZoKpA3Qgf5cxRjyXn3j1
X-Gm-Message-State: AOJu0Yzfxf9sX9s3WeuylLPWb2ZO+7PXKgX+6qnXvjjt8PsaJoc1QtJ0
	DDP2xgAAvoFqJ5PkqhAuHpwRNLOV16R1E1ZN9wMtkaot5/dGvjUOlN5vs1GjV3JT6vFKnZcsCJw
	7shAWqTGRgPUgYXLEC/47U/QqmsfPRXczj5GDFQ==
X-Google-Smtp-Source: AGHT+IHMP8dO9EgYj2+c10cSwpzq5LekVKeJ/dr2+gpREr1d4TFmdi9vMnJ3hrKJcJk2Qa5Pqef401wHss6CfxSsILk=
X-Received: by 2002:a19:431c:0:b0:52c:845e:3194 with SMTP id
 2adb3069b0e04-52c9a3d8b80mr1283565e87.29.1718210841311; Wed, 12 Jun 2024
 09:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local>
In-Reply-To: <Zmm6i6iQOdP613w3@phenom.ffwll.local>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2024 18:47:10 +0200
Message-ID: <CACRpkdbb5OdizDLSRW3bFEJJhrQ7Fs8Pb=Q2yxBog62Z1m-bOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:11=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wro=
te:
> On Wed, Jun 12, 2024 at 07:49:31AM -0700, Doug Anderson wrote:
(...)
> > The problem is that the ordering is wrong, I think. Even if the OS was
> > calling driver shutdown functions in the perfect order (which I'm not
> > convinced about since panels aren't always child "struct device"s of
> > the DRM device), the OS should be calling panel shutdown _before_
> > shutting down the DRM device. That means that with your suggestion:
> >
> > 1. Shutdown starts and panel is on.
> >
> > 2. OS calls panel shutdown call, which prints warnings because panel
> > is still on.
> >
> > 3. OS calls DRM driver shutdown call, which prints warnings because
> > someone else turned the panel off.
>
> Uh, that's a _much_ more fundamental issue.
>
> The fix for that is telling the driver core about this dependency with
> device_link_add. Unfortuantely, despite years of me trying to push for
> this, drm_bridge and drm_panel still don't automatically add these,
> because the situation is a really complex mess.
>
> Probably need to read dri-devel archives for all the past attempts around
> device_link_add.

I think involving Saravana Kannan in the discussions around this
is the right thing to do, because he knows how to get devicelinks
to do the right thing.

If we can describe what devicelink needs to do to get this ordering
right, I'm pretty sure Saravana can tell us how to do it.

Yours,
Linus Walleij

