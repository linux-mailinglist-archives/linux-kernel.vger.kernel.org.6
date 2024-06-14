Return-Path: <linux-kernel+bounces-215415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C262B909270
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF028D366
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062119EEBB;
	Fri, 14 Jun 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOvWJRXg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F091474B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390457; cv=none; b=RORnwGZTi2dta5GgOezCcZXT3gvHPlYYdO9TOkdZLn/v5lvH3dCsDrRcg1tzEaxhmZm8sviZLfOkeLs9xgVY9F72jDoVyMnZOsiQaJMvz+ZEYOBjCMCWNxXKH0TWvc05zEoEZIa4rEzohG2od0kdFbb72tLryQCn3mzwaBpgV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390457; c=relaxed/simple;
	bh=ULzJwpglCX0QEdR3Y1XsB3aWzDUVENMbvB8wSVJ9pJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iO+JShzHhkomB3NvH+lMVU0IHfc9kMAWeAnIWSXW75u40IpYZV96Z2E7AJwKLSIOdKaqLRB2uVTZrlF7e86qkqrao6MkC6GeB49T+p+SaCNLaoQl2IckgE6in3elY/uEhiUlbW3i5sqPS7goJSwgrA1c5pUDD79E9TvxhZtwL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOvWJRXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718390455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vbHnjVCMgPLHGeY6k4yg5XvdLWsbsFGovk2aBHxfGoc=;
	b=iOvWJRXgg04rAv7qfEW+fIW9+/suApH/vyG2QEF9hs5GxUgFeHqwwjk5Ma5NzXSsKEQhx/
	jnr1e9No6k9k4qwHat8sCnkyhJOMe+uuZE/h3QXVCzzKw/H5QXKQirbhSLR/QdLRE4pbtD
	CZfzdZyHn4xfR4lqpk7sGG/JvtWQYEU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-nA-l2EvuNieQ2sPCHOqdTg-1; Fri,
 14 Jun 2024 14:40:50 -0400
X-MC-Unique: nA-l2EvuNieQ2sPCHOqdTg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D3861956083;
	Fri, 14 Jun 2024 18:40:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D570F19560AA;
	Fri, 14 Jun 2024 18:40:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Alexander Shiyan <shc_work@mail.ru>,
	Olof Johansson <olof@lixom.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mtd@lists.infradead.org
Subject: [PATCH] Documentation: Remove unused "spia_*" kernel parameters
Date: Fri, 14 Jun 2024 20:40:41 +0200
Message-ID: <20240614184041.601056-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The kernel module parameters "spia_io_base", "spia_fio_base",
"spia_pedr" and "spia_peddr" have been removed via commit e377ca1e32f6
("ARM: clps711x: p720t: Special driver for handling NAND memory is removed").
Time to remove them from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ff02e1a02e12..dd8436c98735 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6273,11 +6273,6 @@
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
 
-	spia_io_base=	[HW,MTD]
-	spia_fio_base=
-	spia_pedr=
-	spia_peddr=
-
 	split_lock_detect=
 			[X86] Enable split lock detection or bus lock detection
 
-- 
2.45.2


