Return-Path: <linux-kernel+bounces-216247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD4909D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83A7B20AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289F187351;
	Sun, 16 Jun 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki8XOTY4"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926321E867;
	Sun, 16 Jun 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718536416; cv=none; b=KFlwEZUO78GYpYGfvge1VqYBbcYSMAkOjhTf621nfcH9PZBSkkHjs1kL+WcNyUK/ahGR2jE/OrVkzyIJJDnb0o/z18KeAwlOo4CK2+QfW5OFLWGb1+eBIai5FTddUjc/F0fkz1gX77XWLoOmeJgfdQR/y51GZ39saHqxEYWM3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718536416; c=relaxed/simple;
	bh=5Qe22a/rXnwgANrtomn4MOl7ZqJKAGbvletrgh/L8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a0AXfZxb5Vv3GXQLa2DwOIa5b3r9F+y8qY4SHqe3gxLO2q2Mi/4rfOxqMhxP4gwMKYTGXI5YC2R1/flxAPf6vRvc1LFAHZ0eIq3AwM3bN81FFFm+quUt2ppDtgjhXvME65s6Y+h1B8n7nJBEJBb5xNsy86QxSHBvf+bjAYO3vTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki8XOTY4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so4163587a12.0;
        Sun, 16 Jun 2024 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718536413; x=1719141213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlVnCg4+HXPsRalS2DKf0R5L2DbSMtI+mYeqbnqSO/E=;
        b=ki8XOTY47ztjcuZO9C2Abrm6xneWEeoJO3VVZekOw51cY82ewk8aDXnoZhaQccaAzo
         vXceeuQ4iY4ENqeJJKbTNybcoEAGwDCzO4yecx9C5gG/CFeedCRyFlCW+/sYnuxoo1WZ
         zyumBi/kWQAUaqBfeW5ZiS9oKW6PGQ+pyos7kK71YiZuX4ZPU8ueFWe3P2VRL6P0Xjp7
         FeVA5LUGWN+yj22xh4O9bYA3JHOBtA/V9WjVzBVAEjryWdCa8OjqmE4Sy4PvSvJAsfHq
         1Vm0aQvSjKr3slbvPhgeWYnjPRO8vp10bsk4CKE5tPfrAtWKF26AjjkrKcM1JR3iw3IE
         koGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718536413; x=1719141213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlVnCg4+HXPsRalS2DKf0R5L2DbSMtI+mYeqbnqSO/E=;
        b=dcMpdp1p3ES5vxluIrLX7JsmXYaOUlYdPOHeugudbAWQk8vTdoS4r2G5Hyn00bCrTA
         OVPyK/gZo9Cq8olaAtyKUuN5DGYdCA+5ZwoPGh708FJtu/NDGyCv6qbNiw6XYqTKHeGa
         /9wT/+qAcjkaWbLf7LCE0Kmh8IEgAGxapA8Rp1Vy5sA5h80kf3wB8h/VMrEhNdGv/+jf
         aCx3qKDwnLWTJ5iVIOv2Ks30/k4J92hK6ew/AFD5giyqSQTvur2LUka098A+7GrDq+3h
         TJL67Vh7rFGVifm67M3tWS6JL8feNRTuzUsjoZNKeOxROKpOTehTFEcusV2DyXK89Aqw
         FhHg==
X-Forwarded-Encrypted: i=1; AJvYcCVno98CxqJgrd9Uz573enkt0uVF0TTVR3IdmO4t7Ul5+zdwumiAK7iKuRQV89SXlDtEPpxqA8NZHahBjanucKTviiU0JqVO4ipSqCcPgSejaod446Hh8zAj5jBOXIU3/nTJpy5sTvy5ADTisq/BsXMO6f8tGz+vZdv4+WQkgcXhQcEvhQ==
X-Gm-Message-State: AOJu0YyQsQLCYCcuAxi08QVErr6j1Ac8+plqku09srPADGMM387G4epF
	5PSl5Lfg/qvEtU52sanXZ6JqrutIjJD2OCrzMzyxzbupkdq+/3WB
X-Google-Smtp-Source: AGHT+IGecZLkBaThfkqSL3QBnjraLowY/PCR45MvfrrAabtuQGmkj/cKCxg7OWyIiRbWH3JHOVE+Fw==
X-Received: by 2002:a17:906:c005:b0:a6f:1fc0:3fc0 with SMTP id a640c23a62f3a-a6f60cefeaamr513546266b.6.1718536412509;
        Sun, 16 Jun 2024 04:13:32 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3385sm394930266b.24.2024.06.16.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 04:13:32 -0700 (PDT)
Date: Sun, 16 Jun 2024 13:13:29 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: drop obsolete stericsson,abx500.txt
Message-ID: <Zm7I2Zbq1JNPoEJp@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These bindings are already (better) described in mfd/stericsson,ab8500.yaml,
drop these now obsolete bindings.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/clock/stericsson,abx500.txt      | 20 -------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/stericsson,abx500.txt

diff --git a/Documentation/devicetree/bindings/clock/stericsson,abx500.txt b/Documentation/devicetree/bindings/clock/stericsson,abx500.txt
deleted file mode 100644
index dbaa886b223e..000000000000
--- a/Documentation/devicetree/bindings/clock/stericsson,abx500.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Clock bindings for ST-Ericsson ABx500 clocks
-
-Required properties :
-- compatible : shall contain the following:
-  "stericsson,ab8500-clk"
-- #clock-cells should be <1>
-
-The ABx500 clocks need to be placed as a subnode of an AB8500
-device node, see mfd/ab8500.txt
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/ste-ab8500.h header and can be used in device
-tree sources.
-
-Example:
-
-clock-controller {
-	compatible = "stericsson,ab8500-clk";
-	#clock-cells = <1>;
-};
-- 
2.34.1


