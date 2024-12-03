Return-Path: <linux-kernel+bounces-428729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E309E12A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E228235F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB0166F25;
	Tue,  3 Dec 2024 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnVpow3s"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33218132A;
	Tue,  3 Dec 2024 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202442; cv=none; b=F5Qu/9LbmA/QEavPCZmFxh8+BWz7d/SGRju97Ym4AChqgw0Z3zjnk+A5TRNCmKMsVHXPlKI2tBaVhmgbjzTwJF3S1RRcq2/4hmFuAesFEwJPuVTqSwe/tjamUIq47tGhPwJvPn6RddH9z8uE0p3hU19QPQkYZA1H4LN9gcTkdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202442; c=relaxed/simple;
	bh=6pZiuvJaNtb/CqZdgPcO1kRdrv9vQuk8hv7BwCYOsp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMHqKbaIcxMy3+b3s5ZN1O58dn0aXqm7jbc9YxjvDphi9Ldro8VAEW8Q6MM/kBgba75iQ8C9P1+uv9A5u+zy6fhWC03dg/XKS1QpUznTrIMxS+MjbO4Yh+2VIGbQtVQW7XLf4+EO9FDaYa3gD2JRqlkvORMNOvnmwGhMH30xz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnVpow3s; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215c4000c20so798095ad.3;
        Mon, 02 Dec 2024 21:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202440; x=1733807240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hebD8ipCbzY7nEzua8g0Qgmxl+l/xC/PNKeirRiQP54=;
        b=WnVpow3s1zpKTYTEUNLCab8whKsRNceRw0eVm3xsUx6rjL6t8R9HptQmmoxpZmtZUh
         C9yAee4jLQG6IZPsfVMuk8H9lGbexy3LH1+EXLXsDy9SkYdLf3OIs3mvw0vGNGxjgXrM
         9AerOSR7k8RQKoLnqQfx1C9c3i3Zl0vmxnCphM+pp9rrmUR5T3CHS34TZI0JMPbJm3kt
         4ZlFOUdupCs/DfQOww5b+VCRl4/gXoOevaGLis6zqMlSheWXmjGgLo1OPPs6Ig4AbvXI
         USqx7jbaFRdreTU5mDXKPClkN9D+U+jn/9t3r4N5RIALwx1okyTdcGdMNfNN066XFlqz
         YOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202440; x=1733807240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hebD8ipCbzY7nEzua8g0Qgmxl+l/xC/PNKeirRiQP54=;
        b=pBrqnYek75087xvY1XT8HrkP1WOy3b3Y3gzcyf1LA5HUQaSYSo5gXU0DdmHmPEAO52
         oVr+J65ICIyxynt9IyzlBCoMfO/luF8X/GCOW80KMgb5vIjSflploLAOnqvym2e6DhGV
         W41zy8nDoeKyNhCmwpeAolewbRuVEbDgRor8XKJRb7hs/vaATq991mkANY5IMKXFKShI
         wieg0fL3iE/0YQOLeEXb9D/YJZinan+SJUyHL14Naa97d7pYj0MFgZxw+dKUiARHhQDO
         G8vA6hA0Dpo6Ujh0XmGwHeq3bvSQazCuI2WUtkIALifpRvuHMrFZUAeV/nnnEbY90Fgo
         tkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDaMePqATVF9jwXKtm7I6JXF69K1B5mvoMgh6H7yGsOYiNu1AbosAkswb7J6w7r1fRzRE3xhJRCeWPHfOF@vger.kernel.org, AJvYcCVeqahnWId4jYgy1/uvX0+axQgF7OskLCO2H8Mkj5vz/Jkeg/6tyqOiNNXWnacwcs1t1WgXSIhRE91+@vger.kernel.org
X-Gm-Message-State: AOJu0YzIW17cstfju6F+mC59bSkdIHJ6JehYdehRhn4sMLCl6MbJdCFD
	4o5CDH6T5ESAHqk8KkoAeQr7xejDJIGiw1Hbfpsyad15GhTOr6u0RzX1zg==
X-Gm-Gg: ASbGnculScYpPf9KrqgdoU8r4FxRTg/SYNauTxiZLORds7YluAYJG34OHChEk5miWFk
	8ijrXWSyQ2aZVPC5qdKVCs47XXF1c69OfyFFo0DKbjMlVZ7xWoGRCHnFkwG1P1FNYpg0RL+26LL
	2R4ek1vrYW5e19hxIjLBEsvCGT+DWhJyr6dAmkwE6HNF4EzOWoEQeQlOpaN97K7fIl2s2yVvXvK
	Cfz0EgRsapf6nSHMq+K9BuAPA2lPwZTnas3zuVUyK7FGwaO9JVbc+tMHgyhhedS+Q==
X-Google-Smtp-Source: AGHT+IE+mF4zZQlFW9cTU/rjqk1T1d7ncMfeh7ab/M52pAyOy802erj5Ky8I4VG6C2ix3C05Hk+qkQ==
X-Received: by 2002:a17:903:2344:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-215bd1b450amr12903395ad.5.1733202440414;
        Mon, 02 Dec 2024 21:07:20 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21586d40afasm33242385ad.270.2024.12.02.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:07:20 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH v5 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Tue,  3 Dec 2024 13:05:32 +0800
Message-ID: <20241203050640.109378-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203050640.109378-1-towinchenmi@gmail.com>
References: <20241203050640.109378-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Acked-by: Neal Gompa <neal@gompa.dev>
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
2.47.1


