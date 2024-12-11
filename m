Return-Path: <linux-kernel+bounces-441644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9F9ED15D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298D328157B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171D1DC999;
	Wed, 11 Dec 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W/yDAPGK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704961494CC;
	Wed, 11 Dec 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934354; cv=none; b=eHN+7wxDLfZuQKwY5f0RCAbPrv9NmaW3unmfYdSN378gjKMfaKp23lYgSJOGYXuXJnRmqqcCNusE6DP9VJERqOlznKt3s1hU23ntLicvLV0IkcydwUIA2aFWEjYjDfwgimzRSxraJ73m5J/sXeo3fSUKlNt/7cYTe/GIyQEUwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934354; c=relaxed/simple;
	bh=BSb6dGpj8WEgGRm9wlpP29R54fLk0doksNHJLVXty28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kby0Yt5DXkJuL355evjtGFlLTvn2dZn43naOTdWK3NWWsBRXsNkGknp2XfhFIVjw7XU5gt2xM5g5Eco7Z089kcPDDi8JmRzcGJZRuoeWJ7bXZAVsdddSrAzBXNF9E1DryGhGvWrUoubdZaZLMIyo38eZrjQNk3QZx9OgxB0cjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W/yDAPGK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 369C2403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733934350; bh=avoV5jUxDsd818ed3tRz+JAdLeh3eZbJA2ARQYvnzoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W/yDAPGKbUu5MlNKMy6G1GewrP4A+I47oPyv7IUqC9KEzoTPKrNHFtkn4B4n1dZyM
	 1dDYkqVA8wlIyOG+6DbmgZEvbzpYyxZShNoVcQWMc+/BYWZIbFbJiqTctDwKTBLgZZ
	 wPNR2x5f6NJNLAOYARWoDSvaQzA9M3yPHguYQcYP02aLpY2Ss9bx37rusMejbZW3vw
	 GklMOYBMaoUHMEDk4vVn4ZkNO4V1bupQqmICG3+rDSean1nTLJ1rW3nA6IeZoQUvrA
	 VWlOz4pv+Bbfmeg59Fiy8uzzGFpuzMitpKCcgcFN1LQh8PLijFQV8GmNZ7vv6mxKW6
	 hZ1h+0S/6bFQw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 369C2403E1;
	Wed, 11 Dec 2024 16:25:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada
 <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
In-Reply-To: <ac6bb4a4-d57c-481d-93e1-e08ab9fd6bdc@gmail.com>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
 <87pllz2r30.fsf@trenco.lwn.net>
 <b7c99226-7c03-425a-91b6-c7969bdbb1cf@gmail.com>
 <87v7vr12qr.fsf@trenco.lwn.net>
 <ac6bb4a4-d57c-481d-93e1-e08ab9fd6bdc@gmail.com>
Date: Wed, 11 Dec 2024 09:25:49 -0700
Message-ID: <87ikrq190y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>> 
>>> Jonathan Corbet wrote:
>>> [...]
>>>> Ah ... I should have thought of that ... I'm glad you did.  I've just
>>>> pushed the fix out to linux-next, will send it Linusward in the near
>>>> future.  Thanks for fixing this,
>>>
>>> Your docs-fixes is based on v6.13-rc1.
>>> This fix needs to come after v6.13-rc2.
>> 
>> ...which will happen once the fix hits mainline - the *fix* doesn't
>> depend on -rc2.
>> 
>
> Well...
> The fix conflicts semantically against v6.13-rc1.
>
> I know you hate full rebuild of htmldocs. But I'd like you to follow
> the following steps to see the full scope of this fix.
>
>  - git checkout v6.13-rc2
>  - git checkout docs-fixes
>  - make htmldocs
>
> You might be surprised, but you'll see the following:
>
> ./drivers/dma-buf/dma-buf.c:1: warning: no structured comments found
> ./drivers/iommu/iommufd/device.c:1: warning: no structured comments found
> ./drivers/iommu/iommufd/main.c:1: warning: no structured comments found
> ./drivers/counter/counter-core.c:1: warning: no structured comments found
> ./drivers/counter/counter-chrdev.c:1: warning: no structured comments found

So I guess I don't really see the problem - nobody is going to do that
(except seemingly you :)

> Current docs-fixes has a semantic conflicts opposite to the one v6.13-rc2 has.
>
> I'd really like you to send a pull request that resolves the semantic
> conflict existing in v6.13-rc2, not the one that happens to negate the
> conflict on merge.
>
> That's the minimal expectation I have.
>
> You might wonder whey you need to checkout v6.13-rc2 first and go back
> to docs-fixes to see the conflict there.
>
> That's because "make htmldocs" don't rerun kernel-doc conversion
> when only the kernel-doc script is updated.  To see the effect of
> its change, source files with affected kernel-doc comments and
> "EXPORT_SYMBOL*" need to be updated as well.
>
> Of course you are well aware of this problematic behavior of
> documentation build.

...which is worth fixing in the build system...

> I don't mind docs-mw if you'd like to keep it v6.13-rc1 based.
>
> Have I made my points clear enough for you?

I don't fully understand the problem you are concerned about, no.  But
it doesn't really matter that much, I'd rather not have an important
contributor being unhappy with me.  So I've just pulled everything
forward to -rc2 and force-pushed it; hopefully things are better now?

I'll probably send the fix upstream on Friday.

Thanks,

jon

