Return-Path: <linux-kernel+bounces-567697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9510A68920
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0A17AA26F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5B25332F;
	Wed, 19 Mar 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anCMVJdw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBEF2139B6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379033; cv=none; b=AJ2Wyq3xi87zW5qq+4jAUxD6TmMRViZnhY1+ssDMwsZ6HRZ9+MskqJr21fhKozEWvMJuCqDrcaxrL9X50S2DFeTVfwcjTEhg1o3wji4lrR0QG0EMMjRbGADbmJkSjTxDox3Ll462J74KxrV5GzEZQNrevr1Brr0ALBkI0RwDwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379033; c=relaxed/simple;
	bh=fYuae0Em9A2EnlCg3kMbKfLvDNuhclJG1YzHqvQep5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrVtp7w1sBRqVCo4AREeJLDeAJHLhK6VergAXStIeTwCMXDWCb6HNPp5cCk7Dfh6HD8QeFII+ra/r0uFrXPIqaoQJr/cff0n+ND/YnnNdQ7WOjVexpSmR4/Hb6AOutc0grZmOuBSjDnN6jELn2RdRD4MLKxUKrqz48OeFRqvcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anCMVJdw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4luwH017209
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hfoVbFjBm0lH97eGzKF/pQOq
	7LjV9TNtpVNaGzwiCK0=; b=anCMVJdwJTWh3GRa8y6SOdHzjqOYLDMnUvjX8q6l
	fPMIgpnpuHDBa/QuCYvpVZHDNGbz0VW2qwmI5xAhJJnUYkCnA+4GXAmPYVnf1SqE
	U24qLD6o0Yh+it523DCXV4W0LrvKHj0+M2WjCONtHIL/y9qkV7cJsscn2Pig/dmt
	3oQX2JNrm6kufHLz2M5qBYFWZNJCx9wcGutsxOQ76gj3iYFsLsRAtgO8TdigNJ5C
	mxJxnmZUQfdTylrZRRKHeU5jZYRWRTsiu1pOqMNv9esSRJ9sL5Li4Rjo32PGlLMy
	Xz6WslCEz1S7f7v544UR3a30I6RA0o6KXICTF9kpktU+MA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sy37e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e916df0d5dso117425026d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379029; x=1742983829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfoVbFjBm0lH97eGzKF/pQOq7LjV9TNtpVNaGzwiCK0=;
        b=ld07WBkPPZKlt9uH3Jczshg15pK7+p+HnZFVdbpWKDc7oX6xrW4fiGJ2VLHmlwvaQN
         LHJMXg/fOnAOK5Q8YAFFxYueW/RNYTqanW7tyhHXVl2cdZ9AR71parIuq5p7EdU9viII
         ba7uoLyWYeZtKjbS+5jR449eIUkzBcRuvXQ9UzDpJ7GAnvusc6dxqRjXbdK77KqNh+HN
         ipZvZ0JOmQfQbIBqiEV4sLMmJxPcKp4Q0bSuE1UdT77pvKRGmiG/1ZrnMTpZ3h0UlE5I
         yALOgD5xNp+u/CJar6P4rzciRJwOrmcWuFa2ktmZA/0Nk8THm3QpzHxo3RU1kYPE5nro
         RPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXTuNYR877Djad7iLLaP1CmDhUN6L0xgqdPnTKdytorIebdzt1yYdlyG78ZjFWCg6KgZEck4uCWaUmoFpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rwnvpHxJ00NhLM28U4yxAFoMeM6mu4yQeufDjEMjIBuTRXQs
	GaFjYcrzmAJwr2e3DmI680MtnhS+xgN2HiiYUYvgb7TnCdlT54N4H5ziJIugDVuKdo9wW6yHxnn
	i5gNzBX1LqQur5xM3ekAHtd4qdzhDS0YY9U6Kq/6e4qfxCQBscJ1SXcqMCyaTrWs=
X-Gm-Gg: ASbGncsA9BgHgsp0Vmcd5ogz1RRWxJoYE+2aZQNWFWN0KEzlsJp8qGVYaQVPzoG3XPm
	7V8p94pGShtKfCYMfWmbC34MQQGxWp8r8yEScoU+HNyHU0XASAJdu48p5SpEi2SLJ7aLleUEoYT
	4SYy/+znwstwXt6LIn9yKcSTaSTR3MHQSgSDIDn1HqAPGDjUqR0jcpb/Hx+sROILU06S4GJEPyB
	no1kMOElWBRFDDmBE1xD3vtqKjVpvvoMBrNS0sDc9Km5trQEObK7NG+9i0k080jBUiExdkGDkVn
	z1B5kcHzBESXu3Gq/JAOs2oOhg+jHmIPyHjPQrtZbCVIIp4kRDSQVW8IzDTqBcotWbBUgZtNhh5
	IuOA=
X-Received: by 2002:a05:6214:21c1:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6eb2948029amr31141746d6.45.1742379029558;
        Wed, 19 Mar 2025 03:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6nPWr4lL40shrvGhvld1ioXV9TDj2ynQPlNrEi4elNXyPBWBEeHgVfboyb90akUr84MNm7g==
X-Received: by 2002:a05:6214:21c1:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6eb2948029amr31141176d6.45.1742379028830;
        Wed, 19 Mar 2025 03:10:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a82d7sm1967182e87.18.2025.03.19.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:10:26 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:10:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stone Zhang <quic_stonez@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_miaoqing@quicinc.com, quic_zhichen@quicinc.com,
        quic_yuzha@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs8300-ride: enable WLAN on
 qcs8300-ride
Message-ID: <pbfj4hpihijj7zr334agmjcencik2v2bayizntfik5rsmvyecf@7jfm5qf3entc>
References: <20250318093350.2682132-1-quic_stonez@quicinc.com>
 <20250318093350.2682132-3-quic_stonez@quicinc.com>
 <64ccc09d-7e1e-4c20-90e9-43b36a9cc46b@oss.qualcomm.com>
 <f01f371e-730b-4845-830c-68eb2acd6809@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01f371e-730b-4845-830c-68eb2acd6809@quicinc.com>
X-Proofpoint-GUID: zPrIrz0oid_9mY9um1-wbNrRdJEJoLsY
X-Proofpoint-ORIG-GUID: zPrIrz0oid_9mY9um1-wbNrRdJEJoLsY
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67da9816 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=qC_FGOx9AAAA:8 a=COk6AnOGAAAA:8 a=ALGLAe0xcYOngpMLPdsA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190070

On Wed, Mar 19, 2025 at 12:21:25PM +0800, Stone Zhang wrote:
> 
> 
> On 3/18/2025 11:54 PM, Konrad Dybcio wrote:
> > On 3/18/25 10:33 AM, Stone Zhang wrote:
> > > Enable WLAN on qcs8300-ride by adding a node for the PMU module
> > > of the WCN6855 and assigning its LDO power outputs to the existing
> > > WiFi module.
> > > 
> > > Signed-off-by: Stone Zhang <quic_stonez@quicinc.com>
> > > ---
> > 
> > This change looks good generally, but please align the various stylistic
> > things, like property order in the nodes you add with x1e80100-crd.dtsi
> > 
> > I also see that board-2.bin doesn't contain the variant string you've
> > suggested ([1] @ commit 646e008ec53a8bb9ae16ebf98a65b29eaefd6da4)
> for qcs8300-ride platform, WLAN uses borad-2.bin from link:

This phrase doesn't make sense. The board uses nothing. Users /
developers build images to be installed on the board.

Please use linux-firmware instead of using staging firmware repositories
from CLO. This matches expectations of other users.

> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/blob/main/QCA6698AQ/hw2.1/board-2.bin?ref_type=heads

Please add a note to the commit message mentioning that the board uses
QCA6698AQ instead of WCN6855 (as Konrad and I have thought).
Corresponding BDF files were added in 20250211 release.

> 
> > 
> > Konrad
> > 
> > [1] https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/blob/main/WCN6855/hw2.0/board-2.bin?ref_type=heads
> 

-- 
With best wishes
Dmitry

