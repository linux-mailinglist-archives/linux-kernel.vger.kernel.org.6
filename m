Return-Path: <linux-kernel+bounces-276686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C8949705
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60242282598
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69957CBB;
	Tue,  6 Aug 2024 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoAWGcJz"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0F4F8A0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966238; cv=none; b=XRLC/bMxln4ckx8FY5m3dokzzylJto76iJiQ1iUGNpd3gyVdFipKyjsMyemUcCeaQEXLnV7NPffGITTPX8CaH4v4sWxI5Ktwj/NcJXdQ5h4on9ty2I8pBFdyYVLyerqzr/D2AWhdTpgDoEaHj/ZDTha8Si6O9CyX3aHrNg0zPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966238; c=relaxed/simple;
	bh=p+3eegjSe20iNB+5u6YzaPxhe/oJKOYmpnVFA1m95LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ9xn+oo41CAcQwxhe7rfTA2GotVQxh62auoH25MSaHx8kPJeAsYyxC+jpdvBZdvmyvShlvD2RB6tC9qLpBT7gXdKZyHgTFI6PZLmh/vRwrOHhRlHtk/kJ7KtPJ+hLfQebWDF8hqwlaEpfzZZ1iwuOePsueip8xOlDYaQTg948I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoAWGcJz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65f9708c50dso10499537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722966236; x=1723571036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWjWrVmS/yk8OuhWMz1++EcjJMNuNXc51TIUOBZhv2M=;
        b=EoAWGcJzYPvR4wqXOK+cSXrzTNy4uYubq5hWeVrUSqwkdGnkm4PQ2WQvikGb41bc29
         2h6RGLGQPZfeCEK+p2dJg/uOIR5cJAC/FyfA0ppL/oL6r4zG53qcduoMuQbK9kPPTdYw
         bZcFYncRd7WVNChofn1PyA6QyT4MsxAeYUQb2mjhbNM1kw7L5SY0mtLV4JA2bTVgMjCI
         XsyxZdkh9vGL+lYHk3sRs31gPNnYX2edALHIH/AbluS2cWKG0upouszNNbBjHmSzk1Bz
         zeS2L5ARZnP/5nDYbbFu28/7OTDtMkh1ssRauTEUEEDkgB+YlzQrs0+L4PA/+tOc4Xri
         kGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966236; x=1723571036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWjWrVmS/yk8OuhWMz1++EcjJMNuNXc51TIUOBZhv2M=;
        b=Ed4x4ltcQ2PDIS61en5Y7m2pqXOL8q/PeeaTEgMOY0MH5MRFSVGhX6X1JjmId7a514
         g1szCemctZ06h6Yz7P8PhXZP9+03uk2gIlkhy9Q1ph4ow3LeMp42E0IdZsSOCW2UxaCX
         lcgvIdw9/o/oDn6Ml04JLE4tk8RXo5unSezYyVergNftyAC1MjuvmpZO3UsywVlPkH5D
         aTxgX/OYTYHvIm00AOvsNGVLpb5vLX7wJHjgPVT5rJJUR92fGCyoac+07WZcVBWgbrkP
         34ooeJECgwXkYEcPJnQUnPVuuNgv/rZJYPfX7hVyH8lWQSW4sbNUxE/JSPudKCuufjl6
         eZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvP3tNB8VZ/F8ORvypChxXCGAcDhomhpOmwbLRE93oajk8GBsVc0BZDXMjouOoJHKmg6muldqH6AIl9go/NZIDSqcEjr4leXq2W0FW
X-Gm-Message-State: AOJu0YxeYGNMVmOMZb4rrCo7R+4u5Zom0Xsp1WiUX0Xo3c2FysAEL5dL
	deE7bY0Hhkx7GO34lcRZH55Hcu/HXytjaEcJbx3pCe83d+mA5cpT
X-Google-Smtp-Source: AGHT+IFAyONh9iwXiM3HctqqviBUk6YQECbd7oESQ5qGX3KFcWIdcfuu/oRkVL1ZI2amXNUhFToW9w==
X-Received: by 2002:a81:8605:0:b0:61a:e947:5518 with SMTP id 00721157ae682-68961bd5bb6mr171409757b3.27.1722966236335;
        Tue, 06 Aug 2024 10:43:56 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839fe5sm48342436d6.84.2024.08.06.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:43:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AFE071200043;
	Tue,  6 Aug 2024 13:43:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 06 Aug 2024 13:43:55 -0400
X-ME-Sender: <xms:22CyZl_dhk5qGDfuA5x5Zt0f2LYb9dzYtKXDjhP4AyZBNxgXee0Y6g>
    <xme:22CyZpu32VeI4xmmAh6gGux56-Vtvm4XrETz2wlPbKulmOWwJrdahdW3U6poRnvmG
    l3INdaNWeXJuRwtUw>
X-ME-Received: <xmr:22CyZjDH7KZYxF1WKRE0XrK_nAQg03k8vdpRDiSQKoJIrryqLLpXOBWyLHQpCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:22CyZpdb6VL_13bhtEuCIe-54ExKrgf6fufFo9cz5A2uVwdKhYQ7Xg>
    <xmx:22CyZqNtHZOeodU1BhEI6htlpsuwMr5EkSakQSJhstDSPpQoH3x_MA>
    <xmx:22CyZrm8MgGRaoyD9okCJlz2HbaEXcAOQl84Ls5JQrkEY5BXGWIfpw>
    <xmx:22CyZksiUvM7KcFrLwQieK3K7qezsRF7WSk0WCKrxBI8AhNZ8MS9hQ>
    <xmx:22CyZsvInBT8BQ6AtWJp4L0WPtgqfeXKjrZLNWFeDf8UnLmpVZax-q8i>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 13:43:55 -0400 (EDT)
Date: Tue, 6 Aug 2024 10:42:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Carlos Llamas <cmllamas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
Message-ID: <ZrJgnP5Nv03k8rMG@boqun-archlinux>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-3-cmllamas@google.com>
 <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>
 <ZrI3mFLUwDyEMRIB@google.com>
 <e378ac65-73cc-4829-b605-f164c67dc5ae@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e378ac65-73cc-4829-b605-f164c67dc5ae@redhat.com>

On Tue, Aug 06, 2024 at 10:52:52AM -0400, Waiman Long wrote:
> 
> On 8/6/24 10:47, Carlos Llamas wrote:
> > On Mon, Aug 05, 2024 at 09:36:43PM -0400, Waiman Long wrote:
> > > Many kernel developers understand that BITS refers to a size of 2^n. Besides
> > > LOCKDEP, there are also many instances of such use in other kconfig entries.
> > > It can be a bit odd to explicitly state that just for LOCKDEP.
> > > 
> > > Cheers,
> > > Longman
> > Right, and similar to BITS there is SHIFT, which is also a common way to
> > specify the 2^n values. I'd point out though, that it is also common to
> > clarify the "power of two" explicitly. To name a few examples that are
> > doing so: SECURITY_SELINUX_SIDTAB_HASH_BITS, NODES_SHIFT, CMA_ALIGNMENT,
> > IP_VS_SH_TAB_BITS, LOG_BUF_SHIFT but there is more.
> > 
> > Perhaps this is because the audience for these configs is not always a
> > kernel developer?
> > 
> > Anyway, this is pretty much a trivial patch to address Andrew's comment
> > below. But let me know if you think I should drop it, it seems to me it
> > can be helpful.
> > 
> >    [...]
> >    btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> >    bitsize?  Maybe "bit shift count for..." or such.
> 
> I am not against this patch. Currently I am neutral. Let's see what Boqun
> think about it.
> 

This looks good to me. Maybe it's a bit verbose but that's what the doc
part should be: providing enough information so more people can be on
the same page. Please keep this one, thanks!

Regards,
Boqun

> Cheers,
> Longman
> 

