Return-Path: <linux-kernel+bounces-571566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09394A6BED7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D5D188D6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968951E5713;
	Fri, 21 Mar 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwOqSwML"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA351E571B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572428; cv=none; b=H9w5HsLPyTJRGmDLPyl93oDcTFlP84fG0iyPBovsTirYJmbrkiv4rJ9pbYINq/OWp2qC1+rR/kwl7jv+64Sk3jDMDroB2mJAEy9P0EScf9JwFK9cMGeNW+EVGtskgYGqQznoxpqRHMfOVIO5+F5ei6hVG9lkHZsKNPH+cIybfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572428; c=relaxed/simple;
	bh=yw0rmi0N+1PoG1Vjfi94zYQFIsZ1jJ/dTZR2eWl8J5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrNJ8IW2hrolsXjbZ5U3M0+1+T+q7hEIyiFE1IwGRWAqnoM6RB6ZEelW7H6oXN/i+Ttw2RPNW3KkRdkibOBPoHhNC1rrJ4rcHIaWhsDFwp0VOS0IPmcfw0+IkHKoM8HASCGiOnh07FFjVlVYZmPojjfKCWMJM+kN0aVqJyammjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwOqSwML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATHIl001127
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LptmSOduTXZdmxLfabby/f0q
	YD+OOd89CLB3+Homj/E=; b=XwOqSwMLn6z4nHVnDSkjrjKFlzyirWWCntc4tipp
	mdieX75XroXRDdyorNmXzvbcciaq9pQf0LkT+vPXhl1tTisgbArrLN6Ph6XSZ44v
	PHwfbPbgHbs5PX8XZVoXC4/+yhO7XBakxe3gIuCGR3htwRDz22CgcWUycxORItcW
	pA2ZMdE3ZJxmcxw750xmNfalecsyaLy8KbhYk5suDi2RT6GD2cPITOt0xOrs6PIl
	xU5BZUQZ/bZ1e/a+8lfPk4uJljvvUX/DmuetZz8cAPTpO4klaZJdCdxxPAbl7H1x
	QrAzjuAtzNmsEZ/dSBZICyAlxmsNm6/Nc10mLWvE0EK2KQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4u9s5w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e91d8a7165so35616146d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572424; x=1743177224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LptmSOduTXZdmxLfabby/f0qYD+OOd89CLB3+Homj/E=;
        b=hcIYGCPxkL0Hs6GyAkiFeHpBoqOzuOc9wJ8VSTRnc0s+oVebBIJpLilxKe6p1ZKvWG
         0qlUUvyLZ0yVC3uFy7NEnHJCqUxoALK8cQxVOHVKLxV/FOoguFniwpcEcvuoWTsa8OFg
         Q4W40tDz5T6ZmF+tL/BCx1KsuQeP0JJAF8wuUS/Fn1z1PGtvEyix7uXTuSk43YBOfA4B
         DDHu5eOQnGn84a3ypuamAakdp7TQ7/Cq8N7NgJc9fokaw5mZ8cFlOkgmw3RpLXbt4lR4
         IWKT6U6+UkZPM05JhtY90dDDO0pYlgvE7b6jU0hdIypApEKb0G4UuRk8e417JWs+5LjL
         SFJA==
X-Forwarded-Encrypted: i=1; AJvYcCX5q2NBIz0CrJg4dOpMCZ/K9bKFrDiY9DLrsUlVXthKAB3EaJcQ2c3HYUVKidRRe6UWwR7yT13niQya4jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXsuXN/m9JH5IxphewlIPkeLKKcPgQ1LcQAB8C536m6MWVAY/
	i69Rb59Acv4tfzGuBKhkv6ZwgDlw56QjxbNWK9yyAoIuJSaqZTHfyEN6mEH9B1S/0+xi6IpXupJ
	F0WeWs9v7jvphnWpstfiGZkxmno0Kf5poEI7eqCxop3LvtQMo26miQ/VT3PjZmXM=
X-Gm-Gg: ASbGncswtk/AnUOJqaV+gVVdIlolq2iUMoTNRT1RHHlNtRWPAAsdIzZ9mjbdRAibEGf
	h2BbKHRxApbTFGH9uYtoyLpBTe549M2dBA7dqf7E0uW8b+MChhT2yZmAgs+w4NOUnrhyREkBKr1
	6X7+266ogPkdApdrXGpVmmSd6Z9wn9L8MqMHHQptuMJmfQNn/Y6IN/R0VabLC93/jO5pZidwS63
	pgnKpyENYeNBZMKbeQrRIoiw+h5q3RAuGq0YJHsraaztvpPOxrc6qCoRf5kpa9tYx2Hv6b80gOJ
	w2k7HOMztssEw4HblK0Isiydi0HVgPbgOagMG6tEDxuean18Qezz5nf360mCca0IgylpFxtoT6y
	BEX0=
X-Received: by 2002:ad4:5de7:0:b0:6e8:ea17:8587 with SMTP id 6a1803df08f44-6eb3f3b7b50mr46274806d6.42.1742572424186;
        Fri, 21 Mar 2025 08:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNM19+y0wvr0/rSNbRv08Ya/wFMH3feSKKK/Zb7YMAXHSS6ZMZj7DV4uHlqvystkp4UnLvjQ==
X-Received: by 2002:ad4:5de7:0:b0:6e8:ea17:8587 with SMTP id 6a1803df08f44-6eb3f3b7b50mr46274196d6.42.1742572423624;
        Fri, 21 Mar 2025 08:53:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad651237fsm209084e87.242.2025.03.21.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:53:41 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:53:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 09/10] phy: phy-snps-eusb2: add support for exynos2200
Message-ID: <wwvjm4576r437tf2thbqseca5fobedgrhjk52iegwz5qnlhfv4@pnsl3pvsefwq>
References: <20250321135854.1431375-1-ivo.ivanov.ivanov1@gmail.com>
 <20250321135854.1431375-10-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321135854.1431375-10-ivo.ivanov.ivanov1@gmail.com>
X-Proofpoint-ORIG-GUID: DherVC7kHBG1efjnkM76onvwwrLYMEJp
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67dd8b89 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VxB2ctdoYg6PJSLCJaAA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: DherVC7kHBG1efjnkM76onvwwrLYMEJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=669 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210116

On Fri, Mar 21, 2025 at 03:58:53PM +0200, Ivaylo Ivanov wrote:
> The Exynos2200 SoC reuses the Synopsis eUSB2 PHY IP, alongside an
> external repeater, for USB 2.0. Add support for it to the existing
> driver, while keeping in mind that it requires enabled more than the
> reference clock.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/Kconfig          |   2 +-
>  drivers/phy/phy-snps-eusb2.c | 162 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 5 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

