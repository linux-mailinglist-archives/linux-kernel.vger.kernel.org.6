Return-Path: <linux-kernel+bounces-572813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011AA6CF0E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C99D1898C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5A204864;
	Sun, 23 Mar 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AiWfrKb6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BC1EBA19
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742730979; cv=none; b=Cm+HGkyR23VU53nR4X6eBbIWIeQc+SefgBZiBVoDD5dDRQ2c9uraRLd5JRLCXZ+A5dyONA0vg3HKXIbvSbSUQM/r6sk/ooaLImJCUsqf60SN4i+/CoesX0KfULASTdJCtHVsi8uEeTAJiW5bJzO9BrpzSI5CJloovWzXM8nZZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742730979; c=relaxed/simple;
	bh=zbaR5ttQ56jRSP6j99iVgll8r6z6mbqwkIB/rK5/73Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaI1Uoe9YdLqk2MlsyeMkmj/thNiaPWe0qHtX3yj6++w94ePDMu+qIsRAijLYEGtWCUbTyFH3JEnWVE9jy0vcUAc3x1qtLoYZz/ZtcG1VpQ7NBHn8YinXhb2EtqDimp4k3soCHL0WJkrTvOSKGFT/e1UHtL/kiAUZGpdbG2yVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AiWfrKb6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NALNdA002140
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 11:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nKaIoOJgUOqFHM43prnMCY7L
	31hLWRx+UXYn0c9TanU=; b=AiWfrKb67DejDlG79c1n4r1AVhY7UzOcTsJtcOJ3
	l2E6gL+05oMxmn5ghCEqrr282z0y8ksHhsDSmA3EEPx1nV0CEXXO8II8nHnKMjvW
	GYR9HBUSUuDc/FoTPF0xfTzjIge+smpKQ1lXIi/hUWUcSbicb6aAzbRZALgzE2yK
	d8+JQBAnOpoiBTmH5IKGRtKxHJQ7rAXhrOSCfpPT0oQlzj4B/kCw5eKh+d9I5fts
	PCbY4xFcc0y68Dkkyazts+0wM7CpgyArhpoLuJ1Po42bP1Q/UjOZsjEPlt3u9y0H
	iHfyzCLk8sElh7B4lDnkcoP4X+PQqEHORkKFOVzeLcpcng==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79j31g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 11:56:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8fb5a7183so68435906d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 04:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742730974; x=1743335774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKaIoOJgUOqFHM43prnMCY7L31hLWRx+UXYn0c9TanU=;
        b=frG7DqS0MzPS8hpeVjCSyCdXzmuhfVIDI23/KBMKqvphwEk2qdG9bSTMqW6TYZSmLL
         tLQ1DxAt8COAiNEmqxZUq0kXG9+ngx6qrFvUhi9VhiGb4bpf/77G1rD+i1NGpipnzx5Y
         dLwMktYeurV7STVCtgHmPsO7yPJ58ixQI+7+H4BSqb8tdM2t/MwqfPwC7TRYEYEs+3vg
         9OWefZrYdB3x8BmQcx+wgJAzAZHXrpkovjEOksDhTmDwHFnrX6giPAC6Z6k0o2nJCjjG
         1QJtJDk8aPdnWJpie69qBXCVY0jj/3EJTE0ZwcX2u34df/WYwjLDVF1/HPUied94inq+
         hINA==
X-Forwarded-Encrypted: i=1; AJvYcCWiMiZ130KafYsbCUCNZZRF9nS0Y90GOm3KgfO48JgH859zz5eNZ574Y1jy0F5w8dFtxuODXPVZRsXRT/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXhJ1z75HDsZbRfFqF60nBtgLP4BoTNcYZ+29dILGDuGeHcJ4
	q/s91RfUrotl1j8xrXz0SZaWb3vjtlOUVdiXNn9ZehMLnihODgZPDLaRlrG9r6+RRFN9OX8UFmm
	BRXWRo+/hAIzsegB3BF9hMeZVh6T5x1iHJM3MC6H+F4nzbwkuwbJMukMo9PHFN6k=
X-Gm-Gg: ASbGncvb00bm2f+vM/k0+La+UhKhvJwfq7G7YXKJEG2WTii4lTu0IgvNwOZIqF7C3BX
	9dG+wW92GjRFpQosyXMWgOdTkUFK8xnqQi+cG+yKKN/XPvsogPdEP/LiMb7zaM3xmiZlUId5LDj
	N37A2uQ00o2GMnjUdS7bn0oC7g5yvHQUGTl3C0IUAqv6apEtBXwa6yUxELVYcXpo8ZAUN2YxfN3
	syNNzfvXsVhUXYbd+gacfxaikckxqaGoeYw3XjFZZF9QC9HOfAQa8tZM5qI0bbLxJ8c+s8k2BeP
	XXqA45SS5WxpPq5RMJwH8T0m48hDQe7o0l/WRWS4AxwL9vybgmuLEQC7XyGsJmHNKuWvS0L/htd
	i2TM=
X-Received: by 2002:a05:6214:2245:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6eb3f36a59dmr173614076d6.44.1742730974010;
        Sun, 23 Mar 2025 04:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAAiKi3aiC5wUmJTjj3X1TJwxYZnFKUNEvU/LzEMV0zcnUdHAGkgX2ulK6zhWQkYHOe3qQ/Q==
X-Received: by 2002:a05:6214:2245:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6eb3f36a59dmr173613826d6.44.1742730973595;
        Sun, 23 Mar 2025 04:56:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646d2a5sm747971e87.52.2025.03.23.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:56:11 -0700 (PDT)
Date: Sun, 23 Mar 2025 13:56:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, megi@xff.cz, javierm@redhat.com,
        quic_jesszhan@quicinc.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asrivats@redhat.com
Subject: Re: [PATCH] drm/panel: himax-hx8394: transition to mipi_dsi wrapped
 functions
Message-ID: <xflxj7nn5fs3d25fdhatnxnem24eixjppbj54xbokisipjscr2@ogdvnmgwn23g>
References: <20250323053007.681346-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323053007.681346-1-tejasvipin76@gmail.com>
X-Proofpoint-GUID: nMu8Jr2VT-MnLW8MkC0l3DHECSqD-tu5
X-Proofpoint-ORIG-GUID: nMu8Jr2VT-MnLW8MkC0l3DHECSqD-tu5
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67dff6de cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Ut_GpTIo2zxuSFPkNb0A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=737 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230089

On Sun, Mar 23, 2025 at 11:00:07AM +0530, Tejas Vipin wrote:
> Changes the himax-hx8394 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx8394.c | 444 ++++++++++-----------
>  1 file changed, 210 insertions(+), 234 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

