Return-Path: <linux-kernel+bounces-538836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B8A49DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F950170F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D904170A11;
	Fri, 28 Feb 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLPIcTPR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7931EF399
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757102; cv=none; b=PWkGFyHw9oV2BEibaKQiRcwU9hrcKu4mQyl5ySdEvwKdYr6IA1njp34CtO9z3GNcb9j95kBKgPBV94z1A3KKD7XkJpC4+Rq9j9zR9NvQFPDt8QsMVnqLHybehZ5NffMz0/jgOs1gmlBFezsKnPWRpjkvCeOoO4ci0smjAgtMyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757102; c=relaxed/simple;
	bh=Vv/QMAwZcdHeazWrgZHZAOtR+MkgUhw7F+Chcv5IzP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBhltRjRiqCfKIrsN+sO9Z2twsu4Bv8+cY4Wte4olp4apzh7WVfQAhWxDRJ3pk8RAdToeAG0sEPIq/ps+Z2jWimaN+97/C6IZ7oY8Dx7Q+wSkaeeQKnog+AEgtsNpO2CDQEBqVeEu1x8DpNPniBqwO/HnMsrTNPEiwX2cEljfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLPIcTPR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXLmD011787
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LNUpDIdNaYqmVN760bwRMxn2l9LZA3ETnVlarvrMvs=; b=DLPIcTPRotTuKfTf
	33hlPqh05yNpkp7abvi4/OzcSu0iGx/2OBAjoSaFPg3hxO+XL26VYoNcDVs+3I6d
	ga86erWfQN3KmfQihoV3hIsOpF1jE86yj8eMB068F1UFkHsj0GQkvFvTgp30699x
	dQiiOlnpa7deVA/aZytPHYx7ubb86OxWscl4dLVa9LRt2ZjhACLjcy5UpMJSqCvC
	RpicbvxhNFHar6VIWZIIzI8b92FCihl9dq7WA6xQVU9FmRTGnLWhhM0If4vWYWQ5
	Y9ChsunhMVETusHv9sP+QIBAivelJkf9crLQyKpEKfDcThkxlvXnlCVW2/eMAL8a
	1FNyLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522skywr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:38:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fed0f307ccso272343a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757097; x=1741361897;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LNUpDIdNaYqmVN760bwRMxn2l9LZA3ETnVlarvrMvs=;
        b=EzcwiokDeZYKCvplO/O2b7XiPipXjmkhk3UtR8qArgScVcDyx5uI6RTjn/7RSPsnF7
         Gg3VaTtUU9IXZw1ruPkWHUGJSbhBggTDqzMzR+ExlGzwE51vc+LzdvKC8imwR1CMeX/D
         vv95bP3ooAbuch7h2MOqPEiOoDIr2rvWlcAf2mZNdBaJKMr9/WvdAGRsx4e3zo5ba2Si
         Enih47h+6Oy4JE+UwCiEZ/wAk2xSrFhcWoRwJnw2YxQVqwpupbU1xUWL0JCwrHIa29nU
         0QxFdKrHhX5jPY2/tJZGqetp0xwFp77fG5rgORy8QtxLz4vQIrLsSbyQP6Rj0w5uLf9p
         FCVA==
X-Forwarded-Encrypted: i=1; AJvYcCUWhJ00bNry/5CmXTViqpcy3Woqv/iMcHf42ZQLMnHuWAa9HNBA5pm5NsGEHYgCLoGNRV2NjXXA21G45s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLc0R37eOoicD0VZ6cNSb+SeVOv+ZebpgtMneZADs4kBClDwq6
	/lwveqYTavCOU61++8VWRbEz+Yw/GsdALVMBXHrCP82BV8ya+nMVO1JvkeNK9DMKMOUv7QLhsBY
	bK45WVyhED11wp5/ueixYnhHe7vUZ6SrH3ka94mSczPaDmSGOq9u+HluuozHWiv4cl6BM5rw=
X-Gm-Gg: ASbGnctoOpmgWwJcPI+d99T3G1JDtANUmQa1QK37mIgLu50mIXiw3QfOXQxn6gwdxbD
	smUkyqiDFUba8uAVPaPPW1Cx+I07F9RcNs3QlRD3lBakN4LabhWsCHe7+0Lv99E8izwKRB1inGe
	ROCvkaPMXjZNFGuEljgImJiNynbKk2XeCddS/ggZSO1vkHzvG2NbWYy7myq1ZkAV0mtgmu1Sja/
	OCvphNrmk0tAov2KIlQWZjOYi7sOZnndHpdB2HW0U8kNa9dHGCxo/W1tSZ+VesUdEvFt8SfaoSG
	u/Y+jeM+29blhAbvLIl0U5NdSgGBemdTsv9G6AuNSsFFd7SsA+Tkk9OP9kQsHyZ0dW5mP/SP7g+
	riCOBaG75
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2febab79a02mr6270497a91.20.1740757097289;
        Fri, 28 Feb 2025 07:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESTQBcE0OFBLHlj8E+mhhVJ+4hIEvlMb3ba1zyf+ZYTUKbNkLyE8zPsVDOKn9heQeZqiPpoA==
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2febab79a02mr6270453a91.20.1740757096898;
        Fri, 28 Feb 2025 07:38:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dcdsm34738965ad.77.2025.02.28.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:38:16 -0800 (PST)
Message-ID: <e702e39a-e199-4ea4-a066-0b2e26253f98@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 07:38:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
 <20250227191034.1949954-8-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250227191034.1949954-8-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mBTRJPlYH3hjylk3renS0-se-6yXJ6LH
X-Proofpoint-ORIG-GUID: mBTRJPlYH3hjylk3renS0-se-6yXJ6LH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502280114

On 2/27/2025 11:10 AM, Raj Kumar Bhagat wrote:
...
> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
> +{
> +	struct reserved_mem *rmem;
> +	phys_addr_t bdf_size;
> +	int i, idx, ret;
> +
> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
> +		switch (ab->qmi.target_mem[i].type) {
> +		case HOST_DDR_REGION_TYPE:
> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
> +			if (!rmem) {
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
> +			if (rmem->size < ab->qmi.target_mem[i].size) {
> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
> +					   "failed to assign mem type %d req size %d avail size %lld\n",
> +					   ab->qmi.target_mem[i].type,
> +					   ab->qmi.target_mem[i].size,
> +					   rmem->size);

The v6 version had a kernel test robot build warning here when building for
MIPS and it looks like nothing has changed.

I don't know the history of why struct reserved_mem::size is of type
phys_addr_t, but that type has a different size depending upon architecture,
therefore you can't use %lld.

To print it correctly you either need to use the %paa format that is meant for
that type, or probably better would be to assign it to a variable of type
size_t and then use %zu (and use that variable in the size test as well)

(also consider if the other %d formats should be %u instead)

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			ab->qmi.target_mem[idx].paddr = rmem->base;
> +			ab->qmi.target_mem[idx].v.ioaddr =
> +				ioremap(ab->qmi.target_mem[idx].paddr,
> +					ab->qmi.target_mem[i].size);
> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
> +			idx++;
> +			break;
> +		case BDF_MEM_REGION_TYPE:
> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
> +			if (!rmem) {
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
> +			bdf_size = rmem->size - ab->hw_params->bdf_addr_offset;
> +			if (bdf_size < ab->qmi.target_mem[i].size) {
> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
> +					   "failed to assign mem type %d req size %d avail size %lld\n",
> +					   ab->qmi.target_mem[i].type,
> +					   ab->qmi.target_mem[i].size,
> +					   bdf_size);

the same issue exists here.
again this would be fixed by making bdf_size type size_t and using %zu

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].paddr =
> +				rmem->base + ab->hw_params->bdf_addr_offset;
> +			ab->qmi.target_mem[idx].v.ioaddr =
> +				ioremap(ab->qmi.target_mem[idx].paddr,
> +					ab->qmi.target_mem[i].size);
> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
> +				ret = -EIO;
> +				goto out;
> +			}
> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
> +			idx++;
> +			break;

