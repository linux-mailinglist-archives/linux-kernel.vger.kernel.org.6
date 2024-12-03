Return-Path: <linux-kernel+bounces-428960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95C9E1563
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63FD161531
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D581B21AA;
	Tue,  3 Dec 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aHtMFiHE"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BD1A01B9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213717; cv=none; b=ARqeXCOGKhjWtElX2tLYZBZlHnERTxGJElftNmYv4a9kg2hxxauqeJmwhVg7iFhjxjHz4+QHuvYqBn5kJ16V8Xq1Cqr/BiiKeCuD4EECPotap8hIgaNi1127EUYGbnqYcW2sYmpjuUi/hwdz8yC3xc493PpmJTwd6ZpT4CbMdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213717; c=relaxed/simple;
	bh=ZiLk7GgWvmZilORth65y8636sc7UGfmaJFiqtnWLVZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVtc5eVcI4/b7UPu2kJmGhvpdkMv6QuECO1ugA3p33oprTIYQZB6dlTY6fRMvvW7lxFlaSSciPHOcWXCKNkOzSoEFI74BBTJOEbWvdw6wkNlq1u2iQNR22CxJchLeYtkdsIQ+FLjxNPtXUyW8cZoh8Rye0rxjRiQiVdmxvsyQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aHtMFiHE; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733213706; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P9bXSc8Mw7fyXPHQ8KEsd7SMB95kevoVh98GxRCDL0w=;
	b=aHtMFiHEbFDhGu1ihTWcEnnXR3Z2oQIYqsF7Z9J0LXbc8ln0+qlXss/Zb5snHJR3aCtijv/+mruE11RtNfSyIimXQacaLo+pURKz0m/pxy1gNL5Zex5tsbz82iqh9fAsn7PPxPJSfEVysLR8oyTZThYo3fSn8C05mfUXkQin398=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKm.qCN_1733213705 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 16:15:05 +0800
Message-ID: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
Date: Tue, 3 Dec 2024 16:15:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
 <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/3 16:02, Max Kellermann via Linux-erofs wrote:
> On Tue, Dec 3, 2024 at 2:42 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> I think at least this patch resolves a recent regression,
>> I guess we'd better to address it first.
> 
> Certainly your patch is an improvement, but maybe this just wasn't the
> bug I was experiencing.
> 
>> As for your reports, I think we might need more information
>> about this, since I don't find more clues from the EROFS
>> codebase itself.
> 
> What kind of information do you need? I posted some high-level
> information about my setup here:
> https://lore.kernel.org/lkml/CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com/
> What else do you want to know?
> This triggers pretty often now - can we improve Suren's patch to
> record and dump more information when this happens?
> 
> Right now, we don't even know if this is an erofs problem (and if this
> ever was). It is just one of several candidates.

I have no idea since I'm not working on PSI stuffs.

But I guess you could record more frame addresses to get the caller
of readahead_expand()? e.g. __builtin_return_address(1)?

Also btw, is _RET_IP_ stable among all cases as readahead_expand()?

Thanks,
Gao Xiang

> 
> Max


