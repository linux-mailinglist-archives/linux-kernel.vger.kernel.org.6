Return-Path: <linux-kernel+bounces-211480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCE905263
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32889281A02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1682C16F0F3;
	Wed, 12 Jun 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8PPkdkT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5A16F848
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195209; cv=none; b=jjOQMGin0xBy/M8OlH6Kj06lqgvaR69mKSpg5b6qW6t/uIJdBvtRHCso1uYDQ2a3wlqg+busY1iHSIlnhmjZER08ci9KSYKU7CkSzR0cePn6Cs1C8TLSl0uSdRbkS5ngUP8SdqyPLFOt8jNPf1HtbwYLc15WDyoHz4rO3yNisc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195209; c=relaxed/simple;
	bh=QKaes3O71kakimHZ9ExuD/ps5uBksdYrWMe0gT5+C80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Gq/F1U4Xo/8SVxt5AApL/21HA8Yrr2aUVh02WWDCTsFJCy6AbfehB+9i+9kGvHZ3iAWquiU6avNtY3OZfLaSH505R9h2FoFSS7K2BmH8bpL4Li++ae6hSJATpUctECUvwC9WJdEjc8s8gIa1pTdyVsl0Z4hyingpTJ1vLQnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8PPkdkT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718195206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DCAbJVewQ86BApmc0sfUvldghSL3lNlhtdPFumthEaM=;
	b=f8PPkdkTVtDxmJdn9+Xm6Prapjx2vUGjZDKBal5dNEbLpA0WWC74Ukt6hOqnTUdkp/+aGG
	EKXkYUbf4r6AxUCf14T9CnLnBkkPKZgUMiZyfJHPhBUzB8dCEr6aLYklpjaOafdfg5wzWp
	iU4NCZ9fMs8MFXfjLOMpROXQjM7T6kc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-RyjPc3ztPkujl5o1zgAFKQ-1; Wed, 12 Jun 2024 08:26:45 -0400
X-MC-Unique: RyjPc3ztPkujl5o1zgAFKQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7955f8b4bcfso243676685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718195205; x=1718800005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCAbJVewQ86BApmc0sfUvldghSL3lNlhtdPFumthEaM=;
        b=hc44YWPyTh7ZY9ISdUm1FuxvIXKkkjjt2UrSleA8SsZlop9zIyIvoGqy+O+pI1LfVW
         s3VoKMN6tHLWfquRwscGf7MdoC6WkfgF2maHoAnGwIOHc31mXWWJF+/IUqkpwtsrF8pS
         ZN/V3zc/241etJg4+m1tp0G5ro03wEzBrSOLd/ZGlYLelzOCWWfACRP8KBZY0TUv+mga
         eNqA0kmHpYNOrpUWKE+SzHicrXPdIIH4fuRhBCQaL7+c/lalhN5/YWdEgBQv6Q7TB2Np
         pXLQ7wyJqq07gln/ztvLwZTC6oXS2CkVJJuJ0KUiAD/bBofQHiqdotR7mCJjmOJ5E14k
         +b5A==
X-Gm-Message-State: AOJu0YySqFhdrtdi1QgsU0wHnUt3rzNMl/ZT04A1hXMNlv5imKVIeCZJ
	P8SqQ4XQ2V9e3VxZjQ+4X6qCYhS0vQLwIGXNaouuwWWgjS2pN1zNm5S9IyyPi6cSMrc5tNoop6U
	2OH9fTfsnse0RnjHwsccXx/1wYPbP7Pe0xk17O4/YXw5AyYMVM29/xs5aIUsz6A==
X-Received: by 2002:a05:620a:269a:b0:795:47ca:d1e9 with SMTP id af79cd13be357-797f603882fmr142340985a.24.1718195205001;
        Wed, 12 Jun 2024 05:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqTHx4L/adya3wPuBQ0mIYvQpev5zOaTKEWny2F7g42umR3gtpRcUfw9IvvjCGIUNu1UprGA==
X-Received: by 2002:a05:620a:269a:b0:795:47ca:d1e9 with SMTP id af79cd13be357-797f603882fmr142339585a.24.1718195204612;
        Wed, 12 Jun 2024 05:26:44 -0700 (PDT)
Received: from optiplex-fbsd (c-76-152-42-226.hsd1.nh.comcast.net. [76.152.42.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954c3580aasm452524485a.136.2024.06.12.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:26:44 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:26:41 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-ID: <ZmmUAUl_zuXnA_0O@optiplex-fbsd>
References: <20240606170026.101839-1-aquini@redhat.com>
 <20240606180622.102099-1-aquini@redhat.com>
 <20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
 <ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
 <20240611143239.ab8e4d96289a748ae1f8a480@linux-foundation.org>
 <Zmj7XAF5EcF40glG@x1-fbsd.aquini.net>
 <20240611194312.6048eba27c9ff3869040a35c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611194312.6048eba27c9ff3869040a35c@linux-foundation.org>

On Tue, Jun 11, 2024 at 07:43:12PM -0700, Andrew Morton wrote:
> On Tue, 11 Jun 2024 21:35:24 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > > Shouldn't we make this the default (at least for 32-bit) so the
> > > regressed kernels are fixed simply by applying this patch?
> > > 
> > 
> > That is a fair take, indeed. I guess we could do something like
> > 
> >  config FORCE_MAX_MMAP_RND_BITS
> >         bool "Force maximum number of bits to use for ASLR of mmap base address"
> > -       default n
> > +       default y if !64BIT
> 
> "something like" != "exhaustively tested" ;)
> 
> I'll toss that in there, but please do let me know when it is suitable
> for an upstream merge.
>

The follow-up patch does work as intended:

  [raquini@optiplex-lnx linux]$ make ARCH=i386 defconfig
  *** Default configuration is based on 'i386_defconfig'
  #
  # configuration written to .config
  #
  [raquini@optiplex-lnx linux]$ grep MMAP_RND_BITS .config
  CONFIG_ARCH_MMAP_RND_BITS_MIN=8
  CONFIG_ARCH_MMAP_RND_BITS_MAX=16
  CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
  # CONFIG_FORCE_MAX_MMAP_RND_BITS is not set
  CONFIG_ARCH_MMAP_RND_BITS=8
  
  [raquini@optiplex-lnx linux]$ patch -Np1 < patch.diff 
  patching file arch/Kconfig
  [raquini@optiplex-lnx linux]$ make ARCH=i386 defconfig
  *** Default configuration is based on 'i386_defconfig'
  #
  # configuration written to .config
  #
  [raquini@optiplex-lnx linux]$ grep MMAP_RND_BITS .config
  CONFIG_ARCH_MMAP_RND_BITS_MIN=8
  CONFIG_ARCH_MMAP_RND_BITS_MAX=16
  CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
  CONFIG_FORCE_MAX_MMAP_RND_BITS=y
  CONFIG_ARCH_MMAP_RND_BITS=16

 
> I also added cc:stable.
>

Thank you, Andrew. 


