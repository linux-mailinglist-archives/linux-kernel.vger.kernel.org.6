Return-Path: <linux-kernel+bounces-566948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294A67EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B405119C71B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95AC1F872B;
	Tue, 18 Mar 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UaHFsxvm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34001EEA20
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333607; cv=none; b=Nvf6oHhkode4IO7or8WrmT7UYHq/xa1rmfr4bkJ+DW3LmZB99H8ovdJ6lvQhpsFIHpXDLHbuSfIT4ZRcQqtZLmhPX8Or69FqkAfGln78MFf84twTs4Xq8pXlA+eq4lUJw6noPQoA/tvXstfP9D3NdsHaM5aCmsfmBI56zKJGKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333607; c=relaxed/simple;
	bh=vOR3/JIk50CJzaeJL4hwEOyiKqMHqzylkUtWfbZ1yyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN6y3kd2d8DVWuZ9GaPV6s0AzgzwuvqcaZzC+ieNNiwtPEKunwa5rud/3LZoiV8uFMJJLAvus0GrMNy0tSG6YZONuekIoT4j/AEp7/SuX3tBJLMVoZTyMKCErU7wP8Hf1yV8ln2cwfkr2SjzSbuarYgdfQa1dQpGw1vAjH7EtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UaHFsxvm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeDav029986
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MmJSW/umKeswEWSeKZBVRJB1
	BIIFkK8mH0qIUqVs1/A=; b=UaHFsxvmPL/PHpkRSn8ti9khjMAfZf2awEx1M2KF
	ZorQrUsEw306tzWWdCQmLPRiGpYUr8p2FqCJwwknVY8Pjb/abbb4F1bhAh5TKhb8
	g2kKcJrgMtI39U+FRq6zpaYjaavLITmnaUsO62wMcBCbU9wlsnfQhCD38TljmP4G
	MPcT8w/J1ENi5Fqxzx3dKFGlmBEnWpWkWB10B5GsrBQWOOLY2yzQ67Ch+O+0unlH
	i0PbaNzveZ7Gzb2TVnO9krCjiZjalTgYTZ5JqAtjxZoCdUASSVRx34vEC0f6XOw1
	p6Im95+3U8rgW/wcMA8vohY1IH7P9hwsUkY/2bArqlpgvg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t1d77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso172565976d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333604; x=1742938404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmJSW/umKeswEWSeKZBVRJB1BIIFkK8mH0qIUqVs1/A=;
        b=Bw6j9GOhR/WYtzPXiOCNLSaNZ9fJSACgKXXOx97+hYj+QhXk9KqZ2/FPEA+yJW9S3f
         NJxK09ygTRg7RltMns4Ya6KDcAY0QbA0pAXD0+oW+5z6V9WimD7SBynGq+eernav1DU0
         Ex/b4KCxM+UkzFN/LxRyTYvNMBr6XjVcQ08pWw82FmMvDO29Nkv1duuj6D6TWd5WGUiJ
         8hqznaVSEeHRazZm01crqyoQYwj+/BSApJcBVafICr2OLEC+NvOx7Jcz02XQZ5689c7O
         MxoeH7CTa9oV3vJdW+EoEzMdAioIFyB4IrecCTgPu4ZQhsoyZeRaub3G/vhrgN5bpxGF
         SsBw==
X-Forwarded-Encrypted: i=1; AJvYcCWwRLoiAb7nuYhncIj2sEDMKsQGWaQX1uShVHcFSaLltMNyWHUrccFG80x55dkpjR68anlciQmLRYzgUiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWWlrD1Uc62B25P+hw2o2UAm1JFCyj0HevsVZ24nCvaNtmrF/
	sG5svLOwu8wf4SrzgkZYpISSdV71buLeRMol/y3m0X56sNw7KqI6SfQZNqRm9XvlXPgftBqQKV6
	v0sxHxDk1fK5cO0JUug9LuPhplbCFjRvXGXilyNBS4s24g6j9Zg1+sR25RkUSNRk=
X-Gm-Gg: ASbGncuiIYGGgaGctn5iFxuu8egDXR/8EVz2EZMIF/luc1QdsRdD9Vz2fFPxtXz2+8O
	tO5AdSQIcj4LxrTSrX4UPm8qquUZid0Lz88stOK/QS/a5/ul4I7M5UCk265xrQTaWZlYDZYcWry
	498KaV8kUQsaI7kHvV1q51+NWlgDkpckw2yoUq3SajM+D8GIvJxHyzhQMYu3Jby/T9vep3W4VxV
	apW5EixYvsbTAG7iHTZv7j59Q2R4pjV4wz578YLj1bMqA2K98AGGS2MGyBqNZOZSAO4EF9Z27IT
	h2LFWaD3Gcibx3U3X85a4vFyp0Y+DbgqvLvhYxAP8J+wtHyL/6awUHjbQdWVVhVoSrbAvfA4pNF
	JXKg=
X-Received: by 2002:ad4:5ba4:0:b0:6e8:f3ec:5406 with SMTP id 6a1803df08f44-6eb293b1d37mr6816356d6.19.1742333603480;
        Tue, 18 Mar 2025 14:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhztXksryfX8def6oBiw6VCdyAmlTnjdkgF1TUSXGb/cfOrSpTBlHYDH6pbe2Y+6+JoMCdWQ==
X-Received: by 2002:ad4:5ba4:0:b0:6e8:f3ec:5406 with SMTP id 6a1803df08f44-6eb293b1d37mr6815936d6.19.1742333603183;
        Tue, 18 Mar 2025 14:33:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a7a98sm1766004e87.224.2025.03.18.14.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:33:22 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:33:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8998-mtp: Add QUSB2PHY VDD
 supply
Message-ID: <f5zjupndrasjpwys4v46hjvd6p3ta3uovsfylmlono3chtf5lf@suigsx2kpnyj>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-7-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-7-cb36882ea9cc@oss.qualcomm.com>
X-Proofpoint-GUID: N_4Sl6hgmw0IAaGB1XaBvx5dyaQFDM4p
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d9e6a5 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=YPhFelTriHocc5OovjYA:9 a=CjuIK1q_8ugA:10 a=PkAOt9_mmfBkvtOLxIEI:22
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: N_4Sl6hgmw0IAaGB1XaBvx5dyaQFDM4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=816 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 07:35:20PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Set the supply as required by bindings, to silence the warning:
> 
> 'vdd-supply' is a required property
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dts | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

