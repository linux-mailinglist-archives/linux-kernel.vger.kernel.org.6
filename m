Return-Path: <linux-kernel+bounces-401545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351399C1C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593F91C21F13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5F1E47B8;
	Fri,  8 Nov 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="REkWowVA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AA1E25F3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065043; cv=none; b=qmfjkLpLSnADeKj0t/4RbZwJnkGZHhemGINe+j36/sKe2qKqX2cK6aX4Pfv1I+UVsy624YPNVxa01e+7qNA44CF9K/EK9VDofjZ09+TBugP4e/LC4b6fjNToXgGYZikY4CM6b5QoGzl6KTPBbvZpQkaGVjCx9j3Mg67Mo1ihk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065043; c=relaxed/simple;
	bh=mAPRkq8mcGAitqZ2NJPZs4WYcWRS92IxYDvqOFLptL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwW8eaA/UJHVfs+aziA508DcQhTUnCienVxLNMvPVyczYlCWe+/R/TyP/F91/FtmtlsW4XrWrrpEZeLABkaSjBEvUEadXnS/FtrcUtdXN8AcmlDUUsp90Y8FlsUXk02fOKmYsmVYWIbEtQ2Q3nKHpeZmTu4Cex8AvnyLv3BTbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=REkWowVA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1427778f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731065039; x=1731669839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=REkWowVAGXFPJsLao/LHIOwLWbc7bC1/om4qfzn8elqIvx1CDGor+LfsvAEKRs5ONp
         HrLWQ41Pz+FCFIPno/G61I3/QOMTCYiVD5rkxsDx0n62c/ta/f2UdmqML50ZeBeBTCmn
         2GpB5OxxRnkhUEhutTzAEVpKHO6JdeKfsIuvIzmoyRsy379tSkAtIibOJNk4Uq6Nfsxk
         iUl7TEhWSKGOAHZUG9Jttwe9R6VMP80E0rQSK/68Szo9bhKXOAnMvsPQlEX8uNKn4wz6
         c8fZSfxOxGNpM7V1/XgTDRR2f6fsCuqYFSFx5Wk/qmsLyYNsIHnXi2PEGVxI2aUSVGK0
         x3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065039; x=1731669839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=w7cOrIpXxveFtq9uXCZTaTKIU6buwA7V15Q3f4i0aAz6iq5BWWwd5XblUVnIgyRELa
         wRLSMMFeLBKYUmNnzPh5Jg0rRmqYmVOmsOLkzNopVAfE9OnN0/1V3Pnsk04Iv32zduQw
         tQR7vsbTHURmItyOZMrUrnCYfK6R05ET3iM/2ygXYltNroZauEU5DESEa2uhUYBe2Pkw
         IbV7tEP5PMT2xfv/dH/8k7Z8M1Dr81ktpBfOpltDeuVZdJlx89zX5f+abV4xjFwiQLSu
         4svChv+ugn2mH8CaA5Uz/t4s57uJBHUHwyr043XTgOPEg6mBKD9v6AufPGgfCaWAn7uA
         fNrg==
X-Forwarded-Encrypted: i=1; AJvYcCUqhlJDxYu7w1AC4LfkqG8XtvjlWn/b68O/5s7lMAtIU2EMiIJdH3uDnFMvX/FIU2ZufR6UxD89bNdD6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpB+qZnVcYR/6uTa2pJQUUFGukbrup017X4y6tgNsPlHmjHmSX
	43380cy1gE85Jp1KpfT8xxk7fEbcoRxjzA/x/fvAQi7tvx5U+0+3DioHt/Q7pd4=
X-Google-Smtp-Source: AGHT+IE2dTZAM2eNBdyoJ0vYP2310xH3HRvixP7wsdVyd9U7THrSH3mKlvans7ZEtSce5JJp+KGjDg==
X-Received: by 2002:a5d:6daf:0:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-381f17253e1mr2103427f8f.27.1731065038785;
        Fri, 08 Nov 2024 03:23:58 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm4281443f8f.10.2024.11.08.03.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:23:58 -0800 (PST)
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
Subject: [PATCH 1/3] clk: lan966x: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 12:22:34 +0100
Message-ID: <20241108112355.20251-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same LAN966x clock driver so make it selectable for
ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef709327cba1..713573b6c86c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -270,7 +270,7 @@ config COMMON_CLK_LAN966X
 	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
-	depends on SOC_LAN966 || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.47.0


