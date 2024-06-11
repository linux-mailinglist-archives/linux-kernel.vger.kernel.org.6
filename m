Return-Path: <linux-kernel+bounces-208993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB0902B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6659281EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C31509BD;
	Mon, 10 Jun 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XhGU1jQO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF615098A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058338; cv=none; b=FOoFY9y4r9F0CwDkvhpQEswR/z4NdDeM2dylQOkgNQ/XMu937OIpQJBku9b8XCIojsl9QsLUvAlp2wYkUuB6Yu0TZ8r4z1S3N7+lDzKA9euEyQXOFSHWzqsfM8/a7SdndZ32snMIS8bUy1xisQwHoAyOrlEkDE9U3rxOX/m7kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058338; c=relaxed/simple;
	bh=+RxVcrk5xlinIyKBU8E8yKLsymOqJrp8Zmr9e1mtnNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToJu4fUjAUXwEh2eSOw1tAU7pUdYqwP9UBI25VToj82LN4wJjkpO7BC0c7rzTdCW2ZRFx+RcMzzwWVT/7URkpp+Q9MlMlRQbUx5ZLF+ZZLwc6TRsL6jcUbPBUknrtAKJ808EZYrpbqZBI0LYwdQNRXFY1dxGeHq1I6igpLte+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XhGU1jQO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70fdc9644so12372015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058336; x=1718663136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyDnUVi7f01VKkUwYe3kP2/vlms1ESU+sUAt3unZHAg=;
        b=XhGU1jQOpxq8bONZwPPsHHLaV3UQVq/GKl1B6jBpQ5MsEOpOin8j2bMaNhWRY9wqEH
         vo845YmHGuqLPMbVkXa9GXE6h0H5K0/K/90Z3E+OIgTp3OD6PV+qX5uHHTpgsMH42gXZ
         +UfEQubIHNsXgx2iaVkQvB+qIP4YpT/RFJ4Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058336; x=1718663136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyDnUVi7f01VKkUwYe3kP2/vlms1ESU+sUAt3unZHAg=;
        b=mA18nipTYsCWl46WSPAr6I1nzuN7RVqmu1oMtOWIQKucvrStD1jHxhuYAjX3vsZPG3
         PUyBaSSOEuzw0v1O6GlBFWahR3dC7h4NfiKFdggskZ0353qh8y2OzSUO8uU7tGymwtvh
         Fo9tIkgjCQZtaxzbj3h/db3Wgyfuf4J1x7nqysPPB/tagl6XyUN5Jfy8nuSWBwa2CPk1
         /aXA+dIqPJG2AceVt2YkVT+TTy5534oYm1i0lDh72mbpecfSvJLAhaCGhUxNfu65oU9d
         lQiZMIavue8f4tJD4b4kMbLarf3UqelGavTEfk0sr0bbBbhXqVq7Y53gzBIHloNFZaPX
         Tigg==
X-Forwarded-Encrypted: i=1; AJvYcCXUJZujvtD17QFuFn3RbMznVDgohSjvaQcfTmxGMRMsNLs7R3GL/U//VJ8Ag8CmxAVjW/jjVE0UdWQJCDU+bKd3LiNfSVkAePHITK9v
X-Gm-Message-State: AOJu0YxJHAOqeazSQGu55IqmTMDU3t0+TM3KvDV4JsSMgm/hXEXoX91v
	9kmnVEtSusR0QIhKDsk4l7XpJSoUW3FBXL8P7E93/ua+VPNUg5RDAb0JlL/12w==
X-Google-Smtp-Source: AGHT+IHKwUPrbCmgwcYQyfYNHQzhIsajNRjs/TPs5xRJljWfg9/8As8zTXUgUwq2P5ekE1wC6HHkcw==
X-Received: by 2002:a17:903:22c2:b0:1f4:8bb9:924f with SMTP id d9443c01a7336-1f72879f841mr9952475ad.1.1718058336214;
        Mon, 10 Jun 2024 15:25:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 1/8] soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
Date: Mon, 10 Jun 2024 15:24:19 -0700
Message-ID: <20240610152420.v4.1.Ife7ced506aef1be3158712aa3ff34a006b973559@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For UART devices the M_GP_LENGTH is the TX word count. For other
devices this is the transaction word count.

For UART devices the S_GP_LENGTH is the RX word count.

The IRQ_EN set/clear registers allow you to set or clear bits in the
IRQ_EN register without needing a read-modify-write.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Since these new definitions are used in the future UART patches and
Bjorn has Acked them, I'd expect them to go through the same tree as
the UART patches that need them.

Note: in v4 I added the GP_LENGTH but kept Bjorn's Ack since it seemed
very minor.

Changes in v4:
- Add GP_LENGTH field definition.

Changes in v2:
- New

 include/linux/soc/qcom/geni-se.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0f038a1a0330..c3bca9c0bf2c 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -88,11 +88,15 @@ struct geni_se {
 #define SE_GENI_M_IRQ_STATUS		0x610
 #define SE_GENI_M_IRQ_EN		0x614
 #define SE_GENI_M_IRQ_CLEAR		0x618
+#define SE_GENI_M_IRQ_EN_SET		0x61c
+#define SE_GENI_M_IRQ_EN_CLEAR		0x620
 #define SE_GENI_S_CMD0			0x630
 #define SE_GENI_S_CMD_CTRL_REG		0x634
 #define SE_GENI_S_IRQ_STATUS		0x640
 #define SE_GENI_S_IRQ_EN		0x644
 #define SE_GENI_S_IRQ_CLEAR		0x648
+#define SE_GENI_S_IRQ_EN_SET		0x64c
+#define SE_GENI_S_IRQ_EN_CLEAR		0x650
 #define SE_GENI_TX_FIFOn		0x700
 #define SE_GENI_RX_FIFOn		0x780
 #define SE_GENI_TX_FIFO_STATUS		0x800
@@ -101,6 +105,8 @@ struct geni_se {
 #define SE_GENI_RX_WATERMARK_REG	0x810
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
+#define SE_GENI_M_GP_LENGTH		0x910
+#define SE_GENI_S_GP_LENGTH		0x914
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
 #define SE_DMA_TX_FSM_RST		0xc58
@@ -234,6 +240,9 @@ struct geni_se {
 #define IO2_DATA_IN			BIT(1)
 #define RX_DATA_IN			BIT(0)
 
+/* SE_GENI_M_GP_LENGTH and SE_GENI_S_GP_LENGTH fields */
+#define GP_LENGTH			GENMASK(31, 0)
+
 /* SE_DMA_TX_IRQ_STAT Register fields */
 #define TX_DMA_DONE			BIT(0)
 #define TX_EOT				BIT(1)
-- 
2.45.2.505.gda0bf45e8d-goog


