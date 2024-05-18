Return-Path: <linux-kernel+bounces-182952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6068C922C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F68CB21790
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD406CDAC;
	Sat, 18 May 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1ucqdLn"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC66A8A3
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716062856; cv=none; b=o3IrmwBYAUPNcn/GKfC4uhoFrurkvHx0Y3yPBUjpEMh1xQVhbrNPZQ9pj+ulaj+EAAf+Gl5DgUw0269+4GpCrvW+PrqZdQtqlFPeViSOEXcki65JKLeyITWGIu3P2mbIlcSP2H9jVNb3DIYcBdZbAij91oCes4OeJOSXZOJeOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716062856; c=relaxed/simple;
	bh=hNz1n7doUQDa2gnviukj7uX76N/6azWycr+wpcMBXiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxruwBV1CdUNP/6DU4ZIRi7bHWiYd6HcTSoBcJpOVMT4KS+1Lg8iIjpiXDF4WggVSqsvZM7KZPxdkcFrW0EevmrQls87AKsO3qhlbOaJ3Zif0Szq+oGtFigThbfC2ZmdOaQCuyIwxMBNHYWZ6/9uYbgOqV5+oDuPi7XJ3kcejo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1ucqdLn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so6173053a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716062853; x=1716667653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6sRNb1yEf5vNz5YzsNae8SVBllCt3VFapFt6/g3Jck=;
        b=q1ucqdLnl39rc1hGFqzYCv6Hjrktb1shj/6TH4JSQTA4GnIpSa1ENGc2YQQP6coQW6
         SUfJqSw04+kWEKJkCjKVo8MaCN2JkpLo09u6YShuQgAESf1Ut32psuXYPshsKhbmD7d3
         rwlQH1z6SFyy7nGC3RjVd6LwaZuNjcT6YsQ69ic+UDfSRzcexyYDq4qCExdcni3QUd+B
         EGmP/PKxOTiW7eC7XP2HED6ZHOpzXVMFuh7N6pC/4xVrDxPeMFgPq4Eb+Jxe3OzaDkJT
         c5DWpSEdOkQV7xArgrLTOywZW91eBMrCcIA24mcneHiCVt/goxKDeqRziJ3Ua50fEOcV
         ujqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716062853; x=1716667653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6sRNb1yEf5vNz5YzsNae8SVBllCt3VFapFt6/g3Jck=;
        b=tEvpAyQL11jRijK1KZIrpgxf5nJ3WZhr0ozpbbsxa1+QJcLqVKMzswpkabserzbrvp
         wgYPKEkO/HUJiRMUYco665JkaU9OApKRKThkjluc4IRY1Dh634t+9gTaicuuNH9scJrz
         KbmOfV8cZI1NZIgxxHaw6GfV0be1lJKMsyN0MIoF1O8mAot2GyAwILjJx8sy1XKacFQA
         LHxaJ1WzrHcWpJnAIIkLTCYVFETmtejyhuccBzRK72DxuvAtkKI8ksQNE64DdGm3ggy7
         8zwPrFRGtziUG7Cq6DeJ0mDl3Sqk64yQmDUWSF3BCf1soh5GDDe3jIBXJf+y0cxlzxf+
         XM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYeWpbtHRjuTqzNPC5jqhbQ0Rgu99byqeGjQ39eoBtC+vBgUIC/wFZ5av44KTavQmbwuXcrfuoKVBlal0IC54wGNxKQYdhxNxEqX0r
X-Gm-Message-State: AOJu0Yxzs/8Nc9FpmjTEu/c+cd9ElWEDV2eO/lCP7m6ZAR44fcC6WRSk
	1s/KnXmaGwhC5qFquuiWwxfbffo/yp3OnfeTRlrRQ01At0/WJn1w+oRR0PA7PV4=
X-Google-Smtp-Source: AGHT+IFnknZj5UpApTZ/MDEr1PXR3EqvP2yIG6UqIBcNWsxdbGJ86TqcFkQF+RVf5gDuY22ECRk9ww==
X-Received: by 2002:a17:907:9c04:b0:a5d:edb:6d60 with SMTP id a640c23a62f3a-a5d0edb7992mr369010966b.19.1716062852568;
        Sat, 18 May 2024 13:07:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177desm1248364566b.207.2024.05.18.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:07:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 18 May 2024 22:07:19 +0200
Subject: [PATCH 4/5] arm64: dts: ti: k3-am65-mcu: add dedicated wakeup
 controller compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-dt-bindings-ti-soc-mfd-v1-4-b3952f104c9a@linaro.org>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hNz1n7doUQDa2gnviukj7uX76N/6azWycr+wpcMBXiQ=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGZJCnvI1zKo9nYJ41eot7hG97NsZ2wQu0B26jx+pMZitp3gl
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmSQp7AAoJEME3ZuaGi4PXbCoP/RZg
 ow7PNeZMz0qiFUQKohCrR44TWISQMMQFLQkWgjV5bwvXIJCk6g8PIsaOWQ3uOgKNrlQrG3FMrZl
 2nXWjCr8p3YpJOtdc4ClvkqNN7zWMteYu9Krs2oyB76muHDbYJx8nolrgenmhY+GmISxJ3xtZmJ
 rkAcwzcP0hzMXThFmWoMWrFIbEnm3/Qw/evAYbGk9xTpXb8yAZuVvKPJcLUTWBLtH+6T70nUBWB
 9MYIpr6UEsksFbbWdUcr6x+991kl7LN0pcjre+DZVfHp7DYcmj0qchewNd7BgupJGM0r12ql/k5
 D1pUcLGC+NFYI17xLr4TI/TumxL/sAw8l3bBfzNCHFgaAQbuNhFaRi3yqru1MrG9diQAKrxULpB
 UHtaFbB7NLCgSHjz4Ve57eEzRcplX1pq2ezPjOngG1cggkEuZONM82dEbf1lK7kPfADA2/I/dO6
 HCGjpNQRXVvJnlawf6YDEPuxptnuz03ceF7IP6Q+vWhf2jwTGh0z4RZXrO4J0+XVyEo0b0m2eZQ
 X4ikeQOAKn4XC0iHIO8kNUF9+Iy2UOt0UWpoWQUa2c7XweXeDWfQowEX+vpYlvuuVUr/TdKlPba
 SM8tsUFCSUvDnh/p+d3ATrrTPGUXK0ZdpwubhKMSlcGBajx28ZHha3FFtV0VX64o8Z3Cd4KTCTL
 DrEtQ
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each syscon node must come with a dedicated/specific compatible, which
is also reported by dtbs_check:

  k3-am654-base-board.dtb: scm-conf@40f00000: compatible: ['syscon', 'simple-mfd'] is too short

Add one for the TI K3 AM654 MCU wakeup system controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8feab9317644..3a61ea728645 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -7,7 +7,7 @@
 
 &cbass_mcu {
 	mcu_conf: scm-conf@40f00000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
 		reg = <0x0 0x40f00000 0x0 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;

-- 
2.43.0


