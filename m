Return-Path: <linux-kernel+bounces-250692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84492FB2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73D0B2300F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D0172BCC;
	Fri, 12 Jul 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxbMcKV/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F216FF37
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790352; cv=none; b=qLNL8eyMEib1hAOx2OhUuKquSnQiLTu+2gMuSjEZ8A06ASIKbPRAdQteur8T8tV5ed4zNBwtZwWl6vssGBpn0eVjr9hEofjkOC/bP6qVOt3OfWvu5/grqfvEGLtC/1/q5xQXARCaZRN3t0k2CqOQWUGtnhNWSjxKyEUkuKbTWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790352; c=relaxed/simple;
	bh=ewuv2DScA0KHxHepz7iXXuaiIDkgzMtLA9LufqTlxbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eP2DTxIQjJzzKmMuw0Z4Km/+CydeEpO31+gitqvf2kR1w/UokWpKk/QuKiDmJTg3Tctv8Rxr0XBCJOhec9QdyWaC1OHMqSWmJHT8uOxadtuXlQbfxyBsCQMcgWi7fk07N3VzSu1CBsKPL0RA2PW4S/4M3GGVuVv59rdrjhDlOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxbMcKV/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIMh6006357;
	Fri, 12 Jul 2024 13:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=NKJsM7SEgeGt3SGI1oZ28F9YAfkS43VBsojMb2tfJ4c=; b=
	NxbMcKV/ywPtyLZRPasj3UaP9A39pjhmzmwj/ZvxWq7HDFNGrVWrL6vBqe8LRvtz
	1CUwKG5XHMnCtVLghE68W/CyTDLypyUPK+XR+XBum2qCOxeVJKsQ0ymO145uxlaO
	By24YmV7NrHZDoyCHLpVjaAtWUQfqQVhujIP8ouE8mi/RxKItqm4oa5NDjbo4kys
	GhGenKdaBBGwmsQ/UDpZT0Xl9p7ffizBq+QDd9cDuhjvZgpgKTZKx/UAQjtu5Lim
	+CbKqvOQR/vxvvAMfkJZ3JZP2QG2Q+9TsiD9ALOcyDBTDFpOi6Y+Yni0dlNysAfA
	719VCHQ6TKXIMjXqXda1bQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcks2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCVnUN022018;
	Fri, 12 Jul 2024 13:18:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDD029886;
	Fri, 12 Jul 2024 13:18:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-4;
	Fri, 12 Jul 2024 13:18:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
Date: Fri, 12 Jul 2024 06:18:49 -0700
Message-Id: <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120089
X-Proofpoint-ORIG-GUID: No6kTf_mUWNt04cQaojtpklUJkOHJeFn
X-Proofpoint-GUID: No6kTf_mUWNt04cQaojtpklUJkOHJeFn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an ioctl to transfer file descriptor ownership and pinned memory
accounting from one process to another.

This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
as that would unpin all physical pages, requiring them to be repinned in
the new process.  That would cost multiple seconds for large memories, and
be incurred during a virtual machine's pause time during live update.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c      | 15 ++++++++++++++
 drivers/vhost/vhost.h      |  1 +
 include/uapi/linux/vhost.h | 10 ++++++++++
 4 files changed, 67 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b49e5831b3f0..5cf55ca4ec02 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	return ret;
 }
 
+static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
+{
+	int r;
+	struct vhost_dev *vdev = &v->vdev;
+	struct mm_struct *mm_old = vdev->mm;
+	struct mm_struct *mm_new = current->mm;
+	long pinned_vm = v->pinned_vm;
+	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+
+	if (!mm_old)
+		return -EINVAL;
+	mmgrab(mm_old);
+
+	if (!v->vdpa->use_va &&
+	    pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
+		r = -ENOMEM;
+		goto out;
+	}
+	r = vhost_vdpa_bind_mm(v, mm_new);
+	if (r)
+		goto out;
+
+	r = vhost_dev_new_owner(vdev);
+	if (r) {
+		vhost_vdpa_bind_mm(v, mm_old);
+		goto out;
+	}
+
+	if (!v->vdpa->use_va) {
+		atomic64_sub(pinned_vm, &mm_old->pinned_vm);
+		atomic64_add(pinned_vm, &mm_new->pinned_vm);
+	}
+
+out:
+	mmdrop(mm_old);
+	return r;
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_RESUME:
 		r = vhost_vdpa_resume(v);
 		break;
+	case VHOST_NEW_OWNER:
+		r = vhost_vdpa_new_owner(v);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b60955682474..ab40ae50552f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
 
+/* Caller should have device mutex */
+long vhost_dev_new_owner(struct vhost_dev *dev)
+{
+	if (dev->mm == current->mm)
+		return -EBUSY;
+
+	if (!vhost_dev_has_owner(dev))
+		return -EINVAL;
+
+	vhost_detach_mm(dev);
+	vhost_attach_mm(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vhost_dev_new_owner);
+
 static struct vhost_iotlb *iotlb_alloc(void)
 {
 	return vhost_iotlb_alloc(max_iotlb_entries,
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..8b2018bb02b1 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -187,6 +187,7 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 				       struct vhost_iotlb_msg *msg));
 long vhost_dev_set_owner(struct vhost_dev *dev);
+long vhost_dev_new_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..543d0e3434c3 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -123,6 +123,16 @@
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
+/* Set current process as the new owner of this file descriptor.  The fd must
+ * already be owned, via a prior call to VHOST_SET_OWNER.  The pinned memory
+ * count is transferred from the previous to the new owner.
+ * Errors:
+ *   EINVAL: not owned
+ *   EBUSY:  caller is already the owner
+ *   ENOMEM: RLIMIT_MEMLOCK exceeded
+ */
+#define VHOST_NEW_OWNER _IO(VHOST_VIRTIO, 0x27)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.39.3


