Return-Path: <linux-kernel+bounces-220106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587B90DCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3ED1C23674
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706801741CB;
	Tue, 18 Jun 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxZL/P1c"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78616EB4F;
	Tue, 18 Jun 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740044; cv=none; b=RX4r2qMh6hMD65Wj2brngxOwRhE1sRJBN4dGJBXQ8uTjE/3bD6oajpwBNlGG62UzcEIxYHzscr5Oc0RZfTh4hVMtYlwXrJsEQ9J7z01dYF9LgkYYgTXXD344vaB/dMfvesz0myF52rcaIxI3CVDYBXIUFWnSvLl+1wVkcrfnAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740044; c=relaxed/simple;
	bh=8gdDcCSe54P4+dfAmjsoie/lp6JWaQijac5rE6M1Yrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PihvBhqFAkdjsLcd0hvO3EusdoGH6H7r6prYMx5ZdUrnpugsFYF2c7c04JEcoUROIYoBG3CG3YfmRUBhP4h1qrqJ9qgr+Uo1B+kL7/16PEzI1a0B4QCdEgGNAQd99yo+2RA8clu/QIOlcfoi2rlRHPUExzC8RyleqrYKpo0o+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UxZL/P1c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3yahc90eC8bxYCtEBBBBSEKm40YkQsH0tBXadWSmuT8=; b=UxZL/P1cRCZ0pq0xRWUE443SuO
	qEQ3V4hSp4ZTJ4eNhYgXU83MMW4+HNYhXxfW6llwCsgmshno75ATXFzUFFqaczzh0YRT/dGoq5RYO
	baOGT0vF7WjnqktnrbADs2v9CbZWYvHo1Q+1bHcAkUsrqNWgQnfe+sZcDQO/LI7tuHLVJlI+QbT+b
	YXygbZCT6j72wTc2VdgQs7oPjA2IJHZTHSMEjz5tT3mHvJGLbR8N7Z2XIrktd0OxCp5m+XMrb+Zkn
	LoUF9kAJRAdj+TmxScM3rZlgmRn/ioxS10i2g2I9XIe6FX/YtWAtajS0cMjfXgu6MVC3sK8DnWIvF
	LNfvWERA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJenS-0000000GOqt-3tAP;
	Tue, 18 Jun 2024 19:47:14 +0000
Date: Tue, 18 Jun 2024 12:47:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
Message-ID: <ZnHkQpyiX4UKdLEt@bombadil.infradead.org>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617203010.101452-3-dakr@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Jun 17, 2024 at 10:29:41PM +0200, Danilo Krummrich wrote:
> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
> 
> The firmware is released once the abstraction instance is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

I don't speak Rust, so if we're gonna add this, I'd just ask you also
become a firmware loader maintainer, willing to spend time to help
review both C and Rust code. Is that too much to ask?

  Luis

