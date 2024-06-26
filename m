Return-Path: <linux-kernel+bounces-230353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE4917BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CF31C21E17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE964166310;
	Wed, 26 Jun 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3R7tCapy"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767215ECF7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392550; cv=none; b=Ibq3HZp0mWlktf9FLRsz96xhrQGkdmGx6gK8y8DytmZhZrwJUEReQ5dsKGrqI2fs7nmqrUiS9QPaRfZMQazF0JWRXCslpG4/mlGzvvoYFiZU7GecAswJ0gZc14m7M7sGFxxgYv4TwclSvTLI4wwUPX7WJesOmTgO7mDBXBDsmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392550; c=relaxed/simple;
	bh=+U75moA0IOcTF8Mg2ZA6R6dIZbLjLcURR2ucwEYEtdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzEIvJS5ucNh6BTO1nL5VvjdNA61fQKd0VS5B4Lsu1HWQO0eSyCcUXgZt3m4zQmca/QpgVYchI8dvJlYyVTYLOjeB13wBs2rR0rf2JlrNIgiE2rHpaIbBi5q8T2hkO2gtxfmpBhIzk+ZYWBYUJ4uxguQ4/ebrRH0UK7+mbScpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3R7tCapy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso5699709e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719392546; x=1719997346; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2idBZgptzvkcKjgaYWXZ29bOmlTpQUWB+7MaeYkOqsM=;
        b=3R7tCapyU+E5EFkHhnyNosuDEjVISzxLS8V1waSi62Opg/gVtB1QPIWlcWgTZ9RmlT
         lp0Ac7xmKtNpGKAk0XLdbT+DXi3jFPYlrWn2S9eYUhxJ6PhLk/q3frK88oHNESDoTWsB
         fgBe9xjC60MqC/PBomeWkMmDw6ZMnfzdXSQx6p3EmFOsnVjlDeceTK8qebKvHlWGJqjx
         CG36OoOMYNeMoK5ZWtBpZgiaEOw+sX/ESD3QSfPGWbR0hDaXYuLAritmf1NkN+VQuw/d
         a3Z65NZ52b3rR1cPn57mgB6MESoq8Mlr5FyDXeJWxiiLlgzB6KKUqt8deX4+rjigjFPU
         b3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392546; x=1719997346;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2idBZgptzvkcKjgaYWXZ29bOmlTpQUWB+7MaeYkOqsM=;
        b=bG2eTJpEIcmmYd+8BKmiakAom5WHjw6BmifE0g+DZxwchD1GfDSEPYCYKbfGEXq7WL
         GtQ9LSJrHy4PL4DXkyYMLbkfnUjJEOBmsqLZFWdPUU2UXWMi8qhr73/D/k9VOoQYzSyE
         dWo8tBUgpfs7EfRPVuHiP77rDpn2Zpm0PMLd3nJ9SRBZDcwDO2RKSXwXzu6Purnizh/0
         Gi6nzAIzM4wk/cXMwzYm/VPD1CaeBa8PhIqXYYV/j8NTgCWjwDmPrD3/G+iQ6B+Gpuvd
         zEPNXAYFgO4O+hlq6WIGp/xvfdJoOX69xIgAqvp7yIy3ZobS/JhCJkxPZShcS/mUYU8l
         runQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZ5rteXFSqp3naw6Ij2MF8ALkgOscumvuP5VSf1HFgXIDLvmGzWNzUB1XRXOMwOhkYNubLXCGt0ypVdI2zeDq9skoshpRak3zdhDZ
X-Gm-Message-State: AOJu0YwyEW7iDUl70GmzWo4h/FWYE28d4dyLHJYLdDiPQliJzoSEEEY4
	vDb+S9pyi4/o4ul4pdWV51huvDwLlqd+oTHn0oGdjOz3uWNBZTFMo73Z9s18iLw=
X-Google-Smtp-Source: AGHT+IE96WCuEHxhwRY3kAhR5wUw+y9sH2sXQqGFnioVeB4yEHN2JU/Kt4AO4+8FYsl7G+N7Li1Qbg==
X-Received: by 2002:a05:6512:304b:b0:52c:ec24:e3ea with SMTP id 2adb3069b0e04-52cec24e4f4mr4757544e87.10.1719392546450;
        Wed, 26 Jun 2024 02:02:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:7be7:aef1:af9e:fff6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8424606sm17627005e9.30.2024.06.26.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:02:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Jessica Zhang
 <quic_jesszhan@quicinc.com>,  Sam Ravnborg <sam@ravnborg.org>,  Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>,  David
 Airlie <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panel: add lincoln lcd197 support
In-Reply-To: <irzer3be5fj2rg2bmc2oqxqtaw6jybbdkgv3jgxpyhdvojwv24@e4i2v6d454nz>
	(Dmitry Baryshkov's message of "Wed, 26 Jun 2024 07:41:45 +0300")
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
	<20240625142552.1000988-4-jbrunet@baylibre.com>
	<irzer3be5fj2rg2bmc2oqxqtaw6jybbdkgv3jgxpyhdvojwv24@e4i2v6d454nz>
Date: Wed, 26 Jun 2024 11:02:25 +0200
Message-ID: <1jmsn8gjq6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 26 Jun 2024 at 07:41, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Tue, Jun 25, 2024 at 04:25:50PM GMT, Jerome Brunet wrote:
>> Add support for the Lincoln LCD197 1080x1920 DSI panel.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                |  11 +
>>  drivers/gpu/drm/panel/Makefile               |   1 +
>>  drivers/gpu/drm/panel/panel-lincoln-lcd197.c | 333 +++++++++++++++++++
>>  3 files changed, 345 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-lincoln-lcd197.c
>> 
>
> [...]
>
>> +
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB9, 0xFF, 0x83, 0x99);
>
> - Please use lowercase hex instead
> - Please consider switching to _multi() functions.

Could you be a bit more specific about these '_multi' function ?
I've looked at 'drm_mipi_dsi.h' and can't really make what you mean.

Maybe I'm not looking in the right place.

>
>
>> +	usleep_range(200, 300);
>
> This will require new helper msm_dsi_usleep_range(ctx, 200, 300);

I don't really understand why I would need something else to just sleep
? Could you add some context please ?

Isn't 'msm_' usually something Qcom specific ?

>
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB6, 0x92, 0x92);
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xCC, 0x00);
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBF, 0x40, 0x41, 0x50, 0x49);
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC6, 0xFF, 0xF9);
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC0, 0x25, 0x5A);
>> +	mipi_dsi_dcs_write_seq(lcd->dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
>> +
>> +	err = mipi_dsi_dcs_exit_sleep_mode(lcd->dsi);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
>> +		goto poweroff;
>> +	}
>> +	msleep(120);
>> +
>> +	err = mipi_dsi_dcs_read(lcd->dsi, MIPI_DCS_GET_DISPLAY_ID, display_id, 3);
>
> This probably needs new _multi helper too.
>
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "Failed to read display id: %d\n", err);
>> +	} else {
>> +		dev_dbg(panel->dev, "Display id: 0x%02x-0x%02x-0x%02x\n",
>> +			display_id[0], display_id[1], display_id[2]);
>> +	}
>> +
>> +	lcd->prepared = true;
>
> Should not be required anymore.

The whole driver is heavily inspired by what is already in
drivers/gpu/drm/panel/ and a lot are doing something similar.

Maybe there has been a change since then and the existing have been
reworked yet. Would you mind pointing me that change if that is
the case ?

>
>> +
>> +	return 0;
>> +
>> +poweroff:
>> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
>> +	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
>> +	regulator_disable(lcd->supply);
>> +
>> +	return err;
>> +}
>> +
>
>> +
>> +static const struct drm_display_mode default_mode = {
>> +	.clock = 154002,
>> +	.hdisplay = 1080,
>> +	.hsync_start = 1080 + 20,
>> +	.hsync_end = 1080 + 20 + 6,
>> +	.htotal = 1080 + 204,
>> +	.vdisplay = 1920,
>> +	.vsync_start = 1920 + 4,
>> +	.vsync_end = 1920 + 4 + 4,
>> +	.vtotal = 1920 + 79,
>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +};
>> +
>> +static int lincoln_lcd197_panel_get_modes(struct drm_panel *panel,
>> +					  struct drm_connector *connector)
>> +{
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
>> +	if (!mode) {
>> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
>> +			default_mode.hdisplay, default_mode.vdisplay,
>> +			drm_mode_vrefresh(&default_mode));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +	drm_mode_probed_add(connector, mode);
>> +	connector->display_info.width_mm = 79;
>> +	connector->display_info.height_mm = 125;
>
> drm_connector_helper_get_modes_fixed()

Thanks for the hint

>
>> +
>> +	return 1;
>> +}
>> +
>
>
>> +
>> +static void lincoln_lcd197_panel_shutdown(struct mipi_dsi_device *dsi)
>> +{
>> +	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
>> +
>> +	drm_panel_disable(&lcd->panel);
>> +	drm_panel_unprepare(&lcd->panel);
>> +}
>
> I think the agreement was that there should be no need for the panel's
> shutdown, the DRM driver should shutdown the panel.

I'm happy to drop that if there is such agreement. Again, most panel
drivers do implement that callback so I just did the same.

Could you point me to this 'agreement' please, so I can get a better
understanding of it ? 

-- 
Jerome

