Return-Path: <linux-kernel+bounces-574179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295EA6E1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B8C3B83AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06E264A87;
	Mon, 24 Mar 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOTqhXZA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEE26463F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838044; cv=none; b=FofrZkzIcwHGdTkvthz2DwCUOUHJJtmHMasee/bCn2HuvEO9rmS5DorEkIofalqCuU9X0YO29LCX5shFxeUARztK+HBZCur3gWfWr48vIm7ZeNF2OMWmKXn4E4SAGjOjwnTeH70QUEbq7IDLhjnBeqXMKFcOxqf+hi2WVcmM9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838044; c=relaxed/simple;
	bh=GExsqTP5bLJ+U3udmB4ZWQUf83n8CResj8PDLQiXC7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaKplFxFHj3ypKDbiuxQGPhGvgGalzhGS8XUiKlIMxFXUzMj58uuLTlTYvN4JV7GVHUGr8KnAn1Kr8fSczXIt3dIaiNnQdahWtSz5vNYqqmf/xjy2bwgWLSB2zXckblevsj1WVmc4f40BYwUQOY0u0iVXAJxQtMJB1OO3Im3wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOTqhXZA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9Pi0W007713
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ky3lpKk/27DWJKFcnCrWLdeANM6vCO/gYaNrc/f6Yi0=; b=bOTqhXZAxIqwVQKF
	ce4vtv+BRFYtzCEs4IPgF1f6qdhIt9bjWkywGBcCxnscfoyA6pjbUdYMgffbSSvh
	0XWyCKlLGYyylHBC7q4tId8HIawbR+i7dJHHls2tCbuFRUmP7CUMXoZqwhNhg/k3
	GluZNYLKFXRbPn8RE2hncHrRf2GKKqrVAQ4sjhwhi5UYgVcx4FS1jsP5VklpDamT
	XxXGNZh2HNLLxhADuhOHQe4f7GwrH/lffYs8LZcMBfduFMVxQ1kaj5KaLjRDRGr/
	TJUD5o+yly5Z5oEsL1Pra/vmE/nTo73lpxI1e5NjWh+n62U8HsoGzcBf0J3dBE5B
	HsA2vg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyjd11j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:40:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso8056396a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838029; x=1743442829;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky3lpKk/27DWJKFcnCrWLdeANM6vCO/gYaNrc/f6Yi0=;
        b=ssykEeoka8Dn847QacmyLRUx3MQelDYZLUuaQQTYL9icUizLsjgsbjfWEGo7xozEkZ
         WRGlXi07cj8usn9K7+ouVHynStgHPAhsR7HvADGPNSrXnW8WxCFA+MucqNDjf4jRp5pS
         XXFWUSBRBNL8ozq7WOylF+1JOQBiCwgLKr6rAfStgeufWSLzwp/LsA2SgiZL2vl1/WQ3
         /eFoRHSMR1V6ZIdwD2ONx53s/aSTFFbYXNDm6bAKqRTcfqcNoKTtdMMGNB+nSqcLszBN
         iqsSwUDHgiZtoXaFC33upn+BbKJhje49BLLYcL8oT2k9gc395XEdZcufkMz8s1Q6NGo3
         iieQ==
X-Forwarded-Encrypted: i=1; AJvYcCX47rPG0cpnf+uZyJztezZMGhgWQG45RoCqQdS7u9TekP1vOGWc0sgSM3oyzSBSIp5vYQlh3gDohvnXxQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi37qqQS0bK2Tkbj02+cdPwzcpTIwO0mhhWg7uzkXU5NtBm5bg
	BRYbK5G5YBUdnZE8BYR2u/hsruwdt/4pnl3tcK9WfpirWn8K2qI+2aBHtoFJSegiA5YIcCPoIUy
	+LgAF9gQ/CCKq03wMpZaxBKBJeqBO/MX2WnDX86V/9J5z+dexfXQUbqmvRVv5uYQ=
X-Gm-Gg: ASbGnct2GYUlF8ntLSXTM2xhd3FmaFMvf/peL2bAbE9UeOUj6ZRg5VvWmN3C73QmrjQ
	4QHPoR4WYp71l1dg8BgwDwGg4de3lH7lyq+kGMBU8repihhJyKWXnL37/zeBcNwkZPMaIWMJu8S
	gQzsbTPJsJMCtYb7bPNtiIp8ylDpo018Nzs+iLA/pUQlAC9dNyhs9plEysc8VZHKtumI3wpmiWy
	WSUOsQXdV/SXKKRN+GZ33IqqPIFmtfVOE6+zqjKa1oh2ipxCrdquXDr3hCgaiyjXvXO7J4TSKqH
	3xbCECRCxEH2XpNYH89h8eFU0D66hQnBf9p9Tm4obFjTGMYii2BU51JWQjjpGPSDfhyvNz4=
X-Received: by 2002:a05:6a20:2585:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-1fe4300f7d1mr22409118637.29.1742838028978;
        Mon, 24 Mar 2025 10:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5oX8dTPG7ZC/grxFyBcsgx+ra9S9lw3KDuIrotZWq/1lAVLboQBF+jfRGO9uzwcJKAsNMeQ==
X-Received: by 2002:a05:6a20:2585:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-1fe4300f7d1mr22409079637.29.1742838028460;
        Mon, 24 Mar 2025 10:40:28 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618efdbsm8559210b3a.178.2025.03.24.10.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 10:40:28 -0700 (PDT)
Message-ID: <13fc00da-3dcc-42bc-b5b7-0bce9739ffc9@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 10:40:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kbuild tree
To: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc: Oliver Glitta <glittao@gmail.com>,
        Alessandro Carminati <acarmina@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
References: <20250324103048.3d8230f9@canb.auug.org.au>
 <9faf14a1-ba47-46bf-9ddb-629782b8b52d@oss.qualcomm.com>
 <5d58bda3-4f6f-435e-962d-a8a5724112f5@app.fastmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5d58bda3-4f6f-435e-962d-a8a5724112f5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67e19919 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=wx1vDGlhu_UX7bQBBhoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: HrTzJmB5G029GNzp0EijxbB-dhY6G-FE
X-Proofpoint-ORIG-GUID: HrTzJmB5G029GNzp0EijxbB-dhY6G-FE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=834 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240127

On 3/24/2025 10:37 AM, Arnd Bergmann wrote:
> On Mon, Mar 24, 2025, at 14:52, Jeff Johnson wrote:
>> On 3/23/2025 4:30 PM, Stephen Rothwell wrote:
>>>
>>> I have temporarily reverted the latter commit until the former are
>>> fixed up.
>>>
>>
>> +Arnd, will you post your changes for these?
> 
> I have sent out the last 10 module description patches
> I had in my tree now.
> 
>       Arnd

Thanks, Arnd!

