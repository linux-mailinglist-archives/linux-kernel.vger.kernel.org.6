Return-Path: <linux-kernel+bounces-379688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855CF9AE24F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D29A2820EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2A1C07FE;
	Thu, 24 Oct 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+UySiUl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00E1B0F2B;
	Thu, 24 Oct 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765018; cv=none; b=jJd+4sYm91QI9s5cba22XX2DkjOGWZHjeSaW1qUoqOln38Ji3RSbin7quXa2zcBGmN0bbU0xqfMIt1MbzXS0O4SoCXELUubUDTj0lwNo3qoWV56Umik5Lz7b8PMPsRXRD/vDhEkhej5iGjBXfRo0mbzJpE+N/zfSTZoHzt7zqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765018; c=relaxed/simple;
	bh=qmPDOcWi4GZ2WL2qnJgzDrV08NLOO3YnKWxWoOl+R9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjajhMZAOit2eP89nSU94x4vwyG2gpUFt5lDCfA7qymkoOqbbKZgeWjPtZacEiBxvZjs+3BaUTgPSEM8GAkmJ9JdYrqn1ZtQrt/9XakIgwX41bDKpJpGO+rlmbropNGGAxyqkRHp+vFX0N86LD7z2wpeEq1vgIF9DhPgRGdIKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+UySiUl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso5192945ad.2;
        Thu, 24 Oct 2024 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729765016; x=1730369816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvZ1ZhPe43+xA+24X/t0+zXdfah6Ns/POWttndJQ8qQ=;
        b=h+UySiUlyGPGbUci6A18FH9skJBdR6NFSBV4cnpc0KIbVYCbx75B7ZDN4cMzRPbyo+
         6YDPBTl7+7iU8pzmzTwGbN4Jp4JrrQWCN3qn9TSYEsc/+8XmwCEm/SIIbr+l6B3L54Am
         1V+hp9o4ZmZEdOKqma2C1eIbFe/X8wLS86F/aVYoLr28XN8/M9eKxYFaEXfuhx3b+QCq
         MNLaPCfPd3cifsDjqwRIQyGBzqR8eulKR5jwkJHP6hvJfOQE41Ne/qpNlxeBISRm693v
         ek2d/IhOjhMw6CO26rzY/odgNw4azJl6wqcuXxfbwmuFO4nLUHKImmcnaUCdJWMA7IhY
         brig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765016; x=1730369816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvZ1ZhPe43+xA+24X/t0+zXdfah6Ns/POWttndJQ8qQ=;
        b=L5D7QTWsqafR5HXlfa7+ueVOHo4oZBNpNDBmEh74y+BLaulsrj6pe/GzP7i+Q2+Axl
         yZH73Y+06ZJWSKFBXf/rnoQt9b73BYSd559TPdCLZOq1eC46WSlOcQF6IOKQZSZhW5OF
         NCbu0CzF1uolPv2c3Q3RoYJfBvLECOu93dTR2+5t789WNWnHhH+MPpUhAlHlHctj5PfD
         V7SXKsJXTS2P30yXziykNYCtzWA1IQJOZrPlYbJnY899+7Zkq+bHvAMmS1jUpo3p5VWT
         eoEfAwBtLO/0bJj5velo75g7jiXYcLaM+LpIK/q+CJk1L1nPQTw2xx/+I4rVWtpj6ScG
         YBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUbVFqtc2sx62V0xJqpLGd7U+nuTk8rbm0UVF9+TKyGn8RXrLV7M4eEVpHDUKOZaVVMC9NzhBEvE1Ir@vger.kernel.org, AJvYcCXn3MH5hlandLPZeIJYIUjoznPRCOoricsndtjW3JiLfuOeoPY+SFjtFutYrYS3xIlDbPfJ5lRrhwIXKng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQavFZ4dWVChcy35Ncp6AQnvmbx6EPHblF9U81vawQHw/5D9x
	80uRt7p2x9TyTO0q+a4rSzAalgQDmW654lUk29dishiLs8JsoV7K940NrP1iucc=
X-Google-Smtp-Source: AGHT+IFDHMJxcGzxyDj6XM0QRJdQj9V+xj/hmPYE0tIDSciLcrYoMRr4/vtKEHT6Z4MU+Y+MWNWu9w==
X-Received: by 2002:a17:903:22c1:b0:20c:a04f:927d with SMTP id d9443c01a7336-20fb99d3784mr15869935ad.33.1729765015805;
        Thu, 24 Oct 2024 03:16:55 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5606:d914:fec1:9dc9:d21d:9b02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm69782065ad.132.2024.10.24.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:16:55 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH 2/3] drivers: usb: serial: mos7840: added optimized register setups for common baudrates.
Date: Thu, 24 Oct 2024 18:09:03 +0800
Message-Id: <20241024100901.69883-3-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024100901.69883-1-tony467913@gmail.com>
References: <20241024100901.69883-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

added optimized register setups for common baudrates.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 114 ++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 362875a53..acc16737b 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1063,11 +1063,116 @@ static int mos7840_calc_baud_rate_divisor(struct usb_serial_port *port,
 {
 	dev_dbg(&port->dev, "%s - %d\n", __func__, baudRate);
 
-	if (baudRate <= 115200) {
+	// divisor = (256*DLM)+DLL
+	// baudrate = InputCLK/(16*Divisor)
+	if (baudRate == 50) {
+		*divisor = (256*0x09)+0x04; // DLM=0x09, DLL=0x04
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 75) {
+		*divisor = (256*0x06)+0x02; // DLM=0x06, DLL=0x02
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 110) {
+		*divisor = (256*0x04)+0x19; // DLM=0x04, DLL=0x19
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 134) {
+		*divisor = (256*0x03)+0x5d; // DLM=0x03, DLL=0x5d
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 150) {
+		*divisor = (256*0x03)+0x01; // DLM=0x03, DLL=0x01
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 300) {
+		*divisor = (256*0x01)+0x81; // DLM=0x01, DLL=0x81
+		*clk_sel_val = 0x0;	    // clock source = 1.846153846M
+	} else if (baudRate == 600) {
+		*divisor = 0xc0;		// DLM=0, DLL=0xc0
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 1200) {
+		*divisor = 0x60;		// DLM=0, DLL=0x60
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 1800) {
+		*divisor = 0x40;		// DLM=0, DLL=0x40
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 2400) {
+		*divisor = 0x30;		// DLM=0, DLL=0x30
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 4800) {
+		*divisor = 0x18;		// DLM=0, DLL=0x18
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 7200) {
+		*divisor = 0x10;		// DLM=0, DLL=0x10
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 9600) {
+		*divisor = 0x0c;		// DLM=0, DLL=0x0c
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 14400) {
+		*divisor = 0x08;		// DLM=0, DLL=0x08
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 19200) {
+		*divisor = 0x06;		// DLM=0, DLL=0x06
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 28800) {
+		*divisor = 0x04;		// DLM=0, DLL=0x04
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 38400) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 57600) {
+		*divisor = 0x02;		// DLM=0, DLL=0x02
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 115200) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x0;		// clock source = 1.846153846M
+	} else if (baudRate == 230400) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x10;	// clock source = 3.692307692M
+	} else if (baudRate == 460800) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x30;	// clock source = 7.384615384M
+	} else if (baudRate == 806400) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x40;	// clock source = 12.923076922M
+	} else if (baudRate == 921600) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x50;	// clock source = 14.769230768M
+	} else if (baudRate == 25000) {
+		*divisor = 0x78;		// DLM=0, DLL=0x78
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 50000) {
+		*divisor = 0x3c;		// DLM=0, DLL=0x3c
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 75000) {
+		*divisor = 0x28;		// DLM=0, DLL=0x28
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 100000) {
+		*divisor = 0x1e;		// DLM=0, DLL=0x1e
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 250000) {
+		*divisor = 0x0c;		// DLM=0, DLL=0x0c
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 300000) {
+		*divisor = 0x0a;		// DLM=0, DLL=0x0a
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 500000) {
+		*divisor = 0x06;		// DLM=0, DLL=0x06
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 600000) {
+		*divisor = 0x05;		// DLM=0, DLL=0x05
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 1000000) {
+		*divisor = 0x03;		// DLM=0, DLL=0x03
+		*clk_sel_val = 0x70;	// clock source=48M
+	} else if (baudRate == 3000000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x70;	// clock source=48M
+
+	} else if (baudRate == 1500000) {
+		*divisor = 0x01;		// DLM=0, DLL=0x01
+		*clk_sel_val = 0x60;	// clock source=24M
+
+	} else if (baudRate <= 115200) {
 		*divisor = 115200 / baudRate;
 		*clk_sel_val = 0x0;
-	}
-	if ((baudRate > 115200) && (baudRate <= 230400)) {
+	} else if ((baudRate > 115200) && (baudRate <= 230400)) {
 		*divisor = 230400 / baudRate;
 		*clk_sel_val = 0x10;
 	} else if ((baudRate > 230400) && (baudRate <= 403200)) {
@@ -1088,6 +1193,9 @@ static int mos7840_calc_baud_rate_divisor(struct usb_serial_port *port,
 	} else if ((baudRate > 1572864) && (baudRate <= 3145728)) {
 		*divisor = 3145728 / baudRate;
 		*clk_sel_val = 0x70;
+	} else {
+		dev_dbg(&port->dev, "func: %s -baudrate %d not supported.\n", __func__, baudRate);
+		return -1;
 	}
 	return 0;
 }
-- 
2.34.1


