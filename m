Return-Path: <linux-kernel+bounces-402568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE49C291F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DC9B22A87
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFC1802B;
	Sat,  9 Nov 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="GiyvBhg4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311A18C36
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115737; cv=none; b=EyEx9+v4NgSo/J9MtIJZ5xzQd2xFLB+IiaAJ2zBhSTDKXeEV0yLktS7x2YsRq3uflOE2oZoNDM3T0VtE84p5JwnJ/SkNiwQTMLfVYoswKKFIP1QTntDDL8NVvvmBToJLSDPx+HFTHyvBabz60NKwJmICx+/xjE/9bmE5uRqkLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115737; c=relaxed/simple;
	bh=U4/39m1wSnM6NEKJmtt/qupJOrq3/D+YkHzzTDlhxIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb0guesAexEv2GpKz1f9RHCdj3lNVW9MlKJWT6+Uy+5JyKVX6TbQ2MdCwXxXephnUYv6POKDRBCq1HdZp/+UCaLix7xlmizTmwCnwRTyNKYCQZiQvxOqrk5AvL2SPCvVcgeAwU336ACmJbti7/UZTI1xVglXKndQusFpzHUIKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=GiyvBhg4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c83c2e967so2052865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115736; x=1731720536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JQhJjVLe/b9J3jK6ApFcepDaYbpXUd3aMShB4aDox4=;
        b=GiyvBhg4DWVWTHZf2VGtIgqWYyCAKimbPYxH7LjPXINyntoKf1QIWMv/Dvvg45aKtX
         QJhk1UrRTsnPk5nzJUrcKMzfhStyl3yoqOhvZiP1wrBKZVV7RXhEAW55N09WA662DYNy
         M5m7YL0f9oF2ju7fYgKaCMU44N1T0TBezqqwMWPYQtYqOfENfmQck544h66v2p2bOD26
         fht5MBIf9/qzauxor3SKhAJAxZlzLDxe7S4ONw3+ctQkmjgvQ3bRtkEEVAufUN/YG4QQ
         Cg/1dJOqjF0Pv5vqcX0wM0Svyfxv0r8StvPHk/BlALPMRYOyWx1Bbo+Aw8IZxqvUcKRJ
         uobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115736; x=1731720536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JQhJjVLe/b9J3jK6ApFcepDaYbpXUd3aMShB4aDox4=;
        b=IJ+i8qDKl/cg2EM4KjQ8zdf9IrJTLrd5JGgPj1r9oyMAkMmuFpEp/3YNyzyuDyhfPK
         VeebYI1eDZS6TH1DqSAQBb4YrZHWiVFATbZlMOlLckzyyhYAx5w+odLbt1/h7a8t7LOy
         T7e59GEuW+BHCm5rlOA4hlEIoAlBkF2QmAsCr1bldo8Z+rk65s8qgRdvsOdVTgciWd1a
         OMvHZnfGmU0sLDi+WxoiGHUGzzciq2DHqKTCqyn8TaEoWV3f96X2jrIKkbPSesxPYpoC
         P56Lx1o1KFdhQkTkmcz1SukgIioUfSdqowqvjXux2zEjmU+lFiHoMK7TIF7OdtlseKIX
         N4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXZfA4xuWrAT1AFrPnIRhhtF3V1Mg7lZNkyuiMOK0GWkGtBR53BhpiFU2nvguO6ZP2Q2fTeBvmKNVZAPSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIWDJbbcRTSqXHjTjxTbHo3zrc9anqKjJKn5fKt++xk7CFLes
	+1/+BXEOUHE7/Nt/jiSiYlqO2/+Tvgs4gB34qJs1efDNZ7+oLTayuroVqHfUXaY=
X-Google-Smtp-Source: AGHT+IFKg+q7iegnZHiSf+idYwfgc2LKuVrDKq4p8WHgcGx0frkz7U7cZpi6uSNtCUvntKMxtTgqog==
X-Received: by 2002:a17:902:d4cd:b0:20c:da9a:d5b9 with SMTP id d9443c01a7336-211835107c0mr29325685ad.5.1731115735628;
        Fri, 08 Nov 2024 17:28:55 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:54 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] proc/kcore: mark proc entry as permanent
Date: Fri,  8 Nov 2024 17:28:39 -0800
Message-ID: <60873e6afcfda3f08d0456f19e4733612afcf134.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

drgn reads from /proc/kcore to debug the running kernel. For many drgn
scripts, /proc/kcore is actually a bottleneck.

use_pde() and unuse_pde() in prog_reg_read() show up hot in profiles.
Since the entry for /proc/kcore can never be removed, this is useless
overhead that can be trivially avoided by marking the entry as
permanent.

In my benchmark, this reduces the time per read by about 20 nanoseconds,
from 235 nanoseconds per read to 215.

Link: https://github.com/osandov/drgn/issues/106
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 51446c59388f..770e4e57f445 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -662,6 +662,7 @@ static int release_kcore(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops kcore_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
 	.proc_release	= release_kcore,
-- 
2.47.0


