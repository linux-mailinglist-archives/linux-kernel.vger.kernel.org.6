Return-Path: <linux-kernel+bounces-562724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF0A631DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F711897522
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34034189916;
	Sat, 15 Mar 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnzTrLOQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064822F3B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064420; cv=none; b=ICO6I1S+zCJEhPuZnpC0yZ4+dENUWeQa3R7pJLoVTutfD0ysJEMMkGTFwWxBSX91k3W0OsMQ4P1B5yPStUcyuQaeRytGy6jbSjsYPnMEPLp5ELRDPdsiZ3P+Pg8Hz61W3LMs/wZ/nznj25obaN+3s8FN2sKA5DmVYOm48GrI/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064420; c=relaxed/simple;
	bh=FG+MSnJUMNKihNcXbFoYUsyKgXGlOzLpZG1qqTaQLe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjXg7e/ITRlLE5BO7u8PuY1PIir33s2RRPT3mBiO1UHrTp0g7XqFHTamsdmUBSjbSrv2Vy+YJOqvE0Nv1Je1FUsR/tvOAKH61yFZXzS2Btbl4u7NkYq8OywkoWZqEHNMtikc2qfGnZerJSF/ZOP4xzY0aSekLve545RdOyTQTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnzTrLOQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52FIX1l5028099
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cW7zBq2vG9Kq4RtRp00LNhyk
	wIwKr7TZJvVXzuqO9uY=; b=PnzTrLOQ6ybulUf+7XRklfe9qzLZDrZzUe+JZ+jF
	fTubIoy87x8eImo3B6LFzcrkAalcv2y4ftTGTTa6XLQqxnAXB5EjoB6KgAjJ0so6
	88hWJHTphJY1WrhxbJmewuYxCGotnbzwMw8UGMptz/GGnUP1OPjDPyawmOLcE3du
	yT5fXoaR8lbSoX91CjJ/OOIPGNCZh3fklGm5Y8XJzfRNDTXEwRf+OnSJMBdOF3fx
	wzjfz+FGp+xre0+stAyvRFGWA3neqgOh4L/F8z7ggVr7BqfN0zpX+36z6gop1k8I
	akOS2aNq85koyBYebCtelqAj6qEIua57YxOpjhhlHN+aVg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r113kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:46:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f184b916so95095116d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742064417; x=1742669217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW7zBq2vG9Kq4RtRp00LNhykwIwKr7TZJvVXzuqO9uY=;
        b=H1YkV59v8+LjHDPHZ123xzwsWu3lKek5Mvq39mqXMV5fYxuhPnVzDtNn77dQDXqE/C
         4VxKoi8G+QQK5mZinxb6xCSI3vI/xRR0uavgNwcnnvWqQFAmZRYjgZPCifDh5XKlAu9p
         6F2xBFb40JnL3bARtdg6u+JFf+XqP0xsKlRPgrdubNPoP6nKS0WykGfSqX+UF+lyVNeD
         PlQ8qJJOv0t1euEckx5PrgN+b4IKz534t6zRSrzDSyFwZIPqPbnTWHu/WUE28i9ELVk9
         PcSBlEWEWP0CQrVbZxEAaYk1mMcc0eoHgkMjTMUOuJmcAXe9f3qiLPr48+lfmm/f9VOT
         4TJA==
X-Forwarded-Encrypted: i=1; AJvYcCVdTCMYaW9Yx7aRkA/TerKsxcdIGtHrgBXBqp11g98uN2gby1gHvftmFd2F1q4iMQl/mNtdMXh15bFjJ9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfF6LQEmhUJiExfet8YccooBUWKNzWwcMfJNCQdhL5dcxz2w4w
	IkauMFmZee5RuP3u9JKLEoWoChS2p1EXe5BpPS0w0XiO/2moRkTQKZcZlAxkdmMAxGLbPoY6cF2
	kqBZdAFoUqMBBRiDQL0+JXM4409XJcG9Wd2xwqasHKWJ1W7D/WJUrmLBiV8Cw2qA=
X-Gm-Gg: ASbGnctaD/BTGd37RBgIdVU/f2iFWvmN+0hz+3RFCwK1qGijIpooXLgReUBPfI0XxnD
	hzntdJyIG7AypgMn3jWXXVvP+6PqXpEqxByGGYw1n4TfCApl1UIn1QjkN0IceqoYUdNv4OJx2yh
	S/V4xnzSdt697LBcuC7Aaszhg/r0tRPLgMyrn3tzdC4bZoeUnPmvFisC73THIFb+EbdHRTcMJ9E
	qV6sOKMAY4zlo6JDnHaJaazzTVT0LxP3QPb1WOxmli4GGy75kp0ObFzvCozx5VUweuIJd7f6SFO
	hHvBJDaVyWWPpUa+XEJgPzSiwrjUGHSK7ZgwJjqP2OTz1uAIpp0IOuU6Ja0jTpdyHP8GQrTw+s9
	B28s=
X-Received: by 2002:a05:6214:e46:b0:6e6:6a82:4989 with SMTP id 6a1803df08f44-6eaeaaf7679mr80369896d6.44.1742064417035;
        Sat, 15 Mar 2025 11:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2k3woza25edkuOd6aOfh3Rheo47eOG6FJ5IAksq5indYFamjN7H0zk6nHe/RdyRLppcJ9Og==
X-Received: by 2002:a05:6214:e46:b0:6e6:6a82:4989 with SMTP id 6a1803df08f44-6eaeaaf7679mr80369596d6.44.1742064416623;
        Sat, 15 Mar 2025 11:46:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1c217dsm10225061fa.65.2025.03.15.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 11:46:54 -0700 (PDT)
Date: Sat, 15 Mar 2025 20:46:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, lujianhua000@gmail.com, quic_jesszhan@quicinc.com,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, asrivats@redhat.com
Subject: Re: [PATCH v4] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
Message-ID: <yxy6dfmvckthcbrnojnsvxy5g7jp274axk4eh76rdezazub5af@s7nb72ufr7io>
References: <20250315182522.628187-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315182522.628187-1-tejasvipin76@gmail.com>
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d5cb21 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=Ajo0Ny0948vakP_J2TsA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: qpDQ8I7xBzv5VLcWDv8M1kd7BHkPMP79
X-Proofpoint-ORIG-GUID: qpDQ8I7xBzv5VLcWDv8M1kd7BHkPMP79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=573
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150135

On Sat, Mar 15, 2025 at 11:55:22PM +0530, Tejas Vipin wrote:
> Changes the novatek-nt36523 panel to use multi style functions for
> improved error handling.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v4:
>     - Cleanup nt36523_prepare
> 
> Link to v3: https://lore.kernel.org/all/20250309040355.381386-1-tejasvipin76@gmail.com/
> 
> Changes in v3:
>     - Remove mipi_dsi_dual_msleep
>     - Change mipi_dsi_dual_dcs_write_seq_multi to use the same dsi_ctx
>       by swapping the dsi accordingly.
> 
> Link to v2: https://lore.kernel.org/all/20250307091519.245889-1-tejasvipin76@gmail.com/
> 
> Changes in v2:
>     - Uses mipi_dsi_dual_msleep
>     - Changed mipi_dsi_dual_dcs_write_seq_multi to not equate accum_err
>       of either dsi_ctx.
> 
> Link to v1: https://lore.kernel.org/all/20250306134350.139792-1-tejasvipin76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
>  1 file changed, 823 insertions(+), 860 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

