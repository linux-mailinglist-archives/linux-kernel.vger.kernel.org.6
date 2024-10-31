Return-Path: <linux-kernel+bounces-390382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D69B7921
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ED41F2265E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B1199E9F;
	Thu, 31 Oct 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD45STXZ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE613A25F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372140; cv=none; b=D/3kC7mIrXLoanSGV/Q2QyMOqp6A7HZFTMRKOyvPQ1fT6nEaCcCkHKh+tNdd6mW5WqgfdXmryMD3B781Uw3ZtYMlD0YAS4GOpCL9tydaIhWbOVQ6sFnjlEEqp2xw27HtrmqQiU0oyQk1WL9E8MIDERCDVDZq/lFQISfWqxQjbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372140; c=relaxed/simple;
	bh=I2kWhSn8aENuSjRYLbfTtVZqAafY2D3IXG9eCyhkJHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSBIhO53x6ER6cV1KAjaaIxtXQMrEd8f1NiNJB5HbbNXgCEpF8lQ+q1gYeq2Mt9mVvYF7fFzVJRBLoTEld5vgUmmFuPDLPU5gCWPu0lPOgYf44nbhAwmf7KTzZggmTGosJOhwrnSsgT/1fu7u2Ve5B44w+E7/wBd2XuekLqQwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD45STXZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea4add8a5fso7438477b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730372137; x=1730976937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHNRb+kQOoIzK3RlYlUwYxMLFnjUn6/EMjgF1j51zD8=;
        b=BD45STXZlKfld/tGPeOWk5hU6ablzJchrRkqni+88D3pJ1ZAUUYdjfLXy67JMXFMcU
         dvX5yd10bj9YajlHAtcaN8JalAIz4U6Y2JVlyI1CNmGlPc+rLNqpUFVLKOZHfCCG44h4
         AF9669qvDi1gHmNpCTx9KmFSErHnEpKeVabd9wgofg3okgsA/7VoN6e+UF+JniVUFpIZ
         ENxfr84BJTe5ve3Or/fgn+PpHDiIDMrI/XKsWcU4gp3pISh0IY+fmGOZXTOv7HLC0eAl
         rEeIPoz8PIVDANMwSHiQfruvzwnlpF4QOsaBBNF17hMjjI/XcRVZlqi7UUYbaDTLCskz
         /bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372137; x=1730976937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHNRb+kQOoIzK3RlYlUwYxMLFnjUn6/EMjgF1j51zD8=;
        b=eXoDJA4wcGcuyq0YKd7ps4e4sCbMCQZmt/5kfCMzZCcV+D86k3thu4Bj5InM2AGguJ
         nE2A3zEMgvOOZLIEr8W1cDlpp+RMB2oJfHp+tb0gUU1rDdg9qnKVHWRwmPFEyNvusTdu
         aB8DJFxhwxossig0syJYODMwNEfMlpLm8FA8x17SaI852pBZHc+1Y5qcfbaYTO8P1OFE
         JuN886uhYis6q07AtSbh9KjLflqc7XMt+778IOLrlT4DY/FG88aZTMu+CnvNejpF+X5s
         +NlyeIrfLSzzQBYTtcAecyAbGX2VNzpoze6afX6ibFNwshKxctb/PBu/c436IXCUEl8h
         9zAw==
X-Forwarded-Encrypted: i=1; AJvYcCWNj3ClgAZfLE41IXDusvCVlcYbXJQy+2EtkC8J2p1Cyl+oPjewyav3pPgalk7itqWI2UCy6+mtMJbblVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVczR0Mp8sWDedGFDUKUV5+6PzfDkJT0p1zpNCoxQLsyC1ryK
	Uhm9CF+JHSX4Hc48gELCpEo8vrSsQDgBoepbf38U+SQMzBuoqlrs
X-Google-Smtp-Source: AGHT+IEkuvKipKcZUa/w/oJLu7XXuSvnRybQdKUGtgrHvr1s3fNV5JdwZUYSaRSJ6dd/HO8FSlWZmQ==
X-Received: by 2002:a05:690c:4c01:b0:6e3:14b0:ff86 with SMTP id 00721157ae682-6ea524e28c9mr27632317b3.27.1730372137224;
        Thu, 31 Oct 2024 03:55:37 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (dhcp-213-15-2-159.pbband.net. [159.2.15.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9f201sm6618476d6.16.2024.10.31.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 03:55:36 -0700 (PDT)
From: Marc Dionne <marc.c.dionne@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v4] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
Date: Thu, 31 Oct 2024 07:55:34 -0300
Message-ID: <20241031105534.565533-1-marc.c.dionne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Dionne <marc.dionne@auristor.com>

The number of slabs can easily exceed the hard coded MAX_SLABS in the
slabinfo tool, causing it to overwrite memory and crash.

Increase the value of MAX_SLABS, and check if that has been exceeded for
each new slab, instead of at the end when it's already too late.  Also
move the check for MAX_ALIASES into the loop body.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
---
 tools/mm/slabinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
index cfaeaea71042..1a9b807a48c3 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -21,7 +21,7 @@
 #include <regex.h>
 #include <errno.h>
 
-#define MAX_SLABS 500
+#define MAX_SLABS 2000
 #define MAX_ALIASES 500
 #define MAX_NODES 1024
 
@@ -1228,6 +1228,8 @@ static void read_slab_dir(void)
 				continue;
 		switch (de->d_type) {
 		   case DT_LNK:
+			if (alias - aliasinfo == MAX_ALIASES)
+				fatal("Too many aliases\n");
 			alias->name = strdup(de->d_name);
 			count = readlink(de->d_name, buffer, sizeof(buffer)-1);
 
@@ -1242,6 +1244,8 @@ static void read_slab_dir(void)
 			alias++;
 			break;
 		   case DT_DIR:
+			if (slab - slabinfo == MAX_SLABS)
+				fatal("Too many slabs\n");
 			if (chdir(de->d_name))
 				fatal("Unable to access slab %s\n", slab->name);
 			slab->name = strdup(de->d_name);
@@ -1310,10 +1314,6 @@ static void read_slab_dir(void)
 	slabs = slab - slabinfo;
 	actual_slabs = slabs;
 	aliases = alias - aliasinfo;
-	if (slabs > MAX_SLABS)
-		fatal("Too many slabs\n");
-	if (aliases > MAX_ALIASES)
-		fatal("Too many aliases\n");
 }
 
 static void output_slabs(void)
-- 
2.47.0


