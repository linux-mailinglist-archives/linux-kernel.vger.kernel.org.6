Return-Path: <linux-kernel+bounces-284571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340F950299
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39391C2111A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734A194C73;
	Tue, 13 Aug 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQQ2ANrk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CE19047C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545602; cv=none; b=rQ7J029FIYLA5x5dyyelpNSKNI0OJdMmZl22bg0n6P4VcM7V0B19AiVghZkqbhASCvQSr3IX115QN41puQ3aSnPotdypLbG1yZaNKq16L0c5mFTQOpbf3+nIMCqhqDXPYbUGOssvs9hrI+5vDvL9E1AhNPgGWJooOJ+KpjtHXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545602; c=relaxed/simple;
	bh=jfJKAWVAz6OsyLNuTbI1cBCCxMzXL5Do7Wl7jtJHiQ4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=k+HWYHh+ygSlQZYrD1hfp/3vDGdPhI9I3qHx0L1zE/FUo3qyaLR2oNgpKqShkFH+p7MmBrLdGZ0w8AovubIso4pfTQALahC4uAJdslTxMJsbPHDoew8Grb2gFYt+VGArKXiWIWN6UXTHhG+f0L4HQLJuz5SjdKHJxLWsKqiMmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQQ2ANrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723545599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=cNo7/EXhsVJoHbfZhyj091rKwJVs7Vr83lU9O5NUCCg=;
	b=VQQ2ANrkQbXMIh9PZz1ZE8E1geCYovw5FTPk4NhQ1XGrV8R1T5Dx+AGk/r/C3qdr5vRIlm
	w6k9Q+huTSV2lOxaKHsI6GIdXeh7hxCvc/Hrz3fcyfhfEeL5XYqAEnWmvCy1mpSV4PjqHh
	FsPWFb47f2woWt9f8EFCKIp+pEI2o+0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-VlOUm3wEPNS7ycglrdxu6w-1; Tue,
 13 Aug 2024 06:39:55 -0400
X-MC-Unique: VlOUm3wEPNS7ycglrdxu6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3C5318E68D2;
	Tue, 13 Aug 2024 10:39:53 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB46B1956052;
	Tue, 13 Aug 2024 10:39:53 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id ABFC130C1C18; Tue, 13 Aug 2024 10:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id AB37D3FB48;
	Tue, 13 Aug 2024 12:39:52 +0200 (CEST)
Date: Tue, 13 Aug 2024 12:39:52 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Khazhismel Kumykov <khazhy@google.com>, 
    Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: [PATCH v4 2/2] dm resume: don't return EINVAL when signalled
Message-ID: <d018fc37-e266-8e57-70ee-51b7a4dbd5ab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Khazhismel Kumykov <khazhy@google.com>

If the dm_resume method is called on a device that is not suspended, the
method will suspend the device briefly, before resuming it (so that the
table will be swapped).

However, there was a bug that the return value of dm_suspended_md was not
checked. dm_suspended_md may return an error when it is interrupted by a
signal. In this case, do_resume would call dm_swap_table, which would
return -EINVAL.

This commit fixes the logic, so that error returned by dm_suspend is
checked and the resume operation is undone.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Cc: stable@vger.kernel.org

---
 drivers/md/dm-ioctl.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-ioctl.c	2024-05-15 16:55:57.000000000 +0200
+++ linux-2.6/drivers/md/dm-ioctl.c	2024-08-06 12:31:11.000000000 +0200
@@ -1181,8 +1181,26 @@ static int do_resume(struct dm_ioctl *pa
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+		if (!dm_suspended_md(md)) {
+			r = dm_suspend(md, suspend_flags);
+			if (r) {
+				down_write(&_hash_lock);
+				hc = dm_get_mdptr(md);
+				if (hc && !hc->new_map) {
+					hc->new_map = new_map;
+					new_map = NULL;
+				} else {
+					r = -ENXIO;
+				}
+				up_write(&_hash_lock);
+				if (new_map) {
+					dm_sync_table(md);
+					dm_table_destroy(new_map);
+				}
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);


