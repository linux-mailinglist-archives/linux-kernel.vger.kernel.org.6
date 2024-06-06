Return-Path: <linux-kernel+bounces-203599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B38FDDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C369285318
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62421381A4;
	Thu,  6 Jun 2024 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D8Su1yD7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5E1F93E;
	Thu,  6 Jun 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717646239; cv=none; b=oLfaVulbcsRiMFuYQGpUzpbH+W5wop50clHyuWj993AKCbe3+qqb3CDoHyV+vbvIJV7PIyJxnnjWtr6Z9K2gHSjBYTetdStWfbown0vjxTJi08Kx/9q9zfiIRsSVsFuSK9gcyL8OSy62oXl2huzfs8G8vk52GnNpCTIJoAUi9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717646239; c=relaxed/simple;
	bh=EaY5BrDdOhqaPOZCdv2iNHH25C/VSajUjdFzPDXWjEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fkclY6CFYV3+FSjaDklaTAJhx0ZNRVlcOyVr3ww/TImmlF9EWM4iRdKizYHMXUNt9lh0qDxvAOVN+le9ot0HEvtsJB7gRhIez/lwYdwOv2WegyPsj1KcRwPxhE65WADTDkm0S6wGFd6dTCoiERovwlcyQgJdCmQhq5CKrn+Ckvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D8Su1yD7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455LnxN3010981;
	Thu, 6 Jun 2024 03:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NxTScTdu+cY5qYyPDINiUC
	BeXfAZvEyVbO80czfb4ik=; b=D8Su1yD7MFETZaka79Dipqytyp8GhfqKkmst4Z
	CwYwBGWa7NxGo5uI01RKkLqMp7PnAe0YpKceBRNd1QcEVyu611BtsEwUjm/ODLwU
	icQDUq1JA6RwtfUZPdM2vrVD1mngbFGtV8yjPbImJ/Z030lOtFn8dTs4kvrCi33B
	imPrzM+yJr9YuGok8kH0/gGTK8SVIL6Kg3TR0uJ6xHN0ACi7nCVo8kp2xngk3XpT
	YW0FVPhXPIiN6DpOZWObjxm6jlpIQmI1kGtL+5vbrBF3UfFMSWYChbvIn4X8EVha
	uWEQrsh4RNm3Ca6fLZr9LrK+BHb7EY9eHOkZm5oJA/kdKs4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjhw0tswk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:57:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4563vBiO021043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 03:57:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 20:57:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 5 Jun 2024 20:57:08 -0700
Subject: [PATCH] usb: gadget: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240605-md-drivers-usb-gadget-v1-1-29847a46aad3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJQzYWYC/x3MwQqDMAyA4VeRnBeosjq3Vxk7tCargdmNREUQ3
 92643f4/w2MVdjgUW2gvIjJNxfUlwr6IeTEKFQMjWuurnUeR0JSWVgNZ4uYAiWekMnVvutad/c
 3KO1P+S3r//t8FcdgjFFD7ofz9pE8rzgGm1hh3w+PQqWohgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DE1C5Ec27rBHkuCeX4394JZcVcI_q328
X-Proofpoint-GUID: DE1C5Ec27rBHkuCeX4394JZcVcI_q328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060028

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/libcomposite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_acm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ss_lb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_obex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_ether.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ncm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_phonet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_eem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm_subset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_rndis.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_mass_storage.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_fs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_uac1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_uac1_legacy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_uac2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_uvc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_midi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_midi2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_printer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_tcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/legacy/g_zero.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/legacy/g_midi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/legacy/g_dbgp.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/usb/gadget/composite.c               | 1 +
 drivers/usb/gadget/function/f_acm.c          | 1 +
 drivers/usb/gadget/function/f_ecm.c          | 1 +
 drivers/usb/gadget/function/f_eem.c          | 1 +
 drivers/usb/gadget/function/f_fs.c           | 1 +
 drivers/usb/gadget/function/f_hid.c          | 1 +
 drivers/usb/gadget/function/f_loopback.c     | 1 +
 drivers/usb/gadget/function/f_mass_storage.c | 1 +
 drivers/usb/gadget/function/f_midi.c         | 1 +
 drivers/usb/gadget/function/f_midi2.c        | 1 +
 drivers/usb/gadget/function/f_ncm.c          | 1 +
 drivers/usb/gadget/function/f_obex.c         | 1 +
 drivers/usb/gadget/function/f_phonet.c       | 1 +
 drivers/usb/gadget/function/f_printer.c      | 1 +
 drivers/usb/gadget/function/f_rndis.c        | 1 +
 drivers/usb/gadget/function/f_serial.c       | 1 +
 drivers/usb/gadget/function/f_sourcesink.c   | 1 +
 drivers/usb/gadget/function/f_subset.c       | 1 +
 drivers/usb/gadget/function/f_tcm.c          | 1 +
 drivers/usb/gadget/function/f_uac1.c         | 1 +
 drivers/usb/gadget/function/f_uac1_legacy.c  | 1 +
 drivers/usb/gadget/function/f_uac2.c         | 1 +
 drivers/usb/gadget/function/f_uvc.c          | 1 +
 drivers/usb/gadget/function/storage_common.c | 1 +
 drivers/usb/gadget/function/u_ether.c        | 1 +
 drivers/usb/gadget/function/u_serial.c       | 1 +
 drivers/usb/gadget/legacy/dbgp.c             | 1 +
 drivers/usb/gadget/legacy/gmidi.c            | 1 +
 drivers/usb/gadget/legacy/zero.c             | 1 +
 29 files changed, 29 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 0e151b54aae8..f45d5bedda68 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2799,5 +2799,6 @@ void usb_composite_overwrite_options(struct usb_composite_dev *cdev,
 }
 EXPORT_SYMBOL_GPL(usb_composite_overwrite_options);
 
+MODULE_DESCRIPTION("infrastructure for Composite USB Gadgets");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index f616059c5e1e..724b2631f249 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -854,4 +854,5 @@ static struct usb_function_instance *acm_alloc_instance(void)
 	return &opts->func_inst;
 }
 DECLARE_USB_FUNCTION_INIT(acm, acm_alloc_instance, acm_alloc_func);
+MODULE_DESCRIPTION("USB CDC serial (ACM) function driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index f55f60639e42..6cb7771e8a69 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -966,5 +966,6 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(ecm, ecm_alloc_inst, ecm_alloc);
+MODULE_DESCRIPTION("USB CDC Ethernet (ECM) link function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index 3b445bd88498..6de81ea17274 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -674,5 +674,6 @@ static struct usb_function *eem_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(eem, eem_alloc_inst, eem_alloc);
+MODULE_DESCRIPTION("USB CDC Ethernet (EEM) link function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 1f21459b1188..d8b096859337 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -4316,5 +4316,6 @@ static char *ffs_prepare_buffer(const char __user *buf, size_t len)
 }
 
 DECLARE_USB_FUNCTION_INIT(ffs, ffs_alloc_inst, ffs_alloc);
+MODULE_DESCRIPTION("user mode file system API for USB composite function controllers");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michal Nazarewicz");
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 2db01e03bfbf..93dae017ae45 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1322,6 +1322,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
+MODULE_DESCRIPTION("USB HID function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Fabien Chouteau");
 
diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index 17ac6ace0cff..979b028edb99 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -593,4 +593,5 @@ void __exit lb_modexit(void)
 	usb_function_unregister(&Loopbackusb_func);
 }
 
+MODULE_DESCRIPTION("USB peripheral loopback configuration driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index c265a1f62fc1..cfd712fd7452 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -3577,6 +3577,7 @@ static struct usb_function *fsg_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(mass_storage, fsg_alloc_inst, fsg_alloc);
+MODULE_DESCRIPTION("Mass Storage USB Composite Function");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michal Nazarewicz");
 
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 20c6fbd94f32..67052a664e74 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -38,6 +38,7 @@
 #include "u_midi.h"
 
 MODULE_AUTHOR("Ben Williamson");
+MODULE_DESCRIPTION("USB MIDI class function driver");
 MODULE_LICENSE("GPL v2");
 
 static const char f_midi_shortname[] = "f_midi";
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index ec8cd7c7bbfc..c765f54e613d 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -2868,4 +2868,5 @@ static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 
 DECLARE_USB_FUNCTION_INIT(midi2, f_midi2_alloc_inst, f_midi2_alloc);
 
+MODULE_DESCRIPTION("USB MIDI 2.0 class function driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 0acc32ed9960..8e761249d672 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1797,5 +1797,6 @@ static struct usb_function *ncm_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(ncm, ncm_alloc_inst, ncm_alloc);
+MODULE_DESCRIPTION("USB CDC Network (NCM) link function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Yauheni Kaliuta");
diff --git a/drivers/usb/gadget/function/f_obex.c b/drivers/usb/gadget/function/f_obex.c
index dcb093210305..1305e2326cdf 100644
--- a/drivers/usb/gadget/function/f_obex.c
+++ b/drivers/usb/gadget/function/f_obex.c
@@ -487,4 +487,5 @@ static struct usb_function *obex_alloc(struct usb_function_instance *fi)
 
 DECLARE_USB_FUNCTION_INIT(obex, obex_alloc_inst, obex_alloc);
 MODULE_AUTHOR("Felipe Balbi");
+MODULE_DESCRIPTION("USB CDC OBEX function driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 0bebbdf3f213..0aa9e8224cae 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -729,4 +729,5 @@ void gphonet_cleanup(struct net_device *dev)
 
 DECLARE_USB_FUNCTION_INIT(phonet, phonet_alloc_inst, phonet_alloc);
 MODULE_AUTHOR("Rémi Denis-Courmont");
+MODULE_DESCRIPTION("USB CDC Phonet function");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index ba7d180cc9e6..280a78da26c1 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1507,6 +1507,7 @@ static struct usb_function *gprinter_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(printer, gprinter_alloc_inst, gprinter_alloc);
+MODULE_DESCRIPTION("USB printer function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Craig Nadler");
 
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index b47f99d17ee9..7cec19d65fb5 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -1013,5 +1013,6 @@ static struct usb_function *rndis_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(rndis, rndis_alloc_inst, rndis_alloc);
+MODULE_DESCRIPTION("RNDIS link function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_serial.c b/drivers/usb/gadget/function/f_serial.c
index 65c50092aea2..8f7e7a2b2ff2 100644
--- a/drivers/usb/gadget/function/f_serial.c
+++ b/drivers/usb/gadget/function/f_serial.c
@@ -392,6 +392,7 @@ static struct usb_function *gser_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(gser, gser_alloc_inst, gser_alloc);
+MODULE_DESCRIPTION("generic USB serial function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Al Borchers");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 2edbd9b510d6..6f3702210450 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -1284,4 +1284,5 @@ static void __exit sslb_modexit(void)
 module_init(sslb_modinit);
 module_exit(sslb_modexit);
 
+MODULE_DESCRIPTION("USB peripheral source/sink configuration driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/f_subset.c b/drivers/usb/gadget/function/f_subset.c
index 8ae9689ef2a0..ea3fdd842462 100644
--- a/drivers/usb/gadget/function/f_subset.c
+++ b/drivers/usb/gadget/function/f_subset.c
@@ -500,5 +500,6 @@ static struct usb_function *geth_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(geth, geth_alloc_inst, geth_alloc);
+MODULE_DESCRIPTION("\"CDC Subset\" Ethernet link function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 37befd6db001..90906d714736 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2301,5 +2301,6 @@ static void __exit tcm_exit(void)
 }
 module_exit(tcm_exit);
 
+MODULE_DESCRIPTION("Target based USB-Gadget");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sebastian Andrzej Siewior");
diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 7de74a3dd392..2b9fb4daa806 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1823,5 +1823,6 @@ static struct usb_function *f_audio_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(uac1, f_audio_alloc_inst, f_audio_alloc);
+MODULE_DESCRIPTION("USB Audio Class 1.0 Function (using u_audio API)");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ruslan Bilovol");
diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index e2d7f69128a0..49cf5aae90ca 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -1014,5 +1014,6 @@ static struct usb_function *f_audio_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(uac1_legacy, f_audio_alloc_inst, f_audio_alloc);
+MODULE_DESCRIPTION("USB Audio class function driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Bryan Wu");
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 383f6854cfec..f85ffa24a5cd 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2251,6 +2251,7 @@ static struct usb_function *afunc_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(uac2, afunc_alloc_inst, afunc_alloc);
+MODULE_DESCRIPTION("USB Audio Class 2.0 Function");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Yadwinder Singh");
 MODULE_AUTHOR("Jaswinder Singh");
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 929666805bd2..40187b7112e7 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -1118,5 +1118,6 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 }
 
 DECLARE_USB_FUNCTION_INIT(uvc, uvc_alloc_inst, uvc_alloc);
+MODULE_DESCRIPTION("USB Video Class Gadget driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Laurent Pinchart");
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index 2a4163b0f6fe..75831f2c7abe 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -537,4 +537,5 @@ ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *file
 }
 EXPORT_SYMBOL_GPL(fsg_store_forced_eject);
 
+MODULE_DESCRIPTION("Common definitions for mass storage functionality");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 11dd0b9e847f..aba8cc621e7e 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1247,5 +1247,6 @@ void gether_disconnect(struct gether *link)
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
 
+MODULE_DESCRIPTION("Ethernet-over-USB link layer utilities for Gadget stack");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Brownell");
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a92eb6d90976..eec7f7a2e40f 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1536,4 +1536,5 @@ static void __exit userial_cleanup(void)
 }
 module_exit(userial_cleanup);
 
+MODULE_DESCRIPTION("utilities for USB gadget \"serial port\"/TTY support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/legacy/dbgp.c b/drivers/usb/gadget/legacy/dbgp.c
index b62e45235e8e..d70fb5bc2357 100644
--- a/drivers/usb/gadget/legacy/dbgp.c
+++ b/drivers/usb/gadget/legacy/dbgp.c
@@ -434,6 +434,7 @@ static void __exit dbgp_exit(void)
 }
 
 MODULE_AUTHOR("Stephane Duverger");
+MODULE_DESCRIPTION("EHCI Debug Port device gadget");
 MODULE_LICENSE("GPL");
 module_init(dbgp_init);
 module_exit(dbgp_exit);
diff --git a/drivers/usb/gadget/legacy/gmidi.c b/drivers/usb/gadget/legacy/gmidi.c
index 265c392810d7..e4a419b19f45 100644
--- a/drivers/usb/gadget/legacy/gmidi.c
+++ b/drivers/usb/gadget/legacy/gmidi.c
@@ -31,6 +31,7 @@
 /*-------------------------------------------------------------------------*/
 
 MODULE_AUTHOR("Ben Williamson");
+MODULE_DESCRIPTION("USB MIDI Gadget Driver");
 MODULE_LICENSE("GPL v2");
 
 static const char longname[] = "MIDI Gadget";
diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index 23312a07efb4..e25e0d8dd387 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -425,4 +425,5 @@ static struct usb_composite_driver zero_driver = {
 module_usb_composite_driver(zero_driver);
 
 MODULE_AUTHOR("David Brownell");
+MODULE_DESCRIPTION("Gadget Zero, for USB development");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240605-md-drivers-usb-gadget-ed0158860957


