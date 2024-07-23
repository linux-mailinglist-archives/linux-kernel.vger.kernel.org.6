Return-Path: <linux-kernel+bounces-259595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819EE939924
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39B71C21AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC213C69C;
	Tue, 23 Jul 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwVRbWHv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9F18D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711882; cv=none; b=D0RVm+h0U2u2uy8TFfE7EZtr38C0v/PXxrDokwrzMw1gAjdZuYTRsYZzS48EHpVs5cxkZs+Belv2ioZ3yPiQsed3wia7o+5NRU/yr2Yfi6abZg65CmDWlW715PjKKtt8YhYK2jXJu3D3E/3V90j1Vxl6uvFCxDdRvhbkG+bOQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711882; c=relaxed/simple;
	bh=MnGjihXqiAGaoS+ccm0KQSGDFvml58Ao6wjAIy0NCek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8mxLLRsez02y2ki3CGyjcfYltIWcNFIKZMGESwBoxPlYUyYgzYe05TUzVrFJDJ241O+cqQ/3dzrog8WZ7q7fVCaXUGV4AyzBYk3d4CpusCsC/sq5jfCHtKVoiicdFfprnKC1/so0yQqJ/S7tXUsUS4IMIZ4Xm3hqK1gPH45t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwVRbWHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721711879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wjPrxZzwd6kroJlcjWmsZZtN0tFwF+CbZxsLDbkBNxc=;
	b=UwVRbWHvEHDMUwJNNgo7sSmt0U+7I0eaop8D6VCiTZzUxThuukpuPjq/mYnz0z0Ts6e8yk
	HCGjubsJxrgHREZnTy+/TaNyJga3sFCQw+mj45V08dbocvQl1fJMcByH1YU0UkDGNCRYBE
	6ulR49vIbf+qZbYgSic84OjtVk4jbBM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-E4vIq6S1NYCY2eEmzso2mw-1; Tue,
 23 Jul 2024 01:17:54 -0400
X-MC-Unique: E4vIq6S1NYCY2eEmzso2mw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC39A1955D55;
	Tue, 23 Jul 2024 05:17:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CA7230001A0;
	Tue, 23 Jul 2024 05:17:31 +0000 (UTC)
Date: Tue, 23 Jul 2024 13:17:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, rppt@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Message-ID: <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723020746.3945016-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/23/24 at 10:07am, Jinjie Ruan wrote:
> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> as below:
> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> 
> It's similar on other architectures, such as ARM32 and RISCV32.
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by checking if crash_size is greater than system RAM size and
> return error if so.
> 
> After this patch, there is no above confusing reserve success info.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>


My Suggested-by can be taken off because I suggested to check the parsed
value after parse_crashkernel(), Mike's suggestion is better.

For this version,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> v5:
> - Fix it in common parse_crashkernel() instead of per-arch.
> - Add suggested-by.
> 
> v4:
> - Update the warn info to align with parse_crashkernel_mem().
> - Rebased on the "ARM: Use generic interface to simplify crashkernel
>   reservation" patch.
> - Also fix for riscv32.
> - Update the commit message.
> 
> v3:
> - Handle the check in reserve_crashkernel() Baoquan suggested.
> - Split x86_32 and arm32.
> - Add Suggested-by.
> - Drop the wrong fix tag.
> 
> v2:
> - Also fix for x86_32.
> - Update the fix method.
> - Peel off the other two patches.
> - Update the commit message.
> ---
>  kernel/crash_reserve.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index ad5b3f2c5487..5387269114f6 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
>  	if (!*crash_size)
>  		ret = -EINVAL;
>  
> +	if (*crash_size >= system_ram)
> +		ret = -EINVAL;
> +
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 


