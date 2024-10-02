Return-Path: <linux-kernel+bounces-347282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4198D077
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AECA1C21576
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4B1E5006;
	Wed,  2 Oct 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DCv5TqpZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A61E4128
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862744; cv=none; b=lx+0NgBvu9jhzJhUAfjCride/Bk8sXW4CHdQt7AAly7V105PbI+bNSFIhroQ0Qt5wjkiw8R3iJr6/zwceIQBDclK23bRUEULQEI+4x++5R9mQxfIPjqAxUwVoT3dqMN/O+XaDzGV38hmAEI2o9bX/1nuQ+wrKAzVX0dPFwI8X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862744; c=relaxed/simple;
	bh=sAspBPW2aJDhH2ElRQqQ5ltJlXwR8eTbuD4hXdxnqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruhz9z2Vlc/nhir+sgpwDs2q/NJw9XcyFy0Se5ezHWrcSEIhe2VXWNbDhAKR0XruB4BuOPFhg0k4Ww57+TxBxcmxfygP4t3BuPIE9QMYyLNICdVF5R/ZcRSZluvUtijdWQ8AnIGld9I4Dn2f+/KGuTOQqjzjcqLCbAW69C7KSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DCv5TqpZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae102702so48849405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862741; x=1728467541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=DCv5TqpZ1YAZ7Pp06K/X52iDXgB13bv85KGMwiU0V0nnbk3L9bzoQdoIlMrrIqzMpE
         KKuRoD75v7aFiq8wC4IOntg9Xbe1jIq/GWdaRF8Ho3EfIIJqIQlFCA3VXmFxSdZJ9/gf
         NTbWQunIbEr5CM9Ee2goyw0tq4q+0jsA1Qaq+xhxlzI4ZLD+xnTf45jr0OabXRExuZgE
         gu/7eKOQ15g4FXRu7SnXA0ZmTjtdsXkiG+98gmCG2m4NgWhDKYrBpo+ggkeGCewWUgQW
         w4C9A3vkp2jJIpbPnFv+nLP/+8vgelE1i3PQIgR9p8E3/f2VoUoI3pv6O6ppzIqDbNXI
         nRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862741; x=1728467541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=lt5dvUPbnTJ7dWTlUmkTe6sSzFAmM2d1F+Lb+M6iJ6HRfF5O8wADQ3CWnEOfbkvzXw
         f4yLPzQruQoo3O+39wf3zKhpNN2UApjeD05yf8psbmvshzyLNptdSqM7Mi30KGziaPMJ
         G3/47r/ZGXeFaT11UOw8hmM198pE5JMWV1z0vU8AsV2x0nZ+DqIemR0Iu9x2dI7JjYVa
         V5CV06bpHTuBlA+Ht33fU2VOJVgxX3D0CGJN8hVVI55YO/c1/RwABiPMQjdM6pHuZDQF
         deLn8zF1mnacqw/aRMV9tViAA70buSmQ1Ia3Uif0m9eLbZsEFOMHWFV+SMiTAZzSmljp
         dgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+4qd3kLuSiwdSRjWee8kvLbMShZIndePhHHpj6t8SwSrO0/Nzi1JSfjB3onk4knPU3kxZU4k6SH1kOtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/7Pb7fO8/cp0pcKrKUQZhOU+dWjKOl1NUyaZu7PPE2z6e/8j
	zsFOYmqBdx9DurtmXjrugrD4mOSdpqqvKu+4VuWTJIfPDIZ0FLjEocq0IN/aA+M=
X-Google-Smtp-Source: AGHT+IFfZ9QIzDhHJg8KrEhxdmzD/m43IGBBfCVRb8bcy456c44XVgrW040k5TPGyMtQxd4At28VkA==
X-Received: by 2002:a05:600c:3b11:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42f778fd829mr17411955e9.31.1727862741278;
        Wed, 02 Oct 2024 02:52:21 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:20 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed,  2 Oct 2024 11:47:11 +0200
Message-ID: <20241002094832.24933-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order

---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..0d5545bfb2 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,6 +4,7 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
@@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		irq->id = args->args[0];
+	if (args->args_count > 1)
+		irq->flags = args->args[1];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.2


