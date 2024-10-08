Return-Path: <linux-kernel+bounces-355911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE99958B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260C91F27F52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42761215024;
	Tue,  8 Oct 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wtv0usUj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C21E104B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420105; cv=none; b=atr6MlpMMmMwQc+EH/Loq3vFhPY2QWVx02z4Ai+xOx6t590MfzwTd23cZt6K1Y+D/gt6behooNtyGElF7XIcTPe1MJMBJpSlW1wzFyxlAA6pUeqQGkUMYUoqvsnhLqtKkEImxwZQXrHPtkCbwV90MeT46Sc0Ld7U6o0CoBk7YJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420105; c=relaxed/simple;
	bh=T903sHO+EkFLMCyABsc44I2YY74tKguRpzo4nCqXIRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=c4PInIR0rrq6Xru650zLMRFgfaS/0IS5coZcK+9GQ9RIzp7mJt/9ZzlgDlNJonIizJfLpsfN5YHuMlY18x4FLC7EErTG2/b10SAiNaVPq0uWR88jLf9xFeUNMQ9OpAK9RiylxyiDVbI0LswBi3LSGzRHmagOiWo5qdpjLPeDmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wtv0usUj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498F3FS4018162;
	Tue, 8 Oct 2024 20:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bTBlXqBEX5S1Gz7vdC4dkE1aCMpb1UuwuzYdO+JgWM0=; b=Wtv0usUjZDg4FWaX
	SUnOL569HFAtrSmYfMViiXZtiWmWNpcRwB3WZT4y2hwuAsWgDxx4HLJXFwIGngVz
	m3PTUas7ePAgOllBtWYcJa6o2WmVI8Z+7GDlUufD01vM1af3buxLNGvPf0Cp4gaU
	+Ko8m4gKCRAwp91/f9hldvDSOy9ylwfo5cEPE0o+QgWpfVSiG0zHL2f1PC1d8tYx
	WO7WkLCS+QuDAretLTRztw6k00hL9IiHvz14dx0EoqBY0megNsPO58VHRbQB85JP
	9OxzqdI0j5BzDmQxmX+Xlz3VRUL8ZN2s49PaQhxOU6e45vhSx602LAGw442FtNwr
	RO7/Mg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs4gqq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 20:41:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498KfWco028341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 20:41:32 GMT
Received: from [10.110.106.40] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Oct 2024
 13:41:29 -0700
Message-ID: <df41b180-d669-4829-8d71-77c9cc575b7d@quicinc.com>
Date: Tue, 8 Oct 2024 13:41:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v1] arm64: defconfig: enable WCD937x driver as module
From: Trilok Soni <quic_tsoni@quicinc.com>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <krzysztof.kozlowski@linaro.org>
References: <20241007082312.2136358-1-quic_mohs@quicinc.com>
 <9d105bdb-b0d7-44b8-8bab-a5c161759567@quicinc.com>
Content-Language: en-US
In-Reply-To: <9d105bdb-b0d7-44b8-8bab-a5c161759567@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TunuYcJi5RMqx03DdYcyIOBiIqPCIlK4
X-Proofpoint-GUID: TunuYcJi5RMqx03DdYcyIOBiIqPCIlK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=615
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080134

On 10/8/2024 1:40 PM, Trilok Soni wrote:
> On 10/7/2024 1:23 AM, Mohammad Rafi Shaik wrote:
>> Enable the Qualcomm WCD937x codec driver as module as
>> is now used on the QCM6490 platform.
> 
> Rephrase this sentence a bit. "Enable Qualcomm WCD937x
> codec driver as modules since it now used on the QCM6490
				^^ it is
			
> platform" ? or better?
> 

-- 
---Trilok Soni


