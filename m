Return-Path: <linux-kernel+bounces-560532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668EA6062E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43ED3B3A07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFA1F9A8B;
	Thu, 13 Mar 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dwGqZGNB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CAB1F428D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909731; cv=none; b=Epqcxfb0mkGxyr3dZQCgRChqHcjJanTgCJ+NgRioYmgIpeXyCW0fKkKJwSSkCDp374Q6Nx2VF57q0FpoIyCVtIntBlO7jT6oNSTZwmhZPNVOrgQiMp0SycAVjYx2bgVmm5hF05LEnRDWZplIdgCJKb4wW96l6grpWp8QxQiKoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909731; c=relaxed/simple;
	bh=0lu8oU1tyqYj57FgsKOmobIAzRwBp7FW+RRAsiYBpss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWSVaoB1H0KhyUI2Opbxdsu0JeCpsdJkeJhVqJsCT/zTV6EAa3VE0fIQSGcPE3cuUtYV9DezUF0v8/mZ09adxPS+dERc67jFVSmJtTOI/ir+Wbllcchsd3sMViz2cnnUa9bFSqtQn1z5NmK3WRiwj8EFD94T2jBs4tHc0PhWJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dwGqZGNB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DJj40e028516
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=; b=dwGqZGNB2o/W1vhD
	lMvadEKnxYanIo9kqSUDcDRjzYmf0TZceWIIFAN5IMf9GLnu0vKfBl3PmMir/KAk
	WlP/r2ERc2k4tD8cZEiRtt8U6GhiW/3HsZAfKDfDxREL6QCLQJZumrxiCZoUrobj
	pPSJMo/CUvLm3P7FqRGHPp/lUzAaaD0iIqgbxHEUd4/4JGcTN2GOIwGJM+Pw/Y24
	/IjsOyMx6/5dwvtNvPO93+76BHj4j8w1KpQldr2S6nNQXj5cvMNNm1fjqL3bhgOJ
	7VUI9ZyZbtkc0yR2cfQX6LW2QF7I3TlWpXNfCgJDt7E7kXr0g2A23DXmkNyrdAsY
	oWs4Hg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pyepy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:48:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223477ba158so41892025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741909727; x=1742514527;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zkd/Jggqn86Uyh/5JzZQRlmlyi5xVymwBZ1NTqzN0CE=;
        b=Ftb00aYPXx6AggYZGnmfvSPYZ6npdQOdLvf2Dnm9pl8rpMSTSsTLHVpjWYSgR6kf+w
         5mzTsPb6qUvMC42w6VW2jLlx3SiEMeJkFbrDjO7dTibXB3lq2JZUSOFuqB1AKkzoIwr3
         qF5/0x0fBRn8/cMSmyl7k1K3xcaIqOgdkIw79etQHb0WcSRgc42u2Br2cHJvzQgh7NSt
         q42vSpdMQiztzm2jauY/EMjghg+65U5/HoBrGsafTBAkRv2Xx5egkp1KugHJzdH098pE
         G+VSQom7k7iZT0k2PDbk6lzwkWN5CeJ0agOP0cgRoeLLM0vhY7p+9Rts90AtcI2bLApE
         mz0A==
X-Forwarded-Encrypted: i=1; AJvYcCV5KTHOxtgkJ4lIfNRI4jwL+0PxVubEdYFL/Yc2pm5EpDxCGY2kWxmql4dnUUfa4wuJ7ePO0F4KuLi5yzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGHJcCFWTVgzRmzkeOTzn6UcyB+35p85ad8LpLFbl75/Xiygn
	3MTtgqWw/XIHgkggw3pn7DQuwOluc3HyTl8j8Q+fSoUmIcUfEXb1xDSa+vzk9f6e0/vmyl1jl+E
	5+DVHdDp3V1O7VULC3W8UC+CvldP8pTtRAltTQ48xy3xjnYZFSJtAmEs9dFk5wHI=
X-Gm-Gg: ASbGncuUx99XOVerWmqrPoTBw1hPSCHM1iPSBtDmrrQySHY7z1riy/f2R9MGjAwZAml
	yxPB8Duf7YwmTMd209fAEbrkUfq4p4BR3iiD2qMfTYZ6wpb6Jr7oVTl6Lb83X1LSSYxLBvex9iL
	9MdQM7KWAdmfSNJrGotmzcAtkGS6cn9Lq4QpPgf7BEfuYkpFIqG9OR05sccTDLnEdwVojlQp1p5
	QfCFNQ2qROx35IAr5Osi1mD9NVHYc8oOZn4WLkUOssOAaStGLcrHyKn6A6V2tySdIe8vKI7eo5t
	lTHrzHw0FR1mtv3httQQoTI3g539vzJykonXihhnvz1CdDh/sBcrjh65tiuJcjw9cf16Ny5EW/P
	90c7qIIkf
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4626065ad.31.1741909727069;
        Thu, 13 Mar 2025 16:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcphUQ8UCrGDx8Md02DmjuseFiFZVhQ2qPU88RhdsaxrxfnuW+c53+Y3w5UiXV4O9t74jPcQ==
X-Received: by 2002:a17:902:ecc5:b0:223:f7ec:f834 with SMTP id d9443c01a7336-225e0a840camr4625785ad.31.1741909726725;
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887fcsm19356845ad.39.2025.03.13.16.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:48:46 -0700 (PDT)
Message-ID: <2654f986-eb8b-430d-b962-8e77d9e11826@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
To: Bjorn Helgaas <helgaas@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com
References: <20250313171637.GA739165@bhelgaas>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313171637.GA739165@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d36edf cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=wUlHnouiQKlN4MMnk_oA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: _hEWmL4CxOFchihvDF8tGt4mjZsYt2cf
X-Proofpoint-ORIG-GUID: _hEWmL4CxOFchihvDF8tGt4mjZsYt2cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=770 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130181

On 3/13/2025 10:16 AM, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 05:10:16PM +0530, Krishna Chaitanya Chundru wrote:
>> + * @speed: LNKCAP2 SLS value
>> + *
>> + * Returns pci_bus_speed
> 
> Not sure how strict kernel-doc is about this, but I've been told
> it wants "Return:" with a colon here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?id=v6.13#n142

Yes, patchwork is flagging kernel-doc issues in this series.
However, there are numerous pre-existing kdoc issues in the MHI and PCI files
being modified in this series. Just look at the patches with errors being
flagged in patchwork (including build errors with 06/10):

https://patchwork.kernel.org/project/linux-wireless/list/?series=943497


