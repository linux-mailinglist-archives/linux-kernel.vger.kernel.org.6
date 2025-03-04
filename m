Return-Path: <linux-kernel+bounces-543511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05593A4D692
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE937A54EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84B1FBCB3;
	Tue,  4 Mar 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jvUG1PgG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508E1F91F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077366; cv=none; b=JqvvgZtCvDjXED66O5KTrVuDMXh/Z2ZoG59/PSlz78zGE3tKas930Owghbh5F4LnuxC+8ZdBBIWBGNc4iF9pTRmrSNFMQ5uBqBIBySa7QuGuAmx9lBdxhLhapp4/YY7gjOkV/4M1ZfsVXlSA9/Sog8hZEta9qATSficQVx0y3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077366; c=relaxed/simple;
	bh=XgA9qqbw3UkE7vJt7EJN9UvDMWDyIUQzyLjlUvqTt0M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRPLe9P5Tf+6oyoY9Wj3j93LHJv7Nrq8FE8Sydh94fc+Q53cF6NA0to+l3k9OGWoRaYcHwUepKxP9d7GEXivab2zrMp1+S1sphzfprssQPuvjWLllZGJZeIk8ZN5e039lKLl968bndJ8z/YfypQ92Cj+PHa6A8fpLHr32FpKgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jvUG1PgG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NX3PT017193
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 08:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XAMOM7rvhCYgMuIw3HT4H/aO
	fsEkoZQ5Aqu4Fze2AEU=; b=jvUG1PgGOVC5kQ7DsFZlnFb43l5Lntg0lg8RuOxb
	xcqIawn1FrIoBG2AnX09O/3fL80pZ7MzN2EBN15To8lm2KF9O6jjFMDcQUkgd42i
	Qik8A8DLDoHf/jnBB/22laPT7G7F5l7ewrhymH/V2AW/e5UbL36g2yo/aU/kAZsZ
	uF5bKgXUxjfjUHsD21qMr/s6gr/D5xDAlg7aaVsUvbiO398Nn3WVCBC8W6iU+J8l
	gnpMM7NpuJYhfj3Ko+GiYNzQWxk3d9O+gmDP2xztPaQ1fnJvUot74YZXyF4VzDjd
	te7Dq0Mtfn7c1ZOOSx5z+k1jiAdwXAuFrUVroUqgP2o2Pw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6th814-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:36:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8c4f5f477so41765926d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077362; x=1741682162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAMOM7rvhCYgMuIw3HT4H/aOfsEkoZQ5Aqu4Fze2AEU=;
        b=W4tjB9lsBY48SfTlJLyXPRGA26cATKgqXT1VUfIXZUOi8HOjJxGFqK0NYiSxQbQuIs
         8GkUdlWUeQ8Oocqh2jonJOvqMpSCduWA1xcA2//xt1t28VS+FoK9p0yUBBVPieu5phvO
         XHlRiS6Wv0/jjZUgfxVk2apYi8to7XQjkmzY9aYWPe3pW3eCGKKZeb7/VPBiJYi4mdeA
         ES/h2Jb4iTYi6YYOYDch/DqQ4zqshu04Dcpm+SR8a0+85Iwz7QZJJTp6YmDu9xjLcX41
         xQ9EaSgLRBcav+tUtK8XRRyNfaaWsm7V7KZJx+Mqidaq6DVoIQxkWZymiEQc9E1lBVdy
         I2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXc2bDIhuhf4Ur7T3kl74O8koOvphV1SGG3AWn7OcmxtuQiZ6S/sQ0CO+l7YSBSSoB+fnYOiZi/rcElMac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkbkgrxhV6qSQ2CSLyOB6rtNBGVy6AZ9aUSH2xReu+cv1Ef4V
	w5usCUZneG8Kn5rZX2f/MMGoSEx+crOiAZTbB/TIf478MP8kNQ0ZGulB35I8Q5AJYqalWJ31OsT
	IB1Y0/0Z3Jazi9nCWbX64GBy2JCMoFueA2USK05Yu521y/ZjYaAYWbsOxZCbBDqY=
X-Gm-Gg: ASbGnct9MtPgYkZRua2SnYSRPEVyLF0pgfwNqLLkDklSN4/fd93sAnNEqkXCD5pryVd
	FaZpwiRCxL+DlDlQrlhZAfJJkEYhoAfYW1XTr1WpyfMO7C36u+CCdL15JGYQNR6ws2XDogeEim1
	obybK6uzUzDLEDzbqnPzNz9B8LqFKSPCE7yT+lAqgWmMqJGWRxkC79iKMkymqovDiRqWIXmWILp
	JLrH3nXjqnGrTDpD6NtC8Yy7r1lchqvNkBW0RhSHquMHJFKgAMdwTlX1AlOg9Yz8voWUXJQL/L6
	zrsp+NZUq20GGnww1jJOudv0I5W/ey/VMWOVXuvtCFWv9bAn
X-Received: by 2002:ad4:5ba3:0:b0:6e8:9086:261 with SMTP id 6a1803df08f44-6e8a0c87592mr237230196d6.3.1741077362664;
        Tue, 04 Mar 2025 00:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYTjjYAGqBjSa8LYcj6moKGc25A1v1rHHnj0+thRYs3Enml4DGKp4CuJXYuuPTy+m3iTBSkg==
X-Received: by 2002:ad4:5ba3:0:b0:6e8:9086:261 with SMTP id 6a1803df08f44-6e8a0c87592mr237230006d6.3.1741077362372;
        Tue, 04 Mar 2025 00:36:02 -0800 (PST)
Received: from trex (54.red-79-144-194.dynamicip.rima-tde.net. [79.144.194.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm17265067f8f.12.2025.03.04.00.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:36:01 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 4 Mar 2025 09:36:00 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
        todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v14 2/2] arm64: dts: qcom:
 qcs6490-rb3gen2-vision-mezzanine: Add vision mezzanine
Message-ID: <Z8a7cMmxJuHIhgjo@trex>
References: <20250208225143.2868279-1-quic_vikramsa@quicinc.com>
 <20250208225143.2868279-3-quic_vikramsa@quicinc.com>
 <ca8e6569-b466-4f83-83af-38c51891d395@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8e6569-b466-4f83-83af-38c51891d395@kernel.org>
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c6bb73 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=cl0az7d0LwC7qAhl51RXhA==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=-c0S-HA5VnWDXXpzp3AA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: gaaj3dGJYWwA_H4JFYnvGxDcY6rlDrnT
X-Proofpoint-GUID: gaaj3dGJYWwA_H4JFYnvGxDcY6rlDrnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=809
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040072

On 03/03/25 18:13:20, Krzysztof Kozlowski wrote:
> On 08/02/2025 23:51, Vikram Sharma wrote:
> > The Vision Mezzanine for the Qualcomm RB3 Gen 2 ships with an imx577
> > camera sensor. Enable IMX577 on the vision mezzanine.
> > 
> > An example media-ctl pipeline for the imx577 is:
> > 
> > media-ctl --reset
> > media-ctl -V '"imx577 '17-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
> 
> AFAIU, camss does not support SRGGB10, but only SRGGB10P.
> 
> Based on tests reported on IRC I think this might not have been tested
> correctly.

I acquired SRGGB10P (10 bit packed) frames from the camera despite the
pipeline being set to SRGGB10 (16 bit) samples.

so something does not add up.

> 
> Best regards,
> Krzysztof

