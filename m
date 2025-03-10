Return-Path: <linux-kernel+bounces-554595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C057BA59A50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFAF16C604
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FD22B8CA;
	Mon, 10 Mar 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiqDy+7a"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D67192B82;
	Mon, 10 Mar 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621692; cv=none; b=keaVvbcKWAWfZJ2g5mISwNtaGSUeNbgxahyDqun8HTTDDp1aU4wKipXRRK4Wdl3IhOsWBAvn9wYE8R0IkE939C0xXCxI2Wh3+IJ+1wgMiibNMwlVXO67xPOTZtDQcLBffWXA5iD91QxZrMqJbWtEI3UxKz7IP/vu3b7mrdvURRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621692; c=relaxed/simple;
	bh=SIVt748yjhXN61lTCBdrIOqbrGqJcOCWdZVCSIknig8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2Vn45m4FZ4MO8e2XuQNzIlkVnTJ059Ij1R4+Rh9Q2HoePUWopOPcBlvFFWjCzbyzHfwPIkWhmhl5A7560fImyY4k7YMGYFpaqEtHHL07rRreST5ygHLE9BvVjqM6nmXQXAloRwBB/nNoYYFFJRAiLOuvDhJ+8+BAdu+y+DpMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiqDy+7a; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so3523435a12.2;
        Mon, 10 Mar 2025 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741621689; x=1742226489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8Qki/M6cF25Z9mXICuii0r2Qp6u8hLmIzSqDO0dJFc=;
        b=NiqDy+7ackWTgRDsNW/LE0yOUyht9F3k2TLbgy+0VInJ/ph5G9FR7QiTgc0Lpk0CK4
         /0PNhOx+hN1i9+7j3fMujfZNjYnSD+VkYbR46wZCIYwe5l/BT2DsV7g02z0JQ+mD5HSK
         hP0oGOV/E3ZJNvGB0pozhNifchdC0s/TNbOV8Agc66XsKT88/5l7chjBy38bQJGABfv/
         v3CUhX07HYMbbXK3zRu6BG7WOx1JaxgXdmf3SxgE0vReyBss/3rUkAhHDH4g2eZ/AWFv
         brpSLgTkWV2JG+sB1ZKXcRrF+TT73o5QWZIckVNj1RajS582pLlICTfZb6H17C/0Pd/A
         E+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621689; x=1742226489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Qki/M6cF25Z9mXICuii0r2Qp6u8hLmIzSqDO0dJFc=;
        b=sHC33i9GkEOICfcYxB33E3uLqar4a1RgPKm2FUOwzkUrxfF3aKCRpkkV4V8j+um38l
         xaU0PgC5LyCr1bXg4JwmEpXQGDbzm0/CGu3udBB3nrrYhHWGyN64Gn4TenK5rSCdK8Q/
         yUzkxkBYeQAeMZzGoI5ZngHHzoZJM64t6sMMkDmVSuMl/c/Lqp+jBA2KQMEd7vsBwqNr
         Umi17cvUThF+NmEgh/pWPHle213B1EQgjd+RpesLMAKKFXGGHp1cYHl7UH/RFb7hOc1N
         TBCM0jeEAe7KImoTR/WpgPl9bhFJk3tcj/CdMfAS16fAZvnWlZw0zSxCbqrryPX/f32f
         fnYg==
X-Forwarded-Encrypted: i=1; AJvYcCUEO5HigeX+YfvH3VrEcVXmOiOM/vXLGxOEjNnsABHs/Gw4MH11QETYSAaommRvsBWJc2AgikT4PHL+amXv@vger.kernel.org, AJvYcCXECFzgyn21tNbrOL9J3eyiKlgislPFW5XIBCiXV95F3eZ1/F4ixgzdbUbxopQHTSt6fDEwVYS6gPUY@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuG5ksAz39fnFyQxfY7VGNClErTycC10km7NuQgr0xigThMtU
	u1C1CK0VTe4nPpTvUAWo01x2GxEIHglWJs0DiOyHRXq/ynQaV7hs
X-Gm-Gg: ASbGnctMe/LSxnMDH9rsvef8585quSQNgi9MRLKGgc1IXp5EMuc/ZsvE+GIYTTX2F4D
	TX2Rzi+iZqJG30SLR+O7WE8thAvnC2IvrpG/+ljRgTRf8KlGlOe5kYYy9s9RVC1M16Wj4TxNDVn
	G1Rc5XyHSbz49bDJT/3Gv7aEV8IsrQSztSmZERCqVvKujIcUB1KVmQOy0KXdIsfMp+Zu1AHsAVf
	6gyNNN7QbXeLQ/NH86Dw8m7TbrsmDIJvZ3XjHgOdFn6HYZ04zVli41fqrVwyKqTT52h7PNHoDcz
	6NNqLu02qdAI3xjVQQzEz9i5jltX0EJx1TSpAqRnN0vrvqXV
X-Google-Smtp-Source: AGHT+IEdg7fwP49o1tXyXWKqfxK/eu1a7dIocwJZ5jiVtXvBnrVoYPaIUXHxtiURUXgbSYhcfA+iyA==
X-Received: by 2002:a05:6402:2550:b0:5e1:8604:9a2d with SMTP id 4fb4d7f45d1cf-5e5e229949amr16131275a12.4.1741621689100;
        Mon, 10 Mar 2025 08:48:09 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766d0e0sm7252732a12.64.2025.03.10.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:48:08 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Ultratronik
Date: Mon, 10 Mar 2025 16:47:58 +0100
Message-ID: <20250310154804.326943-2-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310154804.326943-1-goran.radni@gmail.com>
References: <20250310154804.326943-1-goran.radni@gmail.com>
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

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..563d319fb73e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1599,6 +1599,8 @@ patternProperties:
     description: U.S. Robotics Corporation
   "^utoo,.*":
     description: Aigo Digital Technology Co., Ltd.
+  "^ux,.*":
+    description: Ultratronik GmbH
   "^v3,.*":
     description: V3 Semiconductor
   "^vaisala,.*":
-- 
2.43.0


