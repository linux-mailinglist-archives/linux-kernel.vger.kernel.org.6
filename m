Return-Path: <linux-kernel+bounces-257348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3909378DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B748A1F22CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC06144316;
	Fri, 19 Jul 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2YEp7ol"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5413F431
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397681; cv=none; b=B3OYQbaXUnDGCMTGY/TgXhg6aDcCKOk8NYphfAyglgNczr+2i9d/5/pfajh2IS/p7/yNHFUzt8v17wgUt15lrleHAMfi8V1jHsbGPjww63BJhYjDfpiixgozpT95zvEbA/3VtCHESmv0DDwRlS0FizIRqSNK/OroSF33K0hYt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397681; c=relaxed/simple;
	bh=eKr/Whu/6udWU/mKOmKQc4mkH3IN7O/qghdeq2l6tCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPhfZZlnSB/LgRV3nShwTgSfRs1STt1UzVAHUgLQAID7bJazirOd0DYjKbbFS9y2KSokosBBJ9ve3yY4rX78LYBBZARBtgZYah5wranq7ptt4tY0junezsx14VMjg6CSeuUn1buAQ3Wnhw/yFrJRMzBsBNBjnkljR0bb7MNkkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2YEp7ol; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266edcc54cso45925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721397678; x=1722002478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc/lvxk1g3HuegnXaisJU/OL2Ih+Ws0A6QMr/ME/lAs=;
        b=R2YEp7olq3JQc9p3B514P79TdcxyAkGWn0AClJCkUbuwj3thJO1oPEznnnIK+0Kr2C
         E63Yh8cIoDEWWL8UiESibAhhPhrqndoCC/z93gLi0uOrw3YWQVbavu8Wrpz/Qjt7rEN8
         eV9t0zwH0C6ir8wLCKEYCUSytiUGQAO1vfb7pzq1OVnGzMZG7+PAXYrYRgGo8By/W2go
         BA/pCnQfkzuVcG5e76Is9WmszkPlinLKq3W8ok7MDF/xuV5H3Pw6DLMj3f4kzy9x2zn5
         u183gl3/oqkd0D4PnDSC2dgyai+BJweK2OKn2xJ8yL+0cixLr3xGZW8agyVtl7kLRnub
         dWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721397678; x=1722002478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc/lvxk1g3HuegnXaisJU/OL2Ih+Ws0A6QMr/ME/lAs=;
        b=elvYwQ31ok2t1S7D0v5ESK3Nm+glUYkXwsfynomOESv5e7Ohpd6NfYGDLZs/I0+AGX
         mAbBhNlLW8FWFExNj+W9xYnGz+aDwshkg8gtosXpcH9TUz3Qz52zip/AbEn9oRsvdZDA
         XMJiaJX9MEecapU7MKae9ZGQ2R1+RkpfHiFwIcb16J4tZzce/hQlGXwwR4re8EvNYlwz
         adNTBAibqPQZa8JC8CrEaUGFiX9LGc0D5MyftW1559LwhuClZyUVMJ6RSuJoTgLNoyeL
         Jex5D7TN7somRt0hjImFxZ7jUZB1gRaeHxnBN+fa+hgUks2eDw6w0dWGophNnMsNGqw2
         Jfhw==
X-Forwarded-Encrypted: i=1; AJvYcCXB8vaOGDVt2bfaqgWyrMYYs8IBrnh6QQFVK1DhiKy0GcS/SbhkLUc4GrQ0XcR/v+GAzDPmlBPrDcLu7CWp1SWiR8rioeeIqa3kYg50
X-Gm-Message-State: AOJu0YzQ4qr2gAxLiynnUq6/lxXXpPEuc7L5xOvZdhvRytwlZQG8/C4N
	VZZcTcg8JufEjypSm2EAwksbGXvqM7HbmtsCryr9tfNjJ/CNExfpYjCFN7sLjA==
X-Google-Smtp-Source: AGHT+IGtGTacUit9HaIrHSZTBHJdDYIrRZbK5puBsJayYiuB18xnHZFiAxAnBCnQocCzhGwWjeN0pQ==
X-Received: by 2002:a05:600c:5683:b0:424:898b:522b with SMTP id 5b1f17b1804b1-427d69c0713mr1086675e9.1.1721397677189;
        Fri, 19 Jul 2024 07:01:17 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6906a96sm26412155e9.22.2024.07.19.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:01:16 -0700 (PDT)
Date: Fri, 19 Jul 2024 14:01:15 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, maz@kernel.org,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 5/6] KVM: arm64: Initialize the ptdump parser with
 stage-2 attributes
Message-ID: <Zppxq_8OC56HRHfi@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <Zn8omLmCSIHun1uq@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8omLmCSIHun1uq@linux.dev>

On Fri, Jun 28, 2024 at 09:18:16PM +0000, Oliver Upton wrote:
> Hi Seb,
> 
> On Fri, Jun 21, 2024 at 12:32:29PM +0000, Sebastian Ene wrote:
> > Define a set of attributes used by the ptdump parser to display the
> > properties of a guest memory region covered by a pagetable descriptor.
> > Build a description of the pagetable levels and initialize the parser
> > with this configuration.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> 
> This patch should come *before* patch 4, no point in exposing the
> debugfs file if we aren't ready to handle it yet.
> 

This is true but this patch doesn't make sense without 4 because here I
add a bunch of functions which will not be invoked (they are invoked
from the debugfs calls).

IMO we can squash them (4 and 5) but it will be a bit harder to follow.
Let me know what you think, thanks.

Seb

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
> 
> <snip>
> 
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
> 
> </snip>
> 
> Neither of these bits are used at stage-2, why have descriptors for
> them?
> 
> > +static int kvm_ptdump_build_levels(struct pg_level *level, u32 start_lvl)
> > +{
> > +	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
> > +	u32 i = 0;
> > +	u64 mask = 0;
> > +
> > +	if (start_lvl > 2) {
> > +		pr_err("invalid start_lvl %u\n", start_lvl);
> > +		return -EINVAL;
> > +	}
> 
> 	if (WARN_ON_ONCE(start_lvl >= KVM_PGTABLE_LAST_LEVEL))
> 		return -EINVAL;
> 
> > +	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
> > +		mask |= stage2_pte_bits[i].mask;
> > +
> > +	for (i = start_lvl; i < KVM_PGTABLE_MAX_LEVELS; i++) {
> > +		strscpy(level[i].name, level_names[i], sizeof(level[i].name));
> > +
> > +		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
> > +		level[i].bits	= stage2_pte_bits;
> > +		level[i].mask	= mask;
> > +	}
> > +
> > +	if (start_lvl > 0)
> > +		strscpy(level[start_lvl].name, level_names[0], sizeof(level_names[0]));
> 
> This should pass the size of @dst, not the source. This becomes slightly
> more self-documenting if you use a literal for "PGD" here too.
> 
> 		strscpy(level[start_lvl].name, "PGD", sizeof(level[start_lvl].name));
> 
> > +	return 0;
> > +}
> > +
> > +static struct kvm_ptdump_guest_state
> > +*kvm_ptdump_parser_init(struct kvm *kvm)
> > +{
> > +	struct kvm_ptdump_guest_state *st;
> > +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> > +	struct kvm_pgtable *pgtable = mmu->pgt;
> > +	int ret;
> > +
> > +	st = kzalloc(sizeof(struct kvm_ptdump_guest_state), GFP_KERNEL_ACCOUNT);
> > +	if (!st)
> > +		return NULL;
> > +
> > +	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
> > +	if (ret)
> > +		goto free_with_state;
> 
> I don't see any value in the use of goto here, as there isn't any sort
> of cascading initialization / cleanup. This also presents an opportunity
> to get an error back out to the caller.
> 
> 	if (ret) {
> 		kfree(st);
> 		return ERR_PTR(ret);
> 	}
> 
> > @@ -57,22 +176,34 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
> >  static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
> >  {
> >  	struct kvm *kvm = m->i_private;
> > +	struct kvm_ptdump_guest_state *st;
> >  	int ret;
> >  
> >  	if (!kvm_get_kvm_safe(kvm))
> >  		return -ENOENT;
> >  
> > -	ret = single_open(file, kvm_ptdump_guest_show, m->i_private);
> > -	if (ret < 0)
> > -		kvm_put_kvm(kvm);
> > +	st = kvm_ptdump_parser_init(kvm);
> > +	if (!st) {
> > +		ret = -ENOMEM;
> > +		goto free_with_kvm_ref;
> > +	}
> 
> (with the earlier suggestion)
> 
> 	st = kvm_ptdump_parser_init(kvm);
> 	if (IS_ERR(st)) {
> 		ret = PTR_ERR(st);
> 		goto free_with_kvm_ref;
> 	}
> 
> Otherwise genuine KVM bugs (-EINVAL) are getting lumped into ENOMEM.
> 
> -- 
> Thanks,
> Oliver

