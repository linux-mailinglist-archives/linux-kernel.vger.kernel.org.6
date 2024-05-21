Return-Path: <linux-kernel+bounces-184425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117A8CA6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9088B22224
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707BD44393;
	Tue, 21 May 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JnDeaCG5"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343F41746
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261445; cv=none; b=jx8iFITSLU2vrqK8CEq+ghdxhJ51ueVPWTZyLYA/8LyAk2i2MvPrWqWHssoOylAIQ15irQkatxmPyw2wBL1sFt6BPn3mTh0FNYopXTwFB0ROnP8lqlqVj67Wn7rYRPBUMSV5fKSBbCaPZlytIDO227e9PMjWiqpWSkgvlUBN52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261445; c=relaxed/simple;
	bh=BDYFLsz+/qdUa9ORrrhrQxUmtbfPzFNySy6nqCUl4C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdopKuMVpMqetUTbLohVRCcPj/SzvIYRGTtcjzX7WxqwZZ7LMx2KF4qiaI74LxjscNBg5oCs0pVIBDbrSQ5yMDplBLvEEMXsDSMK1bSEU1ShmfoXNiyfkBdfpacXmHMDMqEnOsQ22KDhVw4l+nEBKfhhK4plLDFWVfQXlOpiY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JnDeaCG5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecddf96313so81726585ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261442; x=1716866242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBJmvHjrIZD4J5+8YalNZy3ccMmTqVm1w0JgkzYgp6A=;
        b=JnDeaCG5KGBMHJJAoGYCI7G/HKYEJQTN2ylrSgljXAgMNB2+MO3Dv5oQkNeyGVhtGD
         oDF0eHRf1qBR5w6gkBV1XUsFIlDfyyHNj3wOr19FShik40xbH71jpT28vyFeKGWOg9ew
         6kholWQP/8m/RqsdKVtPG2CwanBbLaQCqKi0GYhoYVoI5tBbgXaWipKsB315SLC3EpNt
         A1iYgtyT+cCyxH4MwnPPZhp7k6NQ9v5JKsDzIQtMD9e0VO6yuxHNb80nktXh/kOLSz2e
         C87IZAUfq009V30ZC/s48Y+MFFt3/zQnW7bpVfBghZrQihy/JaOIvo2aeUQdvUihRQdc
         AOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261442; x=1716866242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBJmvHjrIZD4J5+8YalNZy3ccMmTqVm1w0JgkzYgp6A=;
        b=SwQ89ny34OSnnsj+q/uhqDFRU5WJSe9nl8IrJ28rNbkrJoFf1pXU31SLLe7Bs3Mg0P
         UXSbtmR41a4wnSbju7gHuzkcqU0gYK1OJGX0XdagF0al5sRJzXSam9+onyS+wfio12+p
         pr3mUy/xekNMnjyH5Kne/jp2au+5E5md9eyJJno47wRfH6jTcD1M5xt/aqu3HGOaBHwo
         DydGtdYRyurnyMGqDM9469WjKcD+/CUqA8Gmi0lxUXYMkTUoKom2uvlCx7wOaeJd1npk
         o7R9QOaIofKYaSElA5lS0YHdcv87lKQU12dxixM8LIz/3Uu+K6DsurEAzLfIWKh+vfyi
         3Lzg==
X-Forwarded-Encrypted: i=1; AJvYcCXnr6KyD9tGuiFqCoJfVuuYeTO/n3o4Lr5ZfRTo6N69nKyjGuU4a1rZkGxnJkqb7H3xeYbZykli4Bccpau9noZHUyBvhXZXjUJDk3xo
X-Gm-Message-State: AOJu0YxYci9VHlzPMHEFK4BRVZ7u4yCWtIDgBUQvMnukMCNG//8LENJO
	TWJDvlBOPrFUabD1Qf/AyHOH/qO7tFe+c1Qf+/qvsGSLQSWXuGpsfXWcGhJqILs=
X-Google-Smtp-Source: AGHT+IFNy6BKjfAI2rtz8anl6N+itc18Z32U8IcDCV9zSoM7IeBOmMW3L7ublaurf44C/d1dCLLr7w==
X-Received: by 2002:a17:902:f683:b0:1f3:4e4:f76a with SMTP id d9443c01a7336-1f304e53670mr56219285ad.65.1716261442263;
        Mon, 20 May 2024 20:17:22 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:21 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 01/31] Staging: rtl8192e: Rename variable IsPassiveChannel
Date: Mon, 20 May 2024 20:16:48 -0700
Message-Id: <20240521031718.17852-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable IsPassiveChannel to is_passive_channel
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ee469c9118b8..4a0db2dfd5e9 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2356,7 +2356,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
-static int IsPassiveChannel(struct rtllib_device *rtllib, u8 channel)
+static int is_passive_channel(struct rtllib_device *rtllib, u8 channel)
 {
 	if (channel > MAX_CHANNEL_NUMBER) {
 		netdev_info(rtllib->dev, "%s(): Invalid Channel\n", __func__);
@@ -2432,7 +2432,7 @@ static inline void rtllib_process_probe_response(
 		goto free_network;
 
 	if (ieee80211_is_probe_resp(frame_ctl)) {
-		if (IsPassiveChannel(ieee, network->channel)) {
+		if (is_passive_channel(ieee, network->channel)) {
 			netdev_info(ieee->dev,
 				    "GetScanInfo(): For Global Domain, filter probe response at channel(%d).\n",
 				    network->channel);
-- 
2.30.2


