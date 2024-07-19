Return-Path: <linux-kernel+bounces-257241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11D937748
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB7B1C213C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB948624A;
	Fri, 19 Jul 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fnl8LrsO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BFDDB1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389488; cv=none; b=H3WCzGkVL3MVj8wIoPE9nvUTjypBaK+JrGW3DVnGjVh9onEOxOWKKyKKrvjEqHum6Xk89mXvjBWq+U8qFdIHEKtpXtR0LOn3os5l8/VBd9uduRoX5jbrbfKuLjeP0HLfZz9fHeB+2/zuJASqohyEtM6u9iE9rxtz8TCQewhDGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389488; c=relaxed/simple;
	bh=kgKTLoK6aEF7j5uUJdbhIC+g+jKuvnbnfAisvztFBcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR9RbOCDA4Nw+a7Ta/k5rc/knND/A1D3VNaCjGxSbglT6xqBYykExG863O4SEjpfLeobMJAoDe1BgIkrBA9h27E4kn+PYOxy0EJCiL58qgNnZya9VtX/JFnR6gQcK4prW7vXWRwE8SKa9sVWv7wcl/ngXQ4Hngbo7x+bqzBJo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fnl8LrsO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42725f8a789so30365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721389485; x=1721994285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqiXhGjOSYu1xQZgH96GVDYB8na0EBhm6a6MmbmS/gs=;
        b=Fnl8LrsOJoG4f2f+PHxa7wqhgw5d/YzE0XJMrpl/XxgJAGs5N4EJkhsdqnMJnUN2lu
         54pW/mW56fy0s6UMeR5/+zF4rQFXMpJ8XaECuJChjdFqq+0LnRWjyxmWU/wwpmC+t+Vj
         I3L/j3jsbLzKAJAvHKT8HxMFV4jwdpn7thB8CQbd3J51kvWM1jpneJ87w16MGb00D4Wc
         EuH3LH/+H0roBvL9ZjxblsrFm61XB4bTMPSgV3CPWL/8kPLAtuWUte1h+O31obupnIWp
         mfYsZCm63pfEZUr69CHjchT8bYxVK3T1SR9ShOPVykhm+tHUAv8/h7jNauv2P5kSkov6
         ekOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721389485; x=1721994285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqiXhGjOSYu1xQZgH96GVDYB8na0EBhm6a6MmbmS/gs=;
        b=CH6m0zHODoI/vb286CeVNBhFncli9NAQpWYJdgeyKCuoy4zqDKECRBx+tACx7dduo5
         ZQINNhsVsPI66s1dbCTniZ5KEtq4b4TT63IkIixDEBMLp56QFOjdAt5UKxG8SbLCaZ5p
         DvgmJi0lbb90aXRK6vhcw1Kyel8JwSOBtP2ty4Gtxno/TaXyY/HhMB1zCZkUGJ6Ub1vG
         V2OluSsjB3+pQodmjXuq5Kuwufj7re7RCrD32/SChdfnAlXQXvUVvRg9l0tDzrfFjAVj
         PHgLskMih9WHgj4+tY7NESdd2ucwEqTWE92G4c77L9RUApd3dNXA55z0gUOOLg9UuNxg
         qAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpF/tMj/uC0FKW1OY5V/OpJa6bPhcTxAgKQwslijJJTBRUInHDPHZOprlsB2mDUDdaDx971l44QR3lALBed1JPlM36K/V8htIB6QDp
X-Gm-Message-State: AOJu0Ywb9aQg12nMCfw+/7zecQ1njohxjkEqsMXJtKdSw1UH5pJYZMy0
	SMINYfzIzUcuazJ/iIMYAg613phAoW7C5AQLRWDeW98yzyx92NL3Ayk+AhRmIw==
X-Google-Smtp-Source: AGHT+IFU0Zkx2Sq301T9KLS1Qev+gl2hXlS+YMiIjix2LoeRgr3gvV/t6LaUnZWd6GxnVJkmx3HXGQ==
X-Received: by 2002:a05:600c:511e:b0:426:5ef2:cd97 with SMTP id 5b1f17b1804b1-427d5812246mr1214575e9.2.1721389484609;
        Fri, 19 Jul 2024 04:44:44 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a95099sm47533645e9.48.2024.07.19.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:44:44 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:44:42 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, rananta@google.com, ryan.roberts@arm.com,
	shahuang@redhat.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 2/6] arm64: ptdump: Expose the attribute parsing
 functionality
Message-ID: <ZppRqmuL2ORp2uNC@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-3-sebastianene@google.com>
 <20240705110747.GA9231@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705110747.GA9231@willie-the-truck>

On Fri, Jul 05, 2024 at 12:07:48PM +0100, Will Deacon wrote:
> On Fri, Jun 21, 2024 at 12:32:26PM +0000, Sebastian Ene wrote:
> > Reuse the descriptor parsing functionality to keep the same output format
> > as the original ptdump code. In order for this to happen, move the state
> > tracking objects into a common header.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/include/asm/ptdump.h | 41 ++++++++++++++++++++++++++++++++-
> >  arch/arm64/mm/ptdump.c          | 37 ++---------------------------
> >  2 files changed, 42 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > index 5b1701c76d1c..c550b2afcab7 100644
> > --- a/arch/arm64/include/asm/ptdump.h
> > +++ b/arch/arm64/include/asm/ptdump.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/mm_types.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/ptdump.h>
> >  
> >  struct addr_marker {
> >  	unsigned long start_address;
> > @@ -21,14 +22,52 @@ struct ptdump_info {
> >  	unsigned long			base_addr;
> >  };
> >  
> > +struct prot_bits {
> > +	u64		mask;
> > +	u64		val;
> > +	const char	*set;
> > +	const char	*clear;
> > +};
> > +
> > +struct pg_level {
> > +	const struct prot_bits *bits;
> > +	char name[4];
> > +	int num;
> > +	u64 mask;
> > +};
> > +
> > +/*
> > + * The page dumper groups page table entries of the same type into a single
> > + * description. It uses pg_state to track the range information while
> > + * iterating over the pte entries. When the continuity is broken it then
> > + * dumps out a description of the range.
> > + */
> > +struct pg_state {
> > +	struct ptdump_state ptdump;
> > +	struct seq_file *seq;
> > +	const struct addr_marker *marker;
> > +	const struct mm_struct *mm;
> > +	unsigned long start_address;
> > +	int level;
> > +	u64 current_prot;
> > +	bool check_wx;
> > +	unsigned long wx_pages;
> > +	unsigned long uxn_pages;
> > +};

Hello Will,

> 
> Minor nit, but if we're moving these structure definitions into the
> header then I'd be inclined to give them some more specific names (e.g.
> prefix them with 'ptdump_'). Granted, this header isn't used widely, but
> it's included by arch/arm64/mm/mmu.c and claiming 'struct prot_bits' is
> a bit over-reaching imo!
> 
> Will

Thanks for having a look. I applied the prefix.

Cheers,
Seb

