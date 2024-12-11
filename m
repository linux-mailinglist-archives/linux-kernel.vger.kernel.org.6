Return-Path: <linux-kernel+bounces-441208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17099ECB16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2607D1883901
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76743237FE1;
	Wed, 11 Dec 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXxLh6Fx"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BA237FE2;
	Wed, 11 Dec 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916212; cv=none; b=Sk+YjmY6ub0z0eZ0zysDyd8knSFCrUuFkVLujBK4V2ELylP5wmH67AZIFx+dlLQ9BVugKNqv5txDil9lulY3yhotHh/ldSziRqnCWiWZqfqAaVgkeO1+7hHnpyUYCx70ecVqEYkEYnAH8fRcJ13COHcxtSAguaLONG6+vkjkt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916212; c=relaxed/simple;
	bh=1vNipIX32Wwi3oGAVLnp+7uIJ7IUL27kn1rJRFlsJds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECdCCQnPvH1fNdGtpBYzvWmjz+I+iMczTqglbyLPbe9pylTR+CD3VnoQoYgi/srGgZ//FcNoU5pSz7wZ4fdR9n7963H3ZnYe9rT/nHybbiIYSkIGF6JRi8E6q2pSTHRcflyLPfhFYSHV5qBkp/WSMw162pvGe6eKUWQN9Kh372E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXxLh6Fx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso4003969f8f.0;
        Wed, 11 Dec 2024 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916209; x=1734521009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQWOc7h4gW6hbxejH92pHeAPkqe+egzJ4Bg+pNFuODg=;
        b=UXxLh6FxCa92Qwafr3DW2JBCvoxkej3bAaleTinqM3oyFzyElctygbQuOSYa89FYE3
         YfJJAuu9JlB1VSn+i/Jwc8dljWUewlOvUjNeBEYzGr1IiYanu2iW6Fs0R+gk8Ch8K3wi
         jaSJbAotv270LDyWc5BQScCpAcPEMNHFJmrQ7qH1N+8crG8O/ZklnmIDW/OrMc5k73rA
         w2tXprwnpe5zd7+DCIdinZtKZjoUkId2jvfLqaEB1i/m/s2XeDtZiVLj2phqXI+aEE6M
         5cw8Tq2kAgyD7gqCoCGqiICRYHYh6zV8G/AUFJ3MsU0ZQeBRkj/UhzIDmKCPYw60+2er
         1dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916209; x=1734521009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQWOc7h4gW6hbxejH92pHeAPkqe+egzJ4Bg+pNFuODg=;
        b=ZtG9xFS6vvWbpHI70UHR4aLo9+3ObNpz0H5Tzq7ydACSdpWHaGzWIfO9YRPHbBGOeZ
         W+rAfFxjcAdM/b+3bxzd5Jac6GXEW0Hvw0VFv9WKVcs2WvHEsRugr9rSDxkY4wIavkIn
         5DpEoH8hVo+pmPspBdOUPCCoYy98pwlTj/8x5Bgs7pp/sO4XeGdbVagGczUnGQkxoSeg
         wiVdH5cwtLzHuJDzFmoGHbEgpgGA27bnPdTRj6IcoPq+4cSZKRXvH6XyXFyuwlGjbeRl
         pRm6gNV2m6Nb3zhMVqdcTNjyuFv799hqhbzDTlToB0+CTskstus8dC+ch9KaxizpfGPI
         LDkg==
X-Forwarded-Encrypted: i=1; AJvYcCWAiPB2Z4PfaAJKya4sjF0KsamtxeXdnGmuKbnYFhHr4FYg1XYJ/jO2cphFx/tJrMxXxoZe/ljKA3tFFvEj@vger.kernel.org, AJvYcCWRA1sptFofUc2Hj3lRfmvKoXci1ma3j0LLWFbpfKO6uloplaRyLil4IVR1IW+ZA6JzqCfvJhFHlkvi@vger.kernel.org, AJvYcCXZ0pS+flhWO3ZqKJHVuIYEWyyJi3IjkYo2SAmjxe4pfHZilpGAdBtHSbrjwKcRwrMta4wYFqDM6Kj9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78ldJg14G4C/6QQN3uUKcQFJ5ymFn3wCHhHZ1/A46+8tnBzh2
	nbQghk6crCzvbwYC+zUEiWWBSicz/1lQ1XtJ95fUvY4TyEN7nujV
X-Gm-Gg: ASbGncsSG/s5aQQ4II5EYnyd2ZEvj94dvFkR9yBxoQETIXhFPcakqpab04IRaXWxaJH
	28wBhfDyYoY+ABKqoadrcM4oZz3RP6Bs3PgNGD3iA5AKpLq1xMnvRjTxR35f6c6z3282vhs+5lp
	29lZLNa8iibeAZC3ebkzNWYLRqyOZmlB5U6cWxnKITiInwh6RjaBOV39X35RCF9VzbO/h0qweI6
	NqPEnCrnxqSFx1EhfvkNbuq+PkqCsAYdsF3C5/lQBblE63oSRBSjnfpC07CGYkG3dXLjSacg8ek
	8diVXcvTP3FbXuqBf/fOego=
X-Google-Smtp-Source: AGHT+IHGnqfRTMQSdBags7kgU/xojPL+4GphCNQsoxHctrDKfCP0pK1QPBW+fWeHB1D1DevDtDA4Gg==
X-Received: by 2002:a5d:598c:0:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-3864cea38edmr1959544f8f.27.1733916209273;
        Wed, 11 Dec 2024 03:23:29 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3878251dcdesm1041292f8f.104.2024.12.11.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:28 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] dt-bindings: clock: add ID for eMMC for EN7581
Date: Wed, 11 Dec 2024 12:22:37 +0100
Message-ID: <20241211112253.27905-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ID for eMMC for EN7581. This is to control clock selection of eMMC
between 200MHz and 150MHz.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/en7523-clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
index 717d23a5e5ae..78d16068228a 100644
--- a/include/dt-bindings/clock/en7523-clk.h
+++ b/include/dt-bindings/clock/en7523-clk.h
@@ -11,7 +11,8 @@
 #define EN7523_CLK_NPU		5
 #define EN7523_CLK_CRYPTO	6
 #define EN7523_CLK_PCIE		7
+#define EN7581_CLK_EMMC		8
 
-#define EN7523_NUM_CLOCKS	8
+#define EN7523_NUM_CLOCKS	9
 
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.45.2


