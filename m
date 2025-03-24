Return-Path: <linux-kernel+bounces-574312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20ABA6E3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6DF3AD988
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5753219F121;
	Mon, 24 Mar 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XU6m82Rb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304819DF41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845163; cv=none; b=dSoE98kkuHJHig35IyMaV4kgMp2p6mQRN+YsAYOzYpFm0rda2DqonyXgwe5q5mSBXC3XWK1FY3QT+dipjtDlYwiA7XQhk8DS/VnXo3ZDpD8ORUV9TzZeQ/GXLw/JmT3CzHum0c5/VdeziQDSloxLOa+3JXCgWiLtW7BktiQtul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845163; c=relaxed/simple;
	bh=XU+3ff2wCDPJCiDraMaKy0/I/DEH24hGfBmOFOZn45g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF8bHt4JDxHhoPUNG5hOBvZRcgU+mv8Osfc56rsk28VSWi9HQBEJEOxNANWYgrpc2/qZHPnIIfaDIV899MyVEogLR4nOmC5UWjtk9EHp2jKu4w66Ptd49NjEZzcAseA2/oCTJqpbkxnp/ovWd8q7STJA/1uOi1gKrwaujOO1nIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XU6m82Rb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PNP5019600
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aq9nswubh4CvJAyZ9x8Ivp0JYqniIFdvl4igqnNOPXc=; b=XU6m82Rbcvg6Iklt
	ecNNzMlshf73nEnPd22llaFTpdEtm0b7LIuMomZwEa0DtqCGp/6GeZJ7rbl3BpI8
	SL2qdSeAaSPqCuSpIhY2dSM1t77gYKJRaLIlHxArKmE/TFBoRit6ttbd2x05tSHj
	2xwOuEbvc21HcKbqtdUWB9LQKEdMmvZe9Vg1ApXT3nThHSK3atPeQPA7pG1mpCHW
	2XXM0eBk+Ed4N2BF1Kv9I9qPv4g/OleqULgOROT5E3KNyRvbkMBGNWIATQ5dPcN2
	Y2BaStsg6pvjEorTJf7DuPYRLrSKiYHs1hsP8dhztnOl3tCGTQXqetN/DVhygdL4
	ckpDjQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm5uwjjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:39:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-476695e930bso4748081cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845160; x=1743449960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq9nswubh4CvJAyZ9x8Ivp0JYqniIFdvl4igqnNOPXc=;
        b=nQythKsC6dM9/vIaLCFha+08bYh4amlDPQ5y1efWXmVX8DPJH4eb7dbRavx3DM7VGk
         APPF/4bUmBrSF2grIymLXE9Y6B48twoDRqMEDqPiiKfDAKBGJpd7Yo2iYuToVd+RCOsx
         WreFG8Dfgppaw82STQeC0DJc2DXV2bGo+UnAvWI9QYRIs86/k/ItRFD7sehaYmqWH34P
         GG5QhDTyMGobHgU4ywc91bL0hCLR/XtRZwGHMp4a3UJxq8WZUC3JyPrs9Nr6tJHXP/YK
         4MjOMsDkpG4sRiMwZIUgqjPBIw+i5bhKujGh1TvNIJf8BciZqakV64zJ7m5pUA5CMqxl
         KLGg==
X-Forwarded-Encrypted: i=1; AJvYcCXgjvRs/yPSVPMnLjM4tu0Bs4BnpN2t54s1OLfDrPU202lNfhbG/7j7l4Y+RSD2M9VDaq6DwtRehs9A4n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+OVKEbnfbXakXA3q2viLRWRji8g3mO++9ALvkkhbrptwtwbr
	vmJIVMY+QqZzSmeZiAdvKY02SSMkk4k0rX/gxH30DlRZQgNaDmmznaj7xV47VUw2hFvJw4jdUrk
	KaSnTgj8nwruHNdWt4QyT4I/DmAUw0ls2svAjMXYvYvFLdpJ48GRr1Nbtro4WfOA=
X-Gm-Gg: ASbGncvdSsQxPalq0/INc7ZpAvdDcP2BAMLqwqbR3QnAbk3ARL41iAlZEvhudWhFP6T
	UrQjkg65goGNhZGAgiGAc21Ynjdgt9Pu0ckOlTdEDWuH+95HpClPBCCSOxFNJ0mFBisajazT/d7
	MFgd2wmiTiN/qc2eZax/+DZmRYrOh7HlnbhIRHC3Ffjm8r5++fSEbA/YQM5REV9eyFioH5d42Sj
	7c/rDMCXsUJcJeY2MU0lvnNKFkb9CwbCljxlu84dTm+0TlQdmyJdp1ZqRSI6llRocYa4HKputfm
	mrbeNDo/STirLjBxg2tWp17Le8faEskI7YcBmX4OSBLkGCJ43UdV73Ns9sMOad2GzHqz0g==
X-Received: by 2002:ac8:5890:0:b0:474:e664:691b with SMTP id d75a77b69052e-4771dd87882mr89906001cf.8.1742845160054;
        Mon, 24 Mar 2025 12:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHviieFK1EfENsl4a9Pml/b1ejxCDE5UyK/0Ef2r/1I9kvIRSgTlksPYavU5w4Abz1YKLR2A==
X-Received: by 2002:ac8:5890:0:b0:474:e664:691b with SMTP id d75a77b69052e-4771dd87882mr89905691cf.8.1742845159499;
        Mon, 24 Mar 2025 12:39:19 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf687fbsm6561703a12.4.2025.03.24.12.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:39:19 -0700 (PDT)
Message-ID: <8ed64d8e-40f7-4a2f-a758-10ac5f08254c@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 20:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
To: george.moussalem@outlook.com, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-6-b7d659a76205@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250321-ipq5018-pcie-v6-6-b7d659a76205@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x3Tz5f17zd9stxksJ0qLihJ8LzKT3vCh
X-Proofpoint-GUID: x3Tz5f17zd9stxksJ0qLihJ8LzKT3vCh
X-Authority-Analysis: v=2.4 cv=AJKH5mlP c=1 sm=1 tr=0 ts=67e1b4e9 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=QQJSiojk9BBBe0YzEv4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=530 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240140

On 3/21/25 1:14 PM, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Enable the PCIe controller and PHY nodes for RDP 432-c2.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

