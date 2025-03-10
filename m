Return-Path: <linux-kernel+bounces-555273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9AA5AE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA921894DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE1221F11;
	Mon, 10 Mar 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDYofdhW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69222173F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649870; cv=none; b=p5rU6uLaHw6Hda0VvmqvzkK8M+y7OZ6vCFmmx7VAjHBwZuFewFzsObu19WiEryW1Jfxm5ZublwbaFk8eGTcu8M4lWWaZu0gvtpcYfo4H0GF3RGdPY6ie4eV6e9/Ieyl0ZoeBHWn+xoPo2BxsRtyWaWF9Xwz3LXKdYf+Doaet5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649870; c=relaxed/simple;
	bh=+J/gIo4jHxazEkQlxKxKqAY1qd9upi8y4fJP2X2CZWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZurWp9SRLBjW43YwyReerQ/UX+/FBEBBXGOUlbO8S6fU/HiZbxplkyCl95pZ9DC1Lc8dGiPKYScoA4v0GalTObqaVWTjkz+2kphCOBh0YwSY3dykiz8nwmYg/HAfgnvTIvLlhCjP1wVBFxK07vK8Nuuf1wtZcUUYIrb7d+4wx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDYofdhW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJxPHw001680
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8TFjGbBf7rY2t4VlMRWb4Z8bam2nqJEippM+OCcgS8=; b=dDYofdhWdXPuo8Gk
	X8eUaoBELPf5r2lDlX2BT9sMdcIDGSW5uKgszDKROEAaiRN32B5gNT5r4XoSNwu0
	CiAXxrBVUk+OwA+0x0mvqy22He+HP+pilje1+focREWPQCX7HoSvVhal/Cq0SGno
	BkPzQKpnwUFPox+PD9jiuJKqfklESge/hfrewZ499QFGDPMzbcBjNbxtCJpkTzSG
	xau+/sWaYf6NZqx0OWLR+5co1SNQQQs2Lo32gAlrpfs3D0ipl6DW7+A8ZoHMEhLY
	JWBMx0XndFszNzskJuP18uir5cSqTEIwgNvr/onXRlcuwy+inZX13S5PzPA29RLY
	rWu26w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk6e3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:37:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7be6f20f0a4so136967385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649867; x=1742254667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8TFjGbBf7rY2t4VlMRWb4Z8bam2nqJEippM+OCcgS8=;
        b=oU0fx6sMYcoe3kbqPOoHnLHff6TthjqqLWwC9UaXpkv6ja9RkO9rQqO1+AHySr6ls9
         42TSvvEvZQ7WM37Cgw10pflb6y6AJy286S7erN3YJWB251AbsmG8y9SD8P9Dw3KpR1yR
         qJrEJQi0Zrv44EnmW75+S0Nsw+9LQJAV/T3/OyZB9VTEdUTnEJET/e3T6X66B2ZreqzX
         4FMShQCXs1sRh+oE5M25no+rMkjuspXZEY+msCw32bBexde53tnSBvx2mXu+xvu3ABkK
         fLEUmk7mvxatUydV8aJ9FJ/EMZ8B0owOC3YczI0iXvIVh4FhJYyyJCCteHkp6RLvfy4l
         NM2A==
X-Forwarded-Encrypted: i=1; AJvYcCX79htWjez0Q5EyFfMtJSqtqv7JlW8xT6pclVLS3GRx6BAERChj5kYvIFXiEMLbg5EOVStSLWUqsgX7OyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwi94brbrT1bud5dmUTvJlkRvpervPARRgRzo/rCKerx5T8cwE
	uOv2yOoy4oRa1zo1Yg0NyJ+TpLVdg9XEDJYP5hTDQsiNs4hxwLf3NceHdS3R2H71wx++eDF9GH5
	erP2Yb4wP1P6i0/iQWCpL9AL9UztE4gW338QEECHmk8aDgSL6+BaxE9KnsasvIzE=
X-Gm-Gg: ASbGncv7SCqecnu31Bflezoawcs0teIEneLtLHRS0szvo6tWMZ+vdfxxwknPzG5D0vy
	j5vJoS+oNbXzdLh13q/FmCNf+MDCbJsEE9N02Jlo4HCgVs/90Kd4/DWg3k+xyDN8r0cd5zsIwne
	WK85BnyslhqgnNtgjOqYjfLuQuhNaewIeVvWEK0enDa0aN9b8+BnqMDIybip70OXB//xqt6nTLT
	kUXEIv5yngzYYSp4Yd+4RnbxziE8ZQYGbgKEiz4FOHCbWgfUe1r7mx+kdTLN4QGdL74JZWAo1rM
	Y212vKExhGRlGsmSrVsfgxFECP2acY0Tc5fZZR+eQppsFO9xiNx+1n25Q/yKv07axVvuAQ==
X-Received: by 2002:a05:620a:2603:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c53e1d8eacmr535686885a.11.1741649867234;
        Mon, 10 Mar 2025 16:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Mp5wCFYiwFx0JJwA59DroSlD0bMK7BsJYztTlXkZgV5YDKGVGzmedYfg/iXl/C3zcTEbzg==
X-Received: by 2002:a05:620a:2603:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c53e1d8eacmr535685185a.11.1741649866890;
        Mon, 10 Mar 2025 16:37:46 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a194sm7397206a12.59.2025.03.10.16.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:37:45 -0700 (PDT)
Message-ID: <455b685e-0ccc-4c57-a60f-39ff9cd280ca@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 00:37:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-ginkgo
To: Gabriel Gonzales <semfault@disroot.org>, konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        gpiccoli@igalia.com, kees@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, tony.luck@intel.com
References: <0bcdb8f9-9a3b-4d6b-bf7e-55a22ffc5df9@oss.qualcomm.com>
 <69f26012-e71b-438f-ac58-e0a3faaf4d43@disroot.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <69f26012-e71b-438f-ac58-e0a3faaf4d43@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67cf77cc cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=FfWvQauag8hAH5SirX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: YzW_iqoPgNPud2FU21PskDBA3Y2dBOgB
X-Proofpoint-ORIG-GUID: YzW_iqoPgNPud2FU21PskDBA3Y2dBOgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=973 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100179

On 3/11/25 12:28 AM, Gabriel Gonzales wrote:
> On 3/8/25 23:11, Konrad Dybcio wrote:
> 
>> > +&hsusb_phy1 {
>> > +    vdd-supply = <&vreg_l7a>;
>> > +    vdda-pll-supply = <&vreg_l10a>;
>> > +    vdda-phy-dpdm-supply = <&vreg_l15a>;
>>> +    status = "okay";
>> Please add a before 'status', file-wide
> 
> 'a-status'?

A newline.. the brain didn't synchronize with the hands

> 
> [...]
> 
>> > +&tlmm {
>> > +    gpio-reserved-ranges = <22 2>, <28 6>;
> 
>> Would you happen to know what's on the other end of these?
> 
> Unfortunately, no.

Usually it's some secure i2c connection and pins for the SPI host
that the fingerprint reader sits on

Konrad

