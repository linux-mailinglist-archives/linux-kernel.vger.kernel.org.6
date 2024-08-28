Return-Path: <linux-kernel+bounces-305805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9249634B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19867283A02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DF1AD9C5;
	Wed, 28 Aug 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qtl0KDNF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DB1A76B9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884085; cv=none; b=NUnJYSwTJT1OdQHULR5cwPojfsVqBnAnhvd4jE9VF9cvg3tpNLmCJ8OgXNoMl5/TirZGlo9pMSx4Mi/WesSI8eHyVl5IWwH9kePvUYq2Jr1dGTMgnL/esshl6ODISOx60N9jhJBDdCZ27dqHopuuzjrWmSQIaNR2POKkzLRzy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884085; c=relaxed/simple;
	bh=X+km3MM8Djv4BAoedxYfYSnV7h3AO6W0/QFMSBR+6tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3ChF4p5GXDrizqTOXMFc3eQB4kXeX1LeDd2rahcF+LYPOCkqQjW8LsNWSC/7Vey5IO0o8lNfZ7sSYZFhSPOtm2Woii8v7eu48xqP3VXlHooizLgiBZILr0W04W2C0yVg6vxQJMXs8FWECWmwRJJgLPpXSzDhnFJyWwnDHwUuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qtl0KDNF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202018541afso32725ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724884083; x=1725488883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyvIuJm8YmYnY8dX3OldQiJE1+zDwIi+PDulR5QhNTU=;
        b=Qtl0KDNFau6tda4TQsdUKaVUUNaP4IRDY9DgPE6BgrLHCZSy17nFABDMZgCdSRcD8R
         vXuXRrEbZNl5BRXwr9iuoTmzdf6mSCiJwKittvuZ45g7CGMai9Ix5PUAFWGbDixF1/xd
         mmKnEl8JQNxQXkquVklYWiCfzFJNFIZ8p+0bfENuGhLi2BNYgO0qAKi5jr5yra1uveK4
         o7MuhuPjLUXSvLgxyM8NWl1hD++z89Gw+ohOHuufU7PgsJZmKbw1Ih4IEl4D7dAFgoae
         Ar6JUylJLg7p5CaRVtFp/+5CA1sbraUKp+Wfbb9onVVkdh/i7c5Yo0inppEH1WAt1T3g
         Q/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884083; x=1725488883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyvIuJm8YmYnY8dX3OldQiJE1+zDwIi+PDulR5QhNTU=;
        b=BWADdXBbos+Godwp4q4Su706rcO5BB0FqRJa3JYKDJ5uecbC3vsAILVwWsg8JA0RJo
         m7cfbDu0TrOFK2WTy5KY17lvbK9wZ3dqXQcev6OQ0FeaIdZ+0CQ4Y+Ey58BRrLHGWDJ5
         9FONKQYCAhGjQY0OfW+Vi2uti5uexVh8ww+mLr5Xbk9bX1e8vhwjtWdd+Wm9AvS7M+yT
         QUHAt6CJUlaFoC55UOt9STyGOVr+tdxL0vbhWdyZfMBIIbvZYkHFe3xjOFEvsXHTp6ac
         WoA5+4fu4xtFiJAbHEXe138gjPfnb94LA0jI874b0wIx6zF7GcqfDQmdi+EUbM30Lw6C
         geyg==
X-Forwarded-Encrypted: i=1; AJvYcCV+FSTeSZC/5eQyveqkq4xhO+fQ/3UzxlgJOMpPflf3a7WBKeznI49isQOjM+xi5LspLSNBdIv1ZzI02iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qj3mdiH+W55zk34gPDYDzUl4gRBH6J7uTp29xfTxNdLJsKyY
	6m+xU7f3BoYmNi3CPeVLMIH5HuLkTG7wpocsNbdnwOBaHY54FMpbQvkjcxZWbg==
X-Google-Smtp-Source: AGHT+IFXWx05e/+XweIL+R6dsRvJNpSo2hQC1mySqaLDGAhfbYvgJChv9vcvthH548sGd8lARL2kdw==
X-Received: by 2002:a17:903:22c7:b0:1fa:fe30:8fce with SMTP id d9443c01a7336-20510b5500dmr423205ad.23.1724884082803;
        Wed, 28 Aug 2024 15:28:02 -0700 (PDT)
Received: from google.com (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844618f6csm2496536a91.27.2024.08.28.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:28:02 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:27:59 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 06/19] gendwarfksyms: Add a cache for processed DIEs
Message-ID: <20240828222759.GG2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-27-samitolvanen@google.com>
 <CAK7LNARQncjxxqbjiMHXdAnakpo8QYo-5kYnN=KaD2xDe0uXPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARQncjxxqbjiMHXdAnakpo8QYo-5kYnN=KaD2xDe0uXPA@mail.gmail.com>

On Thu, Aug 29, 2024 at 03:15:02AM +0900, Masahiro Yamada wrote:
> On Fri, Aug 16, 2024 at 2:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > +static int append_item(struct die *cd, struct die_fragment **res)
> > +{
> > +       struct die_fragment *prev;
> > +       struct die_fragment *df;
> > +
> > +       df = malloc(sizeof(struct die_fragment));
> > +       if (!df) {
> > +               error("malloc failed");
> > +               return -1;
> > +       }
> > +
> > +       df->type = EMPTY;
> > +       df->next = NULL;
> > +
> > +       prev = cd->list;
> > +       while (prev && prev->next)
> > +               prev = prev->next;
> 
> 
> 
> So, this entirely traverses the singly-linked list
> every time a new item is appended to the tail.
> 
> 
> In my analysis, this while loop iterates for thousands
> of times in total for emitting each export symbol.
> 
> 
> Why isn't this list_add_tail()?

Good catch, I'll fix this in the next version. Keeping track of the
last element should be sufficient, but I agree, using the existing
list implementation is probably cleaner. Thanks!

Sami

