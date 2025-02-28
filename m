Return-Path: <linux-kernel+bounces-538409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB8A49848
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1263B7832
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544442620C1;
	Fri, 28 Feb 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URdM1scH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA89849C;
	Fri, 28 Feb 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741959; cv=none; b=o6/oFrRMSRYjxl32IZ6nANktqYVUX3gNaOKKq4oy4WMUUOsEnlyNJyIAo+Mw+UC0g458nyAoph+AFP2ndphy4VBs1rkU7YdFT3pHEQZUG5+cyye0SMFUpiRbjX0/PxPVL6NZvM8/f1plcRpMu4UTTpfSmGDg5VVUSgFcE2BHBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741959; c=relaxed/simple;
	bh=/wwwD4wAjR3ByHttIHyxvekwIMoEdhm3ZV7AI0wUpbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pViqQBsrfWlRzbzMj/2KiM/15+WtHmXpkMt+RPN4cMEernfVrKzORfpvOsiOUY+xsQdCmEFB9jtjuN+HOvgPs8WwynN5xrA94BWEsL6ejkQJYG1YnfygRSX2ZrGZMwLNiCi8x/VZ5f9FST40vQSGv4j5ka2qFLrCUMJg/9qOYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URdM1scH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C59C4CED6;
	Fri, 28 Feb 2025 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740741959;
	bh=/wwwD4wAjR3ByHttIHyxvekwIMoEdhm3ZV7AI0wUpbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=URdM1scHahtWO3QBBpQQKXP8aa292GmHfLBTIR8Jat7LMGc9klINLL/Yqgs+YPkHx
	 YbA/O7nEpi/eSzVtzMzNK7hyp3wi07/usM7iZE5dlx6/HNDVraVArG5nTthMqgGXnA
	 4jo758naNUHVJ3HuKwN8F/pRlSkDZ81a8/6k8VwRgMLmgbi4nrfIy4SffQgAjc8qHS
	 tXUOw+7tXU3kIHr6ev25hsuqNovFDjiG18cY5KlKPlMgroUbRD2l7pYJpHyUqZdo9H
	 mjCG1DCSRw7FK4ixmmcrwLhV9GMlnE5fuvYYXlkZGgd0MzJ/1ij7ytXKPrW63SRU7Q
	 Zlqmt0PbC/Ccw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,Gary Guo <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,<linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
In-Reply-To: <87wmdamiik.fsf@kernel.org> (Andreas Hindborg's message of "Fri,
	28 Feb 2025 12:10:59 +0100")
References: <jeyp4dToznpiAQYWHAABrEBIHVfxaIf7ntexop3d2AXQgnlytw3J8YFkX8E8EFKc1-USf_fVZqKhEmuNGE3O0w==@protonmail.internalid>
	<SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
	<87wmdamiik.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 12:25:48 +0100
Message-ID: <87r03imhtv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> Hi Oliver,
>
> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>
>> For usage with block-mq, we found that having a variant of ARef which is guaranteed to be unique is useful. As chances are it is useful in general, I implemented it as kernel::types::URef. The difference between ARef and URef is basically the same as between Arc and UniqueArc.
>
> Wrap at 75 characters please :)
>

Also, be sure to Cc relevant maintainers and reviewers (I did so in this
reply). Use scripts/checkpatch.pl and refer to [1]. You can also use
`b4` [2] to get a lot of automation.


Best regards,
Andreas Hindborg


[1] https://docs.kernel.org/process/submitting-patches.html
[2] https://b4.docs.kernel.org/en/latest/contributor/prep.html


