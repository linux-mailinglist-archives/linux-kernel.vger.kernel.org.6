Return-Path: <linux-kernel+bounces-236430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0491E237
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8505287A9E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C8161339;
	Mon,  1 Jul 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYpK1NmG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C716089A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843524; cv=none; b=nC7l3sCJZ0uNMcireV3Zd9PMEQwNzF1MxlVqAcfuK+fCQUF367n+HGVl4naGBibREBQ6+IFW2GB/StQmQ9Yyl6hntOk3lz++yhcP1at+vxW8cLwZP7hGQpyqHqIoNbsSDgsyV4FqvLbN4BTrw9LcVTsUVy8C4AuPyaMmxAWbo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843524; c=relaxed/simple;
	bh=ylIjIytNCS6g+buHRSvJY443NgCMp6CLLYYSc8yrqsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyq/sWTkxE3lJFkxIkAoeL688zAdt6bgpMpKTKkZk6TgP8a2y9eY5rIZ8nrSd6oDg+bXvtsyMDdj/nOcWWL2QFoRmbDYDd2wCk2BEs/uBH8rRfAkS733Y7CKCUpatZzzpYpV7VZ2qZoPfTqFtT425ppFGUvpNmF2BuBLb5vK0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYpK1NmG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424a3cb87f1so88175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843521; x=1720448321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iRQeefAgXsUamr4Ot8CeDDrfz8J0bienc8DMyyz7CU=;
        b=NYpK1NmGwG6WvuOiXAItAFoa4Io3y8CcQcjVY4rhmxazUwC5VB6DlpPuW8RwJU8q7G
         yPYbMZuqfzuid0pRAP+Z14l0B+bLE8UlzKGCVNwMEetGuQY0JqhgOZHZS3nLvLo6VlPo
         Os34j4CXnzucr0zy3OMDbVQcItV3gNn9KJAV4LLpMi+qR+q8m43YF5662nNeFFwy953Y
         oWgSkNVrmSnDdvt2MG7fWyb4WtaDOR2rXvX62o4izrEzYtaPUa+5ImQqvc2XKxquaMNX
         jO/3ywsxlhvs4yX9/e4gw7BacIDwFaRzehx1bm70RehuMt9VDlsygbVqH8wwGyyJVH6t
         ZnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843521; x=1720448321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iRQeefAgXsUamr4Ot8CeDDrfz8J0bienc8DMyyz7CU=;
        b=C63eUFyVzOr/phX6DZ+qLN+CjEqi5A26xEf8D6PgMg03XCO1EWBwqJJLbBG/dJ0xhI
         yx4m6jKEP6rF39VLoZsXe0pG492/r0+soSF61zjCTVakWZ9BNJyRF/O2QYtpDdlJtHEV
         6fSX4PT1KX76cKtIt5v3Z5lc27HAIQHojYhkv9YZOPTPXmSotC+sMOFLSm5d0wPRda9W
         dYo3R4H4AuH8kdArg+J/wlqWXjKrYu6fKwxDALpAHnsdYVN3/XFhXG3t2ox4crPmxYLA
         T1/CgcnzzzDeY39VJVMghaua92mbaIiJtvlxJrzDgVN4mYheFkHFJsewfDl3TaYKntde
         ZRVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJeXS15j5K2AbP+Pz4tCyGSDtztxvA9QMiBQ7XB9x2bTC8biymN/VZsW+2GV8ogrG4Q+0lfz4hsTCxyWwTYEgHC/+qBkAssYdMpECQ
X-Gm-Message-State: AOJu0YxY/GqCBQFdzXDorUz6aump/4pwRIfkox8n0EJWA+3MKp+bbMyy
	1H7QROSvqsgQA13hBqGKs0MpWEEprZqagjJeEsNSi49AiXstRlzjhPljiQSmUw==
X-Google-Smtp-Source: AGHT+IEJSpUxXnzmaKpeXZ9ZNc9ay9XiJ8uD9AmMNUm7TYpCOsXMWXwD4qP0QOho6uCBNDDg/b3sMA==
X-Received: by 2002:a05:600c:35c5:b0:424:8b0c:156a with SMTP id 5b1f17b1804b1-425777d21e6mr3583315e9.2.1719843521026;
        Mon, 01 Jul 2024 07:18:41 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af54ecasm154237255e9.12.2024.07.01.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:18:40 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:18:39 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
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
Message-ID: <ZoK6v2_pJnc57LHM@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <ZoJsAyrmtge4mXJY@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJsAyrmtge4mXJY@google.com>

On Mon, Jul 01, 2024 at 09:42:43AM +0100, Vincent Donnefort wrote:
> O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> > Define a set of attributes used by the ptdump parser to display the
> > properties of a guest memory region covered by a pagetable descriptor.
> > Build a description of the pagetable levels and initialize the parser
> > with this configuration.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 137 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > index 36dc7662729f..cc1d4fdddc6e 100644
> > --- a/arch/arm64/kvm/ptdump.c
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -14,6 +14,61 @@
> >  #include <kvm_ptdump.h>
> >  
> >  
> > +#define MARKERS_LEN		(2)
> > +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> > +
> > +struct kvm_ptdump_guest_state {
> > +	struct kvm		*kvm;
> > +	struct pg_state		parser_state;
> > +	struct addr_marker	ipa_marker[MARKERS_LEN];
> > +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> > +	struct ptdump_range	range[MARKERS_LEN];
> > +};
> > +
> > +static const struct prot_bits stage2_pte_bits[] = {
> > +	{
> > +		.mask	= PTE_VALID,
> > +		.val	= PTE_VALID,
> > +		.set	= " ",
> > +		.clear	= "F",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > +		.set	= "XN",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > +		.set	= "R",
> > +		.clear	= " ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
> > +		.set	= "W",
> > +		.clear	= " ",
> > +	}, {
> > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > +		.set	= "AF",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= PTE_NG,
> > +		.val	= PTE_NG,
> > +		.set	= "FnXS",
> > +		.clear	= "  ",
> > +	}, {
> > +		.mask	= PTE_CONT | PTE_VALID,
> > +		.val	= PTE_CONT | PTE_VALID,
> > +		.set	= "CON",
> > +		.clear	= "   ",
> > +	}, {
> > +		.mask	= PTE_TABLE_BIT,
> >
> > +		.val	= PTE_TABLE_BIT,
> > +		.set	= "   ",
> > +		.clear	= "BLK",
> > +	},

Hello Vincent,

> 
> When doing a kvm_pgtable_stage2_set_owner(), the walker will init a leaf which
> has both the table-bit and the valid-bit unset. I believe this would lead to
> spurious BLK annotations here.
> 
> The following should fix this problem:
> 
>   .mask		= PTE_TABLE_BIT | PTE_VALID,
>   .val		= PTE_VALID,
>   .set		= "BLK",
>   .clear	= "   ",
> 

Let me try this, thanks for the suggestion !

> > +};
> > +
> >  static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> >  			      enum kvm_pgtable_walk_flags visit)
> >  {
> > @@ -40,15 +95,79 @@ static int kvm_ptdump_show_common(struct seq_file *m,
> >  	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
> >  }
> >
> 
> [...]

Seb

