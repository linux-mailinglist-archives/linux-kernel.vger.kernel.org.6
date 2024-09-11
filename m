Return-Path: <linux-kernel+bounces-325497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB4975A66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BB31F246E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827611B9B36;
	Wed, 11 Sep 2024 18:30:07 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF71AC8B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079407; cv=none; b=sq51QY1pA81nQw/0NW3dT3EmQ02W9AeeJMf1aJ38WWq6154b3JT795xWcZmYOqM+OBpA3op89O4yJTl4tD2ts2CbQ/CkEv/3w7J9p+PcJrQNXMQJ3O9GFGXpmUvt2XlzChmi5CVtOlpvwknqkD2w0jtLD6a9R5oD7xp3AOBMnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079407; c=relaxed/simple;
	bh=kJflO/5pJByNEtb520iOW/f+0hsW1F7xR560N0ae40U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eC7WHaVFYawO0/wbNskH/wHG9+iMKS1AFQNlhUctF7SKWivssjg6TmOhKDc48nt4biEbRJkkOp59JjhfnyYfFwmHErAzOXX4UH0VBPxe1t8ClHFJQqD0WthAEtdxWYPdgXhL5tZYcWPEN+aW0qo8ZzH5GwypAN3JWq+QI0EadmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1soS4S-00Bwab-O8; Wed, 11 Sep 2024 21:28:04 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.23.140])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X3pxm32rLzkWLv;
	Wed, 11 Sep 2024 21:29:16 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: David Howells <dhowells@redhat.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] afs: Fix checking wait_event_interruptible() return value
Date: Wed, 11 Sep 2024 21:28:53 +0300
Message-Id: <20240911182853.19634-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrvdefrddugedtnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdeftddvieeltddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudelkedrvdefrddugedtmeeggeejkeeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeeipdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehmrghrtgdrughiohhnnhgvsegruhhrihhsthhorhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrfhhssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
 eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1726068760#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12170014, Updated: 2024-Sep-11 16:40:30 UTC]

The if-block in question is presumably supposed to handle
wait_event_interruptible() failure, i.e. when it returns -ERESTARTSYS
due to signal received by the task instead of a zero value.

Fix the condition appropriately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4be5975aea15 ("afs: Further fix file locking")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index f0e96a35093f..2dba323b3395 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -652,7 +652,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 			fl->fl_u.afs.state = AFS_LOCK_PENDING;
 			goto try_to_lock;
 		case AFS_LOCK_PENDING:
-			if (ret > 0) {
+			if (ret < 0) {
 				/* We need to retry the lock.  We may not be
 				 * notified by the server if it just expired
 				 * rather than being released.
-- 
2.30.2


