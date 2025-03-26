Return-Path: <linux-kernel+bounces-576751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61441A713FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB6C1898853
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2B1ACECE;
	Wed, 26 Mar 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp/dFAXL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8A1624E5;
	Wed, 26 Mar 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982278; cv=none; b=FhKBKcu+X7sGgj+Ngs813NWx44G0RnyACBk0WxPC7TAvFot0RrQMr7+7l1KQGxvCFH8GN9D4KTtGN5fgEoMxSNd9UPYKeUxxeuX8ptJPKT4rfOAcdpOxEVvvvn0ANug4h2sOoUjQ91s5HAzJXIuEcKTN38PpHLhC3uKcOkLSdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982278; c=relaxed/simple;
	bh=gJS4ScYiMa+n1OgZyN7+oHNp2TWwRLSqoGKBdpG7u5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOTUVbGkMYxScwWYlGA2buHakA1vpqq6JDgtHzpEASCLg4+hPymu9XN8zJPjoF8dPcFBHX9tNSY2TIcftWDCo9Kp3CAgtlb7cmN7VkfEbaRqTX1c5CNGYJf+QYC8SpE9f7GT46DrxxzPGL1jE1GNEg0pJ1Z/+nu00ssVKIer2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp/dFAXL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so10037072a12.2;
        Wed, 26 Mar 2025 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742982275; x=1743587075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf9Qik9JrvC930iZLcWEILH2y/FBDHFNXrRtgx57a54=;
        b=kp/dFAXL4QKctnJG3o0tFsNGw3LZuriuOvW/pPMTK6dD6RIltxtTVvxJlMCVuaQ7DS
         r91prgWn2yKBxMUgtBJWBXmYWUVpDz128Aca5eCQsYA3+aDIIu+BB7+XbuXVJx2cagK1
         O5kVJwzbx8o5aChcqZfTeIScCsiY0euyoybpWKtKvITqvVZfBlKOIbKWIpoGu4dLBIju
         sXr/BU4PygYEDZZEOLZiPwPYZvB80ei3g52YQxfJglnHCYaYfW9HS4WGAFXQm6vhlQFQ
         ZqRxP5fAb86FKbpCrKHlBJUMg6WIRyhyyDff7pn+r7gAgKJGhWrUL1abXHUxgSDXAZo2
         +awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982275; x=1743587075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf9Qik9JrvC930iZLcWEILH2y/FBDHFNXrRtgx57a54=;
        b=DuO/AS6EPDjSFGGxZR4uW3NllqJHa6qQijdxpYKJna/PtmIBtsxa4w3BCdn2eQwZs3
         CbLeRrH4jQRiMlU+K+ZfBDHcHtAcJsXbXUVfLRcwUB8paqMT1xawHUgfbPBX76UhgsT0
         91eZ2VpBNFlTps4z4zR2PhRCrmLc45j1ZyYgsiERlAyE8paJr+9O1OUuC8u+Bj7uqqRH
         w1ku48xNUX00bgVLS3RQ0ux5HDmzzc5VaLfkpTbQAmUCQA5lm0st/0mAhbHWqeLmyIMt
         AOVZveBvA2RjnkYfMMhQuxl7nQMLN/Zy7Zd9UdBlgJBWAGgZB4JCeZiiGsP/JRNh8Tja
         sMnw==
X-Forwarded-Encrypted: i=1; AJvYcCWKCUOErdX24sm2CkRujFB76Q1Cg/aCRKXmoSi8o4a9MBFPVWWF3PJUOLwnnqZyRS8LDmpnQc8q96AA62yR@vger.kernel.org, AJvYcCWcRn8CMAmITi7IwqRz40uLbDE3q97cS4aDjQ4u7Wa3dk+F7hbJiWLdYXa14A9u+mS6R0TTI7peQrju@vger.kernel.org
X-Gm-Message-State: AOJu0YzNM3YhmSz/fcAM4rvxsUuQTOeKp0NPUjrgspYxrU77okOzvl2s
	24USBQoi8w480CbJKgoYxORwLJvyhJQ+z5isZNUffE9t6fxZPCGI
X-Gm-Gg: ASbGnct5obFg+j8tCgTp2WQhuA2v+g1xzBguqZdTbEUKoarhq7NBinhv+Sj2i+qBEAQ
	VFwYi0DQSd9P2aKJiEqdzFfKwy05Jxi+Ob0zTI93VX3tRmQORFF7ASfv4NfvCdCvqNNePYlTIlU
	ZqDdo/i0WCazQqBniSWqbRWF8Az+VawH0fBlPEwzRrqbv1RqWu4hespOYcTcDTtG1hToquyx0+O
	HAeUCbJSZrmwxhpGIdVrJePKpymrW1gn1fU7Fk99gQthL2DSCXB5SV19PiYSZsgTgZd2K+fL2Q/
	F4flEIPiGeHdTwpB/FC/1oC6nJnYnGKB1O7ED1Xc0iWYd+30
X-Google-Smtp-Source: AGHT+IH8Taqu7aI/lWPv2IBnxRCsvnXj14enwizoDVnhYG8dsv3YswSIDdexqlS32FXzM7CZDSYJSw==
X-Received: by 2002:a05:6402:84f:b0:5e5:bdfe:6c00 with SMTP id 4fb4d7f45d1cf-5ebcd467281mr17652904a12.19.1742982274757;
        Wed, 26 Mar 2025 02:44:34 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf84600sm9120488a12.19.2025.03.26.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:44:34 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add Ultratronik
Date: Wed, 26 Mar 2025 10:44:25 +0100
Message-ID: <20250326094429.2397365-2-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326094429.2397365-1-goran.radni@gmail.com>
References: <20250326094429.2397365-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ultratronik GmbH is a German electronics company:
https://www.ultratronik-ems.de/

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..91285296dbd3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1597,6 +1597,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultratronik,.*":
+    description: Ultratronik GmbH
   "^utoo,.*":
     description: Aigo Digital Technology Co., Ltd.
   "^v3,.*":
-- 
2.43.0


