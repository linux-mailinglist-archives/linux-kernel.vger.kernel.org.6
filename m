Return-Path: <linux-kernel+bounces-343042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A0989624
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449101F228FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AB17BED0;
	Sun, 29 Sep 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCYUOfH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F314287
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624376; cv=none; b=VWIO2OOEXviaIULStY2i2sOG7xzAggOMR9g3ZVmh593j7mK2MtX8fS34+ZsPid6CFEHKCE1uTilPfJmx6+VithP0+kTX9NW2k31dKCC+LAoa9UgYznNsMtLRq9g/MtJpKiNoqjMtUvBN8CsdxEUMCDcxwcs5O2afioQLR+2vs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624376; c=relaxed/simple;
	bh=4T0HyN4MREec+erQ9q48dRLyStUQuZD2fv6ixAs/t6w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FNSjmKA6djlroOAKa6GtyAfOn1IZPCcsDDQD3BiHvgwpQSV8YDN6XExOJBfYCbuCG4naksNBMpF406xx9RVpgzljMbsIRU5PpgOBwihYIoWe4jG9JUPYw8yg0EYtmkSAZLfIiQvEJ1qTajM9fU4MbXEKI7LXn+hPG0ELIKw9H7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCYUOfH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167B0C4CEC5;
	Sun, 29 Sep 2024 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727624375;
	bh=4T0HyN4MREec+erQ9q48dRLyStUQuZD2fv6ixAs/t6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCYUOfH33zc416rVcoLXT4B8TsSxswMFg+HZyADsTGF6rx30Iwxw59Xp1NAohvnAx
	 sBO9kiT5qAlfhr/1Wc+CrlRoCoK/HJ6S46Kxy8vgOrXsiTWxYLTbTXm2SZ24BNhWqK
	 fiGqYJQbGL+SCUdQmzmsw+wP6zM4hbtMSQCVGyCy84AunU5Mksk7l1kxGRr/EhdDg3
	 yxSQakTpScyCVLtat9RdJXdNGWu6NqSaJHs7q2yPxwsuprVbC7HgtBcbCi6qOTTEmE
	 +JdOddOgVYlU7a0DUCI1KkiQXvjF5LwP1nvQVudKdGU7t5ebQ5VCpWDxzrFQaiulaf
	 ZYfyjl0OSnSig==
Date: Mon, 30 Sep 2024 00:39:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, "Liao, Chang" <liaochang1@huawei.com>, Will
 Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma
Message-Id: <20240930003931.f1927079bf6feccb6627416e@kernel.org>
In-Reply-To: <20240929145000.GA8931@redhat.com>
References: <20240926162901.GA9716@redhat.com>
	<20240929223956.5043f74bc781a124e761f013@kernel.org>
	<20240929145000.GA8931@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 16:50:00 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 09/29, Masami Hiramatsu wrote:
> >
> > On Thu, 26 Sep 2024 18:29:01 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
> > > into userspace. On some architectures (x86) this memory is readable even
> > > without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ.
> >
> > Good catch!
> > I think we push this urgently and send it to stable tree too, right?
> 
> Agreed, can you route this patch?

Yeah, OK.

> 
> > Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
> > Cc: stable@vger.kernel.org
> 
> Will add this or should I resend with these tags included ?

No, but can you confirm this is correct tag? I just track when the
alloc_page() came from.

> 
> perhaps the changelog should mention that debugger can read this memory
> regardless of pgprot_t...

OK, if you can do that, can you add it and resend it?

Thank you,

> 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

