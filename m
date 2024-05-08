Return-Path: <linux-kernel+bounces-173814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266448C05ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7180DB235AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D7131E5D;
	Wed,  8 May 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LnYS/Gfz"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DB131BC3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201600; cv=none; b=bFXSnXARC+UChcdBZ7c+ecFdOXVZcoqXyt512Cq3p8qCbCbXLc53++U3z3kU1TxDEmngcgFsRVnkN52OyaTvoN99RTGrVu2as2d2D1lWi4gR7nrQ0+ZmdRXYrgdZ0+jyETo67Y/j/18N5yeLaRc+yZtxPBam07Hw8z1kAKorhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201600; c=relaxed/simple;
	bh=x2/OnYIYkyXnQCQ5vX3XkS/1O36D1J7pW0EOFe5QTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtpNj8KqjpvNwoR37Sf+iYGPhMh0q/HM8/o10J8VfMEazIJI9PvT9PknlhOF1fPtjAJq8PxjzartVoJE2Yq0hvAm0H87perul2LxjoPcDyqlT9O/r6HnQEUJACS6W7P6/TMkf1iY/DVmTKCC+bm8goaBbBrBQSJfUdyGWkQW17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LnYS/Gfz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-628a551d10cso157268a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201598; x=1715806398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Or8KqEsgChQkx7PQCuukTAwNzg+3SO5efP38g6ozU=;
        b=LnYS/Gfz0yFNFFVCSH+abmHPsk32EI6bS1CepFP5hAMQlJ2dVdt3LuRQpJzffagKbH
         sBTkPYt6vGD/3aXYDDi9pWTeoR3pJdW4OIzpeSRMJ9qEqLkHX+Kf4jSYRwUBi1+UqLDI
         9EMArBb0TuyioTiEMcPXOEYcxytErmPl0W8Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201598; x=1715806398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Or8KqEsgChQkx7PQCuukTAwNzg+3SO5efP38g6ozU=;
        b=bhVM08Oo0X/MGxC2UwMA2XLsZJFesMcgSIen71H04yQekSbmTLJB758US/RiZwKu3i
         W/M/kmlsngEYC/7fERuuRhc/SfWnSQARKMtaQAqmDrDmnYCDhxn8NxabX0ncx9Zad8Jf
         8TT7DJH6fPFH7p2kJ54/P3hUSo/wu1VdDSWVgfzV3yy19gZWACOJe76Q6/mWEop8yIEK
         SKIZge/e391p5taALD/2kxQHEHXUS9h5pPUVlZQipFKgHqmc5ynIKTsJMczGwbCWiQgq
         O4hijj7YI3Bz64nq6Am/DH0NPGqe3H3kNATnwixX55qNK/tq6qvwdpqQ8Wg27YX+zdLN
         Z74g==
X-Forwarded-Encrypted: i=1; AJvYcCUZHTat4jsK66kVm8RmVEeVtCI8u5bVESV5plJUPa1sh7r7FPopXb008JRzCRjFvjJ7lr90R7GfPOvDX/uXHFXS1ujXVxG/1GPucXV6
X-Gm-Message-State: AOJu0YxVygRFppMiIqeePcta97XxdrUJRfiIc/3uLCn7MuJxROWQvQH8
	X8cJqWH2r/ydLTlvHZcxutJ71J55aNP2GaMD/VevmbaGDXyWtzUanWC4wKsmYg==
X-Google-Smtp-Source: AGHT+IHlT4cBNVtbeGs0IzW+xarvyWIMXyM4S+1OqXcnO8FWroaFXVatZK0+WTDPEWg5ukRKVZyIEw==
X-Received: by 2002:a17:90a:5309:b0:2b2:93b7:b7b3 with SMTP id 98e67ed59e1d1-2b61649d921mr3595706a91.10.1715201598143;
        Wed, 08 May 2024 13:53:18 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
Date: Wed,  8 May 2024 13:51:44 -0700
Message-ID: <20240508135148.v4.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508205222.2251854-1-dianders@chromium.org>
References: <20240508205222.2251854-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mipi_dsi_generic_write_seq() macro makes a call to
mipi_dsi_generic_write() which returns a type ssize_t. The macro then
stores it in an int and checks to see if it's negative. This could
theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_generic_write_seq(dsi, <32768 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: a9015ce59320 ("drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use %zd in print instead of casting errors to int.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 70ce0b8cbc68..e0f56564bf97 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -314,17 +314,17 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
-	do {                                                                   \
-		static const u8 d[] = { seq };                                 \
-		struct device *dev = &dsi->dev;                                \
-		int ret;                                                       \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
-		if (ret < 0) {                                                 \
-			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    ret);                              \
-			return ret;                                            \
-		}                                                              \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
+	do {                                                                    \
+		static const u8 d[] = { seq };                                  \
+		struct device *dev = &dsi->dev;                                 \
+		ssize_t ret;                                                    \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
+		if (ret < 0) {                                                  \
+			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
+					    ret);                               \
+			return ret;                                             \
+		}                                                               \
 	} while (0)
 
 /**
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


