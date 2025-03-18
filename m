Return-Path: <linux-kernel+bounces-566945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD87A67EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D69319C3CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851E1F872B;
	Tue, 18 Mar 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKD8esFq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875717A304
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333566; cv=none; b=hO/viEAx65Ejfd3TZCh8oVpYpVNEHCbsQ2QjCQEJAH77Azanz4wmfrAXDvQMV3LrGNkiWjCOiHqoCcXSQBVgpnz0cDkPNv0WcgPrErJN9lJ5QevZru0vtPgvZXuwKXlfxOvsfUY/kN6RimoQLbmslDoiIVjUBdHxIRZQr39mblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333566; c=relaxed/simple;
	bh=xCefQxY5eX5TyNCZN3Ts5F4MHBnzagPkrKVWljYA6ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFiV6muuToRKO/fQe5/bjZImUMpQ8id9+AV3zFGgQ5v/XPdBbKN+Gsrg/yOO/MOlIajbE+WdjLv9cec8e3oOfYeqwntS0klUCaBW6VUkJR+9QdohenTQ1iJFC0kkL+tEYqtq2htUq2s7atz9MxrtLMMDL1NKZoo4g+8AxqbGuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKD8esFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IHoZ42019356
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gPOW806eFczV4bEYj1EqtuH0
	iSacm+l0DRcJzd65XIw=; b=WKD8esFqZrV95QoSeR3zdxinsFLgvlt0u8ZV3+e+
	jxfwffHHsek43tma6P/I41dD/v8OtZUKnhgTotqISLh1foCrVGsJ/xbJOk7YdguR
	ZWPcz+hKACRRSJxCPSAQ7aAp2bIJi4fJ52ZUOt7U9eJ+SZt1qOSQDAgl9eJqcVC3
	8HwaBYbNM9XMsgB+bYyADwQliMETakQf86XyHxJq87EqET5V23ZbFsz01Ath3O8/
	t8sahk7Ay7npnjNrcwkQ4G3tTvaZuvFFnLSTigy1fWPtVQdUcItb+nGC+n3t9oSZ
	o7qPwWV9i2lUAlsJU6irZmIsxJmeH2OtN6jpeOsosljoFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu1jdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:32:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3c17f91dbso1058631285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333544; x=1742938344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPOW806eFczV4bEYj1EqtuH0iSacm+l0DRcJzd65XIw=;
        b=SEaWt1SRBZROMG3dTdz/Gi4bhvbk8e6IiFH+b6LpNFw+TFYPCenqK8+rWpE6dJWwGu
         dm0S1iwpOXvK2iE8l2hscky6XqNsGiyYL99ALuEZh8RVnqxemun1oPC++Qhaz6u2pQBa
         rGu8821dn1sU2Jxz1n7YIKSo9cWP7ibH3QNXlZjHZRr7A3XzO0BgIoRlPi1excjephL/
         tOxsxGnB6Qwhg7CXr1DMBjp7T5gyd0e+ZfsET6njlJhbwCryS54dxs27Ue/81Aax+gc2
         uscoYDBErUSf5t72mMJ/Rhch+IRSI4fOF3ZWLW7uDHHB3oOyeljfSxp5DC4WCQHO7oOd
         h2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpTLXa424dTtWhXPhKN9PVGedihEvvWmeUZCWzAnQbfk6qtRydVuPRlMRe5DttzqZ3TqgX5kknhNHAjSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnZAQHSUTu7IxUbtkNABdbspTivcZPWpTZY6dwW61SoDKTXG8
	6qxlygM+qr6VDgvi0sGJy6vzV2lROd/fSzvlECJX9k9PwxnKcXtNgI3yXUVooQ6LYVixMCe73Ph
	jITjnCLMvktB9iWw0n97a3t7ECpMlP2GS+uTz/dVri0gMMBgRM4fM91+Lmyr/WSw=
X-Gm-Gg: ASbGncuuH1ezYu9ur120+Pth5Nr8feQFE20pdQkmpnE9jk8t6vQt1H6uS3RH5o0P++l
	FM+aG80uOruXNQg9xiU9Votmr2CbcfBzAQfW67hzMqBCuTPEy0TzzXS/u4lGlz2viTIhJH8b4U+
	8Nb/KrRMqDaQSoDHhmvhNupbFIdKqgNGqUtQfSD6hwRCJwOOhIIE3CXwQnacc8kiF57n0dhonG9
	IO45lu5PBOeJ1U2iWawxsXjt7gb8pqiNuqbIHmADFB6U7i7HFLy7na31Why511mc1fWI7Aibaqy
	WcxcvLiJ+BvfrNYGemq43U2hjFZLtbt/73elsPgW8+e2Pfpwv1DCJLSXKFm9scfWGAFINDmAaRV
	gtUg=
X-Received: by 2002:a05:620a:1a90:b0:7c5:5343:8c2c with SMTP id af79cd13be357-7c5a83d1517mr35364085a.27.1742333544240;
        Tue, 18 Mar 2025 14:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMdxu78my2UQBc4VCvzpYeoYb898Sl+qrEPDXLGkA8XwpYzSSkbR6Z5orjrN/urRBvEFLanA==
X-Received: by 2002:a05:620a:1a90:b0:7c5:5343:8c2c with SMTP id af79cd13be357-7c5a83d1517mr35361185a.27.1742333543863;
        Tue, 18 Mar 2025 14:32:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bee7fsm1774919e87.54.2025.03.18.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:32:22 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:32:21 +0200
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
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8998: Remove mdss_hdmi_phy
 phandle argument
Message-ID: <pxnpqoolslizrgvjvr3mblxz5hhedwx22xkhrwck56g7cdlmjt@3r7l5cmmqn65>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-4-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-4-cb36882ea9cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d9e67b cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=flz5pWXUi7tf7Cl3TxAA:9 a=CjuIK1q_8ugA:10 a=f-3eBOmM0es_zl1mbYjY:22
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: iJxT2tdfIvw24xD38-96FZe6ZfXLNY_m
X-Proofpoint-ORIG-GUID: iJxT2tdfIvw24xD38-96FZe6ZfXLNY_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=433
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 07:35:17PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node has #clock-cells = <0>, as it only provides a single clock
> output.
> 
> This leads to a turbo sneaky bug, where the dt checker shows that we
> have additional clocks in the array:
> 
> clock-controller@c8c0000: clocks: [[3, 0], [39, 178], [156, 1],
> [156, 0], [157, 1], [157, 0], [158], [0], [0], [0], [39, 184]]
> is too long
> 
> ..which happens due to dtc interpreting <&mdss_hdmi_phy 0> as
> <&mdss_hdmi_phy>, <0> after taking cells into account.
> 
> Remove the superfluous argument to both silence the warning and fix
> the index-based lookup of subsequent entries in "clocks".
> 
> Fixes: 2150c87db80c ("arm64: dts: qcom: msm8998: add HDMI nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

