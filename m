Return-Path: <linux-kernel+bounces-337550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59F984B99
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A895281943
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0213A3FF;
	Tue, 24 Sep 2024 19:31:16 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8E137775
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206276; cv=none; b=iGyILDru1vZpYAJdJZKbTTFCfoGsRT0rD1f990Vi4Wgg8s5/Po5gLL4C0SEKNKl7y8xMCqr5RQFZ6wy13bMB3QgkIwr8LaoGGc8UzZ1hhlfSaLparOF6VdacRaSnu5h3QvZb6+VBgOisSt+vPPyg0b+hbjci/fVhMmAi8YT21zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206276; c=relaxed/simple;
	bh=uuVl6MBaXlHZbPcy1TEcgr1GjBMcSriG1UXSxHvSc/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l415uGTsMSsaUe+FK71VKvAaWm9MbFROnndq79VxhZaaknHo+fqBP0rDnzBd5cT5+YHIJk1x5B49RzXqsK5vWKM6UP3BMH2gA8+NSjJJa7e6xxSoAiBGP5BqirD79SN9q7o3iWPS+gJOpGETshjOZ22XpMEmmCnbqI7A3rsn9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2EEB292009C; Tue, 24 Sep 2024 21:23:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2083292009B;
	Tue, 24 Sep 2024 20:23:21 +0100 (BST)
Date: Tue, 24 Sep 2024 20:23:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: David Hildenbrand <david@redhat.com>
cc: Guenter Roeck <linux@roeck-us.net>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
In-Reply-To: <65959acc-c59b-4aca-8ab4-5d0603d22110@redhat.com>
Message-ID: <alpine.DEB.2.21.2409242018160.3358@angie.orcam.me.uk>
References: <20240923235617.1584056-1-linux@roeck-us.net> <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com> <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com> <bf98fa37-461f-47ce-8d4c-bcb69f225a9c@roeck-us.net>
 <65959acc-c59b-4aca-8ab4-5d0603d22110@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Sep 2024, David Hildenbrand wrote:

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09aebca1cae3..4c9f5ea13271 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -595,6 +595,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  config SPLIT_PTE_PTLOCKS
>         def_bool y
>         depends on MMU
> +       depends on SMP
>         depends on NR_CPUS >= 4

 I think it might be more intuitive if written as:

	depends on SMP && NR_CPUS >= 4

(with a note in the change description to the effect that NR_CPUS will 
have been unset and the condition won't work as expected unless SMP).

 FWIW,

  Maciej

