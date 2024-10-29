Return-Path: <linux-kernel+bounces-386198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E99B4050
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6671F23386
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD139183CCA;
	Tue, 29 Oct 2024 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhSpLYFN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353740855
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168295; cv=none; b=N8YqGaB1QY9YOmQJFlGvkwiaKg+JXkM8htn1wa9IfbaTSZ5KQ3UsSLN++TMTc1+r0w0hxdAr9TCl4T7TJHCadWBaFtSw3RcijqwquTSA0KJbeZRCL/6sVaz5QZJ4YqPAMu4iCur6xx/vUEJeLYAzsxvux1VuGOqRL0xZgE7Fa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168295; c=relaxed/simple;
	bh=JAY/5kWZM5hlslVrg1drUBGomgTDs0sWGyoq374dypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rez+OPLckCD/LvOs+JxgKHBNISK3ibjoPArRetQ94kaQlOMJId0Xa5I0nD4qipthSO2j3j9b7pOGco4jTSkXzM+YDPtfBtF4aEV02GMWlqhUp+9ce5SrZ/ICyXhilS4ZO0KPd5Ge+nSISboBH+EnS/VkpndC9lRG5pZcSvplW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LhSpLYFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SJLqG4030537
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7P4yIdSiMHAms4Ghd8h7jsv2
	1QwNBxYxHu6SKvt40RM=; b=LhSpLYFNp0z1mT5WvrI4o/qvdBgGHpIWJhSIPS2z
	eDW4z0kiDIibFwfysgeKg2id0RnsJquNV4B47cJu9dz1SjAx9gG/M/NHRJcuZCBl
	pIheTtQ3sOFfQnS6m8ZourEY8FfwjhAyXCmpORZ9TFL98jd0z4aSZFa77LK+HDpQ
	bqhHAsw0EiLOljLsonev/OjgwJ1+QmfTAX3rdRYUs5LfkTBPYilqaLcJhwgS4Uht
	avvK5S37Po7pxG80NyD+NJfZmDWdHsIsceo6y7SO6zmz4e4gO7/H//Rc1UyeI+LX
	U+xLKIs6LtRDWlxwOlXHnNeTUOPSCsQSzP9szO2ZGK56Sg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8evru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:18:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e33e5fc515so4929620a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730168290; x=1730773090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P4yIdSiMHAms4Ghd8h7jsv21QwNBxYxHu6SKvt40RM=;
        b=hQe8A1sjjEkIEtzwHd8YK/kuR+nCbv0awz9rRs54nqsidtqZgdhvlM6lNvffBgvQfJ
         A34f+mbmwXFgeml2u16lWe7EPchr1G6KjgPz78E6idmGz4hY4ym9WD8SO3gXlQvWtMB6
         bVDfgNWqZ1shB4QrSMxLrozJ7Ux7/QiSOZg7uLvhF4jFlMFHo/ffUTj6vQl+BuRPPToG
         6qc0ORToIk/T9RxnCHeSoIPHJB7Qr5RPXITUPeQ0aMeJA8w6zZ2fUu2O/m0ClD1E7hcP
         AJVp2X9qoHcAWbcwy905mVm9Ityj8ojkcURVSNe9Qw8Mrd3My9eD8LQ+m+mmacTzNsOw
         djHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdp2ANFa9p2zQ8YKpcLfegBdJchNoQr5jzaDKxfWFsAcDL/f7qDy12lajxnbCpNn6ZQbkOQQKQgNf0Mcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pYIpS5H4WyWZ+jxv+BbWVJaBTZKDkETmaeadz5jJ/80GWF9O
	lKDOwJ6Pmr1WPmUY6F2qvmrb+1/7A/kb8up6KfxUB6F+qs8DLz4EhsSVNvnuHLktySwNpjUbOxe
	OqULrPBWm2Qy9sRaMDzqI1Q7S5j5u2gSZpYd/iOnNsyg7lfd/amsF9r5A/vOmjS0=
X-Received: by 2002:a17:903:985:b0:20c:cf39:fe2d with SMTP id d9443c01a7336-210c686c65emr145190115ad.5.1730168290244;
        Mon, 28 Oct 2024 19:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+xgITwhTl7ivR0wQRvRjnzxHy333WUwa/y/57CQtVf7YIFk/gBOrEM8OHHRFO3Q1SyLl73w==
X-Received: by 2002:a17:903:985:b0:20c:cf39:fe2d with SMTP id d9443c01a7336-210c686c65emr145189915ad.5.1730168289875;
        Mon, 28 Oct 2024 19:18:09 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44199sm56834155ad.2.2024.10.28.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 19:18:09 -0700 (PDT)
Date: Mon, 28 Oct 2024 19:18:07 -0700
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, quic_fenglinw@quicinc.com,
        quic_tingweiz@quicinc.com, kernel@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615-ride: Enable PMIC
 peripherals
Message-ID: <ZyBF3ygQnIdr/k/N@hu-bjorande-lv.qualcomm.com>
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>
 <j4ggfrynyoriseef5r5x6uwgo6cespll2np7uitc64yagoa6pz@r3ro2cpqrrry>
 <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com>
X-Proofpoint-GUID: rjHqMfHEy2lCmpXjczk2Mcf2C6RaHWUl
X-Proofpoint-ORIG-GUID: rjHqMfHEy2lCmpXjczk2Mcf2C6RaHWUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=963 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290016

On Mon, Oct 28, 2024 at 04:40:36PM +0800, Tingguo Cheng wrote:
> 
> 
> On 10/28/2024 4:23 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 28, 2024 at 04:03:25PM +0800, Tingguo Cheng wrote:
> > > Enable PMIC and PMIC peripherals for qcs615-ride board.
> > > 
> > > Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > index ee6cab3924a6d71f29934a8debba3a832882abdd..37358f080827bbe4484c14c5f159e813810c2119 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > @@ -6,6 +6,7 @@
> > >   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > >   #include "qcs615.dtsi"
> > > +#include "pm8150.dtsi"
> > >   / {
> > >   	model = "Qualcomm Technologies, Inc. QCS615 Ride";
> > >   	compatible = "qcom,qcs615-ride", "qcom,qcs615";
> > > @@ -210,6 +211,20 @@ &rpmhcc {
> > >   	clocks = <&xo_board_clk>;
> > >   };
> > > +&pon {
> > > +	/delete-property/ mode-bootloader;
> > > +	/delete-property/ mode-recovery;
> > 
> > Why?
> Because boot modes will be supported on PSCI module from another patch,
> reboot-modes are required to remove from PMIC side.

That implies that the reboot mode implementation is device-specific, if
so we should probably not define them in the shared file.

Regards,
Bjorn

> > 
> > > +};
> > > +
> > > +&pon_pwrkey {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&pon_resin {
> > > +	linux,code = <KEY_VOLUMEDOWN>;
> > > +	status = "okay";
> > > +};
> > > +
> > >   &uart0 {
> > >   	status = "okay";
> > >   };
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Thank you & BRs
> Tingguo
> 

