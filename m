Return-Path: <linux-kernel+bounces-245763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E092B8E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59E6B21B28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A41534F8;
	Tue,  9 Jul 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+qQlcWk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AB1EA74
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526191; cv=none; b=eKdysVzF2NJ3Rl0nKadGzDhfvMkK8gjv/+HfZVt0w3jLRzV8JxlGMsMcUln8agQWOKKnSUjTbrul2Wwa8GAS7VGv9O6UhFy+U6lPRzMYKTsO3qM1vS2w+TwoSvkvtaFWYBZ8Pn+NIShV1I59KnNO6td+vGoJ3DiCSskIPGgUefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526191; c=relaxed/simple;
	bh=iwOwn57p2wyL6NB52eUH/DDhMOsbR+xMK/mqYL7ckSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orXC6X3FtlEsSmxVmckIOTathiWDV9f+8bH0m0sMbwICNIBfFVa1h12WmqS1vDIbxWbQr5ZNN9h5sbfUsfp+zR/0yaxOaN6ahuX8DiuhLcM2XQYJLp7am5XFIHS7yK06d3i9dF9qkqOeUdaRAY1V70Efs8asBn8Ul5HEWXIoPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O+qQlcWk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DM2BJZhMwpSGyN9OWrMu8sRkPGKjHUKKFKcsWq3B1IM=; b=O+qQlcWkHhpdiCu28MICATUe9d
	bQ6RT7qME0tQ4icGRjZFmadItFADo2d3G2To8jmyU/GZaKopzm4Lyq9zjrI2zNxacc8tIC66ezz8e
	9Mmn2VQw18elmoAbXO+Mpp+4tt5IY9yS64WBWv5FbsGLLQXkGoYuogi8mYipFkpOEpSHBDZiKnTHL
	jjUkHzFsSsgDUBTJfFxZZa4rIv4wmJeA6ZQPIVE/Ki/DGsR1Gucmr1bPuS5fscCcD9T4CWuf8FsHt
	OENGz0EH2qi56BjWNnAJ1Toh7s07y2Cz4J7UBdsGnZypUju9GaFTE6hU5mCmseM8i6wzXOPLAxXwR
	K0f4GYbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR9SK-00000007rBZ-2Ipo;
	Tue, 09 Jul 2024 11:56:24 +0000
Date: Tue, 9 Jul 2024 12:56:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: zhangchun <zhang.chuna@h3c.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, jiaoxupo@h3c.com,
	zhang.zhengming@h3c.com, zhang.zhansheng@h3c.com,
	shaohaojize@126.com
Subject: Re: [PATCH] mm: Give kmap_lock =?utf-8?Q?b?=
 =?utf-8?Q?efore_call_flush=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoi?=
 =?utf-8?Q?d?= kmap_high deadlock.
Message-ID: <Zo0laCcWwAoL0bFu@casper.infradead.org>
References: <1720516658-50434-1-git-send-email-zhang.chuna@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720516658-50434-1-git-send-email-zhang.chuna@h3c.com>

On Tue, Jul 09, 2024 at 05:17:38PM +0800, zhangchun wrote:
> +++ b/mm/highmem.c
> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
>  		set_page_address(page, NULL);
>  		need_flush = 1;
>  	}
> -	if (need_flush)
> +	if (need_flush) {
> +		spin_unlock(&kmap_lock);

should this be a raw spin_unlock(), or should it be unlock_kmap()?
ie when ARCH_NEEDS_KMAP_HIGH_GET is set, do we also need to re-enable
interrupts here?

>  		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> +		spin_lock(&kmap_lock);
> +	}
>  }
>  
>  void __kmap_flush_unused(void)
> -- 
> 1.8.3.1
> 
> 

