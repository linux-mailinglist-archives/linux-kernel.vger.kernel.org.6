Return-Path: <linux-kernel+bounces-169033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786B8BC1B1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323D4281A7B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E913376E6;
	Sun,  5 May 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cZDC+zYd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6A22611
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714924004; cv=none; b=rmwKjJjIjEnlCEnaQyhokdkjRpvzW+8Gl/QtryD/DiudgNcAuVx35YZjXW2Nk3xbuE4vBojwGJ4TpZfkimVLDegbEvWQjrqbd2H+Ktq1uWoSjy4zAu+T3ghyFJ3ucImgGK5IHfsyXVU3sVJNk00MZ9zxt1J3hcBvMi8J8OhOmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714924004; c=relaxed/simple;
	bh=oWz45KAsZZuOgIMJRc1/NZXuBkXIfJ4cn2zOApfqg1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V931y/9x8o9zHyCnnlZVQiKGkBoV6XGN64FCrjfUN+ef4Ht5SEujdTMl/OQdhf3vU0AchYrE5upYS/9iY1PwGv4OupiRmlO/IyMb9kKLItjHvQfvjflRnZ5IhT5x96sJ7q1K3oruOj8faOGkekBb4R7tzOFGp46JiUKe1+89caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cZDC+zYd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso7858635ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714924002; x=1715528802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaQDafqzubUAw9+/semCOIrnrfAwnNkCHgeJ4BoA7Vg=;
        b=cZDC+zYdRlCNwGfVsiFYydWFkkpcY1XS7xpQOSxZogWcuQ3bSrSLiDkPXEPD2TjIs7
         oO4SSE6k4pgAYhRniV4QplJb+/e2QIHlWO8Gu5rMQ+BoP01OaVkIdptfEXW+0wCxZ9Q+
         ELAQ9MMz8AqngnFwTv8yYq+nAO5f70INe8wsNclefTcUEYu16St8e65KZaIShNeBhdpH
         hpCM/RQTKZEkCeT7YxNBFZBtQeDvfTGHQweG5+1aWNHhCGj3nc/jaT9l6WW0suQ7REZD
         KEAJ3P29thGxbUdJTmdbyGV8Dq+wWUq9MCL+nHpw9PHy4hXBUV3/9sgGVuTSP59i7g86
         KAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714924002; x=1715528802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaQDafqzubUAw9+/semCOIrnrfAwnNkCHgeJ4BoA7Vg=;
        b=asGZk93U6WgGfagsXGOLld+H8ZjO44p1QohNdC09Qeq3yFEwqt8PbNcbzz+yIUfTJN
         Ogf6z7OcYruUo5HEcw8E7XHz7U2FO6V0PkpcwsgmNkXZtH/5ydT26Q6hzE9jsKz4rhf9
         Qlyo+xJlZiw1j/dPQLV2s9g0WJoC03M4ZCj2fZz3Nr6jU1oeAOmmrbDGjZSYNOcfkNoX
         qhlnO8dwqwmv1MnLuwDQZbuNopNAnBYDnFCXOuJRsaRQdPjbw6+78+82H+BSzsL0yzbS
         grnMckcYxzooJLwUf28DbX+4KzE7LwDZcmbmdirYj2EIuPihP/8JRi9eW2iySjxPy7fe
         sBxw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRDTEr4yK7rQmV0mSSDyrPMxGZkwHOq2kzCWdjM9x6zn4g8wmAUvFaaDqXNf2Y/u31Ifj7f+SMoLJh2VhmLYdNKVVABJ4iOQW099+
X-Gm-Message-State: AOJu0YwwftmeaXQX8F5UQvRbmEkt9uB01fzoCq2xjq3GNbgC1NJfzneq
	yG5n4WeexW6Qflvpf2jy4kih/UfYIfcc8HSiD/hQqHxFsgmxZgjimBHlmQjQSdo=
X-Google-Smtp-Source: AGHT+IGrseAAt2y4uabYtqTQP/jWY6so2eoXUE8to+FlmXTVhjcIh8I045DqPXerpxzSkWzODtLLfw==
X-Received: by 2002:a17:902:bb17:b0:1eb:f263:d2fc with SMTP id im23-20020a170902bb1700b001ebf263d2fcmr8161144plb.54.1714924001967;
        Sun, 05 May 2024 08:46:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001eb4a71cb58sm6639923pla.114.2024.05.05.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 08:46:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s3e4V-00G2MH-FF;
	Sun, 05 May 2024 12:46:39 -0300
Date: Sun, 5 May 2024 12:46:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
Message-ID: <20240505154639.GD901876@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <20240501145621.GD1723318@ziepe.ca>
 <CAH2o1u63GjMnYrfa8W-c1hdp+TAA0R-FyxXM4dEiFF+KEGWwbA@mail.gmail.com>
 <20240503181059.GC901876@ziepe.ca>
 <CAH2o1u7av8zMucB2sKxBOZtd1eqEC4Qmgin=8VQ03pWbQdZUUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u7av8zMucB2sKxBOZtd1eqEC4Qmgin=8VQ03pWbQdZUUg@mail.gmail.com>

On Fri, May 03, 2024 at 12:44:09PM -0700, Tomasz Jeznach wrote:
> > For detach I think yes:
> >
> >    Inv CPU                                   Detach CPU
> >
> >   write io_pte                               Update device descriptor
> >   rcu_read_lock
> >     list_for_each
> >       <make invalidation command>            <make description inv cmd>
> >       dma_wmb()                              dma_wmb()
> >       <doorbell>                             <cmd doorbell>
> >   rcu_read_unlock
> >                                              list_del_rcu()
> >                                              <wipe ASID>
> >
> > In this case I think we never miss an invalidation, the list_del is
> > always after the HW has been fully fenced, so I don't think we can
> > have any issue. Maybe a suprious invalidation if the ASID gets
> > re-used, but who cares.
> >
> > Attach is different..
> >
> >    Inv CPU                                   Attach CPU
> >
> >   write io_pte
> >   rcu_read_lock
> >     list_for_each // empty
> >                                              list_add_rcu()
> >                                              Update device descriptor
> >                                              <make description inv cmd>
> >                                              dma_wmb()
> >                                              <cmd doorbell>
> >   rcu_read_unlock
> >
> > As above shows we can "miss" an invalidation. The issue is narrow, the
> > io_pte could still be sitting in write buffers in "Inv CPU" and not
> > yet globally visiable. "Attach CPU" could get the device descriptor
> > installed in the IOMMU and the IOMMU could walk an io_pte that is in
> > the old state. Effectively this is because there is no release/acquire
> > barrier passing the io_pte store from the Inv CPU to the Attach CPU to the
> > IOMMU.
> >
> > It seems like it should be solvable somehow:
> >  1) Inv CPU releases all the io ptes
> >  2) Attach CPU acquires the io ptes before updating the DDT
> >  3) Inv CPU acquires the RCU list in such a way that either attach
> >     CPU will acquire the io_pte or inv CPU will acquire the RCU list.
> >  4) Either invalidation works or we release the new iopte to the SMMU
> >     and don't need it.
> >
> > But #3 is a really weird statement. smb_mb() on both sides may do the
> > job??
> >
> 
> Actual attach sequence is slightly different.
> 
>  Inv CPU                            Attach CPU
> 
>  write io_pte
>   rcu_read_lock
>     list_for_each // empty
>                                     list_add_rcu()
>                                     IOTLB.INVAL(PSCID)
>                                     <make description inv cmd>
>                                     dma_wmb()
>                                     <cmd doorbell>
>  rcu_read_unlock
> 
> I've tried to cover this case with riscv_iommu_iotlb_inval() called
> before the attached domain is visible to the device.

That invalidation shouldn't do anything. If this is the first attach
of a PSCID then the PSCID had better already be empty, it won't become
non-empty until the DDT entry is installed.

And if it is the second attach then the Inv CPU is already taking care
of things, no need to invalidate at all.

Regardless, there is still a theortical race that the IOPTEs haven't
been made visible yet because there is still no synchronization with
the CPU writing them.

So, I don't think this solves any problem. I belive you need the
appropriate kind of CPU barrier here instead of an invalidation.

Jason

