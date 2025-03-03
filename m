Return-Path: <linux-kernel+bounces-542792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A7A4CDBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8461C189402C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17522FF4F;
	Mon,  3 Mar 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGJjuC1r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C11F03E1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039002; cv=none; b=TpAW4tv6WGnIuRfIbXMIu4L9HymdjTmwFpoUo4kVC/y1NLZeY9AAGiAIIDQDWUeMUv6+TprOO0BAfboP22IQQk4VsBV2wIokZqblqlXwjHvpjiNbCDJZaYfaTCatN3Lfd7cGmzLty2ieCs5fyGVJeoV6lPnIgyzC5cbuy1Q7BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039002; c=relaxed/simple;
	bh=hQRHnDkkYYJm1kGP411WuGPS6pRSmfEvNG8A2sv/jFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOOIW0cLqRAbqwnRcO9fj7pd/6C4tnXXfcF4Eo9LjhZUo2xC6Uvgr5foA3meqf97apsdsAkKZrKOf1DQJMZsyh+hdn6iJ5rm99y1oKibH8+Z7n8wl44pCH4xsVHXseEPHOXlfzivQ93Z4eZRlBgxk+H/nvf8SSMsyezkmvJAVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gGJjuC1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523B5o38004538
	for <linux-kernel@vger.kernel.org>; Mon, 3 Mar 2025 21:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kdn0EPWjFWi47gSGgVfPoqhV4FTHW45fU21tUvu6lFM=; b=gGJjuC1rR3uk/jKs
	PyqX6LaRjzfVdTM8o2IIHA8+VSQvpd8NxuRZ8q+SvGrQ7pZEkc9wx0OPfJizgP9U
	hIprJcrb6w8Nj2Ys3RqKH6hoNmJ+CWOwsyik6zgpcLSvttHnpysQzm41xkZJIGES
	ewnI2VPLLs5OZrLoXgbKMju6I77fnWApKh2ZdLhy5mLcOC+svC79AA2uICJ4oZuK
	E0879FZOme7PtrDO94DZBgi+KEQpGpfyaMBjA4VLqqQ7kQfbsBHE8Xh7uGOUzzl/
	OLpATw3+Zv+2GmFbFfuGd0F+O/SAB+NN+NsSfVcdWQ+mnKbKk5fgLiy0kApUk4is
	OJQxzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d5wrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:56:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-474eb69d822so3753141cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741038998; x=1741643798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdn0EPWjFWi47gSGgVfPoqhV4FTHW45fU21tUvu6lFM=;
        b=ulTRrMNskTcNQZ/9vmPmWWxvG2N0/UUpmkhhrABhYUzt9JBtTudy7xrSX+9KBoyl+y
         o04CHhTH60B6SsBppKF6Vs++KGjQVbWmNQ/rTcEB8+GQHMXxGqpaC8ZoR1LWkKorLU2z
         qRib7S6fCIyrFt+UAyun/uybL3tsuY/rk0nNMlzHgZTMHQhqiQ8IK4thsrKhQ/1tq+ZQ
         8FYXjUZQajg/PBf/X0DSATHY9GtSRq/UXqNw44B3fuCkQCbT8cwjgBPL5pWtPhG9zyaL
         VUX1WY38iV/N0vBR5xhMf9MCOXMXzunpFlOK/HThgUYCJu1vjl40UQUuqGPdsTz5mppQ
         YXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXoyfjQArRX7VqG7q+kvV/p2FFP5rWMY6Es8Zll2mutvgfA9KcFQo1RiMMT0thzmLjf+Yto5nRmn49EZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjfz/JKxrafwbPq2ziUF28SSg6UaPXe608J/2C7Q+K8RVO7Pb
	lhcW2A21s4wz+wP6TqtnYAOS+xfMP8Z/g4gQmA8akV7YSIM4QYZQYdMVOdULY12/29t65enSdUa
	KLeUu7GsI/VG269jfLF4Ta25Zptn9FnKnHd32S+LCVkzxUanSK6WbX7bKWFzxod0=
X-Gm-Gg: ASbGnctUGfbHq1/veO7bvGKsLcEh+WTYQiSJW7/NfpsGcA6qSi2ZZ2C+AichfXSAigz
	lVLsiof5CtpWOTnCF0VqJBlJgWQFuuNhlrAm+FvLLrgyCSiQa5y7BZSBaVZVm1F5zR+63bQBOsm
	reblbBLzjFFJ68Yh/Q3AEPSlrzO58XX5FLymX+mMLZ7TF8MTfuZnPTl9A9wRl2MNgDbApwep5DP
	hkcIMHHyUN6cANWvM4QQVBIR7iz4zDiQDgIfrUuVhe3D2TowdhqZEN7RyV+d3Wn9T97FbD/KlJd
	UuTknypvbFYTocp86nglwGLav8RfvWOkcJTb2pHjl1hubMPlT3fXQdPDo42OgCOO7QRvwQ==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr72806056d6.7.1741038997598;
        Mon, 03 Mar 2025 13:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrJuoSvkjwi3RX1KRgiUtMf0XgXWhFFVFKUGmACEcoXKDG2ph4RBblLXA+X1oIIsGokl70Sg==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ed4:140c with SMTP id 6a1803df08f44-6e8a0d6de81mr72805786d6.7.1741038997268;
        Mon, 03 Mar 2025 13:56:37 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1d860c279sm172592866b.27.2025.03.03.13.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 13:56:36 -0800 (PST)
Message-ID: <33bf565a-82af-46d3-920a-ed664aaef183@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 22:56:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_tdas@quicinc.com, biju.das.jz@bp.renesas.com, ebiggers@google.com,
        ross.burton@arm.com, elinor.montmasson@savoirfairelinux.com,
        quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250226075449.136544-1-quic_mmanikan@quicinc.com>
 <20250226075449.136544-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226075449.136544-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lY7QQXu5Ly-EqWB_tNC54fARrgVuA46k
X-Proofpoint-GUID: lY7QQXu5Ly-EqWB_tNC54fARrgVuA46k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=662
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030170

On 26.02.2025 8:54 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller (NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


