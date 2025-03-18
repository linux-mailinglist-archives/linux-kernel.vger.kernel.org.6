Return-Path: <linux-kernel+bounces-566951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D20A67EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D4F420BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCD2063D2;
	Tue, 18 Mar 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1cBdI36"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83C202C5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333976; cv=none; b=hzN674qhnzZJQ8wwRb6wkYqNSJyqZxq66pI73gpwADN4hATcJ+wkzN+Ak5uCuPIk44lv3SPWznIOeZX/52HpMueZY9N320U5C5hj11ER2Ii2is12kkp4arR35Kduxj08TpyU+0gUjY44fYqxpggef01VavwD39hdA6u1qUcKfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333976; c=relaxed/simple;
	bh=oVDhCneLrzXiBz83QU9c/Kh6UQKeVOnCHUu0xq6bos4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjmlzZvIekswVZzXiXm3TasaDBkhbIQgNTS50GQ0WKYIf+2UHaKGVfnmbezh1o8vz0nRjtlAsnDqMj+HQ6vffeYzgud52KT9BOf17eejH6jq9wz0n8zMZ/WqjurBfxO63CH/xyv83LPT2fCWiTjblZzrgnxnH6Ztz93/oVFg2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1cBdI36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJFBlF021042
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=io0+rG08jyQuVDox/j2ODyQ+
	2gpx3sWiw700hJF1YnA=; b=l1cBdI36n2yoaEyDfiVWhAVfSuY53+jpfitVoB+p
	ZRII7PJ6MbVEtpsQtHqfvXedvLmlPsdQhFBUtQCt2uxQVuDogi49WvY2vlmjTA50
	tPkN19qr7Q7gHw0p57ujIEbxrY8D9w0+bXEskhmCUQayJM9gMpUaGjid7mubEN7K
	zVWk6AdVqYcwMR6gjlwafbfH99TzGxGfDZHWanrwO/4408hpgM/Jn+PjuRiZRYKA
	hZpNl+XzuW1KDwUh7YjOAhID6kw0JqLmlml/bTMJxsqPskZb729gtPrckNrTv+nK
	XmJLXnAuA6asOtGxqdN7o0pl9a7xXeIL6l4hLKR54bvbsQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu1jvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:39:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91d8a7165so107621366d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333972; x=1742938772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io0+rG08jyQuVDox/j2ODyQ+2gpx3sWiw700hJF1YnA=;
        b=pUj+Gpxkn+szEL6v1leeWUwb0bjrgMr/RSZPUrX0r3+T1G4mWClYJ8RCFgYeIW84PC
         4CydfQ36v0lmpUDopGrUwg4j1sWdE6uTIDH6tGU+K9uomhbFAyq628zkV1/Ww7iA1QfX
         DCK1yemKxELAkC7k9Fbb30OGzhBPVDgU0AVM+fywekENoQOp7JVOpT4BtHcl5oRrN+6F
         sB8xHoulVfiVM7v4h7PYomjs5I49ifYQ/1T9eYNsF5v53MN9LMm4yOyVjrJiyTCEA/qu
         ybqg6tQu/HOx3Ozp7jmb1xjCAXV4F7ivVSv6FaWEz/hmd8VItj+uF/zGwO+PnD6D8g6w
         dIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6K74lrGeK2mMNcJX4NyPAlPkCikkM6gv9tDQDq5F8VTMPIwqIv36qj50S/eKiG6k9ev3exKrgnt62OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdmIAKjhPZBAMWHF0VXR+0siw+HvFwYYljrDLuaqMBjoD8D2v
	hs+P9pUb3/W2MW4kFiMTyFZAnNbCi9/vkO8hrQjpZG1v5sEfd/elnbDLrY8Z8EjYbUW765QQvwo
	ujc9tneSaTJDfRlBFlrXFhLp3DHASjfV/79YM0jVSCGM6vOPCCQsYa/sl/GE6EMQ=
X-Gm-Gg: ASbGncvtYetDuMfGMNtKI70Ripup2MCqKkEzO6sAfJwvGz6rM9bGZHcMWnEYR8ekmq+
	zTXkH3Eh9bVNpnvQ5/aPW/PhwdSgonkD98Z77zEByt3yLPgLw2uKjJxkPmGRX89uYUMOGAI68hS
	0tyKRhW//8HKSiVX0yi7m3rjC658aEuoA8W/CxOYiAmg0IPl0o8h5+LRDPnmCj8AZD7ZjEhTa7S
	Vc0hrPn0yCuc0igj/AVsijcUAIl88YRKbtgqSL1idhA3agxhFyU/qFhrx+KCKATNtw5ACLsrcFM
	cXYEiQGLq0ppfqlo2RGjy4E8bltPHFmgoSesM4jmgYS81BBd0Fg2NHnQ/7stsiK6VHvVgKtxWKf
	7cqk=
X-Received: by 2002:a05:6214:c44:b0:6e8:ee44:ce9f with SMTP id 6a1803df08f44-6eb293b4a2dmr5529286d6.20.1742333972674;
        Tue, 18 Mar 2025 14:39:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0U2l2RyAju9tgrxofWi6cQ2Kcl1PuoMDDqu8P0QBMhO8hHnpC6loZwdkR82n6lsEl9RvuDw==
X-Received: by 2002:a05:6214:c44:b0:6e8:ee44:ce9f with SMTP id 6a1803df08f44-6eb293b4a2dmr5528986d6.20.1742333972263;
        Tue, 18 Mar 2025 14:39:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1e8bc2sm20796751fa.104.2025.03.18.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:39:30 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:39:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Stone Zhang <quic_stonez@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_miaoqing@quicinc.com, quic_zhichen@quicinc.com,
        quic_yuzha@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs8300-ride: enable WLAN on
 qcs8300-ride
Message-ID: <4srz3ztdena2p2vlzymfmk6oz7q6ocww7y7mdxiyfgdrpu5may@nhlvmj2ofkcs>
References: <20250318093350.2682132-1-quic_stonez@quicinc.com>
 <20250318093350.2682132-3-quic_stonez@quicinc.com>
 <64ccc09d-7e1e-4c20-90e9-43b36a9cc46b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ccc09d-7e1e-4c20-90e9-43b36a9cc46b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d9e815 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=qC_FGOx9AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NXR--wKKspllqp7VDo0A:9 a=CjuIK1q_8ugA:10
 a=dK5gKXOJidcA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wB2t8fhXp3FCsEQZ1zgOEYRQKPC2OQYq
X-Proofpoint-ORIG-GUID: wB2t8fhXp3FCsEQZ1zgOEYRQKPC2OQYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=962
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 04:54:25PM +0100, Konrad Dybcio wrote:
> On 3/18/25 10:33 AM, Stone Zhang wrote:
> > Enable WLAN on qcs8300-ride by adding a node for the PMU module
> > of the WCN6855 and assigning its LDO power outputs to the existing
> > WiFi module.
> > 
> > Signed-off-by: Stone Zhang <quic_stonez@quicinc.com>
> > ---
> 
> This change looks good generally, but please align the various stylistic
> things, like property order in the nodes you add with x1e80100-crd.dtsi
> 
> I also see that board-2.bin doesn't contain the variant string you've
> suggested ([1] @ commit 646e008ec53a8bb9ae16ebf98a65b29eaefd6da4)

Yes. Please at least send it to the ath11k list as documented at [2]

> 
> Konrad
> 
> [1] https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/blob/main/WCN6855/hw2.0/board-2.bin?ref_type=heads

[2] https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html

-- 
With best wishes
Dmitry

