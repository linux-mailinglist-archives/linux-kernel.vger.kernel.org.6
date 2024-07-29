Return-Path: <linux-kernel+bounces-266364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB693FED0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DEA1F227FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924F188CC8;
	Mon, 29 Jul 2024 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4WGVnKH"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46343152
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283778; cv=none; b=tSB9crcSNMPSXySlJ6X+TODMmF2AP5h+qYqiiiF24lrFBF03PZZZ+e9j/0GSYZF2IdyUrIfNncPzueCSGQP43ZfhFD1Hl27sLzcBYfIwaeUKB0poGMnzThnKZj5M7enCLYEXuXJQVHpWhPovnrGPyVGlGbi/Tt97jqprmbpF4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283778; c=relaxed/simple;
	bh=Y0bKmENPrkpO62iFnuZrcOnFpoRNmn6cKOZ5PurDAzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kqv2s5qhi9paykoWbnm87MP8SkcD9AWLoo7A4WWROpNS7noORWlWrVKgv17kG/zb2pGbA+5nvJNuUHg2QsPv5aUHzqeYE+zH2HZZciWAajjImvoOhr8sfsCXSDcOg8+Zw7nIitSeXxdt5aUKTgRp3hBiKEK0dZ1p50gZLprM/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4WGVnKH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6678a45eaa3so24874127b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722283775; x=1722888575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO5YO3gTMJxRN4DD9FtUSuJI3FyT9bz9kOdIwn73kJI=;
        b=S4WGVnKH6AyS5gPtspPJzWTkk+ywyjShusJXRGuXl+wrvty76H1OZXBOnZyfiU2UEP
         fBTrRVaFbPOpz1xeSw0g9Eq7kXhjnRwwPYw8qfD5JrNc3QUv7XIU1/qLCCpZFqZDR0c2
         xD+xtjL6k/MlvwePlEeGhNd7PVyXLwo7XBqNPWvSQncEGlFTkFVN8Vkq5JmFusdEHpGc
         gUHG2qbCrbMBYdOpNOYRLA0smKmC185VV08Vk8CBoinzeWYq+DuxNT00Rb0EkB91ba3Q
         NozT/sEs+NP02cO3D6Cs5CAFuLhYkPPp/Gv7HE+5isL7v+xobseF2ZR/8L39Jx1X8Pki
         t0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283775; x=1722888575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO5YO3gTMJxRN4DD9FtUSuJI3FyT9bz9kOdIwn73kJI=;
        b=tpOcm3XJNbMGUDbR8MVq3/BAnIAm1W6BQ5AzZiyoJ6kr+C/VlvmeqYaqlVB8itFwiq
         NVnlV3qoiK1S2bfNGHq+yJ0II6E+B0r0MHgcHD+8i7hUzpexDqh/uzfPVd3pfnXCjUwP
         BC0gKAAeG5HklmvYHnXkQvNLum8pem8czLF5XOnJ0zw9KpxGnVAAnFjHJenv/b9P+5nN
         g5GnIg9KnM9DTU+6zDnuMDxankQi4NhKrCcXbYmSWgammLU2x2K1sjDNnsiFwVb1N/+y
         w2Cjl8GiqSRxMtkpDHWszsgX9NHX6AiSJrDIw6iqTbApdBJsBwva4Dg76CY+EkNrGlvU
         4Opg==
X-Forwarded-Encrypted: i=1; AJvYcCWzihNe6nXiub4BuNga5sSSPECxmVbNGHyxZEWkk7J31umhDCpDCa/fkAojPrVe6jZ/v8o0yNfDZzBPP1JgRBuYdy9uVOTHfq4Oo6SI
X-Gm-Message-State: AOJu0Yw7hFzu86fz4Ui6KT38/5B2RGKpRrg1yaoeFQIPJqk6U/TXno+h
	73mEdG9wsfFqCuFTCS9pySy0ATQPVLUosNvTVaK1OxZJ/WJlXLCmvQcFUaGZPt53AnnjWUfQ6rr
	1dEhYIJWxcxtntJ24CNRpxslkNoxmjEmLTLDd+g==
X-Google-Smtp-Source: AGHT+IHNGA9/9hOvLxvdj7+5y602kFWRi0g00FzF83tJv7u7qWJ8+ORj1d+m/utPMN2nC0Pnz2E1p8NJESCd3fTXz34=
X-Received: by 2002:a0d:e746:0:b0:65f:9873:73e9 with SMTP id
 00721157ae682-67a09593ba6mr101492697b3.33.1722283775155; Mon, 29 Jul 2024
 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <gq5fcttutomphgfrwrtloqzczia3uc5qpont3lrowocan2xjc5@ubfabhsh3mfl> <CA+6=WdQuFYbADjG0i_zWMGYmw95H1U_McqCw4CLW0+Gate50YA@mail.gmail.com>
In-Reply-To: <CA+6=WdQuFYbADjG0i_zWMGYmw95H1U_McqCw4CLW0+Gate50YA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jul 2024 23:09:24 +0300
Message-ID: <CAA8EJppoj1Y2675UOp=JH=-HLdYuuzfr2Sxy1zzkvLosmrRQNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location of
 the 11/29 command
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dianders@chromium.org, hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, 
	jagan@edgeble.ai, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jul 2024 at 06:10, zhaoxiong lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> On Sun, Jul 28, 2024 at 12:59=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 04:32:44PM GMT, Zhaoxiong Lv wrote:
> > > Move the 11/29 command from enable() to init() function
> > >
> > > As mentioned in the patch:
> > > https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.=
corp-partner.google.com/
> > >
> > > Our DSI host has different modes in prepare() and enable()
> > > functions. prepare() is in LP mode and enable() is in HS mode.
> > > Since the 11/29 command must also be sent in LP mode,
> > > so we also move 11/29 command to the init() function.
> > >
> > > After moving the 11/29 command to the init() function,
> > > we no longer need additional delay judgment, so we delete
> > > variables "exit_sleep_to_display_on_delay_ms" and
> > > "display_on_delay_ms".
> >
> > Won't this result in a garbage being displayed on the panel during
> > startup?
>
> Hi Dmitry
>
> We just moved "Exit sleep mode" and "set display on" from the enable()
> function to the init() function and did not make any other changes.
> It seems that many drivers also put the "init code" and "Exit sleep
> mode" in one function.

You have moved the functions that actually enable the display out. And
by the definition it's expected that there is no video stream during
pre_enable(), it gets turned on afterwards. That's why I asked if
there is any kind of garbage or not.

> In addition, we briefly tested the kingdisplay_kd101ne3 panel and
> melfas_lmfbx101117480 panel, and it seems that there is no garbage on
> the panel.

Ack.

>
> BR
> >
> > >
> > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.c=
om>
> > > ---
> > >  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 59 ++++++++++-------=
--
> > >  1 file changed, 32 insertions(+), 27 deletions(-)
> >



--=20
With best wishes
Dmitry

