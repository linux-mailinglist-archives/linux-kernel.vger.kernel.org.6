Return-Path: <linux-kernel+bounces-362824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A675499B9A1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2511F21597
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA513D52C;
	Sun, 13 Oct 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjVQ5dX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDA36B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728826783; cv=none; b=APGbdHv5sOREQmQ05IJVmNGG1/o3N3YqjtH+aTvY34sEYgBNq4wIevcuasZU1Bj39KV/wJtl0u3uN2tLJv5ddv7rKpAsqEWufGnkQyuoA+yxymeURhsBX1/QRDaKQsvKnQHxZzy4Suw1aJoMhVsJdxkuTYwyz7RH2m8utoaTCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728826783; c=relaxed/simple;
	bh=uzLTAGz3TtqIRD8gVWK0hNU4xISDn+1hLbRXKYbV4To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3uICNjKqeT9MBBGNl2LDqQAmP7XJ1Z5TV50HUQ3P4LeYFH6LhVqx7eqlxW8O4c3oJsQbzx9aGk9y60VWxwp209PODZmAY8ENR5+Pw2SHi7VvjB6ZwlFqWrhUYq8qyImlVGFVAm6Eqb8PkVAIBEytNZzMRP1a+QEf1MkNGW1xx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjVQ5dX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A69C4CEC5;
	Sun, 13 Oct 2024 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728826783;
	bh=uzLTAGz3TtqIRD8gVWK0hNU4xISDn+1hLbRXKYbV4To=;
	h=From:To:Cc:Subject:Date:From;
	b=EjVQ5dX6b3TDEthKgxifd8qdMRB9hMSYl86iCHiCRsXzAIvIpVSyPu2QJjiUYcVj+
	 tn3e65+n3S7evXD+fhYTfuXIg7NDDoD5NrI+8ijs8EFYEj9l+SEOLAwFKz7JM+iSK8
	 NiC0vbguJYmcnAmqAiAHKFmKbt8jKdFv9FZlh5v1gqxczDwnQ8IypEnfP3sZw7ZTp9
	 EuRv9YW8z8Mh/C09J57EqI0GTyQB39RZnZljqLA2WlAaCvc3MFG3LY7Hx53769UetC
	 POKiuuIeP8pxJvto9fA78iheltR5lWOL3OnQu01xxs3voZeaMfZFh9JgKpvBtwZ2n6
	 STYBP1Exvu+mg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Add support for Cortex-M85 processor
Date: Sun, 13 Oct 2024 21:24:35 +0800
Message-ID: <20241013132435.2825-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add processor info object for ARM Cortex-M85 CPU which inherits the
setup procedure, the processor and cache operation function from
Cortex-M7 processor info object.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm/mm/proc-v7m.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index d4675603593b..ed7781c84341 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -194,6 +194,16 @@ ENDPROC(__v7m_setup)
 	.long	\cache_fns
 .endm
 
+	/*
+	 * Match ARM Cortex-M85 processor.
+	 */
+	.type	__v7m_cm85_proc_info, #object
+__v7m_cm85_proc_info:
+	.long	0x410fd230		/* ARM Cortex-M85 0xD23 */
+	.long	0xff0ffff0		/* Mask off revision, patch release */
+	__v7m_proc __v7m_cm85_proc_info, __v7m_cm7_setup, hwcaps = HWCAP_EDSP, cache_fns = v7m_cache_fns, proc_fns = cm7_processor_functions
+	.size	__v7m_cm85_proc_info, . - __v7m_cm85_proc_info
+
 	/*
 	 * Match ARM Cortex-M55 processor.
 	 */
-- 
2.45.2


