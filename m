Return-Path: <linux-kernel+bounces-575586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86667A7047E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF9A189032C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF20325A2A0;
	Tue, 25 Mar 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbjF+1/1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0B18785D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914927; cv=none; b=OeLOg0SMFVwxA6sf6F74opTeIh+uYqxu1k1i9WLJtz9N9pHVtO+/jvSpSKjegAGL5wvxaDvCUC/47Ik0Qdbh13DaAa/seJ7J1laK/43UfYbn/CIQh1bUB1HOqBzRyElUFWZjOGbBraAckG96f+99wtFSFKe21vcMjH7l9H+Qjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914927; c=relaxed/simple;
	bh=BmAU/M5ltULQKNyysUK+FmVAyg56Vw499pyMf97QL5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiVkik2HcmvplxQFrkWiv+Nw2GE2qNL4MX1mjdWtHO1NWFyxJ5Ol57tpr7FF/xp0qzykxsKJ1yrSUbZygyY+UGZFIAsy0QrprysRun2sHNG7EHBSUAxC2Zb3rZf15/TZZ+btC6skm5FlEcojBqKUZyBWTLplNn2PEGdGWAK29w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbjF+1/1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDAwY3032670
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X0k0ZQD0agrNiXKZUYp0FW9zfWl3toreXjsE9ra4O2g=; b=CbjF+1/1Yq2dywFL
	jTy5EfswbVcrbTsyoOiogEiuXi6vLEZ3ysbQTQFGkcP85VA0O6O4zJ2Bs+E6QSY3
	q/nieWTGT102AExd81FHM2m3c56ZWseJCupiNFocqDh11W4TDlflboFdzTFN9yRX
	lbXNcVeybmOip2WTA3ftTiSHlxvAklDYZ4duF1xc5whNNkcz30PtzUFQm968tg2h
	EOuvNvnrTBd1TvImGyafZH1T/DZkaA5+pFYLj2rTunVa3m6++igiCT27heOmU8U8
	3rZeynf0IQ7hl4Ln1WJ88ZNnn+yUWTUad4yMGTSyC1IBcD3R62azPl2sniOaXqGk
	IUDLZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd31y4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:02:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22406ee0243so73638805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914924; x=1743519724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0k0ZQD0agrNiXKZUYp0FW9zfWl3toreXjsE9ra4O2g=;
        b=PLHo4muflvmriiNOl/DfCQoY1m/g8XP5ab7Jozvi491We3kuzV/VzEAeq+T4ylNWnX
         nMzVOQb7j8rnMAoR/FqIPz10qkMnTtI8jdGhGGgVU0RTV5b4evWxmSYCHRT39VoAfKjx
         kBc/LKG6K9MTOQTEgJmlA+arcMbFS5CJQyiHGNhiTgrU0fw6sCJvlL7M6jhWi7VyGDkD
         mEaDyn2XhVE2js8c4u/8u0DX8S6f0MK51VyD2pTI8COEUT38rqkhTQM6hANLVg9fzh25
         wl2GNHn3rLqqdjZ7idqSFt0+JUZvcSbDBJzYZE/vZTFnhrrhH9aUHZRaZvCa4AAVZLom
         9kEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5CsP0FFXuvjcibUXKDuRcBBA9je8itt456ZTo8Abt07ZGagy4Hn/fxIJ+cO6O0j5mMtFdTEHR5TswvqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcL/YA5QPvVYYJyG0JaiIxZOBiYe7uMen0MbaN0AfH6ttbV1n
	MSuFWHL07fCqf6jiRACVOCGXwJZRO6gM7Vt1YmdXUzF/Kl8pXMxy3VIuo+CGTpBMtn6sDWKfuw7
	XNqpaxN8i5Xq9YfA+fJtidrJ/kQEFd80Xk88s7qktOmNHapvQidDjVjJra8Ee4lk=
X-Gm-Gg: ASbGncuXeW/4VKDivap8UUNcaUnPmCvda81Qu9BqfqLc42nexvoM4EX11ylMNm5gcD9
	aqhhocBzoiu8w3CeVn5eNrh1GnAzuJieq6h2jki7O0cW5tnkSG5Duf/RM7c3xKL8up7O254U6Db
	JGaGbk/2k0S21SkgsMWqXMno7dbRcCTQpqfpO9MmHM+yiIvZv+gr7R54HaGnLQ5UaKfWtv51rFO
	fc4zSNaaemOrslMIAe71clxrzOyIIPn3WRgZknI9AItz8r38qfVVt9roHl4y5CY/u4MebbROTAI
	2S2MLSvo87447cc6gglK2Wl5M6yVeJ7hqf7KK+tX/5eA
X-Received: by 2002:a17:902:d542:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22780e3d70fmr304420205ad.53.1742914923489;
        Tue, 25 Mar 2025 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1mPbYXqKt9EK8jIlWkvsYFnh2mt5OM6+fZ3t2Lqn9JZtCj2QkLKlfrd0drlQM6CvsRA1YVw==
X-Received: by 2002:a17:902:d542:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22780e3d70fmr304419465ad.53.1742914922936;
        Tue, 25 Mar 2025 08:02:02 -0700 (PDT)
Received: from [192.168.1.149] ([110.226.153.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f60b919sm10390715a91.27.2025.03.25.08.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:02:02 -0700 (PDT)
Message-ID: <7029a455-47be-475d-b429-98031d227653@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 20:31:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Add snps,dis_u3_susphy_quirk for some QC targets
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325123019.597976-1-prashanth.k@oss.qualcomm.com>
 <ee0848ea-7a06-4f4e-9115-5e3c0ab8bf95@oss.qualcomm.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <ee0848ea-7a06-4f4e-9115-5e3c0ab8bf95@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: snLuae1VAwJ2sRxr0R1LCdsjzDbtVX7O
X-Proofpoint-ORIG-GUID: snLuae1VAwJ2sRxr0R1LCdsjzDbtVX7O
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e2c56c cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xCN+fvAPfuA1Y6DlmAlLzA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=izccJD69kMcyVaTehSsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=946 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250106



On 25-03-25 08:11 pm, Konrad Dybcio wrote:
> On 3/25/25 1:30 PM, Prashanth K wrote:
>> During device mode initialization on certain QC targets, before the
>> runstop bit is set, sometimes it's observed that the GEVNTADR{LO/HI}
>> register write fails. As a result, GEVTADDR registers are still 0x0.
>> Upon setting runstop bit, DWC3 controller attempts to write the new
>> events to address 0x0, causing an SMMU fault and system crash. More
>> info about the crash at [1].
>>
>> This was initially observed on SM8450 and later reported on few
>> other targets as well. As suggested by Qualcomm HW team, clearing
>> the GUSB3PIPECTL.SUSPHY bit resolves the issue by preventing register
>> write failures. Address this by setting the snps,dis_u3_susphy_quirk
>> to keep the GUSB3PIPECTL.SUSPHY bit cleared. This change was tested
>> on multiple targets (SM8350, SM8450 QCS615 etc.) for over an year
>> and hasn't exhibited any side effects.
>>
>> [1]: https://lore.kernel.org/all/fa94cbc9-e637-ba9b-8ec8-67c6955eca98@quicinc.com/
>>
>> Prashanth K (3):
>>   arm64: dts: qcom: sm8150: Add snps,dis_u3_susphy_quirk
>>   arm64: dts: qcom: sm8350: Add snps,dis_u3_susphy_quirk
>>   arm64: dts: qcom: sm8450: Add snps,dis_u3_susphy_quirk
>>
>> Pratham Pratap (2):
>>   arm64: dts: qcom: qcs615: Add snps,dis_u3_susphy_quirk
>>   arm64: dts: qcom: qdu1000: Add snps,dis_u3_susphy_quirk
> 
> Are there more targets affected, from the list of the ones currently
> supported upstream?
> 
> Konrad

My initial plan was to add it for all the QC platforms, but wasn't
confident enough about it. Because we have seen the issue only on these
targets and hence tested only on these.

Regards,
Prashanth K

