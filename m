Return-Path: <linux-kernel+bounces-512655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4789A33C28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B28A167D07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0321325A;
	Thu, 13 Feb 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DWV/mKp6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345B213259
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441430; cv=none; b=ObIdHK4lFPUNsJ2aiE+5/Jgy55nxXGm/I43LxYDnUdjZ6w2IzcRBCTl65srWo3ei7mnAQyamQGn2ZZNiOZHubI4TYjJDKhf53bGqYmklcMFup2p9eaUUEAJSGKmsZ54wnJY10+fmqXo+xn7CRCWRyddTOki+zs3nBjHE+K5HUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441430; c=relaxed/simple;
	bh=bzt6k+aa5u1/W7RojxBuWDr/44deao41NZx9GmrqMJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXjcPfD0H6AXPgN/DEavI+Ob75BzC40GytWLIMzIyYsNFo19fhuV4g0OqX05erQLRA+99saH5p/+LS0PrrT3bpeihl+9lEThwVsXHum67ncoOwNnaIU5ygrtrfx0I95mYh03zBmPWDyW0iBQCB8yqjoNb7L5sacPtRofuBronzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DWV/mKp6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4395a917f33so9666315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739441426; x=1740046226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb9z6DcnNl0g9HoZcHoRWOLXyD9UxXMHyf9eNtzv3So=;
        b=DWV/mKp63pxV+LA8XqcAjES7sNx/RxS5s2nhyBO4QxSxHMSa+Bws8aXeY20e5icFSk
         6sYVUPP70NmjzUHLrPqPIreJ7Doe2aoAHvCGFX/HMBp4FrtiT0iOSHtBSml1Vx+HAS7S
         i4np6BhStsjGRt7Sdbx98cHWw61wAg3VrbHRTX4X6KFuiPjqZkDUwX7FI+PGOL+fRtTj
         swzf5oWzp8FkXzqonBgJYo6SLy2DU+g+grnVV9s9D076X7KsL2ePlkuJS9+crlnxoYB6
         iGb/w+TnuulCh4hF+8zxCalza/M/n6Gw8Ft+GVFjTNn8bp2h11oUrZqJv2UyLifZtVZS
         WkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441426; x=1740046226;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cb9z6DcnNl0g9HoZcHoRWOLXyD9UxXMHyf9eNtzv3So=;
        b=MTlvMl2dpUG3ALSHDOjrfSHj/xX8N9DqNOryO8Tbvr40YKDzRqjGMT4l5j2Rkjcaja
         GHLZMjRiXHySKusL+BpCXJW1G4c400viVdrnYiQdn5E9mlQvcClvfqwGMjJLxk3MWXV7
         i09KKcRvjHprwvPisejRgtPEfrczDwKgxF37T/JcATlfwCuLrogfPCPef2djehgTQ/M9
         6WKVZ3bRbSudXUhdBorsAdOryw3s5By11Yxbp8rPQR9RLhOlvOLF6Ad3byqd+e2BJN41
         YQ2OtMai2OKWlt/dWZuhBjit8NwtCCZTU21ZrInentjAggZBgmT0kH/Fia++qbF5JZMf
         Rg+A==
X-Forwarded-Encrypted: i=1; AJvYcCV/7XHhbJ+K4kNRWXhn0+Uk0pLZBeiw7f5O0rSkCO9cjM8HzrY3HHOPBzJqWcTOBjaJ/RfHdeSPNyg7+fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9e3+lwqUYnUfyYUmnNAjIJrEHxH21/CvUfSgNaOYxhAxEDpEQ
	w/jyPvwjZEn1DM1EP/p+ya8Dg93dSSJmmPTfusFqs8U4deb8Awy2Cdu7MvCRj9g=
X-Gm-Gg: ASbGnctPhB5L873S7lkFIWi+5CY7hrPm/SjNcqz375p4VWJWxN7J6kkV3GanddheGq3
	8LLuGjhx7nvzJHfHtzvqK/h7ofvnvlNVNUROKht0tIxSRItnTbMJlqSCHj9Pb/2BTGwcEytYNNl
	ddCyQ4paO2Ltm9OY+A/CBcgco4++JD3YbL/mko/XpGwMdERUa2Xx4iAg5VaEJyurToN43ZjtxG1
	IhS9j9nYASZS4SpaYwFyiBmrxe1SOBAeipO8sms+wlGYk+xr78CKdIv59cgCLp7O61iuMByuQjv
	XtJwe79sZEH7Pw==
X-Google-Smtp-Source: AGHT+IFnAzzmsoX/LnTlYKfUwdNafAjQwt9ZvkB3qt0FKjzX4kx3PyzgxFabDyvJ+Y073z4cgUVqUg==
X-Received: by 2002:a5d:648b:0:b0:386:3327:4f21 with SMTP id ffacd0b85a97d-38f24f9cc70mr1962954f8f.27.1739441426065;
        Thu, 13 Feb 2025 02:10:26 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b617:2c1:fc8c:2705])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm1435555f8f.67.2025.02.13.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:10:25 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Dave Ertman
 <david.m.ertman@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Danilo Krummrich <dakr@kernel.org>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Philipp Zabel <p.zabel@pengutronix.de>,
  Andrzej Hajda <andrzej.hajda@intel.com>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>,  David
 Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Hans de
 Goede <hdegoede@redhat.com>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>,  Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>,  Gregory CLEMENT
 <gregory.clement@bootlin.com>,  =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
  Michael Turquette <mturquette@baylibre.com>,  Abel Vesa
 <abelvesa@kernel.org>,  Peng Fan <peng.fan@nxp.com>,  Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org,
  dri-devel@lists.freedesktop.org,  platform-driver-x86@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-clk@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 3/7] drm/bridge: ti-sn65dsi86: use the auxiliary
 device creation helper
In-Reply-To: <CAD=FV=WQsFzAmpcqSG-eAm6SW-i3Q7EdbxEKyuhyovVXVRxC8A@mail.gmail.com>
	(Doug Anderson's message of "Wed, 12 Feb 2025 08:38:25 -0800")
References: <20250211-aux-device-create-helper-v3-0-7edb50524909@baylibre.com>
	<20250211-aux-device-create-helper-v3-3-7edb50524909@baylibre.com>
	<CAD=FV=WQsFzAmpcqSG-eAm6SW-i3Q7EdbxEKyuhyovVXVRxC8A@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 13 Feb 2025 11:10:24 +0100
Message-ID: <1jfrki17fz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed 12 Feb 2025 at 08:38, Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Tue, Feb 11, 2025 at 9:28=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.c=
om> wrote:
>>
>> The auxiliary device creation of this driver is simple enough to
>> use the available auxiliary device creation helper.
>>
>> Use it and remove some boilerplate code.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 84 +++++++++-------------------=
-------
>>  1 file changed, 20 insertions(+), 64 deletions(-)
>
> Thanks for creating the helpers and getting rid of some boilerplate!
> This conflicts with commit 574f5ee2c85a ("drm/bridge: ti-sn65dsi86:
> Fix multiple instances") which is in drm-next, though. Please resolve.

Noted. this is based on v6.14-rc1 ATM

>
> Since nothing here is urgent, I would assume patch #1 would land and
> then we'd just wait until it made it to mainline before landing the
> other patches in their respective trees?

That would simplest way to handle it I think. No rush.
I'll rebase when the time comes.

>
>
>> -static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
>> -                                      struct auxiliary_device **aux_out,
>> -                                      const char *name)
>> -{
>> -       struct device *dev =3D pdata->dev;
>> -       struct auxiliary_device *aux;
>> -       int ret;
>> -
>> -       aux =3D kzalloc(sizeof(*aux), GFP_KERNEL);
>> -       if (!aux)
>> -               return -ENOMEM;
>> -
>> -       aux->name =3D name;
>> -       aux->dev.parent =3D dev;
>> -       aux->dev.release =3D ti_sn65dsi86_aux_device_release;
>> -       device_set_of_node_from_dev(&aux->dev, dev);
>> -       ret =3D auxiliary_device_init(aux);
>> -       if (ret) {
>> -               kfree(aux);
>> -               return ret;
>> -       }
>> -       ret =3D devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, a=
ux);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ret =3D auxiliary_device_add(aux);
>> -       if (ret)
>> -               return ret;
>> -       ret =3D devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, a=
ux);
>> -       if (!ret)
>> -               *aux_out =3D aux;
>
> I notice that your new code has one fewer devm_add_action_or_reset()
> than the code here which you're replacing. That means it needs to call
> "uninit" explicitly in one extra place.

... but it needs one memory allocation less ;)

> It still seems clean enough,
> though, so I don't have any real objections to the way you're doing it
> there. ;-)

Both ways are valid indeed. Just a matter of personal taste I guess.

>
> -Doug

--=20
Jerome

