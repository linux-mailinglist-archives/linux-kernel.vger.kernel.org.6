Return-Path: <linux-kernel+bounces-539664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D950A4A707
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A3E189CF88
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606017BCE;
	Sat,  1 Mar 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZfQuufTh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D62D2FB;
	Sat,  1 Mar 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789309; cv=none; b=AP2W2ZPs3XqAEgHo6cZpOmkEgoaaNCREx843Q4sy9ZJI6aqI/2/r4HFWaaUhM9lUwsDNAaVwX81QFMim6MnUBEe9sS9hD39SYwKNVoIMA0SrUsRgygACGsRHjYkjkr8PbIEUR5aW9RFds6b5EoDwcscc8YrA5RaL+lxDA46BcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789309; c=relaxed/simple;
	bh=IEuRO14YdnRL/A9Gkx3TT3Wd26fHbkUoPOs8AGRadgA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pn2db1yDe4NtCB4euZpBzWzIrFoddL7mpRVmzUNOog6Z/JaY/p7HhvDTvsNesCcsDrWgFtUX6MzrLUp1URNlH5SLxXFT5uHGVVKQ4oW/o0C5O7CoqUs3OkSpdJzf+dY3jXCmxASYghY92Lia3uSZi88N8i3zxcmtxGK1dJUVikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZfQuufTh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SMj4KF030921;
	Sat, 1 Mar 2025 00:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AFexQ02lH0+4Iu6zY7kVwC
	pkKaWe3CsrR+B8JwD/L34=; b=ZfQuufThCWgzssZ1UVifiJidtTBmWEjCWhQB7h
	moe4s6Cbtjf0hZM6F4DEaD2MM6SqQMs57CIMEixOx0al/yZzcBbWCLvuNXuuhjB1
	RNBTZwRbXpDqtLpAONnTG4VT3GMtLfvIeGNsHJX8Eszg9P8UThVpsoPOgxQ3aums
	elNJjTfZbr8VTTFdmkrxDuWYubw7rpNFg0EezIzBxqSqP4x0nxJ/suIPTtWEugOB
	KCFIr0R/axnVmCj4T2T57pJMbY5KoXXdVnCaw5SxERXiRgHNWXzq77i+VPKeWFeD
	zXFxmgNfUd+7jAn5cZp9j6SnRk1qOsIANMOJ6MtC6Toiq3hw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmty28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 00:35:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5210Z257025297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 00:35:02 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Feb 2025 16:35:02 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>
Subject: [PATCH 0/2] Fix use after freed situation in UDC core
Date: Fri, 28 Feb 2025 16:34:50 -0800
Message-ID: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5lMkL-mUWlRV57X7w5ZLmG3WvqBH604s
X-Proofpoint-ORIG-GUID: 5lMkL-mUWlRV57X7w5ZLmG3WvqBH604s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=636
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503010002

commit 1ff24d40b3c3 ("usb: dwc3: gadget: Fix incorrect UDC state after
manual deconfiguration")

Added a use after freed situation due to the fact that the
usb_gadget_set_state() API queuing asynchronous work to be run at a later
time.  When moving from device to host mode, the UDC is removed, and this
is the condition where this is seen.  Relocate this fix from the DWC3
gadget, and apply it within the UDC core, so that we can properly manage
the gadget->work.  It also makes sense, as during soft disconnection
sequence, the USB link is unavailable, so any UDC should reflect the
proper state.

Wesley Cheng (2):
  Revert "usb: dwc3: gadget: Fix incorrect UDC state after manual
    deconfiguration"
  usb: gadget: udc: Update USB gadget state during soft disconnect

 drivers/usb/dwc3/gadget.c     | 2 --
 drivers/usb/gadget/udc/core.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)


