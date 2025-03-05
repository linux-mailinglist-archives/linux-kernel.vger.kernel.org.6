Return-Path: <linux-kernel+bounces-547905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F56A50F16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF45E1892EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A2206F17;
	Wed,  5 Mar 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WFl4/t8Y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371ED1FC7FE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215085; cv=none; b=W+8maSXMcImH6gW5oElvNrq/Px7/dM33QlAnHw71pGNzP4wrzHV+X8d9eEXGU+9pF6qk1V9YsXR2IURwPuZ0DjTAj6IQEt5ye9vl8MKcQUu1I/rtttqAXcewKVgZZcY9S1rHaUCubWcWxciP22y39d5gmjyKdsDlrmmEi3rH1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215085; c=relaxed/simple;
	bh=IceKGWqriCmJXvKeL3ksESOhM6RWnyRSW04aSL+8b6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFxFEDtq7spN9DFcteOYXS92LIlslhr4QNAtWjp8T5pXRX1/1i6ET69TCsQpJJVlZbJxnB0YlVkAUCItGFjpHqYhEy6cdfFloKnuEJRXRzQIN43RwnkJTfhIfeYtKySm5q9u25ChLKwrUlosrCw7x1ClgR+x81PghwE5VSZZamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WFl4/t8Y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E982C40E016E;
	Wed,  5 Mar 2025 22:51:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YNFAtB1aIkco; Wed,  5 Mar 2025 22:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741215077; bh=ChXxUsgwZ+3msiCpuYLa+cDwDjifwaKkx1Gfc+t4Pf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFl4/t8YOPBjAWRBJRzwhc6k87dk6YgUtfjvQQ4f3ePoCp49QEXy2csRztIplM4+g
	 eq9/A7qmROzYzazXvb0XJYmHDQv/Rj+PnLQKwq3nH2+/Lp89NOxHP1eljDT6CBFC//
	 mIf3sWFznEtGzPHvrOKlNnylICrqpsZMC9s7OvFJxqZ9zCRIxX5v2L74yiaBsabe3S
	 G68PnAumIM6eowkrYYNpuSa0uhK/eblOVMpL+L7NviRwpqwrZra/4R1olsBGTWT5so
	 OFR7jEyMmPCB+zJ0LM5wK0KSw+RPf/oqwLChsBjhxlIC1o7FZxZn5SRBjEHkK6eyu2
	 hgQq3T9bF7FCbtjo7vR8NeJ6FsrotGT/IbhCPa6kD/X0yT9ZEjkrYxm0hAzT4udN3q
	 SKz7vDAh3PPLcqeNnxtAVlpzJ50OVeqvm1dC9bjgIVW+H3OG2t2sh1uQ+7I0vYHoZj
	 1lkYxRGNbGpSW7A9Whvt64QBlVPSUnZ2dmI+EJBeIFGhEYCAOo74GJsaYZi+ZockJm
	 5iS62DNOCq+t/h2flK1ozrmmZkJ9nd3qJqeRRxKERTPWXEz9yKFAhVGDbBkMbzNteQ
	 /Bo8ZZmPRJYkNvnUBxWb+ARZgg0CAFZ5xfrWjuqeLGEuSSDSHcciDrfATuJXCzKRy4
	 9awjK50w4lFQ8ElUNKt1zM7w=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09AF640E01A5;
	Wed,  5 Mar 2025 22:51:02 +0000 (UTC)
Date: Wed, 5 Mar 2025 23:50:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Message-ID: <20250305225057.GBZ8jVUXJmIJBZwdgT@fat_crate.local>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
 <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
 <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
 <a6145d2a-e1a9-41b4-8017-5bbf37ec2d65@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6145d2a-e1a9-41b4-8017-5bbf37ec2d65@app.fastmail.com>

On Wed, Mar 05, 2025 at 11:45:11PM +0100, Arnd Bergmann wrote:
> There is a twist here: clang by default warns about unused const
> variables in .c files but not in headers, while gcc doesn't

What is the point of this warning, do you know?

Someone defines a const, forgets to use it and? Oh big deal. This should be
a -Wunused anyway, no?

I must be missing something here...

> warn about them at all unless it's explictly enabled, and then
> it warns about both of them. Newer gcc versions have a distinct
> -Wunused-const-variable=1 for the clang behavior and
> -Wunused-const-variable=2 that warns for both, so we could
> reasonably decide to enable the =1 version by default and
> leave the =2 version for W=2.
> 
> On the other hand, most of the users of 'static const' variables
> in headers are rather dumb and should just be moved into the
> file that uses them, or they can be replaced with a #define
> or an enum.
> 
> In this case, the only user is a macro:
> #define _PAGE_CC               (_AT(pteval_t, cc_mask))
> 
> so maybe '#define cc_mask 0' would be appropriate.

Sounds a lot better to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

