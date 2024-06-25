Return-Path: <linux-kernel+bounces-228854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53029167CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE841C25265
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889D1553A2;
	Tue, 25 Jun 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvBByc7a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D9154C0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318382; cv=none; b=F9mFclvzxGxEYtjKdS7JXpRwVVqWRn+nmphEYSBHBL/2jpco69ldZ65eoISZGJhA73TS1q2ysML21rVZzWzgO2rZFimSFn9yr3x16J5HFu7+tQq3wv/3kuGj+lQbQQUhAqdd7Hw7/bY3WkT6DVRyDD6FUN0F4Hhg/xi4CnQrn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318382; c=relaxed/simple;
	bh=WCh/XkC0BXKeHRYFWnbZeYbOu3vCw2Nm+k3rqiKe95U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Aity5LoTZVq0bVLpWamy2E6OdFGsWiVgRmzC3LBG7ShI18DXmzGerYxINZn7TTnTlhdKFASNNbgs67H6p80fq0xzssPc+ouwkVsTsPkB1TLpyaBSzjbiqVpJ+uZmFpH1OgmWrT47MYTKRHwyp+00euUF7goMykK778c0RAZC9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvBByc7a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GtsFx4uLbIgCsY2Rbgjjg5IWwkj06XCQTC4QZBlv4OY=;
	b=hvBByc7aU2SIJat/sYJLZd7NKUo45O5edChzqz9dsyZ8VXlICda5a/genIe/vgeL7bAqpn
	e0tJojIeKd4FlyaYNFDSjtOVHPRSP7J9/9oosDISeQDIc+5HNiDzOht7q+hDin/aIq2evd
	ohIpeoPftafYPmvbIvXrj0ftzmzqGpA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-Md1ZfYzPO1mf-KiPEEKABA-1; Tue,
 25 Jun 2024 08:26:14 -0400
X-MC-Unique: Md1ZfYzPO1mf-KiPEEKABA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DC3719560B0;
	Tue, 25 Jun 2024 12:26:12 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.34.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACA0D1956051;
	Tue, 25 Jun 2024 12:26:09 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org
Subject: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
Date: Tue, 25 Jun 2024 08:26:03 -0400
Message-ID: <20240625122605.857462-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I've addressed all of Christoph's review comments and rebased this to
the latest nvme-6.11 branch. I also retested everything. The test
results can be seen at: 

https://github.com/johnmeneghini/iopolicy/?tab=readme-ov-file#sample-data

Please add this to nvme-6.11.

Changes since V7

Broke the changes to nvme_find_path() into a prepare patch.
This made the patch much more readable. Removed the WARN_ON_ONCE
in nvme_mpath_end_request() and changed the pr_notice message
in nvme_subsys_iopolicy_update().

Changes since V6:

Cleanup tab formatting in nvme.h and removed extra white lines.
Removed the results variable from nvme_mpath_end_request(). 

Changes since V5:

Refactored nvme_find_path() to reduce the spaghetti code.
Cleaned up all comments and reduced the total size of the 
diff, and fixed the commit message. Thomas Song now 
gets credit as the first author.

Changes since V4:

Removed atomic_set() from and return if (old_iopolicy == iopolicy)
At the beginning of nvme_subsys_iopolicy_update().

Changes since V3:

Addresssed all review comments, fixed the commit log, and moved
nr_counter initialization from nvme_mpath_init_ctlr() to
nvme_mpath_init_identify().

Changes since V2:

Add the NVME_MPATH_CNT_ACTIVE flag to eliminate a READ_ONCE in the
completion path and increment/decrement the active_nr count on all mpath
IOs - including passthru commands.

Send a pr_notice when ever the iopolicy on a subsystem is changed. This
is important for support reasons. It is fully expected that users will
be changing the iopolicy with active IO in progress.

Squashed everything and rebased to nvme-v6.10

Changes since V1:

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've
codified the tests and methods we use to measure IO distribution

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9


John Meneghini (1):
  nvme-multipath: prepare for "queue-depth" iopolicy

Thomas Song (1):
  nvme-multipath: implement "queue-depth" iopolicy

 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 102 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |   4 ++
 3 files changed, 99 insertions(+), 9 deletions(-)

-- 
2.45.2


