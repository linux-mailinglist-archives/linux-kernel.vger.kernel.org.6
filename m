Return-Path: <linux-kernel+bounces-577124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC54A718AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AE51898E90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08BB1F153C;
	Wed, 26 Mar 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0tNZeYy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3751E485
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999695; cv=none; b=WYo6tOjTmizu5EsgnsiQkKCYZJ+aCaH4MU8M8lFguesQK4je/cP9M9D3gdO3wZgZI0dRiAeI5P5X7By26pq5/yUT7jriZMszivFXGHpZTHwXnp+I44IonVN8zBn5dW335Swv/kVSrkMu0YLMOONSrQBtGcCEiA1RxgY7O8pUhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999695; c=relaxed/simple;
	bh=hkLjxtxFnMmcf7k1i8SOyChknKCe/QRI3dgsGv5WSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQvE9ifqTetM5NV1Vc3z0/1GNkH8kEg/QT2Z/fCNOYS8KdPO3nl0oQ86Z3ZcNWD4WOo3w2llJlMZupA/bWVFXronx2gOSpbVbMlcEuHCZwF2WA5zVpOPt3GNspz8PG9HZn8V2okftaAWPFgX+1Nd6pV4Ojd5LPJlhBE1uLM49eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0tNZeYy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73Dkt009005
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=K5UW1TpqjCGvrPnveaTgtYvQ
	tV0bgWt6Sykm0ALy02I=; b=D0tNZeYyFJbFtiM4PHdeRq8/xvxhJFt9q3LjRoGI
	qCYyk8YXXRzw9BdRBCoXWddTiSoo7tP2KdjrurKIU4BZNZXai6kRsWZd5z2+Xgva
	S33oIx7imlZpn7mA6hLpTzoCl5mKmOOhkquuSqtDtVwy2MNZQrwYbbxSSnG7mfe5
	+1219HKMLdv90lWsjnujskR2kuQ6QyauNRvf2vTA7phhgZ2wsul96OClxr8GvxWh
	4qPOnU5103GqFN6BgfSjTZKHanZTyS3U9AD36f9aWdJpVE0V/IE3OIBh7pZsuWhK
	R0a86WYE1B3codWlm33OHWZ31F6hwp0qbkDXcreWXFdUfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd4n9hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:34:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c8f8ab79so979283085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999692; x=1743604492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5UW1TpqjCGvrPnveaTgtYvQtV0bgWt6Sykm0ALy02I=;
        b=eiItUjtE3Q2oXbMLOQ1qtdMgJL/m9ww1K+VUUyyBfxDTbJjV7ZJ7AIBchiGMD/trx+
         wP5PVQAy2dcpQf5kanRFWj4grxFewj0CnkyAfHI9RmDi0QW35te8RXxhrJsmNMqdqcJC
         L7Qyh4izEoIg8/R9fBkJlbU5M8wsJgOoshrytE/fDPCBwXEg26yTlzbePYtPKSWvCgUS
         ZQ4CDSI2Q6SDM6oAxBx6WRZcJddBtJQr4S3YXmSyLuFB8zwSw22SP5L685dV14JxUx4b
         yDEcHfox5U83GWzStW5ywB6nQ/2/oYD1a1mVngqFZhwA6Q39ILcB5dJDLcM/i9/caQtK
         xU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFjwRpi2xrdjGKNPI1LqmMm6UKIbE1gskRtmpFrf143YDhKo+mJZYz7+F6OdhNRUB/DverfgY3tLLvIdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IMvjTGhttHNJKUtdsqRDSCmz4c9EbsBFEnR4k0T/QZK8OPkm
	eJshNsRRlhGN7CwQdGl9Ra8g/U00DXzvAWOO+lwjehGFmByRCsLC1gHzrnygmjBh+e35gItHQA2
	FMbyK/XPrNeGj8Ue0zdybfs+9gRMAb0qecMtTd+iI1jEh9N7KBj7gJVWoicj6mg8=
X-Gm-Gg: ASbGnctcMqWeApbPUl0QUOy8MRD3mkbADatmlXHrO5tn1/vQ08w0c7t+sUoUEk/8nS/
	xsGr+Obl953L2HE5Ni8YuqFgHv90l2Wqc8JZyJVQeGbGlcWxjBy/OJx56QKQYVlHNc6+9cjiEC5
	dd7Ev5Xkpnhc4zvZAkSBZvMtJAZKnHHi6c2YRmqE1IzXkjEsjkse5CqWZ95pWaoui+z9osfKr2a
	jsg0QAoqsPwAz1+SCUHUZgQVaAxXrVx4vASMeLREJx/78r/3uarEMqBSmNMdwWAOngORlXS5D92
	3p+ssoBdNGyJ0+GK0Wgi558y2E9gzx79KtUz3sdA327GvrKPVMr5mEeW7oPAgjVfzk5cOyyDHb1
	U8WA=
X-Received: by 2002:a05:620a:2845:b0:7c5:4949:23ea with SMTP id af79cd13be357-7c5ba202c38mr3617211985a.47.1742999692212;
        Wed, 26 Mar 2025 07:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6PU+LTOnwomkjsF37We9FDJ5iV3bcXRlbHabhUpTUBXDD4TQ1EGPyPBf1OZiZ8+Pj6q0efQ==
X-Received: by 2002:a05:620a:2845:b0:7c5:4949:23ea with SMTP id af79cd13be357-7c5ba202c38mr3617205385a.47.1742999691684;
        Wed, 26 Mar 2025 07:34:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d8f38a4sm21948831fa.83.2025.03.26.07.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:34:50 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:34:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: enable UCSI on sc8280xp
Message-ID: <e4fjkl4ame46l4gguxa4cjans3w4evgcjksrcqpzdijdeam3ue@z3ydgfslr7su>
References: <20250326124944.6338-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326124944.6338-1-johan+linaro@kernel.org>
X-Proofpoint-ORIG-GUID: Vgb98N0SrCH77-jFDgYG6uNZuvllKmzo
X-Proofpoint-GUID: Vgb98N0SrCH77-jFDgYG6uNZuvllKmzo
X-Authority-Analysis: v=2.4 cv=QLZoRhLL c=1 sm=1 tr=0 ts=67e4108d cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=R4_Tb_Y2wpFPbI5QzzAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260088

On Wed, Mar 26, 2025 at 01:49:44PM +0100, Johan Hovold wrote:
> Commit ad3dd9592b2a ("soc: qcom: pmic_glink: disable UCSI on sc8280xp")
> disabled UCSI shortly after it had been enabled to fix a regression that
> was observed on the Lenovo ThinkPad X13s.
> 
> Specifically, disconnecting an external display would trigger a system
> error and hypervisor reset but no one cared enough to track down the bug
> at the time.
> 
> The same issue was recently observed on X Elite machines, and commit
> f47eba045e6c ("usb: typec: ucsi: Set orientation as none when connector
> is unplugged") worked around the underlying issue by setting the
> connector orientation to 'none' on disconnect events to avoid having the
> PHY driver crash the machine in one orientation.
> 
> Enable UCSI support also on sc8280xp now that the DisplayPort disconnect
> crashes are gone.
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

