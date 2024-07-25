Return-Path: <linux-kernel+bounces-261633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998793BA28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0601CB23C74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66C6FC1;
	Thu, 25 Jul 2024 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI6rUXWM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7B20EB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871153; cv=none; b=Q3TKmGA6RL5DOC++y1/0hZj5GjFmoOsxyi47ZQohtatE8cKf/Apkn17nGBOXXGwCW8k5FwZBv1cXGUzzY3OPX1vsIkYo6U45b6BBD6XlJA0bQPFtxmKjwSXSnEBgjRmy7n4nuH1nJIXUnZGTAivNt0BkY8GINBO1nTTGTD21dEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871153; c=relaxed/simple;
	bh=f5IcGXYse95pgYaA+PA4U920JSA5b88X1Xog3re2538=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sQe/S0oTuDizpu6sS5Co1BFTbcX/qv7opZInWpMNmDP9J/F1RFPtbVgHtWqjXRWc5QlZu5vLgKuf1ZzJPEORwgF+SoAM85sUSqed0bCKvwEZ8ApXJqot3srSs4kkRmLsKV2Jg/bkG7WG+6kSF0PP+DLMpJ8vA+UIKOff2hLcnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bI6rUXWM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721871150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3AFvrky8PX7geVy4VOlD+26UP7h3zv3ayB+/222jDiQ=;
	b=bI6rUXWM7GpuEV+jid4gT2NAHZzjaMAT7eoQJoLhEhio4nnmIlQ/zmFoYEUs8+JdZYCv+x
	+T5HP88NykzXBZUODdGt6kpGbx2yBnjHntu3dJss/7C1ztAMJ5yQloEjZnwdA/mCj6L7HX
	6UofiC8DxZX/oEYMWu59GcnP2sKQFv8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-Cxb1LMW5NW-3XnmWQtYOiA-1; Wed,
 24 Jul 2024 21:32:27 -0400
X-MC-Unique: Cxb1LMW5NW-3XnmWQtYOiA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7701955D45;
	Thu, 25 Jul 2024 01:32:26 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E54031955D42;
	Thu, 25 Jul 2024 01:32:20 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
Date: Thu, 25 Jul 2024 09:31:01 +0800
Message-ID: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments
Changelog v3
 - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
 - Add a lock for the network device's dev_set_attr operation
 - Address the comments
Changelog v4
 - Address the comments
 - Add a lock for the vdap_sim?_net device's dev_set_attr operation
Changelog v5
 - Address the comments
Changelog v6 
- Replace all the memcpy of mac address with ether_addr_copy()
- Remove the check for VIRTIO_NET_F_MAC in vdpa_dev_net_device_attr_set
- Remove unnecessary check
- Enhance the error log

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 80 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 139 insertions(+), 1 deletion(-)

-- 
2.45.0


