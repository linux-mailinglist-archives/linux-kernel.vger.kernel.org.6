Return-Path: <linux-kernel+bounces-355748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA59995664
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9251288A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E8212EE8;
	Tue,  8 Oct 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLcfD5Gf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52635212D38
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411862; cv=none; b=ATZ794VKfQgleE4n8KmsPlvLK7+PJ6MWyY9ahmil+yIqkPCvv7aTCTAz7HIYMnpnsVOtm/Aluv84M1AEEqi4iocu7JQdZSvvYEIqbpjtwLGra0WygPq7y+jSJZkyDVzZ0cEmn8mZiMcYUF+3c8o2CkW2XLN0irceZSIj399K4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411862; c=relaxed/simple;
	bh=rLjkqqec3xpR1frr9NDKk6gRLk94gdypxDmkrUEViws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Df2fkqL86Ub+0I8fUjaVBnpx/DhGwW1o3dhUZ3d5WSnQfBgos3frqrkPvEa1IkgxZg26AqvVux80MHQiEEbpbaeUmNNK6/XK4o49/jIyJpVRE+6w1leD3uBAWh++DU7DFI85xI4Eny55FCzcGlKdleczPEUG+7WTc12hejiEjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLcfD5Gf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2916a92ffso578816a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728411860; x=1729016660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrvlWnwoFV3e2edxctMJRWd6D69IO32Lv18UF7a4HnQ=;
        b=SLcfD5Gfp+c686H24nYnKw1SGC9cSwmi4mlV8n3Gy46KIRmCNdrYelE/kkzJZmBvz9
         zp/cMcTKaUyrZ2/1oSzzLPenbvuxS5aFEbUkeMaTyqFLgDrgOWtnlaffv06lHoEoDakX
         JVFJ//d6o+Fefhr3OGZKqQ67wmfJd1fkoluN7GCV4ww8ZvzZbdTV4lT2EVyIrqToxoGI
         pGpQnNTqw9UEPd13eQ0aUZ34kWF9Ntr3hBtQBbJKphTymfgyYACdQ6A2PjYdESSQa1mY
         41OxF46EwKcswCpLc6X037IP2UpV5qnfNQfNNPrEJKGcOJyILSAmql/SLZaikB1TLf+F
         gsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411860; x=1729016660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrvlWnwoFV3e2edxctMJRWd6D69IO32Lv18UF7a4HnQ=;
        b=eK/XVg2DzHV5229eKwyloc8qWaJgcY/BzqSUrNZkC0H0DRL7pPSdi37i8iaLlBi7xH
         MgXfMLjg3B7lHEWAtyHOPMTS64ON+tpq82GEOZWjcxL/LJ8rFfMR2es50Uxeyn4w0v5M
         8XkT6F3nNifgUejYegVHvqYzImcMMT6YniiYQUBNHmwO642BgVleNhzyfiWPdnGLNJ3L
         r644NXUb5JkfO6Uf0K/CikUV9CnouxtQTkj7+2vxW45jxYs5NP8G/Vv5FDa9NjTCvSKv
         AVKDNOUcaAVwoC0Qmyai3Cl9Gz2cwoAm84gLNGha0h5VbIdeBQUWrRgyZIme0nGm18wy
         IHXw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNJBsQS+GZCekXs0PujzbGR/YdUKnsfrVyoLVolP0F7pVUeQ+lrAgbumWPDTItr1AqGn4maIRIUwBkIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/UCrnIOLmWfpx4aMxVuojla3o2z6hOggojNfDZkdeFihdj3X
	K9sHuC+jlHHzmhr4q68HkX1zwIX0qMEmyZwtNGbYTaHWjVNvaZ/ctc7fbg==
X-Google-Smtp-Source: AGHT+IFrC1BOX5fq3fT9GY+B4e+w7fOfAwRzhd364zGbc1qa8ApU9IGR03UBDYTaiaQwO53RvLNhGg==
X-Received: by 2002:a17:90a:e593:b0:2c8:6bfa:bbf1 with SMTP id 98e67ed59e1d1-2e1e626bbd4mr21589884a91.23.1728411860513;
        Tue, 08 Oct 2024 11:24:20 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:11a4:8d8a:9e8f:54c2:bf8d:2f83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c8fd1sm9712450a91.18.2024.10.08.11.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:24:20 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: dwmw2@infradead.org,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: [PATCH] fs: jffs2: Fix inconsistent indentation in jffs2_mark_node_obsolete
Date: Tue,  8 Oct 2024 23:54:11 +0530
Message-Id: <20241008182411.30387-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Fix the indentation to ensure consistent code style and improve
readability, and to fix this warnings:
fs/jffs2/nodemgmt.c:635 jffs2_mark_node_obsolete() warn: inconsistent
indenting
fs/jffs2/nodemgmt.c:646 jffs2_mark_node_obsolete() warn: inconsistent
indenting

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 fs/jffs2/nodemgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index bbab2bdc7..cc51c85ef 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -630,8 +630,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 					  ref->flash_offset, jeb->used_size);
 			BUG();
 		})
-			jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
-				  ref_offset(ref), freed_len);
+		jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
+				ref_offset(ref), freed_len);
 		jeb->unchecked_size -= freed_len;
 		c->unchecked_size -= freed_len;
 	} else {
@@ -641,8 +641,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
 					  ref->flash_offset, jeb->used_size);
 			BUG();
 		})
-			jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
-				  ref_offset(ref), freed_len);
+		jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
+				ref_offset(ref), freed_len);
 		jeb->used_size -= freed_len;
 		c->used_size -= freed_len;
 	}
-- 
2.34.1


