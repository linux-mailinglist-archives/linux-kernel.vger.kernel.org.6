Return-Path: <linux-kernel+bounces-547402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6DA5069D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFD73A6EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662E250C0A;
	Wed,  5 Mar 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UYHqu1Mj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51775199920
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196532; cv=none; b=CgqU4hNCHY8/0SnjON7uDpOPO3QPIhYcM/U5mPFpluZe6MqELTpyL1ZyPhEFRez/VKPmpYI2aMAi+afahSdvhRaxwnVQvLYHME99Go9rm+AWiqKBIQjmNWMcOxIW6HHAgC84AfhmX+YpFrlW2J7Z7duZrpx7RZ1uM3wp/Em1YH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196532; c=relaxed/simple;
	bh=bb5K4ZkE3s/6VshzIh28PtqgzaQjLWaI4r4D0uczvRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGXzcMUs6IC9nsN7OYCelLQMl8feK84t+cAk2y3hgQYJ/XoDiy4EsaKvAeBNKKmmI5C90uwOEoNo71BEw0Viaw+ovpV1er52LrU4vWadkIv2d8pyrYI6UplupZFeH4vtnjWo0o6zAQY26BtuXFPPlgpXJeEuPkhR7NdZiTAdoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UYHqu1Mj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525BDZ3n016297
	for <linux-kernel@vger.kernel.org>; Wed, 5 Mar 2025 17:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cW4c3i4J3mlPr+rYfyKkb0xfrDke8TBiM4daJ0wdc20=; b=UYHqu1MjjB0gsgFJ
	n36Q8i7fXiGHeg67CXM52zLzntcgLr98PnNfNWXlAeiTjr4wmdYdn05FVNstDMsV
	p1YcDfh9k6N98JfSfQUfvYetvl3f7QKuv+4YdMaIf6hS9dOpLyXuDJ6OWEnQB6w8
	gQ0E+pHLCS5uOvhGJ4K4ppRckb9l4icRPcpTdMSXHHE4ocr0Bm81jMMNqfjnDcDZ
	S0EQVf3OuBq9VZl5AB04cpTBN/K3bU+7LZoj7+8fbb7b70FEHO1/NZb1QZJKJHOR
	efW0692mfIDuocz0kQhXqY5CRt15wiSSi6nVNoICrUx11kd2P61bPBmX1nDgt4Mb
	TGrMoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6wp3d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 17:42:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22368a8979cso95844675ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196527; x=1741801327;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW4c3i4J3mlPr+rYfyKkb0xfrDke8TBiM4daJ0wdc20=;
        b=WJR8rlUJZcoV31c81z+iqGxBxqFkTP/Zzs1wbni3GnG/w6VAvvaoPOjuofN1Rl0niX
         eVLjSyWf/uqvwfT7PtjsonAdtNryyE7FxeSKdeQRdmRn/YixXlPN1GFAXMSQ60e0TCgS
         6SZF7xFG57Sae8ID0av6JckRoFBas55jK07yeS9PqkvdBfhTcmHsSZcUvfnFj93YclMo
         4TD0QqdXLB/ETCGqTlWPq+Q6QGo4Hcku0sfVhcl9yQeGXcX/UOZ8FH6wJKMs23+O7k+C
         aUzQi7ULp8OKP+64SzTM9F6xYfalsgwqr0nTsLND6mxCkcKLYiHThfW8vukZZzGrNJlu
         6N/A==
X-Forwarded-Encrypted: i=1; AJvYcCUh5l6lIE4Om5rDPZODIOl+tCqKi9KqA5xHupy02DIBRCCPcfslTH0NJWu+5cj8UptJR081s+AW4Ak9M2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmkVsE84NXAxzVmtIuXt14cn8fZhZ0UlNzqX6faJvyUrIxaNa
	hHZBuXvK3Y46MggBWmVXEjGPIALGViiyjmjzwOGr7FI+wzVJPmjHDvON4ZUYeZWdcRnukPzDBhm
	Xe7WS5jPUOKY+utag/1S5Hvp72NS11VDlq4lW+PUwGNYnoWYEfG31uEcYplJMZUU=
X-Gm-Gg: ASbGnctwVQXTdp7L3ITP2HjFD8WWDWCG+MmarKHjo9XD5W78iwTmJZDBl4Nrq27FRmr
	U0ZKugyeeQJwKjJlOl8HE6KinZ/O/iWxvRq8a6GNSlEEa1cnwRfLfoUrbltgWD0qETqz9BqZI56
	4Ppt7dnJo/gG6NKh9wwPiBHOpH9ic1ygx3jVSY4IF5xC3nbwEt2wNyoaMXc9pOnCga/bEQWykul
	dQdgUVPGyFegJBGH6EoHBh0Z15tN0HMjG39O1kxdjIm7NiEv6qzEn3TpHW0bUZPYYbVGwFGZRN/
	qDVzvIkHGzUlyYg6yRUONKk/Yj6Rnb+h5YK/RdrzpOlpm3H6PGz86nJeQ3U5zYJBaSMRQaE=
X-Received: by 2002:a05:6a00:2303:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-73682bea834mr6032877b3a.12.1741196527399;
        Wed, 05 Mar 2025 09:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjmbCYLlh6OKP/aJo2EZp8bB7f5NVOCgf9md+RM9XMbm3yCdHm8vq8WD2+/r+MsZL538v/bw==
X-Received: by 2002:a05:6a00:2303:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-73682bea834mr6032858b3a.12.1741196527043;
        Wed, 05 Mar 2025 09:42:07 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734aed45c21sm11521080b3a.176.2025.03.05.09.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:42:06 -0800 (PST)
Message-ID: <5bd6c864-018b-4401-8c1b-7bad023de75b@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 09:42:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: ath11k: pcic: make memory access more readable
To: Ziyang Huang <hzyitc@outlook.com>, Steev Klimaszewski <steev@kali.org>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <20250304063328.33762-1-steev@kali.org>
 <TYZPR01MB5556A389846BF8E8A49831CDC9CB2@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <TYZPR01MB5556A389846BF8E8A49831CDC9CB2@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c88cf0 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=JUnQ2HaaVozFeyLivG4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: GsbZ2U5nSPIF4H8AHZaEq_8Kry3xaymi
X-Proofpoint-ORIG-GUID: GsbZ2U5nSPIF4H8AHZaEq_8Kry3xaymi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050135

On 3/5/2025 6:41 AM, Ziyang Huang wrote:
> 在 2025/3/4 14:33, Steev Klimaszewski 写道:
>> Hi Ziyang,
>>
>> With this patch applied, on the Thinkpad X13s which has an ath11k, I am seeing
>> the following:
>>
>>   ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0210
>>   ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>>   ath11k_pci 0006:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>>   ath11k_pci 0006:01:00.0: ignore reset dev flags 0xc800
>>   ath11k_pci 0006:01:00.0: failed to receive control response completion, polling..
>>   ath11k_pci 0006:01:00.0: ctl_resp never came in (-110)
>>   ath11k_pci 0006:01:00.0: failed to connect to HTC: -110
>>   ath11k_pci 0006:01:00.0: failed to start core: -110
>>   failed to send QMI message
>>   ath11k_pci 0006:01:00.0: failed to send wlan mode request (mode 4): -5
>>   ath11k_pci 0006:01:00.0: qmi failed to send wlan mode off: -5
>>
>> I'm pretty sure this isn't supposed to happen?
>>
>> --steev
> 
> Oh, give me some time to check what happen.

I suggest you not spend time on this unless you can test this on all hardware
supported by ath11k.

/jeff

