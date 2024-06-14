Return-Path: <linux-kernel+bounces-214522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F89085EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485141C20A86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AC1836FE;
	Fri, 14 Jun 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHSr8R3F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC718307E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352894; cv=none; b=IQVmR+prPTWLLPymp5aPPPrbu+wrhZcPwRjnWyaqhu8EkDIijpmbDyPlzZ8tgDBf2U5pO6xlROeb1CE9XkSARlc8bkE7VNqBeut7EzQGAMr5OnTyJ880NOK/nwd5ayj1uRbsOkb4na5BD41k5smgQ4fTZMDqSvDIOsX2+QZf7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352894; c=relaxed/simple;
	bh=AJr56AIyxw1AV+8imWQzB4XZoQsJAgsK6sLrW1PzyvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqNe6l6M2xidbjwI9UdZ2zfIUtOFxxvf1HFHmzF+zvjW52V7BJ2DSemtUjcSwt8Ju+LTkwKAYEZcMUEIxlSML/tEdHtHTMdCFna6JfgQSyZB714YBK56T3trQz8gHLvGpLLW1CBhySXMinINBOm4KYIxBN9mFwO92wwIrTcKW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHSr8R3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718352892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kpIVMcrxNUuot3WrmRIeXJx5cyzexiU4T4G3Mxhn+Fo=;
	b=OHSr8R3FGbEDBn5Np4aKkOaRmpB4Qxx7BMHcO8fRYQJazTWExyblqR5k5ji7Q/J5y/98oM
	rOGHEN7X/n8amSyKkrIGYudYOA3hzsjLPI61rIdMuxIMjHRTYwWOJy3GR8BtFxPJIoCcip
	MtpHBkz1dgOCuYb4tfJ+6YpAkwBeJLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-QPyfIbc7Np-25l__XOO7DQ-1; Fri,
 14 Jun 2024 04:14:47 -0400
X-MC-Unique: QPyfIbc7Np-25l__XOO7DQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0BBC19560AE;
	Fri, 14 Jun 2024 08:14:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2DDA19560BF;
	Fri, 14 Jun 2024 08:14:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] Documentation: Add "S390" to the swiotlb kernel parameter
Date: Fri, 14 Jun 2024 10:14:38 +0200
Message-ID: <20240614081438.553160-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The "swiotlb" kernel parameter is used on s390 for protected virt since
commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
and thus should be marked in kernel-parameters.txt accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 PS: I wonder whether we could remove IA-64 nowadays...?

 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..423427bf6e49 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6548,7 +6548,7 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,EARLY]
+	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,S390,EARLY]
 			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
-- 
2.45.2


