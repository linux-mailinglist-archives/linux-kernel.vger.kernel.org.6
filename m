Return-Path: <linux-kernel+bounces-185330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C48CB392
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7002FB22D04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB511487F7;
	Tue, 21 May 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cANlZAMp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAA14884F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316606; cv=none; b=gxYiSNokwDbnhrHBSSw90Zm6WWF2YHBnbKMv9mm6kgCX5oHjvoOLnUgE3GD5dqCY5dQShWq/cxLvT7kTEaraim8FR6MWz7I7LcniUpOUzWIXUhSmmhvYuCkWhKgQf0X8jbfuQF14c6W0Yh2NNs8WB3EJarrIBtne4J1STAjkFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316606; c=relaxed/simple;
	bh=qvsdQhZ7BuP31Y2XO01pfGuDmUVoBr18WPXViDhgp8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoSOnilIymtboAk750mnHDC3q2TCRE/oAlyIDWV9B1uAwUgwfj4YoX0RaziC5Cj82YRuODuczlwlRWxhWISroM3OsAK7lyhsJG21a5rJ+ZyV1GSezPZIuU0D2QukCICCd11t5rOT8URg5lUBpWJEGzY2LbLJR4/IzLpI9SXNlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cANlZAMp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716316603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jevMKRBxb/R55R0RVyGAIvU9KnGm8nwwPq1TksVQuy8=;
	b=cANlZAMpCaWVkzl7YhRboGpv/tZBDU6NydVl3uVF/Ine7bq1XBR2TWR3zf5GZc77MRkCfZ
	rQNtUO+XaJQQxWhAzMqevI9vp2BY9JecVq0GNurHFIDwua0bj8XN5wXT0oUcA64piZd9ZZ
	M9IrmICgX8PZnQUVlnBssRL525Ryxn4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-WGzUnwuvMqGDsep8lFp7og-1; Tue, 21 May 2024 14:36:40 -0400
X-MC-Unique: WGzUnwuvMqGDsep8lFp7og-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-420eed123a2so13969015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716316599; x=1716921399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jevMKRBxb/R55R0RVyGAIvU9KnGm8nwwPq1TksVQuy8=;
        b=mB5YG6Ei47o7632S6/I1ESbH2nHIQaiMdVEzAhBkrNpvI4II46WkT9YH6gs5I8bajN
         MxWKt8T89oaTNrH0cHiSytLOxaoa3S+68CwxilfGEWdvx8fTCQ1CCtI3JdPw2s1fc9pO
         6xdG45teclX5qqPmjb0kymw8UHqpXDgrBNaRDEyGiNAP89/+JAzNGQlOGdOXiMqxn2Fq
         6TExrpJsoGGGPLzFovodCBHzwoR3R6C9ryRsCAOUQ1dqYaIX8wlB2hGlDObW7KazydYe
         SL7HJVOan1tEUIfu6vQ7+060M/bTVi2vUcAhOv5MKRpzHsRWz3M4hRI+Oec/8OEnRGMh
         TsMw==
X-Forwarded-Encrypted: i=1; AJvYcCUNvaW213K2zidewzH9ETzHFgspz5Onbhbi9d5rzV44A1WhB5M6KPVrmnz+aFaEMrNhfUsGwld7i5sdJKNyT5MBdeR0NwQJZWuQUdK5
X-Gm-Message-State: AOJu0YxfEEvCJ8dy9gAV0CtaxUd5DYnTNz/nyPQAV0eF5hzEOqM0igwZ
	e9Z2QtyxMfDXJQMwbxTWTcXefuov6YQBQmSWYS4erQnIrkSYm9TQTaf77zS0Qh7VgZU/dlWKkgW
	Ea9LiFCCDVByJgCJuHObP8FBV4Fbo3CuCove0OcewNnpZ5aEMjYH+mgHJUPfIHg==
X-Received: by 2002:a05:600c:3b23:b0:41b:f3b6:e5da with SMTP id 5b1f17b1804b1-41fead61b59mr287566365e9.36.1716316599618;
        Tue, 21 May 2024 11:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk76L37vIpOA5Y58eTWTGFIjiFF33BBGgA3nqwWyu66vAzg2d7meVl0CY1IrJMA1aWEsUH5A==
X-Received: by 2002:a05:600c:3b23:b0:41b:f3b6:e5da with SMTP id 5b1f17b1804b1-41fead61b59mr287566195e9.36.1716316599179;
        Tue, 21 May 2024 11:36:39 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b4af0b0asm25792883f8f.100.2024.05.21.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:36:38 -0700 (PDT)
Date: Tue, 21 May 2024 20:36:36 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>, wedsonaf@gmail.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, ajanulgu@redhat.com,
	lyude@redhat.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem
 operations
Message-ID: <ZkzptG6fJx-MJ_6s@pollux>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
 <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
 <CANiq72k7H3Y0ksdquVsrAbRtj_5CqMCYfo79UrhSVcK5VwfG5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k7H3Y0ksdquVsrAbRtj_5CqMCYfo79UrhSVcK5VwfG5Q@mail.gmail.com>

On Tue, May 21, 2024 at 11:18:04AM +0200, Miguel Ojeda wrote:
> On Tue, May 21, 2024 at 9:36 AM Philipp Stanner <pstanner@redhat.com> wrote:
> >
> > Justified questions – it is public because the Drop implementation for
> > pci::Bar requires the ioptr to pass it to pci_iounmap().
> >
> > The alternative would be to give pci::Bar a copy of ioptr (it's just an
> > integer after all), but that would also not be exactly beautiful.
> 
> If by copy you mean keeping an actual copy elsewhere, then you could
> provide an access method instead.

As mentioned earlier, given the context how we use IoMem, I think IoMem should
just be a trait. And given that, maybe we'd want to name this trait differently
then, something like `trait IoOps` maybe?

pub trait IoOps {
   // INVARIANT: The implementation must ensure that the returned value is
   // either an error code or a non-null and valid address suitable for  I/O
   // operations of the given offset and length.
   fn io_addr(&self, offset: usize, len: usize) -> Result<usize>;

   fn readb(&self, offset: usize) -> Result<u8> {
      let addr = self.io_addr(offset, 1)?;

      // SAFETY: `addr` is guaranteed to be valid as by the invariant required
      // by `io_addr`.
      Ok(unsafe { bindings::readb(addr as _) })
   }

   [...]
}

We can let the resource type (e.g. `pci::Bar`) track the base address and limit
instead and just let pci::Bar implement `IoMem::io_addr`.

As for the compile time size, this would be up the the actual resource then.
`pci::Bar` can't make use of this optimization, while others might be able to.

Does that sound reasonable?

- Danilo


