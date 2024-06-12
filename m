Return-Path: <linux-kernel+bounces-210768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED64904877
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA757B2194A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95432AD5C;
	Wed, 12 Jun 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSmNs7iA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939F5CAC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156133; cv=none; b=DBP0SrkeaG6Ynx89IaZV3U6fzXLqeqCpyICpfhpYdl4Lq3U7+NXj2uhFbvbvDEfV7K09vmKbWdnRXp7chbeMqnPofiUu4+xPbiBOtwJXzKEAGYiz2DaBvW7jq+wwJxDi5l8mJJf4wrramtnc4EZHi5JWemROof6W1VRXrgsNe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156133; c=relaxed/simple;
	bh=SUbo+YKohnGRExDlaUfo3uU9lbahumsxOGb28uZaVjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9BBMNCQ/rJgix3te+86bnmM+H4no+YkryiNxVfBUFe907snUAYVMlXSA9EcAOSKlghkw57n4ckmDcg0L+WxiD656y1o87bQQACdKtJv22ihjNxYunwGbfLRbJw/9HnIUk9+zxbECQ0PsNmc8+yzQxX/GX+daTcoG85/Cvr0FbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSmNs7iA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718156130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0W3paLQyIxFzIGzA0UJ1JuvvuAzjNLrCVraVK30gc4M=;
	b=hSmNs7iAjgzL7ojJsQETpy+f8MhU0Hidz/i4CdUxUK/y7W08m/8VOqWG5kIeOx4HPthFj+
	6VlyrwFhjOs/Nv8w71OCeTva4r/LGSGHYCJ8ID3TbWs4UQHaFELKLwEglFSDi6rTVQ+Xsh
	ZPRNaUi/i0sq25BzNpRX1sYyjQzQTlc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bskaXANhPdatFIJltRdnQA-1; Tue, 11 Jun 2024 21:35:28 -0400
X-MC-Unique: bskaXANhPdatFIJltRdnQA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62a083e617aso33644697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718156128; x=1718760928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W3paLQyIxFzIGzA0UJ1JuvvuAzjNLrCVraVK30gc4M=;
        b=XFlzS3taJ0hJ1qTCeog8yH2UyGnJqc7malc8wCITGl/BF8WqwJRI4aenilnfz8p65i
         NBgavvtjfWpaa9DbLiIhitm65Hk7qz5C8aKW1a6SqDubXMMF7VSgRjEwwhtf8nLLi1xE
         J9wT8gaAKfn8bLDnVCn6RPTFx3G3ObaIPoWjDt96/0Px6pALKKYrxYtXAmlulfdd9Qok
         hPgRrqWruodvR1vYAS1Zl/FzpoCnZlDb7B6TjkztXpa7FBtc4mvcq/glzcTS0uJyJduz
         x82CXsx1wryjRHl0bc3OaupMDxXrJesDiC8oA7x2NGb8tXoFJcY4hVxpBybdx5FMFufb
         7ljg==
X-Gm-Message-State: AOJu0YyDaIdfuXmC7S11iYJKgzCasmXOkbwZpz1oG9ZATEeUeD9Ml9EG
	7iK2ofrm2BBIqzrKtCKMNctvcmTnDVfzKdnIwOl+jmSShxiV8gFjLMS2ks+2/MNZoK4ReC93vNS
	k9q0c1lEXoY/IoN1w1pwkkzrs7hupoL4NXa//Noj7lWdjpFld5xyyRSjdsSKAoQ==
X-Received: by 2002:a0d:d403:0:b0:62d:a29:5384 with SMTP id 00721157ae682-62fbdaaa65cmr4151697b3.43.1718156127853;
        Tue, 11 Jun 2024 18:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjmTTt67EgNF2LKxAS293dORd45vdPlnfDq/IczAzWnFhn/SbC/sQEGoRMtkW7fUqRC/2aTQ==
X-Received: by 2002:a0d:d403:0:b0:62d:a29:5384 with SMTP id 00721157ae682-62fbdaaa65cmr4151637b3.43.1718156127487;
        Tue, 11 Jun 2024 18:35:27 -0700 (PDT)
Received: from x1-fbsd.aquini.net (c-76-152-42-226.hsd1.nh.comcast.net. [76.152.42.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b093aff889sm4361476d6.101.2024.06.11.18.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 18:35:27 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:35:24 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-ID: <Zmj7XAF5EcF40glG@x1-fbsd.aquini.net>
References: <20240606170026.101839-1-aquini@redhat.com>
 <20240606180622.102099-1-aquini@redhat.com>
 <20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
 <ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
 <20240611143239.ab8e4d96289a748ae1f8a480@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611143239.ab8e4d96289a748ae1f8a480@linux-foundation.org>

On Tue, Jun 11, 2024 at 02:32:39PM -0700, Andrew Morton wrote:
> On Mon, 10 Jun 2024 14:45:28 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > On Mon, Jun 10, 2024 at 11:11:39AM -0700, Andrew Morton wrote:
> > > On Thu,  6 Jun 2024 14:06:22 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > > 
> > > > An ASLR regression was noticed [1] and tracked down to file-mapped areas
> > > > being backed by THP in recent kernels. The 21-bit alignment constraint
> > > > for such mappings reduces the entropy for randomizing the placement of
> > > > 64-bit library mappings and breaks ASLR completely for 32-bit libraries.
> > > > 
> > > > The reported issue is easily addressed by increasing vm.mmap_rnd_bits
> > > > and vm.mmap_rnd_compat_bits. This patch just provides a simple way to
> > > > set ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS to their maximum
> > > > values allowed by the architecture at build time.
> > > > 
> > > > [1] https://zolutal.github.io/aslrnt/
> > > 
> > > Are we able to identify a Fixes: target for this?
> > >
> > 
> > Sure, it would be:
> > 
> >  Fixes: 1854bc6e2420 ("mm/readahead: Align file mappings for non-DAX")
> >  
> > > I assume a cc:stable is appropriate?
> > > 
> > 
> > Andrew, I admit I was somewhat hesitant on adding the Fixes: and the stable CC
> > to this patch because I didn't really think of it as a "fix" for the given 
> > commit, but just as a simple way to toggle ARCH_MMAP_RND{,_COMPAT}_BITS 
> > to maximum allowed at build time.
> > 
> > I don't disagree with doing it, though, if you think it might be appropriate.
> 
> Well, "breaks completely" is motivational!
> 
> But does the patch fix this, by default?  Doesn't the user have to take
> some action (set FORCE_MAX_MMAP_RND_BITS) to fix the breakage?

Correct. The patch doesn't fix it by default but provides a way for users
to adjust these settings at buildtime. Users are still expected/required to 
take action, though.

> Shouldn't we make this the default (at least for 32-bit) so the
> regressed kernels are fixed simply by applying this patch?
> 

That is a fair take, indeed. I guess we could do something like

 config FORCE_MAX_MMAP_RND_BITS
        bool "Force maximum number of bits to use for ASLR of mmap base address"
-       default n
+       default y if !64BIT


> > Lemme know if you want me refreshing the patch to amend these bits.
> 
> Is OK, I can update things.

Thank you!

-- Rafael


