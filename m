Return-Path: <linux-kernel+bounces-386132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E339B3F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B81A1F22EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188CAB664;
	Tue, 29 Oct 2024 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaTqBny3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACB4EB51;
	Tue, 29 Oct 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163984; cv=none; b=K/YaY3Az+vVw+wbcOEeskH4n7SooMcrFpUNrlClG2OYlbv606oJ+awIz7pOwgeBIHHCJJ6Bh/hUhHj+kdET8LqX3HMZZ30edQd7MXolpHgZNAJvZ/nmbP9u5YEU4B+pom+52Sho81OsMcD319nFijDvpBSXQcMDg+xJ6/toH7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163984; c=relaxed/simple;
	bh=BtS5sZwERe0fvOyFzUSqVS+BDMGGGQIidKnRLUXm0kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGZWahTr3svrfrSRN3w7QD7q9Qu5Yn5kZOYsqK3QIFPk08BMictXQFF6pcPtdSoXK9DpuAcETNbvNiVAmV3qF6phLbdjqfAspil9rQsd2/DRwbAT7nnxWFo0KHHlJMf6JkJUhFR0hw0eBWbXWaetAacMajb8OQZWWzkz0oSNaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaTqBny3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-210e5369b7dso10764395ad.3;
        Mon, 28 Oct 2024 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163982; x=1730768782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOQqsdvD2kJ7hOf0gc7nGs2u4WOLnq6mE1rYCDpzVcA=;
        b=FaTqBny3LNzwh/lkz40rNxVfaocz2nIoEbN2Z/gwiVbEJybPI1iz4NKRVaBztZPpwR
         1rg77NyOJLtgSSS+RVeBxJLEq8ntYrn53o43k7apwm++cN0t1wwH4kGTZzC8yteYOCZZ
         a94IIfJJ1chT+VWZkcK+NDMdM8KK3yz/8hWdQtQdHwd732ojZ1PzhqsFZSSvIOxOQj90
         Y1l0PZukvQptTLuKYAPHigc5yPG1BfB5pB+dfnIl+7/RCgwCyhcGYV/RmmO3bPDGQNc4
         zitNKBPEgUUppmu785Ja7j1ZAZEp0EeRMd3OkewMsVBCiT5EE9POUolg1qj+Vc8heFCc
         Fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163982; x=1730768782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOQqsdvD2kJ7hOf0gc7nGs2u4WOLnq6mE1rYCDpzVcA=;
        b=s/fY1f4F3kJGQf17EGzHMNTCRbudergH2BjORoRVxnAPNAhUXVEgARDANX9pSqJm+Q
         wtrx37pGuUYXEStDXcZavJvx155ECs1yALqmLfDZpaEPThbSCtttzHshGIsldI0oTQCw
         Qx3aCUcLg2eXXIrqTGisPTeEtWFsd4HHfm/Y3+TjqmHv5k20k9TXuCqzjW0MtacC6r79
         ycdfUCaDviYid2vkDzejkcretu1ruxg5nTecwB2hw22XCRA7IAzkrbQq2gGWVFEPNmFZ
         ngUpIhxnw0shf9N3QK2hKHUeEbBs2xLRjWOC9Xi6R47EIbBpXlP+YDUqAQZyrQ2053HM
         AIBg==
X-Forwarded-Encrypted: i=1; AJvYcCXEngGbfEX9FfFcuC4EAIaD+mbOIzmIDn3NO+RoilXOvLhGkgt9eZf/CABClgUlAauOhJdRAd0KBwA3@vger.kernel.org, AJvYcCXGNelH+fpgYsfJjjz9I+Xch5atgWhNCALV523Io2nmbED4xaS976ac8YLtOT7Wqo/HhpOHalUcyzHKUkac@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4hLabQEOe/zyzc70VzE5JT7OskzmSI8kJz+Qfd5IUuXJe8MW
	Mei3WQg3uRfGjc8Z8YS2oB+W6WlP3pU2x+fmaL2VpXPYogApqbXk
X-Google-Smtp-Source: AGHT+IGfIbiEp9AgPkAzQyYf5y8q1xHXZI40WLf5p9E21EcZOo7Qi3kg+2a0UWsBAQAR0nqjBem1Qw==
X-Received: by 2002:a17:902:e552:b0:20c:853a:52a7 with SMTP id d9443c01a7336-210c6c31d52mr143089975ad.36.1730163982006;
        Mon, 28 Oct 2024 18:06:22 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bc02efb1sm56306225ad.221.2024.10.28.18.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:06:21 -0700 (PDT)
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
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH asahi-soc/dt 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Tue, 29 Oct 2024 09:04:00 +0800
Message-ID: <20241029010526.42052-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029010526.42052-1-towinchenmi@gmail.com>
References: <20241029010526.42052-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatible.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 59a6af735a21..6e9a670eaf56 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -31,6 +31,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr-pwrstate
+          - apple,t7000-pmgr-pwrstate
+          - apple,s8000-pmgr-pwrstate
+          - apple,t8010-pmgr-pwrstate
+          - apple,t8015-pmgr-pwrstate
           - apple,t8103-pmgr-pwrstate
           - apple,t8112-pmgr-pwrstate
           - apple,t6000-pmgr-pwrstate
-- 
2.47.0


