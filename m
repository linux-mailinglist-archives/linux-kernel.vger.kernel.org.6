Return-Path: <linux-kernel+bounces-567588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF42A68823
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7836A8823F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893032571B1;
	Wed, 19 Mar 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFEtPvcI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13B2571A1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376687; cv=none; b=UZfCmCNU6qgYUmLxkkP+CBfV9IzvWxCGi+wiExwOe8Q4TUxy6TBxgdE1OWkJufKiPocngkaX+a5uQ8WGAP8ELh84vx0ZSinYLpL3vAIoBAKeSsiKtOzVrr2q8jBDZq5yxfUjrbok1EGfv7hc1svHEbCEMcAQndnVH7TRgGRrjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376687; c=relaxed/simple;
	bh=pag8Nr5xVrgJ9snU+fESIDcnF5aHvXj9M0eC2lbzGoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4RseWIWISAwxxRM1w0xjJeVdq5FfZTMiImmuesYWeOLwXtZV7V09+wU8UhH5fWKr6cFHCsTrk0y6hf4586AcVl77Ruwbgv2aROf7CDF++ZSBMsNKamGM3QlNNA8aki0Q5AAlQoRHPfkeqWqrGNP3EJSwO0wN53dE9ZtUAPZgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFEtPvcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378D1C4CEE9;
	Wed, 19 Mar 2025 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376686;
	bh=pag8Nr5xVrgJ9snU+fESIDcnF5aHvXj9M0eC2lbzGoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFEtPvcI3B6djmlwfI4ENNUUVB/eRlUK4TGtc3dZU7aWTbeBFRgxYkQq/ZPgeqQnH
	 jQOAuWC2l7fgLE+zs3Pd3BikKT7qYOJE8QEIaSO3EMu5tnWhjl3V6ec09PUA1fAKYu
	 jNg/nVWwW/ZR+JliDty+dS2VfzgCSRVw4bl051i7n6G7CEsFZKWfq2GV5bunfFHY+R
	 3Yr0FgiMeQFKplTmMbY/UheD50qVtTfxc3FiyjxUpd45ulUt3qROkS+IaeVrWvGKjr
	 uls3u2CGRwO6K92Lysx4o8EgPcygb/E7KIWoJfO/xJkzsxnaS0zpzuI1yozovPgzst
	 Ts5hI9AKlmG5Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 15/57] irqdomain: bus: Switch to irq_domain_create_simple()
Date: Wed, 19 Mar 2025 10:29:08 +0100
Message-ID: <20250319092951.37667-16-jirislaby@kernel.org>
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
Cc: "Marek Behún" <kabel@kernel.org>
---
 drivers/bus/moxtet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1e57ebfb7622..6c3e5c5dae10 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -737,9 +737,9 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 {
 	int i, ret;
 
-	moxtet->irq.domain = irq_domain_add_simple(moxtet->dev->of_node,
-						   MOXTET_NIRQS, 0,
-						   &moxtet_irq_domain, moxtet);
+	moxtet->irq.domain = irq_domain_create_simple(of_fwnode_handle(moxtet->dev->of_node),
+						      MOXTET_NIRQS, 0,
+						      &moxtet_irq_domain, moxtet);
 	if (moxtet->irq.domain == NULL) {
 		dev_err(moxtet->dev, "Could not add IRQ domain\n");
 		return -ENOMEM;
-- 
2.49.0


