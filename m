Return-Path: <linux-kernel+bounces-300246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A779E95E0FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F572B21427
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2FB667;
	Sun, 25 Aug 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzvvaDat"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36C2AD15
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724558128; cv=none; b=tLaxAaq/ZMOCAVBJWyTSELe4DebeQmkV/Q+WguIscFcFGJbRzA5p3SCvCnlo7AxpnHWAVuBov6OVdOeCuwmOaQL+g9/RwcQcA0CGGrcibC5bzFFk1diMp5C+3a7SAJWbk9/8+sfICs+V5HsbCJQcf4OEJGnJsbCE9MmWhBPHhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724558128; c=relaxed/simple;
	bh=sZQOe7xHP3OjdupH2X9l9O+m1HSX2fWNk440f4gWAWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/j8YoRmchcYUtnZOdRidu0pMNZjGk1UPbiwGG98DLEiYNqxK2sQSOtBBRAd+9g1EBmzT58l7ygOKVBaPisCtW5MsPRCOO/5/fhIuahjW8uoLny/cYvfzcxs2tJWFAT+l/Mlf4rMGkRbVLD4rUKa7rkLAbzch1XwVrYryBaAKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzvvaDat; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71431524f33so2781921b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724558127; x=1725162927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Im7+BhtxW89XIZEU/f57AqCNicfD4Wbey8FFMEh3HXA=;
        b=JzvvaDatsXZQKZDywLdsHGtLIQlRW8pJ7tz/0+HPm1sm5WuJp1Dd7tc4iel0G/eaGB
         RZnfO0riF/GrFLT5O2NinuGGNmOIcLi6HreUyruMELKwxJVCeTeiusjI5ynwaN4cRZUh
         CCfZt7VvOujBhRiL93fmx3wcaO91E/gU71DNEnR8PoTpkprMdG/5F0oS/IOFLhwjcO+t
         75oRIrxvEFCBJ9nLAxzyhHNwomrCI8+R8RHlBAnddwBri9Lj7tpiQJmDOxc7boH5LfGM
         N1GSYIO3/k53lkBIgTF2FZRXrwjcSdoFB1fKrDFLVH9Tq/HBs5j2JPs1M1t/Hb8Y6kec
         7HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724558127; x=1725162927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im7+BhtxW89XIZEU/f57AqCNicfD4Wbey8FFMEh3HXA=;
        b=ZbPiSzSUTSTAwU7jWuoZAN81Inl3f8sptleDVZ/CDMHWv//Hu+TuFUftZZbSIXBAXd
         lXFTrzkprD44iT7YEzECn48r7dUsC+p2S5q2VAgpW60Fx6troLUxO9en5gxg1tjBsqHB
         vke+vXW3NpnP8mg6uUX5E5Eg3zJ9Ffj6HaIv04M1BfDBluD1r6nMrme/TmRM+KzEZguF
         SXKUSCvgdTl7xbfotYWBJ1KE0hMxkD0JpCAn5u35SJaPBQO29Q/a4CnF1eNtUofksHZ7
         VuHtUlJzPcjQVh62UFR6//JuI1wo8eSCymn8r8ljtWxT72expw6iIrSQZMNDiZ7948jD
         TdYQ==
X-Gm-Message-State: AOJu0YxpWdGHzZzN4iJ7hMHczSO0jjJF4Dl1MlL2Rcm4T8v+PIhC/4rw
	n/1Ex7NSY0JSLp0erYloF2plnoFuSY6XpStP7TiUAE6/+SrUBHsU+NPdE7PR/+0=
X-Google-Smtp-Source: AGHT+IE22uT2L7oxZJxiJ0DzouctlKhGAxVyb4UuNjbPFENilt4LXT1f9PRGUJ9QzbJ+rZNUE/HBOA==
X-Received: by 2002:a05:6a00:10cf:b0:714:380e:12b7 with SMTP id d2e1a72fcca58-7144576eeeemr9074641b3a.8.1724558126321;
        Sat, 24 Aug 2024 20:55:26 -0700 (PDT)
Received: from fedora.. ([122.180.191.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342750a0sm5260124b3a.95.2024.08.24.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 20:55:25 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: Added static to image_desc and vme_user_vma_priv struct
Date: Sun, 25 Aug 2024 09:25:14 +0530
Message-ID: <20240825035514.40095-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct image_desc and vme_user_vma_priv are used only in vme_user.c file.
Added keyword static to these struct definition to limit its scope and
potentially allow for compiler optimizations.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 5829a4141561..fe1026857710 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -88,7 +88,7 @@ static unsigned int bus_num;
 /*
  * Structure to handle image related parameters.
  */
-struct image_desc {
+static struct image_desc {
 	void *kern_buf;	/* Buffer address in kernel space */
 	dma_addr_t pci_buf;	/* Buffer address in PCI address space */
 	unsigned long long size_buf;	/* Buffer size */
@@ -114,7 +114,7 @@ static const int type[VME_DEVS] = {	MASTER_MINOR,	MASTER_MINOR,
 					CONTROL_MINOR
 				};
 
-struct vme_user_vma_priv {
+static struct vme_user_vma_priv {
 	unsigned int minor;
 	refcount_t refcnt;
 };
-- 
2.46.0


