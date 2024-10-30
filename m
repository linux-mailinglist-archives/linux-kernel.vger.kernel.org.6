Return-Path: <linux-kernel+bounces-388767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B79B6423
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678822816C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB71EABBE;
	Wed, 30 Oct 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDNKfbfI"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F03FB31
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295134; cv=none; b=tCVlfLqoj4dmrSaaESlWczybkpnaZsSKJXCOi+3Ar8SIxpwnvbs+U0VJ4Oepe75sZ7Yd16y7fGj7uoLWsGLnbijo7YBFVIOeGtAvj4JjbmZfqqyIYAGuBQcmkn0UEfc1Nq1nxkNskw6mgenq0irEnFei6DWGy84C5MfPf3EcqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295134; c=relaxed/simple;
	bh=Re8Arxx6x5qOB4LQGkXCJaMRkFudlsmyB2e/oy/1A1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvKy94HM5AOTyuIcZCl6Zm8P7JEDlCSwIvj+wbwsRRtEbTPhq90O4LWfCAVmVo2C3PvIolJ048KFESxOP/kUphqsO9ttitfvOqRJCZwQ7FelslzrN2dZN40Lvyti45QTiSl5N8gYsIZTpKe0FYUJII9PbvLwBh+5+ulr1mXlHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDNKfbfI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15467f383so482049085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730295131; x=1730899931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ns5nWhr0PT4Sc6/u0VDcTbhfTPo6/0aZkcTxVWdIZRo=;
        b=GDNKfbfI0kLJw+J6xxVjRBvbsH8FvmKbMyo+F0CjIrY2iuu8eViipA32nK4cMjNR2u
         v7a6v/rG1K7e8cczVzVNJW5NChf+PAk5hOy1ZSQI9Wv3sAqZ3zuuK2ltqWW4kfmWpBbl
         XKpkpLOHT/JvOGnsTTr4ieNs1USk/de8Njjyo3u745AgvsH+ox1rfP6KlHv683/MuRb5
         1sl5hCPWWgEgAcx7qokhL5WOi4Ls8fs+ZXBye0YWYYixX99DdG3ymsQdt71hdqqiLLep
         elBRTEyryTDWuJCLdOhX2tpy/c0mtjP+xRpSuUAr0nVchaCHjyjQ+/dwgPiDiddjipT9
         +ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295131; x=1730899931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns5nWhr0PT4Sc6/u0VDcTbhfTPo6/0aZkcTxVWdIZRo=;
        b=OZSMFpahKBJArQ+2IVgCrSrRPjiWmAS52/DnFnf8uOnVswzbcxi98q8PwsLXEXqLuT
         quuGIK4o/JWoBuE5/QJAy8Vm5tVKnoEofaG5DbQA1drwJcyQ0VbfsYzo+l+5zif/YsbX
         ftV3En/n/lzuito/qTE0/O/D+aPcw7MT8ThyBnWOjn0gkzG/MgDs0zQhlCfO9an5xPlA
         pVVMW7hToCP31Cb9VwAXL9uqNFfEdmqQSNs+cWOnntSsAiZnLQFnYizqrTbPqt0Eb491
         OAI3Mf68Xcm2K+dcViuIBjGi3wC2L3Bnm6xr0fJujCiNrBHj1lHDQ0L4qExwZmO9xmng
         DezA==
X-Forwarded-Encrypted: i=1; AJvYcCXhxfOwY242QMHvbE49UiZmdd7uyRaYT7WdqTQy+sBP0RMqJh4TDfaDirF+sJNRULOrvw//fqoHNrafUyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jLNDg3KPiFXpPolMWVkXIhd2wJfdb0FPRrVrKj1l23QLa0Wp
	UmnEjNMpF+FFfraLskclPZNVQoWKXJ0l12mJpTKrZqGpUfEHD4B+
X-Google-Smtp-Source: AGHT+IHDeLO3HDuzQWG5QFgMmTLs8z3uetA7y8Qy6YtIjbeSmpntV0NS1nysmvuJx6ZNotSlChVO1w==
X-Received: by 2002:a05:620a:3182:b0:7b1:3754:7d82 with SMTP id af79cd13be357-7b193f74527mr2102137485a.66.1730295131265;
        Wed, 30 Oct 2024 06:32:11 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (dhcp-213-15-2-159.pbband.net. [159.2.15.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2aab9csm513495785a.61.2024.10.30.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:32:10 -0700 (PDT)
From: Marc Dionne <marc.c.dionne@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v3] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
Date: Wed, 30 Oct 2024 10:32:08 -0300
Message-ID: <20241030133208.41061-1-marc.c.dionne@gmail.com>
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
index cfaeaea71042..bf770101929a 100644
--- a/tools/mm/slabinfo.c
+++ b/tools/mm/slabinfo.c
@@ -21,7 +21,7 @@
 #include <regex.h>
 #include <errno.h>
 
-#define MAX_SLABS 500
+#define MAX_SLABS 2000
 #define MAX_ALIASES 500
 #define MAX_NODES 1024
 
@@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
 				p--;
 			alias->ref = strdup(p);
 			alias++;
+			if (alias - aliasinfo == MAX_ALIASES)
+				fatal("Too many aliases\n");
 			break;
 		   case DT_DIR:
 			if (chdir(de->d_name))
@@ -1301,6 +1303,8 @@ static void read_slab_dir(void)
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
+			if (slab - slabinfo == MAX_SLABS)
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


