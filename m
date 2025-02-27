Return-Path: <linux-kernel+bounces-537197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C9A48914
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBBE1611C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C726F443;
	Thu, 27 Feb 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnpjKxC8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3291C07E6;
	Thu, 27 Feb 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684848; cv=none; b=ICfgSCQiFv8vV5qK9BWrqGbKwY0hloOWq6XD+NACDJyU89dqj4kuPgAJWV1LGj/6cbswCOvxNCNkjPFIuDtlEozcng+Yo794NMWmFj4126x3caWjUhZoH2ZFxlPHsSumZpEqhnEvC4KU/RVqpXDG27v5XqUlkXq+UUCDYW+7yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684848; c=relaxed/simple;
	bh=8Ja3G+/8biwQcQyQlcOcW5AKkLPiN5J+6s9uWWE5tqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NfTPspl8M0VR/ZxV/riq9D5nvXHdhjawipZplhlVBWmxhNiyczYWIqDSkuOVYxP0FgG5a6AWXw9Gtuun0AbXj3R3e3LyHdD3BsSrKK0+zEhUSJQfCrjlbyaCi15uwt+HiyR6QuEuvW/AtcOV4ao+apbpR8w6JGn/DVcOx8I5yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnpjKxC8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso2537555a91.1;
        Thu, 27 Feb 2025 11:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740684846; x=1741289646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6T71r4zbRHPgqZ0EGR7Irt/x5iBPir+HkN1z6PeyLM=;
        b=QnpjKxC8e2npeRfHm5ZHIfJ2FKJm97hxorrCBwpEHFzh6z4q4FBqdqyT13X1jPpmw5
         XG0MS739dFIxCWHEQNtj0amYxgAexqs6exGzxWiHvEJZperHRBloivmvatpGVrHUr32z
         EFXjfeIW/Pp8N3Y/4iu/yEfGJofAVF2lLibYxclbGhXD6JJfJwfiAbc4lcsX9iXKeXMs
         0o7fcTHOs6Nx1MxZZAi+RD/5WEtmcCkEtREIwkMxQE68iJPQUioiOiCVfwz2EK4WoLLW
         Sp0s6JoWBgj2TtxyliXayaulme+tHBivgtyy2LmJrMRiFdIOq7YR+ICd/fVlpDq5EVI6
         t4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684846; x=1741289646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6T71r4zbRHPgqZ0EGR7Irt/x5iBPir+HkN1z6PeyLM=;
        b=xLDYvn8gSt4JJ+cPAbLaYxcrcVUwESjt+gGkA6VfhehOeNtOoCz1XCJIrfGLBRIZI5
         hk8lKMo8qkzAkVcfmZiJBoleB6Iddkr+0NBIabd+zFsyR3ypRg4HZgfSZ9zux/SyB6WF
         ALGwY1047Qs2LgLWUaQyDKWmMes8qn9SpNEDyA9bz5HPWvHsG6hZuBMRal0JLVVCZLJ1
         tWqI/PcnhBGUmpmiY7rQRgtUAXnMyj2SsCC1AnJQ4WRos1+GTeWM+cNnIYIVZyAcco+U
         qAaIKEdklA+h7HtEmaOpfcBrGz8g26beax80PLUeTEvR8pbutKjR38NC8KWckgqaTRXg
         ujlw==
X-Forwarded-Encrypted: i=1; AJvYcCVRuDk08jyQOdm/dx/HKHTmG1tSy0TUQAa6u9MMZOe/v47CXoZuTksACSSKda9rYxi8iExXEjQble8eUtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgKXKusu9BcQid9AikJzxpNYQ0KXmQOXMACE1fDCRbJtF1+fc
	/oQm/Z7/SIUFfC0Os5pB6SQamL+IPfm989fdu7nIKnFMNJ1RD5A6koYRpCIj
X-Gm-Gg: ASbGncvp6LWynP8iG0DzOcEzNiytb9dNueU2sbjyoK0nUZEthlylHoDyPnHw9TdLMSR
	WueTZLUZVU4yVMlQeDOQZGXg2ozkPs98rBMorge89dw05AwCfBIisyJs7vphDw9rPZCYu6Pyj1f
	MchPA8zQnpS6ifKbZVF2ahAoTIGm6SZ71MYSa8m5ZL12eXYY8NTV28Z/lv1sKIDyqyt17ZsCohp
	t8fOcln1ftTjqgZF3TjDCwmC+GdHqSecu/JSxUh7/13LfQt42ZNyd3Wxjt5GiNsXewMjDIA1q2D
	gQMix6Uzoa9IgzwM1RQT8K6lypuseVTcX7gz
X-Google-Smtp-Source: AGHT+IEtaJTwHxtP9Ru3d6ucWaSgP6i9J4IUsBMK7rftHq3rP2kpeqnN6gjCMmpitMQ1/Usfy8MGvg==
X-Received: by 2002:a17:90a:ec86:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-2fea12683d9mr7377411a91.1.1740684846304;
        Thu, 27 Feb 2025 11:34:06 -0800 (PST)
Received: from embed-PC.. ([2401:4900:1cb5:84b:96dd:21a7:7ff3:7964])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a990csm4224057a91.2.2025.02.27.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:34:05 -0800 (PST)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH] xhci: Fix bcdUSB initialization
Date: Fri, 28 Feb 2025 01:04:00 +0530
Message-Id: <20250227193400.109593-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize bcdUSB to 0 to prevent undefined behaviour
if accessed without being explicitly set.

Fix the following smatch error:
drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc()
error: uninitialized symbol 'bcdUSB'

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 9693464c0520..5715a8bdda7f 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -39,7 +39,7 @@ static int xhci_create_usb3x_bos_desc(struct xhci_hcd *xhci, char *buf,
 	struct usb_ss_cap_descriptor	*ss_cap;
 	struct usb_ssp_cap_descriptor	*ssp_cap;
 	struct xhci_port_cap		*port_cap = NULL;
-	u16				bcdUSB;
+	u16				bcdUSB = 0;
 	u32				reg;
 	u32				min_rate = 0;
 	u8				min_ssid;
--
2.34.1


