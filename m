Return-Path: <linux-kernel+bounces-395029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE99BB756
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F21D1C22FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5B1F95E;
	Mon,  4 Nov 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOXV+QK/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D71C695
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729824; cv=none; b=Vx0lCkxwK9TO1EpTSRze3rKMGssvlHbC+HCoRYTPbR95t6qnCRWq1hCJo9y7jNi2HLPmafn0xkEWa62EOk20wpV3c+DGU5AuVln88z+zSHm8w4dX8w9zNSNScAoW7O513WhUzT1NHG8Ywnyr+akEmJwtu3MYzKK85RKRzTfF2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729824; c=relaxed/simple;
	bh=Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXhBebxbLeiZmGGFloEfmdvits1zVIcEDwQkfbG+76Yl6atAX6ENWixpBY04sy1DckWGj3Vs7wTcqwVNBYDULGp83VI/uWnB3+aLriRkg3veBHOyNZlKZv7I9W769XQxOnLcak9loU8QQXZTX4UIqqGL/LwHmdl9anlRwnSgt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOXV+QK/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjXSo019793
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 14:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=; b=fOXV+QK/hyhMCDXy
	PjqJed/kJ3Z2YbnFXQpjjKWfJ5PXO4X7j77P+pgicDAdzqIOQ35Iq5cS0J/aSNEv
	gyUgDreEe46iHdnQ+TxlgX0oQt9JGf+w6W6s9MWZLheFjUvJi4kRrEmAF0CsUhQW
	UtEmYGQaxJ+MeQx2to+7+bxmUo8gWUO7Wfi647rYrLFEPjULi2nZ3BcoZX+lg4Zb
	I/Xz+QK6n+GF0QxddXppoJXIcqcySMcJyaJfhznUuA29Y4bISc8igzdsAyreE84H
	DaS4LJtNTKpOt0jmg/zjEEH19zXgQ4/khs6A9Gih3ZhoAy8FndNtdK+5sB1f89D7
	M7E3kQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11vfpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:17:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4609b352aa9so7496961cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729821; x=1731334621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=;
        b=Hss7gadT5UR2EqgHaJb2rydAVKrXaMIvYG/zf48M2heTSRg+VXm66SJoaBy9uf1j7+
         pFo7ZztPWr8CzM3bb+AdSvjG6A5hQtsEQUtfe6mOlmr+PUHkyXefqcys4eJSN0h7olrD
         7AmUxjGJoDY8fC+f0NviTYeTZCFiYiwcvWFNvr6zg7+TH2gNaaFBrb23mIALwsINPZcp
         r9P/IsAOY+lrmgRIDT0CuZNXI/KYIlNjymdU9LsfooSmqIeD0bRIuBCHDGxh6/aB3TVB
         RjSJCGkdyK6tqkW0IGnEfzGZUOWzhVT4CiPGMj7QJCtg9N1LqiHoHpl6tguVes90n2OT
         04bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcaASHnP+N2vlK+Uf+B5DDzCyswP9LMmezZY+jeR/giVLy/FmHN2zOrD2UndFM1MJPt8A3SAk3pUvRsWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2spEDaYMrlP8OKCKBp8zJBnHCWsmq+CV6GsD3aWRn7YWNOrA4
	LlJXcwR9X3uxPQ1RaV1FDzI2xOo65TEW4Va3+uCDs7ZQwrW5wpVlBu/yUSnq6iyCOeTMIvQ0be0
	+UvUAxJSTqVY+V6J3L+ToJeKuJxc4FBplS/wL6J5Zw8I4LxCOgvLu1ZvqMz4YuRc=
X-Received: by 2002:a05:622a:104:b0:461:5d78:4ab0 with SMTP id d75a77b69052e-4615d784f13mr181254001cf.3.1730729821601;
        Mon, 04 Nov 2024 06:17:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7oonLih/OW/AF9dZ7ubomiq4C6h3xeUDXyivjErSr0Hk8yihCCrZnRm9ZrUOTpV8rhO6nzg==
X-Received: by 2002:a05:622a:104:b0:461:5d78:4ab0 with SMTP id d75a77b69052e-4615d784f13mr181253691cf.3.1730729821072;
        Mon, 04 Nov 2024 06:17:01 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5663fdaesm567059166b.148.2024.11.04.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:17:00 -0800 (PST)
Message-ID: <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 15:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware
 parameter
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W-bRCg1kFEX7Cryn68fyA0R8sijJADZH
X-Proofpoint-ORIG-GUID: W-bRCg1kFEX7Cryn68fyA0R8sijJADZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040124

On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
> memory during QMI memory requests. This memory is part of the
> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
> hardware parameter and provide this memory address to the firmware
> during QMI memory requests.

Sounds like something to put in the device tree, no?

Konrad

