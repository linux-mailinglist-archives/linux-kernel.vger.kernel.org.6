Return-Path: <linux-kernel+bounces-549002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD22A54BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883AD3A65D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147A20D510;
	Thu,  6 Mar 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FS1e4M4e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117720AF7D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267396; cv=none; b=IBwgwtlhN8fHOCrsWlth+/i+Ox0mmWctaSoFVlpvExrwBlQpjgS8BmJ+2+yFQ47TJ6PPL+CFcIQ2KyX8721wBTacJz27VgNp/XxJyzQbHvUfH1mNUHlduilNjMZjtQUIhWyQaZ4gtGJRtnjZQzyItk1fMNEl0MhoigaRGKc9v6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267396; c=relaxed/simple;
	bh=fULtRJnDI196ccxDyjA7d7FxqIAyuix7c/OGxmTYtNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Muv58nc0UispgBPVyXybMRzHlZa+3ekVhNMSP6Id1prmhynGkJFRZF2XAtIgmpdLRipH9dg4E2k3kXuqmW1X5KK0ZxUS20y5/34Vcy/EZL3/bNhcB88o44nJxQB9LCpmdE+gUjp8gK5SZyoPTRrTYEw5TmMguoY+XA9bcGIEryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FS1e4M4e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5267MWEQ017916
	for <linux-kernel@vger.kernel.org>; Thu, 6 Mar 2025 13:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0DZEXLtvckg77OKbPWSinx9ePyO3OTpVuNl/L9SQffo=; b=FS1e4M4eG7fceDlI
	M2ep1aDG6hXEqT93mvFWc/hMR4EkpJRCo8haa8A3OG63B5rUgFPikHGKWLuLWGjT
	3EE+kElQAgVQwLI3NesIqga+K3oPwhhdHvCLDt5ei7TFsksSkNksMTzFr41IVI0m
	T5/6oeGGRL+i5qPYVPjBd4sOVf3xUVvjibYcdMCNTkkMwCvdwKH6Rojk2tNNP0lF
	aw0FafPaWBBNy+A8LW2cn6v3j9neWEcBjikxywcr+7Ydi4K8RCjsae9KHBJvd1Cf
	uLAhSK3CgPVvgz2RmU3Jjj7eetvWV/Yh1xSu4lyz6rTOEpJE+X0oLFNJ1cbMBasF
	4gDYVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45778t92t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:23:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-223a2770b75so12754245ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267393; x=1741872193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DZEXLtvckg77OKbPWSinx9ePyO3OTpVuNl/L9SQffo=;
        b=IOf8L21zJjEmVnBi7ggmG/dm3isToa0SlxZEIu5bj6mMDfJuQSCxRp3NErcEzV592o
         NDELFlOPkGtxUi6Hst7UU1apq24BXFHmiIRq35RVMC6hfn/79WGKKfCTM4T0WMEEVy18
         Mhh7u4ilCOdN4taRygHzuu3nRiL189S1cvAFdFwlxP1L4vz3F3LcW5gEtFyYZcsS1nOT
         +Gg3pPov66qgMevd6Bh99ADINI/VdkgAW0q6vpvWNJl/1C5B5+C5DspDKxpDqgR5ogce
         5VcW+UzyNN+v0jx78eKHkA+EKpXiK6KqVdn7f7Tok0bPGUc8p0H/xGlfRByx1Aipjjp3
         CM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu10ZjJ9iEPQWm6cRsIvjq/D7iWlPO8Qe1OjW3hNGcYz15siNaanH5nWI4ckPVEAniL0S9xZUP8q5uRec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEoS0o8RqHZo+z4Tt/y5nyi1oZiwvaD2MoFPL8gcX9M9Zgs3l
	q+FX47ISYddXUdnioQK04Fbe5qA3TpB1+v9QiWPba+UGOphpVVYHZIalcgD6y9t1dl2Ltdun3fy
	DEcSNKfy53WveyhO6WuduprOy+7vFVnGnMRUmDHivSrBRshBpK3oQH2L9piCxwCA=
X-Gm-Gg: ASbGnctp92Qnfnzfg1HnIzUdrhJhWI+EF6eOGZqKmLSfpXvSWQxRk5Q/isETzVtJMA+
	S0cWtr0OJ0D8nbVgA6XY//OXI3vHcxQak8BdiU5/m6urAKhTDnN4zYer8z5+c/zMsFUvk4mGoYQ
	n+hQaAynqLJDPDmGJvYoxwYFxXqk+oOvuiPRQX97fgEThxzOzCUTxR09bhCsAPS0HpgMOKkmBFE
	5xSHb/h18OOLX8J47xOf2XVpRhrf8k3Nb8d1NnTXezEZ9DLbNZep5UbLlzCxX37mdf9MYV5CblR
	6/84e7eZxZDD5xyuTgwfTwyQ5K8dzRC/h0HpzU5C6YVq7KzhjA==
X-Received: by 2002:a17:902:fc4b:b0:224:3c6:7865 with SMTP id d9443c01a7336-22403c67a23mr67829935ad.3.1741267392852;
        Thu, 06 Mar 2025 05:23:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbYidSvuynVuK36jDbOsSSNftXONqK2eAyUE5lvUJs2SLMWYNYB1pVzMJ9GgmFNxu1gv7dAg==
X-Received: by 2002:a17:902:fc4b:b0:224:3c6:7865 with SMTP id d9443c01a7336-22403c67a23mr67829575ad.3.1741267392487;
        Thu, 06 Mar 2025 05:23:12 -0800 (PST)
Received: from [192.168.100.7] ([175.101.107.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5f8sm11798665ad.52.2025.03.06.05.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 05:23:12 -0800 (PST)
Message-ID: <163cab94-3271-44ed-a211-300087f4bd83@oss.qualcomm.com>
Date: Thu, 6 Mar 2025 18:53:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/3] Add support for USB controllers on QCS615
To: Vinod Koul <vkoul@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20241224084621.4139021-1-krishna.kurapati@oss.qualcomm.com>
 <173505391861.950293.11120368190852109172.b4-ty@kernel.org>
 <anfqf3jvh7timbvbfqfidylb4iro47cdinbb2y64fdalbiszum@2s3n7axnxixb>
 <Z2sJK9g7hiHnPwYA@vaman>
 <i7gptvn2fitpqypycjhsyjnp63s2w5omx4jtpubylfc3hx3m5l@jbuin5uvxuoc>
 <Z2sOl9ltv0ug4d82@vaman>
 <318620fc-e174-4ef3-808a-69fe1d4e1df5@oss.qualcomm.com>
 <f607aa9b-018c-4df6-9921-725693353f65@oss.qualcomm.com>
 <CAA8EJpr48k_tHKk-uVpAH7TMcp0-V97x6ztdFrbv0Go0a6kD2g@mail.gmail.com>
 <Z683g5yuSu1Pi0pM@vaman>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <Z683g5yuSu1Pi0pM@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: if5OSuOgs87VFIbeQtsgyJDzqx3MsJD7
X-Authority-Analysis: v=2.4 cv=U5poDfru c=1 sm=1 tr=0 ts=67c9a1c1 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=x49Km1ku1+q3EoAjmEejnQ==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=W_DWO0qsI84jIeYb1FMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: if5OSuOgs87VFIbeQtsgyJDzqx3MsJD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=779 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060102



On 2/14/2025 6:00 PM, Vinod Koul wrote:
> On 23-01-25, 09:23, Dmitry Baryshkov wrote:
>> On Thu, 23 Jan 2025 at 09:00, Krishna Kurapati
>> <krishna.kurapati@oss.qualcomm.com> wrote:
> 
>>>> As mentioned in the cover letter, the bindings of phy have been merged
>>>> from v1.
>>>
>>> Hi Vinod,
>>>
>>>    Can you help in taking in the patch-3. As mentioned in previous mail,
>>> the bindings are merged and present in linux-next.
> 
> Can you pls post it after rebasing
> 

Hi Vinod,

  I see the patch-3 is applying cleanly on top of latest linux next. Do 
you suggest sending a rebase or v3 is fine ?

Regards,
Krishna,

