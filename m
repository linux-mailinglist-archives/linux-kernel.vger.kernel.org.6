Return-Path: <linux-kernel+bounces-427956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43A9E07DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD6281E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC813D53D;
	Mon,  2 Dec 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNagMNTr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BB13AA2D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155456; cv=none; b=E8YCuKx5URLVa/BHNT7fBTEe6cY6571K6+wFqczHAc8j0EYOascWFUsNmVSOByKLaeHBlvstyA/di5wtj5FUWlXUSNMZDXsm8gwXVnDlC/aVhbdZq/xk1G+fZDwhOaWGnJleXE+Bm9RmuQn+xA+MNub7ft92YfwSFSoLXurnmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155456; c=relaxed/simple;
	bh=jOZCL0ei7qE3tFPT/E/SrGKpNxzku939Q/9lO4qiiZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKpxuT/xCj1rLgLdya2+mvShuMRcM4LzD+fdqq7bUn+1BMLLBYKA9CLHxBqxOk+IGrRi2kL7D3peDvPJmWX1NJaJdOSA2jbhLbeowwBpcJQZ6IgXqFIjaFu0f6X120IAeCoUu2+SGmdTsiHvM+RHnIxN4xcMH+BpztHvsLlVQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNagMNTr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733155453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Vi+u/cOGgX/NqxO7f0g0EC3JYFurtZNfdxrvIwqibM=;
	b=XNagMNTry3vreu+JMuB7j1Y6vjBDLFwbIFUNNF1h3BhbMGWz/fBd5MrEzeQK16wpk+Rdmo
	IIa4wFxTCWLJwBLE3Uu9S54J1CyNQ97wLtpxIsg8N7JfvmsMdWIFYl/OjPmOK62dcAylJR
	P/weMzI5CvC3LX+pL/v/JfDBr4/FguM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-wdUPUaA5MXqAEoNmzptXqA-1; Mon,
 02 Dec 2024 11:04:10 -0500
X-MC-Unique: wdUPUaA5MXqAEoNmzptXqA-1
X-Mimecast-MFC-AGG-ID: wdUPUaA5MXqAEoNmzptXqA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97CB11955DA3;
	Mon,  2 Dec 2024 16:04:09 +0000 (UTC)
Received: from prarit.bos2.dc.redhat.com (prarit2023-praritguest.khw.eng.bos2.dc.redhat.com [10.26.1.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A9CB1956052;
	Mon,  2 Dec 2024 16:04:08 +0000 (UTC)
From: Prarit Bhargava <prarit@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: Fix tnt4882 license to be SPDX compliant
Date: Mon,  2 Dec 2024 11:03:57 -0500
Message-ID: <20241202160404.262993-1-prarit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

"GPL-2" is not a valid SPDX license identifier[1].  Update to SPDX
compliant string "GPL-2.0-only".

[1] https://spdx.org/licenses

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rohit Chavan <roheetchavan@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/staging/gpib/tnt4882/mite.c | 2 +-
 drivers/staging/gpib/tnt4882/mite.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index 0edf34d243e9..90341f8c394e 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2
+// SPDX-License-Identifier: GPL-2.0-only
 
 /*
  *	Hardware driver for NI Mite PCI interface chip,
diff --git a/drivers/staging/gpib/tnt4882/mite.h b/drivers/staging/gpib/tnt4882/mite.h
index 6454d069b8cc..fb84eaa83de3 100644
--- a/drivers/staging/gpib/tnt4882/mite.h
+++ b/drivers/staging/gpib/tnt4882/mite.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 /*
  *   Hardware driver for NI Mite PCI interface chip
-- 
2.47.0


