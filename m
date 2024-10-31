Return-Path: <linux-kernel+bounces-391177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4139B9B8380
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626951C21321
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40F1CB331;
	Thu, 31 Oct 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBvMknrS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198538C0B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403379; cv=none; b=W/UIZZ1GP8e9pFcYpC3KFMnsvKnGtKIcH6O8GfyP8cCvmPeRKR2s/5OOYBY/XbEP9hROyIZhzbOlbmIPYGJB0dfGQxKKaVrgRx7gJFg4S8wBJoXvSlW0vf8ocoSSNUGHVfBHsQ469kCRdbCVcGiHPI3DwOeGcFVZZGOK36Z1GMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403379; c=relaxed/simple;
	bh=Ss71kMZkB3nVBqGdR/PxkFCC6+zFDRf4WUm385aXJIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgJGFn/JdhDRPMnRxMjwZmmNWGW3TdrHwvbakvbFMHNf56FUdf8YnAzdXrkhPNVpEzABPibP600DTIPheyRqX0oiUVhzIWKNvjCkEtVHTHfFJQNiz+U3s/+E+G3k+aWrx6vtvd4kcf/qYmq0UskynELX7ySyIIRpxEAlg+HB5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBvMknrS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720b173a9ebso1092043b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730403376; x=1731008176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JP34bMLyU2ULdaARQ1dvvtCxqm+pYihhRf8aqhhtSoU=;
        b=SBvMknrSQKrL4b/ECHyhq8C2QJQjjHD5YEKX9l39GHhm22zyCGf7QTMf5p/GmLXeWM
         z0hUD99esCHKWFzx2THjcwY9HcyONmp8jtL502An7Cje6yv4HoyKbCmTFKoNV4AFD8L5
         YdwInieGe0sHdhIU0rpk1CSbTOcV9G51Bh7/aKa8YSS88wHGwHX+iPHrFymLy8W2y6dI
         wGaiqCKNt30sa7S+uyF31YfMumh+Yd9QDpvEL1pPg8GOJdJG0j82Tz1jXFwQZAR2Ovf/
         kfP5d9gAz7DhGQtOjkPvKuA55DDMfOKsF0pEdsqhCe9P48Uj5+X6sUopNxKoSB+flI/9
         yzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730403376; x=1731008176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JP34bMLyU2ULdaARQ1dvvtCxqm+pYihhRf8aqhhtSoU=;
        b=OBB955S79Oo2fxmfebBpbnpru0QybUvfGjKBSnN0PIsL+kRHvLun8hjxlm+9glai1C
         sSHmSikwDNEI5qf/7RQ+EEiBI/9qRzLLqS3pyO4draDWOw5qNtv5ROuEnn1HQnLRnX3v
         zmGqOEwxqdqY2qGLaYjTm17XHMJaKr2P3m1Mo15HywdZOA55xa5Nj891QQ9y/NskBM8L
         ImdFZ1PB8Gg2TfwHZptmHk5i8qdVuz6DnJpGIsKEPBD1Egvx8kF6Ex7xDDrHguTD6ifB
         4v2v63N4RSiI8V4eAuDG0p9mYI8y1LO1S4t+YucWDy2AmAsv4mqknbWl6e46r343ytTf
         NSlA==
X-Gm-Message-State: AOJu0YxN+/dbqjELCe8KQlqHqO2KHplRj2Elwed53goCgFQNE8MYOxNr
	SqaMGGnPtSExAZe3cbjxZAhjaVYR8M3nLmr/e3QmiSpwAN5xDKCA
X-Google-Smtp-Source: AGHT+IH0x9Hdi48zugBq3IX7CYinSg5EUVVjQ/7qFowXhJdtwKokqcdkv7kHX/SOoimn7Q48GoBWzg==
X-Received: by 2002:a05:6a21:38f:b0:1d9:282f:3d17 with SMTP id adf61e73a8af0-1db91e53617mr5150201637.35.1730403376356;
        Thu, 31 Oct 2024 12:36:16 -0700 (PDT)
Received: from advait-kdeneon.. ([103.170.81.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc316987sm1453210b3a.206.2024.10.31.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:36:15 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched datatype
Date: Fri,  1 Nov 2024 01:06:06 +0530
Message-Id: <20241031193606.87970-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the type of hw_irq to unsigned long to 
match irq_hw_number_t.

The variable hw_irq is defined as unsigned int at places,
However when it is initialized using irqd_to_hwirq(), it returns 
an irq_hw_number_t, which inturn is a typedef for unsigned long.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index fe2d29e91026..f7f27ee5c732 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -102,7 +102,7 @@ static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
 static void rzv2h_icu_eoi(struct irq_data *d)
 {
 	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
-	unsigned int hw_irq = irqd_to_hwirq(d);
+	unsigned long hw_irq = irqd_to_hwirq(d);
 	unsigned int tintirq_nr;
 	u32 bit;
 
@@ -128,7 +128,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
-	unsigned int hw_irq = irqd_to_hwirq(d);
+	unsigned long hw_irq = irqd_to_hwirq(d);
 	u32 tint_nr, tssel_n, k, tssr;
 
 	if (hw_irq < ICU_TINT_START)
@@ -184,7 +184,7 @@ static int rzv2h_nmi_set_type(struct irq_data *d, unsigned int type)
 
 static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int hwirq)
 {
-	unsigned int irq_nr = hwirq - ICU_IRQ_START;
+	unsigned long irq_nr = hwirq - ICU_IRQ_START;
 	u32 isctr, iitsr, iitsel;
 	u32 bit = BIT(irq_nr);
 
@@ -204,8 +204,8 @@ static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int hwirq)
 static int rzv2h_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
-	unsigned int hwirq = irqd_to_hwirq(d);
-	u32 irq_nr = hwirq - ICU_IRQ_START;
+	unsigned long hwirq = irqd_to_hwirq(d);
+	unsigned long irq_nr = hwirq - ICU_IRQ_START;
 	u32 iitsr, sense;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -241,7 +241,7 @@ static int rzv2h_irq_set_type(struct irq_data *d, unsigned int type)
 
 static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq)
 {
-	unsigned int tint_nr = hwirq - ICU_TINT_START;
+	unsigned long tint_nr = hwirq - ICU_TINT_START;
 	int titsel_n = ICU_TITSR_TITSEL_N(tint_nr);
 	u32 tsctr, titsr, titsel;
 	u32 bit = BIT(tint_nr);
@@ -265,9 +265,9 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	u32 titsr, titsr_k, titsel_n, tien;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
-	unsigned int hwirq;
+	unsigned long hwirq;
 	u32 tint, sense;
-	int tint_nr;
+	unsigned long tint_nr;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_LOW:
@@ -329,7 +329,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d);
+	unsigned long hw_irq = irqd_to_hwirq(d);
 	int ret;
 
 	if (hw_irq >= ICU_TINT_START)
-- 
2.34.1


