Return-Path: <linux-kernel+bounces-246498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A374892C2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF9282A81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB517B03A;
	Tue,  9 Jul 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pleTIFYo"
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25EB1B86F8;
	Tue,  9 Jul 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546908; cv=none; b=AJipyfsKTDHhgtQQ8Qt+wcDIY9rMmgiTax9YJM4dBOvjNfCB2Z1T6CLg/VrrI7rcSg6y3xoVANsYxBg88XTjRBbwihm+coYsng/kPQHb+Ikb70LsrmOAC4AMuuSvm6myz6PUNUxDLoPnBuK99Oe+lc+Ghiv3rgTLbZBEaK8STVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546908; c=relaxed/simple;
	bh=c8cxlmF6gbJmKp0GvscVOmvNDUYjxKXUjTI5ERmG9Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6LqfSnzegNoZdZyMBgbTDyW56KBZF6UfbEW27HT9E8GjgGhExMXo5Jngvl+yVodmFxgevBs1kn3eCx+7+ZQxr3aHpYuOvxL6XufM7sQtUGO+Cwhy6sQKeeDtdbW8ylTmfQPC6qM18DnoAOsSMKz+9AbWnOvsUKf4LIuYBnZPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pleTIFYo; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id REqNsAwXTzs6PREqNsRYPw; Tue, 09 Jul 2024 19:41:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720546896;
	bh=xCRQ9FdghEv29HWsRbQeBsLGTuUnfGCmDM9LR32omWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pleTIFYoaqWyd+Pr6fLoKQXMRzTsdVt+kaE8c1aUWdyMsUhn1wL+yKZXCxDsNUtMF
	 dlSMDMV/4pwzNhoyIQ3ZRZPmN0DI9/Z1BJAJeDNmPJuCpXHqx9WZoWWyGj+KcPrlXj
	 Wy/8ckrgeJN+rpy98huLj4LyLtQiF3Om6QXgi58riuoCFbaruRg25avoT4Ojy8dcBo
	 PWCpOzQ/Epuzt3WW5++ENhGN2UnUu1VielyHxzg4QGXi3J6WnJs2HC4g4gAWez2Ktt
	 uQQvoUelindGlgXj0uCNmL8uMgx6PVQw64hT4xxjrwgVTyVGMnfeoeXLOqYVlINR50
	 5CYSseVscUEFA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Jul 2024 19:41:36 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: k3-ringacc: Constify struct k3_ring_ops
Date: Tue,  9 Jul 2024 19:41:29 +0200
Message-ID: <cb9dfc18cdf890afa2c53cd74b0b330d6f1c30ab.1720546863.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct k3_ring_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  17090	   3304	     32	  20426	   4fca	drivers/soc/ti/k3-ringacc.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  17266	   3144	     32	  20442	   4fda	drivers/soc/ti/k3-ringacc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/soc/ti/k3-ringacc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index fd4251d75935..8c0102968351 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -161,7 +161,7 @@ struct k3_ring {
 	struct k3_ringacc_proxy_target_regs  __iomem *proxy;
 	dma_addr_t	ring_mem_dma;
 	void		*ring_mem_virt;
-	struct k3_ring_ops *ops;
+	const struct k3_ring_ops *ops;
 	u32		size;
 	enum k3_ring_size elm_size;
 	enum k3_ring_mode mode;
@@ -268,17 +268,17 @@ static int k3_ringacc_ring_pop_mem(struct k3_ring *ring, void *elem);
 static int k3_dmaring_fwd_pop(struct k3_ring *ring, void *elem);
 static int k3_dmaring_reverse_pop(struct k3_ring *ring, void *elem);
 
-static struct k3_ring_ops k3_ring_mode_ring_ops = {
+static const struct k3_ring_ops k3_ring_mode_ring_ops = {
 		.push_tail = k3_ringacc_ring_push_mem,
 		.pop_head = k3_ringacc_ring_pop_mem,
 };
 
-static struct k3_ring_ops k3_dmaring_fwd_ops = {
+static const struct k3_ring_ops k3_dmaring_fwd_ops = {
 		.push_tail = k3_ringacc_ring_push_mem,
 		.pop_head = k3_dmaring_fwd_pop,
 };
 
-static struct k3_ring_ops k3_dmaring_reverse_ops = {
+static const struct k3_ring_ops k3_dmaring_reverse_ops = {
 		/* Reverse side of the DMA ring can only be popped by SW */
 		.pop_head = k3_dmaring_reverse_pop,
 };
@@ -288,7 +288,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_push_head_io(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem);
 
-static struct k3_ring_ops k3_ring_mode_msg_ops = {
+static const struct k3_ring_ops k3_ring_mode_msg_ops = {
 		.push_tail = k3_ringacc_ring_push_io,
 		.push_head = k3_ringacc_ring_push_head_io,
 		.pop_tail = k3_ringacc_ring_pop_tail_io,
@@ -300,7 +300,7 @@ static int k3_ringacc_ring_push_tail_proxy(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_pop_head_proxy(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_pop_tail_proxy(struct k3_ring *ring, void *elem);
 
-static struct k3_ring_ops k3_ring_mode_proxy_ops = {
+static const struct k3_ring_ops k3_ring_mode_proxy_ops = {
 		.push_tail = k3_ringacc_ring_push_tail_proxy,
 		.push_head = k3_ringacc_ring_push_head_proxy,
 		.pop_tail = k3_ringacc_ring_pop_tail_proxy,
-- 
2.45.2


