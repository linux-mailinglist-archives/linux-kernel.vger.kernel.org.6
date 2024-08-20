Return-Path: <linux-kernel+bounces-293108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD6957ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0E1C230C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C4175A6;
	Tue, 20 Aug 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwAJEiPu"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E1B657
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116949; cv=none; b=aCI8XVg66RALv6i5qghA09JNFzeeib9dFCfzbxVaxyULhOqNrUi6fIeMpgPWoy3UCdue+3GaJyZfJ1o/wYUt76bA6pUYWgN58DlwFsCdO/ZDsRIHs8vZHSB51Z/b2z+2M0oYIfbcajzO3z7xBtlZzp8lLyyAcbu93AjHIUpSL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116949; c=relaxed/simple;
	bh=nnbDVBr+zqffuUc5l4B6rJDkZdmLgcVx+nBpY84gAhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CTsyP9BBtjoHI/GL6LJzVkBcwzwRL6DYxDn74PggSNDzHVAiEDltK8MUF4l8dD3Lkza1wFT039Y97TgucD5qe7exHKf3xnpF1/xLN8l9Hm3OQc/HLsqWBISo6SQT+iYmifvuq5cCViFAjnXKpThomQtAdijX58z+cBnZXf+4P4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwAJEiPu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so6754040a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116946; x=1724721746; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mUATixxdq33VSvfaBNqqUsP8DZlp66vJtGsDHyEY9Y=;
        b=gwAJEiPuoi3pOlSe2stizGQF1METKZwyEmcg/cIwSV6Ho2OGhYglMKzzcSIisjehkj
         fZK31nDkmbuTwDJguXkfkOL9VWV0MYVYlr0awnljbA5a65iZ2n2FSv5RqZ+BTpEJP+kc
         /drOJKoLTz4+C/rFqopkIhsYv1p9XhtJkqluNBh/bbSnWpxRFG/Rt1cmooPSoCQOSQvO
         wQY47IghrcAj2GYmbS7sVJHMQ0dozQFq97uBVf5QiSrYq12MTLaWB59+I+IcOl/Gtl1T
         Jk3SDBKLVM3AfCbn0KY6uYe1AGv+wEORJLHDSEVjWReXSwbqxkVnoOsHgpV547Lu519g
         o9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116946; x=1724721746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mUATixxdq33VSvfaBNqqUsP8DZlp66vJtGsDHyEY9Y=;
        b=cbC17GdJf4GkM0KM9sRZebT0Qi62vrFOG9UoKXuTM5mqiBzY6OtIJNrE6nogFMKQiX
         fp8pqgB18+onzjXgGFLZdrZ8a62GmE/9OlV5PYrwT23FhM9t1OUbGA83P3ucnuVMKFXb
         bsLQdEwPhrsXFecKwJxqLnmPb3GmD6lWj8/JNnltOFbUpji7g+KSNQ3fhDFZXso+lz65
         dS9OT6jjV/sG0lru9VvNAc5cxVIviFEEJixx+bUDwqC8M6XaaCPL5kAeYJ1MIIQ6dn+x
         gCfW3+5qHRl4F3WcvvtCb+Bjq7QQBvIc+de6YhrMSH+t3OSes/295Nw8b0/5I7lMAfif
         lBww==
X-Forwarded-Encrypted: i=1; AJvYcCVu88Lr1eohTmPO2/aIzNxQlEnD9Q0Yd7PNW1W/mH8vGjJDha3E9NcUJJBXFv7InsZTitUPXMkp/MlhBr0uTS/gP/xJrPRhYg/crUdF
X-Gm-Message-State: AOJu0YyO909eIYpdN+URvKc0vs6n0eO/cTLOx8Lx3muvTNN6X27CjuXb
	8r8F3F95Xmdjo9udM5pGwppNtJ8LZT0SPbJ517ICNg0kZZ+N5VW1f5DKEQ==
X-Google-Smtp-Source: AGHT+IEBTOKoW9zicq24+Fr5+Y8S2974Ig1rcqM5vCHBuaLcrRnuEqm8ucueWKsvneiaAk4RYuPixA==
X-Received: by 2002:a05:6402:3805:b0:5be:db8a:7f58 with SMTP id 4fb4d7f45d1cf-5bf0ac5d461mr1116106a12.19.1724116946154;
        Mon, 19 Aug 2024 18:22:26 -0700 (PDT)
Received: from hostname ([2a02:c7c:6696:8300:44d8:63fa:6beb:ff38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe5a74sm6164618a12.16.2024.08.19.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:22:25 -0700 (PDT)
Date: Tue, 20 Aug 2024 02:22:09 +0100
From: qasdev <qasdev00@gmail.com>
To: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
Message-ID: <ZsPvwQAXd5R/jNY+@hostname>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch addresses a shift-out-of-bounds error in the
ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
by an invalid s_clustersize_bits value (e.g., 1548), which caused the
expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
to exceed the limits of a 32-bit integer,
leading to an out-of-bounds shift.

Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/ocfs2/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index afee70125ae3..b704983b2112 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2357,8 +2357,8 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			     (unsigned long long)bh->b_blocknr);
 		} else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
 			    le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
-			mlog(ML_ERROR, "bad cluster size found: %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
+			mlog(ML_ERROR, "bad cluster size bit found: %u\n",
+			     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
 		} else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {
 			mlog(ML_ERROR, "bad root_blkno: 0\n");
 		} else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {
-- 
2.30.2

