Return-Path: <linux-kernel+bounces-520564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B7A3AB93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45531165C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E391DB37B;
	Tue, 18 Feb 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4hlBJOZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAC1D5ADD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917351; cv=none; b=Qg9iTVkA1Gv/NPVFo8NchO8dKb4hb8MX4OYLR5ZtACRKXCsqvd/b+vlx5nAqVCq8vKlK2VVgEpJZbCjaR+vT6wNwvYIVUYDTnMZuINUE9QYlG6PYbetXyqp2V5/wWbJmvADTieJpnm9YrLAfUsyaPqCPz+ZCNX9bLxq/DNgukBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917351; c=relaxed/simple;
	bh=OFxtNMO544u4QXflyKyJc+PEeJaBK8eyu4Fj+6JaLc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/1z7FuRX7ZnkSFLjByhos6Wl6USVnDlIbXEv48YyYaHgYfebaNwv+2snOCdPMQBw+HuvNuQXNcq4DvsqJL3BZD1iKTG8Qqkcvbl3o2FjMLvdcMOKYNuUSe+N+PKwdthQRb8qxSUefO08ahUcnM+6G6ETH7L7yKdypCZ/HmXT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4hlBJOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739917349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8/iHQhrJ/aZGVyYP8XcAahgAPdzcbyxdw/jYg/Ap0s=;
	b=Q4hlBJOZnVn09Jh8+HoEqYwPBzs5KYCaO5cu0ah2b7+P0pRNEjVRqBZmTPEuOH2Qca/izG
	WaNULmK16DQYRCHDJKyZYvmlhOrVz2RDWGxgmnuJCyZ+V831A552Ttsm+yT7IfhHSaJg+X
	wqPo2kaFjm8YZiCeameYc0iFh8OYV1Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-keIo2oqgMQmrNKfT2a6hWQ-1; Tue,
 18 Feb 2025 17:22:23 -0500
X-MC-Unique: keIo2oqgMQmrNKfT2a6hWQ-1
X-Mimecast-MFC-AGG-ID: keIo2oqgMQmrNKfT2a6hWQ_1739917342
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6950180087A;
	Tue, 18 Feb 2025 22:22:22 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A65D30001A5;
	Tue, 18 Feb 2025 22:22:20 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	mitchell.augustin@canonical.com,
	clg@redhat.com,
	jgg@nvidia.com
Subject: [PATCH v2 1/6] vfio/type1: Catch zero from pin_user_pages_remote()
Date: Tue, 18 Feb 2025 15:22:01 -0700
Message-ID: <20250218222209.1382449-2-alex.williamson@redhat.com>
In-Reply-To: <20250218222209.1382449-1-alex.williamson@redhat.com>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

pin_user_pages_remote() can currently return zero for invalid args
or zero nr_pages, neither of which should ever happen.  However
vaddr_get_pfns() indicates it should only ever return a positive
value or -errno and there's a theoretical case where this can slip
through and be unhandled by callers.  Therefore convert zero to
-EFAULT.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d..119cf886d8c0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -564,6 +564,8 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 	if (ret > 0) {
 		*pfn = page_to_pfn(pages[0]);
 		goto done;
+	} else if (!ret) {
+		ret = -EFAULT;
 	}
 
 	vaddr = untagged_addr_remote(mm, vaddr);
-- 
2.48.1


