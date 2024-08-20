Return-Path: <linux-kernel+bounces-294147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C169589F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C524B23DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60D194C71;
	Tue, 20 Aug 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rz4nEtYb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41185191F60
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164762; cv=none; b=t70dj3eck11qR3zwxf7iBU7fUfcXg9NrWpu2lLzjytgzDIkzvfmXYMDmQcy35qIT34K3ttt8atpWsK1PpLiMdVxnWEYjKUQVimCutjpmvQFfjU8OUUuUn1YNhhIxoeo2kU0TmJxWOzqwSVTWw1DumvA/G+MDPYLVl8uOBNWxsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164762; c=relaxed/simple;
	bh=6K/5oa3KeOCD8BeLjlcTBvqfRBS/79+0n2Kq0SJWKq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP9IkriuhKrdqvgDG097kJ2/8BuTTnP0ToZN3scnawq8Qg/DzZHVjw46ps5vvfHBzRGZXnhnpkR5ZVdAV9JtqjU+vx+MXl6nPogf6yXxERkUcq5/+J/AQJSrDF9D4+/11CG/qNrgtm7yFzl2Do0Z995EH+sE+GkSA6JmI0uDIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rz4nEtYb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427fc9834deso38565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724164758; x=1724769558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqVmNf36unFHBK+FfoUHfv7AMu5TB9aKm0xHrMHZXeI=;
        b=rz4nEtYbdj1flNOUPtLHHEXWsEOOJ5S/r0cz9SsIQ5L90eJ93wJ3nv/eKGcTikcZFm
         bW7D8BmGaPIJayxEWjhKGxc2XaWpXLFEUqWwz5Uk2H/DMrze4b6ENqmud+l5AiAXMRj6
         1HN8owy4onTWiJjtncQzpYiEmHnliHIMY5UkojRNyq4KJezXE34GIpxdEgd99IRK9Bi9
         HQOEme6txF/ghGih0HPgFYC6z2yNaHWduVmb21C3Xn9HxQh1dUfiyzZ/TcOhCWk8xJbP
         l06eBj2XmwPpgWYxr+RN8zzHjnAsm/hi/rUl0rJ14t9Qv5k1mBI+njUjmE8CysAxj2NQ
         TX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164758; x=1724769558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqVmNf36unFHBK+FfoUHfv7AMu5TB9aKm0xHrMHZXeI=;
        b=Bt9o4NQsCroa48q54PbIF3R9cNzzO88wlIbUbFk8EIPLJ/KATI6S4hmmtmzNMMzXZf
         kWro3o6PXk0ce0pStpfXaDmHx60+sBtvVV9uWh9X//6+5jWfFOvgovgcpxchLyITBvjQ
         f4gRZ1e5I29DKNXBf28+K1V/1ogaUVSGQUF53cfplChnenwrRShsql6s8IJFWqnTAibF
         7kw/sXdml235l1JiOZHxrFNe8jHSIvziFMjL0axM4qqkDsjk9CpeHMVYsPTkKukEsnxo
         ar0qoJzXv7snd5CP+MI8XRtl5Y1E+YE7D2pO3e3wyufavksW4fKq1lU1YNDXiiDo+lGR
         xEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU4ktZA5DoiXgtLzan2j3zNEOECePD28kPw0kSRH9e3yussxqMF1jpJ+xPaONGyMkYojsAh6SDIAQI+cCNgH6Egh3hEsdaQ7uEuPex
X-Gm-Message-State: AOJu0YyDkn7hAGJhL79CAh7VUHQ/B29uG22N9IBExqhSp1ZSviFDqXuO
	8AUM+x43eoSR6wz5/uRz56Uw1pHuUcVyUvzJ9zzjFx8CommgzEkLesnlADWWZA==
X-Google-Smtp-Source: AGHT+IGIk3MuqZdFNT/V7eQCmxiAfwHKBaInvEhxBOOQ8nVu90AHYeozvhTj6iSXtj9NeYtV9xajCA==
X-Received: by 2002:a05:600c:3d8d:b0:426:5d89:896d with SMTP id 5b1f17b1804b1-42ab78c2de8mr553675e9.1.1724164758048;
        Tue, 20 Aug 2024 07:39:18 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded29303sm196157775e9.15.2024.08.20.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:39:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:39:16 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 3/6] arm64: ptdump: Use the mask from the state
 structure
Message-ID: <ZsSqlIVsSylHaGaW@google.com>
References: <20240816123906.3683425-1-sebastianene@google.com>
 <20240816123906.3683425-4-sebastianene@google.com>
 <86seuzxq27.wl-maz@kernel.org>
 <ZsSkh2iw8s5Oa5xb@google.com>
 <86o75nxody.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o75nxody.wl-maz@kernel.org>

On Tue, Aug 20, 2024 at 03:25:13PM +0100, Marc Zyngier wrote:
> On Tue, 20 Aug 2024 15:13:27 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > On Tue, Aug 20, 2024 at 02:49:04PM +0100, Marc Zyngier wrote:
> > > On Fri, 16 Aug 2024 13:39:03 +0100,
> > > Sebastian Ene <sebastianene@google.com> wrote:
> > > > 
> > > > Printing the descriptor attributes requires accessing a mask which has a
> > > > different set of attributes for stage-2. In preparation for adding support
> > > > for the stage-2 pagetables dumping, use the mask from the local context
> > > > and not from the globally defined pg_level array. Store a pointer to
> > > > the pg_level array in the ptdump state structure. This will allow us to
> > > > extract the mask which is wrapped in the pg_level array and use it for
> > > > descriptor parsing in the note_page.
> > > > 
> > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > ---
> > > >  arch/arm64/include/asm/ptdump.h |  1 +
> > > >  arch/arm64/mm/ptdump.c          | 13 ++++++++-----
> > > >  2 files changed, 9 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > > > index bd5d3ee3e8dc..71a7ed01153a 100644
> > > > --- a/arch/arm64/include/asm/ptdump.h
> > > > +++ b/arch/arm64/include/asm/ptdump.h
> > > > @@ -44,6 +44,7 @@ struct ptdump_pg_level {
> > > >   */
> > > >  struct ptdump_pg_state {
> > > >  	struct ptdump_state ptdump;
> > > > +	struct ptdump_pg_level *pg_level;
> > > >  	struct seq_file *seq;
> > > >  	const struct addr_marker *marker;
> > > >  	const struct mm_struct *mm;
> > > > diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> > > > index 404751fd30fe..ca53ef274a8b 100644
> > > > --- a/arch/arm64/mm/ptdump.c
> > > > +++ b/arch/arm64/mm/ptdump.c
> > > > @@ -117,7 +117,7 @@ static const struct ptdump_prot_bits pte_bits[] = {
> > > >  	}
> > > >  };
> > > >  
> > > > -static struct ptdump_pg_level pg_level[] __ro_after_init = {
> > > > +static struct ptdump_pg_level kernel_pg_levels[] __ro_after_init = {
> > 
> > Hi Marc,
> > 
> >  
> > > Do you actually need this sort of renaming? Given that it is static,
> > > this looks like some slightly abusive repainting which isn't warranted
> > > here.
> > 
> > I applied Will's suggestion from
> > https://lore.kernel.org/all/20240705111229.GB9231@willie-the-truck/
> > >
> > > 
> > > I also didn't understand the commit message: you're not tracking any
> > > mask here, but a page table level. You are also not using it for
> > > anything yet, see below.
> > 
> > and I missed updating the commit message.
> > 
> > > 
> > > 
> > > >  	{ /* pgd */
> > > >  		.name	= "PGD",
> > > >  		.bits	= pte_bits,
> > > > @@ -192,6 +192,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
> > > >  	       u64 val)
> > > >  {
> > > >  	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
> > > > +	struct ptdump_pg_level *pg_level = st->pg_level;
> > > 
> > > This is what I mean. What is this pg_level used for?
> > 
> > I make use of it to extract the name based on the level. The suggestion
> > that Will made allowed me to keep the code with less changes.
> 
> Err, I see that now. It'd be good if you described what actually
> happens, because it is almost impossible to understand it from reading
> the patch.

Yes, let me re-write the commit message in the next version,

Thanks,
Seb

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

