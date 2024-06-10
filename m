Return-Path: <linux-kernel+bounces-208763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB079028E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F941F22609
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6ED179A3;
	Mon, 10 Jun 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rsdyyyae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DE7482
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045136; cv=none; b=UCJf1VN02gRjaQByLyaDZl4kF2m+4jgtgugLJdNYuxsCGi4ANgFkF4sq2k27HuGTDL9HwtxTIAMhWy/L8NjtrNwXR2cqjp/BNWYFAbPhiDXvA1lIYulSR6lKAANM7USk+KD9ERilYxFD3vhwKu62PJxhVeku08WQplwLAI2j8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045136; c=relaxed/simple;
	bh=zaerCgMqV9eLjvZHNarT23uge6Y7hJ8qZGqzjwReQtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG+2L2NDzTyKN80+SzgVk+l1mq5ScLSTiDl8eBeQZwBiub6HGdR40PD0e1fqCIvwrOHmipCew6vHjdYPy5/Etl73xlai4cOTl9jtW1iNJOxc7lfbp2AbL0SafQ8KmZznd+t78Ajv07FQTCA5soZoGVGUL+WyIpQUn8GBvYSfqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rsdyyyae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718045133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fP1RdA2uZs/hxPpChvYu47ujLlyUngkgBww7nrjQRCo=;
	b=Rsdyyyae/3l6+snDWGZEpMN9UiO6b6de25Up5+D6vo/hSZ5ANgifWB7C3b84GaDsiIVVHJ
	lyHrqWyLjm6W5h9314B2katj/M++x/ps6mBXa36YWa5ZknQWN27HdUm1hVneNh56/Eaeze
	Ks5Xomb3nTb3RKdWgEmPt7rr9Ideseg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4V2mHmYkONuThNv9E4bz9w-1; Mon, 10 Jun 2024 14:45:31 -0400
X-MC-Unique: 4V2mHmYkONuThNv9E4bz9w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b07ef34bfcso20416536d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718045131; x=1718649931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP1RdA2uZs/hxPpChvYu47ujLlyUngkgBww7nrjQRCo=;
        b=EqRDln9fMY3Q3HXDi2+octdJVfjskh5FNSV51sIJkqdyA3mx6Dv1kgIDCSZVqgvg5E
         671taksL4gejOYLMdC4JuuAEgubS5m0c1B310sO1zUW1IKpR0NL2jSyrC6W0ABpiiS8t
         M/fsUcE0xGt4LJ5ARckarFutPZlmOlubZorp0/m7ZnXLjOMKc/aGjX0GBuGU1GIW1off
         66jhl/ojW2+4WkB2BLfWDfePXNYxM4ZmDfmrd/znrK9FJoibHQx3wgbA+H3I+0+dI3W9
         GUC5l86mkGgK5cBxHxYfbqUStt0kNnmDdDWn6GrX7iGk06mG57/zf/9FmemN+Yu9tUfF
         TBWQ==
X-Gm-Message-State: AOJu0Yyjh2E4bzBm6PxFrgpF8S4n/4kX2mJRsd4vihSAL0tUQGe+oKmi
	yXPzG3VlyrIH9nDBxGX4f5IEeoLXO5TDmefYqmj7rpGSI5Dxh6g4FXpYsLKfX/+okC19+z29VkZ
	ZEQBjzpC4yraTVDpm+5ZN8rCTXZ1O8LaYANkfEBLtX3+U0IbiiNnpq6DfxcrDXw==
X-Received: by 2002:a05:6214:21ef:b0:6b0:5e5d:8d5 with SMTP id 6a1803df08f44-6b089ebd1c2mr9001416d6.8.1718045131358;
        Mon, 10 Jun 2024 11:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ5ptRWfSo8j1dEXXVQpse3i1xBwM7166S+39aTL4f0I1GpcCXQdz+zSB1olckH6oD593NNQ==
X-Received: by 2002:a05:6214:21ef:b0:6b0:5e5d:8d5 with SMTP id 6a1803df08f44-6b089ebd1c2mr9001116d6.8.1718045131040;
        Mon, 10 Jun 2024 11:45:31 -0700 (PDT)
Received: from optiplex-fbsd (c-76-152-42-226.hsd1.nh.comcast.net. [76.152.42.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm27915716d6.3.2024.06.10.11.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:45:30 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:45:28 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-ID: <ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
References: <20240606170026.101839-1-aquini@redhat.com>
 <20240606180622.102099-1-aquini@redhat.com>
 <20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>

On Mon, Jun 10, 2024 at 11:11:39AM -0700, Andrew Morton wrote:
> On Thu,  6 Jun 2024 14:06:22 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > An ASLR regression was noticed [1] and tracked down to file-mapped areas
> > being backed by THP in recent kernels. The 21-bit alignment constraint
> > for such mappings reduces the entropy for randomizing the placement of
> > 64-bit library mappings and breaks ASLR completely for 32-bit libraries.
> > 
> > The reported issue is easily addressed by increasing vm.mmap_rnd_bits
> > and vm.mmap_rnd_compat_bits. This patch just provides a simple way to
> > set ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS to their maximum
> > values allowed by the architecture at build time.
> > 
> > [1] https://zolutal.github.io/aslrnt/
> 
> Are we able to identify a Fixes: target for this?
>

Sure, it would be:

 Fixes: 1854bc6e2420 ("mm/readahead: Align file mappings for non-DAX")
 
> I assume a cc:stable is appropriate?
> 

Andrew, I admit I was somewhat hesitant on adding the Fixes: and the stable CC
to this patch because I didn't really think of it as a "fix" for the given 
commit, but just as a simple way to toggle ARCH_MMAP_RND{,_COMPAT}_BITS 
to maximum allowed at build time.

I don't disagree with doing it, though, if you think it might be appropriate.

Lemme know if you want me refreshing the patch to amend these bits.

-- Rafael


