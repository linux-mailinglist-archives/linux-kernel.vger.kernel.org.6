Return-Path: <linux-kernel+bounces-524829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74318A3E796
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F2F7AA7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E408264A6E;
	Thu, 20 Feb 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THyuoZEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE91EC01F;
	Thu, 20 Feb 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090932; cv=none; b=RMexlEA2KSCT2Fw6zl43d0NRxfFBt10C78+U0O7OEsDEtz2mH6jqsxFNH1YhfvrF2L23XuMSuN1Vy60KIP3X8MnHUFwTJwiOmRXmZ/Jth0mmZhPfvQomMisQwZcro05MhO9tf2h86errNaEwSnrTTYjgWTGg68B1YtHcB4JhiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090932; c=relaxed/simple;
	bh=4OJg0oQ7N4XigOkvF4kaDEF/g5zSymWc9IjT0ma+hQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPIZzmIeb+BvGXZSFYjFsDSDGD+2fYEFopfV8O+LVDarWuH1xPjWPryx/ak62DFztU+lHHKRGMt04qVFfdpY/v+ndV+iDsAocTJFB+7zhyf2wYlF3o+NIxV6GwvCoUMHPBLY7ERz4q9jkc+rxzdF72vMy9PddsTtxzwnZnS5d9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THyuoZEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE39C4CED1;
	Thu, 20 Feb 2025 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090932;
	bh=4OJg0oQ7N4XigOkvF4kaDEF/g5zSymWc9IjT0ma+hQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THyuoZEHpLqWtVOC9CsvbfbVFtufYSHgkiq9Ic/LvkfTQt3N+EbWOwXhTYnfY9PcW
	 3RMnSOij/q/EA4ubIop/D9NlptpCyC3aG0LVUaD3JHsZ13HktVKLgft+op/Nm9MgxB
	 LytONxyOpCBd0zuKX38NUZEyqfJMUXO0KOt5fhhhNEHIrd3Radn1RO2DD6CuHmKk0+
	 jMsLEOxYZdtiJSmD83sYhA8/t/4JnZF/pqOj2GW2emz/DcWcj+8bzi7czSXyxyBC7X
	 nlm2A6YByIB57oh9IkMspEp89dhBlkWGMgjfBeuPAtYIdDMgcwwXkJ3CilrG9o5z0T
	 3WuRHmAovUozw==
Date: Thu, 20 Feb 2025 23:35:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
Message-ID: <Z7euMa5zYgHvWBsY@pavilion.home>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>

Le Tue, Feb 18, 2025 at 02:27:05PM +0100, Andreas Hindborg a écrit :
> This series adds support for using the `hrtimer` subsystem from Rust code.
> 
> The series adds support for timer mode and clock source configuration during
> timer initialization. Examples and functionality to execute closures at timer
> expiration has been removed, as these depend on either atomics [3] or
> `SpinLockIrq` [4], which are still being worked on.
> 
> This series is a dependency for unmerged features of the Rust null block driver
> [1], and for rkvms [2].
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/log/?h=rnull-v6.11-rc2 [1]
> Link: https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-wip [2]
> Link: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/ [3]
> Link: https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/ [4]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Let me repeat again that I have extremely limited understanding of this.
But let's say I haven't spotted a major issue on the interface...

	    Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

