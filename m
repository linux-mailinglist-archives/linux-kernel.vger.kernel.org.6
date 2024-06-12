Return-Path: <linux-kernel+bounces-210730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242189047FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4691C2244F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E815BB;
	Wed, 12 Jun 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmbVBZ2o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2F631
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151648; cv=none; b=C9JKltetLB5AskejGEBi33EVZ+lodxgfp1CTnvuUlCtLwSSYMVat4WILIE7BinfDcCml4DG9gMUB7zL/a8NKRazbGd41nErJ96EAhvoltLLAqkT4rhJV7ftPjPu3z0dGe9xbbB5M/XFYjeEtPthRoVnlXBl0zUIhPIOGqgCGXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151648; c=relaxed/simple;
	bh=vR9EQsUY9/HkWjvWLjfeNjL78clvcyQ5iWZAMw6pWtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=HYNKumjosUAftsh9ShJV4L88BZ7FzeDo+tXZ+IwSJdEyIynvxmO13vxSgOAceS5DfnbEoXH44i7dhbLYCeDF1szBm+3HPNJ10UwbK4ivKq1EQiIVg5xDHUBvsR2UpP63ti4qkRGcUD/NZ0iSzToYtglc/gSg7+h801NiRhqZ1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmbVBZ2o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718151645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Wgff3xCvcJFFJD3zhHSjdwisi/KaejD8KjBgmyIAzQ=;
	b=PmbVBZ2oGrEJNL8LHzHNmzWIxaLEwQWGG8qkoJen7w/TeHj6bP0lhX9C7e+XcerO8nf1fs
	BDJ0R3MO8M+2SVU0ZEyiHUHbFEv9yLE0eejlfbqPuclHTEK95TnBlAfdlp4vw/TW3GSJ3M
	+6FruNFxc+QspjVEF8EK85YqPeLdEZc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-KcAEN-UbNkSlt6GWkXe6HA-1; Tue,
 11 Jun 2024 20:20:41 -0400
X-MC-Unique: KcAEN-UbNkSlt6GWkXe6HA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48E8D19560A2;
	Wed, 12 Jun 2024 00:20:40 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A8091956087;
	Wed, 12 Jun 2024 00:20:37 +0000 (UTC)
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
Subject: [PATCH v6 0/1] nvme: queue-depth multipath iopolicy
Date: Tue, 11 Jun 2024 20:20:33 -0400
Message-Id: <20240612002034.1299922-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I've rebased this patch onto nvme-6.11, addressed all review comments,
and retested everything.

The new test results can be seen at:

https://github.com/johnmeneghini/iopolicy/tree/sample3

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

Thomas Song (1):
  nvme-multipath: implement "queue-depth" iopolicy

 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 108 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |   5 ++
 3 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.39.3


