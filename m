Return-Path: <linux-kernel+bounces-252609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD69315E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05F6B216DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092818D4D8;
	Mon, 15 Jul 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wimmw+fO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC318C180
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050574; cv=none; b=sGDRjapCOCPh0R2l9JT9ON4Qcc7LFpVyTUhZbrbHecAr9wNxAFyOif9R+lVRm5qMh5CRCDRQWHGl5s4Ol3QlsM5K3Onbkk9qGRkIF9WCUSxsqmL8NopJcMJAZJvZyClU1PwofIogKph3V6GYN4bTKaLpDrWeYJbsIyx0Xp8s77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050574; c=relaxed/simple;
	bh=ZXCC54F6pjnYCW8QAv2W2Z27+hFp2ogWXqthpZ7wPP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXF7iblafexJiNYYu3j9f7phED3Y/2alqzh+yzZtRGGx6il1l5/M3FWMg1UHni5Qz2qWmTKCYcah+5kSxh5/KXGifTlNYn2qvLBQ7jTWSBQAVIJBYFW2Uc3Rnui8fiKxT/A/ySuvyeq7Tpd/rLimmfBI9WII5W9MW7B3B4ns90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wimmw+fO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=275oTcn22xyjv3pIUoHoQnMkygOo6Cyv0P4cxMnU964=; b=Wimmw+fOz6RA0z/RMgWkIGb5EU
	KhQ/YnLdjdEnjnYlmLMWPX3YNkS9phieouIMZtLS5JYmmZaZKWSzcoUeV4slQZBhPhfwzciWpH578
	Tq8KCfzV1TzlEO+cskilpA9Syl4rhs2Z4Ukc11ztHjNnimWY/yUVa5sJGStqbanmKFqik0kabCbXe
	lAKFnpe/aNdItN3IFYNoikvO4y7HJcRgDH5bdqh2CJajz+MItey9Hx4MpCgkVnoGuGU2OtXLxPPM/
	Ndw9dYphSDIYvhQ9/u+W2HJFuGGhFiLmUIedqXVXch0T5jj6g53rh91hxcxtPQf0P+yx6WTDCK1Ap
	EQANjoJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTLs5-0000000FrAB-2WmG;
	Mon, 15 Jul 2024 13:36:05 +0000
Date: Mon, 15 Jul 2024 14:36:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add tracepoints for page fault
Message-ID: <ZpUlxa2yqtkVvUBb@casper.infradead.org>
References: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>

On Mon, Jul 15, 2024 at 10:13:55AM +0000, Zhu Hengbo wrote:
> Introduce page_fault_user and page_fault_kernel for riscv page fault.
> Help to get more detail information when page fault happen.

Why be different from x86?

        TP_printk("address=%ps ip=%ps error_code=0x%lx",
                  (void *)__entry->address, (void *)__entry->ip,
                  __entry->error_code) );

adding the instruction pointer (ip) seems like it would be useful.

> +	TP_printk("user page fault, address=%ps cause=0x%lx",
> +		  (void *)__entry->address, __entry->cause)

