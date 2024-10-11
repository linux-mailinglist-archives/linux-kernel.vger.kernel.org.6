Return-Path: <linux-kernel+bounces-360929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2C99A177
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DD1C21215
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455C21265D;
	Fri, 11 Oct 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Efzr0/2M"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419421E379F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642905; cv=none; b=dGNU8A8PNL8CBA/Z3ooBz1swVxzVqiexZ0fak3cxYZvLk1COmvOeHZyx3kwf4JFxuPodDC+zuV/5Yv5AIXtcqCM0pCBf0C6wS3S8EJgtfHXOZsocr6MXSNnwCBBMaOu/7lJ4DXJ4ZFYjZdBdDM0fDCRPj55LCWHo22GsV0rC9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642905; c=relaxed/simple;
	bh=KywBnJ6zPTZmJYG3G3wLfX8yMpxHMr3g+ZUm5jRHVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVR1oJozgtAnBJIb/VmaCXowJTdOxR8pSSCsTshNuYWWiYBdwzUAWCMlvGm9uQVRre6BNST0BmMKFTj/8Cij2rXtNlqvFiUZegIAbF7g9Yg2ztuvkMCuN1VCYjtk65KiEPMo6iJqsrFU/d3O6YCMq/5LIvteIOTrXNyEj5ZI56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Efzr0/2M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a993302fa02so299500566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642901; x=1729247701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=Efzr0/2Mk4HYN5xQToflDK+/blOrXjMiI9+YAY455wmZ9n51vrDvzN7khQOlr5xP9X
         PCFCI86uLOQ+9ffBWK3oBWcrea8/OG8NjzehI/73SYdZcz5Of1LZ+Tj/aqlt0MvBWrJm
         TS6qQs57GsOfJNb+dkP89o/uS9JM+63toOjCKCmdJhA0KbgS3HsC9r+tou+xZdySYmYu
         fKQqOCD2SQHkze7buxsVwA3Iak2oFEKzVeoWcbZdTHBiHDifY0g+tY10AcdLX+bSWS1S
         l4cUhz3nNt9V5wAoBclVHoBSIjQXFOHw0nIAt37oifkZ0AVoTdAQlKJQ7sTbWXYgh7aC
         M/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642901; x=1729247701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SaYY+AtVB7em+W4exLN3hxNWJekHWEFD8Olho91rT8=;
        b=Sc56qE/1qgmKnmE7BT7MgECJmjIkwNyZimWFsjZds8Ii8wAFIG9kHtODK29pcNe0yO
         MVJLncVdeIr8k4X6N+6p4BfV5kt6/Cggy/Ms6ngF8eM90NwN2ZfSzAZ01Vw/Du0Tc3KY
         npUtLq+fnjfaApvJeISRP1zEw1eiV28Z74SAtO2lKrDy8/PKadHxOyHl+13lfV+PAHyC
         W0E63a/zPvDoxljApzgd/3YXeX2R8dxzT6RDP88UUlx60Ve8sqvu0QjKp2ERs0J8gXus
         MNX3GQ6rNNxxeJl7/isCR2BG91gan4JSeQW8Uwu6kvB9DmGb/RrKRIFd+/uPPRZNSR3o
         gggg==
X-Forwarded-Encrypted: i=1; AJvYcCUdJTJnFD3RZOd9izNTvpeyREAAyZN7LUwD5Lvk3HGYqHCW6TzX48Ni4FN4oNa+qjiCCi9fSLWnLTu6cPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7XZP8mn/amY2zTDjCuLw5XpQCIleSj8ayq2FcXinaQjgUvN4
	7RdRwMsTBT7gmcXCTHOFGCEYsztsvU8RD+tN7AE7mDEuSAfABB2o0H9+Hm4ldNzKrkg3ay5jJ1H
	4fc8=
X-Google-Smtp-Source: AGHT+IELx6/9afAmAU4e05SnZVhUICTVfb+96LCeVIZV6uV7pDo0nHnPRI/3W3xE5NUNttjfNY7xeQ==
X-Received: by 2002:a17:907:970f:b0:a99:4275:baf4 with SMTP id a640c23a62f3a-a99b937a62fmr143435866b.18.1728642901573;
        Fri, 11 Oct 2024 03:35:01 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:01 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 19/37] arm: gic-v3-its: Rename objects
Date: Fri, 11 Oct 2024 12:23:00 +0200
Message-ID: <20241011102419.12523-20-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code accesses the gic-v3 node, but not the gic-v3-its node,
thus rename the objects to clarify which node it operates on.

The following commit will make use of the gic-v3-its node for real.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 2cc0a32f9d..22fa46a341 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -35,10 +35,10 @@ static int gic_v3_its_get_gic_addr(struct gic_v3_its_priv *priv)
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_IRQ,
-					  DM_DRIVER_GET(arm_gic_v3_its), &dev);
+					  DM_DRIVER_GET(arm_gic_v3), &dev);
 	if (ret) {
 		pr_err("%s: failed to get %s irq device\n", __func__,
-		       DM_DRIVER_GET(arm_gic_v3_its)->name);
+		       DM_DRIVER_GET(arm_gic_v3)->name);
 		return ret;
 	}
 
@@ -158,13 +158,13 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	return 0;
 }
 
-static const struct udevice_id gic_v3_its_ids[] = {
+static const struct udevice_id gic_v3_ids[] = {
 	{ .compatible = "arm,gic-v3" },
 	{}
 };
 
-U_BOOT_DRIVER(arm_gic_v3_its) = {
+U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
-	.of_match	= gic_v3_its_ids,
+	.of_match	= gic_v3_ids,
 };
-- 
2.46.2


