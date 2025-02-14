Return-Path: <linux-kernel+bounces-515201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBBA3619F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0429C3A1229
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88666266B4D;
	Fri, 14 Feb 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pm6SDM6F"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13728264A61
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546774; cv=none; b=JTRXwGBPJfAIvVmfA+qIktXmLlNKPCrJXn6ooGZGyrfNOyKFXiAbolYT/u3yQWm8yCQDv5qTCcBisyh+60s1vhs62LYMJP391wBt62rLxysJcNXRAS9RvL5xETEclJmypFdJf2wIGtxuBncPXXDkZhXDIMPTvp7/jyY+vNnESRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546774; c=relaxed/simple;
	bh=fHqSVsarbr9/GNSKcHw7mFlABcvHBZA79lxaZw7Ee7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDOVpLvqHzqEulvR7hJpkHaG1YcFyZeYtjW4Gyp/yHmRvdoRHALWzpjqjt1+XpH1oU4yeL2p2kqJSny1V1TEsP/xMKpWTrwYGAHe3yJ89Fab504XnNqKa8V7ylQRjr1yZYy8s0PqVVLRxkRytbRjWC7CT2ptwrG84eSetvWbcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pm6SDM6F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5452e6f2999so474500e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739546771; x=1740151571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHqSVsarbr9/GNSKcHw7mFlABcvHBZA79lxaZw7Ee7Y=;
        b=Pm6SDM6Fs35JGtxuKf8Ug0RJj4uKeZCOc0V9kqGr2rq6ZFZs/M/WYV0xeaw2ogLs4+
         hSNrzpF2do+iP7t7Qw8wKNRQNnWXIc3NKch0kzJ0aSwEEOuzGnqDDz7VZU8wWDxnE70k
         0JpHR0QJIEXu/WDqdxr5HDKPvUR29sqzI1UmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546771; x=1740151571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHqSVsarbr9/GNSKcHw7mFlABcvHBZA79lxaZw7Ee7Y=;
        b=DdF2wcB9Yo/Zth5UawYBXaUSXHT1LISrj7yqyPwIZsIcEL3zqOydJTsuk5F+9nL2YG
         xe/O2MuEZFuZLvWLCnGr/NjEBuME7QdxlN0sm1hYNmCL6jpNiVHlsy8S0rjc0wWoI5W8
         zD9iAmoojGPozrp96q4QSn/fOVIbamxg9V9gRrAxwYj6E0UMvc3gkPtq16I92BYN/Pre
         mu27ZGiL/I5YT+In7DecNDX3rqhAiV3Xi+7GodTeM7zTFWvkGwGps15UJn4YvHnvu6O4
         D4gcUIdT+q30m3pmvsioe1M8LLZdWCdYoCEfgQeiEW54DccCQAwX4DDq4D38E6zQ2ulz
         nrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMfzNGY9Xyeh7uzJu4W9u5OZE9Znre80E21L2Evyo+8w6ocJ5YrTzzubdKhkL9/TzwVsSsQh5K5roEPVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBpoVxSI/apN99jUhBOH5FbNDi18lSGqg6T8jL6CEpr5BQR5k
	0wzkhmJnMMFh8pXsKuDk3ggYyrexZwyVh/NZvYUAkPBI3qwQOhDPYQptAgpFFrbp/i9wQScIMEK
	xFg==
X-Gm-Gg: ASbGnct2tPcUDkzSWNu7+HBNdXUUyNBBH+e+TyBBF73ji68WYBLnBcRVr07OZgG/CDZ
	VMjs78X2fVdbk4oYhCqG0RdSdWkLt8ij0Ub0pxb0Rv98PvRvmDTAPhetwXRUzHUlxnMcqL45S+P
	bP//ZION5lY3K3D57oL81nm6RtmdkpNNqr+gelU3Uh6Zah9WlutUZ+Mo8TsqOYa6DsvsNSGz7mH
	vky0A8N8Vc74Kk4k6Yg3tt12KcF1Yqs2dZcSl32V4Hk0prJ/+fsSMfmVIlycLYsR0k8cg0WXd7n
	2xQ17TNG1ssq/4WTK8K+YBYe7OpPE3Bts4r8XwJEJL6hVQYwlHfG90cvfqk=
X-Google-Smtp-Source: AGHT+IGl9eLtDWFrIPKmtViL8nrWFrjrl2kzHQFjG6UJuMZsPS56kwQPW7MoQSUCPROj1Mb4T+OE2w==
X-Received: by 2002:a05:6512:2345:b0:545:2dcb:948a with SMTP id 2adb3069b0e04-5452dcb95bdmr670250e87.34.1739546771026;
        Fri, 14 Feb 2025 07:26:11 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105d4esm545398e87.154.2025.02.14.07.26.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:26:10 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-309191eec90so12257621fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiI9PIfuKChTLO3U04N+g9xKekj3d3+3RXaYGueu0fbKNkoMWWrGMVz1upXcP6OiLJgUj2J1uyOXIKh6k=@vger.kernel.org
X-Received: by 2002:a2e:8a97:0:b0:308:eb58:6581 with SMTP id
 38308e7fff4ca-30914801891mr14311001fa.0.1739546770563; Fri, 14 Feb 2025
 07:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-aux-device-create-helper-v3-0-7edb50524909@baylibre.com>
 <20250211-aux-device-create-helper-v3-2-7edb50524909@baylibre.com>
 <20250213-crown-clustered-81c6434c892b@spud> <1jv7tczytk.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jv7tczytk.fsf@starbuckisacylon.baylibre.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 07:25:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VeSrZktEbxNXXTgD80QGTpW5b-WiXUFko+a8FUzmN+fQ@mail.gmail.com>
X-Gm-Features: AWEUYZn5Dl35ky148QOOCnARP_86rg2vhIKgVTUOs7s9KbdYhXOWWeRWr_r9yF0
Message-ID: <CAD=FV=VeSrZktEbxNXXTgD80QGTpW5b-WiXUFko+a8FUzmN+fQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] reset: mpfs: use the auxiliary device creation helper
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Danilo Krummrich <dakr@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Fri, Feb 14, 2025 at 12:59=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
>
> > One think that's always felt a bit meh to me is this id number stuff,
> > I just threw in 666 for meme value.
>
> :)
>
> > The whole thing seems super
> > arbitrary, do any of the users of this helper actually put meaningful
> > values into the id parameter?
>
> In example changes I've sent, no.
>
> In other simple usages (those using container_of()) of the auxiliary
> bus, I think there are a few that uses 0 and 1 for 2 instances.
>
> I guess your question is "do we really need this parameter here ?"
>
> We could remove it and still address 90% of the original target.
>
> Keeping it leaves the door open in case the figure above does not hold
> and it is pretty cheap to do. It could also enable drivers requiring an
> IDA to use the helper, possibly.

FWIW, once you resolve the conflicts in drm-misc with ti-sn65dsi86
you'll need the ID value. ;-)

There was a big-ol' discussion here:

https://lore.kernel.org/r/8c2df6a903f87d4932586b25f1d3bd548fe8e6d1.17291804=
70.git.geert+renesas@glider.be

I eventually pushed v2 of the patch:

https://lore.kernel.org/r/7a68a0e3f927e26edca6040067fb653eb06efb79.17338400=
89.git.geert+renesas@glider.be


-Doug

