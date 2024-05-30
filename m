Return-Path: <linux-kernel+bounces-195250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F18D498C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE4B234E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C81822D0;
	Thu, 30 May 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DCvKmxTG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FF17FADB;
	Thu, 30 May 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064463; cv=none; b=OsikK/8e0Q1AqdATCyaShYvbkdZOuZm+mp7bgxSSsjhBvTdv4nHjMEW3gxtUB3ADGCdtgj6N5W1vJ7BLu9iuK3P3swFmBJ9mfNstTNIH/JN2kpBXDjN5Uul08ihE98htBP7FJqETh9pMTg066BXm5IW40O/3WyJM1JDCr4Xyhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064463; c=relaxed/simple;
	bh=pURWiVdQiIRvSEYAhn6eVcAh1jv+SW/m+hNJ1ghp4uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBAh4cjr581fOaaBMge8XGfWUFsvIIAofRiW+4ciJijbqnnbxphiMX0FHN4pqSVPIxDEW4hHDCvlO7SqysM5O8ng8d1H4dVw1thASa7Y/jj/btmsB91NoSdjiMU+1OxrODeO1xOa2qVKdpvkqhZciu1TvbYii3nc9TLceWQOCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DCvKmxTG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U83lEG013484;
	Thu, 30 May 2024 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XviRhjn8Nh0zHkNpoG6LcuMMZOwS7cMOfzDTeDj+sIg=; b=DCvKmxTGWESZgQ7j
	buiCvTMMLvgFHNrGPSg6kH4m2hJaC8cJ3Jr6Q4Xm3sF5G129mGS+ugGDdPZBR6Us
	Wu1GA5DqDz/AIPaATDTIMDfymEgdSjnDEexy2izGPcQidB7dI75xmvlGoF82iMw9
	dpbEmDa//GJFxFzyz9yqmkSzMx1UioJKsGqBBnVJMG+TDv5HKFPQkKsVwQzpdhiB
	qbx5trnJheAoeaYBk3jEzr6AkwF2FjREHmgXN/4G5J01/zSNR8R264i0+XQ0SPp3
	OUmAO6A1J0cMc7xkc1aq0Clt9Iw39bmFa053lpeV/h4fawRhE7j/DJcDHstSJ5N7
	jmBPQA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2n3m51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 10:20:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UAKu6N008562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 10:20:56 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 May 2024 03:20:54 -0700
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <quic_bkumar@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_chennak@quicinc.com>
Subject: [PATCH v3 5/9] misc: fastrpc: Redesign remote heap management
Date: Thu, 30 May 2024 15:50:23 +0530
Message-ID: <20240530102032.27179-6-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q5UVzqYmnDM0GKmSOvKT1Iul9C5a7A9F
X-Proofpoint-ORIG-GUID: q5UVzqYmnDM0GKmSOvKT1Iul9C5a7A9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300078

Current remote heap design comes with problems where all types of
buffers are getting added to interrupted list and also user unmap
request is not handling the request to unmap remote heap buffer
type. Add changes to maintain list in a way that it can be used to
to support remote heap grow/shrink request and the remote heap
buffers cleanup during static PD restart.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 221 ++++++++++++++++++++++++++++++++---------
 1 file changed, 175 insertions(+), 46 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d115860fc356..ef9bbd8c3dd1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -210,6 +210,7 @@ struct fastrpc_buf {
 	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
+	u32 flag;
 	u64 phys;
 	u64 size;
 	/* Lock for dma buf attachments */
@@ -274,6 +275,7 @@ struct fastrpc_session_ctx {
 };
 
 struct fastrpc_static_pd {
+	struct list_head rmaps;
 	char *servloc_name;
 	char *spdname;
 	void *pdrhandle;
@@ -299,7 +301,6 @@ struct fastrpc_channel_ctx {
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
@@ -1256,6 +1257,53 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 	return false;
 }
 
+static void fastrpc_mmap_remove_pdr(struct fastrpc_static_pd *spd)
+{
+	struct fastrpc_buf *buf, *b;
+	struct fastrpc_channel_ctx *cctx;
+	int err;
+
+	if (!spd || !spd->fl)
+		return;
+
+	cctx = spd->cctx;
+
+	spin_lock(&spd->fl->lock);
+	list_for_each_entry_safe(buf, b, &spd->rmaps, node) {
+		list_del(&buf->node);
+		spin_unlock(&spd->fl->lock);
+		if (cctx->vmcount) {
+			u64 src_perms = 0;
+			struct qcom_scm_vmperm dst_perms;
+			u32 i;
+
+			for (i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+				&src_perms, &dst_perms, 1);
+			if (err) {
+				pr_err("%s: Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+					__func__, buf->phys, buf->size, err);
+				return;
+			}
+		}
+		fastrpc_buf_free(buf);
+		spin_lock(&spd->fl->lock);
+	}
+	spin_unlock(&spd->fl->lock);
+}
+
+static void fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
+{
+	int i;
+
+	for (i = 0; i < FASTRPC_MAX_SPD; i++)
+		fastrpc_mmap_remove_pdr(&cctx->spd[i]);
+}
+
 static struct fastrpc_static_pd *fastrpc_get_spd_session(
 				struct fastrpc_user *fl)
 {
@@ -1282,9 +1330,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_static_pd *spd = NULL;
+	u64 phys = 0, size = 0;
 	char *name;
 	int err;
+	bool scm_done = false;
 	struct {
 		int pgid;
 		u32 namelen;
@@ -1330,25 +1381,26 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 	fl->spd = spd;
-	if (!fl->cctx->remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
-						&fl->cctx->remote_heap);
+	if (list_empty(&spd->rmaps)) {
+		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
 			goto err_name;
 
+		phys = buf->phys;
+		size = buf->size;
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
 			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-							(u64)fl->cctx->remote_heap->size,
+			err = qcom_scm_assign_mem(phys, (u64)size,
 							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
-					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+					phys, size, err);
 				goto err_map;
 			}
+			scm_done = true;
 		}
 	}
 
@@ -1365,8 +1417,8 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->phys;
-	pages[0].size = fl->cctx->remote_heap->size;
+	pages[0].addr = phys;
+	pages[0].size = size;
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1380,10 +1432,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_invoke;
 
 	kfree(args);
+	kfree(name);
+
+	if (buf) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &spd->rmaps);
+		spin_unlock(&fl->lock);
+	}
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount) {
+	if (fl->cctx->vmcount && scm_done) {
 		u64 src_perms = 0;
 		struct qcom_scm_vmperm dst_perms;
 		u32 i;
@@ -1393,15 +1452,15 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
 		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-						(u64)fl->cctx->remote_heap->size,
+		err = qcom_scm_assign_mem(phys, (u64)size,
 						&src_perms, &dst_perms, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+				phys, size, err);
 	}
 err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
+	if (buf)
+		fastrpc_buf_free(buf);
 err_name:
 	kfree(name);
 err:
@@ -1866,17 +1925,16 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	return 0;
 }
 
-static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
+static int fastrpc_req_munmap_dsp(struct fastrpc_user *fl, uintptr_t raddr, u64 size)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
 	struct fastrpc_munmap_req_msg req_msg;
-	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
 
 	req_msg.pgid = fl->tgid;
-	req_msg.size = buf->size;
-	req_msg.vaddr = buf->raddr;
+	req_msg.size = size;
+	req_msg.vaddr = raddr;
 
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
@@ -1884,11 +1942,38 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
+
+	return err;
+}
+
+static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
+{
+	struct device *dev = fl->sctx->dev;
+	int err;
+
+	err = fastrpc_req_munmap_dsp(fl, buf->raddr, buf->size);
 	if (!err) {
+		if (buf->flag == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+			if (fl->cctx->vmcount) {
+				u64 src_perms = 0;
+				struct qcom_scm_vmperm dst_perms;
+				u32 i;
+
+				for (i = 0; i < fl->cctx->vmcount; i++)
+					src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+
+				dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+				dst_perms.perm = QCOM_SCM_PERM_RWX;
+				err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+								&src_perms, &dst_perms, 1);
+				if (err) {
+					dev_err(dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+						buf->phys, buf->size, err);
+					return err;
+				}
+			}
+		}
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1902,6 +1987,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl->sctx->dev;
+	int err = 0;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1910,20 +1996,48 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
 		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
 			buf = iter;
+			list_del(&buf->node);
 			break;
 		}
 	}
 	spin_unlock(&fl->lock);
 
-	if (!buf) {
-		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
-			req.vaddrout, req.size);
-		return -EINVAL;
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		if (err) {
+			spin_lock(&fl->lock);
+			list_add_tail(&buf->node, &fl->mmaps);
+			spin_unlock(&fl->lock);
+		}
+		return err;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	spin_lock(&fl->lock);
+	if (fl->spd) {
+		list_for_each_entry_safe(iter, b, &fl->spd->rmaps, node) {
+			if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+				buf = iter;
+				list_del(&buf->node);
+				break;
+			}
+		}
+	}
+	spin_unlock(&fl->lock);
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		if (err) {
+			spin_lock(&fl->lock);
+			list_add_tail(&buf->node, &fl->spd->rmaps);
+			spin_unlock(&fl->lock);
+		}
+		return err;
+	}
+	dev_err(dev, "buffer not found addr 0x%09lx, len 0x%08llx\n",
+			req.vaddrout, req.size);
+	return -EINVAL;
 }
 
+
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
@@ -1950,16 +2064,34 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+		if (!fl->spd || !fl->spd->ispdup) {
+			dev_err(dev, "remote heap request supported only for active static PD\n");
+			return -EINVAL;
+		}
 		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
-	else
+	} else {
 		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+	}
 
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
 	}
+	buf->flag = req.flags;
 
+	/* Add memory to static PD pool, protection through hypervisor */
+	if ((req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) && fl->cctx->vmcount) {
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
+		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
+		if (err) {
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+					buf->phys, buf->size, err);
+			goto err_invoke;
+		}
+	}
 	req_msg.pgid = fl->tgid;
 	req_msg.flags = req.flags;
 	req_msg.vaddr = req.vaddrin;
@@ -1991,26 +2123,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
-	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
-			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
-		if (err) {
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
-					buf->phys, buf->size, err);
-			goto err_assign;
-		}
-	}
 
 	spin_lock(&fl->lock);
-	list_add_tail(&buf->node, &fl->mmaps);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		list_add_tail(&buf->node, &fl->spd->rmaps);
+	else
+		list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		err = -EFAULT;
-		goto err_assign;
+		goto err_copy;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
@@ -2018,14 +2141,19 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	return 0;
 
-err_assign:
+err_copy:
+	spin_lock(&fl->lock);
+	list_del(&buf->node);
+	spin_unlock(&fl->lock);
 	fastrpc_req_munmap_impl(fl, buf);
+	buf = NULL;
 err_invoke:
 	fastrpc_buf_free(buf);
 
 	return err;
 }
 
+
 static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
@@ -2249,6 +2377,7 @@ static void fastrpc_pdr_cb(int state, char *service_path, void *priv)
 			spd->servloc_name,
 			domains[cctx->domain_id]);
 		spd->ispdup = false;
+		fastrpc_mmap_remove_pdr(spd);
 		fastrpc_notify_pdr_drivers(cctx, spd->servloc_name);
 		break;
 	case SERVREG_SERVICE_STATE_UP:
@@ -2400,6 +2529,7 @@ static int fastrpc_setup_service_locator(struct fastrpc_channel_ctx *cctx, char
 	cctx->spd[spd_session].servloc_name = client_name;
 	cctx->spd[spd_session].spdname = service_path;
 	cctx->spd[spd_session].cctx = cctx;
+	INIT_LIST_HEAD(&cctx->spd[spd_session].rmaps);
 	service = pdr_add_lookup(handle, service_name, service_path);
 	if (IS_ERR(service)) {
 		err = PTR_ERR(service);
@@ -2566,9 +2696,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
-
 	for (i = 0; i < FASTRPC_MAX_SPD; i++) {
 		if (cctx->spd[i].pdrhandle)
 			pdr_handle_release(cctx->spd[i].pdrhandle);
@@ -2576,6 +2703,8 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	of_platform_depopulate(&rpdev->dev);
 
+	fastrpc_mmap_remove_ssr(cctx);
+
 	fastrpc_channel_ctx_put(cctx);
 }
 
-- 
2.43.0


