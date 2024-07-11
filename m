Return-Path: <linux-kernel+bounces-249832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95692F078
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24838283DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461319F473;
	Thu, 11 Jul 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYrZngTV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDB8BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731036; cv=none; b=uJFWORJRkjoTlDyOCeDcP4IcCtlpelouNCsfxMYa4tMBrkAA36Nob47c0kzg7bwVykZF0KsAgkVZMa0IHNx1zmQwNLWm7vggLwf2NUgrieU7OzYkW909hM7Pc78eP3QMG53CssZvv961ADdOdiKfB5y3oQOreWCbL+nnzM58EnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731036; c=relaxed/simple;
	bh=C6U5+2MKQd8GQw6Idw5ENhz6VhwIWsV9C4xyieOR7Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6WAQE7dK6N8iuXIg8FeEmL79gBKkh0liEwq5lwhQKUAm7/eU8UiMEjhDhJ58FJyaQ1Y7VKefwftds9teQdkpJd+ZX/xTwnU4CHFMw8KmlwCNtFMk1mRlRufbtsY1We4VCoZIz/CniD1lVO6J8KnPELkDS+Iwx350BqB6RUzRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SYrZngTV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7sfw4UaChI/0QPbmvEbRPHylAdZXJH0kBGEe7mU1bQ=; b=SYrZngTVOG1gdQRHzIXZCzqzzb
	0EyUHSkSovZYOYZh37ruzUbu4dbHkPBli7iWZhzkg5IRejbAJB0rg2B3+QUvMG9PG8HZe8/24pDvu
	WlmtpyJbSB6dJu2VM1XZRoHSedp8U66dl2r7TfXUVignnmgEbbJ7xVpM2p5aKTDqnzXs5v8DEi56b
	/yH2tIVLm7K4S7eh/M9IoRcriPsPZjAFVv6/qsSQCb68MVlKfzj/n7kq7rGio/N8TYOs+TESFxLTA
	71k7Jmj5qAHcqolef+z3CBdBqK98A3HHvvKDbXJMKrq8sl9CUusSbkg4qSZvTy1Bm5l9F6Dqll1PP
	KIy8Mi4g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS0kB-0000000BeCS-0g4J;
	Thu, 11 Jul 2024 20:50:23 +0000
Date: Thu, 11 Jul 2024 21:50:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, jirislaby@kernel.org,
	surenb@google.com, riel@surriel.com, cl@linux.com,
	akpm@linux-foundation.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Message-ID: <ZpBFjzIEpq6RIM8I@casper.infradead.org>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
 <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com>

On Thu, Jul 11, 2024 at 01:47:00PM -0700, Yang Shi wrote:
> +++ b/mm/huge_memory.c
> @@ -857,7 +857,8 @@ static unsigned long
> __thp_get_unmapped_area(struct file *filp,
>         loff_t off_align = round_up(off, size);
>         unsigned long len_pad, ret, off_sub;
> 
> -       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +       if (IS_ENABLED(CONFIG_32BIT) || IS_ENABLED(CONFIG_X86_32) ||
> +           in_compat_syscall())

Why not:

	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())


