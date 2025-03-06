Return-Path: <linux-kernel+bounces-548589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E7A546C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F066166F94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C062080DA;
	Thu,  6 Mar 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glblAv+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274B18DB3F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254411; cv=none; b=DYQqO7ujLtr1/6t/+/yojcczQGfoplEFYCeecOtZi2A8DKCSisajiFE5N2F8kLSxlpE4cfU1/CUrhgNMgw48u/ybPxp/P5wVfhH4GWih1f+H0gEw5ncX6iUhq8F8O1g7NaxBA0F5RrT1tCMIVqimfMcrCPvpUM36M5lQI7pGBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254411; c=relaxed/simple;
	bh=g8ftAWsannBKjScJBkCA+ah2c8W+V8QRLBe3IcWo8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtaD3JWx3PSG7BBVGhAXxrXaD6FCEdLxv0+aelEl6WabEldK9+nQrDMnaB86D1wx1SQmNEozVZ1D37MikJkGNqheMnaSZWiyRuy324X2fa+zRMWN5/D3dx8pQRf9ZjZkoNGEoNdRVzmry6NvWJAs0oNBAvewAArcwh/6Cjt7x3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glblAv+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uubAh/lYg724YkjeIYAscgJbLGgC562xtf2/CZEmAQA=;
	b=glblAv+FUNa4Jg04gkv95nX2C1GaAyCBzCVmEhWLoragJaPVxJRAc6FOU3fV1pud4bAS8I
	+GLRBBLmFZIfpKMZkMSTy8CD3X1F1Q8QV9krYdEhRJNcKThm/gb53OOPLfhal+FdbaTjxA
	akMqshl2WZB8huWtDS8yl2Z9ZFiACa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ZaVSTx6YPiWA4xycZ6nsVA-1; Thu, 06 Mar 2025 04:46:42 -0500
X-MC-Unique: ZaVSTx6YPiWA4xycZ6nsVA-1
X-Mimecast-MFC-AGG-ID: ZaVSTx6YPiWA4xycZ6nsVA_1741254401
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so1906715e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254401; x=1741859201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uubAh/lYg724YkjeIYAscgJbLGgC562xtf2/CZEmAQA=;
        b=KzgIrYhkA94DdkurqPusHSCO5a2nXPyuv7/AuZ2F30xxgtOXd2zBDrCXyQx0h6wgY+
         GWmXaUVCCF4r+OfDcKcIMVc47ESijgNGKIn/LcMfp6qLdTgzzI6ajvof50y/JyoQEdIB
         XcDTC4Lk4vaYQOCCLaF8EY5m5a+BmUv5AjvJKLRz+6AIlwvwfcQt1czeBgoZp/U1uChQ
         9k05WqcDLqUkjjvP/aghb+MeZ3J+cajRPRqXF+AwfaEnrTrQj36ZemUVWJvm9bkOcamv
         ybp4a+o7J+Koe1rta/Y6f/u0Wvpi2vIqaaBStdP5hv3QLNitpcuhRimy8xQ4Mh3tIGjV
         iq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWykKyRFtbQzrfiaY35ZBRXRXiwJCoGKcoakWGRvSZAZ/1XPzRCqMAuE1ZTt9UEDO5D5a9aALIRgeOl7sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcoyPIqnq5r/V0/I9+G+Megj8Nai37RGocjyyJUgwh8iHIori
	IoOIOKKa9Eey6ojxY8uX1eFV99kvIzSLTnBsazg7Bn8IV+1GqxWQv1Wu6HrTE5bJ/wB2l1QvLh5
	RV8bYc6teLMRsgfNyawrTl3mm1Xd4bmL82dsoUh8E59/vKYzluTtFAp4a4bHiAw==
X-Gm-Gg: ASbGncucB7RYq+IDOuNXmv/fpvMy+P7AkCf82irbg+3zXL1C/6+c6HzSPkZxsVr+uda
	ze229AqemQbMMJK6xFj8hR0M5rr96B3xEeD+vmUNZwbRvCFv5JVFwOBUq9oUeGs/Vi4kRc8vuXD
	bya7H0rnJK64OvHZ2vLavOhk1w3YQkG/uPLVxp/RFHdQJCAG84pwUDikxMh9xWvI2vRVivu3lKp
	fjFdVL1nZea0BI5oZSLG2dQT5jOLEZZXcuZs86lef6H+4cAbcfkz3/Z2Za70a+6BTJl2mw/cE0u
	JJ6fqeaU9r1zvh1m97PFDk1e0MJs41T/08c2bzauqavt6VKCpRtY8ChtNTBclIE=
X-Received: by 2002:a05:600c:45c6:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43bd2aed7a7mr43322535e9.20.1741254401105;
        Thu, 06 Mar 2025 01:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+0OwxS2kvbXPrOgsrLOM5Fgn/db/xRV171b/5GndlWVz9gP9UTft3oKMWDFA44upmCZSkgg==
X-Received: by 2002:a05:600c:45c6:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43bd2aed7a7mr43322305e9.20.1741254400704;
        Thu, 06 Mar 2025 01:46:40 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4293250sm44159625e9.16.2025.03.06.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:46:40 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust entry in AIROHA ETHERNET DRIVER
Date: Thu,  6 Mar 2025 10:46:36 +0100
Message-ID: <20250306094636.63709-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
folder") moves the driver to drivers/net/ethernet/airoha/, but misses to
adjust the AIROHA ETHERNET DRIVER section in MAINTAINERS. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Adjust the file entry to the dedicated folder for this driver.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37fedd2a0813..f9d3ff8b4ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,7 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
-F:	drivers/net/ethernet/mediatek/airoha_eth.c
+F:	drivers/net/ethernet/airoha/
 
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
-- 
2.48.1


