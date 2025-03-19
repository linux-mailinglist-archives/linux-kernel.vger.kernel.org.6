Return-Path: <linux-kernel+bounces-567624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E7A68858
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C371419C73D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B625DCE8;
	Wed, 19 Mar 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJyKCYDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA025DB1E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376790; cv=none; b=AvSqsVdnAUEnzp6rrjJNZanZmX2YhKYPoAdeDvGFBbcBU4xhpRaJC3wuW9syl2B8nOQCW2C4JFE5x2otPyF4KBJlc+Wkk7Z7OKZxyN/+zAdZPzUwnww9d3Yypc6o65xZDKUQKuHNJ9At4NMprZh3FMSR3zB7I1EUcKnNmKNvMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376790; c=relaxed/simple;
	bh=lidN/QLL8lJclrXx9KsiwC+GwLwp1Sp0oSxXq93ZbfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+Q3bmv5hetmZmGyswLbNOONjzQVmb7OB6BW5DyCm4F8EwnIHjPt70nKcKhMZFTccUyViumch32QmrrdlBjmzOC9l8UwhOedskYBcT+VEE3XeBtgPlkxUJKiWlAY046upRpFFIeqskMd2qGhDEUrITCJdpxmgiq3b/5e0POoQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJyKCYDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324D0C4CEF0;
	Wed, 19 Mar 2025 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376790;
	bh=lidN/QLL8lJclrXx9KsiwC+GwLwp1Sp0oSxXq93ZbfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJyKCYDsJp7yl/+479P7DpVX76p15OAjRaI0jRC0YbCy/GtuHNPKx/jxOA5lNJOd/
	 I6dtTMeyPOxy4WjUrbFNtbDvf88RVHgUtb4XwevspfvXNEqwByb6eF5xZWh25Y5dVj
	 LMtWq020UsOXFnZ3xlN3NWY2nf5EmuRwz7TwYY6KS86lJCGyB3zjLwt0EcqzhJS/cB
	 0sS+NpfcksXilvhcHWjpA4AouTdeawd5KcDM7eKzkyQ6il5tghRgZK6R0hlXWDZW24
	 KTee1eqqvzSA6OR2KHIPLALwZ6avJj8TOwOnAZ30PbvP/BIf7apK0f2tPyMLvUXINB
	 7+LK4W7r1G2XA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 48/57] irqdomain: soc: Switch to irq_find_mapping()
Date: Wed, 19 Mar 2025 10:29:41 +0100
Message-ID: <20250319092951.37667-49-jirislaby@kernel.org>
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

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index e5831c298ad6..e4b6ff2cc76b 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -344,7 +344,7 @@ static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	if (irq == 0)
 		return 0;
 
-	return irq_linear_revmap(qe_ic->irqhost, irq);
+	return irq_find_mapping(qe_ic->irqhost, irq);
 }
 
 /* Return an interrupt vector or 0 if no interrupt is pending. */
@@ -360,7 +360,7 @@ static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	if (irq == 0)
 		return 0;
 
-	return irq_linear_revmap(qe_ic->irqhost, irq);
+	return irq_find_mapping(qe_ic->irqhost, irq);
 }
 
 static void qe_ic_cascade_low(struct irq_desc *desc)
-- 
2.49.0


