Return-Path: <linux-kernel+bounces-396028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD89BC6EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF8FB227A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E61FE0F9;
	Tue,  5 Nov 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc4LtAyV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAC1FDF96
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791628; cv=none; b=B8ULS1rvqBpiIRh7qzS8UYhgXMZdy8f50OTBP1oHA7r5Xl3h3FhvSdRm56VrB8q5Fq2Q+Jj/lhuvdIsL/WG9OxfkNCNMFk9HLH3B1lXl4ADoVV5xwk4mzMpHFwNsw4UWBDqu0M4tLRxcAwNih1wUZtR+KDDWCetbxIaLgRfPmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791628; c=relaxed/simple;
	bh=K37jmAn+i46/q7llMx3NfKkl2XmueoFEhPKnmfV/LFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GZgChoTldNnhunAzNX3QwnVsFNiuQowr3GDIUNIZ4V6jq9j/sCjGx4p5ndZsWa7ITAw53KAJH/j5z1XdcK0rC9dzYElWH8mZDQi92LCfVwVBl3x2Rj2qVSXvxEJpaOio1I/5Ebct7zlpf2TmtxMUd0ykCRRWTFRBb8XJvKT0a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc4LtAyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IAbznj+213o8XKlRU5NeNrKkcB2wGB6raPasxImqtUc=;
	b=Uc4LtAyVNz35hccRvL4EgABY3yi842Wz20WYlFeFQ3qfrTzC7MSTT9pnudj5D/Q6RCRyHv
	VKrsdHQZbFfQGKzEJK0THuyDczm7OPz0+OIneIkWmRjN6umgT/IcJhW8YRcW+Hu6i6qvKq
	cZNZPOgma9rxguM/85pFLIBVtc1Q1UE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-Rn67miV2MzKREizuAw3kQA-1; Tue,
 05 Nov 2024 02:27:02 -0500
X-MC-Unique: Rn67miV2MzKREizuAw3kQA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D48195608A;
	Tue,  5 Nov 2024 07:27:00 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00B811956086;
	Tue,  5 Nov 2024 07:26:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/9] vhost: Add support of kthread API
Date: Tue,  5 Nov 2024 15:25:19 +0800
Message-ID: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
The vhost now use vhost_task and workers working as a child of the owner thread,
which aligns with containerization principles. However, this change has caused
confusion for some legacy userspace applications. 
Therefore, we are reintroducing support for the kthread API.

In this patch, we introduce a module_param that allows users to select the
operating mode. Additionally, a new UAPI is implemented to enable
userspace applications to set their desired mode

Changelog v2: 
 1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
 2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
 
Changelog v3: 
 1. Change the module_param's name to inherit_owner_default, and the default value is true.
 2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
 3. device will have their own inherit_owner in struct vhost_dev
 4. Address other comments
 
Tested with QEMU.

Cindy Lu (9):
  vhost: Add a new parameter to allow user select kthread
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_worker_destroy()
  vhost: Add new UAPI to support change to task mode
  vhost_scsi: Add check for inherit_owner status
  vhost: Expose the modparam inherit_owner_default

 drivers/vhost/scsi.c       |   5 +
 drivers/vhost/vhost.c      | 194 ++++++++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h      |   7 ++
 include/uapi/linux/vhost.h |   2 +
 4 files changed, 193 insertions(+), 15 deletions(-)

-- 
2.45.0


