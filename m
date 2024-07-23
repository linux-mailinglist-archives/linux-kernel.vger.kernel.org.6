Return-Path: <linux-kernel+bounces-259664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71F939B19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C2128505E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55D14A624;
	Tue, 23 Jul 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkAhw1bv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1A13C90E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717311; cv=none; b=EsuA0kXWBL3n9n9wvThgyjrw7SQq6CVxa1CU8gNaGqn4Ix+DnyP7UmMoEuPypa8eZBoGtuoZ5bQdoViB3BPyJ539NUUBU2aZ+kD753WtO4xWU3kXGnwAE/zVRZLXb73D/q8h/PLhgjrc9q4c8YHA8Xzxz/wjxmBWDdzdSxFxMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717311; c=relaxed/simple;
	bh=0+XntXQQ9v9CMUCR2cJhmVHrlMqCupIkoRdvi4nr1rg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=krNxlQ+2jfU72ZkTEBhOYOLzWcpYQSLVTDB006vfOrmV+fhrH6EN7oG2jwsbvXdJ7L8Z+Ut/9eUrQ+2xn35ECXW+iV90a8Xv7h8KE1E3Zk5Jp/iBsqsAYjS9Ea/FYodWz3qD2kCdHQIpotPSP+vf2sCb5lfAfufsBQbXoA1U248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GkAhw1bv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc658b6b2eso4194555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721717309; x=1722322109; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=GkAhw1bvEfUc8SuOpeaNZC9PVpBPEJoj8mj2c0eIoGojIBF+iABaGHkbdgYgHAjndF
         YQaiQ/KpEUTwsqUrszUSQCEimiiZZsGeuFB7h3JAHXQTqa/fKApRGNdwnaLdhkWqbhQH
         ZCVmVclBtiCstdzdZmUkFqarROlaHl5gJY0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717309; x=1722322109;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=KmXujAGf5jR2wY7iLDNzot8yddDXAurMwEWjyU0i3SOGd06XZqlOZCULqub8eJyEVV
         f/qH0a9rOt5VbXdwVXm4sImZbLJLgUgYrdiwOBwpM5n1EPBv02IRdiURBH7SPvw788uR
         0P4GFRNPTWVviHsZp7k3qzy26Gzk3cCYhXJEhSSDez/re28vhSJqfmb93j+q2wu5nOC3
         g0UvldZy9rnEmHfMOcIKlGg7Vw9A0POw3ZPf8saR8He6W5hSdZoJ8RDmwmTu44DveNv+
         MG9OMiCyv5tPOFZAmT6aHtaUyryG+Ux9osA6hwkfI8AuW4F3meA5ix4JTgDVdJpDFY4L
         O/+g==
X-Forwarded-Encrypted: i=1; AJvYcCVYN7UR4dOUjDY3k+M1j+2A5zrLzl2goAj1W7osuDuHmsrrnzbaTVErSyXxYyS2PVqhxtEwcCC0ED08JVzUV36CQ9UJs6WlNsaibu4J
X-Gm-Message-State: AOJu0YxDvFxjNB2QqwOG1/cWFt3nD4FMfJWDULamVY53jYhm/lPKrkx5
	Ocl6t2RHfEAgzyRmpyJWOv3nQE8N3syi8FIo44gfRBO1PAzyc0sX42A2eICUEg==
X-Google-Smtp-Source: AGHT+IHAObmxYU1HV+RmN2tsABt6hiYi3Tbms5Abfi+vZEx8a/c2GmYHqxZ9nQrGtERCuO54fBkrRQ==
X-Received: by 2002:a17:902:e843:b0:1fb:415d:81ab with SMTP id d9443c01a7336-1fdb5f6a05bmr19444185ad.20.1721717309537;
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm66950175ad.173.2024.07.22.23.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5.10] ext4: fix error code saved on super block during file system abort
Date: Tue, 23 Jul 2024 12:17:19 +0530
Message-Id: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 124e7c61deb27d758df5ec0521c36cf08d417f7a ]

ext4_abort will eventually call ext4_errno_to_code, which translates the
errno to an EXT4_ERR specific error.  This means that ext4_abort expects
an errno.  By using EXT4_ERR_ here, it gets misinterpreted (as an errno),
and ends up saving EXT4_ERR_EBUSY on the superblock during an abort,
which makes no sense.

ESHUTDOWN will get properly translated to EXT4_ERR_SHUTDOWN, so use that
instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Link: https://lore.kernel.org/r/20211026173302.84000-1-krisman@collabora.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 160e5824948270..0e8406f5bf0aa0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5820,7 +5820,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
-		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
+		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-- 
cgit 1.2.3-korg


