Return-Path: <linux-kernel+bounces-342024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2949889BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CEB1F220AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9018BB90;
	Fri, 27 Sep 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EomoHZVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513315A8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459207; cv=none; b=C46I4kJPgkfBPaSPmYbua9gmvI07cduZ7ZE0Vy9Y/nog+NRU8S+QuShn51rQMm0zCjardKbBNggLBOuHvkIxurdK8jIfS14dAk3e/z8UVzEb85OkqY/av2ELkPC8TuiqJMt4Phsy19oo9f1aup42Pj/K6UmC4OVbhYdhA8O2sSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459207; c=relaxed/simple;
	bh=3sL61aymoDEYtuO6t35PxBh4p7AxYJPxOaaItLnH5TA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bkx50xVXBzYT+++U1SgsxqkP6us0e0RbIBrkHhnH4bxkFLj8q2kKQ6Hkjxo2nqJmG2L9wDGGaILoyq4SEzlB/7aiTFCtCI2Mfc76P4fEXeqrnwKiTOwv0HCIbZawOIkDU7J6ICmd6Qpjjd07T7exDZoX6hLQkvBwEaNybFA/ttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EomoHZVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1BFC4CEC4;
	Fri, 27 Sep 2024 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727459206;
	bh=3sL61aymoDEYtuO6t35PxBh4p7AxYJPxOaaItLnH5TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EomoHZVyTeHGHgY6mKLiNgrraGxyPr1MdakAEb06Dali+dWQjrmIWD9VuNBSkhs7t
	 bQiwDW/xDzArHNhwUtYLkWckWIdy0660HkA2NopMnoS6Hvkf4wArHZoLCspProY9kF
	 TQXuB6AqIzw3BLmtnVCeNL66GGt0dSR4NrycqLL4=
Date: Fri, 27 Sep 2024 10:46:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kun(llfl)" <llfl@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 1/1] device-dax: Correct pgoff align in
 dax_set_mapping()
Message-Id: <20240927104646.3a0b777b5114ec62becd7f47@linux-foundation.org>
In-Reply-To: <23c02a03e8d666fef11bbe13e85c69c8b4ca0624.1727421694.git.llfl@linux.alibaba.com>
References: <23c02a03e8d666fef11bbe13e85c69c8b4ca0624.1727421694.git.llfl@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(cc's added)

On Fri, 27 Sep 2024 15:45:09 +0800 "Kun(llfl)" <llfl@linux.alibaba.com> wrote:

> pgoff should be aligned using ALIGN_DOWN() instead of ALIGN(). Otherwise,
> vmf->address not aligned to fault_size will be aligned to the next
> alignment, that can result in memory failure getting the wrong address.
> 
> Fixes: b9b5777f09be ("device-dax: use ALIGN() for determining pgoff")

That's quite an old change.  Can you suggest why it took this long to
be discovered?  What is your userspace doing to trigger this?

> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
> Tested-by: JianXiong Zhao <zhaojianxiong.zjx@alibaba-inc.com>
> ---
>  drivers/dax/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 9c1a729cd77e..6d74e62bbee0 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -86,7 +86,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
>  		nr_pages = 1;
>  
>  	pgoff = linear_page_index(vmf->vma,
> -			ALIGN(vmf->address, fault_size));
> +			ALIGN_DOWN(vmf->address, fault_size));
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
> -- 
> 2.43.0

