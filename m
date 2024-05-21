Return-Path: <linux-kernel+bounces-184714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B68CAAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825BE28114E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3C6BB54;
	Tue, 21 May 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h4XWxlRa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA51605CE;
	Tue, 21 May 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284193; cv=none; b=Ln/KOZ6bmiV2vkyRmvZ7xBz83nqaJNhxCofA4wv9ViReGb/VzJBP/lwqNwyhOS0G5yIN/maKCXpICwZIZw+YIqegcF8/hKKOuNrRb+3OxYFD+W8PyLQrCWhagvmC7LUpItFUJbFsvZW38X6nD2VkllWUehT1TX67/ikXqRLBJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284193; c=relaxed/simple;
	bh=aZ9KTA3NSZzS8QeCimSEWzDSSXkr6lkyH2AAhT2CxOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=aX1HM7vXqPrlSA0ZRy11+IjAWki4CTFN2ZaYG22aX+f+RpZ+nuLiWF0nYB4AuJWX6rMqsmVZxowAYgK6hPORHeW5we6I3XCg0eEsTrT+mIAgn5SCSAwVH1ZUj6HzkbQgXcCjobviEHvdFfxneySSg6BeoGXvBS0r9sYF6XCXpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h4XWxlRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L2muCh019783;
	Tue, 21 May 2024 09:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qI1oTQmT40vvo2dT8GWELI8VX5shz/FEUwrm6Ztocvo=; b=h4
	XWxlRatrACEZKdsXfkpn9M1kXJx3zapfWk3tVtmOsFVTtJI0L5fxeWNXZHF9JGtx
	y/9534q541rkCeI89TaeA8EceI7J3D4jKmDNHK7b+SxWNG1m4FikgH1qJdRbnS42
	ep01HgMpG772HYUDgGL/dE00oF9ovBvloebqDf1qbcrNgNpsYb2EwXiNcONPTZeb
	BIbtsVp8/Pk4IXo5pH7Vbr8JqoxzvRZqy2714qIgZXzoof0ImWK/Ou1Uu5JH8SyE
	Xo8pwgS4awpM1GdsU9U3wuvrRbr5qr537sRa4VcRsvFXhtPDlpjeCo8LcrOtjLuP
	QVEtqHK02MZKm4k2yNdA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq5ddk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 09:36:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L9aSGl002777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 09:36:28 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 02:36:20 -0700
Message-ID: <f9e0545d-cf00-447b-a1cf-8251e3fe9ffb@quicinc.com>
Date: Tue, 21 May 2024 15:06:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI
 USB
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
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
In-Reply-To: <1ceae2a4-0715-4cea-9351-fd98a0017b85@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M2fQu6igYkd19n8AS39jqhZnIc2e9gYx
X-Proofpoint-ORIG-GUID: M2fQu6igYkd19n8AS39jqhZnIc2e9gYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_06,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210071

Hi Greg,On 5/21/2024 1:35 PM, Greg Kroah-Hartman wrote: > On Tue, May 21, 2024 
at 01:16:35PM +0530, Akash Kumar wrote: >> Skip usb_early_handoff for 
the Renesas PCI USB controller due to >> the firmware not being loaded 
beforehand, which impacts the bootup >> time. >> >> Signed-off-by: Akash 
Kumar <quic_akakum@quicinc.com> > What commit id does this fix? Should 
it go to stable kernels? yes it can go to stable kernels, issue is seen on every target with usb over pcie support. >> --- >> drivers/usb/host/pci-quirks.c | 5 +++++ >> 1 file changed, 5 
insertions(+) >> >> diff --git a/drivers/usb/host/pci-quirks.c 
b/drivers/usb/host/pci-quirks.c >> index 0b949acfa258..a0770ecc0861 
100644 >> --- a/drivers/usb/host/pci-quirks.c >> +++ 
b/drivers/usb/host/pci-quirks.c >> @@ -1264,6 +1264,11 @@ static void 
quirk_usb_early_handoff(struct pci_dev *pdev) >> } >> } >> >> + /* Skip 
handoff for Renesas PCI USB controller on QCOM SOC */ >> + if 
((pdev->vendor == PCI_VENDOR_ID_RENESAS) && >> + 
(pcie_find_root_port(pdev)->vendor == PCI_VENDOR_ID_QCOM)) > Why are all 
Renesas PCI devices on a QCOM host to be marked this way? > That's a 
very big hammer for potentially lots of devices. Have you > tested them 
all? firmware loading is being done in HLOS, not UEFI,
if firmware loading is done in UEFI, then calling early_handoff() API makes sense,
else it is checking for controller ready without firmware loaded which is impacting boot up time by 5 sec roughly.
We are seeing problem in all targets having usb over pcie support. > thanks, > > greg k-h Thanks,
Akash


