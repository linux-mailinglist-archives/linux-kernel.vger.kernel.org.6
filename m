Return-Path: <linux-kernel+bounces-571602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6EA6BF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6983BB394
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3822B8BD;
	Fri, 21 Mar 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtSoBD0t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B014601C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573803; cv=none; b=enGKdXCcUqzcq4eAXzdYY3sSMFHvf3z+Xuq3FbOQETVYfoCLCsku2Ca1FXM3/V3+KQdaGVIbMIyvA+tTqo+9egjMChF+JAXx8jcVmCSTrGC1tZVGc2s6uRTaxTo7CudkaifH2O2uSj0AmSpJ/UHEkyIvm58xFDpcjeBz4iXc/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573803; c=relaxed/simple;
	bh=sX4muvpyzWlipm3+edEVZE9OiBEpH0DByrdbnIKMYr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxZkkHWrpM+i3G1J4MI5YifyUKxDpdxg7h0SbUUxi4+yO9fv3iyZwE8Tjo8dZVjVsJbuUeJ6YjtowNsaiEDju7cv6t1MNJRxg/bRZYTa1yHgx4Ent3xSPQ9yQQcrkFE/GRubyr6KeHjswYvCJBajY3TprcYpyXEiuF2UCany0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtSoBD0t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATAbx003019
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KC691n78UfcfnBIMAEEZOgix
	8UerazMGS6DJH8rBSes=; b=jtSoBD0ttl3RR0OcVWAiU/nuCCHpxHsJRs8T718P
	mPp0eDBxxTQce9+Dar557Zlf9gKMXJGcgJSLUZZjaCzrI59/MGrbjO+ecn6sR5P4
	/CkzAuySTJIRr7YNmt92bvIlxVqquRB717Kxu5nbZ+5rvED+3XClwt5jMx6jH5rw
	vDT25pWCuY07CXEUk2jmFMo98CLkWqP99IDOjgamiXKg1GUO8176ikjn/rnPwrOh
	6wSDPq5uxAB3qEhypBM9JT0wsNGqq2upSh2fSZVEsrCyUiqpels8zshaow4M/B9D
	d7/iONRXmp4uXex3oCuC3NI9Vvr6lmCqgGrU9Gu59p1Ghg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4p11as7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c579d37eeeso330848785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573800; x=1743178600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC691n78UfcfnBIMAEEZOgix8UerazMGS6DJH8rBSes=;
        b=s6oflSxWpp7vKhyl7nXfG6W9majcMHG2zwKZ3WOHkqycD6W6IxJwl7ZnOnh+peGhwd
         uNpCPKr77SqpcA88omUq8bj0cMuxYTV7tAn7TfdhEIebrgWuPTpXVgyVNrGnOAKF2UlA
         dRiTb2Ptk6ZTdFENMryaoGpMpXMhsd8HsE9jVXavDvUQEQT+mt4rk4/6B2WLg0W7GVBP
         9W/kW+2po62d9mkxkfM7XhU5mEMnS7shLBRkBNhyg81DLuBgaVmqD3dBFiVTv+GaNiVF
         tlxATKghvFY/Y8qhGKkh4T/CIpOO/vlXXyFb6Q11915ezLPcgx6W0+d3MaZKdME0z8Rq
         enTA==
X-Forwarded-Encrypted: i=1; AJvYcCW076ZQ+THv2kTI/sP0pSAlds436++ED10S9dnrgkN0q/61S8W/XsC7OYLtteAM3/hvrOwGWeq7JuSTg6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHJJ93hzl8nYES2ztwLv/z8JOn0mS5v9QuW2iPrW1N1sSA0o2
	saL7SHu8jRnltWk7JsPPBumv+2mcwZ+Ze0ev2aHuToSoy5hufrooPyshRHwUPxuJEul59FmdBCD
	5ckluqFRaLdJ73qbfnFxNcQI6CSIOvuwlSi/kvHBdQeMhEwzYfDRl6zvsaHe5uK8=
X-Gm-Gg: ASbGncvijb+ywno4Cg6ayW35MIPvHDFCqivlBxmnkYl9fkKQmvW3Wwsty9fJTFsVs0K
	+Bv1yfGUvG64uf7PYrY9E8G4B3vcRxXlvkL7zIxvwmVRe+DrCbllAFtci8CBVzUu1yyGmyfhryH
	2/6WSblzRNwgnVirmMKK2DBzMCbMpWrAL1gqb+CoM4xaQ6z1p7wgLSMNOSFdC1HPnWEAj4sS8Xm
	7/dG3XSXdnwSwpizLDwq++z8K8Gzus3wPNu2cjgqu74wFS0Lri8avY0NXhWrJz+srUgP+zRP+4E
	Ya6TMvvlp2vo8JxbnGaAbCfZmRAObPyoDxrDKP1h9PpkZt4SuYPBRmbQvV1mSiaE6wrHOJjPpzQ
	9p7A=
X-Received: by 2002:a05:620a:394a:b0:7c5:4a6c:eb8d with SMTP id af79cd13be357-7c5ba200eb2mr484939385a.58.1742573799924;
        Fri, 21 Mar 2025 09:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCnw0RuPGGAcRXmxyrZFcq6Uvyn0JUfRhjB0xBqWfhqbZS/bLEaIZ6/ICcRwJQBMDqvBgROA==
X-Received: by 2002:a05:620a:394a:b0:7c5:4a6c:eb8d with SMTP id af79cd13be357-7c5ba200eb2mr484933985a.58.1742573799445;
        Fri, 21 Mar 2025 09:16:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647c79dsm212119e87.70.2025.03.21.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:16:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:16:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] remoteproc: sysmon: Update qcom_add_sysmon_subdev()
 comment
Message-ID: <ytbcjcbzwftajmovkun3x44tvmfyljthzcsrml3vbwyvkd7glg@enfp7qfhtzkq>
References: <77a6b65b-5f3f-4a21-a837-7a4a7e09b099@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a6b65b-5f3f-4a21-a837-7a4a7e09b099@stanley.mountain>
X-Proofpoint-GUID: 6Xhr9a-mpYJca1-Ku1Gu61aT7vVLZtuy
X-Proofpoint-ORIG-GUID: 6Xhr9a-mpYJca1-Ku1Gu61aT7vVLZtuy
X-Authority-Analysis: v=2.4 cv=NZjm13D4 c=1 sm=1 tr=0 ts=67dd90e9 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Oz3NjKvTjiMZACM5Y-cA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=717
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210119

On Fri, Mar 21, 2025 at 05:35:44PM +0300, Dan Carpenter wrote:
> The comment says the qcom_add_sysmon_subdev() returns NULL on error but
> it actually returns error pointers.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/remoteproc/qcom_sysmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

