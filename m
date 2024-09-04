Return-Path: <linux-kernel+bounces-314531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1696B490
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CF11C21B90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1211C7B8F;
	Wed,  4 Sep 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ILQx7ecp";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="LQIsSu1z"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C51C68B8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438681; cv=none; b=CMKekqj3pAwX1xEaAIr+7EmYJ1ivXn/AqYy/EabUum//k01mwSoDuiHEHBVpw2s1tEXJnVQ8wN3TpOX/IzcTuL4RsAHVoA/jP+LO/NsGt6JzFIQEurwb1XpgwVHe7LBf86rY3JwX+0rQEGusV7zWX/vG0UtwTER2+s2ww1X/6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438681; c=relaxed/simple;
	bh=12N3q46XQiecPb2oufmrGICQCBcT5ecdudDGcuTf44E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYsmhhkXT5I0cFa7VVnNnm/qwOujAAFMgdjHDw/FDnEegoIoeeYka6zyg0EWEb/lMfvK8Y7WsMEpMVoFY2sMqIt8GxGkinY9MAKHc0liPeuSyMM8jvfwuGlEklrycBVsNbAee+azXdI25B58wdBogKdRJx4xSe6MEs1tbA4g+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ILQx7ecp; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=LQIsSu1z; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1725438678;
	bh=12N3q46XQiecPb2oufmrGICQCBcT5ecdudDGcuTf44E=;
	h=From:To:Cc:Subject:Date:From;
	b=ILQx7ecpTvUCHqc5lj3wAK15OxOUbxTVwjQsW5/97Pl44LokJI8jXjsj80z25OuDF
	 iM7OkDO/nDW5vWYHvLDHeKlBrqqRpfxrbKKFel16AoF4nFao+eJTH/td1xUs18+Vg7
	 f7UyGD576y/ZkJheLuYv7be4lGBReQQunP6mAdl+v9EqiZnCDRMIwQKLyG3VrZd+W6
	 g+eJVyPOCdeVYwqoOsD4MMddFZDpjc3p6Sr54v2ITJ0Xs0lJuODf7hEZkjoB7sTxgn
	 awA6LvefK9wo3KQK8arMeelgkhNohKGrb4V7FPBBsA7XnBbXQ0m6bVtSYHizEbLKPd
	 NpsY9T02GdHag==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 46B2F7C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:31:18 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=LQIsSu1z;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 850747C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:31:15 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so6968396a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725438674; x=1726043474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wl5lFlZZmqmzzNDLDZabcElQI0pBWjUywY0vrZnCNgA=;
        b=LQIsSu1zgvqTCui+orUh9mX4SMJ5TWq2sR48P9cWIdOs0dgU56vahC/HZoxTJ9o+ap
         GkTPc5rfLCB9kQ90qCqSINFABpimZd6RSc+hDd+hLAqbt3+R8HCH//QK89agbVdH5vVw
         GCMI5D0KuHBD/a3p+zPGFQEHyGZvblFpP38ZFv0t+L8dV/oZCohFfBeW1VaDUhwV3ozG
         qbgDXtNIga45ZOy/8d83vrzoAbOH6b88ZoIDXpWR/BuGKsAnh+WnYGOYQF3CeERmz1RX
         Emw6xSdQqnBy8y6qSed48yl+lkM5Q2YMW/EKklbCyn8HTuCi4Xo+Zd9FvCkcn5Ipc56n
         LuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725438674; x=1726043474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl5lFlZZmqmzzNDLDZabcElQI0pBWjUywY0vrZnCNgA=;
        b=E7gfBL0WL1nKdiRaKNWx2gFiSIrKEb6GuZTtyAboLzPWYEmk1jwnWR/RuAHub3Uoxq
         h1bhc4Jvb/vksqmvF9ijE//068gjCkjioFhP/dxHk19evH2Zj03kfcq7r8/sCyW3ngoA
         //UHGtvvaxZawMG0HeK8XfnfVnFGsXGa0cezUWwDqbuE84vqpy0q58xBKuI/1aF+4Rdo
         VA9xXlfbyic/jyvwXRl6cQ/OOFSWNVtY2mFS9NtVQhvhqaWKFf04Mi6E9714v81wF/6u
         TfunASQikzi7yjXxH3tx3b4zn3mONmduso705YILgeceirngXAh2RVwok4Q+2U7gj69S
         KqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5N2XI18XMul8cHF6afhxV5Y+5eaFAsgYyDr+VPl3C49GuNpRWubFx14v8AFQ+ncdf9qwlPoY3Cp1mU5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUKGZ74yhwECwbeWQYfhPxuQM4RrysE7XcGXMWMKnDuDBvHdQ
	uxMBmB3/ZuGacjzmSovv+sUcKpkktbCj/sSvS6Ayc5EyrCMJQP08GIu2I2axM+SeTEy4tQHuOVq
	mzUUgVb0BNWMystpUSRmsGjwOjhhZ2YZmmQDQAFtsj1nmRm/4BqZGy9Ie3I5w7KU=
X-Received: by 2002:a17:902:d2d0:b0:205:5544:bad6 with SMTP id d9443c01a7336-20584230d75mr94740805ad.55.1725438674424;
        Wed, 04 Sep 2024 01:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgJbK93rPoTGn7e+5VtWYSo3ES6TsSkat4XXudfYHMjSL/FnAwD5lW7dBeTsvIE7zMeiGN1A==
X-Received: by 2002:a17:902:d2d0:b0:205:5544:bad6 with SMTP id d9443c01a7336-20584230d75mr94740425ad.55.1725438674064;
        Wed, 04 Sep 2024 01:31:14 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae968f78sm9198335ad.119.2024.09.04.01.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:31:13 -0700 (PDT)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1sllPz-005H8O-2o;
	Wed, 04 Sep 2024 17:31:11 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with selected clock
Date: Wed,  4 Sep 2024 17:31:01 +0900
Message-Id: <20240904083103.1257480-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when we
cannot output the exact frequency, enabling the imx8mp HDMI output to
support more modes

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
This completes the patch series sent by Adam Ford here:
https://lkml.kernel.org/r/20240904023310.163371-1-aford173@gmail.com

and makes the cheap screens we recommend work with our imx8mp board
without further kludging.


 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
+	/* accept 0.5% = 1/200 = 5/1000 tolerance */
+	if (abs(round_rate - mode->clock * 1000) > mode->clock * 5)
 		return MODE_CLOCK_RANGE;
 
 	/* We don't support double-clocked and Interlaced modes */
-- 
2.39.2



