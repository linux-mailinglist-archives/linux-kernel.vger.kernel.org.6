Return-Path: <linux-kernel+bounces-292479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429D956FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C421C22BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C516CD25;
	Mon, 19 Aug 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmAJsDMY"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810668287D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084092; cv=none; b=Is7xaWS7PEOK965KqbhIsODNYWk4IsY8DfPwHVrpXUTLikK271V8/t9f/3O0YDrozK1+CgvyYib7wg25YLvAAQmf1EOgQEb0WvTw8gT46VkIrYgjGyUW8DCY/emjiKtp8D3wOLQY0A7npaddDW23C5bQvkKn6x3S8uoGlMIWL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084092; c=relaxed/simple;
	bh=2wHrl71jmtaGRaC9bBPlFwfuaOlpD2ILBryCkczRsW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6z4fA52wAlwrg5njx7uSShrC0OivUMRFimNUg5lJuIVkVsbcjhlkjRPLG4dKT1ka74jEUICIP30doY1bEzgDWUdNq5AOQS0yfcbnKnlze9A4x0J4fRxIlgFSzXRTlyx1As5ULO4K0X9rAk3sQZle6NrCXReVuIn6gx9MFauIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MmAJsDMY; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a20b8fa6dcso300590485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724084088; x=1724688888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIO91E6aNJoytIdsntCTP0hK3bjqHc3xM1HLhirFIT0=;
        b=MmAJsDMYUiRfCRL2UccmUrl2lo7vG/f54wNAgNk9Lb1SBSfUewy5IlXL+jH+q9HSaq
         lZzNxq3+nNv0Dkzsr0ck4AGPV360TEq5olnApUKZa5B9znf1jGJ/UIDqtWepGFX2SrAT
         VXGh8WKzUCKr3aT+TeY0VBMg00zLDvb2bViY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084088; x=1724688888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIO91E6aNJoytIdsntCTP0hK3bjqHc3xM1HLhirFIT0=;
        b=K8segdnUSYIiR2j6OSPN0aqF0H8TaDVO91H66Ru7qqJUpgBoKTZ5rn2teYnHDrwGLk
         KSK/A1tBNCReKyERKCSJHrFsW1Rvf09sWy6tH4yetN7CC+rcp0sgvj+THLw3AzZhE4Jn
         HLhplC/c9mw3KrvpbdAcJw1ykJfFeBfO69Ha2rZYcxvd42dmlOHcOhIvLm8Lg0xCr5vL
         A7rs64lwNhEe1XZi4uucqRsiUyPgGAqPcti24cS34u3G3XL6otrv026uNw8ZS6qCbtYA
         eEfAaDtdZwWrDUOp24W19frycN4HQ5gon7/ST7707Dm6JE9blSv+YJfbtBzeJCxo6Y+L
         /8NA==
X-Forwarded-Encrypted: i=1; AJvYcCUHZR9fJHxnS814h5mTGvMYp+E4vxZ3KTc6t65z//n2KiOnYTSAKCnTB6MXJp9Vmw6ic0MI94qpXTt4PU/JmjSXKcgLVvfSDOpgCIWx
X-Gm-Message-State: AOJu0Yy3iaOwk3bcVbojLUhzSGf8Ef5orLbwKnrdNTpaaAxYkL+gx9hx
	jdULEka1roDFsk43aaBFiRF6XvDUgHEfSLaXCA5GgxpPlFnHM1YopV1lpdVRRRVdtZ9MZg12iYs
	=
X-Google-Smtp-Source: AGHT+IFuIKR4NkLdS30SwnlAqN6V1gZ903qn9Js+iz6lSsyWQNN0HTf11mKl99IiYpju8oTde8kNtw==
X-Received: by 2002:a05:620a:1a21:b0:7a2:a50:53cd with SMTP id af79cd13be357-7a50690675bmr1206416185a.14.1724084087762;
        Mon, 19 Aug 2024 09:14:47 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e0982sm442799185a.98.2024.08.19.09.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:14:46 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf6beda038so27453236d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:14:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbMw3sn5BevHXuKSNN2gm0OIPN6vNt4VexC3qASd5BkeZ5K3jMr8znHiVuLfpxcAbZwX5c2G+AMCGGiKbFjQZTfzu8/64rhbFBmgEF
X-Received: by 2002:a05:6214:3a06:b0:6bf:836b:2c18 with SMTP id
 6a1803df08f44-6bf836b2d69mr91124376d6.14.1724084086193; Mon, 19 Aug 2024
 09:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818072356.870465-1-tejasvipin76@gmail.com> <4be2f1d1-534c-4c99-a35e-f354c75c88b4@linaro.org>
In-Reply-To: <4be2f1d1-534c-4c99-a35e-f354c75c88b4@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Aug 2024 09:14:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaYCW3hDp-eV9Wio-3iB2-PViy5Jj9VZxPEK2j+PPLkA@mail.gmail.com>
Message-ID: <CAD=FV=UaYCW3hDp-eV9Wio-3iB2-PViy5Jj9VZxPEK2j+PPLkA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: mantix-mlaf057we51: transition to mipi_dsi
 wrapped functions
To: neil.armstrong@linaro.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, agx@sigxcpu.org, kernel@puri.sm, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2024 at 8:36=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 18/08/2024 09:23, Tejas Vipin wrote:
> > Changes the mantix-mlaf057we51 panel to use multi style functions for
> > improved error handling.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> >   .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++-----------=
-
> >   1 file changed, 27 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers=
/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > index ea4a6bf6d35b..4db852ffb0f6 100644
> > --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> > @@ -23,7 +23,7 @@
> >
> >   /* Manufacturer specific Commands send via DSI */
> >   #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
> > -#define MANTIX_CMD_INT_CANCEL           0x4C
> > +#define MANTIX_CMD_INT_CANCEL           0x4c
>
> Please move cleanups to separate patches

LOL, in a previous patch series I had the upper-to-lowercase in a
separate patch and someone yelled at me to do the opposite and squash
it together [1]. It doesn't really matter too much to me, but given
the previous feedback I've just been suggesting that Tejas squash it
together with his conversions. I'm OK either way, though.

[1] https://lore.kernel.org/r/CAA8EJpo4WzMPNjpnkHt-_GJe2TAF_i_G+eTaJrGipMEz=
ppc3rQ@mail.gmail.com

-Doug

