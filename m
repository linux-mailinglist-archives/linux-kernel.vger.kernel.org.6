Return-Path: <linux-kernel+bounces-569789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB146A6A787
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56439168DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A95221F26;
	Thu, 20 Mar 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lukhED5F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7781EA7EC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478446; cv=none; b=ltRyKAa1QqQT9iGXgCAQ+0KLjOUupeVkg8+Z2NR3lYPxHL9RP2FLk0/5pnMgAH6gq6QHT72Ga5Ego2c5fvhoJRsag1HTl7ODDsLWBlbVRLzz86zGIeO40AK63pjaJ5KCT1DeGUOFlpxE2fiBkhz974gfqiut5TmCxwRzVRGTSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478446; c=relaxed/simple;
	bh=vi5feZBeyK+3jj8zNtetozOIArxBSiz9H4WI6VfA63M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1o1Vj1O2iy4DP8XxQGdr++UQRuQ5Fe53eENZoDBvgwKpGzjgStnWqXuHRdIOw134I2Yi4g74+qWlfAnF+7/1GQigtd1HCyhKAN6FOc3xYz5EisvvHmpqOKKZ0ZMD70//m6vfILmSmu1tegYq0WZyc6RzvQQrEKqMQqe3WDjRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lukhED5F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z5rX005934
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H46YjlJ+DKNbZ9xM2pIFspK1
	JAsXXejbR8ZjS3i17Z8=; b=lukhED5F0KZKKAV2SkH2ffNFwBb9021GOW8QV+En
	6wvLoAWXUWernsz0frUDtYTrLM5tYbNWO9vsVlKGj4bKDxJLcnPSCzhCKJJ/m++v
	xQ5gKFSOBf51LVpT9eWq0QFg15ZHOMlt3iwBJzZ4Lr4ZVNHPx4jih2ThlphsXf/b
	1m7TsDxc8JgG43ZT+UQcyawBA6X5V8TMW8MJVHbrA59G7oUWos2dceF1U2X4RXkl
	3NdujAdOKUd60YAYPXGUj45AawS66AgrebLEAYfGCF1T4LVKT4opbxHsCN0q1GX7
	9s58ZuEmqbVqoUflFkw8M1BjgIMrLakiZHx7dm/UpxK0GA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmc1v7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:47:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c54e8ad9b3so299445685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478442; x=1743083242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H46YjlJ+DKNbZ9xM2pIFspK1JAsXXejbR8ZjS3i17Z8=;
        b=Bw8x9GkB+ejuFM3mseie25EfyV3B4SKYO2G0Ug1ehE/HiDBe5GER08OGNDf0lARIBo
         /GMRyIC1aq4oc8DNzwHjOfYEgwwKP8iHwSDbTkuk47REVdXhXLLYYjbMS2U8phkPb22v
         xbjHEfrBed4nxWuqNrOskwhB9KrItod3lDB0hkcxWtCOhmubqXQKWpq2jvL4SkDoJ7kG
         WFk1aJQ5A4C68zdeUhqftlsAEvlodPALZH2a/S930HmbSV/5W6YP1oN/kY/21fgVZC9X
         zKZC5ZAkvU1IwIRlidQfFVfjXx4nLIkW+TaA27W6ajGhcXwhmjet1+64sRQqCSmClRYx
         lkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeRIc5j3jpo7Vds6SMJk/ARVv373YUAJN5a/4Jfy97/QCtLIIVF0g8ODG35L9oOXURiP0CDzbUMZiArvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsBVTow3DzkToa7wxunay49be4AbPNbu36Ushg1oAtp8eJbQC
	mplydcjQBz8CYgi9y8Avz+e5vM19FDdYI+/XQMNTuyTLN1aqF6vtHCU2Z1rp2HFqieVGLmJ+twh
	Ptogl4JgahkX7wMftzwYg3IaLbCe3M+TbBfKruwJWncij/t083jIxh1X1nbAMHL4=
X-Gm-Gg: ASbGncsMZZREapdinyF6TfZraRXXu2ef26jaMvUrCYXq9y51vFbqi6AtRaw1DRrVvni
	/9k0PIvX3/MBSZ09VR2xbIU601nvipyXEadE6BoR5IZSv8O8WTEyIWIeRKoPuFnE2JCWK/6fYtI
	UidrLzjocHyn2PgUchU1zTvB5SZJzWnJ1eINTwSHgiTb4Y0cM/8dSlhnKGsLi5lkbPfEA706ScD
	ZOKzc+OiBxP9hw0G/ySx9mQhEQ+oaw4r2+9L0Yc6vP/i5jD8Pbq7Pq0OrP/92/NG9OBGxlu+DR5
	bmQ6pC6jlk3h21aoQ4LG7GnS3jSB7bK5Qx28e4eByHUgsjRNyLIIuV46qkhbBVcA/Jf//FCEjY+
	lLCs=
X-Received: by 2002:a05:620a:390c:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c5b0505f09mr573403785a.11.1742478442389;
        Thu, 20 Mar 2025 06:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiCaluWBGrZz7qLZC7V9RGm2GJ3/lRrFDVv6gAtZkmBos91xCgxre1lxltkWev26yl+SzymA==
X-Received: by 2002:a05:620a:390c:b0:7c0:a1c8:1db3 with SMTP id af79cd13be357-7c5b0505f09mr573399685a.11.1742478441975;
        Thu, 20 Mar 2025 06:47:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a9c0bsm2281794e87.3.2025.03.20.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:47:20 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:47:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] drm/panel-edp: Add panel used by T14s Gen6 Snapdragon
 (OLED)
Message-ID: <zgzivcjcygbi272q3dmkff767cb45uoffwtx37ij23pi2g5ubi@j5bxjdbgqaqz>
References: <20250320-wip-obbardc-qcom-t14s-oled-panel-v1-1-05bc4bdcd82a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-wip-obbardc-qcom-t14s-oled-panel-v1-1-05bc4bdcd82a@linaro.org>
X-Proofpoint-ORIG-GUID: zN2J7qsJHX5-LScV0hE_xforlW-EN-Y-
X-Proofpoint-GUID: zN2J7qsJHX5-LScV0hE_xforlW-EN-Y-
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67dc1c6b cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=Ues91wDlHQgiS4Cx53AA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200085

On Thu, Mar 20, 2025 at 12:47:09PM +0000, Christopher Obbard wrote:
> The Lenovo Thinkpad T14s Gen6 Snapdragon OLED model has a Samsung
> panel. The kernel currently prints a warning due to not having the
> correct timings.
> 
> This panel appears to work with the default conservative timings,
> so add the OLED panel to the list of supported panels with default
> timings.

Are you sure that this panel can be handled by panel-edp.c correctly and
it doesn't require a workaround implemented in
panel-samsung-atna33xc20.c?

> 
> The raw EDID is:
> 
> 00 ff ff ff ff ff ff 00 4c 83 9f 41 00 00 00 00
> 00 21 01 04 b5 1e 13 78 02 0c f1 ae 52 3c b9 23
> 0c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ca fe 40 64 b0 08 18 70 20 08
> 88 00 2e bd 10 00 00 1b ca fe 40 64 b0 08 38 77
> 08 20 88 00 2e bd 10 00 00 1b 00 00 00 fe 00 53
> 44 43 20 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 41 54 4e 41 34 30 59 4b 32 30 2d 30 20 01 cf
> 02 03 0f 00 e3 05 80 00 e6 06 05 01 74 60 07 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 b7
> 
> Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 52028c8f8988d4b771bd2604256aea4cde4f4020..56eb57c8023fbbb5ba39f5fdbfa8e577400f751a 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2008,6 +2008,8 @@ static const struct edp_panel_entry edp_panels[] = {
>  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
>  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
>  
> +	EDP_PANEL_ENTRY('S', 'D', 'C', 0x419f, &delay_200_500_e200, "ATNA40YK20-0"),
> +
>  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
>  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
>  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
> 
> ---
> base-commit: 707bd8cceaac1af31d3eeeee166687bdde580fd3
> change-id: 20250320-wip-obbardc-qcom-t14s-oled-panel-b74fed21d600
> 
> Best regards,
> -- 
> Christopher Obbard <christopher.obbard@linaro.org>
> 

-- 
With best wishes
Dmitry

