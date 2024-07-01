Return-Path: <linux-kernel+bounces-236074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD96591DD1D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72246282F98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7213DBA7;
	Mon,  1 Jul 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrZsDxgs"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A712664C6;
	Mon,  1 Jul 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831189; cv=none; b=g3y/MFJuTW5L64pNfdpq1G1C0wYXogXaXEPeDIE4x2YJvvOvxkYXsq/XWHH94iPyym+lkTOEKr6Eh50YYv8czkDpDmt9tbYrglFCbGtMeD78oDmqb6lstVf2iOP3Z1aN2W3Godep/GHLRVdqvkRlJYL342E1zMCwWjjH4e2Orrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831189; c=relaxed/simple;
	bh=DR3lQkt61V+LYkFulh41gYt3LOsgKd8rT8vexpvJNyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJF1LePxkVSTZwas/lgVnugDgwfqbaxBjVHumGMVYb5v4RP4npUqiVjPYAm30y4kzr/zmRjzUJvy5l/ZFEitht6N9mZjN6tPFXxysWSUsHDljCQ9cAXzT61GxVgAdiHmlXJKpW1x9T/dXhBzhCCO4vtUCQCtuYatNlaDFgpppAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrZsDxgs; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1faad409ca7so24317955ad.1;
        Mon, 01 Jul 2024 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831187; x=1720435987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0qY0eq/bCYTLQqVWP+SkvvD807zfIcKNdRibSQIaU4=;
        b=PrZsDxgsBvXv/q8SIPLk3Am10PbnFCP0ht74Ze/OsfZL+OfaiAWJsrxLWw6Q/BVi/M
         9NBysnKIhoQ4KwagkvGH2lORBMUxVeruvVxsmwAM3tG4YTigugJl4/2HwfdSRKeEJPC/
         QG1r+0ViwSgAYHu4AT/UhB8lFds3BxVsWPNAT+tUSRa5Xk0JmfpIQ43lOCjrJ9V+hc4w
         fgulTp+rP5+aq1BKGeodjpiZBCHZO6/jKlSwyvSXNur2wxrmaWalDm41Bu/p6YWVXKeR
         gBy9wtyQZMdJhScV33UGJHojeENtAhLmNSVZgjqa/RcnfJqAG2C4qLrJlNrgS8od11UC
         WAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831187; x=1720435987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0qY0eq/bCYTLQqVWP+SkvvD807zfIcKNdRibSQIaU4=;
        b=LpWc+zh63Uw4y6oRfa7I3KueOovnzgvkNGhFolPH8gsH0XRJlLOcthXu+VmrzLSGQq
         eHjc40zgiNXDgjSpsV5xIW2PEviwCUZg30WXpmDfJgaV4AxxPHstvNmaSDAtTfR1Y/9j
         +tzx5vo8qwB8tOerQ0PoSb6eXOs9HxvwXa9v9C/Psvg08NxA18PBoGtXU7K9UMle5L4s
         OgIG3O/ErBJYmMFRzJmw6rb7jcdT2nzHuEvAkrfluqn8y+/Qf/DObloffAMPMrYDsbu2
         RtLzL+t6WEMDcZ0uaZKH5TtQjm2LzdpJE9mV/I8JnKo1VcgSAz+bfzfc6UVmRvc52fgd
         TIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXEPK7R6d0IcsjNMOlB96CHL9AD8i4u1KCbqZJ3OBj96ZpD6+yHVGiyL2IKwkAv2UgLs1tbuhDI7KdfJeocdBBxhtCeCWi937gHJSTe
X-Gm-Message-State: AOJu0Yzd4gBasepvmyIoFUGd4El1gRhOMGVAwofeBKN+XBiwXQNSW5m7
	XpIwzHCRyGFyLJSlIgxmTtN+NGisL3GqZTwM5wlJCN955XKw5/56
X-Google-Smtp-Source: AGHT+IHfEd7Z2W+mZKOkU2QAibQKJj0zxjBUZwryWSVYj+KSgDIHYf+8cNFUtLVRKtbV/mtanbCujA==
X-Received: by 2002:a17:902:f203:b0:1f9:e97d:9460 with SMTP id d9443c01a7336-1fac7e7fcf3mr84609585ad.16.1719831186806;
        Mon, 01 Jul 2024 03:53:06 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15389a8sm62024795ad.176.2024.07.01.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:53:06 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Subject: [PATCH v1 2/3] dt-bindings: arm: aspeed: add IEIT x86 platform BMC boards
Date: Mon,  1 Jul 2024 18:52:58 +0800
Message-Id: <20240701105259.972135-2-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701105259.972135-1-liuxiwei@ieisystem.com>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on the ieisystems

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e386d0ebfb14..818fbe9c45fc 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
+              - ieit,nf5280m7-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-- 
2.34.1


