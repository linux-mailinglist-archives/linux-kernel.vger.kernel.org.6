Return-Path: <linux-kernel+bounces-257383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02D93793D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585E82828A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453F1DDEA;
	Fri, 19 Jul 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KA3qfNYF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC98C06
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399772; cv=none; b=obTXniz3izGzZlsfYWQE0Pjpfrykk3B8K5yCh0eYRpqEdtNIsp3obKX21i3z2Q+Q2gcOH28nE78CF6B41LuX67Lo8mYn6hrG5eF6OPeH54JNxNJWu0fnFHa36LulhDk4kdrI/DaI5QxDE3tSqOojVXBogr/pN1Tgv9Mw/ZaT3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399772; c=relaxed/simple;
	bh=mV+54FIRsUg1B7hA4c9KCJ84eNp6NIHFBQlVgTwp1XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe5pad7CXayANaHZk6ZEO7EkLvkKC31YX+Notu3AMEU2HAo7v/T2HldsZOIemx+g/o3IgDnRNaxWSGI49i/7Qv1Sgt+/04Y5gwvFt9ka7sJ7vTt/IUSzfHbLanv5lW2q6ebJNueRVRENAK4WZbW+/YLUgBZ6tMQyNxfJIPKwUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KA3qfNYF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so13188955e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721399769; x=1722004569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdlmiGKKf4P64YOv5lQSDuR8ybLle1v3kavGCeiCW+U=;
        b=KA3qfNYFKT1QSvMW5pIv3FbJ3vFasGcGI6cEvWGY8tj9LtibsDCMIL5c8UROfKZB0y
         R947aeIeq0ktx5NTaQXbi8Fbxidz5cdJZ9571Rdz2Y4euWL2X7Jop3tpxVUDCipHo1Dq
         UCgpQUvaEL4dZMZvh9GpkPOhL6I+fgoW7h+lzXvNlokMly0qR09RPkTPWtAImRM4Sme+
         yXuILkkzosUIzLfHMxxEKczgaoMqK3VGJl2jWryzWTdTR7qVPg/qmiIudYuqhkWaa+xj
         aruY7QIpTtU3U8jCWN3potb3xBejXW1NzlEAJRZkKrft9afW5lpn3yjefwZgRtCHD8cO
         g2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399769; x=1722004569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdlmiGKKf4P64YOv5lQSDuR8ybLle1v3kavGCeiCW+U=;
        b=ELr2Ija8IZpYYibhX/pjAdn+bKTwbAhoPA44TisYpFAM152S/VBEX3eMvEwm5brGCc
         y5xedcYLZlzWSakaxiivhZxQ16rvNp26qv2JippuNPQROulWUSLBcL2lLaxQrM3CCezT
         EaVE3kvcBbw4jSBPm4VBi9+6zBQOAAs2eNyjV64lbJ7Gs8GXRT0N+iZ7To7OKKL7tAyU
         2w7TF0dlfnsp9oNEB1PsSY4i9OmQjcg1Y/vL8oRZutbM2Jb7ialzVsA00MUgqBOsuoLj
         K9m/0UWYoMu7/BZFST9obXcSKPBAZNI4UzcshO6bKugQ11du+9Lr/Y6ScMyE+xP9YD35
         Z3mg==
X-Forwarded-Encrypted: i=1; AJvYcCV7/ngXZpk7P5LQncuvKLWiyjWnCtM+TjzQqtu13J07pcOnZqAGXtAOJ/Cx0gPW/TGNUHzxnPpDZleCcYJnHoP3UTdWpY0PP93McoPB
X-Gm-Message-State: AOJu0YwaQrov3zD1hwPpt/yannbQRDZJEMy9BJw0RtEq4ygGiLtb8kD6
	qg7GZnxwm880dNvIdwbJZk7NUoYF2jclXeKQasNCngYS+5mf9Y1D3K6ef7XJUw==
X-Google-Smtp-Source: AGHT+IFA/wA9e42Kh22TLUFramVCLKGDe8eWOeYO6wA/icFUlL9M4s7EtisnJ7yAOuE2+K35INQfAw==
X-Received: by 2002:a05:600c:4e90:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-427c2ce8d0emr61277055e9.29.1721399768362;
        Fri, 19 Jul 2024 07:36:08 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43034sm54732375e9.3.2024.07.19.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:36:07 -0700 (PDT)
Date: Fri, 19 Jul 2024 15:36:04 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 5/6] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <Zpp51BYWYFnZHVW1@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <ZoJsAyrmtge4mXJY@google.com>
 <ZoK6v2_pJnc57LHM@google.com>
 <ZpZEjW1m2LypTHjF@google.com>
 <Zppzj1oIDivlAFpP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zppzj1oIDivlAFpP@google.com>

On Fri, Jul 19, 2024 at 02:09:19PM +0000, Sebastian Ene wrote:
> On Tue, Jul 16, 2024 at 10:59:41AM +0100, Vincent Donnefort wrote:
> > On Mon, Jul 01, 2024 at 02:18:39PM +0000, Sebastian Ene wrote:
> > > On Mon, Jul 01, 2024 at 09:42:43AM +0100, Vincent Donnefort wrote:
> > > > O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> > > > > Define a set of attributes used by the ptdump parser to display the
> > > > > properties of a guest memory region covered by a pagetable descriptor.
> > > > > Build a description of the pagetable levels and initialize the parser
> > > > > with this configuration.
> > > > > 
> > > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > > ---
> > > > >  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 137 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > > > index 36dc7662729f..cc1d4fdddc6e 100644
> > > > > --- a/arch/arm64/kvm/ptdump.c
> > > > > +++ b/arch/arm64/kvm/ptdump.c
> > > > > @@ -14,6 +14,61 @@
> > > > >  #include <kvm_ptdump.h>
> > > > >  
> > > > >  
> > > > > +#define MARKERS_LEN		(2)
> > > > > +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> > > > > +
> > > > > +struct kvm_ptdump_guest_state {
> > > > > +	struct kvm		*kvm;
> > > > > +	struct pg_state		parser_state;
> > > > > +	struct addr_marker	ipa_marker[MARKERS_LEN];
> > > > > +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> > > > > +	struct ptdump_range	range[MARKERS_LEN];
> > > > > +};
> > > > > +
> > > > > +static const struct prot_bits stage2_pte_bits[] = {
> > > > > +	{
> > > > > +		.mask	= PTE_VALID,
> > > > > +		.val	= PTE_VALID,
> > > > > +		.set	= " ",
> > > > > +		.clear	= "F",
> > > > > +	}, {
> > > > > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > > > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > 
> > KVM_PTE_LEAF_ATTR_HI_S2_XN is actually a mask covering 
> 
> It is not a mask covering here but in the ACK kernel.

You're right, I should have double-checked upstream.

That said, how about we move this __after__ RW ? and just use "X" on .clear
so we can have something R W X ?

> 
> > 
> > KVM_PTE_LEAF_ATTR_HI_S2_XN_XN, KVM_PTE_LEAF_ATTR_HI_S2_XN_PXN and
> > KVM_PTE_LEAF_ATTR_HI_S2_XN_UXN. 
> > 
> > I believe here what we should do is something like?
> > 
> > .val = FIELD_PREP_CONST(KVM_PTE_LEAF_ATTR_HI_S2_XN,
> > 			KVM_PTE_LEAF_ATTR_HI_S2_XN_XN) | PTE_VALID
> > 
> > > > > +		.set	= "XN",
> > > > > +		.clear	= "  ",
> > > > > +	}, {
> > > > > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > > +		.set	= "R",
> > > > > +		.clear	= " ",
> > > > > +	}, {
> > 
> > [...]

