Return-Path: <linux-kernel+bounces-368173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB39A0C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E71C22314
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709A7209690;
	Wed, 16 Oct 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TuMm4XkT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACE1CB53F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087582; cv=none; b=AFvk0mdlAaBJlxBL1lDENFCpV91lGh99UEWPsoH45FK4C+Z9I6gFITkr1xev8hnzuSGyey1lsi24SWOH4Wa3/OUuu+OiuEXUlKJGlJKrCaqLNL2QEZv9YxAlvdg3volo9EK2w1ZXfmrTDpyiDJbrqQvOZGLuFXuzR1VC/tVMmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087582; c=relaxed/simple;
	bh=Wbfp4F8Il0Uu65yxdbxkZy4ZI+gJLUBq7iMBtnNiR9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eU6AFbUoG26yWzfZf/ajl2fIdM0sbAoJilKU+nBJ2aF1B3cRL++wmg02z+2OqkE19XZwNh1N3yci0LQ1IhtWZr2AGWzqeEEZjehwpLgy1NcC5JUEEYd8UFoUVAAqguX1ryPwf2zxLrH4D5L5x7a4i0M+OmYlP7chnGUQA/MofBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TuMm4XkT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MTwPhUZumRV+Q0+GU7eL6HHhDSMy1l8O8nQqkevoH+8=; b=TuMm4XkT0rn9Z5hcb8UjKqfR9U
	8L/3YsW7L3Wl+A/8ro+wkTt2yYio+Kr3jzk5g+DBDzQL4z3zH3S62YK6VTAQPEIILGf8BhyPjBBZB
	Uavj0d4KqZTF/IASxIOGmWzUpCMIbNmLU8ALyRn/Y86cnfcJvAAQ3SL99qUK/sLLVCgPT2jZ+mc8j
	heVgWjQr1lZrW9twm8IqZdHAsh5eJO5BZ1nvr10TfBPoEMN7O778t5AR32NxfzDxmNF4J8Mt+/c/l
	Qf4F1jboyXmIbWTmwk3Duu3ZVuDOW/D9UTu9/G0Gy+y/FqfzD+UyTle/lxoNWGlz8/EXgIXEYvgbh
	dNj8EHZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t14f9-000000087IX-2WSK;
	Wed, 16 Oct 2024 14:06:07 +0000
Date: Wed, 16 Oct 2024 15:06:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Message-ID: <Zw_IT136rxW_KuhU@casper.infradead.org>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>

On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
> Considering that tmpfs already has the 'huge=' option to control the THP
> allocation, it is necessary to maintain compatibility with the 'huge='
> option, as well as considering the 'deny' and 'force' option controlled
> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.

No, it's not.  No other filesystem honours these settings.  tmpfs would
not have had these settings if it were written today.  It should simply
ignore them, the way that NFS ignores the "intr" mount option now that
we have a better solution to the original problem.

To reiterate my position:

 - When using tmpfs as a filesystem, it should behave like other
   filesystems.
 - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
   behave like anonymous memory.

No more special mount options.

