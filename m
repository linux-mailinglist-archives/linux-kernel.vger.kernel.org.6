Return-Path: <linux-kernel+bounces-274931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5271947E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E13280FBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52F15853E;
	Mon,  5 Aug 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENF0imsd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D72E3E5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872462; cv=none; b=kLgHD8znqJQ9H4kf6m11FhyMetcciVq1+AleHRYJ8MH2lYEOV+HZFMh1uK8P4ghUKrGTKMP+iCoibmgqT00JcHthA/zaTgqIDCVYU5HK8OOJXcp2b1LtVH6R4cyTc+q5Iq+519LzTKkF2D9e8UN5dqcH5vAXFdRJEGLigjTk8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872462; c=relaxed/simple;
	bh=ckR95kzghM6AsvF5uMxEfeEUjIJLOkVRQ/eMIVsntOQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Cu57db1EDEwm1xsIVZ/HBm5flub8Z/meTEbgpDFEHnA8BUwwzTJ8SVQub2smQwCjk3YrH3R+A05bPcPMf876URHLvSg3qWNadFV8D3lmrI2aNzKwa3ur3mJIFwJnGYMSt9fO5h2hi4G7kvdxFMp0zwQyMTVo6LE1BggkZEOrNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENF0imsd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722872459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lLSzwF1d/bXpw29WYzCzvdfDdw9sQIr/+WIQ3AvCeJY=;
	b=ENF0imsdnRCrVg6df/JezO0oqUafPa2jAJtogVOnuqL1BLiIwirD+X2svszczwmocrquzj
	j84Yka2gBy8+uy3QD2eCtYVY72oGr01cm6uqFNTR0WXLZJG7Nm7born9vQ/mej9UGArFhw
	I7X7JLJRsSyhqrdBlQNQou2zsa1UtOA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-gBlK8TCOMH2Bv5IyHZB09w-1; Mon,
 05 Aug 2024 11:40:56 -0400
X-MC-Unique: gBlK8TCOMH2Bv5IyHZB09w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 080511955BD0;
	Mon,  5 Aug 2024 15:40:55 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B44AF30001AA;
	Mon,  5 Aug 2024 15:40:54 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A6DC430F3625; Mon,  5 Aug 2024 15:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A3EA745586;
	Mon,  5 Aug 2024 17:40:53 +0200 (CEST)
Date: Mon, 5 Aug 2024 17:40:53 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Khazhismel Kumykov <khazhy@google.com>, 
    Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: [PATCH 2/2] dm resume: don't return EINVAL when signalled
Message-ID: <ffe97384-f862-afe0-b83-bcfd2b65b72@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If the dm_resume method is called on a device that is not suspended, the
method will suspend the device briefly, before resuming it (so that the
table will be swapped).

However, there was a bug that the return value of dm_suspended_md was not
checked. dm_suspended_md may return an error when it is interrupted by a
signal. In this case, do_resume would call dm_swap_table, which would
return -EINVAL.

This commit fixes the logic, so that error returned by dm_suspend is
checked and the reusme operation is undone.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

---
 drivers/md/dm-ioctl.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-ioctl.c	2024-05-15 16:55:57.000000000 +0200
+++ linux-2.6/drivers/md/dm-ioctl.c	2024-08-05 17:35:32.000000000 +0200
@@ -1181,8 +1181,24 @@ static int do_resume(struct dm_ioctl *pa
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
+				if (new_map)
+					dm_table_destroy(new_map);
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);


