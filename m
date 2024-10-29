Return-Path: <linux-kernel+bounces-387275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EAE9B4EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB9F1C22674
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549F196D9D;
	Tue, 29 Oct 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQBBPzPt"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3819750B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217976; cv=none; b=jp7sOvkPeodXvU3ap8iSPCzA2yRNCe0wamyG0Pc7F0sksBOpJSmTE8hg2qZGA/wu/Am4tDuemCq0qp9PWWdi4QTt0h4dhBG0q4sHO535IIgU5Tib2kC5jUyfbbykXl7xE0om/PrkJcH6sIiaj/lHh3oe79VbU5iQGq3GvYWguyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217976; c=relaxed/simple;
	bh=JHYXYO4Ar0m5AmXnfS+OxQcWUjgEryu7uzk0O80IwGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZr41PqVPcPuo7l2ClG0TxC2YGrUIrbkqXt0T9GI99rfdI6VMokMUEkte3GuoyeZ1B9JU3uYQjaoC9wzI0l0AudbftGHpEG1Rrt8C0TKP3p6xpyi+amHKXBiEXCZKm1hRuPqy2cqaQHRqGW4otY22ZfVMukge5lIq7kp1IBxxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQBBPzPt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46090640f0cso46751811cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730217973; x=1730822773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxqDfsTZfxgb3cilRe8hoCrBEVjF1sBAyNYF4pj84bA=;
        b=HQBBPzPtvKiSEcLnGlm+u5w8ESEIXxojp6vOdQYn0URQSmXBvVSDzUZ6diQMRDdUBY
         fE59lVVvfiuMyHOqXM4GQgPMSmR0OUAvfr5bYF3Ze6FqpdH+3OTU3ZJ/8y78fGKn1Q6S
         imy5TnvTgoa+mCb43DQ3lpnYCx5/C66eUoMUTPHHN6EAvr4HNlYi0fxB48eX7q1DlA8W
         ZFkqW7BlGx4NHNgk/vbg7QvuQcc0cO4sNJdIRrS0/fJCPD76IlQPcdFA696SygxX4gwp
         Bd4ov+W/9+D976ypXrTYFGmWPBG6RHPANFJRNOtlUt/Sm3gSX8MJof9z0VJp6MrAEmyh
         v7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217973; x=1730822773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxqDfsTZfxgb3cilRe8hoCrBEVjF1sBAyNYF4pj84bA=;
        b=naRAeFUoIOert4MyvSCiik0LQ++mx2S5eJY20TDGbDDnzwRaHBi+ju3x1I6HASEPsA
         Rk+U7nBf7UoNavU0fSoH+29/zsvb4euCqn/Ji2fyJikhVRsdtt26YsaQXq6DVhaCl6mB
         /FjQPBOpoHfEOMURYndbBOiymYqKAci9QfPsPCRHClZRXJDT8+qx7KnITsdl853s3qXh
         WSP1QYNYFkXlgiWiWdf+SpnzVv6Y6eyAeOa0gobc+Oz8KbEr4gnhNHfemCNvXQbLNtjM
         jykIZVZYbOAnobEYY/0ZAeXv+NQ7eGCw4s16PJJngbyHDg79hR9dbJz+YqwW8LszwV3J
         gx/A==
X-Forwarded-Encrypted: i=1; AJvYcCUi5fVW/PrGD/wQ0eddikVImFc7YQp7y4aW+OP6+xvMCZJeh1J32GAdsruAmvpr5lbs4moumsCmgEGnFic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChIQwAkLb9xuPhVv97xdwn2duCkqGgWk5sOWTIOWMZjOoUbye
	fsRk1PI/cS5krvK+pbjeds2lmVXrqwTdgsBKkxnyz1oNaFAdkNtA5U/Ewg==
X-Google-Smtp-Source: AGHT+IE/qbLC9OX8BeHdYRbXF0ot9ym22z0B2Ed7vUvRq09Q1GEpYyHNEHqdaG9BO5Ed5KamyQVKow==
X-Received: by 2002:a05:6214:5404:b0:6cd:faea:9f78 with SMTP id 6a1803df08f44-6d1856bf3e7mr214160526d6.12.1730217971752;
        Tue, 29 Oct 2024 09:06:11 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (dhcp-213-15-2-159.pbband.net. [159.2.15.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2b208sm43280476d6.111.2024.10.29.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:06:11 -0700 (PDT)
From: Marc Dionne <marc.c.dionne@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
Date: Tue, 29 Oct 2024 13:06:09 -0300
Message-ID: <20241029160609.13725-1-marc.c.dionne@gmail.com>
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
index cfaeaea71042..2c9c86d677ed 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -21,7 +21,7 @@
 #include <regex.h>
 #include <errno.h>
 
-#define MAX_SLABS 500
+#define MAX_SLABS 1000
 #define MAX_ALIASES 500
 #define MAX_NODES 1024
 
@@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
 				p--;
 			alias->ref = strdup(p);
 			alias++;
+			if (aliases > MAX_ALIASES)
+				fatal("Too many aliases\n");
 			break;
 		   case DT_DIR:
 			if (chdir(de->d_name))
@@ -1301,6 +1303,8 @@ static void read_slab_dir(void)
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
+			if (slab - slabinfo > MAX_SLABS)
+				fatal("Too many slabs\n");
 			break;
 		   default :
 			fatal("Unknown file type %lx\n", de->d_type);
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


