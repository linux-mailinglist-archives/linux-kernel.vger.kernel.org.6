Return-Path: <linux-kernel+bounces-569266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC04A6A0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E293C1797D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165591EF39E;
	Thu, 20 Mar 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2P9OlCi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB120B803
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456961; cv=none; b=gJJwTdCpDQ5E/u4yi1m6jZyrmN+LjDL1+cvUL8+DAMoU0b6+f3dgZyU1o+9jTuPleIm5eYo7XiwQK5uS+EHbK/Oi+/w49zwVhzRCVIVi5fF9QZdsbBgtIfEl2oLHygZcqG9GsuXtbF4EFri1g7yPzte4TPt6gukKK0R8gLdOWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456961; c=relaxed/simple;
	bh=9xyRInh/JuT22nwzulBLrvoDfTg+RPaskoAt6Jh8wIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3uvPYwX5nCmf36W/fAoPiTxyEYS5KlYjOI9Xe9mmpZrYn3QuI9fdoQp3zq29gP5UCU1SSQQsLAOxMbcrJmQpdKCMAxZatcJsdzGz0NRoUq7kHSNDQ1YnT5dBSQZc8CywlPKajoEsuaDncD9v0+UU5955VDJfIv+XdA/qb/D7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2P9OlCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z4J0014237
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y0yS+aQTmw0yZPeMQpU10U+O
	l5ONqbJCFVaNlZvX0Gk=; b=o2P9OlCiXeHE6JsWF/dFuB3V7cPQzgELmd31K2w+
	hmIx26nP5s1F6VyAx4ubc6xddl6g0MaF/B90uDIW88GTHyTIdFBeM0AWDWQNxvld
	F998F7Ocm+DgCTGi3ac3YNUzLypE4t6YhXWVv5GxPMTbs2dnIwJ8sh+i8jwL4xMC
	lDpj21sj1WaXEjpVImH51hwoekyxY+W10Tvbe+Tgjr1USNmhWxFTk6fq21ECzCWj
	OhX2cpP/gqpyFZogTBtZdLmEgvk1EU5vpKSQFP4Tm0Ni8j9424M8OQETh69kQp7g
	qxW7W/0pj2DM/GFpqJkrJ/2AA7CZH0jzrMtQDiFutN9V2Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g09f26mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:49:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b6450ef0so81562085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456958; x=1743061758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0yS+aQTmw0yZPeMQpU10U+Ol5ONqbJCFVaNlZvX0Gk=;
        b=qs7Aad3EK+xp+1alI4lR2djjaMaZee1xb6o2hWMKLkApgnPizzCNVdCqkt5S5aaFXv
         7oJ3d2pzamh2LH1TSrhr93D/L6H8B+/C/Nv9MOfbC5lB1vbtLKfF1XH8A9bthKz3VKsE
         jkXDGx83Y5Fe3k2Zbid7KRE4DcYcTMOnbRt9rUXig98/L/Fo7gw1ir59LrSaYGpXxKbL
         konGXm4vUrKzPupgCOjIK6ZPkeoAuLrfE1EaWq73dpXgfZNEJhQyhgOvEbdOAXXGnw1M
         zoAWhFRNqqO4comtmJrFbjreTbFoWggl3noF8YBXB3AYWylxfjggAYVj23GAqof6Zb63
         HkBw==
X-Forwarded-Encrypted: i=1; AJvYcCXGE+eoKv8ezv1QGcWCZ4XPib2MBF/TGyzJl+9z//DZUT49IVglXRVfv9weQhJLedvckhO1V+RNJgatMXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaIVXD6FCLbi+PKyz7oz3U7CsDVRj34ZFFPVQLipJxnN5Vb/0
	ugTVoEPX9n8ZIHXYboIMD9SCGAfB409ud5bcIBZeNJmDm26/cBX2aY2TCB35KDHDazsFHU5AI0i
	KNMxb42jDk34Pc82Y+9fJBxjfFZ10uLObzlOZXAL54M8LFILAc98pPRmjMG7vU2M=
X-Gm-Gg: ASbGncu+khmSGTLL1Ii9JSAX1KtSjH+dS9Yq+deR1YAFgwykkMda00TfKwY/+I7vTMv
	6f5c1xMwyK8K4XXvUj24SuQFnUsp3Wh0mkFGy9Szi9A1k/w29UqOYPUtnURlppEJoNk0vEhLFWQ
	WHMeoy4oXXm/z5wRxb6JptP53DSh4M4O7XhV0mV+S4O6Q3lh+tSQrx/GCFeCXdmAbBhOwSVItUn
	hlxxvL64od5bkdbDIA+y2I0xQTQksXjhXobySMQdxn8dRef8FsBWvHrI5xM4377uPqRbBzUlMs1
	oVwlhBSpLLE/4JmFthqrz8Dxys1z7mCrzKOzptxHSv9IXG/fORCo7xyVqF/1iMBXsnNFxGVFFmo
	jH5w=
X-Received: by 2002:a05:620a:1a90:b0:7c5:5343:8c2c with SMTP id af79cd13be357-7c5a83d1517mr790764885a.27.1742456957973;
        Thu, 20 Mar 2025 00:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Z5BNkfpKh97ly69kY/44WHPpgB2U+BPmvSvPMFr6Be++EdmzzYicH8E8wyVmOTRhm/ENMQ==
X-Received: by 2002:a05:620a:1a90:b0:7c5:5343:8c2c with SMTP id af79cd13be357-7c5a83d1517mr790762685a.27.1742456957653;
        Thu, 20 Mar 2025 00:49:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a8bf7sm2122917e87.223.2025.03.20.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:49:16 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:49:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
        quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] misc: fastrpc: add support for gpdsp remoteproc
Message-ID: <3zrwjody6ffirauzrtcmvr4fp6nx5b6eqkt2eyt7nxm4jfwjn4@pceeisasgxqn>
References: <20250320051645.2254904-1-quic_lxu5@quicinc.com>
 <20250320051645.2254904-3-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320051645.2254904-3-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=BvKdwZX5 c=1 sm=1 tr=0 ts=67dbc87f cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lc4KdpPQecCvDiYUKO0A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: r5T9w2sJ60521SYaaI2pJ1j91-haQecW
X-Proofpoint-GUID: r5T9w2sJ60521SYaaI2pJ1j91-haQecW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=804 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200045

On Thu, Mar 20, 2025 at 10:46:45AM +0530, Ling Xu wrote:
> The fastrpc driver has support for 5 types of remoteprocs. There are
> some products which support GPDSP remoteprocs. Add changes to support
> GPDSP remoteprocs.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

