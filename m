Return-Path: <linux-kernel+bounces-282097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45B94DFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0A1F217EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22859364D6;
	Sun, 11 Aug 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="T60tgB8V"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E837A955
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343150; cv=none; b=qK50uk5uVv4gF5DsZBkuQMEHaS3JyaJ7oxsoUSixDIRBaINAKOxe5Y9AB2BGS9rZ/IMS2mKTRM1VF/LebqIXpEUO0qaW/0O0QRPwsnoCn8LiR+0PrTyuNLuISur5FkU1uD6SNlT3XEzAkkDmNFx/+BqaHE2qnc7PQvo5mAoYGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343150; c=relaxed/simple;
	bh=5grfuLks3rKXcIjtfmBZhVGPb3A/+OfU2zDVjjjF1Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBvTpQTZpQQ3MdR9jkEupd1bcfOs9vjafvJBxL1xFhV/aRwRwIgyWoAGT52MsbRQOdVtcmlP8ImdYVqZll+yIM680p0ffvDiZR+bTNqUUghyUhVs1SKc/GGLo/nmXlH+sjUl8Xus5piMLbymoYybbd6yDPzn1Y43WLeT9/yDGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=T60tgB8V; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343148;
	bh=5vYTLPKv80Hf2PmCYA6lmzGKwr8GI/3yhJpLJvGnANw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=T60tgB8VlRvZCGgy3G0takWM3wd1gGsXir6aFrswvVyE1/7DYccnqUcOLQYaPbx4s
	 13Px+mGyRWPftP7nJv37EymI3uEyaZaITyllVKlmE0vyIrXHGuxqBqeshixlRLxqNR
	 VxtEuHgyYyxCrhi8ibMHql0gpx7LRb44ecz01aEqq7I9AKG8Q6S+unL1f85/MHlQVr
	 JmFyGy3vPw3Ee5G04dwi97aB4OyYL+kSlYRR/ApuY+A86j8r7bkp51chIgKerWaD6R
	 PR5l9SrxF75wJClNo3Ff1nlSbv7h/aDQ1nObl60FbNtnvD19JWKxMpkQ78ol6BAUdU
	 gFkBnAEgk/cbA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 669F51349C2D;
	Sun, 11 Aug 2024 02:25:44 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:00 +0800
Subject: [PATCH 09/27] scsi: qla4xxx: Make iscsi_find_flashnode_sess()'s
 match function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-9-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: T4HezkSSlvT3gFmLKbqHYKm_5zxNfQmP
X-Proofpoint-ORIG-GUID: T4HezkSSlvT3gFmLKbqHYKm_5zxNfQmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=759
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified iscsi_find_flashnode_sess(), make
qla4xxx_sysfs_ddb_is_non_persistent() as its match function take
a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 17cccd14765f..34242a25cc07 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7189,7 +7189,8 @@ static void qla4xxx_build_new_nt_list(struct scsi_qla_host *ha,
  *	1: if flashnode entry is non-persistent
  *	0: if flashnode entry is persistent
  **/
-static int qla4xxx_sysfs_ddb_is_non_persistent(struct device *dev, void *data)
+static int qla4xxx_sysfs_ddb_is_non_persistent(struct device *dev,
+					       const void *data)
 {
 	struct iscsi_bus_flash_session *fnode_sess;
 

-- 
2.34.1


