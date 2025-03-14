Return-Path: <linux-kernel+bounces-562266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7FA620B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40EA7A602A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAAD1F153A;
	Fri, 14 Mar 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K86bMvDD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6221917E4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992164; cv=none; b=I7A7GPfCDswCHEkn6yl2dmYj+4qVSV6uLwwdPhWBtw310CBQgQIHExvgJZ3yv2JkqubcK8JYXsEPq1WSESkK5ix7pAglcr14ydFbgFmj6kvNRA2kU/AX5EduCQbL50PpoUmXSZOLaTicEFu8/5qAKqn/Od4NBurOUWPZsuYevD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992164; c=relaxed/simple;
	bh=82coecyezSvgbMXY4DGUcnROgEkGpydTprp+i/sXDLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHN8pxvCxoPmGRnDidlOC4lgD2MyhRN7mgfzzX4Lk1RqWYf19C6J+jEtsnGjFfN5Htv03LjtY1t47H3Mw4+68lmkPMWmnTgNK/mM5n/oeWS4OZpIvfToAPUu9uldeETvdLb75Ogt7AG7qagRTQjDiNArVX3aa2G09R0G5e2eYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K86bMvDD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EMLCmh021603
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIwDE800oX8SYV9AWJVrX+Iz/rjOe6oMe8ZrMZYcGfc=; b=K86bMvDDz1zXZtfU
	Y1nKZIuYX1m5faULFMakMSkkST3FLllY8Y4nV4vaMG4SWtBQedcbavML+YbgbNH4
	hP3bieS7xbJI3aGFWDUYQS/l+r0NOSU6rBXnOYGlNyeETQWoJ0e6aTJvuHkCgMUH
	qTnMtkbsWAawyAXj8zzW+Qzg6cblYasLc0mzLgmoUVIHsTWZaAcsSHGepzPBApjk
	jCdi8lsCPm1Lc7LySzLwCRCAlASr6+/086ipzmX5twhTOQHEGss/teqfH0AnGPXu
	6DHUM+3DTlg87P0ODM54ceQN33aZeYoH4eAl90rUp8c0I7vwBwC08xY9DOtN1/G3
	JzcDlQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45cw5q81ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:42:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4766ce9a08cso5467091cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741992154; x=1742596954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIwDE800oX8SYV9AWJVrX+Iz/rjOe6oMe8ZrMZYcGfc=;
        b=rMbxMzjUONZ5FKKTOe5tslrOxkBGnMo2pP1ALx9k3ng6IjNLwdmWffcoXjyUVu+G95
         hdo9eWmWBdX7NmS3aP0oBrtauAnrtdLrfkC/bskTnVQ58bHfmHwyKRyXoJPLUFwnAiPC
         e9ScwB9WtJmW3AfXez2CnUe90qCFEAc9OglKk7FTt6uDpIfg+pp6s/elJKtXLDER51x3
         XW6Qvlp9A1FMu/Ll+kTkWcNksRPBfag2jq5C9exd1d/xrHa40zfhiPwQ+WQCUrQXOoaF
         /e98vxd+62UnPkm4kCsXOC+fVKegcNTfasZe0XBa+39wsClaaftjsarOSZSBKgQCneIE
         zTCw==
X-Forwarded-Encrypted: i=1; AJvYcCXd8Dpbg+0N9o9+GJ0XerCtFJn2xi0nQHK1iyLxTmW0EIn1/twP5Ef9szQ19ohZbiFV7F3Q7ASLQRtks+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwSCiTghjILtXVFQHP4+Bh2hfJUVUbNOy8ia5vVBdydsQ+rsa
	IiH7XwHcda53nKnyvJ5IWctKQMmqx/wrY2j3BLHe5LMHVf0tl9g0EE3Sdhn/28YCAhAVtzDh2mr
	XeXVzU/K0swp5YNRFrDU2M08gRKzT/2kAkOpaCieYSzsI6O6wK6t8CyFQDifPCT0=
X-Gm-Gg: ASbGnctueYdFnIR13D09H2IdJKQ9SuqkcLNzhkEhCTlrsWfSOgoZD8PKXeqdwSz8Nta
	aw6VoNL6OHUbYK5qaQ91hUaV7dhQf3ArM7DkrMlQQeAPau0ySg7iXROea9dCxOTjFK3QeL/NavW
	r5zGQu7U+fYn5uu45UcODWRjWu10ua6g8mfBpd1H6S3JJJGJPica8h5HWFP2aXoblRYj8IHiPQR
	crzUA45oZ9Buc+dVVZXyGWPtMqgAmky7BIWNU+a+UX9ccvLM/iTggVzImSUx9baUQvPZvo7uRlo
	TskKL7tCle+dtO0IkeDjOWJi+LPm7SgyDdYTa1xGzVWJdR1iTJQR7PYkBUHqZgvFt9s2uA==
X-Received: by 2002:a05:620a:31a4:b0:7c3:c814:591d with SMTP id af79cd13be357-7c57c795580mr195582285a.1.1741992154032;
        Fri, 14 Mar 2025 15:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8g9fIKijnYR1RXDYNW9bZ5XeEGfn0A87clOCpiGK6J3Egz2X0NW4LerMPqQE+/r79PX8g/w==
X-Received: by 2002:a05:620a:31a4:b0:7c3:c814:591d with SMTP id af79cd13be357-7c57c795580mr195580685a.1.1741992153588;
        Fri, 14 Mar 2025 15:42:33 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a49d33sm284366866b.141.2025.03.14.15.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 15:42:33 -0700 (PDT)
Message-ID: <15ce904b-fd68-447c-aecd-ba7d1d32be0e@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 23:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] phy: qcom: qmp-pcie: Add PCIe PHY no_csr reset
 support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, kishon@kernel.org,
        p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org,
        abel.vesa@linaro.org, quic_qianyu@quicinc.com,
        neil.armstrong@linaro.org, quic_devipriy@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250226103600.1923047-1-quic_wenbyao@quicinc.com>
 <e556e3c9-93ee-494a-be35-9353dc5718e4@quicinc.com> <Z89Ek8Y7TRSgTuMg@vaman>
 <20250314145407.5uuw7ucrdhca4z5i@thinkpad>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314145407.5uuw7ucrdhca4z5i@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jyVKWmqPyUZF4adXO6wG9-Wd6tXFuE7U
X-Authority-Analysis: v=2.4 cv=M/dNKzws c=1 sm=1 tr=0 ts=67d4b0e1 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=CgR8CRIgTN9bnSrjgiYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jyVKWmqPyUZF4adXO6wG9-Wd6tXFuE7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_09,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140175

On 3/14/25 3:54 PM, Manivannan Sadhasivam wrote:
> On Tue, Mar 11, 2025 at 01:29:15AM +0530, Vinod Koul wrote:
>> On 10-03-25, 16:58, Wenbin Yao (Consultant) wrote:
>>> On 2/26/2025 6:35 PM, Wenbin Yao wrote:
>>>> The series aims to skip phy register programming and drive PCIe PHY with
>>>> register setting programmed in bootloader by simply toggling no_csr reset,
>>>> which once togglled, PHY hardware will be reset while PHY registers are
>>>> retained.
>>>>
>>>> First, determine whether PHY setting can be skipped by checking
>>>> QPHY_START_CTRL register and the existence of nocsr reset. If it is
>>>> programmed and no_csr reset is supported, do no_csr reset and skip BCR
>>>> reset which will reset entire PHY.
>>>>
>>>> This series also remove has_nocsr_reset flag in qmp_phy_cfg structure and
>>>> decide whether the PHY supports nocsr reset by checking the existence of
>>>> nocsr reset in device tree.
>>>>
>>>> The series are tested on X1E80100-QCP and HDK8550.
>>>>
>>>> The commit messages of this patchset have been modified based on comments
>>>> and suggestions.
>>>>
>>>> Changes in v5:
>>>> - Add a check whether the init sequences are exist if the PHY needs to be
>>>>    initialized to Patch 2/2.
>>>> - Link to v4: https://lore.kernel.org/all/20250220102253.755116-1-quic_wenbyao@quicinc.com/
>>>>
>>>> Changes in v4:
>>>> - Add Philipp's Reviewed-by tag to Patch 1/2.
>>>> - Use PHY instead of phy in comments in Patch 2/2.
>>>> - Use "if (qmp->nocsr_reset)" instead of "if (!qmp->nocsr_reset)" in
>>>>    function qmp_pcie_exit for readability in Patch 2/2.
>>>> - Use goto statements in function qmp_pcie_power_on and qmp_pcie_power_off
>>>>    for readability in Patch 2/2.
>>>> - Refine the comment of why not checking qmp->skip_init when reset PHY in
>>>>    function qmp_pcie_power_off in Patch 2/2.
>>>> - Link to v3: https://lore.kernel.org/all/20250214104539.281846-1-quic_wenbyao@quicinc.com/
>>>>
>>>> Changes in v3:
>>>> - Replace devm_reset_control_get_exclusive with
>>>>    devm_reset_control_get_optional_exclusive when get phy_nocsr reset
>>>>    control in Patch 1/2.
>>>> - Do not ignore -EINVAL when get phy_nocsr reset control in Patch 1/2.
>>>> - Replace phy_initialized with skip_init in struct qmp_pcie in Patch 2/2.
>>>> - Add a comment to why not check qmp->skip_init in function
>>>>    qmp_pcie_power_off in Patch 2/2.
>>>> - Link to v2: https://lore.kernel.org/all/20250211094231.1813558-1-quic_wenbyao@quicinc.com/
>>>>
>>>> Changes in v2:
>>>> - Add Abel's and Manivannan's Reviewed-by tag to Patch 1/2.
>>>> - Refine commit msg of Patch 2/2.
>>>> - Link to v1: https://lore.kernel.org/all/20250121094140.4006801-1-quic_wenbyao@quicinc.com/
>>>>
>>>> Konrad Dybcio (1):
>>>>    phy: qcom: pcie: Determine has_nocsr_reset dynamically
>>>>
>>>> Qiang Yu (1):
>>>>    phy: qcom: qmp-pcie: Add PHY register retention support
>>>>
>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 86 +++++++++++++++++-------
>>>>   1 file changed, 63 insertions(+), 23 deletions(-)
>>>>
>>>>
>>>> base-commit: bcf2acd8f64b0a5783deeeb5fd70c6163ec5acd7
>>>
>>> Hi, do you have any futher comments?
>>
>> Patches lgtm, It would be great if this was tested by someone as well...
>> Abel, Stephan, Neil can you folks test this and provide T-B
>>
> 
> I tested the previous version and it worked well on X1P40100-CRD. Will give this
> version a go and give my tag.
> 
>> I am also concerned about bootloader assumptions esp if the Qcom boot
>> chain is skipped

If any major part of this boot chain is skipped, much of the platform will
unfortunately not behave as expected by the kernel today, anyway. While I
personally enjoy hacking on such things, holding back hw support because of
theoretical issues is not going to help here, especially since the tables
can be trivially added at a later point, if ever needed, without requiring
DT changes.

> In that case, someone should add the PHY init sequence to the driver. That's why
> I wanted to have the check in place to avoid silently failing PHY
> initialization. Right now, the driver will error out if there is no init
> sequence available.

IIUC we internally settled on not sending the sequences for X1P4, since
the PHYs are initialized as expected.

Konrad

