Return-Path: <linux-kernel+bounces-185991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896408CBDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB691C22171
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDF8120C;
	Wed, 22 May 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bvXgbRtY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E37D3F5;
	Wed, 22 May 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370248; cv=none; b=nBXxql48pd4Ps2nDursPJLTSrWBam6XYl1/Ov43RyxtZNI6MOOvJKXsE5cDl8TkFt8LIF/zteKEBNPIeRP5YA6NnTIzMT+g9GDAnoSGiWzPujnD/4PqaXbDwYwsirQw0UfSn/67KtlpgYtTogRmSIYIVZNr1Xz6pq4SBZRQsf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370248; c=relaxed/simple;
	bh=a691/9SYo0NKiTnhM4MGzJN3tQwhGkEXyRsB6mtMO3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IUxI8fLCRXSc64D5DV9ZZmj6YiYEDAPGQvVvGS1yRrmf0ZoaQpTyHLHY0qlYdhv9CZJPPBoxUIZtLJXs7XNq8BnWf/BXnp5LI/OlcKnQvmkX+o9NcowEMjrM9nf5fW4E7O3qmLaSeSgqvGk1SZs3PYE/RRb5C3tS5IEG2buGdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bvXgbRtY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M8WMgS004387;
	Wed, 22 May 2024 09:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QnM4WACfCF8VuTUQwFpZpJKatdFA2CHN3v2b1i0LQSs=; b=bv
	XgbRtY3bz2mbRkyhlugNASPEhW4dVQLmZVbNnNmgwQRlpU2rgQ4Rb4gB+ZVnJW2L
	ZK7gRwaJbO8YqseYdGy4hBC8ewRLOXRfrdQcNbsA5XOWm+8iooKLHDcwOvbbNUn0
	6+/W3KGHXbc7VoECFkkueaDp3wfJwLWtlJl7fSHTFipL02whyBYHFJlLwv/omkyX
	+6Jg1RLkpEhcbuXGAOVcR0aP4+2oa8FnvJjGlqQxfH380YrJ2y1lLtffhWXtjw7C
	I2UWj4bHkJ1L2w4Is9op/5p1TcWBiUZZQAjFEMpu19dK/m/1O9xJsLMqAzlurG/y
	+EDTvx3N1l5210qlopIw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqarc8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:30:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M9UfuN001980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 09:30:41 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 02:30:35 -0700
Message-ID: <e2e4bb4e-6e49-44f6-b7c7-cde274a8784b@quicinc.com>
Date: Wed, 22 May 2024 15:00:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI
 USB
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Felipe Balbi <balbi@kernel.org>,
        Pratham Pratap
	<quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Vijayavardhan
 Vennapusa" <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240521074635.17938-1-quic_akakum@quicinc.com>
 <2024052134-roundness-foyer-7bfa@gregkh>
 <1ceae2a4-0715-4cea-9351-fd98a0017b85@quicinc.com>
 <2024052102-glorified-strung-80a4@gregkh>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <2024052102-glorified-strung-80a4@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-nDka7d5xR0NACM44ds188RSwq3GxjI
X-Proofpoint-ORIG-GUID: Z-nDka7d5xR0NACM44ds188RSwq3GxjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_04,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405220068


On 5/21/2024 3:08 PM, Greg Kroah-Hartman wrote:

> On Tue, May 21, 2024 at 02:55:13PM +0530, AKASH KUMAR wrote:
>> Hi Greg, On 5/21/2024 1:35 PM, Greg Kroah-Hartman wrote:
>>> On Tue, May 21, 2024 at 01:16:35PM +0530, Akash Kumar wrote:
>>>> Skip usb_early_handoff for the Renesas PCI USB controller due to 
>>>> the firmware not being loaded beforehand, which impacts the bootup 
>>>> time. Signed-off-by: Akash Kumar<quic_akakum@quicinc.com>
>>> What commit id does this fix? Should it go to stable kernels? yes it 
>>> can go to stable kernels, issue is seen on every target with usb 
>>> over pcie support.
>>>> --- drivers/usb/host/pci-quirks.c | 5 +++++ 1 file changed, 5 
>>>> insertions(+) diff --git a/drivers/usb/host/pci-quirks.c 
>>>> b/drivers/usb/host/pci-quirks.c index 0b949acfa258..a0770ecc0861 
>>>> 100644 --- a/drivers/usb/host/pci-quirks.c +++ 
>>>> b/drivers/usb/host/pci-quirks.c @@ -1264,6 +1264,11 @@ static void 
>>>> quirk_usb_early_handoff(struct pci_dev *pdev) } } + /* Skip handoff 
>>>> for Renesas PCI USB controller on QCOM SOC */ + if ((pdev->vendor 
>>>> == PCI_VENDOR_ID_RENESAS) && + (pcie_find_root_port(pdev)->vendor 
>>>> == PCI_VENDOR_ID_QCOM))
>>> Why are all Renesas PCI devices on a QCOM host to be marked this 
>>> way? That's a very big hammer for potentially lots of devices. Have 
>>> you tested them all?
>> firmware loading is being done in HLOS, not UEFI, if firmware loading 
>> is done in UEFI, then calling early_handoff() API makes sense, else 
>> it is checking for controller ready without firmware loaded which is 
>> impacting boot up time by 5 sec roughly. We are seeing problem in all 
>> targets having usb over pcie support.
> But the bootloader has nothing to do with the device type of the 
> devices here, right? Why not properly trigger this off of the needed 
> firmware location instead of here? What happens when you have a system 
> using UEFI that matches these two devices and the change causes them 
> to break? In other words, test the proper thing, and only for the 
> specific devices you need to have the change for, don't be overly 
> broad like you are doing here, as you might break other systems that 
> you do not have in front of you at the moment.

yeah currently we don't have any uefi based targets, will add target specific check.

Thanks,

Akash


