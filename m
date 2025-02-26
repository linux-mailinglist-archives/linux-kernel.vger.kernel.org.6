Return-Path: <linux-kernel+bounces-534538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C338A4683F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2651885828
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349E225405;
	Wed, 26 Feb 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2MOR45W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DD21CC6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591651; cv=none; b=CBjgetmOSJIHjveRqzh21utyLlk2hLzGWaFNojitFBAKAdv1KKB4ddq4kZyjFMQxb+cQbeWbDYThk2gAnuaiGGq6xktcHKS7nLuOnv3ZEdGOopaPeFuN7AyxIWE3Y50QnJlozCUnUYxcQJeGM3lb6IAj3r81Rh75cIIo5qxusWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591651; c=relaxed/simple;
	bh=zxoFCEm/i4Fsrp5kMYsUFGNq4xymwxtSd66LlDonmFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE4gmAibiZZ8iGQPuNPLCGpuzcc1cET6TIzFmuSkHHGkLiucFMD2rcXm8PF2b9p9KDqiMizQ2P4S3rp5l9YFi0x8XPul3d2uF0tdptLgoDhe5rzyccwO0ZIn+rXDzF7MrF0hVqVDRWjGSHtYK4rW3FYwKI5hEmB5rFE9gaZNHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2MOR45W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAI9GO015559
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dx9NSFPUTbfMI71GbqxOdXWvocLSr95GYi65otaMCUM=; b=c2MOR45Wq+zUfJXB
	YFD2r5HLErySgksMaZ2bq4+++03Vpo8/PLPmzWEnPHttQjfT3sCdXaQKdp0+Dxc+
	Si6jRpK42MtSZFAgdHYTYODQPvrelvynFaoTk2JbJj1pPGDabxiYYMhc/k1ZNsxF
	TDwLq1nykwTGZUzSZzQKmMLWiYXABRBIXeIVIGxGc4faOnwvm+8wXX2glwBSYXIZ
	1xeTxU8WwQw8wQkr7zdr8Hq8pAKTmjMpUedRukD0/Rj0WDlO8ZuTvVVtSGfnpuTh
	UGqrMXa44biPffYeY1RxtuUH1MBLRUgrwzZ6UVlkC4CqBKoZxWXZ1VR8ErFaBgTU
	D9QfFA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnjtrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:40:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e65bc4f2d8so156096d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591648; x=1741196448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx9NSFPUTbfMI71GbqxOdXWvocLSr95GYi65otaMCUM=;
        b=XLSGHfEpMhNpX1z5ubN7PDHzwcpWF3wdeyk9T6YU9zNW2lc/wR7nM3cRT9ZotRgDKg
         CdaFEhk7A2RDZBu3tIfnb4XVIoDaoPPtjOM/RSmVdU775Jcm3id/XFjZaho79++rUt5a
         kl3AdkoaW1M5n7IuYt5Jyh0CRHYwq8vZpJpJWeUxHd/jNYa+3DVS0p3BTNi4O/zSnZM9
         skqFHhom/Vm0LZAaUtQdT+XLI6kgyKbEGgNiV6en6fQu4Rh4tgG/60/RrIN0s23Saw+d
         JdHiywoItloe32sbBtye8Ibdqmz+z41tWlqtNBg1xEHxenkBAGnZpTrwPyvS6cJrwWP8
         K/9g==
X-Forwarded-Encrypted: i=1; AJvYcCW6Z9/Ed3u8N9AzX3qmUO69oqx8hfd0mSrDvsKnZcRoMW/WNm7+2PjU39cdSdlBpirOKjreloPfF4qizbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT5Zmg1mC7CzKoDBLzMCZBlZfzisxczvzvtQc+XItoLlGunT6
	hkQDvcr0NTsqaC1yY3DS+lNKHCkUsUmS2zXlMKsGLJ3i58F0D4tazASOin5Cob6KFFp9SSHSbz9
	kqjsTuXZoWYazSGWsR2HipGq5y846AEguxMbdVyoJ/aw8ikJUwBkLJUwAeOa4TZ8=
X-Gm-Gg: ASbGnctfszCRkLBABzUvWBZliNEYnUgNUKtRZ5vN5PXvvOabWcVQAnXtG9sokxPdcS7
	fC0akPZS0YE8gBcwpOGu7UYnDFFLhZs2Qxmq8lBfavR0u3a7WB9l734GSww6lrzfV2yaacNa8ET
	n5b8uBImwHOYzjzsAkHiP5l1xW8GZJ5Cqc0GmmT9YyjcjF711+hQZnwNYXs8uzyG7zIa4904TZS
	qPo2mztiTaNCgBKmB6a60rrBXPyme7RNUsF3r7NPU96fajX8mjt3Bh5ZjhTpmIGhcHax3I0UEgg
	XUrie18ThSBv8BBoyNqslLhZ2ZNXT1ABiOU7Irty0R/nRhiYxRPmy4DgcVIUgMWwtuMEqg==
X-Received: by 2002:a0c:eb51:0:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6e88f313983mr9688146d6.8.1740591647871;
        Wed, 26 Feb 2025 09:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLKJfnGGe63OoYuvkmyhbg6ykFKbgXEtFviZrtLEdWx7MZaKA72KFBrv7wh3/K01a8jQiRg==
X-Received: by 2002:a0c:eb51:0:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6e88f313983mr9687976d6.8.1740591647542;
        Wed, 26 Feb 2025 09:40:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c7efsm366863966b.149.2025.02.26.09.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:40:47 -0800 (PST)
Message-ID: <696aed52-7519-4351-a3f6-7b86778b18c3@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502
 redriver
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
 <20250226-fp5-pmic-glink-dp-v1-1-e6661d38652c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-fp5-pmic-glink-dp-v1-1-e6661d38652c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gTR-ihkKFJ9f0nP1OPJPfCpE2I2XyMr2
X-Proofpoint-ORIG-GUID: gTR-ihkKFJ9f0nP1OPJPfCpE2I2XyMr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=882 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260139

On 26.02.2025 3:10 PM, Luca Weiss wrote:
> Add a node for the "Type-C USB 3.1 Gen 1 and DisplayPort v1.2 combo
> redriver" found on this device.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

