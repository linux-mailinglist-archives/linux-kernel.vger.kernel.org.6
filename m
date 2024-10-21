Return-Path: <linux-kernel+bounces-375185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF99A9229
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4911F24676
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220761FCC7F;
	Mon, 21 Oct 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orpaL+Vd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84B19923C;
	Mon, 21 Oct 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546665; cv=none; b=WKl8HPNlCjfBeipvRc5qf7QlRGk7brBfyfuqNMgIZ6lTtoINNf4kGb61MOL/yqYP7gBqDfKNT0GXmZj68hicIWbLYTvbL/wrz7ezobpyomb9lfePZrX6m/G2P3xQQCQcJtXk+RdszFtjngXNwuuLLdAWQhwrkDIy6z+R+kJl0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546665; c=relaxed/simple;
	bh=wEbr1HFzzcTR4FwUCPZq06AEKW3liWKe1yuFuE8Ro+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JENJi5AuEBzPbY0SnvE4eJPmyGYGfQjiUpwnQfkXzcFYz3nnU/gbzApjT+u0kSYF+uMKX9qzo4qvhmTzXHK8NhWLA0qPw2nTcA55zjIIB9nb7CsZD5K1NlrceyIKkGGej0mpm+JfFuIz1cwNgZyalIUKDjeyo4MuJnazqpmMYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orpaL+Vd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJ6GWM021903;
	Mon, 21 Oct 2024 21:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zioczsUJh7UppWTZt/rJhiKs
	PmfMyM0J+wezcP6hQ7k=; b=orpaL+VddQv/xGjUrsFaBB44WvEbs3mSXPyoTrK/
	AtlBT0kC/HwOA/iSztx4S7Y0oFCFkxBNQ19Oa2Yz1O9jfcSSBiP+ZGnedG00Rqv9
	0cuw3kQdWfabJN4CGwV3p7rVK/JIu28q6nNQq+Bdm0cNvkfDwl14NxmWD/LSlk+c
	qs/XZxhfnbNwyfNCAcHGC8S5weXBG2S9OmTno/AgGxgcU0pqNM0Ds809Js7s5T9G
	gfELVIM0MuQNIP6jcdL5yhHl355B0fgwMEhda/b+qDQHDA7ASg/AGHngribL/xNz
	en97Qoia4zcHDH4rO7NCK/CtQEPZtZjkb4c8zDi+dIfR2g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tux47x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 21:37:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LLbOZf014700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 21:37:24 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 14:37:18 -0700
Date: Tue, 22 Oct 2024 03:07:14 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Puranam V G Tejaswi"
	<quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Message-ID: <20241021213714.q5pel3c3lgsk56ah@hu-akhilpo-hyd.qualcomm.com>
References: <20240918-a663-gpu-support-v1-0-25fea3f3d64d@quicinc.com>
 <20240918-a663-gpu-support-v1-3-25fea3f3d64d@quicinc.com>
 <udt76i3sl7zekhudqpnvhvhfxchvixwoinz7metuwfrpynl47k@wlpforwv7mcf>
 <20240923200537.q5rcw66wmqnwmtpk@hu-akhilpo-hyd.qualcomm.com>
 <CAA8EJpqNXb+pJp0OQXi5Pn7d2u2zGeJmVkTvsgFXzvkHn6FjqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqNXb+pJp0OQXi5Pn7d2u2zGeJmVkTvsgFXzvkHn6FjqA@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qCycwav3UvaWWnmMYI4JKfkb2B8AkJtx
X-Proofpoint-GUID: qCycwav3UvaWWnmMYI4JKfkb2B8AkJtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210154

On Tue, Sep 24, 2024 at 08:14:17AM +0200, Dmitry Baryshkov wrote:
> On Mon, 23 Sept 2024 at 22:05, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >
> > On Wed, Sep 18, 2024 at 12:27:03AM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Sep 18, 2024 at 02:08:43AM GMT, Akhil P Oommen wrote:
> > > > From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> > > >
> > > > Add gpu and gmu nodes for sa8775p based platforms.
> > >
> > > Which platforms? The commit adds nodes to the SoC and the single RIDE
> > > platform.
> > >
> > > >
> > > > Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> > > > Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi |  8 ++++
> > > >  arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 75 ++++++++++++++++++++++++++++++
> > > >  2 files changed, 83 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > index 2a6170623ea9..a01e6675c4bb 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> > > > @@ -407,6 +407,14 @@ queue3 {
> > > >     };
> > > >  };
> > > >
> > > > +&gpu {
> > > > +   status = "okay";
> > > > +
> > > > +   zap-shader {
> > >
> > > It's easier to add gpu_zap_shader_link label in the DTSI file and then
> > > reference it instead of using the subnode again.
> > >
> > > > +           firmware-name = "qcom/sa8775p/a663_zap.mbn";
> > > > +   };
> > > > +};
> > >
> > > Separate patch, please.
> > >
> > > > +
> > > >  &i2c11 {
> > > >     clock-frequency = <400000>;
> > > >     pinctrl-0 = <&qup_i2c11_default>;
> > > > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > > > index 23f1b2e5e624..12c79135a303 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > > > @@ -2824,6 +2824,81 @@ tcsr_mutex: hwlock@1f40000 {
> > > >                     #hwlock-cells = <1>;
> > > >             };
> > > >
> > > > +           gpu: gpu@3d00000 {
> > > > +                   compatible = "qcom,adreno-663.0", "qcom,adreno";
> > > > +                   reg = <0 0x03d00000 0 0x40000>,
> > > > +                         <0 0x03d9e000 0 0x1000>,
> > > > +                         <0 0x03d61000 0 0x800>;
> > >
> > > I think it's suggested to use 0x0 now
> > >
> > > > +                   reg-names = "kgsl_3d0_reg_memory",
> > > > +                               "cx_mem",
> > > > +                               "cx_dbgc";
> > > > +                   interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                   iommus = <&adreno_smmu 0 0xc00>,
> > > > +                            <&adreno_smmu 1 0xc00>;
> > > > +                   operating-points-v2 = <&gpu_opp_table>;
> > > > +                   qcom,gmu = <&gmu>;
> > > > +                   interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
> > >
> > > QCOM_ICC_TAG_ALWAYS instead of 0
> > >
> > > > +                   interconnect-names = "gfx-mem";
> > > > +                   #cooling-cells = <2>;
> > >
> > > No speed bins?
> >
> > Thanks for the review. Agree on all comments.
> >
> > Speedbins were missed because we are sharing these changes early in the
> > developement cycle, sort of like what we did for chromeos develeopment.
> > Will try to pick it up in the next patchset.
> 
> Ack. If you mention this in the commit message, that would be great!

It looks like all SKUs have the same GPU fmax. Still I am checking with our
product team about the need for SKU detection. But that discussion will
probably take some time to close. I will post a separate series based on
its outcome. I am sending out v2 revision right away.

-Akhil
> 
> >
> > -Akhil
> >
> > >
> > > > +
> > > > +                   status = "disabled";
> > > > +
> > > > +                   zap-shader {
> > >
> > > gpu_zap_shader: zap-shader
> > >
> > > > +                           memory-region = <&pil_gpu_mem>;
> > > > +                   };
> > > > +
> > > > +                   gpu_opp_table: opp-table {
> > > > +                           compatible = "operating-points-v2";
> > > > +
> > > > +                           opp-405000000 {
> > >
> > > Just a single freq?
> > >
> > > > +                                   opp-hz = /bits/ 64 <405000000>;
> > > > +                                   opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> > > > +                                   opp-peak-kBps = <8368000>;
> > > > +                           };
> > > > +
> > >
> > > Drop the empty line, please.
> > >
> > > > +                   };
> > > > +           };
> > > > +
> > > > +           gmu: gmu@3d6a000 {
> > > > +                   compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
> > > > +                   reg = <0 0x03d6a000 0 0x34000>,
> > > > +                           <0 0x3de0000 0 0x10000>,
> > > > +                           <0 0x0b290000 0 0x10000>;
> > >
> > > Wrong indentation, please align to the angle bracket.
> > > Also I think it's suggested to use 0x0 now
> > >
> > > > +                   reg-names = "gmu", "rscc", "gmu_pdc";
> > > > +                   interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> > > > +                                   <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > And here
> > >
> > > > +                   interrupt-names = "hfi", "gmu";
> > > > +                   clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> > > > +                            <&gpucc GPU_CC_CXO_CLK>,
> > > > +                            <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> > > > +                            <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> > > > +                            <&gpucc GPU_CC_AHB_CLK>,
> > > > +                            <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> > > > +                            <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
> > > > +                   clock-names = "gmu",
> > > > +                                 "cxo",
> > > > +                                 "axi",
> > > > +                                 "memnoc",
> > > > +                                 "ahb",
> > > > +                                 "hub",
> > > > +                                 "smmu_vote";
> > > > +                   power-domains = <&gpucc GPU_CC_CX_GDSC>,
> > > > +                                   <&gpucc GPU_CC_GX_GDSC>;
> > > > +                   power-domain-names = "cx",
> > > > +                                        "gx";
> > > > +                   iommus = <&adreno_smmu 5 0xc00>;
> > > > +                   operating-points-v2 = <&gmu_opp_table>;
> > > > +
> > > > +                   gmu_opp_table: opp-table {
> > > > +                           compatible = "operating-points-v2";
> > > > +
> > > > +                           opp-200000000 {
> > > > +                                   opp-hz = /bits/ 64 <200000000>;
> > > > +                                   opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> > > > +                           };
> > > > +                   };
> > > > +           };
> > > > +
> > > >             gpucc: clock-controller@3d90000 {
> > > >                     compatible = "qcom,sa8775p-gpucc";
> > > >                     reg = <0x0 0x03d90000 0x0 0xa000>;
> > > >
> > > > --
> > > > 2.45.2
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
> 
> 
> 
> -- 
> With best wishes
> Dmitry

