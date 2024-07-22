Return-Path: <linux-kernel+bounces-259102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF08939136
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84609B21707
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593C16DEC7;
	Mon, 22 Jul 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGCdzmiR"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7516DC3F;
	Mon, 22 Jul 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660475; cv=none; b=WIkderK+kwGlO8QYxD8kxyIXorI0ljon5rRpVQUhumtuZgkQ5IP/RLDasGdkdd9UAnPpiQ5BBJofjeXZsZkUaakpvmKr3WhgvGyq3OytcT71lISL6XRCL2oLp+gzuY0D9l7YnaX7vtIGUWbwfxX4/KYZN/u8jcVSFKhworDBDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660475; c=relaxed/simple;
	bh=r6rd09RCPRiDvYuM9ZnNjNcEHerqa/WcMkMnJ2T6YZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIW+cmIZs3KJvNWC8sA6XdX/fz3TEkc2l8WqF43dGTIhMgHtAy6bFIFSEuWfiH3OGIJTUFJET//T5fZM4Sk90ElC22iGNv6gcK0Knn0UY1FknzT/gukz0nz3ZQcNfIsvMBEiZ7/XT6OUcvU4VeV0qWNrPO2IvhbrIZgXRVj3i8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGCdzmiR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso3393125a12.1;
        Mon, 22 Jul 2024 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721660474; x=1722265274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEwnmZngztpGdhQKMQK8DcDKmkmbdjPxn0+u2l4YgUM=;
        b=mGCdzmiRhaOIaYziqGkqr5zRSZSS8dBTrrJ+vXFCUsfMhXdh7JP2huPcjExruljky9
         zkxM88qE6xl5osJ6EC7f4RbJ0P+XsNVAs31HxEbymISOnc+9474+5Cz3NozfoJLyo+Mr
         cZqgA91BkFmEiJAfaOQG4O30xLOcwKtvF/3GsLWSRIzczvtlwQi4hU1P8QMivl2UTtYb
         ugSMwWOe4VOD0hxS1kbAFCL6yrxD8NK5llFsbmy+uHC4abJSyQu7Qo5us3h0U07VUGkb
         e8DZafhUOc50c+iM+k43IYV4MbWEtX6c3hrIxtfLWh5QzqNglw5UbKI0+sKCBv0WxupF
         xu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660474; x=1722265274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEwnmZngztpGdhQKMQK8DcDKmkmbdjPxn0+u2l4YgUM=;
        b=BZlyQrz2Vxk6BuvOzr0voWX4yV3udTKRGEoav9nOzpvs7JFg+pVsP0ou5o9vJ72KQ+
         CSZJtufi36dMTXVqfrSpeL/uJAFfIwja6Qg9T2MiQ5ibvuk7hRboIttx/60KVCPwD8qd
         9ftzhJKPBh00feqZ1L9BtTb4IdMqqRCucr+Blf2HhJWijRhyo//CzphQ1ukxrU4c+1RU
         wghkmMeWtWcB7Mvf0bRnZ1Ltk9l3b8VBlcj6QDDJTvRhlaZSdz532NRhiOPNXJrY+IBO
         wlhnCTWtVXEjVZz9XpwmL46HKq5xAAKyyDCW7d46ykZ6jipyZHFM85XN22+GHi7etf74
         nxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJmBJHX+eK4yVI8lqubG0ijjU/9c9JVFS5r9v++cmdiaasNMQsAkLAMTFt6KMIybTzlP1Rtb5eYOr2nevdelHQAy5W12aCfarpWVu6P0Ma4lXF+pl0rVLEBBNlsbiR3B4MYbETlTW7w==
X-Gm-Message-State: AOJu0YxIOyaitgUChPODUC1vDwnBcmAPCW7nAO7DtwlwmzFTfd++Zmk3
	68tvULJr9Twk+h7FT0WPWZasIR2Kes68eziBABhMrybuIeR9silR
X-Google-Smtp-Source: AGHT+IEPSq62sELNfy1D4JuXZzDLEZiEmFw2jiPgiDdDhamzHk6c978zwSKVuzN/cUiMq24B5S66Og==
X-Received: by 2002:a17:90b:1012:b0:2c9:7fba:d895 with SMTP id 98e67ed59e1d1-2cd274e0263mr5394357a91.38.1721660473545;
        Mon, 22 Jul 2024 08:01:13 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77304a15sm8224207a91.19.2024.07.22.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:01:13 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>
Cc: Potin Lai <potin.lai@quantatw.com>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Date: Mon, 22 Jul 2024 22:58:56 +0800
Message-Id: <20240722145857.2131100-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Catalina.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e386d0ebfb14a..2f92b8ab08fa2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
+              - facebook,catalina-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
-- 
2.31.1


