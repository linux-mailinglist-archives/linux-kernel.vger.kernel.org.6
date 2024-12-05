Return-Path: <linux-kernel+bounces-433925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD89E5ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D322821DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680D22257F;
	Thu,  5 Dec 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjIp3Lh5"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D622B8CF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427331; cv=none; b=MeG5E+M9CagyoHae2YKzzPIHSclxPW0/nk9d9JfnlsddIOvXOKaKbmtyuDMRnEI8twuoTdiB9jnm839AAEa6G1Da/a6lCahwnh0hZzK6JP0/KE0lB85F/VHGNFZ0ztLsorHPgqaODCYHc/DI9RkFuZExygohqGSKYZLYGP7qw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427331; c=relaxed/simple;
	bh=0b5CTnLqXTAsT5EGLf3h6Sw+ElEZypSl3uUclYsZVsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtnsiW3b4cVXB55Bn3pc3OCgVmVB4qI3K9TutRxgl54Vo9GVoI5+W5czdBwdjdJArplJuzOVQv3KhkS4VAkMre8jdvV2zism0+8ERkqoGt8AlgU7zSGG1Jc2IGchBVsDa/9jIMRmv7f8jhbPw3pK5pJ5If4UIoBvcTztEWeAHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjIp3Lh5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e152731d0so2125247e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733427327; x=1734032127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S8RsTdn0sMTjJIGfbeOK6kTewNAIU+Mvw8MKGo2JS8=;
        b=cjIp3Lh5yuHq9UPMJ2gfSWYAcimA0Weu4UrnN2btW1ZFiLFbCUM7pArA9UFJzEgsy7
         dS31I/kBhWfhnqyz6rtSw5JTjb9CSI/1hkLwuR/MGZ3AHlsHfdsYyScJdHB7wMQsFs3A
         oCwfdbNcCt8MAfToNOv49XTutuHE4kDiVcG6imPkbGIl0iFSYdoTTKXF7eEMIB+N2qJn
         eXn8pIKxGEZruEfHCNSC0tq7NmR9PgV5gXxRbqdUvhQvOGRNA4tGbNpGFmfc0KffQnGF
         2I61vYV7InwnFTwMu+ot7ApZd+8Je4z8GME0E2RrQXgtLO7WRRTgsmEpk/m1XSTc4d/l
         M0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427327; x=1734032127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S8RsTdn0sMTjJIGfbeOK6kTewNAIU+Mvw8MKGo2JS8=;
        b=NtIzveRJKAAKUERBGh/AdtRqOgta0vv8NqjuS0m3clXPpHu4QMuOdz5mHa7DNgK4CD
         Rm/ijWkdbeG/1gDNhsmxE67BGX3v6h31BTO2mLPFzgOdlD5JrRobz+fuCdGW2H9hZUKc
         cxQOUdLwO3UjiSib/ioxhh+zJikPPoYWGioWaoVT1mVy/eRibqvEgF5KdfoFBJN0oXej
         ZFi5Ou9UiUfw67sw+5szr0fFRAAZbRJVFdcC38nDUm4pvcdUWHfUTllIBS0H6nfifgzl
         z5asJkGdlXIWW7TAlxLUyiFeIVDKfpMnUseIKgJ6TmHP+wCP6aa0ZviWXL+GFozRgLWV
         7oug==
X-Forwarded-Encrypted: i=1; AJvYcCUAP6unUpSLt4Y9ieato99PM6tpkv7Jl/o7voctcLfOUl9HJSvqZ92RrEXeLc1gBjTEqQvMczkcaSkAT1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUlu+vlv1NxxDveapqMH8jXNKHHW5U84TfGGY5EgHdbLnT8HY
	ouiQUvktpuQixwEk17ZTkw8AUVlpy65kbhjJxNna9/8bqex++/iaQuvMMzOhom4=
X-Gm-Gg: ASbGncsj3wW0HcVH1Ab7A3nWBh/fJAiqcZk1TkqCz3eb15wOCnBGLHQvMzxwygn0xZR
	sHy6huTB0mqIBtiVLqiCiEC/Ol4xTehvf7zPLFJAbZfSZ1gliurosgiAHDswCDmANneMfBQwAGq
	b9pXrQ+e4w281MEbsSIEMcZIahrACPi1GAm5luqNYe2OawAVnY0XFclJBNnJMJP9MaH/kOWAU8T
	mujkLWymdymAxlm9OwieXZlkwF7PnMAtciLZIER6ZpsR20KqyAzhQHU1OD83JBc4hDmzSmpoFlP
	XPfWMqzKSuKweY61lteXyt/Q0VcVfA==
X-Google-Smtp-Source: AGHT+IGFrK2H/ob2QGWXfJHSb8e119RrKRAfgEocoDRBmzA04v/V3A76FGV/VQz7I65Os/Jolm+7xg==
X-Received: by 2002:a05:6512:39d3:b0:53d:f67d:d580 with SMTP id 2adb3069b0e04-53e216f02f0mr1698149e87.2.1733427327271;
        Thu, 05 Dec 2024 11:35:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca11csm317706e87.238.2024.12.05.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:35:25 -0800 (PST)
Date: Thu, 5 Dec 2024 21:35:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, jie.qiu@mediatek.com, 
	junzhi.zhao@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Message-ID: <m7u6xzm2o4dmcjot4xfk6do4slikpsp6gi3uyiuw4d35kunbc5@jyzgkrp4xjwc>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
 <4lvsvo6vsc7bipcgftsq3mzunwxoka3wjqad42ptr37oz77zub@5uarhvjmcxnc>
 <a4a74f96-29cc-4007-9b03-f634b84d9cc2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a74f96-29cc-4007-9b03-f634b84d9cc2@collabora.com>

On Thu, Dec 05, 2024 at 02:30:51PM +0100, AngeloGioacchino Del Regno wrote:
> Il 05/12/24 13:56, Dmitry Baryshkov ha scritto:
> > On Thu, Dec 05, 2024 at 12:45:17PM +0100, AngeloGioacchino Del Regno wrote:
> > > Add support for the newer HDMI-TX (Encoder) v2 and DDC v2 IPs
> > > found in MediaTek's MT8195, MT8188 SoC and their variants, and
> > > including support for display modes up to 4k60 and for HDMI
> > > Audio, as per the HDMI 2.0 spec.
> > > 
> > > HDCP and CEC functionalities are also supported by this hardware,
> > > but are not included in this commit and that also poses a slight
> > > difference between the V2 and V1 controllers in how they handle
> > > Hotplug Detection (HPD).
> > > 
> > > While the v1 controller was using the CEC controller to check
> > > HDMI cable connection and disconnection, in this driver the v2
> > > one does not.
> > > 
> > > This is due to the fact that on parts with v2 designs, like the
> > > MT8195 SoC, there is one CEC controller shared between the HDMI
> > > Transmitter (HDMI-TX) and Receiver (HDMI-RX): before eventually
> > > adding support to use the CEC HW to wake up the HDMI controllers
> > > it is necessary to have support for one TX, one RX *and* for both
> > > at the same time.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/gpu/drm/mediatek/Kconfig            |    8 +
> > >   drivers/gpu/drm/mediatek/Makefile           |    4 +
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_common.c  |    5 +
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_common.h  |    1 +
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c  |  403 +++++
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h |  263 ++++
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_v2.c      | 1488 +++++++++++++++++++
> > >   7 files changed, 2172 insertions(+)
> > >   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
> > >   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
> > >   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> > > 
> 
> ..snip..
> 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> > > new file mode 100644
> > > index 000000000000..05cbfc45be54
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> > > @@ -0,0 +1,1488 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> 
> ..snip..
> 
> > > +static int mtk_hdmi_v2_setup_audio_infoframe(struct mtk_hdmi *hdmi)
> > > +{
> > > +	struct hdmi_codec_params *params = &hdmi->aud_param.codec_params;
> > > +	struct hdmi_audio_infoframe frame;
> > > +	u8 buffer[14];
> > > +	ssize_t ret;
> > > +
> > > +	memcpy(&frame, &params->cea, sizeof(frame));
> > > +
> > > +	ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	mtk_hdmi_v2_hw_write_audio_infoframe(hdmi, buffer);
> > 
> > This should be handled via HDMI Connector framework too. There is
> > already an interface to set / clear audio infoframes.
> > als I have been working on an interface to make HDMI codec
> > implementation more generic, see [1]. Your comments are appreciated.
> > 
> > [1] https://patchwork.freedesktop.org/series/134927/
> > 
> 
> I didn't go for that because I was afraid that your series wouldn't actually
> land in the same window as this driver.

There were two points in my comment (sorry for being not explicit
enough). One is to point to the HDMI codec infra (and you are right,
it's not yet in the mergeable state). Second one is to use
drm_atomic_helper_connector_hdmi_update_audio_infoframe() and
drm_atomic_helper_connector_hdmi_clear_audio_infoframe() if possible (it
might be hard to do it - in fact it being hard kind of forced me to
work on the HDMI codec infra).

> I am at this point puzzled to whether I should add a commit on top of this
> submission that switches this driver to using the generic HDMI Codec infra
> (which could also be helpful as guidance to others trying to do the same on
> other drivers, I guess), or if I should just rebase on top of that.

I'd say, a completely separate patch might be even better, I can then
integrate it into the HDMI codec patchset, adding a soft dependency on
your series. If for some reason the codec lands earlier than your
patchset, the patch can be dropped and reintegrated into your series. Or
just committed separately.

> I'd rather add a commit on top to mainly avoid risking to delay this driver,
> but if you're absolutely certain that you can get your series merged in the
> same window as this driver I have *zero* problems in just rebasing on top.
> 
> Besides...
> 
> I'll find the time to review your series - I'm sad it didn't land earlier as
> I would've written a bit less code otherwise :-)
> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> 
> ..snip..
> 
> > > +
> > > +	/* Enable the controller at attach time for HPD/Pord feedback */
> > > +	ret = mtk_hdmi_v2_enable(hdmi);
> > > +	if (ret)
> > > +		return ret;
> > 
> > This looks like a hack. Please use .hpd_enable() / .hpd_disable()
> > callbacks.
> > 
> 
> ...but there's no way to power on only the HPD - you can either power on
> the entire controller, or nothing.
> 
> I can't call mtk_hdmi_v2_enable/disable() from the HPD callbacks.

Why? Add a powerup refcount if necessary.

> 
> Perhaps the comment should have been
> 
> "Enable the controller attach time also allows HPD/Pord feedback"?

I think it should still be explicit call from those callbacks. Consider
a platform using external GPIO to implement HPD. Then the HDMI
controller can stay disabled if it is not necessary.

> 
> > > +
> > > +	/* Enable Hotplug and Pord pins internal debouncing */
> > > +	regmap_set_bits(hdmi->regs, HPD_DDC_CTRL,
> > > +			HPD_DDC_HPD_DBNC_EN | HPD_DDC_PORD_DBNC_EN);
> > > +
> > > +	irq_clear_status_flags(hdmi->irq, IRQ_NOAUTOEN);
> > > +	enable_irq(hdmi->irq);
> > > +
> > > +	/*
> > > +	 * Check if any HDMI monitor was connected before probing this driver
> > > +	 * and/or attaching the bridge, without debouncing: if so, we want to
> > > +	 * notify the DRM so that we start outputting an image ASAP.
> > > +	 * Note that calling the ISR thread function will also perform a HW
> > > +	 * registers write that enables both the HPD and Pord interrupts.
> > > +	 */
> > > +	__mtk_hdmi_v2_isr_thread(hdmi);
> > > +
> > > +	return 0;
> > > +}
> > > +
> 
> ..snip..
> 
> > > +static void mtk_hdmi_v2_bridge_pre_enable(struct drm_bridge *bridge,
> > > +					  struct drm_bridge_state *old_state)
> > > +{
> > > +	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
> > > +	struct drm_atomic_state *state = old_state->base.state;
> > > +	struct drm_connector_state *conn_state;
> > > +	union phy_configure_opts opts = {
> > > +		.dp = { .link_rate = hdmi->mode.clock * KILO }
> > > +	};
> > > +
> > > +	/* Retrieve the connector through the atomic state */
> > > +	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> > > +
> > > +	conn_state = drm_atomic_get_new_connector_state(state, hdmi->curr_conn);
> > > +	if (WARN_ON(!conn_state))
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Preconfigure the HDMI controller and the HDMI PHY at pre_enable
> > > +	 * stage to make sure that this IP is ready and clocked before the
> > > +	 * mtk_dpi gets powered on and before it enables the output.
> > > +	 */
> > > +	hdmi->dvi_mode = !hdmi->curr_conn->display_info.is_hdmi;
> > 
> > Can you access display_info directly instead?
> > 
> 
> Nice catch. Yeah, I should've done that from the beginning. Fixed for v3.
> 
> > > +	mtk_hdmi_v2_output_set_display_mode(hdmi, &hdmi->mode);
> > > +
> > > +	/* Reconfigure phy clock link with appropriate rate */
> > > +	phy_configure(hdmi->phy, &opts);
> > > +
> > > +	/* Power on the PHY here to make sure that DPI_HDMI is clocked */
> > > +	phy_power_on(hdmi->phy);
> > > +
> > > +	hdmi->powered = true;
> > > +}
> > > +
> > > +static void mtk_hdmi_v2_bridge_enable(struct drm_bridge *bridge,
> > > +				      struct drm_bridge_state *old_state)
> > > +{
> > > +	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
> > > +	struct drm_atomic_state *state = old_state->base.state;
> > > +	int ret;
> > > +
> > > +	ret = drm_atomic_helper_connector_hdmi_update_infoframes(hdmi->curr_conn, state);
> > > +	if (ret)
> > > +		dev_err(hdmi->dev, "Could not update infoframes: %d\n", ret);
> > > +
> > > +	mtk_hdmi_v2_hw_vid_mute(hdmi, false);
> > > +	mtk_hdmi_v2_hw_aud_mute(hdmi, false);
> > > +
> > > +	/* signal the connect event to audio codec */
> > > +	mtk_hdmi_v2_handle_plugged_change(hdmi, true);
> > 
> > I think it was agreed that this should be called from the hotplug path,
> > see the (linked) HDMI codec infrastructure patchset and dicussions for
> > the previous revisions.
> > 
> 
> Okay, I'll check that out.
> 
> > > +
> > > +	hdmi->enabled = true;
> > > +}
> > > +
> 
> ..snip..
> 
> > > +
> > > +static int mtk_hdmi_v2_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> > > +						 const struct drm_display_mode *mode,
> > > +						 unsigned long long tmds_rate)
> > > +{
> > > +	if (mode->clock < MTK_HDMI_V2_CLOCK_MIN)
> > > +		return MODE_CLOCK_LOW;
> > > +	else if (mode->clock > MTK_HDMI_V2_CLOCK_MAX)
> > > +		return MODE_CLOCK_HIGH;
> > > +	else
> > > +		return MODE_OK;
> > > +}
> > > +
> > > +static enum drm_mode_status
> > > +mtk_hdmi_v2_bridge_mode_valid(struct drm_bridge *bridge,
> > > +			      const struct drm_display_info *info,
> > > +			      const struct drm_display_mode *mode)
> > > +{
> > > +	unsigned long long rate;
> > > +
> > > +	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
> > > +	return mtk_hdmi_v2_hdmi_tmds_char_rate_valid(bridge, mode, rate);
> > > +}
> > 
> > Please rebase on top of https://patchwork.freedesktop.org/series/140193/
> > There should be no need to do this manually.
> > 
> 
> Oh finally there's a helper for this. Cool, will rebase! Thanks!

And it doesn't even add an extra dependency for you.

> 
> > > +
> > > +static int mtk_hdmi_v2_hdmi_clear_infoframe(struct drm_bridge *bridge,
> > > +					    enum hdmi_infoframe_type type)
> > > +{
> > > +	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
> > > +	u32 reg_start, reg_end;
> > > +
> > > +	switch (type) {
> > > +	case HDMI_INFOFRAME_TYPE_AUDIO:
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_EN, AUD_EN | AUD_EN_WR);
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_RPT, AUD_RPT_EN);
> > > +		reg_start = TOP_AIF_HEADER;
> > > +		reg_end = TOP_AIF_PKT03;
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_AVI:
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_EN, AVI_EN_WR | AVI_EN);
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_RPT, AVI_RPT_EN);
> > > +		reg_start = TOP_AVI_HEADER;
> > > +		reg_end = TOP_AVI_PKT05;
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_SPD:
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_EN, SPD_EN_WR | SPD_EN);
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_RPT, SPD_RPT_EN);
> > > +		reg_start = TOP_SPDIF_HEADER;
> > > +		reg_end = TOP_SPDIF_PKT07;
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_VENDOR:
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_EN, VSIF_EN_WR | VSIF_EN);
> > > +		regmap_clear_bits(hdmi->regs, TOP_INFO_RPT, VSIF_RPT_EN);
> > > +		reg_start = TOP_VSIF_HEADER;
> > > +		reg_end = TOP_VSIF_PKT07;
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_DRM:
> > > +	default:
> > > +		return 0;
> > > +	};
> > > +
> > > +	for (; reg_start <= reg_end; reg_start += 4)
> > > +		regmap_write(hdmi->regs, reg_start, 0);
> > 
> > Interesting. Usually sending of the infoframe is controlled by a
> > register of a kind.
> > 
> 
> "This callback clears the infoframes in the hardware during commit"
> 
> ...and that's exactly what this function does: clears the infoframes
> in the HW and stops the RPT, making the HW ready for the "next round".
> 
> Did I get the documentation wrong?
> Should this function *send* an all-zero infoframe to the external display?

No, it should stop sending the callback. My point was that usually there
is a separate register which controls the infoframes. You code just
clears the header (which probably is handled as disabling in the IP
core).

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mtk_hdmi_v2_hdmi_write_infoframe(struct drm_bridge *bridge,
> > > +					    enum hdmi_infoframe_type type,
> > > +					    const u8 *buffer, size_t len)
> > > +{
> > > +	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
> > > +
> > > +	switch (type) {
> > > +	case HDMI_INFOFRAME_TYPE_AUDIO:
> > > +		mtk_hdmi_v2_hw_write_audio_infoframe(hdmi, buffer);
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_AVI:
> > > +		mtk_hdmi_v2_hw_write_avi_infoframe(hdmi, buffer);
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_SPD:
> > > +		mtk_hdmi_v2_hw_write_spd_infoframe(hdmi, buffer);
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_VENDOR:
> > > +		mtk_hdmi_v2_hw_write_vendor_infoframe(hdmi, buffer);
> > > +		break;
> > > +	case HDMI_INFOFRAME_TYPE_DRM:
> > > +	default:
> > > +		dev_err(hdmi->dev, "Unsupported HDMI infoframe type %u\n", type);
> > > +		break;
> > > +	};
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mtk_hdmi_v2_bridge_atomic_check(struct drm_bridge *bridge,
> > > +					   struct drm_bridge_state *bridge_state,
> > > +					   struct drm_crtc_state *crtc_state,
> > > +					   struct drm_connector_state *conn_state)
> > > +{
> > > +	return drm_atomic_helper_connector_hdmi_check(conn_state->connector,
> > > +						      conn_state->state);
> > > +}
> > 
> > Note to myself, probably we can move this to drm_bridge_connector too.
> > 
> > > +
> > > +static int mtk_hdmi_v2_set_abist(struct mtk_hdmi *hdmi, bool enable)
> > > +{
> > > +	struct drm_display_mode *mode = &hdmi->mode;
> > > +	int abist_format = -EINVAL;
> > > +	bool interlaced;
> > > +
> > > +	if (!enable) {
> > > +		regmap_clear_bits(hdmi->regs, TOP_CFG00, HDMI_ABIST_ENABLE);
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (!mode->hdisplay || !mode->vdisplay)
> > > +		return -EINVAL;
> > > +
> > > +	interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
> > 
> > The interlaced modes should be filtered, unless you also set
> > bridge->interlace_allowed to true.
> > 
> 
> Noted. Many Thanks for the review!
> 
> I'll wait until next week for more feedback before sending a v3.

-- 
With best wishes
Dmitry

