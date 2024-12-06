Return-Path: <linux-kernel+bounces-434521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C109E67C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD121161670
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB841DC19D;
	Fri,  6 Dec 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9mEJg5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F4190470;
	Fri,  6 Dec 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469601; cv=none; b=B/Gso+x18kXS2a8GPj5GedrE+/dOfDG/D2ReUJdS7h0hDFeUKC0tk55IR728LOH1IWR2uqtObIUXcplu8HPK2IwrEbYD1D131fjt0SLdU7u0uFNIkqNvWeZe9ALszQjDJ77pnkOLowhOJahhAFFR55PDREFs0LbkL7YWToqnzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469601; c=relaxed/simple;
	bh=e5TxYok6IUf3ZHHSebSMjERkd9UF0ZEjLA0iPNyi4+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWyChTfNzJV+KTzByV4IJw9aGZsUHQLI8DZXYG6+CuFt2Tj7AadHwmSO7Glfl4c+mGPVZcOBoZBNpyvxfgyW6aoK5gLEDbCsq+cfBaVNGcB0yx/eTsdeB6vS4g+jwkWxpF5bPmYF8ao7gU2KoI5wr+a7TB+q7naSb6B6BN4jEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9mEJg5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99977C4CED1;
	Fri,  6 Dec 2024 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733469601;
	bh=e5TxYok6IUf3ZHHSebSMjERkd9UF0ZEjLA0iPNyi4+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9mEJg5t0PcL/Ndszs1OM3lquWh4oYYZVjJPMMqddjJfaKvdj+4P22/TCZJil2pEM
	 oTYN8HFp/Y1xVsr/Dd4TwLWrPfWF9eAt4Y00a1+nkfaqESxzp1Ynk3AvikS9Gz5Csd
	 Q8G6teoNienbjPB/2lSejxzdscBG25icS1cIjywE=
Date: Fri, 6 Dec 2024 08:19:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <2024120632-hardwired-hardhead-1906@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162531.1883859-1-lee@kernel.org>

On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> It has been suggested that the driver should use dev_info() instead of
> pr_info() however there is currently no scaffolding to successfully pull
> a 'struct device' out from driver data post register().  This is being
> worked on and we will convert this over in due course.

But the miscdevice.rs change provides this to you, right?  Or if not,
why not?

confused,

greg k-h

