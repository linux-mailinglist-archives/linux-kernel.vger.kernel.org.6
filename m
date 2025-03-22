Return-Path: <linux-kernel+bounces-572625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E6A6CC51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D815617327E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586A2356CB;
	Sat, 22 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnww6gE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703F21D001;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=S6qmGBhbx5IVYvLNQSLjGsKMxsf5ESJ1Lmv/BsJCKFUFU7eCxyc7v+jHDPhkzYiXPGRusyGRL7q3vOK0SWsHum5TUSRi4JsHR9kEF9n/t1b+CMEGhqY+Xv3SVEnBNcau7v72D+uIJ/st4lkeBVJcLfIeNpJ4Ve3qmfDpYD3Pxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=Yaohu7isWY3gNZXnBO5AmDueX4y+9dG81g5HOyB+u24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaK/AaXFwboVztLhXCL0UTmEXU25YuTFZs20dDS/TrYekAbVOAMV6MH5KMFri41Pc8dINueJ3Ei6t1xu9nhHJnxPMfWzEigI3Cre5LFQnxA9PFF+F8SQSWOz7gOugvRcjdVKUm42FQnteTlv2onjVT93/q0kurnUetkD8gjulPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnww6gE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E5A1C4CEEC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=Yaohu7isWY3gNZXnBO5AmDueX4y+9dG81g5HOyB+u24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pnww6gE5HsT8SEInP30wiYL7hXXdFdj066RG4AJGdqd/KJ7ySk4RQlTiueXfBwhCK
	 0y3zwSqNLFfbX1qza6Wg78nxcmxdyLL3DZ1IJWgyJpwJ8YEox47J3mPYQfCREnsR87
	 vU9KdPm4ZGx3MUk0ovQ9mTGKbzvQVyNModWhPBlDm3c71qBJz7tUdVBO4EzoUj0wuT
	 6wg/nTO5Ju/uEvfAOC/CYKoaXt2ZwX5U30pVYyJ3Us3A4DMKmCaeIbTM5QIAc1uJ11
	 uXEIPL0f+jJnbdjFYsIPXgYBjYf3J4J5iyvvBL2kPCo4lcNYvPd25Ue/veRnZps5FN
	 6Lzpt2ZLaF/NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF6C3600B;
	Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:14 +0100
Subject: [PATCH v2 2/9] initrd: fix double fput for truncated ramdisks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-2-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1599;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=k4g6SAXWuxXSYv2iKkbm/npvjC9+dlFx9G1/+9RZN20=;
 b=rNJ683tIeaNnaJuuNqFjmoLWib1cKLA5DiGdVBrmkGkeiuHZxssO5pP0xtDM/im05voR1Nb/7
 4LsMkMemF0TAw9Mnp7ACjJIxCYIyVq4DeGqjSHbewp8eywATzHjpEsz
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

When you actually take the exit via devblocks == 0, the code will do
fput(in_file) twice. This was introduced when the APIs where switched
to the file-based APIs.

Remove more of the multi-floppy support from the olden days.

Fixes: bef173299613 ("initrd: switch initrd loading to struct file based APIs")

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 473f4f9417e157118b9a6e582607435484d53d63..d026df401afa0b7458ab1f266b21830aab974b92 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -234,20 +234,20 @@ int __init rd_load_image(char *from)
 		goto done;
 	}
 
+	if (devblocks < nblocks) {
+		printk(KERN_ERR "RAMDISK: looks truncated: (%luKiB vs %dKiB) - continuing anyway\n",
+		       devblocks, nblocks);
+		nblocks = devblocks;
+	}
+
 	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
 	if (!buf) {
 		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
+	printk(KERN_NOTICE "RAMDISK: Loading %dKiB into ram disk... ", nblocks);
 	for (i = 0; i < nblocks; i++) {
-		if (i && (i % devblocks == 0)) {
-			pr_cont("done disk #1.\n");
-			fput(in_file);
-			break;
-		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
 	}

-- 
2.47.0



