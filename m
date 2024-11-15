Return-Path: <linux-kernel+bounces-410376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6D9CDAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F637B24D97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E618B47D;
	Fri, 15 Nov 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="H4wn9Nmr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAC2B9B9;
	Fri, 15 Nov 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659719; cv=none; b=MO2p5JaC0Zk7r9uepVwWHoX52UU4byKLwjJJILMY8BKRNJJrbAnK1BlYR3FmO7FbRAQ31Rwr8YGfkp/pI0ikSZIbfEP0XwOBYMr/VaAOIt6me1XDg+7bgc/3O4JLDd/TbYm0sI1b6YkMRK1enPZX0AkLcreu1EYQ/erjz9wErzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659719; c=relaxed/simple;
	bh=GpORnpg+NQBerqyn0TR3qfFgiIIBLKgPStdADqbKTyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMKIQaESr7/ckLsGIQshZjX7KMpnYw3/sjFCsvwI0RalpwI9BC9+C3fy1DZRaBnskyJ8URV3aQ9bMzpdkIe4ZvzhrznK/LVlXjrSx1zT1htX9Cdvc82nFIKzj0ai1v2xoxDET8nvj5ZMTjT6D9XHrNirm3Ui90BwJuVGuS3m2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=H4wn9Nmr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w8OgLECi2MzZsuLHWKXzJxOoaKR0j3CLKXbFjs87K0A=; b=H4wn9NmrHi9wGBUh0ZpeZIP4yG
	O/OfEgazN1CVhu0ANGgMMdfF3dkkI+s6IaOdz/U7FBu/KnBOymcEFwb+QXo8Frnah+iE5wHycU+dZ
	5Ydl+h0u9cwrjHF/q/nGdisjH1ST7orjL8eS/CBAzMQJdFd6g2TWfcVN4wiVLJ6rruvn6xfcH5sSf
	pggH4+Zr5QPpOr/MbiCqoAQzgQxrZMKunZ5OqfeGzq9BYLMISF5WRCn0hLkl7D/8DqgkjyAXhLBFL
	QatooX0HDjyNdnn+ONAj6zIt4tTLJVZk38Bk3AOjqZ4CqfsvCZNcrk8S9eHaAAh1qfMA75qUzNLMw
	iJ3r6fYA==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tBrn1-0000Ns-Vn; Fri, 15 Nov 2024 09:34:52 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 1/3] vop2: Add clock resets support
Date: Fri, 15 Nov 2024 09:34:50 +0100
Message-ID: <3346283.VqM8IeB0Os@diego>
In-Reply-To: <20241108185212.198603-2-detlev.casanova@collabora.com>
References:
 <20241108185212.198603-1-detlev.casanova@collabora.com>
 <20241108185212.198603-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Freitag, 8. November 2024, 19:50:39 CET schrieb Detlev Casanova:
> At the end of initialization, each VP clock needs to be reset before
> they can be used.
> 
> Failing to do so can put the VOP in an undefined state where the
> generated HDMI signal is either lost or not matching the selected mode.
> 
> This issue can be reproduced by switching modes multiple times.
> Depending on the setup, after about 10 mode switches, the signal will be
> lost and the value in register 0x890 (VSYNCWIDTH + VFRONT) will take the value
> `0x0000018c`.
> That makes VSYNCWIDTH=0, which is wrong.
> 
> Adding the clock resets after the VOP configuration fixes the issue.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

patch subject should be "drm/rockchip: vop2: ...." please


>  static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>  				    struct drm_atomic_state *state)
>  {
> @@ -2057,6 +2079,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>  
>  	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
>  
> +	vop2_clk_reset(vp);
> +
>  	drm_crtc_vblank_on(crtc);
>  
>  	vop2_unlock(vop2);

this conflicts with the merge gamma lut support, can you please rebase on
top of drm-misc-next? Or alternatively just tell me if it should be

	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);

+	vop2_clk_reset(vp);
+
	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);

	drm_crtc_vblank_on(crtc);

----- or ----
	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);

	vop2_crtc_atomic_try_set_gamma(vop2, vp, crtc, crtc_state);

+	vop2_clk_reset(vp);
+
	drm_crtc_vblank_on(crtc);


Thanks a lot
Heiko



