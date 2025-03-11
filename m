Return-Path: <linux-kernel+bounces-555667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1205A5BB08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F1916FB73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A2226541;
	Tue, 11 Mar 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q37KFYar"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87102222CB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682831; cv=none; b=TkfdMvOwilg+UOwkVhVYFx0WIDyB2SSEruKEP2Y3SemjP5qf1E+64T0zJ0ExtmgsPIJ/MLT2jLXkX3a+svX801mFB1LjxXwJUZG1llFL17CcqjD4fHgXgTY2e/RrfoPtSibWjxbFqpfj1m12ocUNpNY/vSofd8Lr5L52Iig1z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682831; c=relaxed/simple;
	bh=t+qxbdjqT90HBsCbN8OK5I4IJn8eZdvYfgX9yqYhxak=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iFGWguUek5QS4j6Q5+VaqwSmi9Oddc/UbLdtbxVNb56hwYvZR9dMDYHLoshhRt9YCqQl8hxcdFovh4PmmqB8ohDhTKaKMq/inpvPlw0OYpusgS4eYP5cTX3yPPZZD6t0u5pF45h3QROgA4XmkvuODJcTcldEvx/Xp1uHejOSimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q37KFYar; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741682829; x=1773218829;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t+qxbdjqT90HBsCbN8OK5I4IJn8eZdvYfgX9yqYhxak=;
  b=Q37KFYarCb5iregFFYmFzCzv+6neIwLU5vG9pHa9h0oJWNx62fGUN4J2
   YEI2+gqK6INN7SvEwynlP12gPCMhCr8SSeuSrI2pZoY2jx5bwt5lExVwm
   z5sCU8i7FgXEyOcYIhVq+w0mPoxGkwrzVdU1XpkbgRN//fv9CkLxRtDGe
   CUEteJvqA80nD9lB9LGshLOeFjyBWQBKDseQQge3FtVdnRxnOyvoI5Cj8
   P7Bl+MRrkiUMww5wkSvnGwK0Vnav1PT3CPCDTY+Sl6FxOPrWXdXHAW5gB
   hJUQ0LY2HGwm0M3lUzRSlKgzKvi9GZlJ0cAWI2+X3j8nIIhjx/UcNQQvl
   w==;
X-CSE-ConnectionGUID: tvwO+DuhTSqC/O55hamMIw==
X-CSE-MsgGUID: MftT/bK9QGGYNUi+RQIaWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52915724"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="52915724"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:47:09 -0700
X-CSE-ConnectionGUID: 8bort+IOT0GtxNyE9nztbw==
X-CSE-MsgGUID: TGuCczlKRySnmgtFgPixyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125287912"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.136]) ([10.238.232.136])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:47:09 -0700
Subject: Re: udmabuf vmap failed (Revert "udmabuf: fix vmap_udmabuf error page
 set" can help)
To: Huan Yang <link@vivo.com>, vivek.kasireddy@intel.com
Cc: linux-kernel@vger.kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org
References: <9172a601-c360-0d5b-ba1b-33deba430455@linux.intel.com>
 <d7a54599-350e-4e58-81b6-119ffa2ab03e@vivo.com>
From: Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <ab468ce7-c8ac-48eb-a6c0-386ea7aa9a0c@linux.intel.com>
Date: Tue, 11 Mar 2025 16:42:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d7a54599-350e-4e58-81b6-119ffa2ab03e@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Huan,

Thanks for your response.

On 3/11/25 3:12 PM, Huan Yang wrote:
> 
> 在 2025/3/11 14:40, Bingbu Cao 写道:
>> [You don't often get email from bingbu.cao@linux.intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Huan Yang and Vivek,
>>
>> I am trying to use udmabuf for my test, and I cannot vmap the udmabuf
>> buffers now. vmap_pfn_apply() will report a warning to complain that
>> the pfns are invalid.
>> I dump the pfn numbers as below:
>> [ 3365.399641] pg[0] pfn 1148695
>> [ 3365.399642] pg[1] pfn 1145057
>> [ 3365.399642] pg[2] pfn 1134070
>> [ 3365.399643] pg[3] pfn 1148700
>> [ 3365.399643] pg[4] pfn 1144871
>> [ 3365.399643] pg[5] pfn 1408686
>> [ 3365.399643] pg[6] pfn 1408683
>> ...
>> [ 3365.399660] WARNING: CPU: 3 PID: 2772 at mm/vmalloc.c:3489 vmap_pfn_apply+0xb7/0xd0
>> [ 3365.399667] Modules linked in:...
>> [ 3365.399750] CPU: 3 UID: 0 PID: 2772 Comm: drm-test Not tainted 6.13.0-rc2-rvp #845
>> [ 3365.399752] Hardware name: Intel Corporation Client Platform/xxxx, BIOS xxxFWI1.R00.3221.D83.2408120121 08/12/2024
>> [ 3365.399753] RIP: 0010:vmap_pfn_apply+0xb7/0xd0
>> [ 3365.399755] Code: 5b 41 5c 41 5d 5d c3 cc cc cc cc 48 21 c3 eb d1 48 21 c3 48 23 3d 31 c0 26 02 eb c5 48 c7 c7 c4 3c 20 a8 e8 5b c0 d8 ff eb 8a <0f> 0b b8 ea ff ff ff 5b 41 5c 41 5d 5d c3 cc cc cc cc 0f 1f 80 00
>> [ 3365.399756] RSP: 0018:ffffb9b50c32fad0 EFLAGS: 00010202
>> [ 3365.399757] RAX: 0000000000000001 RBX: 0000000000118717 RCX: 0000000000000000
>> [ 3365.399758] RDX: 0000000080000000 RSI: ffffb9b50c358000 RDI: 00000000ffffffff
>> [ 3365.399758] RBP: ffffb9b50c32fae8 R08: ffffb9b50c32fbd0 R09: 0000000000000001
>> [ 3365.399759] R10: ffff941602479288 R11: 0000000000000000 R12: ffffb9b50c32fbd0
>> [ 3365.399759] R13: ffff941618665ac0 R14: ffffb9b50c358000 R15: ffff941618665ac8
>> [ 3365.399760] FS:  00007ff9e9ddd740(0000) GS:ffff94196f780000(0000) knlGS:0000000000000000
>> [ 3365.399760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 3365.399761] CR2: 000055fda5dc69d9 CR3: 00000001544de003 CR4: 0000000000f72ef0
>> [ 3365.399762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 3365.399762] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
>> [ 3365.399763] PKRU: 55555554
>> [ 3365.399763] Call Trace:
>> [ 3365.399765]  <TASK>
>> [ 3365.399769]  ? show_regs+0x6d/0x80
>> [ 3365.399773]  ? __warn+0x97/0x160
>> [ 3365.399777]  ? vmap_pfn_apply+0xb7/0xd0
>> [ 3365.399777]  ? report_bug+0x1ec/0x240
>> [ 3365.399782]  ? handle_bug+0x63/0xa0
>> [ 3365.399784]  ? exc_invalid_op+0x1d/0x80
>> [ 3365.399785]  ? asm_exc_invalid_op+0x1f/0x30
>> [ 3365.399790]  ? vmap_pfn_apply+0xb7/0xd0
>> [ 3365.399791]  __apply_to_page_range+0x522/0x8a0
>> [ 3365.399794]  ? __pfx_vmap_pfn_apply+0x10/0x10
>> [ 3365.399795]  apply_to_page_range+0x18/0x20
>> [ 3365.399796]  vmap_pfn+0x77/0xd0
>> [ 3365.399797]  vmap_udmabuf+0xc5/0x110
>> [ 3365.399802]  dma_buf_vmap+0x96/0x130
>>
>> I did an experiment to revert 18d7de823b7150344d242c3677e65d68c5271b04,
>> then I can vmap the pages. Could you help what's wrong with that?
> 
> Sorry for that, as I reviewed pfn_valid, that's someting wired:
> 
> /**
>  * pfn_valid - check if there is a valid memory map entry for a PFN
>  * @pfn: the page frame number to check
>  *
>  * Check if there is a valid memory map entry aka struct page for the @pfn.
>  * Note, that availability of the memory map entry does not imply that
>  * there is actual usable memory at that @pfn. The struct page may
>  * represent a hole or an unusable page frame.
>  *
>  * Return: 1 for PFNs that have memory map entries and 0 otherwise
>  */
> 
> So, if pfn valid, it's return 1, else 0. So mean, only 1 is a valid pfn. But vmap_pfn_apply in there:
> 
> static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
> {
>     struct vmap_pfn_data *data = private;
>     unsigned long pfn = data->pfns[data->idx];
>     pte_t ptent;
> 
>     if (WARN_ON_ONCE(pfn_valid(pfn)))
>         return -EINVAL;
> 
>     ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
>     set_pte_at(&init_mm, addr, pte, ptent);
> 
>     data->idx++;
>     return 0;
> }
> 
> Do it give a wrong check? maybe should fix by:

I guess not, it looks more like warning when you trying to vmap a
pfn which already took a valid entry in pte.

However, the MM code is so complex for me, just my guess. :)

> 
> static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
> {
>     struct vmap_pfn_data *data = private;
>     unsigned long pfn = data->pfns[data->idx];
>     pte_t ptent;
> 
> -    if (WARN_ON_ONCE(pfn_valid(pfn)))
> +    if (WARN_ON_ONCE(!pfn_valid(pfn)))
>         return -EINVAL;
> 
>     ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
>     set_pte_at(&init_mm, addr, pte, ptent);
> 
>     data->idx++;
>     return 0;
> }
> 
> Please help me check it, also, you can apply this and then check it.:)
> 
>>
>>
>> -- 
>> Best regards,
>> Bingbu Cao

-- 
Best regards,
Bingbu Cao

