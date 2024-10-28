Return-Path: <linux-kernel+bounces-385592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AED9B3926
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6418B1C215A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1E1DF966;
	Mon, 28 Oct 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPeHdkvb"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7743186616
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140156; cv=none; b=E7mtz8uowKaonyYaC8wRbF0RL4DvQWpMpqzqmqKO2mEZBj23L9OUQeD+/7KlT3ESLxtBaP7HXPxN6bDI9Blxm22oQR9qcwCjWHyYw6taDG/4v4RWECytOxwJfRg2ns8c+1ePuVmZNcGd3QRRce4rdXfwP3cYW+OSRHeEjhw4FeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140156; c=relaxed/simple;
	bh=EG9g2ix8QDrI490G6Rb3uabFYXJ29pFurC+OCK/CftA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J96KoPR6yJUgnt+0pO5lj9UT8OTcNPCH9IopZEDcdV4BcG9uXbUpVAwz3PALAKmSm438kP9nK2jcYG3p56UX03eBsXlosGInoxJLZqXR1D0Q75wJWZqXxjZ5sT+I/dKvkxRzdvxowv1Q4GDYja+tX7lMeh93YvJGDnI650WONJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPeHdkvb; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a5075ed279so1981115ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140154; x=1730744954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNh72+AxACbmdQMt8H/yJzH0BaV6epZ3NPnzLvAOIgw=;
        b=hPeHdkvbCKIJrL2wiRV1SC9fcQT224aIkO/fSSgjrv3Uem998ws+3HMIRfyqQFlKmH
         mUQi5PrbPw/ImNva3CCjRrmXmEExwwi2nZNHse0hjmwSbzyj7Rmrs+MAhCLFsJiQnnlx
         icDdQ9gqcOBHjiZ3PmRgcUGkjEzNMP3hc+8fMipMViUly4QHBqqMufNDKOvuhlrlLjTf
         GBJmkQR43UYXRwlLuYVae7y+RbI0MiN9nfVKvDPJYb5Ta5aN/79de1pr4V8yFTkFW1Pr
         SgQr+1RcK7rVdhJ3+yjhx9uF7oIcx+t5Cqh5iWt7c2vk7lp0gT79KGsXSBjPkvm6u+Pa
         MgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140154; x=1730744954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNh72+AxACbmdQMt8H/yJzH0BaV6epZ3NPnzLvAOIgw=;
        b=Y2K7jGvk113pqySADM670h22ygwgU0l0ZOTm+2UKEp4888rC2gQRBpMIYaPJXCnUmI
         CuwQYIo8URI+rHniaypAhzagkDBZ+ciVW5RJjRuoOIw887EQvmsN01twODOFzcpzHbyV
         TPWpdsTZMS+wssD/17mGJL1i5eBsQSJ1HpwsUSoyJ438ln/oYfYBwLolFigjwCTSQ0qJ
         EJNPa75uGlPNGiIlm7UM3ue+HM2zAwQybOo/Sqgt5k7F3OoB46y6UrOCPmjc7jyiOY9c
         gfk62+FlLv3zo+HLxfi9+dIWqiufNdTHKSkWRpvzlIOMwINUQ96K1zkkvLx4B9DTkaLQ
         ebOw==
X-Forwarded-Encrypted: i=1; AJvYcCWb74rfPsu6c1dh3aZxurmewa3xams70ElWG4PR+bJEMVHWDrpeuE3Dah1vXfWsM73LfHvGZXOhcSN8J3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YycC/YZyQvXUs1f9iJoXO7R4RfYlYTO0TZrmQ31ZMMWie3HsMeA
	yueSsg88Q2I6r+s7/5AAQwLmXUXVmDsJxUIuw3NbCOVAbIHz3eRN
X-Google-Smtp-Source: AGHT+IExqyJrYtAdOoIXSEb1tPaKnGgmpoNVNp2TZK2xOkG6+S97+gF+8/Q2cUF9xq7qYuXFqmAwWA==
X-Received: by 2002:a92:c26d:0:b0:3a3:b256:f31f with SMTP id e9e14a558f8ab-3a4ed2fc0a7mr84712265ab.19.1730140153718;
        Mon, 28 Oct 2024 11:29:13 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7edc8495cabsm6159225a12.0.2024.10.28.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:29:13 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com
Subject: [PATCH] Fix BUG: KCSAN: data-race in xas_find_marked / xas_init_marks
Date: Mon, 28 Oct 2024 11:19:22 -0700
Message-Id: <20241028181922.406204-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cause of the bug is a call to truncate_setsize() while
fat_file_fsync() is attempting to read. Although fat_setattr() acquires
&MSDOS_I(inode)->truncate_lock before calling truncate, fat_file_fsync()
doesn't acquire the read lock for truncate_lock. The function
__generic_file_fsync() called in fat_file_fsync() only acquires lock to
the inode itself, not the &MSDOS_I(inode) it is a member of. This leads
to the data race where fat_file_fsync is reading during truncation.

To fix: &MSDOS_I(inode)->truncate_lock is acquired for reading before
calling __generic_file_fsync().

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0dd28f0c6293cc87d462
---
 fs/fat/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index e887e9ab7..5578b771a 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -188,7 +188,9 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	struct inode *inode = filp->f_mapping->host;
 	int err;
 
+	down_read(&MSDOS_I(inode)->truncate_lock);
 	err = __generic_file_fsync(filp, start, end, datasync);
+	up_read(&MSDOS_I(inode)->truncate_lock);
 	if (err)
 		return err;
 
-- 
2.39.2


