Return-Path: <linux-kernel+bounces-293778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9095848A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694A11C24074
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7318D644;
	Tue, 20 Aug 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUnyhzXU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8218CC02;
	Tue, 20 Aug 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149870; cv=none; b=o46yLjPvy+lnIP1M99nXlMnIceid161YPY+A5x6kr5nM67kxZNFNS5VhOsEB+jnK4UYlyRWxdtwLcjt+cIUAoAQRwI7LBH4EQliiJAXpgyKysw34yPlU7kh28RdT8hb2Kuyr/vwUqU1TmDP/52XixijgWIHXkA/bMny0wrtkNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149870; c=relaxed/simple;
	bh=6U+Rq43Py/qr0yv50hH4+NhKmRw4lR0RPz9gUMcBq5s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=We4Hav0j6nRspNW16u1a+JEE0KgO06rVs4NofEokZ8V54/kc+lweAET44IqLUAFlQnBMDX8Xb8BuV3cr/YMaviA2ml+9uMy+jtpTJzcN3kjctfSxeEXUwkAVPq4ofFeByMhdPdeN/fYSiQPiv/vW06jKoWIKtxreke31ihw1jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUnyhzXU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fee6435a34so33564115ad.0;
        Tue, 20 Aug 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149868; x=1724754668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8KG5dQytcwjdtzpovPzJqJoYJR89MLqDb7pWxZ3Btc=;
        b=RUnyhzXUNZEIc0ou14lW3jbYuS3GGo40FAxEHcJIQ34nMmzoclGxyjy0uNlstS5BEU
         0LxxfUkk4X7DeXmhKvuc/h5dGF1aiq1HAz4hYyzD5KOAQEnTMbbFGPDKENaXb1/GjtUS
         qUqLgwO+PEY6ODthWKDIak5QJ2BJmzKZEPOIoprxSF8UNvP7V4cKjY5r2uNpi7fK5MBm
         AoQVUAuGeo8P71XB437+92kWBt2gvDcGfnFFqVbC0Rky1YZcoPXltIivxI6+7NBiW7OP
         tuqpFDE1EAmew+WE8NrN3f6IZEvS9l1wzCf3/Evbj4V2UhsKYuIQsZNjAAelZ0LsIzJb
         VTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149868; x=1724754668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8KG5dQytcwjdtzpovPzJqJoYJR89MLqDb7pWxZ3Btc=;
        b=DvGEMYpkCvBx/xEr+ViNXwhI1TtdGDDpmAeasfTwuJasLWV4kKMTZ4VnSOXP1r0aFV
         mWAbEDcxR1/QAUCga/7QeibywLW3dScDSmjkxQpr6b3wLXgaXxtj2T/oODwZwXS2muqM
         OPAISXn974PzzrCI3sLbsPqeN2r9RLV4hx03TYbLqcCDm6W8HnmxUxoAUygd3MnHOVm/
         biPzOj9sbFyeq+7rC3RVQE9hoqJoGNpg91DPZm1KWKvD5ary508AVeYi9OCl+MmAM4dN
         50R7pmXBs0gMZXpRQjREXz5mQrx+Cv7nATJmlpYXnwj5luXucnCVpdkaw7FDWtEsXaF3
         8kLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrxq4grjUQec86IdcXlpFFfPbPfhEelAYZasOemPU6jOJCx2bzXoujmm33EXF3lRjinIWDht5ZhL9hiK9Hyj9kdjvf7pG90o7aXAZpC3yWXfxAmzNaO8n/YZM1H2qPcr2SPoKKZZx5CA==
X-Gm-Message-State: AOJu0Ywfpp8ATLsJwqqoxq2b+7/UdHFpktYal0AE+Y8d1w33EzilGPWh
	yl+Kyk47SGGoUOKvQHvWCMq1fpdxRmIUdGY5nnKTf0aPvCb2Yo+D
X-Google-Smtp-Source: AGHT+IGmvxHmA9LWUK00CwbBTIL4WWWDgRHMSVmTdzRjaleYxC53WdeolERwX2728+kxKkkxxg4tJQ==
X-Received: by 2002:a17:902:eccc:b0:1fd:9b96:32d4 with SMTP id d9443c01a7336-20203f3151dmr117348785ad.51.1724149868445;
        Tue, 20 Aug 2024 03:31:08 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm75444115ad.2.2024.08.20.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:31:07 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Tue, 20 Aug 2024 18:29:01 +0800
Message-Id: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/799dbd97b09693fba6f837e73d4ef3421d604a8a.camel@codeconstruct.com.au/

v1
  - Patch 0001 - add rtc device
  - Patch 0002 - update sgpio line name


Peter Yin (2):
  ARM: dts: aspeed: Harma: add rtc device
  ARM: dts: aspeed: Harma: update sgpio line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.25.1


