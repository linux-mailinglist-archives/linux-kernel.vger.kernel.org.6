Return-Path: <linux-kernel+bounces-553222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CEBA585DE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2140B3A8AEF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27991DF745;
	Sun,  9 Mar 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NldAHH14"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED41DE880
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741538623; cv=none; b=I3xhmNoEaJN6K7Qr2oN1mQkO/dI8gOxjTE86f2Tm8Mr5fzU+hwII7igYbBt7gYy0Y73gAW35sLrG6BJJEDMyQ+SK4VMyT1QvN9I5xswWBrGFgnFgQOKs5HN0wRc5PMl/GObJ8eyk4x+rjew70Je5abjSXztczV0HFBsLAJ05LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741538623; c=relaxed/simple;
	bh=u3lFbDaSfxLs5RBx2vryQP0crfJJodis+bKxzLi1MLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z02OG43u2uGt+P/+l9IY/sLRsJpXGc+H1TzX1MuafHbCgsaGizlOA5/BY5zsNmgJnZtC85cSMu1GJtBPpqomWIIOssNTwQv3xmUR0PQBS6ikf1wyUd2jbR5c2KGGW0GWbLhpALf24i+FcbIP5+W1NgxO7gotuX7mP/ulHeGZ6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NldAHH14; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39149bccb69so106124f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741538620; x=1742143420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHXkBuZmZFlrGfeJ/m4uYp0lVYdhSJImm8UniMvvnLw=;
        b=NldAHH14g/e1btoAny+48LTwjTd5qiW1cOusx+J4SQW/mHh2x/e78YqcyYD2EE122u
         dMR47yo9WZCyWDu4y/LEg1G+pt01BHspdBxY5iBvAHilFvPaqOzH5MwGJwo0GWfHtnjl
         HJjLGtkAreIKCaGfrHJkFFd/DjOWcTrLAJFPXtI3CJvBhHH92m8UrcgmtkkEij64u60g
         uUh3yOLh9nk3Vri/jNHnXpg2LXnuWHGPVVRdOxb6eQbj6AW+MBd31Bu01Ef48dicJy47
         dHNJyjNLHAYk/I/t7UWZR1H7Kiv++XIx2UliH2f/AEPMaSSD8f/TDDSHDSLpsKfNKXcm
         y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741538620; x=1742143420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHXkBuZmZFlrGfeJ/m4uYp0lVYdhSJImm8UniMvvnLw=;
        b=uAfUPPm47VxFGMMm39ST4aYytz38K7Od7AGw5OkvaYj6OShm1O15zVvzMhjvCb1OJr
         7cdoylFs+16nH2zIoZxGX61a6d9EKqz5xtENOaa53Iz6KQEnmo7ZygxYayYgjHj6gT11
         5sNqNt1Ux+IYe7Xf1d7dmvjU3ja9q1ocgOhSwAeoblr7ASgQFf6BCq4So3W+amduh5w8
         r1hL6/TdjJ9yF8ZFwiOe3dbBDJ0SB5dZCDgodGe1XdxR2GiI+ZquuldHwQDCsOekrfKx
         Ocdzmz1qm+YBANmKLAYlNSXIM+mXX8MGSZBPvpOTnTBlqFUdywEb/VbazgCiQ3HgDz4U
         Z/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVHxF1pXeoEl3P25AF1eagVWP7eDHYGAdOO7uPxa3aXfXI0dKuBbMG/Yc2pEJeuQF3xoBAnQIU+RlfDlDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySk1ciE5FmcUG0+tb6U7DIpIk7124QKW8c8kn1zRz01piTyi3j
	oJXWcDhNV1GP5l/y218otGJ30L/G0pyduFubc6q+1mGNGg5VY8tj
X-Gm-Gg: ASbGncvZsVyszyCFfrG+bMtnGHFlylzNOSLuCyd/lRsGJ6Pdl+lc+2fMPmvmK8gnIMc
	7T29aNoUhRsXrSRJjDF42rNxGzZX3D/rVrNJ3EGWP8xb0MB0vpk1WOyBtL4Nr7w0yOcDmHbuAhw
	z+Vt49cEPcRnfa9dy+OSHb5DsaDsQC50nyxQ4LT5VCeZW6GlgcGLI/vpdJsOLc8i/zIA6rurJkk
	aa6Aww5Ts40Mh/fo+oGLayVvAKDMIxrYLUSIu8SScm/h0ADz5YDCVqP4qSRKzgoB7izTRDEGr87
	5G7m95HL0Tuxt2kAtnb+d3r3HplBkrAugklplxG2mWNX4Q==
X-Google-Smtp-Source: AGHT+IFyKUxBLZUDgMFG2/EF/TMdarKQbkjcYBNMq1ME6vdXSZxz5Pi5uDoQh4n16DYoLNiBrcSuZA==
X-Received: by 2002:a05:6000:18ac:b0:390:f1b5:e619 with SMTP id ffacd0b85a97d-39132d5ae53mr9107933f8f.31.1741538619822;
        Sun, 09 Mar 2025 09:43:39 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:64b2:9f80:ccfa:15da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceef2fb8dsm36719485e9.18.2025.03.09.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:43:39 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: miquel.raynal@bootlin.com,
	Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in dynamic address assignment
Date: Sun,  9 Mar 2025 16:43:14 +0000
Message-Id: <20250309164314.15039-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int 
however it initialises it with i3c_master_get_free_addr() which 
returns a signed int type and then attempts to check if dyn_addr is 
less than 0. Unsigned integers cannot be less than 0, so the check 
is essentially redundant. Furthermore i3c_master_get_free_addr() 
could return -ENOMEM which an unsigned int cannot store.

Fix this by capturing the return value of i3c_master_get_free_addr() 
in a signed int ‘dyn_addr_ret’. If that value is negative, return 
an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once 
we know it’s valid.

Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/i3c/master/svc-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f22fb9e75142..eea08f00d7ce 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -998,9 +998,11 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			 * filling within a few hundred nanoseconds, which is significantly
 			 * faster compared to the 64 SCL clock cycles.
 			 */
-			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
-			if (dyn_addr < 0)
+			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
+
+			if (dyn_addr_ret < 0)
 				return -ENOSPC;
+			dyn_addr = dyn_addr_ret;
 
 			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
 
-- 
2.39.5


