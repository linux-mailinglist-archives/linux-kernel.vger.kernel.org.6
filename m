Return-Path: <linux-kernel+bounces-531832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833EAA44592
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CA51884992
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D90189F3F;
	Tue, 25 Feb 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9BnQAh1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1561624CD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499912; cv=none; b=cDoamHJQlbmmtXwbb5MLbkMkv1zmg5AVREdIrqovNVXI0V0sJEvDTT+l31TpVJ3YJ8UVJmXThMqc40+aaTp49M2z4nHku+KVcHzZ3wcLSBYpB2Z5twJ37MKRp99gEFGbEH6QC0cUW2upFmNe+CjXIlJrNuexAEpvP4l49Gnt7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499912; c=relaxed/simple;
	bh=rCByvJMOjUxh8ZzB5E/B1+AmONBCyWA+/sUB1yHUqbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBElISt3kep84LHbzZqlVKz/fdGBgYHkICpEc5rp4sxAiAmy3HsfTUi5qa/iR7iOkhiCqnIvCYK8nRRBa8STe5lwpG/NEhrqE1G3I8vTSZQpB51/70eWTo/OqqkUPU7oUnKga0d7hGMq+I4UURjPO6yPH7dOoDLKQv8tRuLi0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9BnQAh1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so8921385a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740499908; x=1741104708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwUSC8OCkUHVVAACMeGE7Ik1ANgp9jf6fyVgqusnzdY=;
        b=k9BnQAh1Xwo2S4DrTPkb/F3Vstn3eNQfa/J/aKMjtGu0PtkUPfjMgsTtciXiBEcswC
         URbIPvUwbw/QFwc1PwdHS5eQvMgo0fmljEAhI8Mig+1aBKrJsZ4SN3KWj45cgJZRrbWs
         XyTbfhIyrsSWavF0cJBE4pO/ftFJ/TOcE1+50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499908; x=1741104708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwUSC8OCkUHVVAACMeGE7Ik1ANgp9jf6fyVgqusnzdY=;
        b=t+dc9cU+gMsvfQtEDyI7hCDcMS7Npa4pB1eBpgw4Z9jfDBDTGiRbChOFp64mbLikHI
         AuHUBOGkrTKLmv4P8FXw9hwIgu45DVtMyBqk9TcQh2c/GP/I7uheBzD5X5jMo46Dj0t5
         g+14FSPy1o+H8TaBgEncDsnqxMXd1IFyZ4eucFBYk7o7qsnB9B7vcbxAFq2x+R5yuWWI
         23l83V8lBI0DL7frkh9/5Vqvn/F7KCu7tuW7MtkY17Q2a/GpDXFqwQfH4v5v3KFyLYyp
         ptVvqBEUxivZUcrVwvM6Cc99HStJP32JOsH/YxkdY+ySVVD4zZRZPldujtK+uXvrmAox
         l5ug==
X-Forwarded-Encrypted: i=1; AJvYcCXNIF3PrpeY+8cPvz5vVHmlKEcxmtGuhsW50BbxhJ2EqKsaG+YE8ijj16VkP0iQKAxF9dCsUt3XRoxzgbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0uwtscastCbFwzZfvyeF86kgDYf2be9HcU535oTCQELCd/wLz
	qKhC8Kv/xQiktIA7yVvNvVsP5ACc4Av7IRmgULrTetBv2FZrsXGF4nmG0uagG0g67jAjmZdhkLG
	aaF/G
X-Gm-Gg: ASbGncsR2zTlLtvEyLEmcw3IVS5gGNPK6rCPacvpXVoyzpvdLWM3wdInMa2uca1/ico
	t5rWH3FF08q9iWJ5ogP7Iq6tluPduG1Ew4s15rFYmfNAml3J+qA5ypuQt9mchvvdrNzxR+HbjmP
	JcrDPkQXTX490uC0NV4baaBs62MKZu+LSUF9oDPq/Z75YF+mX8xdn8judzPWdGWzIAkhagIHFai
	7KIPkRbZQmg7ME6dXUDXz2vYnrpIyMUJyfT2P0rqoqFBz4uTdpL9fgdlY0IJdsw2t2hC79A3hq2
	A+Xr6CjAidm9Ig32zRAID/eKmVa6yYu8Uq6OoZ06uqo32T0QJod5yI0AxHQ6x7k4bA==
X-Google-Smtp-Source: AGHT+IF172n9G+WG7Mj1EEpvmgy+XQO5kMd8rsQa6NaftxSdjWp4xpgFEGWlXhLmz5e1rbNJ5STY3g==
X-Received: by 2002:a05:6402:1ec9:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5e0b70cb891mr16791870a12.7.1740499908133;
        Tue, 25 Feb 2025 08:11:48 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e459b4b671sm1451475a12.7.2025.02.25.08.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:11:47 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so8921336a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:11:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVfnDkqrXrnB0brsxNhmwOKycZp73nxT8B3xh8/TAOfvHR6FqSN0nGifQMsKoYSRqY6V8RyRWrf4ZW4P0=@vger.kernel.org
X-Received: by 2002:a05:6512:1241:b0:547:6723:93b6 with SMTP id
 2adb3069b0e04-5483909d1d1mr6678553e87.0.1740499509419; Tue, 25 Feb 2025
 08:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com> <20250218-aux-device-create-helper-v4-3-c3d7dfdea2e6@baylibre.com>
In-Reply-To: <20250218-aux-device-create-helper-v4-3-c3d7dfdea2e6@baylibre.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Feb 2025 08:04:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vb+Wb6wJ42jUBxVVNp9P87BiqHZgoY+Tw6W3fO==FF6g@mail.gmail.com>
X-Gm-Features: AWEUYZm3vRrajChqqVao9eJTA9wadMF2aiVVZGdKkNeW96YTlQauMsPFnVVKvC0
Message-ID: <CAD=FV=Vb+Wb6wJ42jUBxVVNp9P87BiqHZgoY+Tw6W3fO==FF6g@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] drm/bridge: ti-sn65dsi86: use the auxiliary device
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	platform-driver-x86@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2025 at 11:30=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
>
> The auxiliary device creation of this driver is simple enough to
> use the available auxiliary device creation helper.
>
> Use it and remove some boilerplate code.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 49 +++++------------------------=
------
>  1 file changed, 7 insertions(+), 42 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll snooze this for a bunch of weeks and check back to see if this
can be landed in drm-misc-next every once in a while. If you notice
that drm-misc-next has the necessary patches before I do then feel
free to poke me and I'll commit it.

-Doug

