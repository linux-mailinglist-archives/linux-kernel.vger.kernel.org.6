Return-Path: <linux-kernel+bounces-575161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD920A6EE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3174F7A50D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF75255248;
	Tue, 25 Mar 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crpchLgC"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A681B4F0E;
	Tue, 25 Mar 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900672; cv=none; b=TWI61PDWn6dsC34KIahRvofWb73YNWviCYjGc9IMEzKbpgB8mbb9uaCxx/VeJlJaa3g1Ryji55GfZXKUy43lM5mFcCqZyLtLfXxH8b4Kj+OP9HME1RtBJ3Gd1e6O2Q7ZhAbzBaFs0CegXIa6/R7hVS8m1HDZgUNGqntJ2j9iq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900672; c=relaxed/simple;
	bh=n8tiOBnU2NtRg22qxDTzvMEb0wivFTtptf4nlizabLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKSqk4PTJ0MveEVphS8f9Wn737vO0PAG4MjEjaIdP2hgNazR1Tyc2WZ7rsge6SL1gK0q+9eNGJY6LQPi6KpggmWDh4j9rxxg9qSgIAD2Vzz0l3yTXeMvgU1q566GesY8JvXI0j9sDXKNDynsGBurJ8gpNzvowbXJ5panuVbcjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crpchLgC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8373984a12.3;
        Tue, 25 Mar 2025 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742900669; x=1743505469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7y/5K3K5zXr9SYnsnRx1Xa8HIQouwi1RF9TlE0iU/E=;
        b=crpchLgCYyUYacnQs//AkAfAtHYMZwRrZh/qHdgMiGK4OQR67F+hYwOiu3nmbkGRFi
         macuENrIk22kmiXGEdMrUZ4rSl1fvedGVm1VbC3/pgD+cdZyikmjT5fJayX131XgbywW
         aoVUE8z3q7S6W48G5Q/LrrPCSYy72YSVkfvlxgLonsUzHjK3256OuiR3g5VWQfnvYYEy
         j8ZBG877BpXOEcohgLv8KfNonS8mSUA4B/aaK2o0x1vintSTzN0TeKIgo6FaNV2d/eAz
         kkAaB9Gg9w+gzQP+oDbE1VkjLJruhM+VXZk5R5FVNO2bDr0ObzBUOOBGQrjXNKaDuQYA
         ADFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900669; x=1743505469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7y/5K3K5zXr9SYnsnRx1Xa8HIQouwi1RF9TlE0iU/E=;
        b=NzcGbTv1642VTlsUfOIT4vSgNK2Aq2R/H1hdIDnF3Mqzsg8FjcLfHJtVRf4B6oB0gG
         EJKfX2g/I/zZpEJiCC9AikzZVDPuuqVmFJbzbbcjWIu7T58UbQavdHjxtX2CTARr7fdN
         C7Au9dFc6NjiXPO/+kPeXpND/bYstiXKY7eWb7xDLhpK3TWIYvACdi5gZx2ho2xhka4O
         t6kW15Hyg+vvl2+3hWQtEdr4T/skqUCFDfiD+vmMZ4wlqmyOj9Ta33t/ygJJJhvqoeLW
         a0ev/j1HNs3TXRyP3lbBa77oqvEnwAVZi7x7+aNgeCo1DSjeY+K0boE3gWv/IAfGGg/t
         IZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXCPoeeQMHzeE06AW+zQrUvVyNj3fbJLKLkrQrq4epOAYI1mVsU0FrbbHWnqT7CYChTEhn+51uAhu8Zr9a7@vger.kernel.org, AJvYcCXEhs7kRtihwDF/J/ZR1h0CAYrHoqeB8ULGR6fxdikVMKQ+AMbK04piGyqL3eMyGAjmBMiCcQQ42Wxj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZvFZsQwmEp72dtrpJ4dBDDsL7RXX28ybAndpilkxPgHpwpAj
	Wq1JZ6PcgxMYSLaVxtc1uWPjpal+Xlo7jNX8YL8twRBAZ6DtikEc
X-Gm-Gg: ASbGnctUWqkC1454FyzTvbXxmVtSIsa4pTRkwTx3kBGBmGeo0XZlC/j8o+sC4aA/9js
	Ij3BNCT35cHBurLJu1Qe1RK08IzkDkcWMq25Iy7RutXIxNk1Wj1LlKJBV2Aabw/TgQmCH8jVYeg
	EUq/0vsIpH61ACFZ/89kyzuGgbjftB1Q83xWYTFF6JlFWcyhVjnC/TjRLPl1RgfnDZECP0eCjrK
	IKfDkvXCe13mFyL7ZfO7/3x+UXenWab2651+9V710+jUXHwd9tYWAfjZlJWJVJvXU1wYpOvQ6XG
	ILv13OVCjPNDiUoQ6q1MkVUia+bqHc1NAMdEz6fuegpT+8U6BVHJWz/94hXlxvEqwIdWL5yy+/b
	xb/F3wA==
X-Google-Smtp-Source: AGHT+IHlMqGTu3mmqZvP0NK7MNjtG8eN66pNcQTLOL0Wk2+owZv+QqgipNp7hNHlntiKlfyLgOXqTA==
X-Received: by 2002:a05:6402:4309:b0:5ed:2a1b:fd7d with SMTP id 4fb4d7f45d1cf-5ed2a1bff96mr121240a12.19.1742900668715;
        Tue, 25 Mar 2025 04:04:28 -0700 (PDT)
Received: from wslxew242.ultratronik.de (mail.ultratronik.de. [82.100.224.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf8cc99sm7556809a12.32.2025.03.25.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:04:28 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	=?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Ultratronik
Date: Tue, 25 Mar 2025 12:04:05 +0100
Message-ID: <20250325110409.2323611-2-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325110409.2323611-1-goran.radni@gmail.com>
References: <20250325110409.2323611-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

Ultratronik GmbH is a German electronics company:
https://www.ultratronik-ems.de/

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


