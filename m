Return-Path: <linux-kernel+bounces-186930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C88CCAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B10E1F21C00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EF13AA36;
	Thu, 23 May 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFiesRxv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F38467;
	Thu, 23 May 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433223; cv=none; b=W5J9HNgsuUlYGc06UfSQif31Ag+aN9vxx2J+5xeLRX7Q5Ga3HXNJG58F+9uu8sCxpP5t/9U+wPF/0S6ILD4u8P5bvi2D4UIc6irMSq0E1x3X85fZo/muOayeBDXCSD2eArrgsTKlUQYxXYNoh+CExqPizHWm5yNuq/fC/MsqPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433223; c=relaxed/simple;
	bh=RfEfl+/zn+igK8ii6+mNs5jx+2tS7lWWvd8qVhUCM6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwMulUj/0n7B8gmAE//lkC59+Ua1f8hZUwe1KMmGbj5WG4BnX8LHXO+Q6tX1A+CjdvtNv1CyyPIc2HogVTmLDIgUB9aEkr1zWXsxh07BKOYV7OXHioNCKfETdVDyNVcGWWphybcRV/H18yGsxifPYAFW4nbFsRjnrwFPk+4GpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZFiesRxv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MJ0w6n028232;
	Thu, 23 May 2024 03:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=MEwFaR39ZmfqnamteJbkG
	QcGt49kGRuAO0GB1G3zUa8=; b=ZFiesRxvCSlSzsSFtbQGKqWsI4ME7nE6Qy90S
	ahqUpIZCCZ0kT3oQLlaAJZ2RbcE2soS5UZutyOL5osRlPwBCTmjpCELymZV/yhyN
	F4Gqlr+9bVyDMbmPYq3NUxrG74aP6+phGK+FncRY7meqhaBchXOehFSlfPe4D2US
	RvA8pqRpUNANp8ehJ1Gt2p8pHkh7uM+2vzor00nUs+PcFcvIZs0jdU4LtQ0x7vVb
	Ig4oyYCV2NLOF/xW967Z5hjkBzambmFW2hFV1SYpQitdlfBCaoo2fd6p5bD+U4y5
	etgLT2eEtTUH1Mva2pLdCHcpJU1NpQRi2t+mFxPb9Rx7XNbxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3tk8vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:00:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N30C66010818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:00:12 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:00:08 -0700
Date: Wed, 22 May 2024 20:00:01 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: AKASH KUMAR <quic_akakum@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi
	<balbi@kernel.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham
	<quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI
 USB
Message-ID: <Zk6xMRPT22meAzrG@hu-bjorande-lv.qualcomm.com>
References: <20240521074635.17938-1-quic_akakum@quicinc.com>
 <2024052134-roundness-foyer-7bfa@gregkh>
 <1ceae2a4-0715-4cea-9351-fd98a0017b85@quicinc.com>
 <2024052102-glorified-strung-80a4@gregkh>
 <e2e4bb4e-6e49-44f6-b7c7-cde274a8784b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e2e4bb4e-6e49-44f6-b7c7-cde274a8784b@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NmAujBxhm7zN-W01Gd5rp6I_UCxmp2BV
X-Proofpoint-ORIG-GUID: NmAujBxhm7zN-W01Gd5rp6I_UCxmp2BV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_14,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230018

On Wed, May 22, 2024 at 03:00:32PM +0530, AKASH KUMAR wrote:
> 
> On 5/21/2024 3:08 PM, Greg Kroah-Hartman wrote:
> 
> > On Tue, May 21, 2024 at 02:55:13PM +0530, AKASH KUMAR wrote:
> > > Hi Greg, On 5/21/2024 1:35 PM, Greg Kroah-Hartman wrote:
> > > > On Tue, May 21, 2024 at 01:16:35PM +0530, Akash Kumar wrote:
> > > > > Skip usb_early_handoff for the Renesas PCI USB controller
> > > > > due to the firmware not being loaded beforehand, which
> > > > > impacts the bootup time. Signed-off-by: Akash
> > > > > Kumar<quic_akakum@quicinc.com>
> > > > What commit id does this fix? Should it go to stable kernels?
> > > > yes it can go to stable kernels, issue is seen on every target
> > > > with usb over pcie support.
> > > > > --- drivers/usb/host/pci-quirks.c | 5 +++++ 1 file changed,
> > > > > 5 insertions(+) diff --git a/drivers/usb/host/pci-quirks.c
> > > > > b/drivers/usb/host/pci-quirks.c index
> > > > > 0b949acfa258..a0770ecc0861 100644 ---
> > > > > a/drivers/usb/host/pci-quirks.c +++
> > > > > b/drivers/usb/host/pci-quirks.c @@ -1264,6 +1264,11 @@
> > > > > static void quirk_usb_early_handoff(struct pci_dev *pdev) }
> > > > > } + /* Skip handoff for Renesas PCI USB controller on QCOM
> > > > > SOC */ + if ((pdev->vendor == PCI_VENDOR_ID_RENESAS) && +
> > > > > (pcie_find_root_port(pdev)->vendor == PCI_VENDOR_ID_QCOM))
> > > > Why are all Renesas PCI devices on a QCOM host to be marked this
> > > > way? That's a very big hammer for potentially lots of devices.
> > > > Have you tested them all?
> > > firmware loading is being done in HLOS, not UEFI, if firmware
> > > loading is done in UEFI, then calling early_handoff() API makes
> > > sense, else it is checking for controller ready without firmware
> > > loaded which is impacting boot up time by 5 sec roughly. We are
> > > seeing problem in all targets having usb over pcie support.
> > But the bootloader has nothing to do with the device type of the devices
> > here, right? Why not properly trigger this off of the needed firmware
> > location instead of here? What happens when you have a system using UEFI
> > that matches these two devices and the change causes them to break? In
> > other words, test the proper thing, and only for the specific devices
> > you need to have the change for, don't be overly broad like you are
> > doing here, as you might break other systems that you do not have in
> > front of you at the moment.
> 
> yeah currently we don't have any uefi based targets, will add target specific check.
> 

Sure we do.

And please fix your email client.

Regards,
Bjorn

