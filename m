Return-Path: <linux-kernel+bounces-201024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447F8FB8E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D4EB2F999
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3469146D69;
	Tue,  4 Jun 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWWmY77M"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF1146A98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516906; cv=none; b=e/qw2fsvm+Y0+Cc3iJ7SG1g9cmbt1PNcdX8Z5v/6vf0j25ylYjYTCxHmgu5+lpgZ6WQkYIoaNQYFi3YLpfQia9tNVmZPdSTOIWNfvS1oxTWOR68ueQuxypmry8IX6Eh8lMxZyq13lbpecoXmSQNLaEgeuQ6flapFoUjxN0pN6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516906; c=relaxed/simple;
	bh=eNI9NbGlMBE/dfZEleY3KsoUvrO1tZDSmMJ0X+X0MGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrwKPyOi+2UPQ/8Ci9C7fD1dEBh2vf2RvlX4S8LqMyXPIoj6xYpbMs/wIOaob51lOs6UVrwldygLGf7mRL42hiJ9FYTLazP52AQTKK3SzMetBwnaBx5gGRR/o11ojhvwlF3+m5iXsRocaynZam9vJuM3tNwpbpLxg1FDYfHfWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dWWmY77M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a52b9413so45192715ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516904; x=1718121704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk/4AF49oXXnNFUX5+Su2//neZ/RJyiCOhQzShR517w=;
        b=dWWmY77MmJz1wcpYB9iFB3yKS0xNqv84Xw/fhPN9m/htFT7/fTyURD+8xkwz/rQQAl
         jf+w68fA16Cn1lH8CI7ceB4ubbZGqDxOyrD+HU7jLkziZF8Bh6e4i+zn3QZ3HHPB/02A
         fkoEhnjRzoA/6Jibkyl21DYxNfRgpJa2JVKOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516904; x=1718121704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk/4AF49oXXnNFUX5+Su2//neZ/RJyiCOhQzShR517w=;
        b=UQhtSP2bHaDyR+lF8/jlBcLr54sFszqg2K99bnsaSJTvq4dgGLrQaJdxuNsXv3xsQv
         GfoCo9cIMdHtpNSSZ8eM6XepYiF9e2suUlwwHlkPiW/i8MKarQBlt9vBTMZlHZoiDfDP
         WMMNx7RihqX/Se295vWNRZCqrkf2+8vyib9yUexg7KcSRoksPvh2sxSO//MNqNPwb1D5
         wGErNNJDY+v5YcfAGGqzkxRlDE0sqUXHQxfUzGHgeduOrBwC5LGwtBhFvYBpGbSQ0Bv5
         liq5JwJSjiC0yEC2V+c/owFnQ95YzkYaAmkeJpLJs2WrhHbpkShjH+fY1NzUZn7j1xdD
         vwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCtLaYJlwmJt9oAACZoA7NTyBOgRreN9fYQzl/Jj6ACTMcHsr2uFJn/+U/Y0q/10/X0I/QcnmZ0Bh7GgXikzsLHqVtG+v95olOti2z
X-Gm-Message-State: AOJu0Yzs6Ss0tvVhDkyL5QvCOd1duHNZAw0aE4rGMZZGXBrA75yRMu56
	YK3KoSdBmgHVWzUupajV3XogEGZBGhPJpXM15qRBmL7/F7/lSrNAYmYscbwjaA==
X-Google-Smtp-Source: AGHT+IH3gIE1OtM086DyyhTOWjAt4JmRQYlQLYPgpkVt7dUI95yVU9Qm9mU9ANKuP1Vy3e7A+IdyKg==
X-Received: by 2002:a17:902:ce82:b0:1e4:c8b3:dbaf with SMTP id d9443c01a7336-1f6370296c6mr142181615ad.33.1717516904142;
        Tue, 04 Jun 2024 09:01:44 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:43 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/7] soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
Date: Tue,  4 Jun 2024 09:00:27 -0700
Message-ID: <20240604090028.v3.1.Ife7ced506aef1be3158712aa3ff34a006b973559@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
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

(no changes since v2)

Changes in v2:
- New

 include/linux/soc/qcom/geni-se.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 0f038a1a0330..8d07c442029b 100644
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
-- 
2.45.1.288.g0e0cd299f1-goog


