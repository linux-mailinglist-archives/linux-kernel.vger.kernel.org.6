Return-Path: <linux-kernel+bounces-567600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ADA6883B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D998188AD93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA254259C9C;
	Wed, 19 Mar 2025 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5WiM2IE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD4259C83
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376728; cv=none; b=bm8zZQDEirQukJqxlHMqD/7DLgfT+1qBRiFHRIBz+tJz5zPqcExcRfAZVF3uZfBIVkOS9HhVCvVCAx1elg7fHeTIMXzZ5+/UWCGxWDI/nueyMFbEc2WoYVBWCpEatnPdL8baq5ifBHyKGVDZUc60a/IkpSP2vU0NlgJDBsRbGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376728; c=relaxed/simple;
	bh=58OahlrnwSdGfcXKgZZBiLlBcI4gqu49x0cWY1ElmVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBSj0/vlk1VYJoUzXMsi+SIlligiOpka/zKMXHfP9AjJs5Qdamfm5EKdbf9k97jlaAftU7/KULDVi/uE7LhpUDPl5w03OkYssqhkV2AJnnDkDLsJm2IEkB/Gbt+aSkk0aPCNj50Cp6BpSkYz3p20AspdRcJSPAt5kUWnU8EGywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5WiM2IE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4612DC4CEEE;
	Wed, 19 Mar 2025 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376727;
	bh=58OahlrnwSdGfcXKgZZBiLlBcI4gqu49x0cWY1ElmVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5WiM2IEEaR/9PDRj+oA6ut255iMC1BwBPAK7TUPhoQYmo13LGpVCr3p/EmfMdVO1
	 Xl/+4iG/D+Z3S8aVivLH3KY4ml9MimZsz6JdCrTGslixbKkMGpB/Ad+C09dMBNFl/F
	 jxE1RyV6fdmm9WUCORjk1Nu+74FoFdHH0RSb8oLZB/7/aAccI2cplVAw/iH5lWXyb4
	 Mm58xzYk5DxyNRrDxuaI1LcJXjjm1iPuBuHy1NBzgKDUmGKAS6+JH3sQ3o8hYP+B+X
	 XKmn8DZfrK/QC6eotSTYl/ceT5/jDQoqS9rVYW+zBWB+SWCHW5e61J1jLnH+6Y26Ds
	 iIHpKGtj7uGeA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 26/57] irqdomain: misc: Switch to irq_domain_create_simple()
Date: Wed, 19 Mar 2025 10:29:19 +0100
Message-ID: <20250319092951.37667-27-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/hi6421v600-irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 69ee4f39af2a..187c5bc91e31 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -254,8 +254,9 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 	if (!priv->irqs)
 		return -ENOMEM;
 
-	priv->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
-					     &hi6421v600_domain_ops, priv);
+	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						PMIC_IRQ_LIST_MAX, 0,
+						&hi6421v600_domain_ops, priv);
 	if (!priv->domain) {
 		dev_err(dev, "Failed to create IRQ domain\n");
 		return -ENODEV;
-- 
2.49.0


