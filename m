Return-Path: <linux-kernel+bounces-257430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C49379D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A68F1C218E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B54144D15;
	Fri, 19 Jul 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfybZCSF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5181726
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402779; cv=none; b=WOhdD47Tl5pYo7GyJCZerU4UeJYQQM/LCJ/UUy7O1vIXwR5JVAZFKHQ862umED+/IlYatN8VXGToNS2Ci+nIuYEypEU42yXI6aQRtjnWo1EdKuG+EXYzS0eO3cH9L/cqk95d3ANs6Ogl9/AR+bDgn8hBfrrhQi6s0pY5TgmTriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402779; c=relaxed/simple;
	bh=s0EtMe573eIxBuEbIx2LI+rWJgaIBXDKejtZmgIines=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q17bTCDh2H02A9zViPqNh5yfq0kxWUN80VGDsuIHSLeqQCvHisXDuciVVnr/w88lnjPT+PcIRhU/FAfq2fqFJB4qcWrSkspwuEGvbW9wpT1wkW5a95ibFROf340c3Naqpl8ix0ET74ELt8qvCDqgpPlxTmNS/q6MAc6AV9OBOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfybZCSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721402776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6d0hXH4uLkiXaZ4xSn07DWYcvQaiD8KGm9d+DE/JVs=;
	b=RfybZCSFXEktE4nYAaUY84wo3kAkQF9pIZcvJ2e0FRW6ePwwcZVLkvStMD7WD6mjSjmLXd
	fk7iHJZuTU8bwpqmBLdEKLpl261Ijr/4+S8iPd6VfsTykim4b+CfgJCVKoZ/3xI4lgvf4b
	nJJzsh7ZTjQ28SNgqktZy5NFzwQZit8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-cUiENI3kM0aTQrqC_bjUsA-1; Fri,
 19 Jul 2024 11:26:12 -0400
X-MC-Unique: cUiENI3kM0aTQrqC_bjUsA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B62CB1955D4E;
	Fri, 19 Jul 2024 15:26:09 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AB361955F40;
	Fri, 19 Jul 2024 15:26:05 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Knop Ryszard <ryszard.knop@intel.com>
Subject: [PATCH] mtd: mtdoops: Fix kmsgdump parameter renaming.
Date: Fri, 19 Jul 2024 17:24:13 +0200
Message-ID: <20240719152542.1554440-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When the kmsg_dumper callback parameter changed, the reason variable
in mtdoops_do_dump() was not updated accordingly.
This breaks the build with mtdoops.

Fixes: e1a261ba599e ("printk: Add a short description string to kmsg_dump()")
Reported-by: Knop Ryszard <ryszard.knop@intel.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

The offended commit is in the drm-misc tree, because it was needed
by drm_panic. So I will push the fix there too.

 drivers/mtd/mtdoops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 86d49db9196d..7bf3777e1f13 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -305,7 +305,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 	struct kmsg_dump_iter iter;
 
 	/* Only dump oopses if dump_oops is set */
-	if (reason == KMSG_DUMP_OOPS && !dump_oops)
+	if (detail->reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
 	kmsg_dump_rewind(&iter);
@@ -317,7 +317,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 			     record_size - sizeof(struct mtdoops_hdr), NULL);
 	clear_bit(0, &cxt->oops_buf_busy);
 
-	if (reason != KMSG_DUMP_OOPS) {
+	if (detail->reason != KMSG_DUMP_OOPS) {
 		/* Panics must be written immediately */
 		mtdoops_write(cxt, 1);
 	} else {

base-commit: 26dbffb2a4c4d4639c7b336f6b74a437c23dadd4
-- 
2.45.2


