Return-Path: <linux-kernel+bounces-577473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81613A71D87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A087A25F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AB23E32B;
	Wed, 26 Mar 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOTC9XqJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5723E34F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010926; cv=none; b=uK5R1XTi7dphVv11G2KGW4m5ZDgg9KooO9f1TX62l5bOaxSgDkv3j1XiaT5XPnGJM5CJSI9EEhAP4gSwCNxxPeupt/1We9YVYStz+NCS8hiQhCQFQgc1ZP9xUOXBbQetUt6mD7k3cNJf7EdKh4ECFfZypg1ad4uVPHUFTWJsKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010926; c=relaxed/simple;
	bh=xy/2rzsOh+trLOCmWnJsm2IkbvXJ8ayuSunPg+ApXo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbsm7LMY78e4PaORBq1l6WtGJcSiQ/M1T667lYWn+Z078Jwd2rrHrBohouFTMYDrPEWvnw8p+Lt1iW5/W5A4Mr7WDNSEFz4zSBXF2ms7VJUkM3Esr6Eh2E+5n1YF44gIeP0s16M55KnTWzw4fxpLeeKwuqFdo/amPLGsqAq1YXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOTC9XqJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF9I75000410
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1whyNVe02s5jo4EwpJiW9RED
	EE8MpWJ5TWtU7vf6DK8=; b=nOTC9XqJoGDPy5O8S+vITzRqXgvTtvRlw6JuhcUf
	bB/ITLmQsQhCl5HGEWRKstUoJvkfOFqRQmDN8XlI/6Piu0lubYL8cD9NjvBKikBK
	nIX72UOgzoQwRZhCppGt/BhRYqvEw5+Gm9PGgLIpZiURaz+xhTHlmK+VX3RxzwwV
	CjApa+671YwHukps6Obk5nN5mx93SQKNm4sugSnWce8I+a8S0zqlzjTel2uyd+Fs
	uvJQ3XCJbsChw2f9CutrHaTlYelQmemMaybabHX68xid7p2yfLgsdtDk5khxQxer
	SOuPAEYJ00i9rzzvMF2sTXIa1AuXtz2eV5CZb4etcGsLrQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kypsbnpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:42:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c593ce5e2eso29609485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010922; x=1743615722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1whyNVe02s5jo4EwpJiW9REDEE8MpWJ5TWtU7vf6DK8=;
        b=LpGGg7JaUDAFei2KO8mDjhRTTv/6GPNWxoged1NwsxBeG9c0pu/jN3E5beg0bvPzvq
         wCTA2OgH9taRgclHvjwon0V2ohaBgWE0wqqu+zgrCDnAmY4hFnTvsiD0xOyFzs3Xl1tu
         4JblRB80MCDmDwzIp5OqaB88RiUhZq2Y+PuDFYJX7o33tnPgkYn0ljr1GOjIPIu+tJi/
         z0qaA1PBnhVTjNIiEoEMvQm0KbIvSziYN4L/hZvAL6E3u6uVjv1nh45Dm1dtCRBRo5Q+
         LSDaavYzGfgmbGYJSI8G32ZdP5moxIaY/rLe7VATiMk1mPtm2ZNbKeHJfEm2n8VvUByD
         CAFw==
X-Forwarded-Encrypted: i=1; AJvYcCXFfjzGFiEq4vhwYM6TPg7/yDSurNZdYUYqosoZcjGVqXR+CAvNYU5J8kEKYANPlQVh4FA5IKISL8RDb9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvssUE1CJqf5pffktgSx7ZugcPtnwFA2XmhQMf2nY65A1FkKq
	Ea68X6G4iXb0y8DhURABXgcSL3qNZ21hfEwxgMzqa5hV+YrHwrICIWtjBI2qrxpgipV6RGOL4/d
	pRtftRcOpD79ocPHwQdUP1wOPwJuqiPAV49V6Vqa1kTOW1f9kg19waFqwJP/05bM=
X-Gm-Gg: ASbGncsEa86MTozxZeOVrAafeR/4PG64kQA4OtsSp9+swkN65QCTU2ECBfDROSP5Kb/
	aQ6n/gHMDPfoBNO0YzWaUYkGXNcjRz9gxYri5Pp/ISKMxf7Ul1Wt7xZI5D+6uemQyd+uaDRbyKH
	IL0McaP8fWo5iTT0MtA1Tfvy919dy1vhiBdEC0NfnkWxCYM40pO6iFEVv4Lxbcm5n6RbtTrlVyZ
	97B2WLHLToHdo7/1BFoDbg5FPQsCENSth1wMq9s92HiRjKZ3cNuuZqe0vQgIddyL2sHjpxQxziu
	t2nAT6gdTXkCm/b06AOaxOTpQQElKiu73EkTiIGJGeR35CNZZDcWmrebOo1EjWUVT1zyDxw9uo4
	CD7Q=
X-Received: by 2002:a05:620a:1a03:b0:7c0:a3bd:a78a with SMTP id af79cd13be357-7c5eda61631mr71561285a.41.1743010922113;
        Wed, 26 Mar 2025 10:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGHUNfQ1l6wNqR9JpGezxG7QsvvjX37Da6MaMIZlLcrxsIc64vsgldMpySbZGofIgFHJRWfQ==
X-Received: by 2002:a05:620a:1a03:b0:7c0:a3bd:a78a with SMTP id af79cd13be357-7c5eda61631mr71556885a.41.1743010921656;
        Wed, 26 Mar 2025 10:42:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbcffsm1849438e87.119.2025.03.26.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:42:00 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:41:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V10 6/7] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
Message-ID: <qcvz3t55bu5zok5up5nxk3mxstzkcpmdavsm6t26pe5dwxyj2a@p6nkxe2fhvvv>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-7-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324183203.30127-7-quic_rlaggysh@quicinc.com>
X-Proofpoint-ORIG-GUID: OaUZftmMXpwP9LhyNqUfWkcm4dd5dqJ6
X-Authority-Analysis: v=2.4 cv=fIA53Yae c=1 sm=1 tr=0 ts=67e43c6b cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TedthiWShpgNw5UeFFIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OaUZftmMXpwP9LhyNqUfWkcm4dd5dqJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=992 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260109

On Mon, Mar 24, 2025 at 06:32:02PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
> SoCs. L3 instances on this SoC are same as SM8250 and SC7280 SoCs.
> These SoCs use EPSS_L3_PERF register instead of REG_L3_VOTE register for
> programming the perf level. This is taken care in the data associated
> with the target specific compatible. Since, the HW is same in the all
> SoCs with EPSS support, using the same generic compatible for all.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

