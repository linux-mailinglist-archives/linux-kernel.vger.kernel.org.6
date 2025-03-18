Return-Path: <linux-kernel+bounces-566950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADFA67ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8054D7A2F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3F205E3C;
	Tue, 18 Mar 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opfCFub+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E912046B0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333801; cv=none; b=OxxY95xspd2t+aprDfobnQZnyUf8DD0KZw5FQmVljOaMykhfmYU42CcwWOczxf7HOzxcI51iKJdA9Ms8k4/7X/pFyBv0WJGrYYasidCrZcmM13wzxz7q/STv2wKo3TcBvsDMXWK/F2PgxeWptN6howucdKWwHBTVA+eYXHQMkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333801; c=relaxed/simple;
	bh=tMitTEqQw4Kms3E3oLuanNeRnAwfAUaWFSBpeuDWX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkkIjDc3LiaqK4AY8WZ8ZC3nuYNtBBqkaPeIiRN972wMurO2s5bfjNzJlzDnD6g45/mejBBxmjzjvgWXGxffcmGctxIT2zpalLhSd487A5AIH9+yO7ZmZOPrUGJm0qH0apP9ORUG4BsAcTALMRVk4fTg2lhB866a3gfZ+dD58QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opfCFub+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJFBl5021042
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y2vcgzW1emQX/7iFJLX2wg5r
	EcXOlkERAyCkxjphyso=; b=opfCFub+SeAlKpeinR8f9Uuk3HLK48q1OGZdyYH3
	f3hz6vwZ2UPXbobD+ZcDDtizUHdN9bgRlz22P940riZbtQwOqSkKmZw1PmiLGrqW
	mEHKs/Sv1BjPac4DDHqFmMrt0jFl4sOPRAeNkZW3e128D75MyUt5Mv0YQgdAgQBv
	6bYdO16uLKmlzBJJ4CKWZzZyIUYW0IcPXjzGjyFgilSr+NjVtfC85dnvHv8pHpKb
	cuP8Si2JEZTJ5icOX4hu8gP+aeaPsGZ6du4bQuUGvYxhzxl3/NDfpEBlJxsvmXRV
	98hWkAHngN9gYBIFf6kYAszIsxzZveNRDjXta/rTDV/bdg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu1jpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:36:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3cbb51f03so1093824485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742333797; x=1742938597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2vcgzW1emQX/7iFJLX2wg5rEcXOlkERAyCkxjphyso=;
        b=E7F6hA6uyc4YEpVGnfD27pS1DpnyNFiXuubyV/GYBkUQz/E30QtL+Tmsms+RXpN8U/
         O8XQyxRGnsVYv91egIsg8wO7ZgS6FJlQxMTprE8loGuNvVa8rubkg9KwTX8nucHWA8Vy
         LJqEcSv1OUWFFJkT0ttyZM0GHrtnPcY5FRZkERWJiD8j/eImzXGsf3bxO3UV/tXFKxof
         6v4NZaQFXF5ewyQa8SkPrxQjdSf45AAid88Vx/4hI5FaIKjE2wOPFepyYJJsvaA0Q4vL
         rpqsPhil7xdMlXf5lL1H6zuENjmHu3OTaCLXPZVCqIBC+Q3HSjEvKYco/Eie3mAV5jbc
         foxA==
X-Forwarded-Encrypted: i=1; AJvYcCUYaxwIxgq5Xwm2yIbEs1xkIB03gooyb9qjcMXZQPaohICGFlD+lRtU1UwVTfu3QU5jPNUiLF6+NCnIz7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3J99o6O7pIurAq3n9mAhDIvLUkePX6ogX1UpKG1+3SPCq3gK
	OsThTD2JXhOn6dD6MU+IMwYW70b/w4Qay8HFPAvd0rnuHoYyJ8B2dmzXoCxXIHn93joiMDB1znI
	UQhTPpmVRNlVp5urYcVi4jhECNkavVF5pHXfn026UHPi0sB+r3YJDE/ndL5h+Lmk=
X-Gm-Gg: ASbGncvYpfS8Is0z6QTUaLuVx9SkpN6L5IAI7iOU9iEWOqs5GHS34/I7lmL+e7Og96B
	Qi2sDEJTmVrXlB7Reiy2wJhwiDM4AACCA+dYOu6uW7GXLdoyk+moGYz6AvK7eAo03D5NiVzlrjj
	PbS9hz0jSVbQvQI9cl35ygKD0E6GYMe+6HoYfKOvOc3ZCFnNVxaewojju1Jnuq7dwNp9OduboMj
	CcJo2nRTbK5oDyyz0+VSZI3/MH0aFMpXbR7AJA0l6U17z7Am6poWAvrq8U7UHmZIb6+v5LHwwm9
	uXynM/8WD7nQcpG5WI2UY/CKFtOV6Ub6O8WTPxypNERK+Hptzig2IJT255PCZj029rXJAVVoQCv
	Ki7U=
X-Received: by 2002:a05:620a:2a11:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c5a8396c44mr35133485a.23.1742333797664;
        Tue, 18 Mar 2025 14:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/vmeLV1QqNZOMnRz1Pxtv/XOfA8xE0/NtFtVMXjjnCWpm8PwSrKmdkweulpjAZxtvhFClTw==
X-Received: by 2002:a05:620a:2a11:b0:7c5:42c8:ac82 with SMTP id af79cd13be357-7c5a8396c44mr35131185a.23.1742333797372;
        Tue, 18 Mar 2025 14:36:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e43sm1821851e87.145.2025.03.18.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:36:35 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:36:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georg Gottleuber <ggo@tuxedocomputers.com>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wse@tuxedocomputers.com, cs@tuxedocomputers.com
Subject: Re: [PATCH] arm64: dts: qcom: Add device tree for TUXEDO Elite 14
 Gen1
Message-ID: <l77iickvroov7crzg6s2i7nq3kakqgdtbqki74stavqkiwyjfs@rv2oegbwogxi>
References: <57589859-fec1-4875-9127-d1f99e40a827@tuxedocomputers.com>
 <5e72992c-170c-48b9-8df4-2caf31c4ae44@oss.qualcomm.com>
 <5hvghahezqms6x4pi3acgaujyhiql6mzl2xhzph5phhki2yiyq@oi3xjatj7r64>
 <129bf442-2505-41c8-9254-ad7cacefab89@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129bf442-2505-41c8-9254-ad7cacefab89@tuxedocomputers.com>
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d9e766 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=prfVWYIJzO_NFut4FmcA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: SqnLIGr0azc_Sv-3ajaZaZrKa5gMkU-y
X-Proofpoint-ORIG-GUID: SqnLIGr0azc_Sv-3ajaZaZrKa5gMkU-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180156

On Tue, Mar 18, 2025 at 04:24:27PM +0100, Georg Gottleuber wrote:
> Am 07.03.25 um 07:45 schrieb Dmitry Baryshkov:
> [...]
> >>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> >>> new file mode 100644
> >>> index 000000000000..86bdec4a2dd8
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
> >>
> >>> +&gpu {
> >>> +       status = "okay";
> >>> +
> >>> +       zap-shader {
> >>> +               firmware-name = "qcom/a740_zap.mbn";
> >>
> >> Are the laptop's OEM key/security fuses not blown?
> > 
> > Can this laptop use "qcom/x1e80100/gen70500_zap.mbn" which is already a
> > part of linux-firmware?
> 
> It seems so.
> 
> Because there were no logs about loading zap.mbn, I activated dyndbg
> (dyndbg="file drivers/base/firmware_loader/main.c +fmp"). See attachment
> for dmesg output. But GUI freezes after sddm login.

Does it happen only with this ZAP or does it happen with the ZAP from
WIndows too? Can you run some simple GPU workload, like kmscube from the
console?

> 
> Best regards,
> Georg



-- 
With best wishes
Dmitry

