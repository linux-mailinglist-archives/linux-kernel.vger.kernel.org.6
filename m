Return-Path: <linux-kernel+bounces-538415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F074AA49857
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DC016AEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760AF25D1F5;
	Fri, 28 Feb 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nzweEyOB"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD31D5CFA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742328; cv=none; b=b1T34zpH+3tBeS0q0XQfaa42bgo1u6NpUTpaQxXbzWpPzdGQgLM4PsaTVNYTE1djQfrw71yWCg0FFqT8uJsQX/006F0DRnpwryJfwCt5CJ8qjgIdEVv8y/YgqegdR/N9QOSmvtT7EOTBxlhsV4hYHT3QUBSCMETDxOmTxPkdy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742328; c=relaxed/simple;
	bh=XKAV4/E1+is1J8a/5HPRUiraTYH/wEodr2IoF9LyrXc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH39K8Xs8GGQ232699JcOO+ri21Fd4B1zzBRhhKBIvjgHLXteTyIjm2NH1sudsSlpYIeqNS9nTpD3Ua49ymlRWCVr8paIBF7dxyrgvGyRdW7kxgFkTxjBq0LVw8pemARrEGataFjQlkAU9XLZYNzYg1vdzNYWwdo6AaqJW52Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nzweEyOB; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740742319; x=1741001519;
	bh=WnuT1lp+dEjui9s8JRMd2CxOSptWUukiYdlX90A/SL8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nzweEyOB65w0CUoEAmf8Kp9DIVwwyrvkN73tjaoaGx37fVwZHQuTwfVMnOfWZZ83k
	 LgiuZSMmTGSJpRKtN8JRj72JB6qmII5IA4dk3CgOohhiFeCXR2W+oau5j8Z7gHwAor
	 BQNl6ap99o5BgskhP4lvv92PeKAKH4L/9II9Of7UhY4kwuhgvhvIi+yZSddVSJ3uF3
	 ibfAq2CkA0cMJlAqeGVwE/M3vFms1eucY+O+K+SODBlLKLUghtuvqjS3VEb4HaiOt0
	 5LtQsUuQO4CvDJpcr0/OhaGe1RBjPqXla39/agU2LSTYs+oUNG/B5oQF0F7l1f7uop
	 v5G+ArcAG7Prw==
Date: Fri, 28 Feb 2025 11:31:53 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] Rust: Implement a unique reference type URef supplementing ARef
Message-ID: <Z8GepRBy6rQtTqh5@mango>
In-Reply-To: <87wmdamiik.fsf@kernel.org>
References: <jeyp4dToznpiAQYWHAABrEBIHVfxaIf7ntexop3d2AXQgnlytw3J8YFkX8E8EFKc1-USf_fVZqKhEmuNGE3O0w==@protonmail.internalid> <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid> <87wmdamiik.fsf@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: e8b37f6015c1c6870e1d3bc1e0e2a0186c0198ab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 1210, Andreas Hindborg wrote:

Hi Andreas,

> Wrap at 75 characters please :)

> See `AlwaysRefCounted` for reference on formatting.

> Please use back ticks for types: [`ARef`], [`URref`]

> For your next version, can you run `make rustfmt`?:

Sorry for all that. Apparently I need to get used a bit more to how things
are supposed to be done here. Please be patient with me for a bit :)

> When the trait is unsafe, we need to specify the conditions under which
> it is safe to implement:

Of course. Sorry, missed that.

> I would prefer `UniqueRef`. I know `ARef` has a different naming scheme,
> but I think `UniqueRef` is sufficiently short and significantly more
> descriptive than `URef`.

Ok, will do. Honestly I also prefer UniqueRef.

> Also it would be great if you include your "rust: for fix dec_ref for
> URef<Request>" folded in.

Are your sure? Wouldn't the patches have to be ordered like this?

    this patch (mine)
    rust: block: change `queue_rq` request type to unique (yours)
    rust: block: simplify reference counting scheme (yours)
    rust: for fix dec_ref for URef<Request> (mine)

IOW, the latter requests depends on the 2 patches of yours, while these dep=
end on this patch. You know what I mean?

Best regards,

Oliver


