Return-Path: <linux-kernel+bounces-312180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCED96931B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CCFB22490
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D101CDFCB;
	Tue,  3 Sep 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="bY8gEV/U";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DV5PT8Dv"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0A19C562
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340370; cv=none; b=hGO9XEK3M/A56NlJosEoxW3WBYTxyOP/vKrbNYKfabIVpUrE6YQ68QbrPp7UxurBkxBsaCnjlMkpApeRirZQTAvmMopB++cON2R+wBZ+5kFrvrAmrY6vpecjG803rqKLXd9Xr1+0as2kp2lJkMXYKoZOeAN7/K4GmJ58LTqbD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340370; c=relaxed/simple;
	bh=wWO2bj7xnGRGn6uerGFHpllvxA3WXeC78hSILIY+YSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE3bBznw81CVBaHZxqPHN9gu0/rlP36FCt8UU6EvrdUXrj63gjC8CEHyzqzHNRYWeAvh3EYUVd1FJ225RrKGMqoG2x+cCoVV3A2FdgDQHZ5zaeGR1VbMU8AmgL+f6I5cIUOXduOiz5DlvxP+iwIGqohZ79xERaLOYSG99oJjffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=bY8gEV/U; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DV5PT8Dv; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1725340367;
	bh=wWO2bj7xnGRGn6uerGFHpllvxA3WXeC78hSILIY+YSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bY8gEV/UVidGLcejSAAkCgWDl4k+YIut/hNy25SPbJSGl2agLINUyDEnCqtJnZaGm
	 SK3tb9GLPaTsszLxdcOdljqjnoacMkXYWb+nV/iUdaEoAWavCj438Ovn1LUMfwARfT
	 ia54RtRAm47KBAvZ4rDQWoGbOVchxei5JqExV76T76+Y6W4t4sz+00XkhSBJyOWfX8
	 0p7/NDTPfjpM1203qmu+CePbJMFA5Eb3jTcaBBOmDSxId2O8f7Av33Qhorkif6FFHB
	 w08dYHJ8GFdq4w/2xu+PzL+P5/vdeZwnNygxaXKQ6xw2nvq/BsVLZUm/+pOWuspS/Z
	 qtBgn6LC8uOng==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id DAE51629
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:12:47 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DV5PT8Dv;
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 285ED1DF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:12:46 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2da511a99e1so859838a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725340365; x=1725945165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTVet2hwtDQC+7RYNH41N/xrPAZsrbreOOChXWn2n14=;
        b=DV5PT8DvlhbY+1Bbl+4FV5krcoRDYnDERbch2dakuVIB+ThDd2yguGSYdyrOPFxPxg
         PT7COBOBdLtvjwgo9cDDwBVC6IomDuoIi6DAi2Hr4dfUJr75JJe7axd2BowyZjDYHx7Y
         RLg/KIUe2QgmUNIa6lLRxEa9Z1MPIhUUtVmV//zONagCudBZHbNI/3ukD6FYtgay7aJL
         xrrANrfB5eXh+VedsjIEqrv2cjIc66mof/GORj9x6L29nKPAyE8uK6a4AScXtWDwj09e
         3P0IBI9NyhSVSxOt1rRVQH9dQqjRo1nBXJ2yOH0hgVO1jc5UUPTjHd9hqpmFS4+YK9bM
         EFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725340365; x=1725945165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTVet2hwtDQC+7RYNH41N/xrPAZsrbreOOChXWn2n14=;
        b=Q5+hxDxXZQ+Ge/CnDR6DfY3/W3a7hIiwa+GCbjKAfDFtQHvh9jqhJqtQqaSR2XPqyY
         8sHM4k7d8imCyh4lR/SZ9PdOxgwNFin4t4N1fUe6NlViE6RrAr2fRJft6N6dmqa7cUzU
         3BPN8FJNFah9ApjC4TNcxgsh8mJorrD5nHmmaTDJv8Us6i3JQiSoEh3LXx7H87M/1OwR
         fvloiIoIIY0nyxXZZSmXa/5lR9IoV1PRze7WcHKnzv+SCUlfTl0MFQ5IH3EimRSoi3ju
         aMLomrAzTzhuVKaqrRLQsjpPr/qvjyF0IQGQBIV+LLij+CxJWz2PIgJCcz1B/lk/wDiI
         YhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeD47uoVPYjbdxV7SasYcMG1gRMPuILkNpJihzNf7ux4VrqOZrZthTwua9ojWSugTBV8CbzBwOYQ4VOPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5ky48uaedyPnGUc2ZFbcFBW4sVqvBNQFypmKYUa19d9E6dYS
	DG37MoVduzH5dsbiJw2urye2mhQCSz5IaHkbDFA5DXicQ9C9ZyMXtgLWvRhlUUSF5cCJsyDoxWG
	6dnltua2GakdzhHxYz3fmRuXSi9cIy/LA96DeSU4UdOrkNybrtqEOIJxQmxNxdPU=
X-Received: by 2002:a17:90a:51c4:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2d85619f138mr17306766a91.18.1725340365190;
        Mon, 02 Sep 2024 22:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI/W6ki+54ibKrTj4V308dUfrgyQoxjyaoSQGc5uK59zJxNKhhGRxaLH+SmdhuJ8T3mWPCXQ==
X-Received: by 2002:a17:90a:51c4:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2d85619f138mr17306741a91.18.1725340364813;
        Mon, 02 Sep 2024 22:12:44 -0700 (PDT)
Received: from pc-0182.atmarktech (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e7faesm12597893a91.16.2024.09.02.22.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2024 22:12:44 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1slLqM-003XDw-37;
	Tue, 03 Sep 2024 14:12:42 +0900
Date: Tue, 3 Sep 2024 14:12:32 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [PATCH V4 4/5] phy: freescale: fsl-samsung-hdmi:  Use closest
 divider
Message-ID: <ZtaawD3vb8gmnVmO@atmark-techno.com>
References: <20240903013113.139698-1-aford173@gmail.com>
 <20240903013113.139698-5-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903013113.139698-5-aford173@gmail.com>

Thank you!

Adam Ford wrote on Mon, Sep 02, 2024 at 08:30:46PM -0500:
> +	/* Calculate the differences and use the closest one */
> +	delta_frac = (rate - phy_pll_cfg[i].pixclk);
> +	delta_int = (rate - int_div_clk);

This assumes rate > whatever pixclk was found, that doesn't look true to
me for the integer calculation (`delta = abs(fout - tmp)` so it looks
like it can pick a larger value)

For the LUT, the way the lookup works is by picking the closest smaller
value so this is not a problem, but someone might come fix that later so
I'd rather just use abs() everywhere for future-proofing


That aside it looks good to me, I'll add a 0.5% tolerance patch and test
this all ASAP (might be a few days); will send the tolerance patch
properly after testing but for reference it will probably look like
this:
---
From 12479386c955a59330232c84f4f856606c3a53e0 Mon Sep 17 00:00:00 2001
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Tue, 3 Sep 2024 13:47:24 +0900
Subject: [PATCH] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with selected clock

This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when we
cannot output the exact frequency, enabling the imx8mp HDMI output to
support more modes

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
index 13bc570c5473..9431cd5e06c3 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
@@ -23,6 +23,7 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 		       const struct drm_display_mode *mode)
 {
 	struct imx8mp_hdmi *hdmi = (struct imx8mp_hdmi *)data;
+	long round_rate;
 
 	if (mode->clock < 13500)
 		return MODE_CLOCK_LOW;
@@ -30,8 +31,9 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	if (mode->clock > 297000)
 		return MODE_CLOCK_HIGH;
 
-	if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=
-	    mode->clock * 1000)
+	round_rate = clk_round_rate(hdmi->pixclk, mode->clock * 1000);
+	/* accept 0.5% = 5/1000 tolerance (mode->clock is 1/1000) */
+	if (abs(round_rate - mode->clock * 1000) > mode->clock * 5)
 		return MODE_CLOCK_RANGE;
 
 	/* We don't support double-clocked and Interlaced modes */
---
--
Dominique



