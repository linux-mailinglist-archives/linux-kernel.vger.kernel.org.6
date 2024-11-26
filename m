Return-Path: <linux-kernel+bounces-422782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5669D9E17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A17A284457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615081DD87D;
	Tue, 26 Nov 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsbegswW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171C28689
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650421; cv=none; b=QiteTNKwyz0F0EYrvf8x+NaWZO+0rtYl1G9J5xVvM4N7vSR5QCzUWuIs2cIzYEZxOQm6KAambPu5vJny4+nZka3AEBK/r/J2U3GBk5RyHG0I2WLzScOv1KDewnABmuq27tfSzOZbST083Hibzf1R19fq0CrecP5NEhjqEGWNwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650421; c=relaxed/simple;
	bh=uE5hUjDKXVrIM3lSxreIifd8IM/XWqg86OFVqiKM64k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFAvwKdLl+h/1Y0yuldyWM81Jb1Jkelwx80G1DOgkhgxhvZj3vo14rLr3ceSdu0LxfOGUQY4Jtway+msP5sf1uZzUtZOeDURLpKGmaHFTG4PpB9hkQQfsyRVrV9Z+YhYXWrV2QSy1SQwiLz3dAv93GTU2CrEF4OYgc3tggotdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GsbegswW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LEdtzhfyIJj92O4o3FcSBjh2+mwuK1/qe0uMyrqyOKg=; b=GsbegswWZrPbuZKSkgX77DTP2J
	28oOmomCr62sc9HoSmV9lrREnJxvJ4g76kLcH++uzeNj1CQSuEj7UxNcUT1z7nKFDXLNlvmxHlZMh
	iqUlWa4cTWUTsn6RED+kSuoswtymNL72HjLJ2FVzUUXybKxX79utaRHpITag/xRCZO4kvLSApXlYl
	sUTpoH33BSvYgdDe1zpTB2Mod6gXTw+OO+BOZNf4P5SjohNh5FQf9KjDdAgWQSSNpmoG1qiWUoVmt
	7+diAcaYOpZG5ObgZW8mcnI9L7fdGu4gpA6begU2lMvQB2BIW4nkDKJYtADIBzLgYL+3Sa/s//s7w
	YMhpiF5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tG1WR-00000000OHJ-1PEq;
	Tue, 26 Nov 2024 19:46:55 +0000
Date: Tue, 26 Nov 2024 19:46:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v5 4/9] binder: remove struct binder_lru_page
Message-ID: <Z0Ylr1cJ2AZ6rcXO@casper.infradead.org>
References: <20241126184021.45292-1-cmllamas@google.com>
 <20241126184021.45292-5-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126184021.45292-5-cmllamas@google.com>

On Tue, Nov 26, 2024 at 06:40:07PM +0000, Carlos Llamas wrote:
> Remove the redundant struct binder_lru_page concept. Instead, let's use
> available struct page->lru and page->private members directly to achieve
> the same functionality. This reduces the maximum memory allocated for
> alloc->pages from 32768 down to 8192 bytes (aarch64). Savings are per
> binder instance.
> 
> Note that Matthew pointed out that some of the page members used in this
> patch (e.g. page->lru) are likely going to be removed in the near future
> [1]. Binder will adopt an alternative solution when this happens.

It's not just "near future".  page->index is going away if not next
merge window, then the merge window after.  page->mapping is going to
follow it, and page->lru after that.  Please find another way now.

