Return-Path: <linux-kernel+bounces-268453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C69424D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ADB1F24923
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E491803D;
	Wed, 31 Jul 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/pZaaAE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9918030
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395835; cv=none; b=dlOn6LwY1J/UNPV74pOVKvEbq1yOxuN4NiZp1OyW9OE8aeu/EvLhHIbhQkjroRd6w0Y27AT+vPpA3vG2UqZWndTfMFyd1zUbYC0Z0jFz2SFneaZkdSoez+Sc2EOftwRBejqcewosZzxqkV0CKB7Lc8e0HmATCx5KeLCe0eQbMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395835; c=relaxed/simple;
	bh=JkBRTB0ebER9e6F0wnfv+1oao0kqLVhNaXL7YIZG5VY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FeXGIScrf5jkFHpsVOlLQ2/uiQrcBG6OWfXXaeMbagjERuxY6LZTMZocLqRITW0GGkudZiOEIFDV8EUe8n6JRrS2PGGLQkBo8OOySZoC8aIf0W7LR/doVSa1uyJtak1WBjstZ6RCjxaLWxgcHUb2el8eNS+awPDTYYhZyM2iW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/pZaaAE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KK/99rFb/OJa+qbI6cUHEnX47Fd/3MtoZJKyHfCgvOE=;
	b=Y/pZaaAEXIYl5IBZFYK0j9ZWQ2LvIFYSTUcfZYq8TT2Jix4cHzkVDKlRHoU5I9KYLgardw
	ftncFbxrhR6SnyxLjJNTG6akBcemM+iJXNgWLYFRZnpEH8pOV2yJiFL9KIgs6pXma2Hc8X
	/6P0K9Spl7mCr1jitJtlRfWryuERr2s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-nVVNNzlmNjm10iqHNzMEoQ-1; Tue,
 30 Jul 2024 23:17:07 -0400
X-MC-Unique: nVVNNzlmNjm10iqHNzMEoQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E2221955D44;
	Wed, 31 Jul 2024 03:17:05 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A610C1955F3B;
	Wed, 31 Jul 2024 03:16:59 +0000 (UTC)
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
Subject: [PATCH v8 0/3] vdpa: support set mac address from vdpa tool
Date: Wed, 31 Jul 2024 11:16:00 +0800
Message-ID: <20240731031653.1047692-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Changelog v7
 - change the code to reverse-xmas tree style
 - make all patches pass the check of ./scripts/checkpatch.pl --strict 
 - Address other comments
Changelog v8
- Change the fail return value to -EOPNOTSUPP
- Improve the error log
- remove the  unnecessary memcpy
  
Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 79 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.45.0


