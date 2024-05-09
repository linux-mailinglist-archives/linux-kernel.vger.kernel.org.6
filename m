Return-Path: <linux-kernel+bounces-174702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0168C1331
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99421B20AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58EDDBE;
	Thu,  9 May 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUX/5+4X"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A3C153
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272966; cv=none; b=qEPwgIFUAr51ygiL7vumDCQYcx8EyHg6zt1nd2+f9YwweaFRt+ggoPNFnAkTA8irbsSlm7qU3ppflIxeRQho04L5MbHjBhDZrw53aO/03GNW4y6KBTomYP7r5zu4R07+VZzP48RjaUmXkmLUNrbCbS3GGlSH7I9/rk+Z742Uvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272966; c=relaxed/simple;
	bh=AE3InwFZ098aRACoxtphpmufoslM075b7kc/GFcYMQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm7139iZwFofhsmvZZBAE/H5Zyfk7ULWw+5HLX6UJ5v0O3qbdepB7NlqtkAqee5uObJvdxQKWjBBjpMY5liIX1aHAER78mgfajYKjR7HjlhQhEl2VhSh9N2/ttUEucdVy2YaN2cgOGvKqnMyqzEA4uA7eVtiuowOHPkUYbh3/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lUX/5+4X; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9963a2205so137492b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715272963; x=1715877763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44yq6LGi2PMD0vBMyVyyqYe6nZFMsvuGg5VBgAwJGFo=;
        b=lUX/5+4XHyyVEwuTEBr5tjxebKH7lQnkzk2dQ7/lfTxpueDo6lTr8CZcuaotFygxQT
         u+L/R+A39XEewJwriHgJcYehXNnfcyjVNR/JA6FRS0/5SIEtRT1eOBj5qmza/m2w7p+9
         cqmLoDd23SGR7vfvj0rTnK6BfHHsAjC6kllxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272963; x=1715877763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44yq6LGi2PMD0vBMyVyyqYe6nZFMsvuGg5VBgAwJGFo=;
        b=PpNhaM+vAZ9dUUJzIspOWPAuaQPDriWGkQTpauI4Q+cQ8tishxZxTD7nSoNsJJ8EIh
         i8C8t+CQP/7pG3R5JZ1TwiircjgXK41sK9tkhJDFeFnhXOYnniaNMaiPScLUUu1ABP3/
         uJUqdXcNPM5OofXrgiM2+nCUkA7+FH6tAmgRzB24BEZ9wfu6qUvBHo8ycUB7tpXEhV/3
         rdJs3sStBfWlYXOG7CWWUvOrOweJ4ZIS1XySuT3HDpVh+u1wQail0B73hcCOBr+Bizu3
         lA4nDdU5HfaYSn0j1Ol52BCXO2wlSRKMdn6lW3nRiClv43ZuiW6Y53RApWDH7/U3BBjQ
         SSnw==
X-Forwarded-Encrypted: i=1; AJvYcCVRP5NPRgKTmxpkx0P2ZHB80M17SpQFzzvcZDEMq+drnPYbQar3GvkKTGDZIyt0w6vgWhKvjNQG2di4rlIH20ZA5V+g5jHo6dib0g9V
X-Gm-Message-State: AOJu0Yzfzg69h+7xvWXn/L504y9Q2S0BHzVEqOzK73xYH+JVWqjpQJwz
	UYTCZMSInxHsXFB55+zX6SNqfTyu/fIGyEp+/u4KBeNIlOdvetQa2GqKSAM2gT9LSEh9Ky9yK0t
	OQcfX
X-Google-Smtp-Source: AGHT+IEDCioq2aI7u2fkfvvqIYR2SDRtFMGMBvp2hct1aqRM20LPzKBte4TOuT4NX+0E+43L+9XvBg==
X-Received: by 2002:a54:4116:0:b0:3c9:7003:af7e with SMTP id 5614622812f47-3c997054d39mr129148b6e.18.1715272962852;
        Thu, 09 May 2024 09:42:42 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a1624fb686sm6426396d6.124.2024.05.09.09.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 09:42:41 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-439b1c72676so1171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:42:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTs+pWFyYJy453AcvwKh6U7MVuwG7/kl/spIlPFCH+3XPUOr0x9bH7pXhZRWTJVH/LE3ao2ja8ulyjZc0rDwot/DE8wI9OChH1QbPd
X-Received: by 2002:a05:622a:5185:b0:43c:553b:1bd6 with SMTP id
 d75a77b69052e-43df3b1ce3fmr3110661cf.12.1715272961287; Thu, 09 May 2024
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
 <20240509015207.3271370-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240509015207.3271370-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 May 2024 09:42:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaTj_ojJvc2T22e49MhB-zp1+Z_tp9uULS0r8MesUd2Q@mail.gmail.com>
Message-ID: <CAD=FV=UaTj_ojJvc2T22e49MhB-zp1+Z_tp9uULS0r8MesUd2Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 6:53=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> +static int hx83102_enable(struct drm_panel *panel)
> +{
> +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       int ret;
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }
> +
> +       msleep(120);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to turn on the display: %d\n", ret);
> +               return ret;
> +       }

FWIW, I think that the mipi_dsi_dcs_exit_sleep_mode(), msleep(120),
and mipi_dsi_dcs_set_display_on() should also be in the prepare() to
match how they were in the boe-tv101wum-nl6.c driver, right? Then the
enable() would be left with just the simple "msleep(130)".

I know it doesn't make much difference and it probably doesn't matter
and maybe I'm just being a little nitpicky, but given that the
prepare() and enable() functions are unique phases I'd rather be
explicit if we've moving something from one phase to the other.


-Doug

