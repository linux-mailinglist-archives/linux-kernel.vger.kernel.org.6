Return-Path: <linux-kernel+bounces-533644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37DA45D12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B14188935C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54621577D;
	Wed, 26 Feb 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWJoRuqt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE65215173
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569364; cv=none; b=uiqS5yfLt339Or1YxP5JR2cWNb4l0b6mjax1XQX5UQn2WgM388JhGEkpSSAHqNnkcDXST41yZ/sa+G/9fiHu8pqg3fSOKZmnKgYux7Mwi2TPvnKyPkKZHMlPAg+2OnxObo8tUxW6rQGb1Sd+jzmDoZ2F/pPkSyM8IWUxRIQCDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569364; c=relaxed/simple;
	bh=aKWtbob+2RSm5JyDWJSTEd1XNxeI/gXvLID19u4dptE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTtABjzJM1pkb+rs3nxZUEOIaUrDJayOncroWuuNPbHejVxzEYYEOUMVRY5eyaOSdgU6pgK1VwBebT79UorqolAQR+oTt37kqzSgtgvr3FNmpt3303qMPDdTGHSgOZ7/AW3OjdLSAHbCGvM9r3jbQdAD7RddS730bGfwM+c95Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWJoRuqt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so1338339a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740569360; x=1741174160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQWD29wnrAJlObQ2+b6JbHQHIRXSBf6Z16/xLVUUT5k=;
        b=UWJoRuqtpufSJ1eEwtIyOqn2Ffii8q3WfxUQoiW3l8eK1jfy8sO7ZSqSwzU+mewwwN
         YNtCuoVEiQVFZLeH/a5zy3/LaQ13c8NVi7/429F7iSlAOXqTy0IPyPnjblh1a4blN8SB
         b5sWXJgsFucLibb3IDcTiYsMaV0HAHplVBiLsqL2JLzbg35Q/ufYdBldLq0McgO6Za4f
         7+5rh1Ihoszr4Hg9AMyBbjd/M54uOmWeWRvpPFfQXxMdepwv09zKFB7ldlpZtMKFkwbj
         tCDmT29rjbw2WyHEBNi+n4xyX/HO33y0k0UVlgj2IHuTL8yl5gyYWloOkznjIxjCDl46
         GDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569360; x=1741174160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQWD29wnrAJlObQ2+b6JbHQHIRXSBf6Z16/xLVUUT5k=;
        b=Q+KVXE5pUhHeXPHgSy0wp9NhkcYhzalhCWPUFrzxGk8moKwfuMlqRhLKFuj6p/mng+
         BugIa4Pw3QRcgLJisraEkCIzB1BZ4SKPF20RdOQfXBPTgCBWOJqMsbFKcAJ3wEaiG6j9
         zfMnzqDqciCGg8F7ZMFnVt+6aR9PqzU5pAmhVkvc/sJchyM6+hFTQ874BcUgBJRScnE0
         Vl3jXHZ/VG/B/dB6b6oZZX/E0LVF2P5uUn48VSJi1xSToBy/TZkBiwrd67Lomq3vAKRo
         qsrBJDIRmNhIND9vgvfImtuauU5GsxEipl36zHnDdPWXpGDm8sYKhOFzK8j7DcOpcdEV
         MJGA==
X-Forwarded-Encrypted: i=1; AJvYcCW41cEPteZd1VnQwW5xIKe/KBqJJMnrILHRb+PHCIS2t5UkZbHv6IA88NJHdaFrRZ80TM5Aj2tq8MVgnNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz+J4ifwON8xoULSwTuOdDrKPv3xVRn2FKnF6ppA/doI7Qyrc
	CZ8k+gY/51gWiJ58r09otykoMhgCUxAxTPdT0xqex4HcOZaspwPpZfoyjvsSDPk=
X-Gm-Gg: ASbGnculdbIrecWX1XBwiLhqa/8WFgihVB/iQiiefmajZFpNYg8IGwTP+dpp5XqTYH0
	4/m9PRwuTYEf3bOVV6Igs0eA150D9Gi6dXLmXv0cqlY6yaPbP67OsNjqrxWM2NKutq84/JJ61Zg
	O3umrIWIhVRc5BBJFXP+ViQBzwhoL4FxNVxb+ME8n6/wEW/bJUJMF65uzUIZVa1XY6KEIBusrY/
	i3O7slk+ya+pgbkcwuS3qcxULRQFteqcgCX5+S7cLRGnRtJQxdMDJKL3hiCP28DvK1wXbCqG2kk
	tHD3/NlgVFwS93b9V0CAOJWGTdwRqASMGhE4EOPgWOHu7fi77Zbs3e43hRimhtUhKaEnKFkuduM
	=
X-Google-Smtp-Source: AGHT+IGUGEs167MMU50Z/gsJMetu4k7d/Wn5NbBN1LtAChUhdquWuXdeMtmsG/KUgqB4AhKanou3/g==
X-Received: by 2002:a05:6402:430c:b0:5dc:7ee8:866e with SMTP id 4fb4d7f45d1cf-5e0b70dadffmr7109591a12.3.1740569359899;
        Wed, 26 Feb 2025 03:29:19 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b7174cesm2610049a12.34.2025.02.26.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:29:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: coresight: qcom,coresight-tpdm: Fix too many 'reg'
Date: Wed, 26 Feb 2025 12:29:14 +0100
Message-ID: <20250226112914.94361-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226112914.94361-1-krzysztof.kozlowski@linaro.org>
References: <20250226112914.94361-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding listed variable number of IO addresses without defining them,
however example DTS code, all in-tree DTS and Linux kernel driver
mention only one address space, so drop the second to make binding
precise and correctly describe the hardware.

Fixes: 6c781a35133d ("dt-bindings: arm: Add CoreSight TPDM hardware")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 52ba5420c497..74eeb2b63ea3 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -41,8 +41,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   qcom,dsb-element-bits:
     description:
-- 
2.43.0


