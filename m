Return-Path: <linux-kernel+bounces-414095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCF9D22ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B97B23ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4201C07D2;
	Tue, 19 Nov 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpF6vPUL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46E1B86DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010396; cv=none; b=SDV/emDlOlqkx+6bQBbCfGMRzER9DtXxdb3bwDlY9K+mF/X6rHgozPCHlsLVbVlg9O7PPdatB037Q2BV/mUe8R6Kw/SPAdg5n/2zmnUYI+DtCkvW6ewbFvle2OSOzqv7AtvLDgtp82sChtmjEF+T1SxkXlLt5T1jesmf4akssFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010396; c=relaxed/simple;
	bh=63pxkNXssRQrM2L4knHbyd0kMuFbHa6LtFqf0DxSmeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gifuw0D04FznaKI7BDuUqe+9bbQPb1bmQic/TZequy73E337Kb6eeLYBmJtrMDXn+vLoX2aMhGO/8zhc8OVCmWdNXGIybQJ1x9I+K65XfMPXv+2KCHr5IL8lNmaPeFob8yuuPAqrxC7QTUUuKyTtiid2d9v89zt8rmDmMFdnTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpF6vPUL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so6186084a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732010393; x=1732615193; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ehDDtmRPifXFMXVHEIhBayF0MkyvbkdJUxO04BnyE=;
        b=NpF6vPUL88Lq8SoHaBHps1eN111QXTO/QMDS711xfW0V3hUFksr3Ga6gNDzYIB7zcI
         BwHS5Ou+o6JlnUACLUiEH2OElRFf/saMBgZm0oQvNIVXgtve0LWemw0LeokzUnFZrGDP
         zMuiiGsRNeB0BBHqEnYS+Js+ADxli1j1HwuPkxhWaUfQR1caRRZt2jvz/8x6V4dZIMIy
         yQbB44rmlhRPMJLsS+Bm4BEPmSEUFm2S10fLBZZwk6x4cGJCuD7m5EU2S05I6NGU7VSl
         TN23laIa3VxN9QHzQgSg9OiB1DhmdV2hvkCxbk4+DJ8IJ7oPUhevSG1XzQyMckek7qio
         sXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732010393; x=1732615193;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ehDDtmRPifXFMXVHEIhBayF0MkyvbkdJUxO04BnyE=;
        b=RdZ1sPnyUbutyT2m8xkEm4TV4UNDcY5Z3IFWp0p0jvPXcZcftqCUr3ObsastL/cwkP
         sPbYfDIEVXQOGDOp8QkisyuFdsulLwW4aR4qiGfXFyL9ZXLc1NyUk4/FWWyY27tB4Fix
         5Qk+4dZQHPhweaVinFcwF0rweRgfx0hy1VPnYHlX836hYESvd0LydzBsUoqSj1J+l/Wp
         AxWVXJYPYPmTP01hdl765DRc6KWSHnWr4djSaE87frE1YqpoMt4T0JArMKGemK1ym56q
         lqO71cPF9WDyrh6pdhP1sIC3u4P7SzH5D3bH2U5L7nMgsPO/2PBAvIzANPFGCVSqyJ4Z
         P+RQ==
X-Gm-Message-State: AOJu0YyuTSFH4lRzkVZmODjslzUktnKWQ6UhTgwvDiDzl7zNPg8p9JJh
	1kq+h0sTDYtkM5ipLPu7pmO6XnHmosfwexFdDwQEjbyzzNyPbsPI
X-Google-Smtp-Source: AGHT+IHOHyHO2oAmtv5u9jyQfez3CaQnsfH3At+m9BeIVTRpwUyC89t4VFBEVcNJtXns3mXdL0K7YQ==
X-Received: by 2002:a05:6402:358a:b0:5cf:cec3:d53 with SMTP id 4fb4d7f45d1cf-5cfde5be357mr2668276a12.3.1732010392859;
        Tue, 19 Nov 2024 01:59:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfc0f4d7f7sm2154474a12.13.2024.11.19.01.59.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2024 01:59:52 -0800 (PST)
Date: Tue, 19 Nov 2024 09:59:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sid Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com
Subject: Re: [PATCH 0/5] Track node vacancy to reduce worst case allocation
 counts
Message-ID: <20241119095951.a46jgpbkz7suaahk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <a522ec38-582a-40b1-b3f6-06dbabd731ad@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a522ec38-582a-40b1-b3f6-06dbabd731ad@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Nov 14, 2024 at 04:39:00PM -0500, Sid Kumar wrote:
>
>On 11/14/24 12:05 PM, Sidhartha Kumar wrote:
[...]
>> ================ results =========================
>> Bpftrace was used to profile the allocation path for requesting new maple
>> nodes while running the ./mmap1_processes test from mmtests. The two paths
>> for allocation are requests for a single node and the bulk allocation path.
>> The histogram represents the number of calls to these paths and a shows the
>> distribution of the number of nodes requested for the bulk allocation path.
>> 
>> 
>> mm-unstable 11/13/24
>> @bulk_alloc_req:
>> [2, 4)                10 |@@@@@@@@@@@@@                                       |
>> [4, 8)                38 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [8, 16)               19 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
>> 
>> 
>> mm-unstable 11/13/24 + this series
>> @bulk_alloc_req:
>> [2, 4)                 9 |@@@@@@@@@@                                          |
>> [4, 8)                43 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [8, 16)               15 |@@@@@@@@@@@@@@@@@@                                  |
>> 
>> We can see the worst case bulk allocations of [8,16) nodes are reduced after
>> this series.
>
>From running the ./malloc1_threads test case we eliminate almost all bulk
>allocation requests that
>
>fall between 8 and 16 nodes
>
>./malloc1_threads -t 8 -s 100
>mm-unstable + this series
>@bulk_alloc_req:
>[2, 4)                 2 |                                                   
>|
>[4, 8)              3381
>|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>[8, 16)                2 |                                                   
>|
>

This is impressive. But I come up one thing not clear.

For mmap related code, we usually have the following usage:

  vma_iter_prealloc(vmi, vma);
    mas_preallocate(vmi->mas, vma);
      MA_WR_STATE(wr_mas, );
      mas_wr_store_type(&wr_mas);       --- (1)
  vma_iter_store(vmi, vma);

Locaton (1) is where we try to get a better estimation of allocations.
The estimation is based on we walk down the tree and try to meet a proper
node. 

In mmap related code, we usually have already walked down the
tree to leaf, by vma_find() or related iteration operation, and the mas.status
is set to ma_active. To me, I don't expect mas_preallocate() would traverse
the tree again.

But from your result, it seems most cases do traverse the tree again to get a
more precise height.

Which part do you think I have missed?

>
>mm-unstable
>@bulk_alloc_req:
>[2, 4)                 1 |                                                   
>|
>[4, 8)              1427 |@@@@@@@@@@@@@@@@@@@@@@@@@@                         
>|
>[8, 16)             2790
>|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
>
>> 
>> Sidhartha Kumar (5):
>>    maple_tree: convert mas_prealloc_calc() to take in a maple write state
>>    maple_tree: use height and depth consistently
>>    maple_tree: use vacant nodes to reduce worst case allocations
>>    maple_tree: break on convergence in mas_spanning_rebalance()
>>    maple_tree: add sufficient height
>> 
>>   include/linux/maple_tree.h       |   4 +
>>   lib/maple_tree.c                 |  89 +++++++++++++---------
>>   tools/testing/radix-tree/maple.c | 125 +++++++++++++++++++++++++++++--
>>   3 files changed, 176 insertions(+), 42 deletions(-)
>> 

-- 
Wei Yang
Help you, Help me

