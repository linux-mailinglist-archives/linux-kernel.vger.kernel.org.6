Return-Path: <linux-kernel+bounces-186445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A888CC448
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EF71F21573
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839AE8174C;
	Wed, 22 May 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9J5IGZc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654387D3EF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392543; cv=none; b=o3VszYHYBM977W5XC8R8t4Rotpt1waKFly3OioQ9TbVH/MG71aQgxlX3J629EtmKL6MnaQ4Ht2SIEwY8xQe43j1fvruwxetjeZN5myGUwKnHwk4Sm4EyHSrMzys+ifvOIwPffxZpOqEiIFJM+JZOJuKqjW32HdFqznmq6/dGozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392543; c=relaxed/simple;
	bh=om0UORPbIHbtR7mx1mvms051mLDb/qPMY6V1s61j4E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=akxsLmZHJ/BHEs/CredyLdLSld/uoENDn1TiQwk6nGPPMRnhmS+5pxhLuDQNT1S1JDL10Mxbj4tkQvRMRFAwNk1p9yyGcvqvS5vj9O6dQw8YgMrmN5BIurerkUqCluIxx64wYfMBuF/sDSklac0Jb89gHGahM1iwHeFS0itn66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9J5IGZc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716392541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UOQlOAwzn82GumJka+toL0AEgDgwNHZGw8MMQ4bZEHU=;
	b=P9J5IGZcfod6ts0mDEg38zqLzyo+7rb6rm+EGgssL0nO+mT6pDzxy8O6OFvEuXwiTLnGVD
	WeVKQyQSKOrrRo0hz27TxyU6NezfqVSc9bWh13fxIikk1WAEbPHh/CSmnqvpfmL3ceUgYx
	Wv4zQ3bK7wrnc+aoJMTCQOC8oq90qkE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-dbCIYJWzN0SpBciFPoj83g-1; Wed,
 22 May 2024 11:42:17 -0400
X-MC-Unique: dbCIYJWzN0SpBciFPoj83g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FAEA380008A;
	Wed, 22 May 2024 15:42:17 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AEEE740004D;
	Wed, 22 May 2024 15:42:16 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org
Subject: [PATCH v4 0/1] nvme: queue-depth multipath iopolicy 
Date: Wed, 22 May 2024 11:42:11 -0400
Message-Id: <20240522154212.643572-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Sorry this took so long. I've fixed everything up and rebased this
(again) onto nvme-6.10 so as to pick up Keith's 'io accounting on
failover fix'.  A new build is being tested again for good measure.

I'll send a Tested-by: John Meneghini once the tests are done.

Changes since V3:

Addresssed all review comments, fixed the commit log, and moved
nr_counter initialization from nvme_mpath_init_ctlr() to
nvme_mpath_init_identify().

Changes since V2:

Add the NVME_MPATH_CNT_ACTIVE flag to eliminate a READ_ONCE in the completion path
and increment/decrement the active_nr count on all mpath IOs - including
passthru commands.

Send a pr_notice when ever the iopolicy on a subsystem is changed. This is
important for support reasons. It is fully expected that users will be changing
the iopolicy with active IO in progress.

Squashed everything and rebased to nvme-v6.10

Changes since V1:

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've codified
the tests and methods we use to measure IO distribution

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9



Ewan D. Milne (1):
  nvme: multipath: Implemented new iopolicy "queue-depth"

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 91 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  8 +++
 3 files changed, 96 insertions(+), 5 deletions(-)

-- 
2.39.3


