Return-Path: <linux-kernel+bounces-566947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ABA67EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D4B19C6DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D3205E00;
	Tue, 18 Mar 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkxBtbch"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AA1DF240
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333594; cv=none; b=YqG6gm4ADTbSia3vVQeQED3Leokt+qp7onyZcy2rgEnLXZ8eVLk+J9Ps1AG3305QQl8KzpBizZRkgl3I1KmfAiZorosYVNhVttG6KSW8SXLfMfNji+MSevlVY2lqFtnazgdYa7RsBuUCOUvBpY98yqhTBp78NVbia8tle4wyDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333594; c=relaxed/simple;
	bh=XxxH7Wl2RNgHRITz5y5KV2ZjNKcScURwrYps/17Kl4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngw6s6BMsQhdY6ZBjAkm+YoR2FKKGzwOJfWULUR1TaYJyXJKND4dC0hOoohv2Q8WzMCTxaC4oUM9NlMt7PFeo4y7TDm3wRWWoazA2J8qR5teNDqyOYQDlWYJwd9wG4vG0zHbIbHZTYFYZvVDmPDzp+UEKPOX+0msdZ8x71RsAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WkxBtbch; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKoJTf019834
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HWM+O/ABS+bwChQR1xXmZHPj
	aip7azCOcMWJO4lqEt8=; b=WkxBtbchZlgJpxW1pOGDk7HaMZUEBujS9UXXMFF4
	w/EBDc8Ix4dwozNE/Aa+6+paFxAvv7nvJH7qH9UN39040YwmNCp/Kl2i/CeakAhZ
	5u+m8eyP7fiyJt7OJGNciHzSNpRTzHpeYOLfO7PoG/uXRsEbiDKY2FiJ2xu+8zUd
	ykxG8hEWxQYkQ7AmjbOJw9oOD5ZtTxDvzKpfskUqCmyLui9L/cEajd/tkXCbwGDc
	GXvKQeUuf26AFfsXGl754HGQW+JYK2gyG9k0SiTWzVbzQ6hDWbdJ2o7Njgk1h9F+
	AgBsl4JzAWIw3Dv1m+kz8MYaosCvzMQYr5V8MuvEh2hxhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbk70m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:33:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c57f80d258so1150480685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333591; x=1742938391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWM+O/ABS+bwChQR1xXmZHPjaip7azCOcMWJO4lqEt8=;
        b=f5hW6lqOgQcNvFe49fi/B+D3TFgVAA9mkQQRadXoFwwItbjpJf7WoX7IC1tOSpWYeR
         B2wgw9zIJPfUeWx6ZxBpsZy8ev3NR2vZX1cXdXYKm8nGG+a5LOQWGhxl2AxCTKg420ZO
         Ke8VH3gxNLC9nPi/EBZbzC1exLvRkAmPUkG+bi4yVvpRKAvfEEcJzeqIvkWOTparYc8a
         MgwuHyCbfH6PmzGgjQJQgmagBtyC9pnab3AjY3jF93C6rIowBcvty4SWEEvm9IqbMnhF
         ZK/DpJsBM2Oky2fX4gMXVd6ZlwrLEg6nbbtH4txsL1hntKlDT6mRMMqI8DZkjRdaI6E5
         omow==
X-Forwarded-Encrypted: i=1; AJvYcCViSAG0nAhbtQQlB2az6Z7tPihn22nf2n2/UVmqe77jQR4BnKG3q8ZWeXBnRm9j28aZVuIH2swa8iAw+3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd83tg2Fh9iYSbYj9ckRJkSrZBwc+lKuyI6ax2C00sHf2GR9QM
	ywKy4jt432C1UzcwScPlzO58OR9IXVb2ZKYuDWvbUiYEM4hSpuEOtwZIzDAp4Z9QB8QCNbstbKy
	OX9Fa8N4J/p8SXf5JnUoop2HG7jXJt006HAvLLHEBIP03jRQSYuuwktzhhR6fFdI=
X-Gm-Gg: ASbGnctx0Hyap2YbyS0ecqVeg2kNx7TtoIllPplQopfZ3p1TOHhw7DgLcfNUEB168wt
	XCNX7vtuLjSmbkFAAC3sleBQaJJOZC6OhDumVQBDQHtun+B38KGtolIWRe7GGpQOBLHkMa6peIC
	TIfwBhC6yN+07DgqZymVsusKPe+YQkLA7zaidNl0yg4fKwBmziLU/1a0O5n/6bPOELz8BVyH2R4
	e20SPuwZlCVKqOMQJXwBxNQfk13kE0lUTIQpLkb7jx3Wcj+fDoLgPDY1qyXEK5nZj7DxwTB/o4q
	kjDLunIPUbdq5MVi8WHioDk1TYdU8qkhJrZMtry4xoL/Qaetqr+BfuDopF2V8rVn3dtELLTjy/I
	QkVU=
X-Received: by 2002:a05:620a:4550:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c5a8396ad0mr33662785a.13.1742333591059;
        Tue, 18 Mar 2025 14:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZBo0QGmn61PGE7V4h9Fp9fhf5n14AdOu0ZUsVrghTVbJLnoF8kgujmhYrXa+WQyRmL2iAQ==
X-Received: by 2002:a05:620a:4550:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c5a8396ad0mr33659285a.13.1742333590782;
        Tue, 18 Mar 2025 14:33:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864f9bsm1791651e87.153.2025.03.18.14.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:33:08 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:33:07 +0200
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
Subject: Re: [PATCH 6/8] arm64: dts: qcom: msm8998-fxtec: Add QUSB2PHY VDD
 supply
Message-ID: <3adym6olojyjwzzg7cxgng755uqg2g3bo7haymkpxvpi35fw5p@pyl2nv3ftz2c>
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-6-cb36882ea9cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topic-more_dt_bindings_fixes-v1-6-cb36882ea9cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67d9e698 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=czvDKQ4P4fPyK2hnz74A:9 a=CjuIK1q_8ugA:10 a=PkAOt9_mmfBkvtOLxIEI:22
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: mhdpEd6GcZCAfDyEvjFlrJ3P9LH_fJZs
X-Proofpoint-GUID: mhdpEd6GcZCAfDyEvjFlrJ3P9LH_fJZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=722
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 07:35:19PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Set the supply as required by bindings, to silence the warning:
> 
> 'vdd-supply' is a required property
> 
> The value is inferred from MTP schematics, but it shouldn't change
> between boards due to specific electrical characteristics.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

