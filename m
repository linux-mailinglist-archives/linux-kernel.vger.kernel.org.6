Return-Path: <linux-kernel+bounces-564446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469DA6553A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A8D189766D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EF2475E3;
	Mon, 17 Mar 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StjnEUDG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FB243371
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224390; cv=none; b=ICO0GeSM3/KUcHvuOxcrZQTjE94OMiuyaY5muICCLSICfuOeGYJg/HQ/ZiTck/SAOsDE78Hl9gT6jFMyKJ3KSKB6NQy3/J2imvUIXy77ftvNRxsp38nHAwJg6iTE7VoA3rPtp7qxT8HbhJHy+hdL/BB6jjeJI4s3I80D+ebFeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224390; c=relaxed/simple;
	bh=SDvhxwcv7TdKOadxWFuLJ0D8uidUwI4ZDk4N4XVcyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILtytI9tR4wUuAnO9TySLpBkDuULL+fkn77bJUslYti6KBBkRuKhmyzqSAOGu8Rus4GMEt2DFdzoKIwxDAcbnndMy7fDtgoWR4cGqMtTxb+cDyePgoasJYo9tOlxUKj0kICeCjVYDaid0YVtayKKMlKOWzOmd/B9BXPvNPPoeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StjnEUDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9jDJ0025135
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XrJDaL888EkzEDNTms51lcge
	hu13HyvkuZYeEeKlbI0=; b=StjnEUDG6HNwZOosjSO4sPdkSWSEerifWKGBiaKE
	lVmmEaBjWxY/W1GS1rwaD72c56MBuTFnAiS+7SWgqHdLz6LiE614la/w/GE0Nouh
	FRz3T4GWz3FLsabJgWRTIYorrhZOhwAXUmiwFnCAycFSDS40LKvBulGgykavLe20
	jMy7vr32YepPTu3TFX8ZnCtSGkEN/HD/iepI4D+QGJZeyhL1aCM5vKxzvXEbeQy9
	B+jAMn7ys/OxeDc+lMZNq6yj5f/5izIJKnxFbt36dVvbTI0WqeKb4wdNCgbixtGL
	g+PJb2H5pV9J1hO1/nzndns7nJukZQ4XeaZDShFqgbeNwg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9w4j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:13:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5750ca8b2so753538685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224385; x=1742829185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrJDaL888EkzEDNTms51lcgehu13HyvkuZYeEeKlbI0=;
        b=M67VW3quCXqEdDaxxukHQ5/LB5p7U6WrvlymPfxCRN3h74ueYDMpRfN1bhpVc6LbsX
         QiIaJT/Qg6lb8UMiZlkcKpmLL1XfTIlhGlaWFLejTM9durcfuWbT6pFaAZ4We+voOLFv
         5F5qW/WSk9autyAaU8yXixt6npGQ3q25cLZpaecX/wf6LrgYCL9H4xNPUOQbH7tc5IPg
         1CkpOxrkQL7VV+oaC+X8nU7EoL5XrBoOTsaAH3hsCD0p9aXNZsiHLIUI6snQXsgYWJlt
         3EylLzi+G8xxMdxbbDt3Wf8/Ke418UELyAzDe9Nxs2IqaWLFKDztDFzn4NuC6tciBMqI
         XoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOqT5sSKUVCOME7S8sRn+RtivB9IgrG5YBOjUG1iBWUy15J6rdtYUxn3Net2c5h/s1QCn7iKr+XmDliYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIcBwHnB4ECaouYUxMpIcJ53TENesUrSN86eqrukGdpFNzobQ
	3EsfVtSfBZHeyuOP3YjtxxFGULsOJM+OBrcZ8bUiGcaakt8gWxL8VoBShhHVxvc6mpwHB2xaPwB
	YaTrB+UdwxYJHMDRY5+0M6NzHP2NtJa6rrGnUXU4ARb4SF1H18hGjZh8HGa+09PI=
X-Gm-Gg: ASbGncsdbsYBKYqmAB1tyUNzDtA6eBzHCNkkO5Ob+PcuUhG9WNI8CIqX9uBETAdpz2C
	ZDbk+dLONOxLNC/vKVzzB4zZ//91kT98sOD+tfOkVZYKIv07khmmNCd8MeerpaTJYVUhvxY3BJC
	77j5HqCLlDSbewfyMnpT1mSkkEuXedPdMQWx/a9KMCGdm2Uh0g98EziiWrYb4Bo7PEbjwKtN1KS
	Rq/GIlTf1gGnyOJKPd3E9JF1KitTdpQFi/PZn4OmtszJtq+/OgDiQF6LupeUEuXh5bHfWs1r2hs
	gt7Eqfb/+/bjp1wf0Imh6GgPtp3f/pC+K66sybh+R5Q3/gsNmBmh9DneVRBCIVvFWnRsuZY6Q6G
	pQUs=
X-Received: by 2002:a05:620a:c4e:b0:7c5:9788:1762 with SMTP id af79cd13be357-7c597881765mr208499885a.45.1742224385517;
        Mon, 17 Mar 2025 08:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAdOfSJ60Q9e2nCDna3LhjC5zfyZWJ3xn3wOOtOquU4EkmFzJJKQlq5NRNd8kCa2QmdisMw==
X-Received: by 2002:a05:620a:c4e:b0:7c5:9788:1762 with SMTP id af79cd13be357-7c597881765mr208493685a.45.1742224385093;
        Mon, 17 Mar 2025 08:13:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865096sm1355327e87.132.2025.03.17.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:13:03 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:13:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ivan Belokobylskiy <belokobylskij@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
        Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v5] ARM: dts: nexus4: Initial dts
Message-ID: <7z2u2almxk7rnd6cx6nq3ypgbzvttkj3jqawv5jojayjz3foix@zprthr6awbcp>
References: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
 <174221818190.3957236.3364090534153729086.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174221818190.3957236.3364090534153729086.robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d83c02 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=8B4Imti52KGAqkOr0YMA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: WsGuDjkxBgYdzGXi0JoYQnlegXhn9gu-
X-Proofpoint-ORIG-GUID: WsGuDjkxBgYdzGXi0JoYQnlegXhn9gu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_06,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170110

On Mon, Mar 17, 2025 at 09:18:33AM -0500, Rob Herring (Arm) wrote:
> 
> On Sun, 16 Mar 2025 23:16:55 +0100, David Heidelberg wrote:
> > From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> > 
> > Add initial support for LG Nexus 4 (mako).
> > 
> > Features currently working: regulators, eMMC, and volume keys.
> > 
> > Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> > Co-developed-by: David Heidelberg <david@ixit.cz>
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > Changes in v5:
> > - Sorted nodes alphabetically.
> > - Link to v4: https://lore.kernel.org/r/20250311-lg-nexus4-mako-v4-1-3916c8ec7edb@ixit.cz
> > 
> > Changes in v4:
> > - Sorted regulators and added regulators compatible.
> > - Corrected pmic include and references.
> > - Moved &rpm outside of / node.
> > - Moved and simplify pm8921 keypad.
> > - Added chasis-type.
> > - Dropped incomplete WiFi node, will be provided in future
> >   contributions.
> > - Link to v3: https://lore.kernel.org/r/20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz
> > 
> > Changes in v3:
> > - rebased against next-20250307
> > - dropped backlight until driver gets converted to DT
> > 
> > Changes in v2:
> > - lge vendor doesn't exist anymore, rename to lg
> > - sdcc@ to mmc@ to comply with dt-schema
> > ---
> >  arch/arm/boot/dts/qcom/Makefile                    |   1 +
> >  .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  | 341 +++++++++++++++++++++
> >  2 files changed, 342 insertions(+)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/qcom/' for 20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz:
> 
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: hwmutex: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/hwlock/qcom-hwspinlock.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: hwmutex: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwlock/qcom-hwspinlock.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: soc: replicator: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: syscon@1200000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: timer@200a000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/watchdog/qcom-wdt.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: sps-sic-non-secure@12100000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: rpm@108000: 'clock-controller' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: syscon@5700000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: replicator: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/arm/arm,coresight-static-replicator.yaml#

As far as I can see, all those are generic rather than being introduced
by the new DT. I'll send a set of fixes soon.

-- 
With best wishes
Dmitry

