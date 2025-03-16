Return-Path: <linux-kernel+bounces-563082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4054CA636C4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7A3AEB16
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E31C861C;
	Sun, 16 Mar 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y7PZUvB0"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5814293
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145602; cv=none; b=IAryH/Eh7s7ig7T0YXsx+KhOFOHSGJn22hT00pdDy216F4XoggsXJsnETUOhf0i4jjVUQc/arXr+oXQukgPyBQLf0cgIgIGxcZ3WF6YK2C8ehfplbt7d693tOrR7OSMOoSWbDGEfDzPltF4deQ73Eny4TyBtcGciAl31viS6/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145602; c=relaxed/simple;
	bh=a4qo5ZogxGReOcwQ6ZEnZwIkT1VrRH1SF3vyf2mH2p0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tg6dssG91gQiVBG3u2hCDEMhl5n1gspQk8deJvRk8vs6Opt+7HFjaYFfaeY9djCCzFtDeJGuLq/I1Y0XNxt7KGoRKQeLp2A2oThDBQi5R2cT/qg3tQDB9Hnb2NnCn4h1W8w3uFkMGmXtUbgnqW0GmtHS2ogeHsw9QNVXyKPXjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y7PZUvB0; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742145590; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=fzOy707LWkwGKF9chjVOZk3NWtrTE4bTaEOfE4ij2iQ=;
	b=Y7PZUvB0l1/dDTtyghQwwQFABwFMwPTVEQI1RqauPXE62xHqEs59vOTmirGVzIH1p109jJ3vcjavt9y7/n5z8LAfMqScZxCLFViVxs8Iiqsi07VnH/ZOvXUjiRHpI4ctGOaOkk4AF3EtBYf0jC4+kJTokzTiibMXKW6MI0aODoI=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRVXgmw_1742145589 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 01:19:50 +0800
Message-ID: <793c8af4-d651-48ff-830d-6a8cfd18d697@linux.alibaba.com>
Date: Mon, 17 Mar 2025 01:19:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
In-Reply-To: <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/17 01:17, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/3/16 10:36, Chao Yu wrote:
>> On 2025/2/10 11:29, Hongzhen Luo wrote:
>>> There's no need to enumerate each type.  No logic changes.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Looks good to me, feel free to add:
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
>> And one minor comment below.
>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 689437e99a5a..d278ebd60281 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>>>           if (err)
>>>               return err;
>>> -        switch (m->type) {
>>> -        case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>>> +        if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +            erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>>> +                  m->type, lcn, vi->nid);
>>> +            DBG_BUGON(1);
>>> +            return -EOPNOTSUPP;

`m->type >= Z_EROFS_LCLUSTER_TYPE_MAX` is checked here BTW,
I think the patch is good.

Thanks,
Gao Xiang

