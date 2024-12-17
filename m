Return-Path: <linux-kernel+bounces-448524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC49F4144
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E07A51B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5113BACB;
	Tue, 17 Dec 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TZ+fbMkj"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F760136353
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734406683; cv=none; b=q/L6s3IgPLCRaDkIU8H1Gkn2SA+arYGpchGchve/n+JMV+Z71NXJ+PS3mSBkzqPWa1qnk8IWQQ/Yn9eW9pAhxY0WRiPHyVVkJT9lGk0D+Y0n0fHAfUL73Sr7SwnlRh6KdMDP0h8F8uBFN5lJbHdyVN9nf1ISMIXFuGyLN4RtKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734406683; c=relaxed/simple;
	bh=GcTbbaap1WgsNiM6CG29TJOE01Wk6g6C0Wzqu9oZhZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAU+aIB7e9fGaUDtgj8xYGaKEs1nklduJm1QFmBOsWLUbP/c/OIyLQv4O/xa7hGQcX2qlXcYPSqJNJMQNQGyC8A2KsB51gzV+VGzFBmfu29mW2igEaXehABdXb4Kn3UwbQJ3DCaqvab4W9TMWQINYi8l2qG839rzwZT4ELMlozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TZ+fbMkj; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a1d43821so39189271cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734406681; x=1735011481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3NzRXOAukgjn6rJBC1FJTe3MMlBMIs9iKLl4SePFr4=;
        b=TZ+fbMkjjhCoNij5oCBW3zDu/DQ9l3nSKgP7grHfwk0RlCYUIFHlCslcQtVdDlv9pG
         vQpBbXeBPhSZUnKOQNHVrefw2QXKeVxuRClqI26oZjY6fPurS9IrgXC/mqByhBMgkLmq
         1yoU7WS8El/l4dX3STPF9SWc6npiJmXUx9DJ7VgW75hpowFamzTf3QD7ZYcbfs8Pkuoo
         j0u9jdYIyeHxsyW4wiWcx1UJY4Z7cHoe4aRyuCv5WBMxGYRlAys1qB+xp+L/ZX7owZYh
         iT0ryFeybpKUalL5Rau6s70F/gvU/ahxqQNnp0q6RzhnDN4pAfl4e4FJWiU+BWy+dUtn
         GUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734406681; x=1735011481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3NzRXOAukgjn6rJBC1FJTe3MMlBMIs9iKLl4SePFr4=;
        b=IMGu5xQtH4uwxb4550U4A1Nx2bZbnvS2D1SCNtTFkmbHJJZHMDqz70oGQXzoQxt8sh
         ycDM4qZR2vOk1hiqxMtSiVpqT9TVqzMbm6OnYSurk0YqYEuiNyvYlvTCmdDhldO1H2ic
         DJNovRlHgDNGoiPYSsi4KSkOWFFxKUN2q19RGnpjYMSGKVdTRdAYS8pdrTL3sa1EKrDo
         AGCDWiSruu/YDCapILtaFAQIa/tuMCuoqeOhAMakpjlw4fuS4C+3QlB/2l/4Ab7l4d0o
         3TkKTOGIiD+54f8yvT67PcH8yufqTzacRQyHIy9+F1jXwyuVSnaxwpeByifOVIJFAExg
         s59Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMaeaWetMuj2pDprj9Et+nA25tb3q+anPooko2Gcxjv+hcQAP6kwB4+32zvoql7h5vXp0BDMwzwQw6HTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzag31aEw4Awd3soK3OGrG/m/eo68x1y/zyPxk3PoO5kOXsK2xh
	RAdkj1VpSPYvUrEjO5CBI7SzsA6qOOXbWyapZbxm3kaRmL6Cxgx9pweX87G+Dl7+CdAQMF06rDk
	w
X-Gm-Gg: ASbGncsVUgaNZexP3/sVCjwd9BPumGwl+6R+GqDBSiW/9VI++OOKV1PuowapDiTsz3j
	WGhtoa+KdQILaTsjNuEtEG60CXQCN6EqYYlUE6isam9/TdUgLanK35JhLTIY6cCLDlGhhpt783x
	4dVpmxte4C3BtpYkKXlWcm35EtIVtMSjNRE6PSkgNQzWofWym3ZBefQK0Kf+k6iQcVpXUHF1CrY
	u7NJo/cNF4FxePkggg3ocuTWZyOf9MLksqVVfJlhqI4QNJXH+c21DOYcTqWIFU=
X-Google-Smtp-Source: AGHT+IEJZ+LfdwF1zJ+/dxo31FEU23mHe/UDc5W2pSlWc4ifzuwGzvTm/aqTxwuIJBKQVgEP9Zze5Q==
X-Received: by 2002:a17:90b:4b84:b0:2ef:949c:6f6b with SMTP id 98e67ed59e1d1-2f2d886111emr2682083a91.13.1734406669327;
        Mon, 16 Dec 2024 19:37:49 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc430asm8895001a91.53.2024.12.16.19.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 19:37:48 -0800 (PST)
Message-ID: <9e833b88-4efe-48eb-a605-984f5ab7f49f@bytedance.com>
Date: Tue, 17 Dec 2024 11:37:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216121953.765331-1-pizhenwei@bytedance.com>
 <affab92f-9a5b-481a-8816-8d5560721648@linux.dev>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <affab92f-9a5b-481a-8816-8d5560721648@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/17/24 00:47, Zhu Yanjun wrote:
> 在 2024/12/16 13:19, zhenwei pi 写道:
>> User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
>> however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
>> mismatched information.
>>
> 
> This is a buf fix. Perhaps Fixes tag is needed?
> 

Hi,

Please amend this on applying patch:
Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")

If v2 is needed, please let me know.

>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++---
>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/ 
>> infiniband/sw/rxe/rxe_param.h
>> index d2f57ead78ad..003f681e5dc0 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -129,7 +129,7 @@ enum rxe_device_param {
>>   enum rxe_port_param {
>>       RXE_PORT_GID_TBL_LEN        = 1024,
>>       RXE_PORT_PORT_CAP_FLAGS        = IB_PORT_CM_SUP,
>> -    RXE_PORT_MAX_MSG_SZ        = 0x800000,
>> +    RXE_PORT_MAX_MSG_SZ        = (1UL << 31),
> 
> In the above, perhaps the parentheses is not necessary.
> Except that, I am fine with this.
> 
> Thanks a lot.
> Review-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
>>       RXE_PORT_BAD_PKEY_CNTR        = 0,
>>       RXE_PORT_QKEY_VIOL_CNTR        = 0,
>>       RXE_PORT_LID            = 0,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/ 
>> infiniband/sw/rxe/rxe_verbs.c
>> index 5c18f7e342f2..ffd5b07ad3e6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -688,7 +688,7 @@ static int validate_send_wr(struct rxe_qp *qp, 
>> const struct ib_send_wr *ibwr,
>>           for (i = 0; i < ibwr->num_sge; i++)
>>               length += ibwr->sg_list[i].length;
>> -        if (length > (1UL << 31)) {
>> +        if (length > RXE_PORT_MAX_MSG_SZ) {
>>               rxe_err_qp(qp, "message length too long\n");
>>               break;
>>           }
>> @@ -972,8 +972,7 @@ static int post_one_recv(struct rxe_rq *rq, const 
>> struct ib_recv_wr *ibwr)
>>       for (i = 0; i < num_sge; i++)
>>           length += ibwr->sg_list[i].length;
>> -    /* IBA max message size is 2^31 */
>> -    if (length >= (1UL<<31)) {
>> +    if (length > RXE_PORT_MAX_MSG_SZ) {
>>           err = -EINVAL;
>>           rxe_dbg("message length too long\n");
>>           goto err_out;
> 


