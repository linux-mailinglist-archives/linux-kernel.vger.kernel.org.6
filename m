Return-Path: <linux-kernel+bounces-526942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCCA40569
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D967A9D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239C200130;
	Sat, 22 Feb 2025 04:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFiMixKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655742056;
	Sat, 22 Feb 2025 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740197754; cv=none; b=kz3+TlGFTrX9gT76gS/92b4T/NRy5s/sjsIUi3n3x8qrT/AwJ0Vsz5t4h2WVv5aH97Z47mbackO9OaIscwBY3RvREgHlgKUPkHU1vVtmi8A/1Ai7MHFrcsph8CA5GxIRf8MVaodi9sXi0oU9T8vN7PRhDIMAYpv2GTY70huXPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740197754; c=relaxed/simple;
	bh=b7GfZVqCRhoo2YiBZC3bMTnTDWqBFTfV4/SwsxGvyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIlzGG8vVxf/OnebW7L3VXS/9iCjKIoC86krWUzMx1hStZLBjvPlFj6gH5rkFnI7vO2Zi/jolYyd5nTuuzZCVqUsmUsCvG+Bj7Edp21VZJntHm3V+91Ar7mlPlP6A0/KNTvh6Ab5riwM/zjYgf5t+FK1ruC5tO0/jlSmNMFbfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFiMixKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3691C4CEE0;
	Sat, 22 Feb 2025 04:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740197753;
	bh=b7GfZVqCRhoo2YiBZC3bMTnTDWqBFTfV4/SwsxGvyac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFiMixKH8ctM6uKAfkDmQrd1pCRKTfPZmEAG0Cn4ebfzejyH95cCWujgkkVQT+YjU
	 NsOvVCltar8ry74Di/UcpRDiMhdwG6vebDIoEpzwfbbT5q4b6ALq98Wqrq0cJXiwHA
	 4DvckMGvyGTH+41jyvWTGAO87kT0eTKVbITuct1uZ5PSrWARWBZNGCP9PO/Qs9A4xg
	 h4AYC57d8230HlG+4hy2aIts/R5oFi5Oo5mPrI+PAcg48m7zcfA1mnTy2aZ7u6S71r
	 BQQJvtj4iFZMdlnEPg8xxuovPErDY6KLLdyEwXONiVlPXlnNtd0EEdCjw2XeYIbsY3
	 qR+jiNt+uTGsA==
Date: Sat, 22 Feb 2025 06:15:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
Message-ID: <Z7lPcy6mgOVSFhZr@kernel.org>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>

On Fri, Feb 21, 2025 at 05:35:31PM -0500, Hamza Mahfooz wrote:
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Just getting familiar how code testing and reviews go with Rust code,
as I might put out even a driver at some point of time, so let's give
this a shot :-)

Using 1st person plural is usually almost a cardinal sin almost and is
somewhat exhausting to read. "These methods" refer to nothing and the
commit message does not educate me why the accessors are needed.

It should be IMHO language agnostic that commit message is more
important than the source code. It weights now even more than ever
before because it is also AI acid test. The current commit message
is as good as it did not exist at all.

Based on these conclusions I'd start the commit message by saying
that "Provide safe accessors to the workqueue bottom-halves."

Then add another sentence on why they are required (i.e. who will
be  the caller for these).

BR, Jarkko 

