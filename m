Return-Path: <linux-kernel+bounces-250687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F306D92FB29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222B71C2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA817108D;
	Fri, 12 Jul 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zos1Mp0l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343516FF3B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790351; cv=none; b=ehColxI3akaaI8supm2LA9foXddxMRxUP+ifNx/QIY8ivrMqQLPHVdDF41iR92Oxzn24wBG3APbhs6nC4w075+13KfBFNGvgRudyMvoGSFQkZYnMNNX20OtebjEh5UG9QLfYYLuJzoC4yoMmnY99etXCJPxOwggAi7QhsZV0CfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790351; c=relaxed/simple;
	bh=J++OFspK0s948cJ/z0bfVt1131RkLmWjkZNgDRGElYs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JZgsnHURt4fE9A9mXC78Yz/HMGkMRdSHLNutr4i1o6YTwIGPJk7WeqJZsAeRCe/VRcJNRLwc24NbxrEgIg8O7/xF9BDAWWooj3qkpG5o2Iaq7cBFq+omM/8gtQhDGXobGUsHFBhRpZStgiE+7EF0vebqGbiFA8hBadDh97+ZnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zos1Mp0l; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILHC006318;
	Fri, 12 Jul 2024 13:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=/mLzJn
	fK9hbmI4aVSg93fjSCOKiTf+2F+YF/zpFRuvQ=; b=Zos1Mp0lqN3G4lGsFl6a04
	lwzWNzaib/NFjM9jR2HEP9QSJMw6FQNOzWef0qls/f4pY2+xx9efAIoaC6fZ4Qz4
	EPUB79Cyc4obvNt5vwfaFZ3TQsrs6Hgx5YyjXTpSqa/Mepg6d7UoQBLIuQC86NRq
	SOuCNQnSrxlM8hw1X5iYcV6hUGg0gF2cD/YzuLEW1tDjgMUwkyxyWAfqCu7MiRGf
	6gjWDRTdbjTv5RDUR8g2jccc+aKnyv0CnrqZtWwe0dzNUOX6HcYJE8HCjaOAWicD
	XuusQtEaLiBIimwxBfjdoWryDO+jTJemnK9QQGFlSqJHtjm4+OSUTRZG+JmA0V6g
	==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcks2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CBVCWk022685;
	Fri, 12 Jul 2024 13:18:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsD7029886;
	Fri, 12 Jul 2024 13:18:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-1;
	Fri, 12 Jul 2024 13:18:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/7] vdpa live update
Date: Fri, 12 Jul 2024 06:18:46 -0700
Message-Id: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=803 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120089
X-Proofpoint-ORIG-GUID: 4uNO_745FSyIFbcgYAq8p1SXMMel9gKu
X-Proofpoint-GUID: 4uNO_745FSyIFbcgYAq8p1SXMMel9gKu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Live update is a technique wherein an application saves its state, exec's
to an updated version of itself, and restores its state.  Clients of the
application experience a brief suspension of service, on the order of
100's of milliseconds, but are otherwise unaffected.

Define and implement interfaces that allow vdpa devices to be preserved
across fork or exec, to support live update for applications such as QEMU.
The device must be suspended during the update, but its DMA mappings are
preserved, so the suspension is brief.

The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
accounting from one process to another.

The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
VHOST_NEW_OWNER is supported.

The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userland
address in the new process.

The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
VHOST_IOTLB_REMAP is supported and required.  Some devices do not
require it, because the userland address of each DMA mapping is discarded
after being translated to a physical address.

Here is a pseudo-code sequence for performing live update, based on
suspend + reset because resume is not yet widely available.  The vdpa device
descriptor, fd, remains open across the exec.

  ioctl(fd, VHOST_VDPA_SUSPEND)
  ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
  exec

  ioctl(fd, VHOST_NEW_OWNER)

  issue ioctls to re-create vrings

  if VHOST_BACKEND_F_IOTLB_REMAP
      foreach dma mapping
          write(fd, {VHOST_IOTLB_REMAP, new_addr})

  ioctl(fd, VHOST_VDPA_SET_STATUS,
            ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)

This is faster than VHOST_RESET_OWNER + VHOST_SET_OWNER + VHOST_IOTLB_UPDATE,
as that would would unpin and repin physical pages, which would cost multiple
seconds for large memories.

This is implemented in QEMU by the patch series "Live update: vdpa"
  https://lore.kernel.org/qemu-devel/TBD  (reference to be posted shortly)

The QEMU implementation leverages the live migration code path, but after
CPR exec's new QEMU:
  - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWNER
  - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of
    VHOST_IOTLB_UPDATE

Changes in V2:
  - clean up handling of set_map vs dma_map vs platform iommu in remap
  - augment and clarify commit messages and comments

Steve Sistare (7):
  vhost-vdpa: count pinned memory
  vhost-vdpa: pass mm to bind
  vhost-vdpa: VHOST_NEW_OWNER
  vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
  vhost-vdpa: VHOST_IOTLB_REMAP
  vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
  vdpa/mlx5: new owner capability

 drivers/vdpa/mlx5/net/mlx5_vnet.c |   3 +-
 drivers/vhost/vdpa.c              | 125 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.c             |  15 ++++
 drivers/vhost/vhost.h             |   1 +
 include/uapi/linux/vhost.h        |  10 +++
 include/uapi/linux/vhost_types.h  |  15 +++-
 6 files changed, 161 insertions(+), 8 deletions(-)

-- 
2.39.3


