Return-Path: <linux-kernel+bounces-249455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1D92EBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A281C21F72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F716C86B;
	Thu, 11 Jul 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="EBBzXOdg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786408479
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713051; cv=none; b=L2+bHadYKQ+aKHixC1yk5v/QZ7J78xYutdUk9LYWo9OMaeMgLnrQJaw56EJdtbWLYBO3uX/vzbucUIi29RAbMvT3HnC1DhYAhAxH2xcAGYsUO8nZbaD6gfFs0mR8GhCpHSj/4JVCVOu8cphV4Gz3Z86aT4fyMfLBdQWz5R4FUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713051; c=relaxed/simple;
	bh=3mL/89el+rhRaN9IS1k+z/ke72NIbuHdZIg+R/r1m1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ja4P5BIm7U/2qOVa1aNgxh+f0AvzPNdpksdx7snTnMD6FhKhEyFXVk9UX04f0pqfSi9VcysMAUDwhhgGO75AehBdYLf7qmG8/0vGVkWb/BlBRbiWk8ADAIXTI8/w5D76vjgNR1QlqlWSm3j3npnp8jF0hAGr2UMvJgboOG2EBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=EBBzXOdg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426717a2d12so6762705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720713047; x=1721317847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4Dw4V6THcyE3QUs70oD5S2P8RGVzfg2GK1ldgIuQek=;
        b=EBBzXOdgD/RxkDp/iwcF3cWI4ZOsad1q+KS6rxnGasVG1kgUeegia4JCwW2+Ic1YR5
         3S2vHc6zLLnhp48+fy4vFe6+1VHL5ZnH1NtjcaFxJOBfAaF03Ct9ox1s6KC9NvnHyEV3
         5Tv/zIH5FT5BPZCQyrQ3ZbyOAY0DJSTmWKozI8Zh8tAW+CtzfWawblYmfm6RCTxzlnM3
         QvOgT8oQzVyHfoyz9cUFPCO7C13hC3qiAjKBpObZYoyqWmAZ2j/jYG5RMUXm+pWAUnOz
         3FvJgxlvjxJMFtu2RV+Wvc4CCkZc+RTCY+cy770SAmVxrJ/Th+mbL2VTXWTOaIT44cme
         cxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713047; x=1721317847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4Dw4V6THcyE3QUs70oD5S2P8RGVzfg2GK1ldgIuQek=;
        b=cbR1CAFBO5WaAbVg3LW9EAu8hdGTBdzC2gfUjWCT54nfaqMePLQ9lA8cyxgKamo30R
         uU8n0CjRw/8k4M8rB44Xbo2DH7bVhQXcplbw4CtD9yHEvAnYlRbPUZZjH64/EKZeS+Qs
         WZF7jAOB5p/GMld3W1NM14nFCImXmwisFBVKt1ThXZaBb7SMep59fZjPnrSP3LajAwvu
         DkRg1UnV+ptBfuoIrx9GPp/ofBG6AUyVK2UMS5UF5wD0tdq3yw+T4cE58lU7Yc0reeVx
         kEHXDkL7TfECb6ExHOWKJbUjB1eBc/nSde2/UEAkPcS88uj+EMqOp4M2nE53Jg8jZ9JF
         qj6A==
X-Forwarded-Encrypted: i=1; AJvYcCW5/xqv+duy45Ta8r/rvdGWGpCrzRfou63kzgU0pUXrK4fw6dUzC1pVGsEpLr44vqWvF38yoWhDtOeQLn5CiEv2+9j/UyL7zh7cXDjp
X-Gm-Message-State: AOJu0Yw+bxgIvsHFHGWOL6jsxFAnMQCqt0j7FHpytgqZf+pGGz0vmrBi
	T2KBoykjnNdSTKud5vkd2rpp4QJeDdGDebwHjm//nWZphlmknPbVbmg9SpzAqhI=
X-Google-Smtp-Source: AGHT+IHsIgeeny9WJLCJr9jiWazzei+4vIWuHW0Vft3mOig7QWwiAJex24Zo4rL/hx2YlJrd8uc/5g==
X-Received: by 2002:a05:600c:4883:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-4279da0240dmr669385e9.6.1720713046609;
        Thu, 11 Jul 2024 08:50:46 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42798b63eb1sm32554555e9.13.2024.07.11.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:50:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] net: mvpp2: Improve data types and use min()
Date: Thu, 11 Jul 2024 17:47:43 +0200
Message-Id: <20240711154741.174745-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the data type of the variable freq in mvpp2_rx_time_coal_set()
and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
the data type u32.

Change the data type of the function parameter clk_hz in
mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
and remove the following Coccinelle/coccicheck warning reported by
do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Use min() to simplify the code and improve its readability.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9adf4301c9b1..1e52256a9ea8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2766,29 +2766,29 @@ static void mvpp2_tx_pkts_coal_set(struct mvpp2_port *port,
 	}
 }
 
-static u32 mvpp2_usec_to_cycles(u32 usec, unsigned long clk_hz)
+static u32 mvpp2_usec_to_cycles(u32 usec, u32 clk_hz)
 {
 	u64 tmp = (u64)clk_hz * usec;
 
 	do_div(tmp, USEC_PER_SEC);
 
-	return tmp > U32_MAX ? U32_MAX : tmp;
+	return min(tmp, U32_MAX);
 }
 
-static u32 mvpp2_cycles_to_usec(u32 cycles, unsigned long clk_hz)
+static u32 mvpp2_cycles_to_usec(u32 cycles, u32 clk_hz)
 {
 	u64 tmp = (u64)cycles * USEC_PER_SEC;
 
 	do_div(tmp, clk_hz);
 
-	return tmp > U32_MAX ? U32_MAX : tmp;
+	return min(tmp, U32_MAX);
 }
 
 /* Set the time delay in usec before Rx interrupt */
 static void mvpp2_rx_time_coal_set(struct mvpp2_port *port,
 				   struct mvpp2_rx_queue *rxq)
 {
-	unsigned long freq = port->priv->tclk;
+	u32 freq = port->priv->tclk;
 	u32 val = mvpp2_usec_to_cycles(rxq->time_coal, freq);
 
 	if (val > MVPP2_MAX_ISR_RX_THRESHOLD) {
@@ -2804,7 +2804,7 @@ static void mvpp2_rx_time_coal_set(struct mvpp2_port *port,
 
 static void mvpp2_tx_time_coal_set(struct mvpp2_port *port)
 {
-	unsigned long freq = port->priv->tclk;
+	u32 freq = port->priv->tclk;
 	u32 val = mvpp2_usec_to_cycles(port->tx_time_coal, freq);
 
 	if (val > MVPP2_MAX_ISR_TX_THRESHOLD) {
-- 
2.39.2


