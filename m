Return-Path: <linux-kernel+bounces-567627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D18A68876
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45185883A77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539025DD1B;
	Wed, 19 Mar 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e93I7MOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8025E454
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376795; cv=none; b=UbHLYWH0WNIbjCypWbaYb+YfjBDi1GUhSbW73JKf0ynEdEkdR5KVtgss0c8y6SV0ESlnHo70a7Es9qbv0pjrs2GBhupZsZa0ko3Qn7JuFU3TX5+RaADo0aTsO+xewDbxMt6lPVGdEojJvTtUZJh29i9FM63WqhcIA2ieWWe3d6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376795; c=relaxed/simple;
	bh=a9U0bdVcfma7Pzlz5vym4wIqvenndjLBfijdaF+4FNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoG0B1+o0gKuBOkpoblErkljWBfhE9DQ0CckV+4F8oX3krLnu6+JPL8GeUnKAB7Q/1nMlgVm+PO+r2vZdZ5riskWPEHk8Tq21c0rKmCdnXL0qTeV73WyA+xjJcXi8rKlM4bF4kcaO6RifhAj4fB8/uz35D8xzuFKa9y63kagTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e93I7MOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A8C4CEEA;
	Wed, 19 Mar 2025 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376795;
	bh=a9U0bdVcfma7Pzlz5vym4wIqvenndjLBfijdaF+4FNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e93I7MOMkTGxVi0J8nfx1bE9K6U4lsDLn6V5zoJSiwOYYJb264t/JZ9cwHMyB7LES
	 0R+ljjVKtsVWbu/C+dbL3HxZ2irk7LAeXA2NOdWtb/kqRZV1EXE3Gl7GmgY8TJD5Jr
	 kzCbcZzZKZjWF/jJ3Nl2K/A12Rzjbq6I65bn1UbgjLs0VaEJSWMNDM6Sh7CKdmwqUr
	 qchaJSIoGauLDT7hZBpDuOOMXVTfNlPyMR5bzTrM3AES8T3f20IAZJe/SkB3d6dOHe
	 5A5zRi4ds+q9WRbvySrFnC2nS64ts+5Ps0ybDOGw6iAkqpn6sVfmru7LHAcBpjiAiC
	 XRncNwTx7T2mA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 51/57] irqdomain: Make struct irq_domain_info variables const
Date: Wed, 19 Mar 2025 10:29:44 +0100
Message-ID: <20250319092951.37667-52-jirislaby@kernel.org>
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

This is just expressing it explicitly as irq_domain_instantiate() takes
const already. No functional change.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/irqdomain.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bf52a08f3255..472f6bb91e9a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -396,7 +396,7 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.hwirq_max	= max_irq,
 		.direct_max	= max_irq,
@@ -416,7 +416,7 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size,
@@ -432,7 +432,7 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.hwirq_max	= ~0,
 		.ops		= ops,
@@ -548,7 +548,7 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size ? : ~0U,
-- 
2.49.0


