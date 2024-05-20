Return-Path: <linux-kernel+bounces-183896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E98C9F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA70B1F21802
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019D13774A;
	Mon, 20 May 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPWN9hRT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B8136E05
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218481; cv=none; b=fyL0BXSlsmoeYRL7WxMotCzcBYC4oxhF0mWD0nioKBleti3fKHO6Xw3zE5WjsVjteHOwJdTQzBzpVi0XDwTrcmqXTDfzCxawXeaCtCYF+U6AWRwucqumt59BrhRqxXEYPmwthEfr+REU+pdydYCt+kWmLWLlQ4Hkm743ovSF7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218481; c=relaxed/simple;
	bh=V2eBgGmN6lPZIjeppPTRl+kJSvEQj2BfLxHuAEveWws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kIZFaSXuUSxFR7oqR4SX+yoD7KPJSKxXvLyvKiObnmW6Xiv9Qhp3n6xVu7udB8RmBgOOyNe+QTym0Gut30aIGD+qUZGJDukwgkyaYfTzkFzaxACoPCS3g0jXAkhDYLhtdap+3pvk6giUL8OVBsYUNLcluepSU0aYcCx0RXZWDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kPWN9hRT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEPKuZ027893;
	Mon, 20 May 2024 15:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=fISmQfEMf2/rDg/w9UA/s9DtZTN/+2SzLGbgOVR/jS0=;
 b=kPWN9hRT/M6zjGCHbF/aCZ/tffzGA8F992WwG+46k1diZOhZwH8DlfrRMp3XldiUYgHX
 yrvUXtr3t1l62NK+DCAwJGmz4oZMDM7Rl6DqW9f5mF5UK1/LZ4rPNi8TuDYw1NkNKu6Y
 MilfRYgvblw1w+z0U+PFXYtHhS5ipej4q4qh7yoVFeVNlVd7qh08LLYeFYCmQQXvblqH
 qmLmjBCiOpkDySdhyfiawUhSy1Zcpe4yuyo8dOXfYVuWgDUNvsEY/c6phqTf7O2TIrTs
 3ak+eRayw4WWfFyKS9MtrRypSr/a36dpU+FdnaDTa+PozQLWGNidC7doAlUQj/8IAzRR Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b2smy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KE2nQU002749;
	Mon, 20 May 2024 15:21:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cy7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19X038962;
	Mon, 20 May 2024 15:21:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-1;
	Mon, 20 May 2024 15:21:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/3] flush workers on suspend
Date: Mon, 20 May 2024 08:20:59 -0700
Message-Id: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=571
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200122
X-Proofpoint-ORIG-GUID: gqnrVHdfhIowfQbYlsHHmaNKxkrIMo8s
X-Proofpoint-GUID: gqnrVHdfhIowfQbYlsHHmaNKxkrIMo8s

Flush to guarantee no workers are running when suspend returns,
for vdpa, vdpa_sim, and vduse.  (mlx5 already does so, via the path
mlx5_vdpa_suspend -> unregister_link_notifier -> flush_workqueue.)

Changes in V2:
  - renamed "vduse: suspend" (was vduse: flush workers on suspend)
  - call vhost_dev_flush unconditionally in "vhost-vdpa: flush workers on suspend"

Changes in v3:
  - rewrote vdpa_sim patch

Steve Sistare (3):
  vhost-vdpa: flush workers on suspend
  vduse: suspend
  vdpa_sim: flush workers on suspend

 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vdpa.c               |  3 +++
 4 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.39.3


