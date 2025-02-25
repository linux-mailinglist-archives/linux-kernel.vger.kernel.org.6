Return-Path: <linux-kernel+bounces-532095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D0EA44901
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4879B8824EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE451A8F95;
	Tue, 25 Feb 2025 17:32:16 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A18C91F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504735; cv=none; b=ebwLXQoRa670NTpKRWMJDQPmZn0XH6pa6nqoW9vWQU3BDU4IHjVtfX3MR0giSQa4FVPeVKiifOfhqDKr7B3w2tkxzv1++sA9AkvyiuKdsYpZzDuFx8rDMxlC1oqvETUVwnsrvbMVjLkJhEbyHl5bCLsYT7YZo0Y64yw3dyl5eVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504735; c=relaxed/simple;
	bh=/px6YTPNN3C+iqrbhPzASwpTLJh6IQkRT7RPVBXwWgo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bVmdoX+ZfN7uCZnZ4otdBqsV25cQP4LQXhfjfG++wtVBCfatpiJG+pdToex3KNos1mXGlHDQdOLeC0EnqvjGyBX5028yoscbfVrNwFQw/Sg0P0FpcpVE3rg47Os44+tfIgI91nMZxa4OzPBlNyLVki8BWIM5MS6FifGK8QaS7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3AC7B92009C; Tue, 25 Feb 2025 18:32:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3651F92009B;
	Tue, 25 Feb 2025 17:32:12 +0000 (GMT)
Date: Tue, 25 Feb 2025 17:32:12 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't use %pK through printk
In-Reply-To: <20250225091250-eac544ad-4e5b-47f7-83fc-5212c720483a@linutronix.de>
Message-ID: <alpine.DEB.2.21.2502251654370.65342@angie.orcam.me.uk>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de> <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu> <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk> <20250225091250-eac544ad-4e5b-47f7-83fc-5212c720483a@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Feb 2025, Thomas Weißschuh wrote:

> > was suddenly lost from the kernel log, the access to which unprivileged 
> > users can be denied if so desired according to the site policy.  Whereas 
> > running the kernel such as to have all output from plain `%p' exposed just 
> > to cope with this proposed change, now that seems like a security risk.
> 
> Your point makes sense.
> *But* the addresses in your example are already hashed,
> as indicated by the all-zero upper 32 bits.

 Darn it!

> By default, when kptr_restrict is set to 0, %pK behaves the same as %p.
> The same happened for a bunch of other architectures and nobody seems
> to have noticed in the past.
> The symbol-relative pointers or pointer formats designed for backtraces,
> as notes by Christophe, seem to be enough.

 I do hope so.

> But personally I'm also fine with using %px, as my goal is to remove the
> error-prone and confusing %pK.

 It's clear that `%pK' was meant to restrict access to /proc files and the 
like that may be accessible by unprivileged users:

"
kptr_restrict
=============

This toggle indicates whether restrictions are placed on
exposing kernel addresses via ``/proc`` and other interfaces.
"

and not the kernel log, the information in which may come from rare events 
that are difficult to trigger and hard to recover via other means.  Sigh. 
Once you've got access to the kernel log, you may as well wipe the system 
or do any other harm you might like.

  Maciej

