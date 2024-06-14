Return-Path: <linux-kernel+bounces-215318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938B909117
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB41F267AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69A19ADA2;
	Fri, 14 Jun 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzJQ1DHa"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE52B9A5;
	Fri, 14 Jun 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384981; cv=none; b=eEzMixqGIqM7lknBfKDENpF2PEx5eCj938nRYO2AGoBuPX8y0+h+h4l8lYRicsIaXHLP+hH+Lyx9nLg8UdfwjNxWVurNRo5wXhF1PyE9seVVekASnZvF9KOjzzTHqerqVBFHKS8ya9VfRmvZ97JfyjRCuevkJ5rqP7/Ewn07Ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384981; c=relaxed/simple;
	bh=Tn/d1isCjdWqAxJYbS1RaHVWp9PYepuqPATjUsKPM9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/c+dipQ1MRLwdMnOpovgzymKndxrzRy379GU63kG5yK2RP9/NB6GK/ftOxusi53QVTxEZmoXe9AMnLuKNIgjS81VSzZe0vZFWfKojCiFJqGWANMcaOWnovt5DLHV7NLJAZ6XG7YIjZxp4IHPpZAcuCaffuVuGZil7dMH0v+EG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzJQ1DHa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f0e153eddso328320466b.0;
        Fri, 14 Jun 2024 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718384976; x=1718989776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEnTD5h4NgQuI5mToEEs+mhp8KzmqC68hjRgyGjlaGs=;
        b=VzJQ1DHaojurKp2EZ2bNmQ+L5DtaeWalljjPQ3CXtSoy1NtxfstCu/RWqtrBn4cjY5
         unAFTiSoxK7Jtk8BPkk0TtrLMlyvfFfkIPnTauZWUn5hqNghCSN5HbAb35e9IPns12Dw
         iZYThkq2Zh4n+QwyUUBnbOsRVSkbaXJm5Z0j5x21+ugcffeDYFpG9pH4TrttjIOhE+BE
         JTTGzrxdhw/pGXySnvuhBOzmr7S7MmQ6goneJRd/elsBvgJ/3FX3rweDLvAcR2cCwtuH
         0T1tsPt/cx0KTBm9SBd6AN3rymGdOUc0+Jz3LzkuQFv+LGG8eFl1RNjlfKMLcBrdzQrV
         nxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718384976; x=1718989776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEnTD5h4NgQuI5mToEEs+mhp8KzmqC68hjRgyGjlaGs=;
        b=iEa9ONvxkUzyRKUDYiZbbri7HBuFa4YZ6RbIPLb5MeCPYxA5zqsbaQWZEsdGfsy8lI
         3okqB+Uzcd33ol/r/XjHTk+8+ZMt2ybQiJFF60bTmxRQe7anIR0KNiFAWggHRFlf7oMC
         +b2HFQ4vJ/JEBlCjaQ9WjUvf2uC1hfkLGrkt73Y+K+qzT4DOmcAe7rq6shh+fivdVVRm
         mVJs+9osZ88ff77c4ASvt9qgLJkwLF3VcepYG1rRJ990mcneoI5Sw+4fUsWWrM7PQg4+
         27cOJAEd1teoVG28bjhbqXHmgROVGtGq55i95qlW3UcG6vc7c/BUh3UQUSavouZl208f
         o4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVH5Oc9kIbiH4uOV/BGe/SKJT9OC8mq9t9mLawPUcLjj1Znvh7lW/pgIjR75GD22ca5FubGUmUvx1sDA5ccozSDqalm6lxEG9nkcVyJzQT4xS6ClVchrZCGV2J/vk441aQKLdOTZbNhXQ==
X-Gm-Message-State: AOJu0YwpJ+yVECY0F8QZi72dusq/iLU84RStF2h6+nqQ7mCLr4Ogm+XG
	lLylTxFrCNnNblS6cjsGZ5IqJVxv2qfiNyVURkywyGNL65rBJwI=
X-Google-Smtp-Source: AGHT+IEex5CJglFDoSoxHeIaMxf9NisE/+aupc3CmcSK71Jfj+qd6xTWSKhqG8uoozTaDAGMXgM7fA==
X-Received: by 2002:a17:906:57c2:b0:a6f:eb8:801a with SMTP id a640c23a62f3a-a6f60dc51c7mr203218066b.56.1718384975752;
        Fri, 14 Jun 2024 10:09:35 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:acea:267f:be5:ea8f? ([2a02:810b:f40:4600:acea:267f:be5:ea8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa415dsm206216266b.220.2024.06.14.10.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 10:09:35 -0700 (PDT)
Message-ID: <4102bac5-897a-4b2f-b1d3-b2833fe69f4b@gmail.com>
Date: Fri, 14 Jun 2024 19:09:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/panel: jd9365da: Modify the method of sending
 commands
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 dmitry.torokhov@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org,
 benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.06.24 um 16:55 schrieb Zhaoxiong Lv:
> Currently, the init_code of the jd9365da driver is placed
> in the enable() function and sent, but this seems to take
> a long time. It takes 17ms to send each instruction (an init
> code consists of about 200 instructions), so it takes
> about 3.5s to send the init_code. So we moved the sending

That's certainly a dsi host issue (to slow AHB/APB host clock?). With a 
Synopsis DSI host it takes < 10 ms when called in .enable.

> of the inti_code to the prepare() function, and each
> instruction seemed to take only 25μs.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 781 +++++++++---------
>   1 file changed, 393 insertions(+), 388 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 4879835fe101..b39f01d7002e 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -19,17 +19,13 @@
>   #include <linux/of.h>
>   #include <linux/regulator/consumer.h>
>   
> -#define JD9365DA_INIT_CMD_LEN		2
> -
> -struct jadard_init_cmd {
> -	u8 data[JD9365DA_INIT_CMD_LEN];
> -};
> +struct jadard;
>   
>   struct jadard_panel_desc {
>   	const struct drm_display_mode mode;
>   	unsigned int lanes;
>   	enum mipi_dsi_pixel_format format;
> -	const struct jadard_init_cmd *init_cmds;
> +	int (*init)(struct jadard *jadard);
>   	u32 num_init_cmds;
>   };
>   
> @@ -52,21 +48,9 @@ static int jadard_enable(struct drm_panel *panel)
>   {
>   	struct device *dev = panel->dev;
>   	struct jadard *jadard = panel_to_jadard(panel);
> -	const struct jadard_panel_desc *desc = jadard->desc;
>   	struct mipi_dsi_device *dsi = jadard->dsi;
> -	unsigned int i;
>   	int err;
>   
> -	msleep(10);
> -
> -	for (i = 0; i < desc->num_init_cmds; i++) {
> -		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
> -
> -		err = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
> -		if (err < 0)
> -			return err;
> -	}
Why did you remove that and instead of just make 
mipi_dsi_dcs_write_buffer to mipi_dsi_dcs_write_seq_multi and call it in 
.prepare if you think that improves anything? The code looks rather ugly 
now, imho.

Alex
> -
>   	msleep(120);
>   
>   	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
> @@ -117,9 +101,21 @@ static int jadard_prepare(struct drm_panel *panel)
>   	msleep(10);
>   
>   	gpiod_set_value(jadard->reset, 1);
> -	msleep(120);
> +	msleep(130);
> +
> +	ret = jadard->desc->init(jadard);
> +	if (ret < 0)
> +		goto poweroff;
>   
>   	return 0;
> +
> +poweroff:
> +	gpiod_set_value(jadard->reset, 0);
> +		/* T6: 2ms */
> +	usleep_range(1000, 2000);
> +	regulator_disable(jadard->vccio);
> +
> +	return ret;
>   }
>   
>   static int jadard_unprepare(struct drm_panel *panel)
> @@ -167,176 +163,181 @@ static const struct drm_panel_funcs jadard_funcs = {
>   	.get_modes = jadard_get_modes,
>   };
>   
> -static const struct jadard_init_cmd radxa_display_8hd_ad002_init_cmds[] = {
> -	{ .data = { 0xE0, 0x00 } },
> -	{ .data = { 0xE1, 0x93 } },
> -	{ .data = { 0xE2, 0x65 } },
> -	{ .data = { 0xE3, 0xF8 } },
> -	{ .data = { 0x80, 0x03 } },
> -	{ .data = { 0xE0, 0x01 } },
> -	{ .data = { 0x00, 0x00 } },
> -	{ .data = { 0x01, 0x7E } },
> -	{ .data = { 0x03, 0x00 } },
> -	{ .data = { 0x04, 0x65 } },
> -	{ .data = { 0x0C, 0x74 } },
> -	{ .data = { 0x17, 0x00 } },
> -	{ .data = { 0x18, 0xB7 } },
> -	{ .data = { 0x19, 0x00 } },
> -	{ .data = { 0x1A, 0x00 } },
> -	{ .data = { 0x1B, 0xB7 } },
> -	{ .data = { 0x1C, 0x00 } },
> -	{ .data = { 0x24, 0xFE } },
> -	{ .data = { 0x37, 0x19 } },
> -	{ .data = { 0x38, 0x05 } },
> -	{ .data = { 0x39, 0x00 } },
> -	{ .data = { 0x3A, 0x01 } },
> -	{ .data = { 0x3B, 0x01 } },
> -	{ .data = { 0x3C, 0x70 } },
> -	{ .data = { 0x3D, 0xFF } },
> -	{ .data = { 0x3E, 0xFF } },
> -	{ .data = { 0x3F, 0xFF } },
> -	{ .data = { 0x40, 0x06 } },
> -	{ .data = { 0x41, 0xA0 } },
> -	{ .data = { 0x43, 0x1E } },
> -	{ .data = { 0x44, 0x0F } },
> -	{ .data = { 0x45, 0x28 } },
> -	{ .data = { 0x4B, 0x04 } },
> -	{ .data = { 0x55, 0x02 } },
> -	{ .data = { 0x56, 0x01 } },
> -	{ .data = { 0x57, 0xA9 } },
> -	{ .data = { 0x58, 0x0A } },
> -	{ .data = { 0x59, 0x0A } },
> -	{ .data = { 0x5A, 0x37 } },
> -	{ .data = { 0x5B, 0x19 } },
> -	{ .data = { 0x5D, 0x78 } },
> -	{ .data = { 0x5E, 0x63 } },
> -	{ .data = { 0x5F, 0x54 } },
> -	{ .data = { 0x60, 0x49 } },
> -	{ .data = { 0x61, 0x45 } },
> -	{ .data = { 0x62, 0x38 } },
> -	{ .data = { 0x63, 0x3D } },
> -	{ .data = { 0x64, 0x28 } },
> -	{ .data = { 0x65, 0x43 } },
> -	{ .data = { 0x66, 0x41 } },
> -	{ .data = { 0x67, 0x43 } },
> -	{ .data = { 0x68, 0x62 } },
> -	{ .data = { 0x69, 0x50 } },
> -	{ .data = { 0x6A, 0x57 } },
> -	{ .data = { 0x6B, 0x49 } },
> -	{ .data = { 0x6C, 0x44 } },
> -	{ .data = { 0x6D, 0x37 } },
> -	{ .data = { 0x6E, 0x23 } },
> -	{ .data = { 0x6F, 0x10 } },
> -	{ .data = { 0x70, 0x78 } },
> -	{ .data = { 0x71, 0x63 } },
> -	{ .data = { 0x72, 0x54 } },
> -	{ .data = { 0x73, 0x49 } },
> -	{ .data = { 0x74, 0x45 } },
> -	{ .data = { 0x75, 0x38 } },
> -	{ .data = { 0x76, 0x3D } },
> -	{ .data = { 0x77, 0x28 } },
> -	{ .data = { 0x78, 0x43 } },
> -	{ .data = { 0x79, 0x41 } },
> -	{ .data = { 0x7A, 0x43 } },
> -	{ .data = { 0x7B, 0x62 } },
> -	{ .data = { 0x7C, 0x50 } },
> -	{ .data = { 0x7D, 0x57 } },
> -	{ .data = { 0x7E, 0x49 } },
> -	{ .data = { 0x7F, 0x44 } },
> -	{ .data = { 0x80, 0x37 } },
> -	{ .data = { 0x81, 0x23 } },
> -	{ .data = { 0x82, 0x10 } },
> -	{ .data = { 0xE0, 0x02 } },
> -	{ .data = { 0x00, 0x47 } },
> -	{ .data = { 0x01, 0x47 } },
> -	{ .data = { 0x02, 0x45 } },
> -	{ .data = { 0x03, 0x45 } },
> -	{ .data = { 0x04, 0x4B } },
> -	{ .data = { 0x05, 0x4B } },
> -	{ .data = { 0x06, 0x49 } },
> -	{ .data = { 0x07, 0x49 } },
> -	{ .data = { 0x08, 0x41 } },
> -	{ .data = { 0x09, 0x1F } },
> -	{ .data = { 0x0A, 0x1F } },
> -	{ .data = { 0x0B, 0x1F } },
> -	{ .data = { 0x0C, 0x1F } },
> -	{ .data = { 0x0D, 0x1F } },
> -	{ .data = { 0x0E, 0x1F } },
> -	{ .data = { 0x0F, 0x5F } },
> -	{ .data = { 0x10, 0x5F } },
> -	{ .data = { 0x11, 0x57 } },
> -	{ .data = { 0x12, 0x77 } },
> -	{ .data = { 0x13, 0x35 } },
> -	{ .data = { 0x14, 0x1F } },
> -	{ .data = { 0x15, 0x1F } },
> -	{ .data = { 0x16, 0x46 } },
> -	{ .data = { 0x17, 0x46 } },
> -	{ .data = { 0x18, 0x44 } },
> -	{ .data = { 0x19, 0x44 } },
> -	{ .data = { 0x1A, 0x4A } },
> -	{ .data = { 0x1B, 0x4A } },
> -	{ .data = { 0x1C, 0x48 } },
> -	{ .data = { 0x1D, 0x48 } },
> -	{ .data = { 0x1E, 0x40 } },
> -	{ .data = { 0x1F, 0x1F } },
> -	{ .data = { 0x20, 0x1F } },
> -	{ .data = { 0x21, 0x1F } },
> -	{ .data = { 0x22, 0x1F } },
> -	{ .data = { 0x23, 0x1F } },
> -	{ .data = { 0x24, 0x1F } },
> -	{ .data = { 0x25, 0x5F } },
> -	{ .data = { 0x26, 0x5F } },
> -	{ .data = { 0x27, 0x57 } },
> -	{ .data = { 0x28, 0x77 } },
> -	{ .data = { 0x29, 0x35 } },
> -	{ .data = { 0x2A, 0x1F } },
> -	{ .data = { 0x2B, 0x1F } },
> -	{ .data = { 0x58, 0x40 } },
> -	{ .data = { 0x59, 0x00 } },
> -	{ .data = { 0x5A, 0x00 } },
> -	{ .data = { 0x5B, 0x10 } },
> -	{ .data = { 0x5C, 0x06 } },
> -	{ .data = { 0x5D, 0x40 } },
> -	{ .data = { 0x5E, 0x01 } },
> -	{ .data = { 0x5F, 0x02 } },
> -	{ .data = { 0x60, 0x30 } },
> -	{ .data = { 0x61, 0x01 } },
> -	{ .data = { 0x62, 0x02 } },
> -	{ .data = { 0x63, 0x03 } },
> -	{ .data = { 0x64, 0x6B } },
> -	{ .data = { 0x65, 0x05 } },
> -	{ .data = { 0x66, 0x0C } },
> -	{ .data = { 0x67, 0x73 } },
> -	{ .data = { 0x68, 0x09 } },
> -	{ .data = { 0x69, 0x03 } },
> -	{ .data = { 0x6A, 0x56 } },
> -	{ .data = { 0x6B, 0x08 } },
> -	{ .data = { 0x6C, 0x00 } },
> -	{ .data = { 0x6D, 0x04 } },
> -	{ .data = { 0x6E, 0x04 } },
> -	{ .data = { 0x6F, 0x88 } },
> -	{ .data = { 0x70, 0x00 } },
> -	{ .data = { 0x71, 0x00 } },
> -	{ .data = { 0x72, 0x06 } },
> -	{ .data = { 0x73, 0x7B } },
> -	{ .data = { 0x74, 0x00 } },
> -	{ .data = { 0x75, 0xF8 } },
> -	{ .data = { 0x76, 0x00 } },
> -	{ .data = { 0x77, 0xD5 } },
> -	{ .data = { 0x78, 0x2E } },
> -	{ .data = { 0x79, 0x12 } },
> -	{ .data = { 0x7A, 0x03 } },
> -	{ .data = { 0x7B, 0x00 } },
> -	{ .data = { 0x7C, 0x00 } },
> -	{ .data = { 0x7D, 0x03 } },
> -	{ .data = { 0x7E, 0x7B } },
> -	{ .data = { 0xE0, 0x04 } },
> -	{ .data = { 0x00, 0x0E } },
> -	{ .data = { 0x02, 0xB3 } },
> -	{ .data = { 0x09, 0x60 } },
> -	{ .data = { 0x0E, 0x2A } },
> -	{ .data = { 0x36, 0x59 } },
> -	{ .data = { 0xE0, 0x00 } },
> +static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xB7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xB7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xFE);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xA0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xA9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x54);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x3D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x54);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x3D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x4B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x4B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x0C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x7B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xF8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xD5);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x7B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x2A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
> +
> +	return 0;
>   };
>   
>   static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
> @@ -359,205 +360,209 @@ static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
>   	},
>   	.lanes = 4,
>   	.format = MIPI_DSI_FMT_RGB888,
> -	.init_cmds = radxa_display_8hd_ad002_init_cmds,
> -	.num_init_cmds = ARRAY_SIZE(radxa_display_8hd_ad002_init_cmds),
> +	.init = radxa_display_8hd_ad002_init_cmds,
>   };
>   
> -static const struct jadard_init_cmd cz101b4001_init_cmds[] = {
> -	{ .data = { 0xE0, 0x00 } },
> -	{ .data = { 0xE1, 0x93 } },
> -	{ .data = { 0xE2, 0x65 } },
> -	{ .data = { 0xE3, 0xF8 } },
> -	{ .data = { 0x80, 0x03 } },
> -	{ .data = { 0xE0, 0x01 } },
> -	{ .data = { 0x00, 0x00 } },
> -	{ .data = { 0x01, 0x3B } },
> -	{ .data = { 0x0C, 0x74 } },
> -	{ .data = { 0x17, 0x00 } },
> -	{ .data = { 0x18, 0xAF } },
> -	{ .data = { 0x19, 0x00 } },
> -	{ .data = { 0x1A, 0x00 } },
> -	{ .data = { 0x1B, 0xAF } },
> -	{ .data = { 0x1C, 0x00 } },
> -	{ .data = { 0x35, 0x26 } },
> -	{ .data = { 0x37, 0x09 } },
> -	{ .data = { 0x38, 0x04 } },
> -	{ .data = { 0x39, 0x00 } },
> -	{ .data = { 0x3A, 0x01 } },
> -	{ .data = { 0x3C, 0x78 } },
> -	{ .data = { 0x3D, 0xFF } },
> -	{ .data = { 0x3E, 0xFF } },
> -	{ .data = { 0x3F, 0x7F } },
> -	{ .data = { 0x40, 0x06 } },
> -	{ .data = { 0x41, 0xA0 } },
> -	{ .data = { 0x42, 0x81 } },
> -	{ .data = { 0x43, 0x14 } },
> -	{ .data = { 0x44, 0x23 } },
> -	{ .data = { 0x45, 0x28 } },
> -	{ .data = { 0x55, 0x02 } },
> -	{ .data = { 0x57, 0x69 } },
> -	{ .data = { 0x59, 0x0A } },
> -	{ .data = { 0x5A, 0x2A } },
> -	{ .data = { 0x5B, 0x17 } },
> -	{ .data = { 0x5D, 0x7F } },
> -	{ .data = { 0x5E, 0x6B } },
> -	{ .data = { 0x5F, 0x5C } },
> -	{ .data = { 0x60, 0x4F } },
> -	{ .data = { 0x61, 0x4D } },
> -	{ .data = { 0x62, 0x3F } },
> -	{ .data = { 0x63, 0x42 } },
> -	{ .data = { 0x64, 0x2B } },
> -	{ .data = { 0x65, 0x44 } },
> -	{ .data = { 0x66, 0x43 } },
> -	{ .data = { 0x67, 0x43 } },
> -	{ .data = { 0x68, 0x63 } },
> -	{ .data = { 0x69, 0x52 } },
> -	{ .data = { 0x6A, 0x5A } },
> -	{ .data = { 0x6B, 0x4F } },
> -	{ .data = { 0x6C, 0x4E } },
> -	{ .data = { 0x6D, 0x20 } },
> -	{ .data = { 0x6E, 0x0F } },
> -	{ .data = { 0x6F, 0x00 } },
> -	{ .data = { 0x70, 0x7F } },
> -	{ .data = { 0x71, 0x6B } },
> -	{ .data = { 0x72, 0x5C } },
> -	{ .data = { 0x73, 0x4F } },
> -	{ .data = { 0x74, 0x4D } },
> -	{ .data = { 0x75, 0x3F } },
> -	{ .data = { 0x76, 0x42 } },
> -	{ .data = { 0x77, 0x2B } },
> -	{ .data = { 0x78, 0x44 } },
> -	{ .data = { 0x79, 0x43 } },
> -	{ .data = { 0x7A, 0x43 } },
> -	{ .data = { 0x7B, 0x63 } },
> -	{ .data = { 0x7C, 0x52 } },
> -	{ .data = { 0x7D, 0x5A } },
> -	{ .data = { 0x7E, 0x4F } },
> -	{ .data = { 0x7F, 0x4E } },
> -	{ .data = { 0x80, 0x20 } },
> -	{ .data = { 0x81, 0x0F } },
> -	{ .data = { 0x82, 0x00 } },
> -	{ .data = { 0xE0, 0x02 } },
> -	{ .data = { 0x00, 0x02 } },
> -	{ .data = { 0x01, 0x02 } },
> -	{ .data = { 0x02, 0x00 } },
> -	{ .data = { 0x03, 0x00 } },
> -	{ .data = { 0x04, 0x1E } },
> -	{ .data = { 0x05, 0x1E } },
> -	{ .data = { 0x06, 0x1F } },
> -	{ .data = { 0x07, 0x1F } },
> -	{ .data = { 0x08, 0x1F } },
> -	{ .data = { 0x09, 0x17 } },
> -	{ .data = { 0x0A, 0x17 } },
> -	{ .data = { 0x0B, 0x37 } },
> -	{ .data = { 0x0C, 0x37 } },
> -	{ .data = { 0x0D, 0x47 } },
> -	{ .data = { 0x0E, 0x47 } },
> -	{ .data = { 0x0F, 0x45 } },
> -	{ .data = { 0x10, 0x45 } },
> -	{ .data = { 0x11, 0x4B } },
> -	{ .data = { 0x12, 0x4B } },
> -	{ .data = { 0x13, 0x49 } },
> -	{ .data = { 0x14, 0x49 } },
> -	{ .data = { 0x15, 0x1F } },
> -	{ .data = { 0x16, 0x01 } },
> -	{ .data = { 0x17, 0x01 } },
> -	{ .data = { 0x18, 0x00 } },
> -	{ .data = { 0x19, 0x00 } },
> -	{ .data = { 0x1A, 0x1E } },
> -	{ .data = { 0x1B, 0x1E } },
> -	{ .data = { 0x1C, 0x1F } },
> -	{ .data = { 0x1D, 0x1F } },
> -	{ .data = { 0x1E, 0x1F } },
> -	{ .data = { 0x1F, 0x17 } },
> -	{ .data = { 0x20, 0x17 } },
> -	{ .data = { 0x21, 0x37 } },
> -	{ .data = { 0x22, 0x37 } },
> -	{ .data = { 0x23, 0x46 } },
> -	{ .data = { 0x24, 0x46 } },
> -	{ .data = { 0x25, 0x44 } },
> -	{ .data = { 0x26, 0x44 } },
> -	{ .data = { 0x27, 0x4A } },
> -	{ .data = { 0x28, 0x4A } },
> -	{ .data = { 0x29, 0x48 } },
> -	{ .data = { 0x2A, 0x48 } },
> -	{ .data = { 0x2B, 0x1F } },
> -	{ .data = { 0x2C, 0x01 } },
> -	{ .data = { 0x2D, 0x01 } },
> -	{ .data = { 0x2E, 0x00 } },
> -	{ .data = { 0x2F, 0x00 } },
> -	{ .data = { 0x30, 0x1F } },
> -	{ .data = { 0x31, 0x1F } },
> -	{ .data = { 0x32, 0x1E } },
> -	{ .data = { 0x33, 0x1E } },
> -	{ .data = { 0x34, 0x1F } },
> -	{ .data = { 0x35, 0x17 } },
> -	{ .data = { 0x36, 0x17 } },
> -	{ .data = { 0x37, 0x37 } },
> -	{ .data = { 0x38, 0x37 } },
> -	{ .data = { 0x39, 0x08 } },
> -	{ .data = { 0x3A, 0x08 } },
> -	{ .data = { 0x3B, 0x0A } },
> -	{ .data = { 0x3C, 0x0A } },
> -	{ .data = { 0x3D, 0x04 } },
> -	{ .data = { 0x3E, 0x04 } },
> -	{ .data = { 0x3F, 0x06 } },
> -	{ .data = { 0x40, 0x06 } },
> -	{ .data = { 0x41, 0x1F } },
> -	{ .data = { 0x42, 0x02 } },
> -	{ .data = { 0x43, 0x02 } },
> -	{ .data = { 0x44, 0x00 } },
> -	{ .data = { 0x45, 0x00 } },
> -	{ .data = { 0x46, 0x1F } },
> -	{ .data = { 0x47, 0x1F } },
> -	{ .data = { 0x48, 0x1E } },
> -	{ .data = { 0x49, 0x1E } },
> -	{ .data = { 0x4A, 0x1F } },
> -	{ .data = { 0x4B, 0x17 } },
> -	{ .data = { 0x4C, 0x17 } },
> -	{ .data = { 0x4D, 0x37 } },
> -	{ .data = { 0x4E, 0x37 } },
> -	{ .data = { 0x4F, 0x09 } },
> -	{ .data = { 0x50, 0x09 } },
> -	{ .data = { 0x51, 0x0B } },
> -	{ .data = { 0x52, 0x0B } },
> -	{ .data = { 0x53, 0x05 } },
> -	{ .data = { 0x54, 0x05 } },
> -	{ .data = { 0x55, 0x07 } },
> -	{ .data = { 0x56, 0x07 } },
> -	{ .data = { 0x57, 0x1F } },
> -	{ .data = { 0x58, 0x40 } },
> -	{ .data = { 0x5B, 0x30 } },
> -	{ .data = { 0x5C, 0x16 } },
> -	{ .data = { 0x5D, 0x34 } },
> -	{ .data = { 0x5E, 0x05 } },
> -	{ .data = { 0x5F, 0x02 } },
> -	{ .data = { 0x63, 0x00 } },
> -	{ .data = { 0x64, 0x6A } },
> -	{ .data = { 0x67, 0x73 } },
> -	{ .data = { 0x68, 0x1D } },
> -	{ .data = { 0x69, 0x08 } },
> -	{ .data = { 0x6A, 0x6A } },
> -	{ .data = { 0x6B, 0x08 } },
> -	{ .data = { 0x6C, 0x00 } },
> -	{ .data = { 0x6D, 0x00 } },
> -	{ .data = { 0x6E, 0x00 } },
> -	{ .data = { 0x6F, 0x88 } },
> -	{ .data = { 0x75, 0xFF } },
> -	{ .data = { 0x77, 0xDD } },
> -	{ .data = { 0x78, 0x3F } },
> -	{ .data = { 0x79, 0x15 } },
> -	{ .data = { 0x7A, 0x17 } },
> -	{ .data = { 0x7D, 0x14 } },
> -	{ .data = { 0x7E, 0x82 } },
> -	{ .data = { 0xE0, 0x04 } },
> -	{ .data = { 0x00, 0x0E } },
> -	{ .data = { 0x02, 0xB3 } },
> -	{ .data = { 0x09, 0x61 } },
> -	{ .data = { 0x0E, 0x48 } },
> -	{ .data = { 0xE0, 0x00 } },
> -	{ .data = { 0xE6, 0x02 } },
> -	{ .data = { 0xE7, 0x0C } },
> +static int cz101b4001_init_cmds(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xAF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xAF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xA0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x81);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x69);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x2A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x6B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x5C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x42);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x52);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x5A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x4E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x42);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x52);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x5A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x4E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x4B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2C, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2D, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2E, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2F, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4A, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4C, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4D, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4E, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4F, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x1D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x6A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xDD);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x82);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE6, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE7, 0x0C);
> +
> +	return 0;
>   };
>   
>   static const struct jadard_panel_desc cz101b4001_desc = {
> @@ -580,8 +585,8 @@ static const struct jadard_panel_desc cz101b4001_desc = {
>   	},
>   	.lanes = 4,
>   	.format = MIPI_DSI_FMT_RGB888,
> -	.init_cmds = cz101b4001_init_cmds,
> -	.num_init_cmds = ARRAY_SIZE(cz101b4001_init_cmds),
> +	.init = cz101b4001_init_cmds,
> +
>   };
>   
>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)


