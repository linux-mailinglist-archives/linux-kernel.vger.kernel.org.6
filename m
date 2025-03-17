Return-Path: <linux-kernel+bounces-563397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01CA64100
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4CC188FBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD41E1DFF;
	Mon, 17 Mar 2025 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="psvBrGWG"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F455290F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192125; cv=none; b=iqYCa2xT/ROuFqc4OHnq4HKGnUk2TmyV8wEdrwOTL6krTh2ouX3/uxMcwy+2e/5BaI18ixrAIg23cdjbhdrFtRBvj3piq0Vfb8IndWZgsANRxAi9qoIQf57/LzhWdLYOOVX6YD1T4DbY1pA22f7Z84FKV6nFN7V6b3Gt5MrFgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192125; c=relaxed/simple;
	bh=apOQC9dhI2xDTVmNUxbKpTpWARGeaMwMMnJfLjD5kso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhEWBfh0MkFLF2FtbEfy0hehxbuRAyqldXfF9u2onyhth1WXoqy2F8XEy+uZygWe6OvPZsiRIEvQ5ftUIK5CMNw/3O+xXzAyjtuyqK4UDeVcUUk0JxzD9dRleiBRvAymy26Wa25vW5nK/wcHU/qEAqkgYma/NbXjhEoJb0TVAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=psvBrGWG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742192119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lcumtgAUnd66okozoJf6gqw1VxhKrCwQJRm3zl3dAOI=;
	b=psvBrGWGBp4hFjfP/VHAeab7a5mDBqlWjgFBok6FogYK4hMZ1d1jiu9WR8IDkCQcn+/VrH72MawtN9O2SDCfUe081YnQEcRam4Q3VGBwdAYjMq8neHH2veFP6BIlHlY8n6lIkYkVcasUPf/tBal+DapRUpu+Zp7z9NBUxiyXuV4=
Received: from 30.74.130.1(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRZQMxw_1742192118 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 14:15:18 +0800
Message-ID: <18767765-53b5-4e78-b50d-9305fe1cb2d0@linux.alibaba.com>
Date: Mon, 17 Mar 2025 14:15:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
 <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
 <489be3d1-a755-4756-ba82-a8f5a0dc9156@linux.alibaba.com>
 <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <04050888-7abf-40fa-98d6-6215b8ba989e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chao,

On 2025/3/17 14:03, Chao Yu wrote:
> On 3/17/25 01:17, Gao Xiang wrote:
>> Hi Chao,
>>

...

>>
>> Previously, it was useful before Z_EROFS_LCLUSTER_TYPE_HEAD2 was
>> introduced, but the `default:` case is already deadcode now.
> 
> Xiang, thanks for the explanation.
> 
> So seems it can happen when mounting last image w/ old kernel which can not
> support newly introduced Z_EROFS_LCLUSTER_TYPE_* type, then it makes sense to
> return EOPNOTSUPP.

Yeah.

> 
>>
>>>
>>> Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
>>> then we can treat m->type as reliable variable later.
>>>
>>>       advise = le16_to_cpu(di->di_advise);
>>>       m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
>>>       if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>
>> It's always false here.
> 
> So, what do you think of this?
> 
>  From af584b2eacd468f145e9ee31ccdeedb7355d5afd Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Mon, 17 Mar 2025 13:57:55 +0800
> Subject: [PATCH] erofs: remove dead codes for cleanup
> 
> z_erofs_extent_lookback() and z_erofs_get_extent_decompressedlen() tries
> to do sanity check on m->type, however their caller z_erofs_map_blocks_fo()
> has already checked that, so let's remove those dead codes.

z_erofs_extent_lookback() will (lookback) read new lcn in
z_erofs_load_lcluster_from_disk() so it won't be covered by
the original z_erofs_map_blocks_fo().

I think this check can be resolved in
z_erofs_load_lcluster_from_disk() instead but maybe address
for the next cycle? since there are already enough features
for this cycle and I have to make sure no major issues....

Thanks,
Gao Xiang

