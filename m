Return-Path: <linux-kernel+bounces-414876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D489D2EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5373B304E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241D1D0426;
	Tue, 19 Nov 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9vMN8Lv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299431CBA1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043454; cv=none; b=XFQ3Reao2k2M+Do/DrwsRcbIvuP5wTBy0I7Wa6wZbEdu00GuB7j8B495nxZTm1QSt3MzVzRhOW6C6vAwU0yCRXDT3sS6PZgGybW3RCw9lyB2wcPW7sTJXUbupfFqSKuDoE+eZHiTUpVIdF8o9n2iueiFdnAQYAVv07dh3VSaqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043454; c=relaxed/simple;
	bh=G6qGdxyzfXX33Pecg24ErTmb30i9GSMGGH474x4iLJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puloj2zxrj7EFW6Fl9V19dbEroNkPYoidrSHo8Eu3ZT0oNq+r4xVRsTyXBx1vk5Y2d/igeSqJiSK9GYIoyqQPmOqTbNNmG8cv0UA2yEDPu3CLMnsUa08T3BsD38GGeZ13Cl6Kj903YTYkW/UKQTsDjvKskHa2rWHSRFx5YY+XbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i9vMN8Lv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Adnyhvvt0aiRqQsOwzy3kVOOtWBzm811D3yr47i1vXs=; b=i9vMN8LvTVibzb3H4z4EwlCVbZ
	ik/WKAflZiwoOFEHPh2pQa50nIzbKIsGjM1q2dNpaK8WGNfKclqxtfIXIP9t4FThnlQTUQaJyA9r0
	w/MhhrMlEV7kRF8W8A9T5e92DKJAZRxpfqTuAMW2TZtADRnRauG3OZ+HtiCEBtFrg1DGoeDeg7uf8
	0tk5T+q0IO4apTqrk21TFNiXANpTINSioGZE+Jxqz/V+TVgHAZ+i+ylnTTTmgNNA4zyWjOvRoJ4u8
	9ddlcS4V+Zd1pLH3c74u+0xd4t7ZfkJLPW6NTZVfhE8LEoUl40DWI2JYSJEH3uth3kA4Y4knfhLQ0
	EnMBfsBw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDTcf-00000004QXn-2Jrp;
	Tue, 19 Nov 2024 19:10:49 +0000
Date: Tue, 19 Nov 2024 19:10:49 +0000
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
Subject: Re: [PATCH v4 4/9] binder: remove struct binder_lru_page
Message-ID: <ZzziucEm3np6e7a0@casper.infradead.org>
References: <20241119183250.3497547-1-cmllamas@google.com>
 <20241119183250.3497547-5-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119183250.3497547-5-cmllamas@google.com>

On Tue, Nov 19, 2024 at 06:32:37PM +0000, Carlos Llamas wrote:
> Remove the redundant struct binder_lru_page concept. Instead, let's use
> available struct page->lru and page->private members directly to achieve
> the same functionality.

I'm not entirely happy to see this.  I expect to start a patch series in
the next six months which will remove users of page->lru.  page->private
is OK for now.  The goal is to shrink struct page to 8 bytes, but I
accept that 16 bytes may be the best we can do.

