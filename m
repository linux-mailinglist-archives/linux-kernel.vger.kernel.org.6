Return-Path: <linux-kernel+bounces-538463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F24A49902
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F83BCC48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600926AA8C;
	Fri, 28 Feb 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd2daEVc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B02528EB;
	Fri, 28 Feb 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745026; cv=none; b=IlcwOr1osxat28xeVnAIqLN/vGSkQGiJIMTsxSArJCgqwBD0l9NcJbqwdVnGJICOcIRn1Qxp6uru/19gXbgPrCWf2oBVmXcOSOu9jNbEWoWPdQe+ZF61C4BnvAw+4efT4I5RXNubHbCZyGVUDYl2Q2csXwPz5aHc3M3ryjBJiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745026; c=relaxed/simple;
	bh=Duc3LTiA2wcifNotLp2bQHF2mAJjeJGKFn3hYnPif5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvLZXUXZb+y4Zv7PeEsZk81yoOX/ceCDV6Da/LzRVh2L5oaSH+wMqBpdPFReiYntLLmRMAA5oDsdS0dB83b9rQzMLmKrDhUMAbMH0wf1BvX6gqGU1Y0aFY8zmsNrw71nvjtHiI0aCUHmolSz/D6iABVS/3xIe5rdwRCPTkPnUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd2daEVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B671C4CED6;
	Fri, 28 Feb 2025 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740745025;
	bh=Duc3LTiA2wcifNotLp2bQHF2mAJjeJGKFn3hYnPif5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qd2daEVcdYHgzDyTYv9omT5Uk1DPc4nRmFufArdjPNTnlZ5BawsUPYE4tYQfo1p5f
	 DxTefvh7SLpf8BDxTyKDN2uxfbFPG8hgxvYNVJ6hcGV9VDUqpaMAYFMJqslzMD58NP
	 k5m5x3q2xYdGF13UI3rw9bh6Z957WQ7OM8nX4DBIwjlXOsfcfSbt1q1TDsg0itqNgA
	 Dr27dlJ/Gf085upL+2zdmK+izP5FP3tKKdtOL/9Fsqp3G2DfRQ/WK8ic9GnuCCLqYE
	 uAPwNe3JMOdmYdV6j0hnUt5BqHAUVWzM6mGX7KxR6BRxTuTGgJtI30sHvmRrB0qPY7
	 uaNQLMsdEwALQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
In-Reply-To: <Z8GepRBy6rQtTqh5@mango> (Oliver Mangold's message of "Fri, 28
	Feb 2025 11:31:53 +0000")
References: <jeyp4dToznpiAQYWHAABrEBIHVfxaIf7ntexop3d2AXQgnlytw3J8YFkX8E8EFKc1-USf_fVZqKhEmuNGE3O0w==@protonmail.internalid>
	<SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
	<87wmdamiik.fsf@kernel.org>
	<Qk7ZuBkLLBGX2wPuhDmR6Zw50-_saYGW8nOwV2mkMohZkROTgTtm9xOWSPI4rwUxI7Ji6KdWIhEw20diAqA0WQ==@protonmail.internalid>
	<Z8GepRBy6rQtTqh5@mango>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 13:16:57 +0100
Message-ID: <87ldtqmfgm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> On 250228 1210, Andreas Hindborg wrote:
>
> Hi Andreas,
>
>> Wrap at 75 characters please :)
>
>> See `AlwaysRefCounted` for reference on formatting.
>
>> Please use back ticks for types: [`ARef`], [`URref`]
>
>> For your next version, can you run `make rustfmt`?:
>
> Sorry for all that. Apparently I need to get used a bit more to how things
> are supposed to be done here. Please be patient with me for a bit :)
>
>> When the trait is unsafe, we need to specify the conditions under which
>> it is safe to implement:
>
> Of course. Sorry, missed that.
>
>> I would prefer `UniqueRef`. I know `ARef` has a different naming scheme,
>> but I think `UniqueRef` is sufficiently short and significantly more
>> descriptive than `URef`.
>
> Ok, will do. Honestly I also prefer UniqueRef.
>
>> Also it would be great if you include your "rust: for fix dec_ref for
>> URef<Request>" folded in.
>
> Are your sure? Wouldn't the patches have to be ordered like this?
>
>     this patch (mine)
>     rust: block: change `queue_rq` request type to unique (yours)
>     rust: block: simplify reference counting scheme (yours)
>     rust: for fix dec_ref for URef<Request> (mine)
>
> IOW, the latter requests depends on the 2 patches of yours, while these depend on this patch. You know what I mean?

Sorry, yes I meant "rust: allow to override dec_ref() for URef's".
Either include it in the series or fold it in, whatever makes most
sense.

The request update can go later.


Best regards,
Andreas Hindborg




