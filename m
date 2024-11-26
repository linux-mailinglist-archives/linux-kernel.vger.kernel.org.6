Return-Path: <linux-kernel+bounces-422225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3357D9D9619
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFE4283D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD61CEAC7;
	Tue, 26 Nov 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQbq9R87"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF31CCEE7;
	Tue, 26 Nov 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620030; cv=none; b=jgwOVpC+guaqMQNn/7gCPciIwAMF/lfGb6l+NaPxln3fS3uSHC0j5qlzdTA/eaSFJZLbD1u1cBJudNCnCsP4lgwptbmFrXJ2h1OQGUTodPTrKhALXhyHimNMVzlNuaisgoiEPMqNvQ+mmXG1vIOJdfv8RCxpoCKxK4TRFle2+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620030; c=relaxed/simple;
	bh=6vAVYKTiBM1cHHQpgfvxU5XHJSx1M1+pXINMLRKkf7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+bsToiqlE5wUGsVXCY9PugjXXkDLNpZa7CkLiwf1mpTbJYFtRwxY5P6zfYH5XWi4bheYSwdH0xxJLuxIKOXb0R2G3cVXuFIbzHz7PAZjJPxtZ1WX73KS2cPkMm+3d4v4EzaYLCBaZEOSfNoucZlpkUrmU+4xsH0LbeCqYsPANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQbq9R87; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21200c749bfso53588635ad.1;
        Tue, 26 Nov 2024 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732620027; x=1733224827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEBwZCx8NPUgEcdmfQO/S+vdhBOxXQpHUc12agCsHis=;
        b=AQbq9R87dWDrWOG0ejUdLe3CdWrHVhXDSg/NnwrD+cmuTRG3A7X+hKfDXwimEPsYLm
         aqD/Uk9Tafmc/5TaKdzyI+oi7N6K31klULKrPgGJ/akWQP9dsj19CLa98Ymvh/HzGkaV
         KyF2X8W8wRtwoGlUJrvghyeSE20d/EqO7zVr+rmK0yoPMDtmUoOzmQnB+mYK7oPmqmS4
         6SIuiq43PIUa5KuMI3r5sVCzaQ/ThfqqWeFfnmYIVT+35YTOQAxC7inPsEKiZDvc1+dX
         kHqSREAzKkv0rVkdfVkoNBKCB8WmtL2fHsvuanGI4Yv9CzA4ucdqs9lHyEVl4VI8GJH8
         xNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732620027; x=1733224827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEBwZCx8NPUgEcdmfQO/S+vdhBOxXQpHUc12agCsHis=;
        b=Tp2D1BoTJGfREJ9eJhxaM7P93wULxp72RvnkezKSTEJ+vFMZ0WOc8OMBWGz2mAwFjW
         ZoBh7JVWFOTS9CyOc/okHmbtu7WImQzFR/mq/g/oLMmBuntvq0B1U06lkkJ8uLQ/UQFY
         DPASXtaL0jfVHP2HvSeRFWq4+Oc4VrImDfIyxToZdfijyZ1K8WlGblEDtCuIJvmQCJB1
         V434D2SC3vDhWXmPQ63UfzGdlTPNKHL4lt+57j6kj4U1i7KL3nvkw2ylpFORepywUI74
         DUl+d+pgCR0n+F6YvLz4VQm2s360erDPJURWqFfDsKiu+D7GjdK6TlMFp/00NjI3PD9f
         lFiw==
X-Forwarded-Encrypted: i=1; AJvYcCU/chxOdOAkKcCrrJWDxlGooX2nffBUdkUMBqykT4XYABz3V36iPbg6xLo3y+DKaOdtAfS7ksoJIHwN@vger.kernel.org, AJvYcCUCbcvTR3taUnjQkzXaPObWUYHiaNHOXcfL38aqW5Y8FBSUytB6evOaIE+0qQuLDLs5n3U4N02Q4xNp6lEr@vger.kernel.org
X-Gm-Message-State: AOJu0YyQo99GfIRyTAVFP+NUm2gA1T4KIUIUk+7AQFEb4hQEUDV5NwWH
	ShRzEMj+uP9BBfRYkuiPM/aCFuA1F+tUzGxpw2z7iR4IFv9oY0HmvZwxBPOp
X-Gm-Gg: ASbGncsy357rNPhukNNCG9Ird6xTSovZdSLV0VNvje2aMetvIqG+WJEV2pcbkJTpBSE
	6WsBkwU44XARMwNJpxamxOZ7wJ7H98b+iNp58OpLCKUVQ6aBLDD712Ozal5xubADYdi/aQa3htv
	e/89m8bECYnyKEH8pHh3vfh2b+cVmpq1lvwNXvue+PpsIGywcYZYLICVyD4GuK62nQu2Dz4G7gA
	vsYgvovX19/93ohraLhZw41vOUCvTM8JCIFgIjNihP/5/392bQnD1gS3CfP8TvTlYGAw+ujZUI0
	6821QbkqVuFRcntSs7JVnmJMQynRt8Uj2Mb2w/xDHKX8Tgcwa6pPOs8ulVNlTtDM
X-Google-Smtp-Source: AGHT+IGjrX9bFz6qa84/F16kDGT6fonLi587arQ3HaODJ+5CESb0p6QYyvh+erm3gzBxo60c5al2IA==
X-Received: by 2002:a17:902:db0f:b0:20c:b485:eda3 with SMTP id d9443c01a7336-2129f2262a6mr206975015ad.20.1732620026715;
        Tue, 26 Nov 2024 03:20:26 -0800 (PST)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5d4bsm82210885ad.80.2024.11.26.03.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:20:26 -0800 (PST)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH v4 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Tue, 26 Nov 2024 19:18:15 +0800
Message-Id: <20241126111817.2331577-1-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
---
    1. Modify email content.
v3:
---
    1. Add mail list.
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically. 
---
Jason Hsu (1):
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

Jason-Hsu (1):
  dt-bindings: arm: aspeed: add Meta Ventura board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 883 ++++++++++++++++++
 3 files changed, 885 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.34.1


