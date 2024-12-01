Return-Path: <linux-kernel+bounces-426657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4229DF653
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30952B21749
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB61D6DBF;
	Sun,  1 Dec 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy0zUOlm"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9441D5ADC;
	Sun,  1 Dec 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068846; cv=none; b=YEfgSTXTMW54nR8mVTCXeiVop83MdDj3Qgkm9ZlONH/hxskIot16fdZmPIj40tjkde5y3KAjE4kUjr3CueAQYPDLHcUaHAcbgHIITpS0J0u0aNWcP37790yyu7jkLBbhV44wYuoS9BQsM9gIsfvwY8xoOoxNJP+91Vnx2BRsZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068846; c=relaxed/simple;
	bh=GLduTRh+mc8PcL0g7Ssi4bKecwo5Rok5jKtZiwlOm8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7PlfrQQ4Ix2StjVC+8sS+N4dKNdhvM286B9yA0ihA5TpU6quSgeRofO13xU3Az0VBQoTHxuw3J4erIIQA4sNsLxQHJNYp4UmXycmQkmLXk52cac1p5FBLWBO8ZIEr6XrxwBQUQ5BbdYJLx632NajpA4tNWwDdVqTQtU7pTddc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy0zUOlm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso2229369a12.2;
        Sun, 01 Dec 2024 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068844; x=1733673644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa5SS8TIm70D96W83i/T8FBfkF8phya3zla9FCJAKVY=;
        b=fy0zUOlmfi3A1l3LbPlKHCTGO98JTbqTBt8RiJCF++QH+/AroIa8oqOWYEWoMsgP/i
         H7YyAr3DwRmeEXYuV/G68lhBQgoIPwGr+JWlEFBNJMZWT4BHZ9TnINgzQ8HOOQ9QgKTY
         Xttu3mNbEP2kzJl8BANfVjGu0DuB/Q6jHNfzZO0ICpkISYxJYagpWZM/FM3Z6LPfcP9s
         s4kiAfNxSFil8iS8en7Qo7ok3Mvmy+F5prRPDqqoBeotomNev44I2wZ9QVOPXe+k1scJ
         XLns/eroBKgyNMYUNiQh09ZRQVjExxoHsW/JeyGAMj99DcFqCtF09QF3VGI+CfRHbBlc
         OYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068844; x=1733673644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa5SS8TIm70D96W83i/T8FBfkF8phya3zla9FCJAKVY=;
        b=F4tOie3jxSoi6dC00wOUql1z9GFBZ8+nhYPcuZyr7WqS6NTqNEegbrD/vuXbdhrVhS
         2Xt7NcaRmFq9Mzpi+bad6Srh8UC6YLBaH7jAxDBL+JaTpA14GY01CdCNSWseHYiGawa0
         FqEvjbVjW28JCeOjAK1CdOxcOE4hHVmMQoz88I8nSBhUj/x4kcLWlNuEdU2TQqRJmBOc
         gi0xSvI5bQmWriEqr5H/9B5s2kor82Eq/lTU4sx+BUaeYOwG352DNmmXXAOVxUAuCLcb
         VgtupCU8ECPJDyCvyzsFcBd3p3abUiI2443Z7513NMwOcsCEsEAyKU9ZpQIVW9jG/6IX
         lr1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjPYDouq5Y9mht6u0NMmZouLNAGuOsMcPQz1JSlQwcP58Ll32L+P2yLKADu4prCQLz3hJmdXhtNPnX@vger.kernel.org, AJvYcCVqWmclHG9/pHCEoSi2bWzp28kDwW2gw9h1KSucgoyElqdC6IYrErN0hJofX7p20lBnIYKoy4g912KMoUQh@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrT4wk4sgG0bA+mycLq4mJWl7ve7CA6kkJW51evC0GWnxfTu8
	ls4hCrLOzQtXTLvQlYWO01YTWLzplZYjQvwYU70TIQJ7Ex/XyTjZ
X-Gm-Gg: ASbGncuQC7+tf7bOpio56u5IK/C1I5IrwU9Cdnbd/SmQHiBM07PpqP7ogmS3AEiPqRt
	IzJzT+LdrtAyaD8lPcY3MpOlcdW/umTBWlWTYy5muMm2SBf/J1AYaVYTn1oGxmVzMNJnRr76ihE
	5vCz5Kxwg8aXc/MXI5k5DbuLuawVMqnDSAsY3P7pCyr5VZSCtqyZHfYUglIQ+TJ4ZPu98BbTXlr
	uPGFjfz+hNquw53ZEPVfaTZJC8XZ6iqa3JoXtqWMnqW9g1dsbc3FQ9gUuWqUwObRw==
X-Google-Smtp-Source: AGHT+IE67IoMhdkZhbCqGTTlL81j+rymuRthOI6+qz6dw9AZsphEAOs24hWrEsa0WM735TWFubxf5A==
X-Received: by 2002:a17:90b:1dc1:b0:2ee:d186:fe48 with SMTP id 98e67ed59e1d1-2eed1871fc8mr15046a91.28.1733068844164;
        Sun, 01 Dec 2024 08:00:44 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:00:43 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Sun,  1 Dec 2024 23:56:38 +0800
Message-ID: <20241201155820.29259-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201155820.29259-1-towinchenmi@gmail.com>
References: <20241201155820.29259-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 673277a7a224..5001f4d5a0dc 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -22,6 +22,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr
+          - apple,t7000-pmgr
+          - apple,s8000-pmgr
+          - apple,t8010-pmgr
+          - apple,t8015-pmgr
           - apple,t8103-pmgr
           - apple,t8112-pmgr
           - apple,t6000-pmgr
-- 
2.47.1


