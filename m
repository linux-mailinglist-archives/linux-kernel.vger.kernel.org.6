Return-Path: <linux-kernel+bounces-530015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E7A42DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3B4188C393
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12666242909;
	Mon, 24 Feb 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+cEEI41"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871620AF64
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428763; cv=none; b=iUTkwFg9TRNQnr6PLh3w1cLqHIR1VBM/w9eOf5+GqgQJzVmsvRxo/Uz6WqxlT5gkvPjk1K8z0GoKTkYVJ/nuwARhQ4WpUDk4MMjk+IICX9o+rZ+JsvFDLzLZX/NLGg9PMUe1QWlyJ+PspFkaQ4Y51pqQSZufJBiOkjg0J1A3XJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428763; c=relaxed/simple;
	bh=1j/g1K7Ja5vbzknnuLCVHa/8XApl+L1E/ioFi17G0B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0xoJmo+F+W8y6nE0pIO+sQJ8+bZOGHl7VYCYstHhVEPIJterqS4F51RtmC7zwDuZlRGO1UmVXfkpDjV5QcDXZcv5PvFA+yyzTYfAmnT73UMa/O3p6tITtVhF0wCJXmxyzThwJSJ7rps+k++7Kl1M8IJ/454x3Y+7YRuI7YO1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+cEEI41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOgvQ029304
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65ZKk2GtEBap0WC6JfQnvOCcYk0q6mp1fm75hAwKexE=; b=L+cEEI41C6nWNjyv
	x3fE+tlVbbb1p6Qn/6V/hxl/wNoyArBMgKbJPPbfVEQq+jgfI8bADBOjsP8DPFVj
	6mdOXo1i26JUOCe3akULpU3cnUlQAGO1VV7OMS3xdfZYRC8WacaOp63oqDhvSk0+
	3EFRGZ86ccJfmJ/1cckB6ats39mRFy1Cs4DKSFqrSLAZCp1eU1kGpPg/wvsiVrmd
	QbN1oZ5xIb2apWMxgMpLNKsmAHU2/QquJ2nRpqd1x4GpaZyeYlRsNtifNlFRloL4
	ADeTOYfGHraIn4T5yy5jtWd97LpB4YVizyIFzfylEBDLtq42XxF3PzpdIMJEGImU
	dozm6g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y49eem5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:25:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e65bc4f2d8so7260056d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428758; x=1741033558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65ZKk2GtEBap0WC6JfQnvOCcYk0q6mp1fm75hAwKexE=;
        b=g9gpzZfuifyJdMupu0Scjz6RK6qstxUolmvA07P0CxKg/RWwj7Pmv6urvTGiRkwd9y
         2iLUEiwZq18sU+G9R2f6mbOrvcpcua6lHv0PCHQn3zUVY2txojFEb9vlJIu8MYYJGmvP
         z8ODt8eB+CTS9jcSa9rjkZVreEftcEMQyJu0iOs38d2orUpj3hDcx9+oHuuLKST6rJbj
         6Vb/NICaAcu2MaAV5lQNs+ybulmA8+48BNXoMpbNqGVZl6DhYa03BH7wui79KiDw3aul
         Rti1xz+3mDYGiIdLUMQKJOMpU3oT/uks3EBwE55HqDSXzmwS2U55Ui0WyLAhGPP1bjGk
         lvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWORIeUjzbuPHZW7PjdEH/E79yuzaY5UVOFwLPb8FkcXlZUcweCjqrK2eex76CN2QRIjUgUnnmtwwB1sYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl37p/KAUj0MCOgHpMqSvoYvCRB1UGJPd+pxyTx/+LLWI9vPV+
	Pjlc/uPOq31TOFkZ4PQzxKoZjivQYDfP6ylqI7tF2F/gG9tSNy0e44fioJY4QkKskG6vREBUdjS
	uCOBDwkwgw/+clQab7Bkpwz2LoCrxc9921/r8ePRRXDM35euOyC9Sdlt7J4uyZI4=
X-Gm-Gg: ASbGncveIpFfhG8KRekbwclQUWeJlXxesx/0H3DZk1uO8Wrsy/BpyYDuqujp02xQkYe
	9tnmZI8vSaTuh8aHN1Ne3XDObw6HCa5iJ5/TPShtBv9ayoJmmv7KpCokiQgpF0Z5WSFpTshBIeh
	nVC6mPb8Xi9BEzaeoInEz1pDDPfJhPIvyxGLrIkQLYty1Ll2EAUB8uxfN86SDiXEmCh2wpo2qZm
	1KFDVyQmNGZIRopiyB2q+CQPLWA9qTkpzp27axOcEU/9jmpWZGoaZrydOflm1gRnH8SGq1oKipx
	LUp/fJBuBZjw+w6Xcckysy6l2BxFqvlBz6dST6Lj5MV70UIbkYj9qeF7vdNw7CPe4ZAFOQ==
X-Received: by 2002:ad4:594d:0:b0:6e6:5d69:ec2f with SMTP id 6a1803df08f44-6e6ae9d2e05mr63774606d6.8.1740428758384;
        Mon, 24 Feb 2025 12:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfKUxFcIDY7voAldnprBxDRpcJ8vSl3Q4jTMO+GbQSLIoMZ1VG0lqyLwhpCWUnpAzTaWApvQ==
X-Received: by 2002:ad4:594d:0:b0:6e6:5d69:ec2f with SMTP id 6a1803df08f44-6e6ae9d2e05mr63774336d6.8.1740428757890;
        Mon, 24 Feb 2025 12:25:57 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da1c2dsm17830366b.77.2025.02.24.12.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 12:25:57 -0800 (PST)
Message-ID: <6fe42573-7e98-47d1-8815-c11d44671395@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 21:25:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm632-fairphone-fp3: Enable
 display and GPU
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250222-fp3-display-v1-0-ccd812e16952@lucaweiss.eu>
 <20250222-fp3-display-v1-4-ccd812e16952@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250222-fp3-display-v1-4-ccd812e16952@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B0fplJwNDa0ExkvgOU7JBXqzL7gS_xTX
X-Proofpoint-GUID: B0fplJwNDa0ExkvgOU7JBXqzL7gS_xTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240129

On 22.02.2025 6:58 PM, Luca Weiss wrote:
> Add the description for the display panel found on this phone.
> Unfortunately the LCDB module on PMI632 isn't yet supported upstream so
> we need to use a dummy regulator-fixed in the meantime.
> 
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

