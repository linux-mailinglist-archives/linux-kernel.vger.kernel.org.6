Return-Path: <linux-kernel+bounces-401752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B309C1EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D997B21371
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB51F4FB0;
	Fri,  8 Nov 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="CHG3r8G3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2571F470A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074346; cv=none; b=TkkQimWmyre6Pwp+0nd6WgjzPVvjNwkHjzf0U5FXcAYzqt/g8GzixzrH2zh/u3R7QijuSBirMome7qTrq8EUPhF0V5rImkmPJvFYvQema+aF/O0ZALeMcST/l5p1l0qxQ96HPhTX5bdXp9yVR/TJ4IN8ZX7kqtfRBDW4ufuyp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074346; c=relaxed/simple;
	bh=0qYOjG+PxUVuapY8Zq6vV+DKT4rZuCwk4o65LvIXdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqyhmBxBMdcepp1nAWVJMGtdSyzOFeP8VT382I3zMNpBzwnBCipmKEocOjmd77sK7as9o7lLncWcmFDfKoT49h1QkOkQKta825cvq5au7tfuZ3fniSdAkEUSdND1JT+ox51tI70w13iXI0pKoFMbamr9G4erm1EFTRZ/yQvEh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=CHG3r8G3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1468098f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074343; x=1731679143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdZLopVjyjhT5RSAFFKohTizpIqPLaJt6XK15njFe6c=;
        b=CHG3r8G3Ma4CTi1T9MagF9MzWOZlrdsvhB42Ic5qQKy0nM6yZCY0Q6dlkvWautjMKa
         ylKiz5Fk6IyzoGBsCiEIAaTmT4U/nljUuFNnnrfjRC9X5GuF9tHlcHB3hfChy8CjOi2C
         CjiFJT1fn3oS7fsWeBA3EPXbCrfiY/VZ6hnK79LP8S2d15kdInSBsEdS3H6QWAHSdfyR
         nM4KOVFMpv1ewK1IEG1udSG7ObA1fSeNwwJdU+fzDVR0HZol1xKjsdEDYjMivbv4fdpf
         iHObXSmJkHR0RExOSEDGVoY6HJ5s99DdIxdKtloFPO2ideGdMkNiQuVnkhCOkbSXWt+k
         scPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074343; x=1731679143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdZLopVjyjhT5RSAFFKohTizpIqPLaJt6XK15njFe6c=;
        b=HvlNQLAi/dW1oHnDksF/LA9ff5LwrpL6gfKTe3iHTd2NTc219vcSk87szhMT/I+Cd4
         zwCqqqUeRnWM0xMqQ+6vrgBbzl5va+/r6LsCjyHsgLGvXArbJgl9SPVjq189UsDG+cKU
         T4vg9L4Hl1/jqJuQLe6w2Dfan13iFqZr3KdNSdbMuZ2mNgRBrxnWAlN7umJuPZGRJ++w
         L50napOk9elTtxkMX2bj5/KnZTzLmZ6qh91TOeVM9U+xnmpVdIny6oSGbzlwyEfjIzU0
         GhaXSl16gqTQ96SblZIVQ8S4mELDvxKC1xP3C3pt0nrF7c3u9JaimJ6FVvdj76bB+oFp
         iRUw==
X-Forwarded-Encrypted: i=1; AJvYcCWFlsmHq5QYGb/PMgQf95SpmaUu9UZK3ztMYmqUy2r90QdhTgssV2FzlMGPhw5WboLtm/CYI9SSKHtyfT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpAum/LqZT26M2yJpB9SRLj8tcW2GpPdLGSZCDo+4SyOEQdNG
	jq0P2wXcN2rPDHcwtky1iHBrBIRpi53FSVFmAwGSMIcwBIbe89oF+eMH27TPWOM=
X-Google-Smtp-Source: AGHT+IEU+4qezTXoyunjCox4NNDvtuGiupxZONMcrWhdVQ4IuBx9NDZjHYgJa4s0rv587Kx6mZc+cw==
X-Received: by 2002:a5d:59a2:0:b0:37d:326d:305a with SMTP id ffacd0b85a97d-381f1866f90mr2485874f8f.2.1731074343506;
        Fri, 08 Nov 2024 05:59:03 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:59:02 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 4/4] tty: serial: atmel: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 14:57:34 +0100
Message-ID: <20241108135855.129116-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108135855.129116-1-robert.marko@sartura.hr>
References: <20241108135855.129116-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel serial, so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v2:
* Pickup Acked-by from Nicolas
* Add whitespace before COMPILE_TEST

 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 45f0f779fbf9..976dae3bb1bb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.47.0


