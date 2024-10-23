Return-Path: <linux-kernel+bounces-378772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724AF9AD54C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920881C212CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1D1D174A;
	Wed, 23 Oct 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWZpMiL6"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3B1C7B6D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713879; cv=none; b=foioo7dctrqk3HraQsSQeEoRv3B5zkcfpVWDlPMPuQLznzdxSdkSc0fLTrUzDt0T/ZoaoxYREFbUzkmc/1V9pkFfAQhMKWYTjIHnzenfgIRtI6BPykR9yQkRia5hAM2aLLHqqTJeIPb6BU88Hogmr6yHJcEVC9WTn/vWYiOIbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713879; c=relaxed/simple;
	bh=NLHyTVAsvLkSf7fYgyHVBaxhH5A+j6JytRQL/AwsTLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MqTSdclZmsa4c2cgW2KM/BsgugpQOqFLEqT2C7DDzr8oj2zzUBNLeR6kpe/Nof6CDKMBnXqWbMsWbMYtZQ4W90NJ58eEH9f08eSTxK3Kjy3sOo/Qb77l/dMRBmj66jPmWUnc4bbaWQbtA1v2l3QVI+YwADNyxuowM0eQQ8WJ+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWZpMiL6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e377e4aea3so1245907b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729713877; x=1730318677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvmeCs4ivALx0RDr+VD+yfIRPn0WVf+CXAfO2vANeFE=;
        b=UWZpMiL6G5elwE872AcUe0vnZtZCfjtbe9t5mGyaDKcubglP+HlTfAOSctsxifiRMp
         QwMz+4xfq4IQOQ2nTcJIwL23lAqNf1ya96MXNffrxDzvSOc2b15cE0nkI736mVwLvc7e
         AGRQlzf+gare7Tjer78bCIi4HNCkcKX/vv7u2H0I0Fle2V+lTv6loUe/2I5uo5ZqNCZG
         wd9Lvc/1yFnVLB4Ap0j9ZYc121aSrsZ7i31d//MZdUgM+foEu0LJRJgr9o7aRwOwfnsc
         JAmhRWj2tCzb2dn3QoBK+IK0+AU+dqCP5t/EuojLtKhdz+AjvHeD8MisNB9YIybvMSh9
         a3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729713877; x=1730318677;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvmeCs4ivALx0RDr+VD+yfIRPn0WVf+CXAfO2vANeFE=;
        b=LwzD/LpPv83PaBuU+ClcWd3HjPQG5evQgKIgGOqsJhKwskoDL9G/RTGx9RRkIEIjG8
         gp99Z1vLKLfDu3A0GtXfyw+NSgoZo/o0nHLtfWkKFb0j4+AhDlEefnPL7G+nDgV74kAk
         ViCfi3ZZKlp/qbGThfIuHpg6iJgQXB9cCn2FmMkMnQe1XhxWKMOQYqNVfuL1zjlE0iU6
         3n9yezwWboJD/lp+/PLuv6PiQm3mDDyrUtp/5JvvcW1td1RnL7NwcrGpX+hbuOCG+jFK
         qCdjy0jwtDfpH1AIWQdD3lsV+btA+m2rmT83rM2kdxQVrPHfwqS/1xmi3UtChRGh6kqQ
         lwRA==
X-Gm-Message-State: AOJu0YyPNdSvQOmenc3tLoc1sJ4ORSHlCCBYZvnj0yOFWDizv+QrawIF
	VsQIRgfUE2HzxMB3ykYkKIRz7LamMMNdoQJaHwDXOk6PoYzk1l2k
X-Google-Smtp-Source: AGHT+IHRxDDgxhtbsnEFOgZDcL0Ns56DwsgxxQjM5QfYSzCmJp16RF0qvQT/5oHFpgwHrBldLkFGkg==
X-Received: by 2002:a05:690c:6281:b0:6dd:c6e1:7570 with SMTP id 00721157ae682-6e7f0fa6d89mr46310287b3.34.1729713877135;
        Wed, 23 Oct 2024 13:04:37 -0700 (PDT)
Received: from hob ([2600:1700:5af3:4510::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5adab49sm16930917b3.73.2024.10.23.13.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:04:37 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:04:39 -0500
From: Pedro Perez <pedropz1537@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: vme_bridge.h: Name function pointer
 arguments
Message-ID: <20241023150439.4a0dbc05@hob>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch names the function pointer arguments in vme_bridge
consistently with the implementations.

Signed-off-by: Pedro Perez <pedropz1537@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 56 ++++++++++++++++-----------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 9bdc41bb6602..abf880d68b12 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -128,39 +128,49 @@ struct vme_bridge {
 	struct mutex irq_mtx;
 
 	/* Slave Functions */
-	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
-			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
-	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
-			 unsigned long long, dma_addr_t, u32, u32);
+	int (*slave_get)(struct vme_slave_resource *image, int *enabled,
+			 unsigned long long *vme_base, unsigned long long *size,
+			 dma_addr_t *buf_base, u32 *aspace, u32 *cycle);
+	int (*slave_set)(struct vme_slave_resource *image, int enabled,
+			 unsigned long long vme_base, unsigned long long size,
+			 dma_addr_t buf_base, u32 aspace, u32 cycle);
 
 	/* Master Functions */
-	int (*master_get)(struct vme_master_resource *, int *, unsigned long long *,
-			  unsigned long long *, u32 *, u32 *, u32 *);
-	int (*master_set)(struct vme_master_resource *, int, unsigned long long,
-			  unsigned long long,  u32, u32, u32);
-	ssize_t (*master_read)(struct vme_master_resource *, void *, size_t, loff_t);
-	ssize_t (*master_write)(struct vme_master_resource *, void *, size_t, loff_t);
-	unsigned int (*master_rmw)(struct vme_master_resource *, unsigned int,
-				   unsigned int, unsigned int, loff_t);
+	int (*master_get)(struct vme_master_resource *image, int *enabled,
+			  unsigned long long *vme_base, unsigned long long *size,
+			  u32 *aspace, u32 *cycle, u32 *dwidth);
+	int (*master_set)(struct vme_master_resource *image, int enabled,
+			  unsigned long long vme_base, unsigned long long size,
+			  u32 aspace, u32 cycle, u32 dwidth);
+	ssize_t (*master_read)(struct vme_master_resource *image, void *buf,
+			       size_t count, loff_t offset);
+	ssize_t (*master_write)(struct vme_master_resource *image, void *buf,
+				size_t count, loff_t offset);
+	unsigned int (*master_rmw)(struct vme_master_resource *image,
+				   unsigned int mask, unsigned int compare,
+				   unsigned int swap, loff_t offset);
 
 	/* DMA Functions */
-	int (*dma_list_add)(struct vme_dma_list *, struct vme_dma_attr *,
-			    struct vme_dma_attr *, size_t);
-	int (*dma_list_exec)(struct vme_dma_list *);
-	int (*dma_list_empty)(struct vme_dma_list *);
+	int (*dma_list_add)(struct vme_dma_list *list, struct vme_dma_attr *src,
+			    struct vme_dma_attr *dest, size_t count);
+	int (*dma_list_exec)(struct vme_dma_list *list);
+	int (*dma_list_empty)(struct vme_dma_list *list);
 
 	/* Interrupt Functions */
-	void (*irq_set)(struct vme_bridge *, int, int, int);
-	int (*irq_generate)(struct vme_bridge *, int, int);
+	void (*irq_set)(struct vme_bridge *bridge, int level, int state, int sync);
+	int (*irq_generate)(struct vme_bridge *bridge, int level, int statid);
 
 	/* Location monitor functions */
-	int (*lm_set)(struct vme_lm_resource *, unsigned long long, u32, u32);
-	int (*lm_get)(struct vme_lm_resource *, unsigned long long *, u32 *, u32 *);
-	int (*lm_attach)(struct vme_lm_resource *, int, void (*callback)(void *), void *);
-	int (*lm_detach)(struct vme_lm_resource *, int);
+	int (*lm_set)(struct vme_lm_resource *lm, unsigned long long lm_base,
+		      u32 aspace, u32 cycle);
+	int (*lm_get)(struct vme_lm_resource *lm, unsigned long long *lm_base,
+		      u32 *aspace, u32 *cycle);
+	int (*lm_attach)(struct vme_lm_resource *lm, int monitor,
+			 void (*callback)(void *), void *data);
+	int (*lm_detach)(struct vme_lm_resource *lm, int monitor);
 
 	/* CR/CSR space functions */
-	int (*slot_get)(struct vme_bridge *);
+	int (*slot_get)(struct vme_bridge *bridge);
 
 	/* Bridge parent interface */
 	void *(*alloc_consistent)(struct device *dev, size_t size, dma_addr_t *dma);
-- 
2.46.1


