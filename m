Return-Path: <linux-kernel+bounces-401546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA379C1C20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6E6B229A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCD1E5711;
	Fri,  8 Nov 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bC6Uaeco"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164C1E2831
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065045; cv=none; b=OCYI/CvHqerIZ/fsp2gohX/Z1zwQ6o9iLJMsdIekI84sXitP+ntJXih64JnIoOJdw6oHkMoczyBnw4OQj+Nm83fbTV7Jl9qIYLgxYIYvhVzQFyXnhTF1MPuwFenXU9jPCEDK7DnfrgETLpsI2QzYr8rJPmNhqDo1RfQWLJzQKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065045; c=relaxed/simple;
	bh=Hg9luVEPDNEyrEB3D72f6ILBx2FRij6PelggGUIez3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2qYVCpGx5QSLlvWpQWjgSKWha8gWL1v6HP6XEa80O2Tp8EQL880l4QhsrzwhkR6kFVYr1LTuCKSgzxly0G5dwqFeB/zbHx5XsHNbJoN/2/IWK7bQ5HYJgEYyUytSUtDo0enWLxNJ0FrOtJZaqLv/JLNlSbTeGPKF4vieoNPpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bC6Uaeco; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158625112so18227815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731065041; x=1731669841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnSKG3TH+X58AcZRDigmrjfJlOAFQ9HXiZWebugh1IM=;
        b=bC6UaecoBSpprY5fyg4OsKrxS6tZUxU7WWayjsHxmsS0uUMbwssisoK6vW8jhm224x
         OfA7SYAh51VpoQwHU76IyVTfZd5ONW48KIdKCn0ne/lvqUeMSwXcoTp9leRWcLYJcKBt
         JTKdZ4k1bJaG8X583pPOUJqPC0MwF7j2Er7TUD2JuVl0Gplht4yHGVXQM60k4kDhuMhJ
         Y9ZHuP5R1nfhqAlse4bdEL35T+FlJ/0cmgKXsPRm/PBvoqanbnuWxCdWsH3LtXYYSnxb
         Wfcs2KXJPnUswKpdjbi31K2772SvTxY4o8iI01S9Rqpx0RCox81lOzbS2tEt91WeDZ9D
         lj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065041; x=1731669841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnSKG3TH+X58AcZRDigmrjfJlOAFQ9HXiZWebugh1IM=;
        b=OSwKPqyOjWIUc455fTiY4wNhZPlfa2Xnoj/3F7wPwAsQBH/JSEKoHxpL3IJmqrUEbV
         BHMHIdN6wCrGvFbJ09HxBuRygWy26hzmZVpE3M19wHnuP8SWBodQYwREVhQzxqSxh5pk
         nqrfFu59tBeksNmXG6aARqh7IRMcTP+/8V+KJ6aTxzhFTc9HX4cPBjMyqku/Rj2geh/T
         GyH4t5AmZmgTANBeOAlKinAjVc2G/K82RpeUxQQPTRxQh85oocggg9rs3a/g53cXnheZ
         4lLBarn2psV0L0maaFgUu1xKRVv5gF1cF3L35fHZOMwvyqgwDlmM2oBp9Cv2AQBAqJ9w
         EjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJG9g3JLwHLBDiheTaK9PpmTlK2jXz4Z5RYt8aOPEO+ZOpbDSWkFxwhvre6r0PK+FBYsE9W/PHQJZ9BQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/47PEAT5M2OVaGasnqeG34EC8KdWXvHmHfA87LGBmAf/J53WY
	z1/ZO8+ESHxHT3okwUFqGxS93Nt6mgXqa9AGXlqIm25lNHogvCVafHW1wadPtx0=
X-Google-Smtp-Source: AGHT+IFhDdWJ9/nrt/S8un2QtY9kM8UUNO7BtPJoNvy1L5IL1cpiKGJx6XnADmahjiBUVox1mtdnAA==
X-Received: by 2002:a5d:5f81:0:b0:37d:5232:a963 with SMTP id ffacd0b85a97d-381f1866f10mr1897932f8f.14.1731065041488;
        Fri, 08 Nov 2024 03:24:01 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm4281443f8f.10.2024.11.08.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:24:00 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] tty: serial: atmel: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 12:22:36 +0100
Message-ID: <20241108112355.20251-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108112355.20251-1-robert.marko@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel serial, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 45f0f779fbf9..e6cf20b845f1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.47.0


