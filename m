Return-Path: <linux-kernel+bounces-562171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE7A61E46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2FF3BF0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B01F4275;
	Fri, 14 Mar 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0ymh87i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADA1C54AA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988302; cv=none; b=bCUdpP+XEpVe4ymhXxq+aeFaBi3L/U7S6CUpuXgRi/gS69jNpB1OdTNeqYOzRftYrInNkUHy3L5Yv/JgInrYjLFpQcxeXPuahvZbZXPnQRTDTGpdq0bujswTvvTk0vdJ5ibNbwqyOQ+gubeT3SR+nTf0zSz3FiryU9Ng+uXTrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988302; c=relaxed/simple;
	bh=wUKSvD8vwF3thpgoejutr15OJKzXA/OuDmMmmBeuNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxqyaJprtocdxl3W7yXPUGI6sVy5QmZFSMRsBB3auMK+pstDJVAL4fj44m3PyKk/KXlg9MfLxvqBB1mzhVMnCmnkGS7Anrfnea/8LdXb96J8X21Ir6WZ1ok6TGQiamcFa0mxj9UWyzAv+RM72Ua58AVhbz4EtsKuPqcn8+d6RJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0ymh87i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x8R8SnT0xlNk6NOCsego5+xxOFgcolEZepoyw3FUxJU=;
	b=O0ymh87ixnRcTnnAJ2TTi4/4cPMQznJ9zk2zxwhdTUHEKciMmYir4IiC85tA6YJhUvXucP
	niGVhaLgpESBtDXBWjGSQtQHazoVQkw5SpZLJX294uHhsmsBUjBdRv07c/6WhCp9QEW1aa
	Phut0DfzksvKTowNCFOuxs8VTrOxxpU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-Z7N13xufNW6XUwaNZpccyg-1; Fri,
 14 Mar 2025 17:38:15 -0400
X-MC-Unique: Z7N13xufNW6XUwaNZpccyg-1
X-Mimecast-MFC-AGG-ID: Z7N13xufNW6XUwaNZpccyg_1741988292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 898481800258;
	Fri, 14 Mar 2025 21:38:11 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20D901944E42;
	Fri, 14 Mar 2025 21:38:03 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 0/4] track memory used by balloon drivers
Date: Fri, 14 Mar 2025 15:37:53 -0600
Message-ID: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series introduces a way to track memory used by balloon drivers.

Add a NR_BALLOON_PAGES counter to track how many pages are reclaimed by the
balloon drivers. First add the accounting, then updates the balloon drivers
(virtio, Hyper-V, VMware, Pseries-cmm, and Xen) to maintain this counter. The
virtio, Vmware, and pseries-cmm balloon drivers utilize the balloon_compaction
interface to allocate and free balloon pages. Other balloon drivers will have to
maintain this counter manually.

This makes the information visible in memory reporting interfaces like
/proc/meminfo, show_mem, and OOM reporting.

This provides admins visibility into their VM balloon sizes without
requiring different virtualization tooling. Furthermore, this information
is helpful when debugging an OOM inside a VM.

V2 changes:
- Add counter to the balloon_compaction interface
- Dropped patches for virtio and VMware as they use balloon_compaction interface

Tested: virtio_balloon, run stress-ng, inflate balloon, oom prints
Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (4):
  meminfo: add a per node counter for balloon drivers
  balloon_compaction: update the NR_BALLOON_PAGES state
  hv_balloon: update the NR_BALLOON_PAGES state
  xen: balloon: update the NR_BALLOON_PAGES state

 drivers/hv/hv_balloon.c | 2 ++
 drivers/xen/balloon.c   | 4 ++++
 fs/proc/meminfo.c       | 2 ++
 include/linux/mmzone.h  | 1 +
 mm/balloon_compaction.c | 2 ++
 mm/show_mem.c           | 4 +++-
 mm/vmstat.c             | 1 +
 7 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.48.1


