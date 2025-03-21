Return-Path: <linux-kernel+bounces-571395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D407A6BCA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E62B3BA51C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746D13D8A4;
	Fri, 21 Mar 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onTNuDhC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AC78F51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566265; cv=none; b=D6xjTnaO8GB7Fj+tzTVXc4n42v2aVpseS+EIIto0HzXh7RfcF5YjXIfA6nyFuGs4dWyHw2GpgSRldA5Yvh/ofdEhQNFJN3JAHZA+HhvPpbTgHmqLS3y+QTFl1C7EDg5WQUF8skYejR7dj7caHcfBhmJYPS5eG7cz2Brf1DfUW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566265; c=relaxed/simple;
	bh=yJomqzVYF7rE9qNwzqjDuJ7IjnKiei1NhFJrdHeLxHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC5Ak33mvC1+MeB5HaGcA1ogZCGUsyEl3j0Qo3FIGvENciW19/qKhsyvnjN8VXEtBFAmiCj3jxV33lEiBna31BcZOv07hQuVJFVUFvGcMNcNp9XEIqrmtbt+KoQYsIE6qT0n9gT/NgKJeTZbvgXsp8bB1f8+cRY4nmksdI5PxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onTNuDhC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCSFV3025611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=enO7l0H3hE0QmwcHT71cY/s3
	vWok3ap99CzatKJPkdU=; b=onTNuDhCNCTfXSrPOBUcLvp3f5OeALfpEsuhqHW9
	RCv52LkJ7SN2KAleenq0acOkU/xJgABrrAcTcYmL1A/0ZTF2KUurtJCKAZW5eVdM
	0YMevWr3UTANvyorpyF+QXyOX0iim7CzFO1M73VaDIQ7rL7jz3YMovWVpuK4H0nC
	ZV1yZU5fizpEfF5OgZUo8wtW7i5GOOWqAEt1LRqApZnduWNL/70Zs+5Yqt9OwAE6
	KdR8TJ/whDUmPRDaqt7Zz4qG6NO0h0cH5dVmBUMto9EDn7kMAuHbm1Y4xca2Bexz
	wxfWeKUra2VuxsoY4LnJWphMnIpWAoEDJc4xxwK4Ijn6YA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h854g9h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:11:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eada773c0eso59552386d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566262; x=1743171062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enO7l0H3hE0QmwcHT71cY/s3vWok3ap99CzatKJPkdU=;
        b=v57pblrRFbPfgcNHfZCFCc4B5gszxe9vHlgbsYjfc5CShmeNOjcypbh9sTWcN1iuNF
         Tu6utV8I+rf4TIs+vR/Sq655y2YHhNzD1hok9rhAWBbdwjolfA6ft48VABhSxd7UcXUt
         npxEuZ1kfU0GN68ShbOxPVZxyBdbPbt7XyQl0vL/fX6zyRaceV1IGIwUv7ecB882btKk
         K3BbZ8+6QYJFXuv1+QC4V0jY/8xeSFrSAY3l398LdYVvYUsWkVNdSHiFlutqcXj4D8zc
         cntkhKWCCvF0TqEADnNtz6EXKBsMVHM7D7J5pmFRMKRCcft3Pbc1kgRJ84hjvcb4yPm/
         dXJA==
X-Forwarded-Encrypted: i=1; AJvYcCX4mMyWsdHDOzp8jCFDhG2k9+a4r1g+FDaC6Oys0jtFbD1m8F2oli519MOI7rdMasVGMmqPj3K6Fj2B9O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypCjSaAmbygHreJ+BzJ5GaiDQOWTeqsk/bke3HIjEPnYI8oJ/q
	p3gfW5OD4yiVuUVHjgWnKqnphNXMlLT5vaeV69XAWVfz2v/iDl78vNNx69iiBFTtYHNtMFvpB/3
	4YYznyQwnrS+p0leYKjemlzMoqzVt9LogXk/3ybT5HDSPjUjzDmD43GWIxNl2Gv4=
X-Gm-Gg: ASbGncsr9Fwbzx5kjpcK52CI7SYe+yofFIwDgEMc3Akj/ZIxsJbQMMJB27y66Ls94rt
	+x8P0Ynl5Fv1IsOZElFWnKeFNveSdwP4tpE1iBtXE5CIeBW/j2gQyL0LawINJPZpHHzF3q/xiUb
	xrvfHF7tq87ME15fo3LtEyfrZZa5ZIyDrdx4PGUx6mjrHvxAEkU0wXcMztI3ZhtTJdgVuJG3ghM
	JyhkJ0sL2/CRtAh+fVf0NZ3oD7SyyXt8stcQKqq633vJxLURvU5THlF16n/TQQlyz85ZnRrtFb0
	+AtGpl4Z1aja96nLXgPngziPQ8qey1wADJFhzhvxINTX81luD5HQ4N0GXR7onzzNmFDfZPIFHLw
	tmW0=
X-Received: by 2002:a05:6214:248e:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eb3f323055mr49262086d6.27.1742566262170;
        Fri, 21 Mar 2025 07:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeivZrTcegaXr9Av/yzGkp+WEb5kB2nx0cZWW158gssFezgkz/WGmpsLNHyxLHrjlqxKgOeg==
X-Received: by 2002:a05:6214:248e:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6eb3f323055mr49260706d6.27.1742566260223;
        Fri, 21 Mar 2025 07:11:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65037bfsm191161e87.183.2025.03.21.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:10:58 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:10:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        20250317100029.881286-2-quic_varada@quicinc.com,
        Sricharan R <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <6szijrbeubobgkiccxvs2povplcedacnofpqtlsnz2se24yjcs@3g2nry5nk7dc>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-5-b7d659a76205@outlook.com>
X-Proofpoint-ORIG-GUID: FBDC5uvj8zonOmc3QTemttj5uNw2vCxL
X-Authority-Analysis: v=2.4 cv=ZtHtK87G c=1 sm=1 tr=0 ts=67dd7377 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=IwAU_dWaxX3plY3JidMA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FBDC5uvj8zonOmc3QTemttj5uNw2vCxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=344 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210103

On Fri, Mar 21, 2025 at 04:14:43PM +0400, George Moussalem via B4 Relay wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 234 +++++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

