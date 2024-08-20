Return-Path: <linux-kernel+bounces-294089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224069588BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C85B22686
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1F1917C7;
	Tue, 20 Aug 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1whp/yR"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AE18FDD0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163215; cv=none; b=ShanspBVDvv/uqK4wVCmhrhiWeaucbnMeXTx7U+bTVyxeTOFXL+1k4FCNdbkux+Hhhg1l/K//gwjJfKRBE6L4DhIlKmkA9AYTsRSUWe0WYv3ZBfne3HS2Q0do0OsgTK+Bl5KDn23hp2m48dhhf00SAwV2w2u2l3IJGPkODGXPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163215; c=relaxed/simple;
	bh=yGCtgCorSiOAoryOCIgqexjc0t7ggJz8lR+Bfk0R4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejeex07afJ7cUBUvsVoeDWNKtMT3q8VTcWfoIcBEkemnjI03UDHHSqkgSPzK4OUiMIkwvopCjsNtIfP8EZpKc4Fhw7RukfZ6kelbsAA1W9GBT6AMjkHcKNDXxloCzExCmx/JoMtq0Nry5KOAc21K26pPof+W0ZKJmPsrFzJhIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1whp/yR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bec7c5af2aso7098a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724163212; x=1724768012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e23Hu8+Z1sCUC2nCZq+qZMQygcSEW/P8er1otbAoihc=;
        b=y1whp/yROhRTz5+//v0yxxC0wP6LmIQB1nVf8LQbKG1XWhKiqj5cKBZoNDw6kR213G
         4UGLatCeDDkMXoykySGagO/lJ8x57PtZuDBmLdSAxxN7htTF9Qs9Gt0+Vtvx4bPp+tq8
         bDhh3Bt3zKNCYTUJRU10M8GeW5gwx3doodWwR06NsyT94u5zwdkQ3sqqomqjzsSltWtq
         Lqr7cdrCJaVC5OyzPU3Y7U7Rq8b+XrCxmaEG8fA6NZvd+rjezBcYWnNSbfmU0nrym3Eo
         vakQAjwPrRcvbuF+nbEcr6r7aarAXTlDYciHCyaHCr7DOYEDV2kloCKXg8d1z6i8ph2q
         9Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163212; x=1724768012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e23Hu8+Z1sCUC2nCZq+qZMQygcSEW/P8er1otbAoihc=;
        b=bKjpHB8kBzExDMWQt5nZu6CJSthx4HucmKlhtMyLwRc6+PzyLtV1DUNh+zih2l+Nul
         ztZzUz66i5r8e02tY8fy8N921IcudZ0crIxy/2nGqgJ0AxnYlA/EwJUo1sMY60onGbJl
         EtR1gOoWzR10ytLgnqFRBOzRS+4ysmiZzyqF459UoKmmSa4MeKgpo3W7lnBee6Igg3bx
         lL2t8woMuKX3vBPBY/qpsFGewKYO9oowXEDnSr5oI3t20OSPExC4EmJqkBfFWZlSoF6H
         3P2xAkgQjxsasCkgUW/1WqqU0vpYZNbFQ491nQ+LoS/bXSmY4jqre1nLf8LKadicCpl1
         VO3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBfbLsrFslcUO/qNdUzQ/bHrHReGMRmob8l5N/ZrXZqIUSJkxnuzN3Al4Xbweq12PuHgopZV50byrFYyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObwaVgBg5+kz9H4XyX+DnLqMkBBdZ/AccGkt5omXTGfr3qJGa
	yjKMipnUmwwTdy5gG3P4M0HXTy1uZfY2p6/V0lI1gk+XVVzPC0iwzBx2utUHbQ==
X-Google-Smtp-Source: AGHT+IH6v5g16+oGR8+nvA7bQYPp8gwjKoUxL4x3NW45RWOQa0iz4Xar7ykgmKpu8OpJ6xRVSzRb1A==
X-Received: by 2002:a05:6402:3546:b0:5be:c28a:97cf with SMTP id 4fb4d7f45d1cf-5bf0e5a28eemr65188a12.5.1724163212081;
        Tue, 20 Aug 2024 07:13:32 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded364fesm195663365e9.27.2024.08.20.07.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:13:31 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:13:27 +0000
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
Message-ID: <ZsSkh2iw8s5Oa5xb@google.com>
References: <20240816123906.3683425-1-sebastianene@google.com>
 <20240816123906.3683425-4-sebastianene@google.com>
 <86seuzxq27.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86seuzxq27.wl-maz@kernel.org>

On Tue, Aug 20, 2024 at 02:49:04PM +0100, Marc Zyngier wrote:
> On Fri, 16 Aug 2024 13:39:03 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > Printing the descriptor attributes requires accessing a mask which has a
> > different set of attributes for stage-2. In preparation for adding support
> > for the stage-2 pagetables dumping, use the mask from the local context
> > and not from the globally defined pg_level array. Store a pointer to
> > the pg_level array in the ptdump state structure. This will allow us to
> > extract the mask which is wrapped in the pg_level array and use it for
> > descriptor parsing in the note_page.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/include/asm/ptdump.h |  1 +
> >  arch/arm64/mm/ptdump.c          | 13 ++++++++-----
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > index bd5d3ee3e8dc..71a7ed01153a 100644
> > --- a/arch/arm64/include/asm/ptdump.h
> > +++ b/arch/arm64/include/asm/ptdump.h
> > @@ -44,6 +44,7 @@ struct ptdump_pg_level {
> >   */
> >  struct ptdump_pg_state {
> >  	struct ptdump_state ptdump;
> > +	struct ptdump_pg_level *pg_level;
> >  	struct seq_file *seq;
> >  	const struct addr_marker *marker;
> >  	const struct mm_struct *mm;
> > diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> > index 404751fd30fe..ca53ef274a8b 100644
> > --- a/arch/arm64/mm/ptdump.c
> > +++ b/arch/arm64/mm/ptdump.c
> > @@ -117,7 +117,7 @@ static const struct ptdump_prot_bits pte_bits[] = {
> >  	}
> >  };
> >  
> > -static struct ptdump_pg_level pg_level[] __ro_after_init = {
> > +static struct ptdump_pg_level kernel_pg_levels[] __ro_after_init = {

Hi Marc,

 
> Do you actually need this sort of renaming? Given that it is static,
> this looks like some slightly abusive repainting which isn't warranted
> here.

I applied Will's suggestion from
https://lore.kernel.org/all/20240705111229.GB9231@willie-the-truck/
>
> 
> I also didn't understand the commit message: you're not tracking any
> mask here, but a page table level. You are also not using it for
> anything yet, see below.

and I missed updating the commit message.

> 
> 
> >  	{ /* pgd */
> >  		.name	= "PGD",
> >  		.bits	= pte_bits,
> > @@ -192,6 +192,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
> >  	       u64 val)
> >  {
> >  	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
> > +	struct ptdump_pg_level *pg_level = st->pg_level;
> 
> This is what I mean. What is this pg_level used for?

I make use of it to extract the name based on the level. The suggestion
that Will made allowed me to keep the code with less changes.

Thanks,
Seb

> 
> >  	static const char units[] = "KMGTPE";
> >  	u64 prot = 0;
> >  
> > @@ -262,6 +263,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
> >  		.seq = s,
> >  		.marker = info->markers,
> >  		.mm = info->mm,
> > +		.pg_level = &kernel_pg_levels[0],
> >  		.level = -1,
> >  		.ptdump = {
> >  			.note_page = note_page,
> > @@ -279,10 +281,10 @@ static void __init ptdump_initialize(void)
> >  {
> >  	unsigned i, j;
> >  
> > -	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> > -		if (pg_level[i].bits)
> > -			for (j = 0; j < pg_level[i].num; j++)
> > -				pg_level[i].mask |= pg_level[i].bits[j].mask;
> > +	for (i = 0; i < ARRAY_SIZE(kernel_pg_levels); i++)
> > +		if (kernel_pg_levels[i].bits)
> > +			for (j = 0; j < kernel_pg_levels[i].num; j++)
> > +				kernel_pg_levels[i].mask |= kernel_pg_levels[i].bits[j].mask;
> >  }
> >  
> >  static struct ptdump_info kernel_ptdump_info __ro_after_init = {
> > @@ -297,6 +299,7 @@ bool ptdump_check_wx(void)
> >  			{ 0, NULL},
> >  			{ -1, NULL},
> >  		},
> > +		.pg_level = &kernel_pg_levels[0],
> >  		.level = -1,
> >  		.check_wx = true,
> >  		.ptdump = {
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

