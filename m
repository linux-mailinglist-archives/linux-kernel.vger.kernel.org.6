Return-Path: <linux-kernel+bounces-184446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298A8CA6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D621F20F43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95076413;
	Tue, 21 May 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="WX4XQM1Z"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFED74BF0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261460; cv=none; b=DJQR2CaeiBIMNyPMUiJqqAllDjKZgF2O4Z6V3BkA2951nb4bABdYb3i6GpjX+8r4rH5INUQoQ1bXE+Xt3a7cCXwdn3IDe2FucvXbFOkDuG4WnlvF1FoMhmdxM/teLLS/bjDxlVJBM7Rb6mgdF+9g2DrlaWe+AUxoqGjLYYBmx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261460; c=relaxed/simple;
	bh=vJHmGCnlTHJFDnVcYQjewmNGAN8HLDG68bKJqwbNMA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIW/dCsiDQQ6X4Fktn0+0cRvht6DKi3kfostIDFjxH4yMPAzs9Cf7OrfTXMBAWPISfT30dIbPi6ZJQYcgx5G9kupUaIgTySlH2NUURX2XkoYpDJsZ86mtDP4xYyrVLgWJxE5KCEuPDNoy9NtLMUIH1tkjfIZJmAO6ld8fHagAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=WX4XQM1Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee38966529so24149435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261458; x=1716866258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpJfdLLLMHxwJAQ9HWJFKbBxT/10Yc80Go3jO/vuxHs=;
        b=WX4XQM1ZY8DNCiBiHAdWLjy4YSm+ToqEgkeGSk6c+fW2Li+fxuomRd67zIaochHtka
         mQwq3H5JcBdNHir3ZIT6om4Ql+XoU+vFbardY/tJPdItuG6rVoa3h1Rbg3yMFbTGaDIp
         iHgW4EJ9Jgs+DriBvO+rwAsZNZChhOYCffC2J2DFbq3hFXHk0Pz51Xm9biFyaaMm7ztW
         2jrx5Sgxsdm0PMkBijCmWJ+ipVNY9n4moKz8xqHYIQEgteUvmx5J5eqL+kWpNlQoLPwa
         b1JF7wRENac15cc/XHED99+N240q7YYzH0Kh+AnJtce+foQ3INZ5tupCcAi4U9gFs5V4
         22WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261458; x=1716866258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpJfdLLLMHxwJAQ9HWJFKbBxT/10Yc80Go3jO/vuxHs=;
        b=JI+HN0VSrvlGqbRzTtl3afEUbXCyPwsNZfHtFifTYFjiRLcH+PGrFbaeuE8nMbOEu+
         ibiubZLYd8L2/MvEhVC3BNBRoZZRAWj9YcOm4x9pAg3VHzD29wKQ/ZK/R3ePW/EajiqF
         7jN9z+jUzFiZiZr8PaDgI4bd3pqNT9UavBXLlRLigEHb8xq+KiPd0g6F12oYQBFQjZmp
         A7zItZNuxec+HWb8sv4eJPi9CwUUoKTlfXWsOISxwBwKWRSyenX6/q3Z0hGrdIX7W6rf
         HsJTOb+lr4MBDCwoajVuZypHk+HFTW2vtQWjZO0Z44/EqSqMPnG5H5qJ8gNh8Ock5nBO
         cv+A==
X-Forwarded-Encrypted: i=1; AJvYcCVd3coX2XLEzhcLEorMQ2UfMm9cy0sDiuuQh5ueovkznB0GFE2Huk58ijWx31LsagMnejjfMMX4FJxCVKwbRFDnqVOEczAwqWDqMhNi
X-Gm-Message-State: AOJu0YzLAfgJdac64vJrh1281p3PjTCLEFnV7cS9Lr2RPMTKFsradA/k
	P/5dz3xfPUCsSg5wQYC15dVCxdmna5d+izsNrWfPQVYDPz5IaiT2nWbGGP984Uo=
X-Google-Smtp-Source: AGHT+IFOsf2NDCipI6AzAYxPue93TEwoIH3sdDO+DdvaRSsMgk1Gn6DPut2+hCrJ8DfbQHkOPXP2vg==
X-Received: by 2002:a17:902:c944:b0:1f2:f8f8:680c with SMTP id d9443c01a7336-1f2f8f86a26mr72740905ad.11.1716261458649;
        Mon, 20 May 2024 20:17:38 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:38 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 22/31] Staging: rtl8192e: Rename variable IsDataFrame
Date: Mon, 20 May 2024 20:17:09 -0700
Message-Id: <20240521031718.17852-23-tdavies@darkphysics.net>
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

Rename variable IsDataFrame to is_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f69f4ca39fd5..0914ba37f42f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -338,8 +338,8 @@ enum rt_op_mode {
 #define RTLLIB_QCTL_TID	      0x000F
 
 #define	FC_QOS_BIT					BIT(7)
-#define IsDataFrame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
-#define	is_legacy_data_frame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
+#define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
+#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 50687f3dce47..9741d351363e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -878,7 +878,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
-		!IsDataFrame(skb->data) ||
+		!is_data_frame(skb->data) ||
 		is_legacy_data_frame(skb->data)) {
 		if (!ieee80211_is_beacon(hdr->frame_control)) {
 			if (is_duplicate_packet(ieee, hdr))
-- 
2.30.2


