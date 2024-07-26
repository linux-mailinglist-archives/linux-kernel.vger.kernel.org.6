Return-Path: <linux-kernel+bounces-262843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329893CDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28671F22630
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAC3A1DC;
	Fri, 26 Jul 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xq4meg/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43AA34;
	Fri, 26 Jul 2024 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972365; cv=none; b=JEw0q3RDW7OrWxJdDPUFmcxHJ2yMpO2CfwTpVxa1+o2Uh/lack1aaM3nD93gntLIxo/Q7L+SGF7b2gzqMn1zqnEy2OpHIp/I6QxThDsEUxh+izvahFx2hQkqDDWIawOvsd2QJlMEvnrctlpSloap8HHKUlo7lWTU7nvU48MM/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972365; c=relaxed/simple;
	bh=JRVYVNBUG+zgdWMbHTC0PsFOiJ7UtAmU7KEE7HY0g7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkMCXOFgHm0LUTZvFKGqA2zrxbpSMLamiNUhlZBULceGiKpD1dpytaXiQSQvqkyIAYq53S/0CmSklgAItSA1Z66d3+kZp/pkaWq6oUxUo7cFgJqIOE+cR2k1qYM3f/2VXkCVn/Vqpd/gXkTAssa47Nql60ORiFpgt17bKvXeG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xq4meg/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8810C32782;
	Fri, 26 Jul 2024 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721972365;
	bh=JRVYVNBUG+zgdWMbHTC0PsFOiJ7UtAmU7KEE7HY0g7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xq4meg/Acb2ZTdSB1geTsbaLOae9gExpapRqPMDUDl8+Aodg/amZaivlLKCutQrjH
	 yJx0fKxC5b90Ie/GQ3S5tXrFlnttKxDkvKFlPWXKVsuR3D/C8ET0xp/hNUyAAMrSri
	 V/ranR4gZ8OyA3+qI0MZ/PelGy/829foydYwNTTc=
Date: Fri, 26 Jul 2024 07:39:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <2024072609-oncoming-scrunch-97cc@gregkh>
References: <20240725222822.1784931-1-lyude@redhat.com>
 <20240725222822.1784931-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725222822.1784931-2-lyude@redhat.com>

On Thu, Jul 25, 2024 at 06:27:50PM -0400, Lyude Paul wrote:
> +unsigned long rust_helper_local_irq_save(void) {

Nit, the '{' goes on the next line for a function declaration in C.
checkpatch.pl should have caught this, right?

> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	return flags;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
> +
> +void rust_helper_local_irq_restore(unsigned long flags) {

Same here.

thanks,

greg k-h

