Return-Path: <linux-kernel+bounces-531071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94DA43BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E73E16C25E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D366719259E;
	Tue, 25 Feb 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cpfk4PGt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9E1C8637
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479459; cv=none; b=NyTMghI634ir58X/trVhj9NafYBFk87LDX0Skvd0rTNap4hIfg+D9LC7ETgao1K3pcLJBnv8SnAUcb0Wx+nKYU6IhzECDhyU8JVGv/tZobFtgN+Jd9A2TjAnTo3OHJxo0D/+ovPdUFG9lppITGPshwDOMC+O0HsHj5+b3flFLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479459; c=relaxed/simple;
	bh=twBjVGnJahxmvhFhjvSn5Su3hptRGwOQitAeV2FWUfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdrNk6v8vpENwyntdOqaiyXpca7dFNjrC2pZoaIlaOoIU11k+Y9QB0bp8+6dEYJMwXQrWQe1n7/vOmNUq9lCPakCAKyMYKbpIP/FDK758fBFhX4zj9uctL594min+Xnts/OlIqQ6MO9HA2I/ni/aRAoWSxBrRQhzkbaO6mKlcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cpfk4PGt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8F7ls012658
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WqnuvYu4WPEc+kz1zfJCPmfGzlIVxlgiv6jIgV5NH1A=; b=cpfk4PGtEspcdglF
	vZ6iumE9YdGZOGpA3IenOsl1dcrN9EuKZhFGKmxaS2icOsxkcJ6RWQYz7Om+PONr
	nr1DOVDk8gItqoi1f5XsuwJVGF3fKT7FPFtNEn83dxZ1Ho7tKhF2donc3zCXPqYF
	ARivm/I9uXNim57p/XrHvwwKLuUpVKJIEmeUDEjDZwpJmA9q1JZWHWu7SrDOUWJ5
	2BJeO3k57M6cePjK9qYSlXGjo+PgTerKI5naKtEgHmbcZHURS/61UWylR0bsdTPo
	LsbKujed3a3/G0WG155HqoPtn1820MIncjwTWsbD7F5CFCtMe1o9Gsc3DGEjVZbq
	Za+xmQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65y0h4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:30:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e665343a70so9676176d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479456; x=1741084256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqnuvYu4WPEc+kz1zfJCPmfGzlIVxlgiv6jIgV5NH1A=;
        b=R1rc8ljwjw115Zpnh8yhqepZqJSGziZj3HsTaCy8GdVIk7pO9bSjk8tsKXjEsHtb7O
         5vj3daK44XXvydiRnV2+F5q9MxT5jzR5FkpCg1bosdGPlOk9u6P1UZ0Z4OxZh0to648W
         fdwsZ15QTPZPrMnZ0OUaQ1aRkTcyQ5WEkaR8ktrj/Ul8u4uawzFa4RR0ZL6tE72TBt13
         oJlj3ALQQ5KmYTYt3IOpJmaotZBcyHDL7WPXYgPHJB0dE+zFMaW/Q00Kz9rUO4o7iAR0
         YGlRbrO8xN9QML9pekWuPH1CufNE7SyABGqaZpIseAjUSb1LWwccKK/eDLlHfgRywLsQ
         y29Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxg9mcTIg1PKbFDzHWkkor5RMVBUFviUKLHgVQuW6SikQ8x4+DITnPvtMG23Ph/BhVbYCp4k/nFePPTE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBffMoORaLhBO1aNpYB3ysaKYx46APPK12rPRL6ji9Ab/r/QD
	pmoh7bmgpxYdZHrJFKJoDAMHlcg4vOBUkA5uFfDp5wmIYRDrmO3ULOJpuh2VSPf8vUrSHz1/ps6
	mZpsu2iabAlZ/B5U+GL4cNfcXGaEe/lDLCnRHfOK+0f8H9tMAD5dBz+sQGDHkFu0=
X-Gm-Gg: ASbGnctbWZHbknKAWfRH95YsAbfn8YwGvLIJIvbkXCVnlOduvyuyAIUvo/DsXBtuF0K
	AFr18RtijdsY6BOv+DD/RpMuC1xOhyKIYEZR14rbBx6nSshKrwuprviW/N2YpykYUtT++dha/XP
	ZC29Rj9Fi+WTNfxUO4R//Q9k4KCc/v/WoT9vnIUu/QVz0LkFpw7OWLfYrro492tgWy/p1Rwsdmw
	z+wsaQvXAmxVpG1VpD9PETUiUR3EuHj3uABnS6sox7ZKX8hShMZUZ2620/DqCi6k5dAudjXu6lX
	ioc2+FTUNkZvA3u7twvlsWf5vR0DmujIxQHLFJFH9AfAroK0xBBWzaaTBu7WQE5YVWhiBw==
X-Received: by 2002:a05:6214:518a:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6e6ae7d9245mr81554066d6.2.1740479455616;
        Tue, 25 Feb 2025 02:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmB4rwyEg0+JyqJXur2Jj93wuFcgD3awq8KLQERo2qnyPuDfhN13XtvsewtYpx1f1krix3DQ==
X-Received: by 2002:a05:6214:518a:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6e6ae7d9245mr81553766d6.2.1740479455155;
        Tue, 25 Feb 2025 02:30:55 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5fc8sm118472866b.5.2025.02.25.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:30:54 -0800 (PST)
Message-ID: <94e3efff-44c5-4be2-9600-f05732e38637@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 11:30:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/13] arm: dts: qcom: Switch to undeprecated
 qcom,calibration-variant
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eyoiN37TS0U2f6G_ljPTJh8DatiTPnji
X-Proofpoint-ORIG-GUID: eyoiN37TS0U2f6G_ljPTJh8DatiTPnji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=944 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250073

On 25.02.2025 10:58 AM, Krzysztof Kozlowski wrote:
> Dependency
> ==========
> RFC, because this should be merged release after driver support is
> merged:
> https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t
> 
> Change will affect out of tree users, like other projects, of this DTS.

That's a good cleanup, too bad nobody thought of that before

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

