Return-Path: <linux-kernel+bounces-421014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801BD9D85DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3190B34EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE041A724C;
	Mon, 25 Nov 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJI6pESx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802218893C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539066; cv=none; b=fp0TCfnj0HmFhOie/RrWCs8dUPp9swKZHaFnANozf043FEilfN9NIzCW0pAPexT6YwRRsqdqM3W+rwyRTWrzKIe5urF/Hpg56hpxox1lknkkaPd/qCaYbPX4+tNenpSmZMbj3GBeT1agAjGfyREpqxbJOeM7GO6MnHtaiMULuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539066; c=relaxed/simple;
	bh=yGW4kJoMpOcK/Cyp9ao4OTwSkjuAHkUit8e7aZifOyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LesbSuJdT9cIkJ/3vBfRH46kge4AuT+tumgVNI4+QYqKRjy1mifkGu25+fkUR0JtsSrh97MvzvC4E/2bCUUGChgeH3ERJ4yGG6CNp4nJi5AAjD9Jveq6iSzoS71L8P9LLw4DSr/ZaEJ++/ImiSeOz1GqUAbzYpSiPH21qCRg1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJI6pESx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP8glAP014356
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d42/JA9nYZ9/D8VoxRryYdvvcEmT7ewq1ySINHSq6jM=; b=GJI6pESxspMzIqDt
	SQHNhyetDOG6lVTi6B2JQotmRIpWbs23S0ZJ1LpYZXRozdN4bp9Yst93Pkc2VvXd
	QRPHRReaoCR9J2jfo3No8zEF8RYtt6J33LnnisH9voBAmy7ZnyCSfkCkwy6EOQ9W
	QyTb1zBfNse99K7dYBc3IMq46V97751zOcZvlnWIQeAPZjzi9tok0A/LkaLLzP3x
	P4EyH4BWUaHMOS2NKOoTeNx7w8MyJHfkd8WMkTQHyA2llasFF+L9xWLDaxuvMUxl
	dzfFddIqYmFePTrcq6wPiPyToYfowqtI6k3ApPhL4Q0G5/LKhrNb0JuN2+HuNOrP
	wtlDUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434nyg0sa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:51:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668c9aa8c7so2552261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539062; x=1733143862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d42/JA9nYZ9/D8VoxRryYdvvcEmT7ewq1ySINHSq6jM=;
        b=Zw6VUPSCqwz68MaepzOVYlj4Zs6w1mGvx1E8/lyQcAHK3LgSIJ0fTQZB4WAnt2sF6S
         RuDXLQFIIWlNT7ZhLLULelFjnt7tR1vS8NmE1vY1mENvtEJGMpmXxDAWRv2dlz+l8PQU
         AKaE2mBodk9jHo7xVxaFivd44PXP3WKsy0ZmaeVaqJotinQj73lf1lYqJotLFRLDtOTY
         jEUkc5dgDHXfYMmnmv1OsSCtEN1sXHJhxLxX0jxia80cE4oiH2CyPz1kxI+B7ThKaoXb
         jOBDL/BFlAbSfGCBGR9E1grdiwmzXv9RH4Ng4vT/fwnlAjDmPi8MhJo7FbHrrvsuqvaC
         KiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaKDQxRVzddslQi1LK7Y/KkEjGFnot8OE8UW58eqdeWsexuGk+xfNZxoD/D3x+a7oR48Lvwp+jaus2x48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICTgfLKEyMcrr1qKheM95J43UUE7AhXoV0Zt2K8Dd8+pLRNPx
	dDYHhUO5FV2PKnG3xbKuk+QkKkzHXX+0IET9jr7nVi7D6qylBrNqR8f1QqNbc69pI+cg0ADuInO
	FBS8NWw3IWuptH08dpNavIAA5EG5pbwl4SvpQqy6rpwqqjlFo/llhczyXWaTheHs=
X-Gm-Gg: ASbGncuu3vkDrSiDbPYnNQt6giH0m21l9puc4qRS3O5O90pzC1RdHK59K7/1hMZhKam
	H+JR30e+a11z7Fw9n9UH1Ud2gmrl+yRK50+DqlOuGGcxfhcSUk9XEeK0ILXcarglqKEMiWrZFv2
	EemApWLDYs428/NDE3ZkrdxH3fazf+dDL+qEJKLX5SpN6Y1xi2olNLTsPdqbmX8+AsOFEvmhm3/
	XY5lLndshPQI9EgaTPbMkVonbDfvHHGof55l3dxB5V/ZamwoEPat6uI2dnHFrHByNlKXzEtY7Nv
	l3veOgqhfMn2DJ18sV5u6sPoRbveIyk=
X-Received: by 2002:ac8:5809:0:b0:464:9463:7b32 with SMTP id d75a77b69052e-466a168bfbdmr533041cf.7.1732539061716;
        Mon, 25 Nov 2024 04:51:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUbxYuqE9h5uUwxctdSxJ6hLhSn2lJZqVvC2/0rgVQXoeTrLMxiKLvqubgQNzDEejqNaURgg==
X-Received: by 2002:ac8:5809:0:b0:464:9463:7b32 with SMTP id d75a77b69052e-466a168bfbdmr532691cf.7.1732539061280;
        Mon, 25 Nov 2024 04:51:01 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fe55sm456496666b.4.2024.11.25.04.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:51:00 -0800 (PST)
Message-ID: <833280a4-7014-45e9-852e-3384fe9d5cd4@oss.qualcomm.com>
Date: Mon, 25 Nov 2024 13:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhupesh.sharma@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
References: <20241122065101.1918470-1-quic_yuanjiey@quicinc.com>
 <20241122065101.1918470-2-quic_yuanjiey@quicinc.com>
 <f9b01690-8940-4f8b-b142-6c2ec4db3e83@kernel.org>
 <Z0BDYiVaLQXaMsle@cse-cd02-lnx.ap.qualcomm.com>
 <ccbc6324-0dcb-405a-901a-12dc33a8130c@kernel.org>
 <Z0Pe0B9LsjpRHkkS@cse-cd02-lnx.ap.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z0Pe0B9LsjpRHkkS@cse-cd02-lnx.ap.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: thGW-n7LmdbgkJTestczcvi1sQueNRP6
X-Proofpoint-ORIG-GUID: thGW-n7LmdbgkJTestczcvi1sQueNRP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=831 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250110

On 25.11.2024 3:20 AM, Yuanjie Yang wrote:
> On Fri, Nov 22, 2024 at 01:35:28PM +0100, Krzysztof Kozlowski wrote:
>> On 22/11/2024 09:40, Yuanjie Yang wrote:
>>> On Fri, Nov 22, 2024 at 08:04:31AM +0100, Krzysztof Kozlowski wrote:
>>>> On 22/11/2024 07:51, Yuanjie Yang wrote:
>>>>> Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
>>>>>
>>>>> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
>>>>> ---

[...]

>>>>> +			bus-width = <8>;
>>>>> +			qcom,dll-config = <0x000f642c>;
>>>>> +			qcom,ddr-config = <0x80040868>;
>>>>> +			supports-cqe;
>>>>> +			dma-coherent;
>>>>> +			mmc-ddr-1_8v;
>>>>> +			mmc-hs200-1_8v;
>>>>> +			mmc-hs400-1_8v;
>>>>> +			mmc-hs400-enhanced-strobe;
>>>>
>>>> These are properties of memory, not SoC. If the node is disabled, means
>>>> memory is not attached to the SoC, right?
>>>>
>>>>> +			status = "disabled";
>>> Thanks, I think qcom,dll-config and qcom,ddr-config are properties of Soc,
>>> they are memory configurations that need to be written to the ioaddr.
>>> And mmc-ddr-1_8v,mmc-hs200-1_8v,mmc-hs400-1_8v are bus speed config,
>>> they indicate the bus speed at which the host contoller can operate.
>>> If the node is disabled, which means Soc don't support these properties.
>> No, that is not the meaning of node is disabled. When node is disabled,
>> it means board does not have attached memory.
>>
>> Move the memory related properties  to the board.
> 
> Thanks, Ok I understand, I will move the memory related
> properties(qcom,dll-config and qcom,ddr-config) to the
> board dts in next version.

DDR/DLL tuning seem to be done per SoC and not per board.

Konrad

