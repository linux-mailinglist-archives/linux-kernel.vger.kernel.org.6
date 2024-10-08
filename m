Return-Path: <linux-kernel+bounces-355044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969A99466C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4241F22B85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6351CF5CB;
	Tue,  8 Oct 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Ll3Bl4aO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0918BC3B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386383; cv=none; b=n8iFnuXLX9uMpQ4AlmqEhEq+rAqh8PKNHBHdqLiXr3HE0Fm6D5FUUKSCxLp50ee8vSysnuWLc+hNYvOox1vJpN5PlUAYcjIUyT6U5OeJgMEG0I3kNJQ0DXQi5QQGLSYF9GdIDc5NE6THUJ0SZ4nkaCK8TBijorDbSX6Zi8Vwj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386383; c=relaxed/simple;
	bh=r6b1YbYea6821kcyyk+/o9Ps7Vn8p6Hcspii7DWXgN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GP0AVYbJ4pNyeihCbTfUBpCWvfCEaeUeO16tvWCDh8BPmZvRVYsbpnkDCshoER0xQqSoWxy3Wdww2GMemzfYfo7wRahUxzeYYvYfaE/xkGoRL4RL4pOG3tveQBnJb3s8F0f6YK8LfXLK6y1FOIZOoF1HCcGdDfn+n+zNRdfQoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Ll3Bl4aO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdb42b29dso3466846f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728386380; x=1728991180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qfJuw9pHQcCV2tXijS5mDrRlpcbQjwcuPA1DQvQPNA=;
        b=Ll3Bl4aOfcXMyQ5OOPD0utNLBu4AflOqBXEZivDxUXiDBg6tgEMeQbebCk/O8uMD6b
         4rno5cDg6eOfTM5GhhifOa7aOAqSTk+CXM9c4ye1mOEEkLiJri7S3QRUvhNStP5U9bFZ
         YpgEtkP2yF+HJKkSn8GG8Ja3R4n0YpQOHfgpiXvhj1p+gAhtyGSFdYmNJxqswB0bbHQN
         eSs7AfO5C4jZvtG2AtIh0XD6H5E7da0J4eS+QJojj1f2wejHpdiHPQ6x0d6p2EKbeI4W
         xfHUdYamIggd6PDpAMtFYynY3lZ3ahB/8EbiBrIrZELXuCas/YYNdGawIqA7bTrioeOw
         nKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386380; x=1728991180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qfJuw9pHQcCV2tXijS5mDrRlpcbQjwcuPA1DQvQPNA=;
        b=dWsk93ETjTpoSdagkXAyR6jKB9jradvdw9DqlRsrxTwC7OJTZkfpIT9docL5RZjuYF
         qgaHvYzv6zIwNaIgwKU+HzDPFdcsC2QcKO7mQu4QDMkIKSxR9Qz00WJlroCRUBAYPksw
         PTU9r2talODKV+c0T7wm8WhuQVUxj8NIzY0jvZtRYQOo5faz2s+R918ytfdWTmqwn3OV
         TEURGorc/sc7XPTPbZOvyVuEKMhxTh3CAn1Xynb6nymjtm6LAfc60EZsf4JZ2IcbppAi
         AbTqhXgzjkI00VzGHXdM+2RJD9QADcoB6b8jsy+VwwwxlndtWxiLF2X2WfybxG8yTL5O
         0lsA==
X-Forwarded-Encrypted: i=1; AJvYcCXV9eaAqPzZP9c3QUbIOKEiHd/8GcnARRGM0RuYUqbw/5L8yC5L6u08V2cCXXho9s4xzCFvMPAReKnRMMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcsirAGNVHaL82BqxNHrFbLMMj2VgiG6T+00UvDumfXQaiRBw
	aN7bP3tFDqQn4cFOFe2r8Izzdrgd3U62uMuXsUUey7lAUAtMlPCRpdpPFwjO9aM=
X-Google-Smtp-Source: AGHT+IFm8bxA195b1uyZp9jktngQkPleO9g2tUo+kmM7B5+LWoZMgvYU6JocHoSzi44P0WUqFnE5vg==
X-Received: by 2002:a5d:6649:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-37d0eaea921mr7981155f8f.58.1728386379715;
        Tue, 08 Oct 2024 04:19:39 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e462sm7897780f8f.87.2024.10.08.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:19:39 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Tue,  8 Oct 2024 16:49:18 +0530
Message-ID: <20241008111924.1865857-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V4:
- Retain Acked-by from v2.
- Fix alphabetic order
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..c79c74ab3d78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
-- 
2.42.0


