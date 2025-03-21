Return-Path: <linux-kernel+bounces-571505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E7A6BE16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2209317AF73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EE18DF6D;
	Fri, 21 Mar 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9EONBFM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0A38F80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570155; cv=none; b=u98tui6U251+gKJNalojsMuHDgxsiugK+nLOO2I6VVlO0EJB7QwHiTABDsC3xdrSWdvSprsdwyxktW5sBZ9+9ZBOtGNNctbwQH+P6omt57N4iGR1sbOYYVFbICbw6yUcgHfPSN2+Mbi+/3B+7k14/wdi51yHZC4M380/566pXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570155; c=relaxed/simple;
	bh=Q+Yl9HDkujJxRlZdUzqqFtSWgyksRDyvgmKWlzqT/gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTgaIEc2qzq8XUfbKngQVUUeb0ni5s+bPRVvNUUei5PCghTOdD3kbHqYFfdlSb7p+6fq5MN2cTgRacpSjQakV63T6K6RD/c7hLpQUGbe1h6sHe91N72z0DNoDodGaqxD183ylLoL+OMYMXUWgl2lx+/liVPdJwInzRE6ukd2BxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9EONBFM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATAEE022096
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kQ0TcVP8/Pvx/bLfKQWmzhGZHLR9S5vQOK8CP9c6HuA=; b=K9EONBFM6YLBtCLg
	VibycnEZcrZRgDsnLCIo6XjbUs3iLp7BoHb4uUIQpDIw1hInMKueRDmO75+Gae1t
	1oD//Y78Z0GOE3stwxgWvLi5Z9ybcBl4MsDH2O3xbkqNuLkp03/jLXMv+wTrgCX5
	qWrNZ6p46DS4/XQ0M40UiCFbdY1nxnkSLmTd+xuyvQXxjJw+C1/6IU4ZcGS0Y2TX
	rn8qRH7Fq6NgbjkmMvZ9yMUjtJtW1JblCuPZwbJ0kvOw56lJn2O89QsgcHjSptT7
	esCvEhthR5OJ8n/y6VGwmYF8Zgb8LhuMHIYUvy8lSW0ln1MtEs3M3mjgUv+CrLCq
	n6tD5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4wph3qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:15:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242ce15cc3so30826325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570151; x=1743174951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ0TcVP8/Pvx/bLfKQWmzhGZHLR9S5vQOK8CP9c6HuA=;
        b=bnAS8fzFrwYbxD463Ucn8ETO4wSDxM4qGwm/DL9RfMruojSCl41E0EbgW8hy8Qfl/T
         i81hbDZblZHhZ8ahsXK8Lti3hHZ0la4/Lxqtuc4k6UAw1nXY0jhDA7I3Ahpcb/KJRGoV
         nYdr/eRb41LihDAM/4xy4KQKyc5H5m2CB14Trs3X3LT03UWUeXEFDT14ZCH5dLqy3S1n
         J25Jacppg+z9vWDRXebmI4AbzFdMCcGJhetgzHKIWPg3Qz+urys4ciVn9iYIBFRDYbvL
         CsM0+gXD9iFEAjiEbjgOOesxSHYxZLpW4VTCkXHAVYuXe3kR4b5PNiUHXfYX33i+ZJi2
         KjUQ==
X-Gm-Message-State: AOJu0YwTidg4sJqW2O/F0khNpMqB2TYMKUUste8VYWdV9NUDdivFSoH6
	7c6bXgOd7+H/Xl8mY4yyNm2kLha7sNZZfIxPDKkXKMfDOyEogeOHijokHwv+hlg9c6n5a872ICU
	LnT9mMUAj+UBz+uuF5HIOUBjlF8ZQtXjlvmNnOfo/rOcH8OmJrwZHTYQ/kifFIjw=
X-Gm-Gg: ASbGncsv7eiwMBRwxehK/HhIhpPwh4KxisS4hfoVM9Ja6pD9mqjgS6YiV36i2xPM93V
	aXoTtR9naC7L82T5dxovzEkryl1ghb6+NpRBCbBVi39twcYpc7eAPuBwDz7v118zJeB+FDLJcLI
	fGN8yrPR7SCOW6GUZmmEcPijVmZF/izD0daKqHByYdKIvHZFLBSLA32otawBqzAB6dNeYAFLM5O
	jWfqZrpRAGuDTgy3eCW6PzmrjqB9WEoD4cIOootyZdsKIS3NPdAmSnGXa1UZ4kvqVc257aA5EYs
	icQ4MbN6ofSJBZ2+lcjsJwO1qBXap/oEw85RbEVlxIMtjlrLXpggnDsK826I9FsV/w==
X-Received: by 2002:a17:902:e94c:b0:223:66a1:4503 with SMTP id d9443c01a7336-22780da8511mr60045635ad.30.1742570150711;
        Fri, 21 Mar 2025 08:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ3exmAKYG/ayUd4BAH+7pjK9h3LAPlqbGIhGayFPW8YGaUKUf/BB+sXOizwBX45jlhFHzeQ==
X-Received: by 2002:a17:902:e94c:b0:223:66a1:4503 with SMTP id d9443c01a7336-22780da8511mr60045145ad.30.1742570150112;
        Fri, 21 Mar 2025 08:15:50 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f0cb2sm17901445ad.212.2025.03.21.08.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 08:15:49 -0700 (PDT)
Message-ID: <d2d6b84b-7463-483a-a634-396b5099ef56@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:15:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add BO import and export
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
        jacek.lawrynowicz@linux.intel.com, mario.limonciello@amd.com,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, min.ma@amd.com, max.zhen@amd.com,
        sonal.santan@amd.com, king.tam@amd.com
References: <20250306180334.3843850-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250306180334.3843850-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: awnX4-OsqlfBjySWuYQle_5r1GpxDMvK
X-Proofpoint-GUID: awnX4-OsqlfBjySWuYQle_5r1GpxDMvK
X-Authority-Analysis: v=2.4 cv=ZN3XmW7b c=1 sm=1 tr=0 ts=67dd82a8 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=uUkMEdlAwGOmqt_sgdUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=844 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210112

On 3/6/2025 11:03 AM, Lizhi Hou wrote:
> +struct drm_gem_object *
> +amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
> +{
> +	struct dma_buf_attachment *attach;
> +	struct drm_gem_object *gobj;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	attach = dma_buf_attach(dma_buf, dev->dev);
> +	if (IS_ERR(attach))
> +		return ERR_CAST(attach);
> +
> +	get_dma_buf(dma_buf);
> +
> +	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto fail_detach;
> +	}
> +
> +	gobj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
> +	if (IS_ERR(gobj)) {
> +		ret = PTR_ERR(gobj);
> +		goto fail_unmap;
> +	}
> +
> +	gobj->import_attach = attach;
> +	gobj->resv = dma_buf->resv;
> +
> +	return gobj;
> +
> +fail_unmap:
> +	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> +fail_detach:
> +	dma_buf_detach(dma_buf, attach);
> +	dma_buf_put(dma_buf);

You attach() and then get(), so normal "reverse order" cleanup would be 
put(), then detach(). That is not what you do here. Should this be 
reordered, or should you get() then attach() first?



