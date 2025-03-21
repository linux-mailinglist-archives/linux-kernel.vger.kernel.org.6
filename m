Return-Path: <linux-kernel+bounces-571565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9BA6BED2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7C18862D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5C2080CF;
	Fri, 21 Mar 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jD29Qml+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8ED1F12F8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572391; cv=none; b=Se8Q9tuF+vhjXt+03NWeeRYrlXs91NMh9Sp7bGz29VA3qixyDkd1PD/jxl4ao65Jpo0od6+MKaewccIP4YIr58b4fAY5RVBlpNUfjGAjTXeChoV0nE40WIRRQ+HJNK8VzelfkAiYO7TShlgTXiQiVPaSKfsIrgRPsixpzC6xEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572391; c=relaxed/simple;
	bh=Z0R+V8mIAAyfySi3sGNVs4O7MwDKBcqIsi51k8di+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9XNiySoSSO0L2y8xbzZ45pNuBrZNDoRp6qXQa/vgHuKnmQNELCHU8Omo+PtczfJt0mn0E/lVQoxYgDADiEZkNERffflyYdPm0TOi/nCu1YapOuh53mnLHxGX6dsBmw4bsFdTNUlR/mXbmdMxr7N/to42AzmIAmcM8iQ9pbWbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jD29Qml+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LCTH7G011389
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VQlDE2/fBoDju/XlglpVY6/w
	fpayn18xS3bj6jOtEoE=; b=jD29Qml+wTE5+2QhwYgyLZzkeSaTzE/Pij7VjbA8
	4k/oIrWsQmIIoY+EZfu/XxBkvCr9ObjmenKZfOZvT417avfhJwOHhvfnZTpcRbQo
	K/K05js6Gt8KWqcU0/pisHfHxvtLYFI1ME0D8iaphCtOp8GITOEWO92R07LO0hFq
	VXgVdxArFxisF0wZCH5OHYTnQptnX1R1gE5RxZM0ie+vgOZe8nTsfe9KWNBftY9K
	+NxWKq64w0ezd4sk2iEBcQcxJ/chx0OAtgyCIZOJC+nre/RG2hdyQ2WmJW7fcDUV
	H7hDNM6UhcPNcpQBIwVulZKgQBjKNw2Us8yTMtx5bQbnLA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h85e0hsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:53:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4767261982eso38444311cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572387; x=1743177187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQlDE2/fBoDju/XlglpVY6/wfpayn18xS3bj6jOtEoE=;
        b=HegfWgNIX9LIorBxER5JXOPxsKp0W6QFCgU5MdCW7qhRFV76fagldN6Xl1RbQqyBep
         Lj1+t1q9bR9+oWQoIsaeM6CpiFCZKdGhMNIgMrogXeg8/7uDMQoJkx3Egw6+AqUcBo3r
         MYpDMGQYwmy5/BIH/MtKejHIUWGe5fuo/WbzmBc6i4v5bMGoaO++6eG8F6n4fUhJNedT
         lqo22Fu7pm5wj60KY6zFrDso5xKUMZDA8nHJ/HulvjGonYVgZTtB5oN1aJWKHRgRoqkT
         82IVBghKGyorNag7KFSuo60u+qeHZRTS+jcCoBNIV64P+i1CAIUp7GREXMiPQ8GUjqlM
         EDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Nc6POpwjpS/re9DswE0YrW7A/Pk/y1B7BKS7U6RrNHDNdSBGApIaN6084S2P6DkSYnLZK9E42tdd+Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RPjm3XJiX+JxkxxzljATltE6aY61Nc491QJEEpUchjiyVAnK
	EhaCgpw4hdUwqBqeJ9/9T31dl1d4RrXW744LOtOy5c6Ss6Gd+8zLBefV4K/2JonU2K3a4uOKFqH
	BqW1bszUzecucfO+aa7b0INJJmJh9dvqGzVf7XKRaeCfmjU4QeeP0YUi2SxyLYhs=
X-Gm-Gg: ASbGncv0vyyWqidar85GRmhhAKCVR6mdGNfioCPUHIro2B2TXCxoTcDytZEYkPl3j/9
	hsObArqVAFib6ulwT23A3KUKo8J0sGUtzk+EKv5yEmHWqbCC9F9HQeHiHRR4TF1h7F+K44p3kxF
	p+4lfcLPVmSO+iZLbcTcHwIAgBxw53eMPwXADAHcvA0sTdmVxDXJYMQZE+HwSsSl4QtItSxSbGO
	1tlvei7HlQZysQiF6qa+POLRZfwRaFsNKz5VDkeuEOIm47pX83aIpNocO7/JvpSCdxrrtTf9OsG
	xZYTAiHwvRDrJ9J83Uk6qDbP79fG9ebyfFlnNx75zip+GEMpL/Y+U4bob+nf1bvcfL25HUHvxie
	E48k=
X-Received: by 2002:a05:622a:180a:b0:477:1e1e:de with SMTP id d75a77b69052e-4771e1e070bmr43919901cf.0.1742572386750;
        Fri, 21 Mar 2025 08:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3lNdzhAtr0sK0LLAK9PFg2BBOEsioVsVc8qjwwC0svOGQ2IU+IMTDXrTnp+MfGwnE56Mnog==
X-Received: by 2002:a05:622a:180a:b0:477:1e1e:de with SMTP id d75a77b69052e-4771e1e070bmr43919501cf.0.1742572386254;
        Fri, 21 Mar 2025 08:53:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647c54csm216260e87.66.2025.03.21.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:53:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:53:01 +0200
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
Subject: Re: [PATCH v3 08/10] phy: phy-snps-eusb2: refactor reference clock
 init
Message-ID: <vphiep5kvusrsyv76a3hdnkso35isoe76uy5hx2vm33tix7yxl@4qh6sk3xe3nu>
References: <20250321135854.1431375-1-ivo.ivanov.ivanov1@gmail.com>
 <20250321135854.1431375-9-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321135854.1431375-9-ivo.ivanov.ivanov1@gmail.com>
X-Proofpoint-GUID: FZ6ZCj32w_ECn1tHaWapj2qkEC42rin2
X-Proofpoint-ORIG-GUID: FZ6ZCj32w_ECn1tHaWapj2qkEC42rin2
X-Authority-Analysis: v=2.4 cv=LKpmQIW9 c=1 sm=1 tr=0 ts=67dd8b63 cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bmNeyW_Q0om-5_paTGoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=734 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210116

On Fri, Mar 21, 2025 at 03:58:52PM +0200, Ivaylo Ivanov wrote:
> Instead of matching frequencies with a switch and case, introduce
> a table-based lookup. This improves readability, reduces redundancy,
> and makes it easier to extend support for additional frequencies in
> the future.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

