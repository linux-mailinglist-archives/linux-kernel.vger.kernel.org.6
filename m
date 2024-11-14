Return-Path: <linux-kernel+bounces-409868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15A9C92B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AE3B27FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B81A2658;
	Thu, 14 Nov 2024 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="euW6R8bI"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEC148827
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614216; cv=none; b=SqiDqZQwWou/AV93eampsj6+94FJovGvi+CXdv8ltOmuUAzWypP2IpUG9+px0Pm0cP1uEORrfZD6YCV//BbHcwvMbvrkl8dwoA3imJWKuQ+JjIBSwI74A4YIWcczafi6dZh2OrDcEacERepFrIAQRo3kO3/kd1nXNpHeuds2C/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614216; c=relaxed/simple;
	bh=UwYpymoJNg6uhdrcPhwIqhStfdSx5HmoITpcaxbv5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NywhaH9TMSeLsrHxjUVF4WpXGIgrH3LbEKLSFApO9fLbdZ3ASazBFhLQmttd4dqLqkbmkV4O+q1zJsOaLM7ep8JMG1fNLyJ/LRaAk2GZLpJCbk+BsSfR2EfjkIlwJ7pzkiHjx4wlCx3d5fDNR+wxfcVAtfW0URht7ST47GLbQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=euW6R8bI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so771302a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731614214; x=1732219014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVQSHnPqrqPLMNZP6o69IRBL1jKThUMkliC7H0VO5m4=;
        b=euW6R8bImhdE91B97BdPgAyCCN2behfRzVhIf2oTLveHN0ufAdDXfnor4i6hE2Drfl
         Neg0T5RjVUZXx+n0ZDM/yTHGGWaq+36QTskwyU6onN4/Q7KKVou5L9D6+2UI6BbIoOc5
         K2l0Av4a4W84A8er8l8hwprEmqv5q+6eAVHSYYv0u86PMXXoph4YaLWDbkuTKqJOEd/g
         ogiUo4jgTAhvWIZKFp8JFiPXxArENuMRb0CBIogG2daLSKiSU/0NhctVSQAhNZ6W85uw
         30zsdJaLPJocl2ZjAQZllGXZH5H98XgnpZKnfb0U2p2x4lsm97O1mo7LQbVB/zLnv98q
         zy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614214; x=1732219014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVQSHnPqrqPLMNZP6o69IRBL1jKThUMkliC7H0VO5m4=;
        b=BY3ZXNFuaGYrUTJ4mAdfi/tq9Tal6idv8I8b0UG9l6M+P9sK+CaRKfCxEFwi8QfY3L
         AWWVbhJoUccHj/LdaXBkbqJKQA+u1JjTDHNQc32PJ5NEeabTeF11J1MFG0rkeBbp2nH5
         7Z0Id9NH4EebAlE+KCsyie4ksimSjitVPudaDtYHEM2Cs+RKLSbd/YyMkgOaevuJmWGg
         TBVEq3EjWWbVfq7Bbo4qSPb1XNJexXUIIj6vvANk5WXGBglB2M/A8Ej76v3+YmrtzLjP
         abmVEJCYg30+/cnXCBqrsgML1Ibo/aIQ558rJmQSE2JWAX/676nA9tIIhV2m4+Ze6tXK
         dBSg==
X-Forwarded-Encrypted: i=1; AJvYcCUC52l4D9FrpS1aCjtv8bFC/Lb7+tRcPPI1FVXYidFKqJ5DCK+6n7aXRwVW85rbG6OrsPX8v77WndMrVVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBJQZpGZANOdRYsH3KjoGpv0MwRnZ5YjDYXRlXxFZAvN2nCyp
	vM8ytFiibCqkDLBTMDlyh848jHoB6rZtJgdq2pYdDApRkfBJ/dm5Eok+1ReySLE=
X-Google-Smtp-Source: AGHT+IHLoJ5uQlbmwI7UOxCVQN1W7z+tMyLKhZhocvuZ5iHF31FrICzOQm6eGNyu9uIQcW79a8XfWA==
X-Received: by 2002:a05:6a20:4314:b0:1da:5bb:f8ca with SMTP id adf61e73a8af0-1dc909bf945mr4488637.0.1731614214511;
        Thu, 14 Nov 2024 11:56:54 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d43sm14009b3a.114.2024.11.14.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:56:54 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: property: fw_devlink: Do not use interrupt-parent directly
Date: Thu, 14 Nov 2024 11:56:49 -0800
Message-ID: <20241114195652.3068725-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7f00be96f125 ("of: property: Add device link support for
interrupt-parent, dmas and -gpio(s)") started adding device links for
the interrupt-parent property. Later, commit f265f06af194 ("of:
property: Fix fw_devlink handling of interrupts/interrupts-extended")
added full support for parsing the interrupts and interrupts-extended
properties, which includes looking up the node of the parent domain.
This made the handler for the interrupt-parent property redundant.

In fact, creating device links based solely on interrupt-parent is
problematic, because it can create spurious cycles. A node may have
this property without itself being an interrupt controller or consumer.
For example, this property is often present in the root node or a /soc
bus node to set the default interrupt parent for child nodes. However,
it is incorrect for the bus to depend on the interrupt controller, as
some of the bus's childre may not be interrupt consumers at all or may
have a different interrupt parent.

Resolving these spurious dependency cycles can cause an incorrect probe
order for interrupt controller drivers. This was observed on a RISC-V
system with both an APLIC and IMSIC under /soc, where interrupt-parent
in /soc points to the APLIC, and the APLIC msi-parent points to the
IMSIC. fw_devlink found three dependency cycles and attempted to probe
the APLIC before the IMSIC. After applying this patch, there were no
dependency cycles and the probe order was correct.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/of/property.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 11b922fde7af..7bd8390f2fba 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1213,7 +1213,6 @@ DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
-DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
@@ -1359,7 +1358,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_io_backends, },
-	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
-- 
2.45.1


