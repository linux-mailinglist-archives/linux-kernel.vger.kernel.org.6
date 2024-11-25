Return-Path: <linux-kernel+bounces-421011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881909D8598
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2963016921F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7C1A0B07;
	Mon, 25 Nov 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQ46rnD0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0A18893C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538837; cv=none; b=PW44lseiMq4q+AOPLoEkfnGhGSonX+u5ajYvF+fTBqTxczECslG89tPcyXxm3FipU06Bc6D3MNQoG0mHB/poe3uOkmwTCijIHACEJFnIZm3vsGZcg32ttXq5m9DrS0/wgHYDTfSjpo+W9aWHYKzs8r4SaFVbhtGs9zRMvvzWlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538837; c=relaxed/simple;
	bh=wDVlE+3a7Q0/blgX4dDF0Ww+r04zZ7/v7CBGXQwyzO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLzJhL32z8TJsLatPqXZ/LHVkFDetD2YJWp4qhBW46YI+oaqoZJzvmM4IxhPAi0siL95SO1eIxO4qQfAvt6ZIuWlZHQbJT63J4XxR7lDWfQ5DRUZwKmbWVWsV9Y0F4F+ZULLV/Ps56kyomBHwc/NCjKdEoo26j/nkyG4f3BTWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQ46rnD0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAd3YX027751
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeeoZnPBXUwuagoh6GBKRIxYphnRKtHZMwhi8JnP0Bo=; b=KQ46rnD0BE1BpglA
	PXbvcmE2LBT9fkSgDXPHQnCNVdVkcuDa9uI4ea+NCjloIHX2gzldWIAbG8aYPo6g
	qoWzOqInIEa3EG482lZCBlj5bCGUvLzY8PM8G4bUichgOh5kHgPUzSeHZ5QHZTJ3
	02FV4Cg6/WjZOZsOQtLuvFdg8ZBjw7No1ou/iUxXyhLbpxIdbSFqGFi4bP61ko5/
	uLfaeFZpXVLR+YUqkyQqwftQs/SibBdZyPQX0wV6tMzSC1h7r+angXi0TetxuAxs
	RdM3d1qTuAHvd5QKs7JBPfKF6BdFUbHJDhGB3FrvE3RnapGvWyJvi3Qa8ziwXDk2
	/nW2Hg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43387jck03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:47:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46680667b3aso2742711cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538833; x=1733143633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeeoZnPBXUwuagoh6GBKRIxYphnRKtHZMwhi8JnP0Bo=;
        b=ZQUhIwbxS0F7czbz4KA47BTApM9xrNstwvogFyWdZqwRrOprb95/D+GHsJQJWbR1aA
         RB8nXBFDkSwr86nFPf5gr9GwySlu5W4oehG5FUcZCi7BGKu6fN/SE69cbnhk98UvST9A
         4U7n+j/Np8ALlWKLzBT2U/OnFk7N253hQEGRgq6MohR+iylv0Bd/f7kOZUy6eJxf43SG
         kNn96xZoLticuwFnItsUNNB0I5c/MeOsQm0U1pi6Xa/oL+vC15tLOzOleKME8WvpXBTt
         pQAZqO+4K4dlJspEWBs8MUaLa30qwTUZ+rzIJdkGFSots3lJ5TbTaWf38GwK3v51N88X
         zLPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIWhB+cG9sHfNIOXHV1op4XMI6000//3+MMJCsGhrGdOS/0tDFRz6X9uU5IQpLd3s+/oNxcO9hF19K0Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqRPWLWtXjBcQNS0ikeyYdcZnGIaP0pfVUAQb19EeUZTFbQ8G
	49DOssBlwy1jpVaRcn2kfEPTGSZQcbJ6MQNtzgfJD9QLXirLhh1IAMoXf91MuHLBYIkkL6tgt9K
	Vy9sWHPr1QZr6wxz6ULhTW/b4n91VJoko0UQNyXL7PFTKqS1lgASWDRJ/Nc8uuIQ=
X-Gm-Gg: ASbGncvXFcmc0NjRj0adNcp5j2NJURe/TxBF3tqKJzegTWU2VbgiZlFPgAMfiAF2bbQ
	aNI0kFw8YVQiI8xuA6u9cRp27Xd2WCHpdbAuwHxoy3L0Rgkx84Ge+4AqejBnrsnB4at1AXnh5AA
	8O2Y6cYZ9AqV1TawrMcCUCbbm1lJNFuyKBr4BN36YIgegVAFn2VC9rRrKyfoCpKqsMn/14Lix1R
	V4eNpMtT8kUJ54FnMNNpy7EgxvQxBK4hkG6iZsYIwBRUtwFkmjD89HCQPz7AE0m7lZ5sGRoN9PP
	72H40/sZ/lnb1unQVlqcS36tR7lFfxs=
X-Received: by 2002:a05:622a:1a8c:b0:460:8f9e:c48e with SMTP id d75a77b69052e-466a160e606mr367101cf.5.1732538833691;
        Mon, 25 Nov 2024 04:47:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/w1GtAxnHY4s+IA+xiplqvA3f7+lUW2gwSCR0W7ECr8U4ppsyLgiI4IDuAcDWm+Gf2BpnTQ==
X-Received: by 2002:a05:622a:1a8c:b0:460:8f9e:c48e with SMTP id d75a77b69052e-466a160e606mr366941cf.5.1732538833276;
        Mon, 25 Nov 2024 04:47:13 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d401f64sm4069401a12.70.2024.11.25.04.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:47:12 -0800 (PST)
Message-ID: <421d43e0-6a6f-45ca-801c-908c66bff158@oss.qualcomm.com>
Date: Mon, 25 Nov 2024 13:47:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: qcs8300: Add watchdog node
To: Xin Liu <quic_liuxin@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_jiegan@quicinc.com, quic_aiquny@quicinc.com,
        quic_tingweiz@quicinc.com
References: <20241125093503.1162412-1-quic_liuxin@quicinc.com>
 <20241125093503.1162412-3-quic_liuxin@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125093503.1162412-3-quic_liuxin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nbXNgv8etUtDK3PtA-h7I9ZTlT7gcbA4
X-Proofpoint-GUID: nbXNgv8etUtDK3PtA-h7I9ZTlT7gcbA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=853 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411250110

On 25.11.2024 10:35 AM, Xin Liu wrote:
> Add the watchdog node for QCS8300 SoC.
> 
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

