Return-Path: <linux-kernel+bounces-571571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E4A6BEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00722189DE23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001D2253A5;
	Fri, 21 Mar 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErGCfkJ2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83686321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572954; cv=none; b=f45rOZlADGg+3fTY7jarWCly0LJHnnvvG0kCbHyi+09wBFhtNDMft74y+hguuux0EpSsa+erdltxMLGbGGhgxVSn1ET8iUGGCa9GuNxSNyJMFegeXBeHasN1XNo+ZZiNkjerWWFlnx9G/UlqvloXrB7/N/tsA2V7l84LPbk0M3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572954; c=relaxed/simple;
	bh=ay6GQChADei4tJLPKRE+6TMFEI/gSwtngn7T+xOVYWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvIlxnVpuLAeeycunkSUjm6F9gRDPwYRDH99Os6NzZO9NtpaOu0jq2bzA7gl6ux+kNnm9lOaJ8fIlwEbtVCMqv3dEVVyvQFGgIgQf4/weN4xYf5Ntjgovt59lqW64gqoCNQedlAPn2eCSdtpnOu07VdAtu2V41BmkcM83i8DfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErGCfkJ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATEtk001626
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vCbcORBD7TYTk+XKpRjnplu+uBcKKY/kXvr0Jk5Isao=; b=ErGCfkJ2qMEFeXqk
	UC6l3H8dLAHsfzb1ZcqgKMAcqIXxd1mg90Dt6wUrb4v/+kjl7J9QM8OAiQNlgi16
	heDzJw1s5Cx6pg2e95+DyHxENBc4AzO6LFS/05aOZ20OBC6FF99fGpFePUaymPLo
	z4ldDaUgfYs4+SUwlgGHl3Wr0XoIXdatQHoMs2ml5Akou6I+aoecjcohNE2k0k+j
	MZbzmwwA3DYhsTGYwM9Mcxz3dKdMvbrh0zu4Cl2rsf0xiiIF8dLdMkyJcaLUCQU1
	YyR4ePNXfB5AQXDgQwBGXZSkfigHCz13fWQsOljLdxkl8aHElgjisq83HpLFOP6Z
	1Uza0A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g3sf6g5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:02:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so3261779a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572950; x=1743177750;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCbcORBD7TYTk+XKpRjnplu+uBcKKY/kXvr0Jk5Isao=;
        b=EzG/MarJkCcVRnHlyj0UqH92UW0WWUewAWrLbLAeA1NzovIJA/nucpkebqSGPLPu4J
         apHG+MdxZuxAtOcBuOKtYIv75M/8it7ZXp2OW7l4op9+pyMAjkWdkrDU+TB1Dn1SXpls
         m+mvIkmu6BuLTq6fUCJ9PdE2SMGtB2CaK8jqyWLU3afk2gR6YtTB1XUv/ieA3fhZiS4R
         mREZIlfedsBdfVVrOYu3dCoQuwYVDxWVebc1fAp79HsmA7IhZszMmFKneRPkth9bsvqC
         R+qr7uF3YGp7tnkJ0bXecoNylS/AWn8szvFkAu0gcvL/vZ17vjoV5bFlTn+WH6sq32dk
         xRLw==
X-Forwarded-Encrypted: i=1; AJvYcCUTakR3tVheqKKSIMsVozBzYYbqPpn3jidp+OJoE3pyURiOJ36bpiE3EwJ4rgA8C+8//cuMTSLtGq4fxbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44O8Tz+TU9eArX+PCCC9yLkqF1l/cK/KFqOf7R1mmNRDM5jn8
	n4TTFzGqraeLleYeAoZzq51CmQVPzkwNyOTVVtMhY05ZzGhFn+SrdISgNeRaIUh5pvS5xNJuK84
	DEbP2GuJfkmth+Vuc0O/fNXnRDNkEfw8hqKAtFZT5+Wcr3jZq3G/pdKwTgsFUMhthA3CWFOM=
X-Gm-Gg: ASbGncv0BwdzYDFWMX6pdg/SAoi9uTUIKYQ7AiemRMMu0+SA2N86vjBte/vXHAPsmgX
	LssY08+p5GtGgoZAsOOC+CJlOssntKu+Y36QY5afr6sKyIxjwMurQj9pHhyU23ovHaFLuII8hNw
	E3Bc4McSOEQ/PzUBSLX/6VpMQUJGCFnwd4oAfXJIYy8FUyq3KvAJOth9bA+HpbRt2sRqVNycMml
	u+8Kjg9yBXMVnwQO//I3+YcbH0Rkc1LweW5Nls902xUN4ZhCNtlVhxebyBSkL0U95fekroH2ez/
	Cxb7VS+pJOfDFhkoKCULrqE8DMXk/t6Iic4/uDDUnREUtSPPiBx9QLFkO6YoNiPq28XmU79VrEV
	CiyYbaSyp
X-Received: by 2002:a05:6a20:7347:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-1fe42f53152mr6623754637.19.1742572950025;
        Fri, 21 Mar 2025 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcQ2r97XLcVjprlkXYBQ4t6SFERPXbBeumuUB0GSNO6WM4PH5u+Dkl5/WJ+KpfvQZJ1YN3/g==
X-Received: by 2002:a05:6a20:7347:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-1fe42f53152mr6623691637.19.1742572949501;
        Fri, 21 Mar 2025 09:02:29 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a29177sm1911891a12.62.2025.03.21.09.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:02:29 -0700 (PDT)
Message-ID: <72e9ddb1-c0eb-4eea-aa11-3f24ed0caea2@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:02:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v12 07/13] wifi: ath12k: add support for fixed
 QMI firmware memory
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
 <20250321-ath12k-ahb-v12-7-bb389ed76ae5@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321-ath12k-ahb-v12-7-bb389ed76ae5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6nSpnxAux3_L2c3ch-zujWICUojqLnPp
X-Proofpoint-ORIG-GUID: 6nSpnxAux3_L2c3ch-zujWICUojqLnPp
X-Authority-Analysis: v=2.4 cv=R9IDGcRX c=1 sm=1 tr=0 ts=67dd8d97 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=7wgTMAlwxEMamJX448IA:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210117

On 3/21/2025 3:52 AM, Raj Kumar Bhagat wrote:
> IPQ5332 firmware supports only fixed QMI firmware memory.
> 
> Hence, add support to read reserved fixed memory region from
> device-tree and provide the reserved memory segments for
> firmware to use during QMI firmware memory request.

Be aware that new memory-region helpers are being introduced by Rob:
https://msgid.link/20250317232426.952188-1-robh@kernel.org

/jeff

