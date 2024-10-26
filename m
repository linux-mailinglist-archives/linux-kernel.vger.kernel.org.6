Return-Path: <linux-kernel+bounces-383080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C79B1728
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79531F23475
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5911D2F4F;
	Sat, 26 Oct 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JipatmDm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41A1632C1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939320; cv=none; b=a3INCBHiPBbHkIcutWyZZSDerqWI5dNp2Ta8WQ0ulpCR7Vqwjm/usIkqDh5akD98D+OEiK2CEp6Ph1n5HtCGCEdZCJR7dgFpaNwxFubSoJ5DY2CNndWIpWs6tQCZri6M1/kiVwwFAkn6GhdslExc67YXX5sbMb05WkL6OvQV5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939320; c=relaxed/simple;
	bh=M5l4NMXojwK7l/dqHDkFvezML6isie41RFUb/ATFTOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WW13kYa6jpz8cy0yNn4YdCmYU2JbMt0z0OizJCvFm2RwvIU3b0DquQs2+oBCJ5xvqyFDMBbCzQ6x1nxrZKDhiLygmaCXB74I9+ojBhj1efuQyfHoJ7JgbJOZYXAoLwJr90S2B9rAZ5wUb6CrhOTBGtU3bIz8CttFLZjuF77Fx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JipatmDm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5sqZV000369
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	peTcJ+kzvdiPGwKZSLvviB9+Qz0VcDYqBwluQ3DeQzs=; b=JipatmDmf/Lh0T7F
	q5DmDBCbqGxYQP23ueBoK51sacdqTZ0gbUZzA4MwPNf+tNDGgfir0A3mHPkV4W+/
	y8v/B1OaDtg3amh0HMDxK38Wx8yWZSx2L+szepNDnQ5rhNy0fzl1A8a2GV5gbMif
	qnfaqfie6AywpvIGbbyuskmqraHMOn/ONRTCeDW0Oxgp14G2djl94wIS+6xpbOM4
	bh3OlG1tLuFKuHjb8n9cMGF6brXKAa2YjhRgmkwUDA4kpMxvkih94buDqbDrEIFo
	3k5crIEHmrPsQ86wJ9h8k5J4vIVhSP8l53MAc9+0WBAbZmNjYIdq2d0aORNwytKG
	KOfj2w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gs6e0pmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:41:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbf5a3192aso6312646d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729939316; x=1730544116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peTcJ+kzvdiPGwKZSLvviB9+Qz0VcDYqBwluQ3DeQzs=;
        b=pIq1PA98E3dTspdPQhX47NnsT0UW3mL20zkv98zD+EuVhblnkRhTa+ss+3tq1QdDlJ
         816/1ij3Vx8xdo6qna6sn6jZ04Lq0TnopKFYbcOgPniDo5i/SmU59dQVdALsJVONh8Fr
         ZfhIB+r7zSRCxFGiTNxmOn6e/Dvfom77S7arhk29oDkPgQEEu3JqfASukRFrcYESUKNN
         eEZy+S3yNbUVmZxi6r2nN6gkLFl1k/vGQH4nCfjKQnj+sbiVz2v/o8Jx1oJugTpqq/VZ
         kDSiDcr2CZB5Ei5KRXXVZJaN3FE2QK+UKGQR9pkqwAbCa8ZeTRqNe9EKkNVdWWl5AOHa
         legQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1IQqLBFk2QyDJhwYRKCent981hBc+T/oLeMfn1jq7cZG9PPGu3eciSvo9f3aolVCnDBtkXNuaY0E4b3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jvR/VSMkWoI7g0MjDf1cLRHN8eG0yJmTiE54MHlv6J6cka/5
	H6oL3ORf2s0DC33wfyRFLtLFnWmCNzP5cgudpmPBFMhnvr1PgMfznBXziEeyCg6PkljZtiCLwDV
	wvPBWkqFs6THWJFuweWJGxnwrWrD1PVbihFluBmYT0ZqbapzyY8BQcbO0v2QQ7N8=
X-Received: by 2002:a05:6214:e89:b0:6cb:664e:38f4 with SMTP id 6a1803df08f44-6d1856b5687mr16652116d6.1.1729939316517;
        Sat, 26 Oct 2024 03:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEelnAahAg5+A8m351j2I3Br+kJNZ/NEsfva7PrVUCS8SYCERlyIyq5RJXtBWhFj+E0qUn87w==
X-Received: by 2002:a05:6214:e89:b0:6cb:664e:38f4 with SMTP id 6a1803df08f44-6d1856b5687mr16652046d6.1.1729939316201;
        Sat, 26 Oct 2024 03:41:56 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7fdbsm161757266b.39.2024.10.26.03.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:41:55 -0700 (PDT)
Message-ID: <33e14868-e6ee-45ca-b36c-c553e0dcfbef@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 12:41:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/12] arm64: dts: qcom: sdm845-starqltechn: fix usb
 regulator mistake
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241008-starqltechn_integration_upstream-v6-0-5445365d3052@gmail.com>
 <20241008-starqltechn_integration_upstream-v6-3-5445365d3052@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241008-starqltechn_integration_upstream-v6-3-5445365d3052@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MWtIaSa3a8kv1-0kzEDuCIr9CHE-1ZSi
X-Proofpoint-GUID: MWtIaSa3a8kv1-0kzEDuCIr9CHE-1ZSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=613 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260089

On 8.10.2024 6:51 PM, Dzmitry Sankouski wrote:
> Usb regulator was wrongly pointed to vreg_l1a_0p875.
> However, on starqltechn it's powered from vreg_l5a_0p8.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

I really really doubt that the supplies for on-SoC PHYs were altered,
given these regulators are assigned based on their specific characteristics

Konrad

