Return-Path: <linux-kernel+bounces-224783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9829126D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F01F26BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE91D55D;
	Fri, 21 Jun 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N52giz2I"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D5AD5E;
	Fri, 21 Jun 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977237; cv=none; b=RJpBAEyt+hiJU/TPR94d9PtXjvOszYu4x8gd3t14SHfAQaHpgDHZX02pfPGAty5bQJa8GiU90tlIcBEiYyGMZy7DjlTEaTuCpokEvxKywYOyTdzaEyBSCapQSvYvUBRJ8m8AZPK0aCGsHJ0oEjyNouW5AbuKwV3pNGXZQIuze8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977237; c=relaxed/simple;
	bh=a+LEDBAcGPRQc9HdefR+wXa1Z1kDFt1mEhDow/VGUtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQQ+srbctatRPugmbgVEw2SS2oN5yU6CZ54Ya7zu2lqJS+XR9uOT+dj2aOGqJ+oror+/pFJtV9EgnABU1+X3W1ol5bzPlZyRjhXVyADarbr4y+I4Ozf/9ATWtthVZx+8vt320aCxsfVUZFuxnsfLeOWxE7ZmA3zugKwCTTvUfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N52giz2I; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so234896a12.1;
        Fri, 21 Jun 2024 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977234; x=1719582034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqehWUTmu3KjLNagitC6UR6pJsfsCjXz84AP8y4+Sso=;
        b=N52giz2IoXeZLapcdU/UPq1us1WAM09tetLMTTxCSGVeUm5QqaA331dkP3EDSkBIce
         TBxVV21SfybrG3ZCJF61GY02NbiLrLx/KrOWYVYk831gzadqoq2rItnhug8RNV63W4hw
         aHkvVF+HLa9XBkPTuF65A0JbZfvXk6EE/uACz0zkAydp45SY0gbvVsyEqwC1b1SAnXe+
         tpADjMvBsPU7qfxj3LYChnYC8CQ1ev+xqaEmmnHMMdhKIfT/SLki/Tn5d/TXdsczJQL1
         Es0urvt6WHtgWX4rdV84NEvdho657PVcVWJd5ZqIS04ZllR53llNrHoX42wWwIWuenc4
         /5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977234; x=1719582034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqehWUTmu3KjLNagitC6UR6pJsfsCjXz84AP8y4+Sso=;
        b=PTsIv4lB3nzuftwqqrr4G+i/OMQuHp5K83O57ASg4WVfGQ3aSOC1cV/9TOtDfjRrQ4
         nK1KXQXvqvxgc3mZY6sQltxIc2vIeoPHJVyCO5qAC0F1EtuKosIa21U0aOFIBJI+liw/
         jE6458W4L9YRT1CTKSQTrcBnYBwuU8hedykcIxE1ehOvYGM3koZtrPzMeIMNboF6jWUW
         22s1BfnqmYsZoCoZIrGM+EQIdx6WVjdIn+xyISWkxrGtRHVTJ02H+f8GUD5thMbyu+JJ
         QrcdqbWTsnVySSGIGucAln14TOZHnYv+CdlQYWWxFjbItZNl9oyNwWXu28W1wgrWi67H
         YEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0McaKBLv19yoBwGHttlxDX67l2V7rNPIiqCh1M+YwsHNZELtSo7frtVAkNyPhtXgMRR0yZVufKIVWet/sjKMv4M+bIx6vDYo1VMMa
X-Gm-Message-State: AOJu0Yxp9bUi5VLqBMfcyqLUqdjzvKAR945usjH8llQwnxXm1gVJheI4
	VWggJd6udMS3gYn/RzAqfvkdUHT2nnL2CJQX8J8H8wXykK9mYXk=
X-Google-Smtp-Source: AGHT+IFg7b3CmvswvXCyJGll1GEkVNz807LHUdzUIlvKzLOCJJL2/LsIJvxs0/pWzX7L/J8BkMbZpQ==
X-Received: by 2002:a05:6402:1a45:b0:57c:ff0d:b781 with SMTP id 4fb4d7f45d1cf-57cff0db78dmr6851849a12.16.1718977233583;
        Fri, 21 Jun 2024 06:40:33 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1b6a:5399:9a4f:7217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cb6sm962059a12.83.2024.06.21.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:40:33 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Neardi Technology
Date: Fri, 21 Jun 2024 15:40:27 +0200
Message-ID: <20240621134030.243646-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621134030.243646-1-knaerzche@gmail.com>
References: <20240621134030.243646-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Shanghai Neardi Technology Co., Ltd.
(http://neardi.com/)

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..6e879abec71d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -995,6 +995,8 @@ patternProperties:
     description: MYIR Tech Limited
   "^national,.*":
     description: National Semiconductor
+  "^neardi,.*":
+    description: Shanghai Neardi Technology Co., Ltd.
   "^nec,.*":
     description: NEC LCD Technologies, Ltd.
   "^neonode,.*":
-- 
2.45.2


