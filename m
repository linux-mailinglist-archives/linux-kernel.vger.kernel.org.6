Return-Path: <linux-kernel+bounces-251654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9B9307BE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 00:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E238F2824E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B890158DD4;
	Sat, 13 Jul 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="T4i+RL37"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C146A6D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910124; cv=none; b=ToOlApTNyNPFe7opgnUY1sxfUANdoPt9N/p3EZop6bC0BxaZB98JrPdB4YrWH3DpsRRIV4ibpgNuf7GRWMgh0JaDvgrnePAkzhWcT/1oIuyMSlWebx72KGfKV3DWJII827KZY7KgowvMexU64+fPos0UrC1zDlhdPxlExmg8OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910124; c=relaxed/simple;
	bh=v53LsPjL4NbtXyTKg2jMCfMm9WLoShyCu0Vc0CFSrgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueO+gZ0wk3sCTeMA14tTd+faocr+2jTd4ypTNLz9IRCBMPbQy+v31LFqnKR+rVOyEVKcU72TV2p34QgQQuIRFG+cIFXGJ+6POosALwwwmoWFajuHF1iAVAzfkBY1OMpkvXAMaMOjjUJ106D1dRDQHfZtMwBC/C4v6iBgU0bM2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=T4i+RL37; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-380eb36f5ceso13207685ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720910122; x=1721514922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9djOW17Hq6Bkvn3DcF8Wpe8/RB5nd3f1kRECjv6cq8=;
        b=T4i+RL37YaqiPkPsV9qj5B6/CLcVoHp5YrkGWcemAN+l3jef0HpELAior7an8rsxPT
         TpQ7k28eZmtY2SmoSFfs4S0x2X2lr0tmVB24wwG2BO0Jqfuogzu6gou+Xufc+fSRT6FY
         am2Wx95thhGHJ3jbCFRr1PD3zPS7vN9PYvt/GRfvX81vozke5ke7mj4OvYQutN9vIayc
         JUkxLRsEELFnWNqLTHYla/Kou99lZQ+ACM0++cILxQ4dwM3jlJ8t2HauFoUJdcnho+QM
         k/wd0p5JREoXlBwDHagjoszzHL67NFKLltopTbynZdW/FyXoKrxchbXb8c5l7jNy0tg9
         Qu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720910122; x=1721514922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9djOW17Hq6Bkvn3DcF8Wpe8/RB5nd3f1kRECjv6cq8=;
        b=ZFjx+nFGQf3uy92Mam5P6P3clTZZeHCjbXAxXs7b2fGtoMKFSFl0On57tXNsO9VrMl
         UyOSY09pyeV13INwkI67tPf/W8Pragjz2Riv9H7RpLAaLAaVZV4HworWeJRI7c4f0J9L
         k8IlrB4FvjA6jFeLUtiOx6q54VanbDBHIZSiviVM937/IsyYyQTkD2lqDjOvwiiYjxvI
         WfnI9jyoNoAnC637zNMx17NiFYmIh03N6Y28pRzVcnzacKkqzwfNK76rH47D5Bzm0C8g
         kkC6a7xh+vvJMRgDId08lPIl/JtBPtLp+KEfTuy2LM0NxbdduxKoac0TOiy7LejLvSDv
         NbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXURDgMZfi3HJ3TKGLEwcfrERh4JP0kMk8cpztDnywfabpMUBx/TtYuD6nBr7G9HVv8S/DAHcyoA/JmDJEkw3tdvOE0SGtCnnbThFQf
X-Gm-Message-State: AOJu0YyUiVoduEzJ7fhYTHoXx80r6ou4Kefr895yUbsH3s0osp7IkuIs
	Avtz4eTsd8Xvs2+Yc058xPfVgQkCIRcNdUwxgMTBTTc9pOwWD1Ry6qY9qrAJeNM=
X-Google-Smtp-Source: AGHT+IGNoMVxgXKi4Huov/Am3Ivchl0iprmp4ADpiiyaxEKkK4U/SDRcp1yh3lV7jZtqlVQMYQIEhg==
X-Received: by 2002:a05:6e02:1aaa:b0:37a:a9f0:f263 with SMTP id e9e14a558f8ab-38a5910a9dbmr198272225ab.20.1720910122467;
        Sat, 13 Jul 2024 15:35:22 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:d7fc:57d0:ada6:13b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4d9d8sm14640025ad.264.2024.07.13.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:35:22 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Sat, 13 Jul 2024 15:35:10 -0700
Subject: [PATCH RFC net-next 1/4] dt-bindings: net: snps,dwmac: allow
 dwmac-3.70a to set pbl properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240713-thead-dwmac-v1-1-81f04480cd31@tenstorrent.com>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
In-Reply-To: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720910119; l=1130;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=L968+RrYNmrkLCbknalApiDQwXty2dLJdHRIixXyCag=;
 b=L3rqLpVjtvL21xgmZs17aB0F6yoEoEFcG/yalWgNg23k2p7NGXFOeub8Bz4u6U8EICTfuR3s6
 7Lx5UJrPN2QAxVkpjpSt/mOQiqvngcDggj0buGRWYjAWtMSM++8boGB
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

From: Jisheng Zhang <jszhang@kernel.org>

snps dwmac 3.70a also supports setting pbl related properties, such as
"snps,pbl", "snps,txpbl", "snps,rxpbl" and "snps,no-pbl-x8".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230827091710.1483-2-jszhang@kernel.org
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <drew@pdp7.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 21cc27e75f50..0ad3bf5dafa7 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -584,6 +584,7 @@ allOf:
               - qcom,sa8775p-ethqos
               - qcom,sc8280xp-ethqos
               - snps,dwmac-3.50a
+              - snps,dwmac-3.70a
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
               - snps,dwmac-5.20

-- 
2.34.1


