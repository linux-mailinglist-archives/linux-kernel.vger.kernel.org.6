Return-Path: <linux-kernel+bounces-428059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9A9E09A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE512825AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273C1DD0DC;
	Mon,  2 Dec 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdezXp0M"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37311632CA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159611; cv=none; b=cZX8HKsCLijk7ASI5YsyXgn2Xos153lQ0aAsPjkAkz41fsZtgb+/3DNK+c68djVPVqPWQiZR6hZj6kzH2gyHpV3EvtKS5RDpbKktJsu3U+3XLDW803RRi+/3RsPEx35/KP6Di1hPVgaTYsCaL/u10O488lYM/qZsuPyIdvR8E0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159611; c=relaxed/simple;
	bh=sZUSJMCOAWd4ueJ4NkIrPf9DmvqC2RLah+ImLTNXzHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIko7e8iwsitkbRq/Qk+JJBUr2DtIvp4XNoV5ZO74U+69E+ZB4HOZCxiLnpSRCn+UhY9X3sVOKA+b/8XCVQJm4RRguaiQyc4KdleubBrX0vV5WLbf7O23CNt4dK+FE5DGlNkPiT+CiWAhCsNliuUhRm5KYIEPbOw1KI6G7czymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdezXp0M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21578cfad81so13025835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733159609; x=1733764409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSXLTpDA/M62S+I3gxA2SYgTP4kesEn624cEHGxP9PE=;
        b=DdezXp0MY8muTeIUJSJvezzZsJkiXsayWh7VIultbiIMjt0qDm+y7+XrmSgM9PSP5Z
         WdK/2NgAystz/xpnzwcFqAkceDDa3Cz08ejh9avc4P+0Vdrw6w0VG9g2ltNwpC1gj+RB
         C1FJagWm8Z+3AAZL7RktKF3DQGwNdZscwo6GOLLkO90pvegtrRRCz2VsHZ6IUFnvfkE0
         zWNrxcRJVozVTMaOmSI3RC0Y0p5rcGFgXq1lt1DwNQ9srUj+issIAwkwxeOG/uoitZHB
         uo5bmAmOkit1FXbjqu6nc6q70kwSsLbywx9tLxiHoFh6u4scBzR2VkV2aB18SQ6eEGNN
         V9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159609; x=1733764409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSXLTpDA/M62S+I3gxA2SYgTP4kesEn624cEHGxP9PE=;
        b=E3leV5lWQtI8A5QzZgTG0/+YpwgiCP4ll2H8BNli3jrhvH2RDfaFxWPlxKzMZtWc8T
         Oa0bFYpUx++wObh0Z3MDKPBkvILRqCM3+6pTT7IReFXk2mSEV4MTe0TFmUpU8vVBlAPt
         Kig8WO1S3xls9pxRISAHCTRpuHwRusp+e/Be446XcjxOE2hZt0MnXvhlLiWNKYV94xVo
         VlWzPSGy9iHKcyisItCtd3oqvDc8KFIHWhokWV6ohwTTEIVM/mObHYAJGutgMdNvAbP3
         PoLh64LDzuF0pcWzO01TUgQ2xJE7nZNnH9gOiSSxwK9RiPbjDompE8qTdLT3Gu8Z8Blu
         jKGw==
X-Forwarded-Encrypted: i=1; AJvYcCVfcgQaaD9e118q+wigLqo62HnkFJ5XC7zSMDK6YCmcOOBTEGW04Yo9mOm5N6kunZHkO/Kh8nllh+M73F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVy1S/xVHWZVrl0dzucdTqBfOrZuFaQwha+UHdPWpv4Jt4YOX
	I1N4oRRGRJlDilA/bElaYiKPRShQO63WKqOW4m/jIbL31k+K+/fM
X-Gm-Gg: ASbGnctTewz3eCv8iwU61Dfus0BbLLCQ3gpASzGV3sxc8tguKV1EXNkxQr65A6oSbde
	Emn+H83XZr6L0FCjQMCILYlGNAEgX0evA3REbmMB6ii4TgB8+2pHpVnRm18lNEVBLrptuOPru62
	GA6P2PLOisvywlqEz3EYN/lkNFTJX6q4n/acjx7X3A18/2itZBVGCQTBp4b1ObDAYGWXdhj5XIn
	EmGUyufhyHMg2okDlorov5Nf2S8BSrrNT0bAtMlktOvIEkL9Sa9iI9eYlVMnRbZlw==
X-Google-Smtp-Source: AGHT+IFyyLkrtgvBDjiSILUMaQ69Swp9YJAshtY0HH5UUNEtNq1jezU8L8bDPPQJXsSn9Cf2tSLlxg==
X-Received: by 2002:a17:903:32cc:b0:215:7ce8:1364 with SMTP id d9443c01a7336-2157ce8163fmr86388125ad.13.1733159608660;
        Mon, 02 Dec 2024 09:13:28 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:c94c:7774:ae6d:31b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm15387425ad.255.2024.12.02.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:13:28 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: [PATCH v3] f2fs: Add check for deleted inode
Date: Mon,  2 Dec 2024 09:12:38 -0800
Message-ID: <20241202171304.5430-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v3: Correct "Fixes" line again. Sorry for my confusion.
v2: https://lore.kernel.org/linux-f2fs-devel/c0998223-6141-40e1-be08-d79bfc28eb0a@kernel.org/T/
v1: https://lore.kernel.org/all/20241124010459.23283-1-leocstone@gmail.com/T/
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ed86df343a5..65f1dc32f173 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.43.0


