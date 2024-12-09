Return-Path: <linux-kernel+bounces-437206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087839E9051
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D20B163719
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D621764C;
	Mon,  9 Dec 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLZFtjGj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB2216E2A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740461; cv=none; b=shvChraigU/QT/Q8to5DpWeps8rTa14obne2PQzYLAk9GIoMuyySmG+jV6edE2E2C2HPe887lxemk+t0Cm/3EnpFSosyZSpz57d5WN6phWc0YGXBqyuBoeBdGPA1lGv8CXtaGjoiM/6eBeqbfmYQkHtJJAwHyc9L4+mEapc7vwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740461; c=relaxed/simple;
	bh=mWSJOnbccL/qRk8+lUsJqekWaYSECi/NRBKTT6E5GO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmvMecMK2jrwoaKgVTU742IAygNOz5w+gMlKuMElA7M0iJBvs9pwz3eO+qV+ZYswEMBNNyRsBUfcWdZemOv2XTHOoOWzMIQ3dVPNxo7v4wyOk0kREwnRmkMS/DwfjFwPMz61AnUM6KEkTxostM1owYSD1R6y1fYqFmGvO9jUw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLZFtjGj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so1457176e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733740457; x=1734345257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hEhLMNTleL6gDMX+OMpFQyaTOOwXEej5ArGydUoWB/8=;
        b=ZLZFtjGjX7YDhKQjUewlQ3b9IjmkSIiH0mTowZ2UtP/yU0wQ45N9tTDbxdR9B4exsv
         1g9Ew3EzbXVzuE9A7PY7bdOpfeyd4VXblGEThGbQf/L9ILHL9zaB/aa2bAHE6Y6j+V/P
         s+pmpLOE4POYAtkidsKgDVQn+A0tAqyp3lFX8blzQOMXse2wbvYCQaf3QSBbGOh68/X+
         x82C1Q0Na45Hty++4pn6IJlsoEiwdYkiISg2O6f3T0CvlrOJsOxTm7JXx5Rca/CneHIi
         54tGKHJYi/VpuW9qKUE//v5/oVSa3VL0gFue3ZuIqs5ZSN0JEkYv8mQ59/9g+mDn+/n3
         c7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740457; x=1734345257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEhLMNTleL6gDMX+OMpFQyaTOOwXEej5ArGydUoWB/8=;
        b=vM24e9CwfZ33rI4KhqLQnZvTJnjlC9F7sm9+V3akiqxcQ9hepP6cnOZ4SvzInt3zXb
         PJadr6BxKlfD9Jkhc4BrosynPM382KVy6vGuc8slU2RGV1VIo3OnqXkIjvnpLFkXo39k
         13Nxf7w/hcP7QJ6MzHpSUn538IbNCJ1dhvnowT19rkk1Wb5s5FPQEOvpgi15A4m3tBWB
         U/So7rqxnAZS/55WXPjGjqehO7DzU52H9nmH/DN1jZjTS42Tx5WIH007WTBuANN/lER5
         OnTLBC58OZ1EBNq8lfUOnOC51EMzWI3VOqtiF4Gvc6y51ZBq7pwi3xv7YwoYbV34D7Zv
         wGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVFV5RN9mXFlkvMz0mzZIFGRdAWW5A2G80yQz7b9WNJ/zevwXKfyXmr6JcGKSPZYWOVKmsUIko1e7sudvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEc6PxBOn+EXWTiB61a69Vs0rrFqw8zFnSKm6rIO3U4sblS0r
	nUaCD+1NYUUfe+Gpzv42gwzjhfqZOxUpxn1pPzY6ywFro2cPut88W7Dc6AGCFAY=
X-Gm-Gg: ASbGncsvwWNQQQVHWV3EtdMZHxacVP1Q+UdAuu+F1IwXtTHQoGaE/1iWzQXHuDH9bXE
	plL7X6nRr4Ei/DR/nEOT8j/KhTHX7arxhiVnpN+WoBEft/VXYBeolFP3o/6I9RPlAojmNFFPtc/
	wbBd6HicE+RQgJlA4eTDgm/8eyhge8nWCjivI71Rw+5XoHMP9sEcRGQUaA3iUw1Z2gSDvMf0SDA
	nzJ2iGfLL25vi5aLHRqjSALBsLg7Zp7TsKCsHR8QSgd1BnzswH6oPGWgCtBDfe4A2OVI2AKMHjl
	OqEF2uyfzGMou0TAVe48AfKDVKA1yw==
X-Google-Smtp-Source: AGHT+IFNlBhxiOyHWAEAkiJz2Ehdp+m4AvAvGfaYvr8lFTl50vAiN44KAJkPfR3fGz840ZteQrXe4Q==
X-Received: by 2002:a05:6512:1248:b0:540:1c8e:b3eb with SMTP id 2adb3069b0e04-5401c8eb587mr1854409e87.44.1733740456809;
        Mon, 09 Dec 2024 02:34:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e336ca054sm975639e87.103.2024.12.09.02.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:34:15 -0800 (PST)
Date: Mon, 9 Dec 2024 12:34:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <sandor.yu@nxp.com>
Cc: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	"jonas@kwiboo.se" <jonas@kwiboo.se>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, "mripard@kernel.org" <mripard@kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, 
	Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [PATCH v19 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <fqrxw7yc7btvqccqy6mksqufcacm6o52xmk6drlqeeepuyfp62@gpjiox76h4cb>
References: <cover.1732627815.git.Sandor.yu@nxp.com>
 <e32c909ea8744fc5ea89aa3b4eed501efbaad1c3.1732627815.git.Sandor.yu@nxp.com>
 <wk6w5ckor53mudcqfs2grnxryhg7zvsjjdmqatyfddyfgsdrwc@mxxoocsi5pe7>
 <PAXPR04MB944814380C7A72641C6002ADF43C2@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB944814380C7A72641C6002ADF43C2@PAXPR04MB9448.eurprd04.prod.outlook.com>

On Mon, Dec 09, 2024 at 08:38:01AM +0000, Sandor Yu wrote:
> 
> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: 2024年11月27日 3:21
> > To: Sandor Yu <sandor.yu@nxp.com>
> > Cc: andrzej.hajda@intel.com; neil.armstrong@linaro.org; Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>; jonas@kwiboo.se;
> > jernej.skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > vkoul@kernel.org; dri-devel@lists.freedesktop.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> > mripard@kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>; Oliver Brown <oliver.brown@nxp.com>;
> > alexander.stein@ew.tq-group.com; sam@ravnborg.org
> > Subject: [EXT] Re: [PATCH v19 4/8] drm: bridge: Cadence: Add MHDP8501
> > DP/HDMI driver

Please strip such headers from your response emails. They take a lot of
space and are useless. See how it's usually handled by other email
clients.

> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > On Tue, Nov 26, 2024 at 10:11:49PM +0800, Sandor Yu wrote:
> > > Add a new DRM DisplayPort and HDMI bridge driver for Candence
> > MHDP8501
> > > used in i.MX8MQ SOC. MHDP8501 could support HDMI or DisplayPort
> > > standards according embedded Firmware running in the uCPU.
> > >
> > > For iMX8MQ SOC, the DisplayPort/HDMI FW was loaded and activated by
> > > SOC's ROM code. Bootload binary included respective specific firmware
> > > is required.
> > >
> > > Driver will check display connector type and
> > > then load the corresponding driver.
> > >
> > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > ---

[...]

> > > +
> > > +static int reset_pipe(struct drm_crtc *crtc)
> > > +{
> > > +     struct drm_atomic_state *state;
> > > +     struct drm_crtc_state *crtc_state;
> > > +     struct drm_modeset_acquire_ctx ctx;
> > > +     int ret;
> > > +
> > > +     state = drm_atomic_state_alloc(crtc->dev);
> > > +     if (!state)
> > > +             return -ENOMEM;
> > > +
> > > +     drm_modeset_acquire_init(&ctx, 0);
> > > +
> > > +     state->acquire_ctx = &ctx;
> > > +
> > > +     crtc_state = drm_atomic_get_crtc_state(state, crtc);
> > > +     if (IS_ERR(crtc_state)) {
> > > +             ret = PTR_ERR(crtc_state);
> > > +             goto out;
> > > +     }
> > > +
> > > +     crtc_state->connectors_changed = true;
> > > +
> > > +     ret = drm_atomic_commit(state);
> >  
> > I'd say, this looks like a hack to me.
> 
> Basically, those code followed the sequence as vc4 HDMI and i915 according review comments in v15.
> HDMI driver should " Reenabling the scrambler when a display is disconnected and reconnected".
> 
> To be honest, I'm not 100% convinced by this implementation, 
> as the code doesn't seem to align perfectly with the current DRM framework. 
> However, adding this feature would indeed address the issue of applications (like modetest) that don't handle HPD events 
> but still require cable plug/unplug support when operating in scrambler-enabled video modes.

Ack. This matches vc4's reset_pipe().

> 
> > 
> > > +out:
> > > +     drm_atomic_state_put(state);
> > > +     drm_modeset_drop_locks(&ctx);
> > > +     drm_modeset_acquire_fini(&ctx);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +void cdns_hdmi_reset_link(struct cdns_mhdp8501_device *mhdp)
> > > +{
> > > +     struct drm_connector *connector = mhdp->curr_conn;
> > > +     const struct drm_edid *drm_edid;
> > > +     struct drm_connector_state *conn_state;
> > > +     struct drm_crtc_state *crtc_state;
> > > +     struct drm_crtc *crtc;
> > > +
> > > +     if (!connector)
> > > +             return;
> > > +
> > > +     drm_edid = drm_edid_read_custom(connector,
> > cdns_hdmi_get_edid_block, mhdp);
> > > +     drm_edid_connector_update(connector, drm_edid);
> > 
> > Why?
> 
> MHDP8501 HDMI support scrambling.low_rates.
> The scrambler status can change when switching HDMI display monitors, even if the video mode stays the same. 
> The MHDP8501's HDMI code updates the EDID data to accommodate displays with different scrambler capabilities.

Ack. I'd suggest renaming cdns_hdmi_reset_link() to
cdns_hdmi_handle_hotplug() or any other similar name.

> 
> > 
> > > +
> > > +     if (!drm_edid)
> > > +             return;
> > > +
> > > +     drm_edid_free(drm_edid);
> > > +
> > > +     conn_state = connector->state;
> > > +     crtc = conn_state->crtc;
> > > +     if (!crtc)
> > > +             return;
> > > +
> > > +     crtc_state = crtc->state;
> > > +     if (!crtc_state->active)
> > > +             return;
> > > +
> > > +     /*
> > > +      * HDMI 2.0 says that one should not send scrambled data
> > > +      * prior to configuring the sink scrambling, and that
> > > +      * TMDS clock/data transmission should be suspended when
> > > +      * changing the TMDS clock rate in the sink. So let's
> > > +      * just do a full modeset here, even though some sinks
> > > +      * would be perfectly happy if were to just reconfigure
> > > +      * the SCDC settings on the fly.
> > > +      */
> > > +     reset_pipe(crtc);
> > 
> > We are not supposed to cause full-modeset flicker if we can avoid it. Is
> > it the case here?
> 
> My implementation differs slightly from the VC4 HDMI in that it doesn't check if the current video mode requires enabling the scrambler. 
> This is because we considered a scenario where the previous display was operating at 1080p60 with scrambling enabled, 
> and then the cable was plugged into a display that doesn't support scrambling at low rates. 
> This case also necessitates a full modeset.

Well, if this is a part of the hotplug, then of course there are no
flickering issues as it happens during hotplug.

> 
> I haven't found any video flickering issues in my actual tests.
> 
> > 
> > > +}
> > > +
> > > +static int cdns_hdmi_i2c_write(struct cdns_mhdp8501_device *mhdp,
> > > +                            struct i2c_msg *msgs)
> > > +{
> > > +     u8 msg[5], reg[5];
> > > +     int ret;
> > > +
> > > +     msg[0] = msgs->addr;
> > > +     msg[1] = msgs->buf[0];
> > > +     msg[2] = 0;
> > > +     msg[3] = 1;
> > > +     msg[4] = msgs->buf[1];
> > > +
> > > +     ret = cdns_mhdp_mailbox_send_recv(&mhdp->base,
> > > +
> > MB_MODULE_ID_HDMI_TX, HDMI_TX_WRITE,
> > > +                                       sizeof(msg), msg,
> > sizeof(reg), reg);
> > > +     if (ret) {
> > > +             dev_err(mhdp->dev, "I2C write failed: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     if (reg[0] != 0)
> > > +             return -EINVAL;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cdns_hdmi_i2c_read(struct cdns_mhdp8501_device *mhdp,
> > > +                           struct i2c_msg *msgs, int num)
> > > +{
> > > +     u8 msg[4], reg[5];
> > > +     u8 addr, offset, *buf, len;
> > > +     int ret, i;
> > > +
> > > +     for (i = 0; i < num; i++) {
> > > +             if (msgs[i].flags & I2C_M_RD) {
> > > +                     addr = msgs[i].addr;
> > > +                     buf = msgs[i].buf;
> > > +                     len = msgs[i].len;
> > > +             } else {
> > > +                     offset = msgs[i].buf[0];
> > > +             }
> > > +     }
> > > +
> > > +     msg[0] = addr;
> > > +     msg[1] = offset;
> > > +     put_unaligned_be16(len, msg + 2);
> > > +
> > > +     ret = cdns_mhdp_mailbox_send_recv_multi(&mhdp->base,
> > > +
> > MB_MODULE_ID_HDMI_TX, HDMI_TX_READ,
> > > +                                             sizeof(msg), msg,
> > > +                                             HDMI_TX_READ,
> > > +                                             sizeof(reg), reg,
> > > +                                             len, buf);
> > > +     if (ret) {
> > > +             dev_err(mhdp->dev, "I2c Read failed: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +#define  SCDC_I2C_SLAVE_ADDRESS      0x54
> > > +static int cdns_hdmi_i2c_xfer(struct i2c_adapter *adap,
> > > +                           struct i2c_msg *msgs, int num)
> > > +{
> > > +     struct cdns_mhdp8501_device *mhdp = i2c_get_adapdata(adap);
> > > +     struct cdns_hdmi_i2c *i2c = mhdp->hdmi.i2c;
> > > +     int i, ret = 0;
> > > +
> > > +     /* Only support SCDC I2C Read/Write */
> > > +     for (i = 0; i < num; i++) {
> > > +             if (msgs[i].addr != SCDC_I2C_SLAVE_ADDRESS) {
> > > +                     dev_err(mhdp->dev, "ADDR=%0x is not
> > supported\n", msgs[i].addr);
> > > +                     return -EINVAL;
> > 
> > Why?
> 
> MHDP FW offers mailbox APIs for SCDC register access but no direct I2C APIs. 
> Individual I2C registers can be read/written using HDMI general register APIs, 
> but block reads (e.g., EDID) are not supported, so it is not a full function I2C.
> i2c_adapter was implemented only for reuse drm_scdc_XXX functions.

Please put this info in the comment. From your 'Only support foo' it's
not obvious if the hw/fw doesn't support it or if you are artifically
limiting it on the driver's side.

> 

-- 
With best wishes
Dmitry

