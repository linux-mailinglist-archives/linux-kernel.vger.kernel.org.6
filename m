Return-Path: <linux-kernel+bounces-366386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619C799F496
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2925B284702
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2A21FAF16;
	Tue, 15 Oct 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHQCF6z4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B081FAEF4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015166; cv=none; b=Mjlr/emrkxUsFK85ocTvDKHQaEGyFvjNrGStRrWv0i7Td3GNEY29uNSVjsMR4FI68F1O8DadgloX4pEskeWVmX20WRSVAgA380LtqMJvUvEvSdBtH4iePMGDGVwdLJwy7hdtt2k1qzoBOrOByB/YyIxV3W7yKyFwkM/Yoysh1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015166; c=relaxed/simple;
	bh=Nw8AYXxLQYRASA0EqVaeq4osc1EcBSEe7S6yFgCszeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVezWNmSWPw9FQ5QnGmvSr3g4NkHIGMkXfDGKtCej5op23Np5v2FfeiKtj/4Dn0qI6zcTwfrfVCRipOYvV1j6e8mU3FZOPfdf1Y321PaGyuS6LktsPr6jH+xfF8v/Z42dtAdL5VOZDcAJURKkp5YNgSx1GIQMMRyZhh8QBvW5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZHQCF6z4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3164859e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729015161; x=1729619961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgVZjc/qQxBTME0XwgT07broj1qCt0+6Ia7kOJS88zs=;
        b=ZHQCF6z4edIlpVBKRLtJ8XkxMlT0LSYexYYXJ2fnl/ogxoJ4PcmZ55QlkhFsyhnv/e
         edo5oYGm011vlh+n06uF+Wug40YbUr21iltHt8csSZ2mp9cmytqg/bUOXHGwMmZo/qWC
         6Td/9WMBWBnOInJYLvTKbIv850UfyRoyoUSII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015161; x=1729619961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgVZjc/qQxBTME0XwgT07broj1qCt0+6Ia7kOJS88zs=;
        b=KYw39MbHefQUJdzaGvwQsXRX8FmX+veyqGLT50GgX7nJwLEkslLcc2tu5SYIDEVy1O
         TQMX0qVrgFdVPs6nJQrNQXEKB9Yi0SuQ4kZLuH/4b/jNXW6SHNYgvuhJrfnSgyRKjFIW
         0+jX1FtvxPOkXiaHjRHb1xQJX3fm/YLnJ0sVJBvKs3MqyADiuz1RbyBMkFS8FEhQxZ2z
         7KK43Y1GDlPqY/4MgsXBkuyV1K+fkeyF4jvd7N4RNh3zQhZgCiF9gCR0+OxO+h32TyEN
         63EFi1PPw1CH00iL0wGCr42x6Ut8ovFy+Cwn4rYd4ye2Zeg4r7RmMfR739GiBvXXmjEg
         UIKg==
X-Forwarded-Encrypted: i=1; AJvYcCViQpIoLsjSRzPyYqOjUt/8fUKb/AIudP9xf4aMBuWy2fuIds1i/iLO1GUY2sDE5XE+junAheWEYUFUFT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+25WI3FP0nSZQQpGPvRY+L+Ynptga+JLitaCa4SqUwLtKOK3
	fOdDwaGm8d3ijcw5U7ly2Z9tQDjFh+x8uFZzjwx/CKwrbFzKFFyTvtDVzj+RiNmYfzzacqJEiod
	fZoCf
X-Google-Smtp-Source: AGHT+IGk0BABIZPPN34ih2gWFNIcNequJJd8dI1I/jzPnToP7Ewb4KaL0nnU+HPeM0ajU/iTUxwd2g==
X-Received: by 2002:a05:6512:3b0b:b0:539:f06c:6f1d with SMTP id 2adb3069b0e04-539f06c704amr4622698e87.55.1729015161392;
        Tue, 15 Oct 2024 10:59:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a040f5a1bsm73001e87.231.2024.10.15.10.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:59:21 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3164793e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:59:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZc2tjPHT5gwJQCf0AlhWIciClo7EoVInhZ1EsAFd0Dd/hZj91ayrLhKBt74u5vPFJDfW+G9kgmv0kJMA=@vger.kernel.org
X-Received: by 2002:a05:6512:3046:b0:539:d9e2:9d15 with SMTP id
 2adb3069b0e04-539da4e12eamr7412619e87.29.1729015159647; Tue, 15 Oct 2024
 10:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-8-wenst@chromium.org>
In-Reply-To: <20241008073430.3992087-8-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 10:59:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-00zCEGhp=Buqg2OFikX2TYDK81gXuD7S_+btqKp9JQ@mail.gmail.com>
Message-ID: <CAD=FV=V-00zCEGhp=Buqg2OFikX2TYDK81gXuD7S_+btqKp9JQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] platform/chrome: Introduce device tree hardware prober
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Some devices are designed and manufactured with some components having
> multiple drop-in replacement options. These components are often
> connected to the mainboard via ribbon cables, having the same signals
> and pin assignments across all options. These may include the display
> panel and touchscreen on laptops and tablets, and the trackpad on
> laptops. Sometimes which component option is used in a particular device
> can be detected by some firmware provided identifier, other times that
> information is not available, and the kernel has to try to probe each
> device.
>
> This change attempts to make the "probe each device" case cleaner. The
> current approach is to have all options added and enabled in the device
> tree. The kernel would then bind each device and run each driver's probe
> function. This works, but has been broken before due to the introduction
> of asynchronous probing, causing multiple instances requesting "shared"
> resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> time, with only one instance succeeding. Work arounds for these include
> moving the pinmux to the parent I2C controller, using GPIO hogs or
> pinmux settings to keep the GPIO pins in some fixed configuration, and
> requesting the interrupt line very late. Such configurations can be seen
> on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> Lenovo Thinkpad 13S.
>
> Instead of this delicate dance between drivers and device tree quirks,
> this change introduces a simple I2C component prober. For any given
> class of devices on the same I2C bus, it will go through all of them,
> doing a simple I2C read transfer and see which one of them responds.
> It will then enable the device that responds.
>
> This requires some minor modifications in the existing device tree.
> The status for all the device nodes for the component options must be
> set to "fail-needs-probe". This makes it clear that some mechanism is
> needed to enable one of them, and also prevents the prober and device
> drivers running at the same time.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Maintainer expects this to be merged through I2C tree.
>
> Changes since v7:
> - Corrected Makefile item order
> - Replaced "failed-needs-probe" with "fail-needs-probe" in commit message
> - Added include of "linux/of.h" for of_machine_is_compatible()
> - Switched to simple probe helpers for trackpads on Hana
>
> Changes since v6:
> - Adapted to new I2C OF prober interface
> - Collected Acked-by
>
> Changes since v5:
> - Adapt to new i2c_of_probe_component() parameters
>
> Changes since v4:
> - Fix Kconfig dependency
> - Update copyright year
> - Drop "linux/of.h" header
> - Include "linux/errno.h"
> - Move |int ret| declaration to top of block
> - Return -ENODEV on no match instead of 0
> - Unregister platform driver and device unconditionally after previous
>   change
>
> Changes since v3:
> - Include linux/init.h
> - Rewrite for loop in driver probe function as suggested by Andy
> - Make prober driver buildable as module
> - Ignore prober errors other than probe deferral
>
> Changes since v2:
> - Addressed Rob's comments
>   - Move remaining driver code to drivers/platform/chrome/
>   - Depend on rather than select CONFIG_I2C
>   - Copy machine check to driver init function
> - Addressed Andy's comments
>   - Explicitly mention "device tree" or OF in driver name, description
>     and Kconfig symbol
>   - Drop filename from inside the file
>   - Switch to passing "struct device *" to shorten lines
>   - Move "ret =3D 0" to just before for_each_child_of_node(i2c_node, node=
)
>   - Make loop variable size_t (instead of unsigned int as Andy asked)
>   - Use PLATFORM_DEVID_NONE instead of raw -1
>   - Use standard goto error path pattern in hw_prober_driver_init()
>
> - Changes since v1:
>   - New patch
> ---
>  drivers/platform/chrome/Kconfig               |  11 ++
>  drivers/platform/chrome/Makefile              |   1 +
>  .../platform/chrome/chromeos_of_hw_prober.c   | 140 ++++++++++++++++++
>  3 files changed, 152 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

