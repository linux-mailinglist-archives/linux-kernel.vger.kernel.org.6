Return-Path: <linux-kernel+bounces-567607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7CA68843
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDED219C0637
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB525B66C;
	Wed, 19 Mar 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li3mSSSg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8125A655;
	Wed, 19 Mar 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376748; cv=none; b=aCOYBICgiJMRVbtotnmnS4XUC0ICUQPDSRsiAZQdw7mLe2BvPmAkI3gQyayjccm5JnoXTz8ougIphgGlE3E7xNGi4eBK2HlyzCOh2EXUgvZ7a0A7cDwDdnqgdBN6gi7AGLsh548punRlQJBYhVQ7q6bgV2AF73vVgXNVESZIsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376748; c=relaxed/simple;
	bh=WiX4WeKHacFFfrdeoVaai4OC93Gt3ejm2Wmh8P+mBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJKIxCR7GJEy2ajnP2XkNR5eDTIFo0Ru8H2+a6WKMtugHNTlkFLus4od/HuqOWcTPcfo8VeY7L16AYH14zSHjd999/4aosh6PIF3hVjchECxl/X1IUklXCdozJWPq3ez3JrealzXUD3fXmxoID2ipKh+4D/gGp5vz4qCWosex1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li3mSSSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE40C4CEE9;
	Wed, 19 Mar 2025 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376748;
	bh=WiX4WeKHacFFfrdeoVaai4OC93Gt3ejm2Wmh8P+mBrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li3mSSSg93zlmywjPim+AqXUqCsihFTWjejPuLAayLQtHqAyC9moPeGVj0XO+kdxD
	 uMBx6fcWwuIi/59IFG9M3SHtxlCkruIneMeAbB9zmbnJo+8w/4W9l9PRSX9KciiBZ3
	 jPLmn7hFkyQ2zWppBD+5N7fBvxqcnKmhN3/46dB8+XTMKu5IYnMvBqcReeNDdGJd45
	 /I+fQcB+swIv0i10qsN8ZwS0yeb3X12yOfNQO5N6H+dJPIBR0kHIr+JjHpRJq8TrS8
	 2TcJJrl2Rb/RV9bt8KOLKRJqqkE6iJz2xGFaVMHahO/Li3VcT72Nae6heCjHSUupwG
	 PG17PKok1KD6Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 31/57] irqdomain: platform/x86: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:24 +0100
Message-ID: <20250319092951.37667-32-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/asus-tf103c-dock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-tf103c-dock.c b/drivers/platform/x86/asus-tf103c-dock.c
index ca4670d0dc67..f09a3fc6524a 100644
--- a/drivers/platform/x86/asus-tf103c-dock.c
+++ b/drivers/platform/x86/asus-tf103c-dock.c
@@ -856,7 +856,7 @@ static int tf103c_dock_probe(struct i2c_client *client)
 	/* 5. Setup irqchip for touchpad IRQ pass-through */
 	dock->tp_irqchip.name = KBUILD_MODNAME;
 
-	dock->tp_irq_domain = irq_domain_add_linear(NULL, 1, &irq_domain_simple_ops, NULL);
+	dock->tp_irq_domain = irq_domain_create_linear(NULL, 1, &irq_domain_simple_ops, NULL);
 	if (!dock->tp_irq_domain)
 		return -ENOMEM;
 
-- 
2.49.0


