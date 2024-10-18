Return-Path: <linux-kernel+bounces-370847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3C9A32D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906442828B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C015CD74;
	Fri, 18 Oct 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hgj6c2Mk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CE155739
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218228; cv=none; b=feaKWrR1bY6inhcDXwBHPdlmcjMrk1q36HCmq1vDBHkosmdJClgovvP0cUOh6qke43oLLyTmMVSP3IK18H9IYFsbQz94M/1R6XG9GHtvSDbfESqvOnhk/9sValtpV0cZz/GLlH31OSlwH3ILNg4yAJgSAGhxIJRMxxGbzVZAq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218228; c=relaxed/simple;
	bh=gLjHY8MSJKyIeC/hJP2PTDhzo1Qc2eZ/oompiLpRfkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYKkI6gYYeEWuMUtNjVD20IMPMYV3A8NXWetSMNenpmeIg/pOKxgdLSlppwDggSuDps20dfU+BRaErVPAg14d8GUy4sq8ZhYQLSdqXquboXfP6RJwCzD/aEYjEqCrMaFzE/aUfIvAs+Ho52/Yh24DXRHzXRTF9A8U8VWKZP2PHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hgj6c2Mk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so1181834a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729218226; x=1729823026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWdd9RuQD9OT8IO+IFQorkG8tJKWR5GHHBm0b+278DM=;
        b=Hgj6c2MkIba5E7DdPDUezpdjZEKnpl4vjE+b4yAG1pTaY2Zf6fPCMnTXG9p3zf9jOu
         +jmpkeQ54Ikd/tm1zbRS7kP+nkcOGaP88FMYxC6R4VNyKEGsH/ki/TrHmXOAL0qJro9L
         Iw2B1yVNg0CeUpw5wjAYzUYbrujkUsRkTbhvN/y82S8cIt5p5ypYif0yrn8re4VBUWHp
         NLn9LIutwh4dlXbPDaaYr/+1N/yqarUwWXSJt7GadizeigsKy2FuBr0i4bKpDh4NWxaa
         UMVm2TJRwTBLKwZjQUerqckR947LtlDVZtbZIG2ELjphhR2kkl0tAL037a7gn/cJH6Em
         EGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729218226; x=1729823026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWdd9RuQD9OT8IO+IFQorkG8tJKWR5GHHBm0b+278DM=;
        b=GNgRqnqHwQW/n7eG2MMFvTOkHcZy/2qP4V3jyn2OnI1q4lojLH/JiKafKsiSla6Zym
         md4u7m40dgolC684Nb2ENjeZV9sQ8IA6gS3GxtBC27REtmDsFXqzyBLcPFRHjhQglLDX
         Ap9Ez7R/pLUaWPqAx3JVwRfQ26LoAB3mRAGOs9RQq19tPnEKuxnP0CIW4NlIbxdbG9I4
         letUvY+l/rzpOr4dlk/xSXkdB0U77NbJUcCr0SXP34W5elaW/a3fpKPHeIDjil7jzUZ1
         zWA47nD9V3Uf805CZWcjtjuVZWBEJ75OmZ3s29vJXYG4wCZZCfegLwq+LXLNMb1PsuMp
         U5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsbVwzN2C9Ngr0RuzTimXwAfuehmjI5TYedSNCsnh+Etni3TKoUIGb/8lmOimSppRB7XYIpIADbOwSeF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPPfVKM3F80xM7XNhrvrd9VqiXNB/DvVB1CbWGKcjbGkj311P
	VLwMwLVmO6HLV54c0V/eHVkMRGemvDkz+jhWt+r6EVdopEwG3YuMa4fepbOvO5s=
X-Google-Smtp-Source: AGHT+IGRgwQMcdUN+DdM+bHtNlDSqsON7etEGgvrap7Zi8+M8ABi3eEaKwZlzaeZthvdRl0aSSBn8w==
X-Received: by 2002:a17:90a:4b88:b0:2e2:d197:40f3 with SMTP id 98e67ed59e1d1-2e56172465amr1204446a91.35.1729218226505;
        Thu, 17 Oct 2024 19:23:46 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da3bc3fsm651646a91.42.2024.10.17.19.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 19:23:44 -0700 (PDT)
Message-ID: <5242273a-e5c8-44f3-93ba-488e64af78c3@bytedance.com>
Date: Fri, 18 Oct 2024 10:23:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] mm: make zap_pte_range() handle full within-PMD
 range
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <cd03a570f23e67016d23c3aa27f5931715570416.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez28bTO2KChkzktf5XJGDsC81mMhKaeny4vmoOMJ38wJ4A@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez28bTO2KChkzktf5XJGDsC81mMhKaeny4vmoOMJ38wJ4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/18 02:06, Jann Horn wrote:
> On Thu, Oct 17, 2024 at 11:48 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> In preparation for reclaiming empty PTE pages, this commit first makes
>> zap_pte_range() to handle the full within-PMD range, so that we can more
>> easily detect and free PTE pages in this function in subsequent commits.
> 
> I think your patch causes some unintended difference in behavior:
> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index caa6ed0a7fe5b..fd57c0f49fce2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1602,6 +1602,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>          swp_entry_t entry;
>>          int nr;
>>
>> +retry:
> 
> This "retry" label is below the line "bool force_flush = false,
> force_break = false;", so I think after force_break is set once and
> you go through the retry path, every subsequent present PTE will again
> bail out and retry. I think that doesn't lead to anything bad, but it
> seems unintended.

Right, thanks for catching this! Will set force_flush and force_break to
false under "retry" label in v2.

Thanks!


