Return-Path: <linux-kernel+bounces-571358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C821CA6BC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572584802ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B71770E2;
	Fri, 21 Mar 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nZuKH1NF"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9438FB9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565334; cv=none; b=Cl8+0rWjU03W2TOz4Y0xY8s48Z/ubV2hLaHsFtJD1axKiYZ6iyLYHoA+VsDnQjN08i6geVscp96U3IEiGCRsrKP4Yeie7cij4Mq8cGbmP2p9mAlFf85iFVep0XsJdeESDPwCqg98IxMvgxyh+97gFxYQ5JvyNxGSsnkcAjxDC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565334; c=relaxed/simple;
	bh=AdJuexWRzfAz86oxnne/IW4kJwTlZlMmB/BbN8hoPs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRB32k74n4THDhjGpHeuy1j5M64ucGm32a/iA7PY32GXkUxjHfn+aL+vwhFYpFJ0U2uvXIUsKVn0uQVueokWWGi8th9qHocNe6AwrrO8baVly/J5Ab59BxLMb051A0xcC4bgP/g1bOM4OtFtieYYb4I1Iz9we/8VYjXtze/ll4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nZuKH1NF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso10358771cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742565330; x=1743170130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zkaw5iQ5n3Q/0Lpyrz/8zsFxGsxzzffjeg2zbqFtr2Y=;
        b=nZuKH1NFmye6NABmUiq/avz44ikpxhiz8Wo+Kw0OJRjPzNRaQAYDiQyQOFdB15Le2l
         hMQxETLquYHNWLmHh0OIbMwzqmphxZ2GlnX7OYFAkYDjvUH7+ROww5gPKs/SucSdE/WH
         wOKsLL8IV1fGN6V7GnNiCvgErnx+Al1fETz7z8Yrb6O6KivzXtws1AoApg/KKgcT15Hd
         gPvryZmXNrWr270nblLA9juuEPWbiW/+UCaKdwkf5WPNnxxLScfcqaCVCJZ3dLco0Dcq
         FAKsEzrwPz4Ug2PsdKilbnkSdxnMGrmlPQtdbvQoeBB0eUw5pawb4zEMRJlKl3awqUyo
         j46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565330; x=1743170130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zkaw5iQ5n3Q/0Lpyrz/8zsFxGsxzzffjeg2zbqFtr2Y=;
        b=OMEOt/Wtwf1fmhP5D0+APMQs9nVIwQ/h/Kv4vBWD0SKriyRpk+pJhpn07P7A2WsDnS
         Y32gpgyE/GKnCeisA2ug9t6qimk96CT6Q2mXAT8K4K9hfRDz3NdtVePXAkOiOY5OoJx0
         V7ZGOTpLnJFgCzmj8TKKyJ34llA8ijkUWd48I/Hb0F6flO18Ggrn2r71JiyszyD4fpie
         yybsHSW+OkUg2pz8xFsiBxM9NtRn4yOVJKMG8R3kiOLI3eTm6ER1KcmLkxifeHrmnxoG
         jofq2AqdDm8Kj8ZKl53W0JjrQaShs61G1d4FPwbHsFzOOUPP4ByoUDh6npZGu6tRBm+V
         B9jg==
X-Forwarded-Encrypted: i=1; AJvYcCWdn7UZKtFanv0P2g3tCkwRktym3FyofNiOI26t2+6+DEM0EglzZZoQfMBRr+NuSck6sqBWICEURyjVM2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHskTi8qCbz1SCg+50W7o3rYC5RpY09BZrnCp22ZmwMGeD0yw
	MrN1od2v/jVocM/Yk8Xpe+m+xhQ2js7UspdzXpVi3pCTaiotey8QmV0lqKIdYmk=
X-Gm-Gg: ASbGncuqRj6qd4z+Nz5seWVkLwk2CuI3A2j4W7s4Eve2JieQc2qmLEEy5BUi2esDnFD
	a8Eg2gAATeKYl8sBgY2bNj5kzb54iQ2ekotqTsnhbuilcsQfuoib2bmEvMdgE0+iAHOv6vti73f
	1w5Vx2xT3JRsr4ZqKcycfbga1lIfrZo/Di4wrrZU45Dmbh9Hvkk8+eC9nbexpqbz8pXwU+wp8Oh
	i7kWtShhKxCl7ZNRnRChqNjox20+1GhOkM5NHhSfeoE7Q8yLKZjDO35fRo5K9IvSUT+Kdqr/zA0
	jwKjfyse8lPI9dOmjvcNDc1JLHA3OZTnEX8yYfLFPZQ=
X-Google-Smtp-Source: AGHT+IEbXh5FE8O7VAveIGhz62AHSuu58vMlCms/I/PLbVH2bCgBpWKIinMzMYIWRzFsFMsCidgO4g==
X-Received: by 2002:a05:622a:2b0b:b0:476:8e85:2a2f with SMTP id d75a77b69052e-4771dd943f4mr53309741cf.20.1742565330289;
        Fri, 21 Mar 2025 06:55:30 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d64d5f6sm12262101cf.81.2025.03.21.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:55:29 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:55:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 1/5] mm: compaction: push watermark into
 compaction_suitable() callers
Message-ID: <20250321135524.GA1888695@cmpxchg.org>
References: <20250313210647.1314586-2-hannes@cmpxchg.org>
 <202503201604.a3aa6a95-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503201604.a3aa6a95-lkp@intel.com>

On Fri, Mar 21, 2025 at 02:21:20PM +0800, kernel test robot wrote:
> commit: 6304be90cf5460f33b031e1e19cbe7ffdcbc9f66 ("[PATCH 1/5] mm: compaction: push watermark into compaction_suitable() callers")
> url: https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner/mm-compaction-push-watermark-into-compaction_suitable-callers/20250314-050839
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20250313210647.1314586-2-hannes@cmpxchg.org/
> patch subject: [PATCH 1/5] mm: compaction: push watermark into compaction_suitable() callers

> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

> [   24.321289][   T36] BUG: unable to handle page fault for address: ffff88844000c5f8
> [   24.322631][   T36] #PF: supervisor read access in kernel mode
> [   24.323577][   T36] #PF: error_code(0x0000) - not-present page
> [   24.324482][   T36] PGD 3a01067 P4D 3a01067 PUD 0
> [   24.325301][   T36] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   24.326157][   T36] CPU: 1 UID: 0 PID: 36 Comm: kcompactd0 Not tainted 6.14.0-rc6-00559-g6304be90cf54 #1
> [   24.327631][   T36] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 24.329194][ T36] RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
> [ 24.330125][ T36] Code: 84 c0 78 14 4c 8b 97 48 06 00 00 45 31 db 4d 85 d2 4d 0f 4f da 4c 01 de 49 29 f1 41 f7 c0 38 02 00 00 0f 85 92 00 00 00 48 98 <48> 03 54 c7 38 49 39 d1 7e 7e b0 01 85 c9 74 7a 83 f9 0a 7f 73 48
> All code
> ========
>    0:	84 c0                	test   %al,%al
>    2:	78 14                	js     0x18
>    4:	4c 8b 97 48 06 00 00 	mov    0x648(%rdi),%r10
>    b:	45 31 db             	xor    %r11d,%r11d
>    e:	4d 85 d2             	test   %r10,%r10
>   11:	4d 0f 4f da          	cmovg  %r10,%r11
>   15:	4c 01 de             	add    %r11,%rsi
>   18:	49 29 f1             	sub    %rsi,%r9
>   1b:	41 f7 c0 38 02 00 00 	test   $0x238,%r8d
>   22:	0f 85 92 00 00 00    	jne    0xba
>   28:	48 98                	cltq
>   2a:*	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx		<-- trapping instruction

That would be the zone->lowmem_reserve[highest_zoneidx] deref:

        long int                   lowmem_reserve[4];    /*  0x38  0x20 */

>   2f:	49 39 d1             	cmp    %rdx,%r9
>   32:	7e 7e                	jle    0xb2
>   34:	b0 01                	mov    $0x1,%al
>   36:	85 c9                	test   %ecx,%ecx
>   38:	74 7a                	je     0xb4
>   3a:	83 f9 0a             	cmp    $0xa,%ecx
>   3d:	7f 73                	jg     0xb2
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 03 54 c7 38       	add    0x38(%rdi,%rax,8),%rdx
>    5:	49 39 d1             	cmp    %rdx,%r9
>    8:	7e 7e                	jle    0x88
>    a:	b0 01                	mov    $0x1,%al
>    c:	85 c9                	test   %ecx,%ecx
>    e:	74 7a                	je     0x8a
>   10:	83 f9 0a             	cmp    $0xa,%ecx
>   13:	7f 73                	jg     0x88
>   15:	48                   	rex.W
> [   24.333001][   T36] RSP: 0018:ffffc90000137cd0 EFLAGS: 00010246
> [   24.334003][   T36] RAX: 00000000000036a8 RBX: 0000000000000001 RCX: 0000000000000000
> [   24.335270][   T36] RDX: 0000000000000006 RSI: 0000000000000000 RDI: ffff88843fff1080

and %rax and %rdx look like the swapped watermark and zoneidx (36a8 is
14k pages, or 54M, which matches a min watermark on a 16G system).

So this is the bug that Hugh fixed here:

https://lore.kernel.org/all/005ace8b-07fa-01d4-b54b-394a3e029c07@google.com/

It's resolved in the latest version of the patch in -mm.

