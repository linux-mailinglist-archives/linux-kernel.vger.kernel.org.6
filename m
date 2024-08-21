Return-Path: <linux-kernel+bounces-295670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC470959FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBE8B24C93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30881B1D59;
	Wed, 21 Aug 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lczDN4wr"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5511B2520;
	Wed, 21 Aug 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250492; cv=none; b=tRlkVeTPWUawK55p3mZnSyA4CyreU1nSMq463vTfsubAkJ4/g9XbPIIdLcFeonafx7SjVPJAgxcVQ8ES3y7ImmkwVJmoZ3rH3lUAtHeAPvKYPcBqLVQFqduKNj5u1vZMQhaY4tK0TR7hrF4Cu8LEun6vZqTsECdwpOTFTsNlidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250492; c=relaxed/simple;
	bh=yIC/eliA3Rct3SZ2+ZmelKDHsCE3ohn9pDGoiaGXrAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtSuUfnBPvNLZsjKoyF14HuyxAaEp4fILoMiNHrWRUK0hMMbe7YW0iKFQb9FAnNIH/1gaEgMzS+dyz8+YJcfjW7zcg3VB+/CTKIzk3r3PNgGnQr26u+Mdba0pk1X348okKZU6jPPF7wQRjfj5mJ8dy+GbR2NWI9QgHL3gzNFNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lczDN4wr; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gmJgsBD1Gy802gmJhsL3aC; Wed, 21 Aug 2024 16:28:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724250486;
	bh=FKaRraVbqkBDXVLLTv7roD4oeXin47AqKDSX9eLt7UI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lczDN4wrpFUqhmeJ3X7Orhilq2u9/zNDAq+Alwx1iMNVULZUyze1cDnIp/cFk55df
	 OEA4w9v0E6f620EY+zwqTRnIJMT5pw+9WCp/Wlo0uEGlHREA6AJQcLl53PpyS0r0gk
	 lLLRlCyqmCH95K0hl6yGcGh4THBVfD9PoykPNPX8PVf3vEtIpCBwDx76sZ+M1TOGmM
	 37XmxtLHLmw7TJU3nvJj4Dwx2gmSMeog9KM74JjkIjpxK+t42NtrmYu8lUtyJvZPKv
	 QL3fnZitzPyiVK8JBnIoZpU/T5aBg1/zY+IAbsf5nO1W/rUtApwGqVx5gJLRiJ6Ld5
	 GOsHTWc9n4hcQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 Aug 2024 16:28:06 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-afs@lists.infradead.org
Subject: [PATCH] afs: Remove the unused lock_manager_mutex field from struct afs_net
Date: Wed, 21 Aug 2024 16:27:57 +0200
Message-ID: <7fa750b2be9523b229105e780c0ef3d9eed20009.1724250464.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'lock_manager_mutex' has been introduced in commit f044c8847bb6 ("afs: Lay
the groundwork for supporting network namespaces") in 2017-12, but was
already unused at this time.

It is still unused now, so remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 fs/afs/internal.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72..a09459cebba9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -331,9 +331,6 @@ struct afs_net {
 	struct timer_list	fs_probe_timer;
 	atomic_t		servers_outstanding;
 
-	/* File locking renewal management */
-	struct mutex		lock_manager_mutex;
-
 	/* Misc */
 	struct super_block	*dynroot_sb;	/* Dynamic root mount superblock */
 	struct proc_dir_entry	*proc_afs;	/* /proc/net/afs directory */
-- 
2.46.0


