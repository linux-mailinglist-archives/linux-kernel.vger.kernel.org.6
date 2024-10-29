Return-Path: <linux-kernel+bounces-387285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAF9B4F05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B734B2113D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48D197556;
	Tue, 29 Oct 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeeLN7hJ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E1194AD1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218425; cv=none; b=ra5VhhUmpc7sLPBiCwP4f+InVT3v3Wr/Kh+u03XpdMVPN7jLoYTB56eRjBconcxxsg/sNw8vVBAjWkKVZK2qLsXZYStJ3209Oh60nLvf+ofIxeoEWEfXK03zVAO7iO3EmdpeV7/sTRV3z9+SLaJUJbWduxCJHsLTQY/VN2jj42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218425; c=relaxed/simple;
	bh=iLIilpBbdjZuHy4yM23fRAZN8JGrVIK5E1rXk4xgmgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGYgqxykNNq6waX3ABKXQnwcuEDVZiLxg/YqoNxKwVO7Dt5QB0RrYxFrwN4UcW0Ly7GRF3lOnL6LyJMXO803NE9Yuh8FbH/vDrurrn1ogcMuMhMA+RSIVkoG9FBxStPVX87iG3j/Pcx2wm4mg/vUQ6BUCoTaBQGdf9AC9hJHW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeeLN7hJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1467af9dbso449480085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218422; x=1730823222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/+rVpMU3LGFLQSvsBt+1W5qp/kMGu20FPFZx0ofHIA=;
        b=CeeLN7hJxMlyKOHspMNHx4rfsnByfGCDtq3az/WUOcZlbeezgR8f1hFcBw6e72lGjg
         JjaZC577T06qq2aEGkxgkloWSTSDDYyt11/CZg5vLhg49reClIHR6JPHtbqLhd2CK6c8
         WDLP2xWJIky7XhaqRyfGS4yeUS7gE4wkG/7lNvYzM+moHsnfr/J0lkRqBle45AcTf/VQ
         PcaNh/YgR6HZE9PYyIpDWh+mRcmJ5tQYYDHDPID5jwcxHT6xXNO+KWy59YQVrWkk4Ghd
         0hDvXFYJhNLn+7HqOJV6VtGaCf+3VlXE0X8tGd573bx7WpPyhnEUQnXv/k1gPfc7qUlz
         GJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218422; x=1730823222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/+rVpMU3LGFLQSvsBt+1W5qp/kMGu20FPFZx0ofHIA=;
        b=c+qy9V/0BnRm+wBZdh5fXP2EkDMcutRZTAJCU8yWnQMBvWyCWs3LXwdQkwGPPZtn9S
         IIs9sWaCGSDa0lq83JbY16iEy4WZ6+cwSZsh+m/CA7Uyo6xL0YlSBMS2ESi6f1JQB3+n
         zFwXk3rCT7KlDS/AJDF3fDLDfLDDZXyQj7hYrweIqlK1k36fdXmdnm1e4hrhPpwJL0Eb
         +WsS2BbIKzoIwwdEQZsqtzEJhC/X7ekfJW++XxbeODhgYeknVnnQkeciPAVXCRHj5TvS
         6iXaR8YllXh4ngC003tVpbX6NVY7erBdLsolpXuKdMx8fwULo4dCByZHLqyToC7GdYCj
         MHdg==
X-Forwarded-Encrypted: i=1; AJvYcCV/a/IrgQFMC+5llOxwZJUR0EwKs03ix7w5dD3FJHpweJp3UIn7U20itBLr596QLkhDOa1UqBf1LaD1MOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQo6O5dimM59DRsFUND2vOWFw2u4qZ0wmaEAUNv0TQMVNml0RK
	d40+6oiajD7rHyWG4gyUsv9+JcEFI3Gm5+Wy3FJhbY2BoBFUjkiSuy7Fb/Vd
X-Google-Smtp-Source: AGHT+IGrgqBvYt59b34IHtFVMfSaUoubxtwBkyNT463/rxysr1T9JgF2E31yqnXXOWqx3YO32LK43w==
X-Received: by 2002:a05:620a:170c:b0:7b1:880c:57fa with SMTP id af79cd13be357-7b1aee4b8a3mr17150285a.52.1730218422576;
        Tue, 29 Oct 2024 09:13:42 -0700 (PDT)
Received: from hemlock.fiveisland.rocks (dhcp-213-15-2-159.pbband.net. [159.2.15.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d359411sm424685185a.130.2024.10.29.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 09:13:42 -0700 (PDT)
From: Marc Dionne <marc.c.dionne@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH v2] tools/mm: Fix slabinfo crash when MAX_SLABS is exceeded
Date: Tue, 29 Oct 2024 13:13:41 -0300
Message-ID: <20241029161341.14063-1-marc.c.dionne@gmail.com>
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
index cfaeaea71042..2e0a1890dbbe 100644
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
+			if (alias - aliasinfo > MAX_ALIASES)
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


