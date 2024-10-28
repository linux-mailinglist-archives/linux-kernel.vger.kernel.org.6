Return-Path: <linux-kernel+bounces-385566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008029B38BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4C6287253
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6781DF75E;
	Mon, 28 Oct 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLxE4szh"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01928189B98
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138824; cv=none; b=ltrpYkT2V08vlA9QOqtleLIFmVTTcEx0gCc+EIh40b/JJVvcdEk7aEgBiicB2ky0lKJ1hLOpt286fdaJBPHLS8TzunhNa+/YoApJNKkXOL8ANKd7Qc9NTGHuRXhlyue8UcB0CscaJGBnOCpw4QUFB5q5z3OvGjl8ALCjbYWIdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138824; c=relaxed/simple;
	bh=906Xwqc5BLZHTLhmXAaRwWo5+JImUIzliYYeDlqxCT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SWvJo1ZrCNur8oRMCjiiqmfa+ym4pYgwxXRKiHcrGdaE9xEToeFTWiN6NWfdwC3Scd8TDkqYmrlNWsvJopE1kOrIjtRxr0BVTiWXFLNnKDkkNQnCnUiRMk0F96BUDvMQsEG+qwsg0fzTzhryYZoiXcPGQpMRYaBjPZy3h5YE3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLxE4szh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e55c9d23cso3522984b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730138821; x=1730743621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSPXfhYXFqsav+wNvpf5kcVIJjv343m6ZpWPKhJ4i1M=;
        b=CLxE4szhYoLXxWaMp45xVw572QDxCD3LdBzXZEaYmRbyRhCoQVoYHKtZuqGrAAFIbH
         TUEFfVzXvcyCVemN8oiIgFpc0/6tQiRopSwYnyFpbj01KH90i08OzRCiQXljzVkL0tPY
         Nf+FUgPy5clE9q/vKmBMgNl5HPzfLKZRKQz8eWrqG9YZQe7hiqVmqZ+h/U5s2iLTPuLD
         fXQcicHb6GUqYrMWP+tKzHUtBWPtC7n51api8eKkzheu+IGOwSh/YOUMAgr/tkXB5/hb
         LL12ijvhpgliJ+5vPL3KGoLtWpyjrbpa79steucsYpA0M9+AK1OcMyIlTl4IDcQzAxt+
         7vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138821; x=1730743621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSPXfhYXFqsav+wNvpf5kcVIJjv343m6ZpWPKhJ4i1M=;
        b=nVixeiZE8QtUGDmEE8DCN5c1tKOioSkiM1OEC0y28PMDWVnjeopxtDFW6qXRKBBPap
         9ax/O3L8C86TLqi+E9nFd1/Ds3nAJSVtJ5yCG2t2Dd7TJoz8Awgd+OPKt1pbcTuLcQkK
         zIz9cQdo5Q+9ccDCuo0yzPgMU852GDJmx9oGGG8xaRYFqiloe0cfpj/Jju1DUGsX5JXA
         dk+gy4tCGuvAVkUYAZUpDxc18OHDWTJPeynwYwhcCbG8OQ0TsKaFsFIjS3N59S3owSlY
         KJlufn3Ia7okYXlIUCKx3uw9M8iSGnPCSNe0nheFIgM4IHkSgQ1xlCQCSVjgYoI5nNKU
         6oUA==
X-Forwarded-Encrypted: i=1; AJvYcCVhiG2PICgGhe7GDygEayi/ZP33ktHCF2xoaX0hQMdGke+T4LKZUY5jJ73I74478c4L95oelRCx3UYamfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMguAxjY+fpb3zVyCztjzfloI+2GAtMFXGD50uA9ZGtPLW/tM/
	kam7F/+g/wBo+NDtlQJGiUInSN47OfmXsJ8fQc5+u1obeuF8thQxmN+IVp3DZ3mSTLN5142rZ7B
	nbA==
X-Google-Smtp-Source: AGHT+IGEphgAMJPO1RrBvORQ8s/TYfMNYCHByxWeAm23fw9VpJx73ZRrDNmOoAg0zAywWzMIM+hx0G5Vf7Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f64:b0:720:3b92:da02 with SMTP id
 d2e1a72fcca58-7209257ee6dmr6558b3a.1.1730138821179; Mon, 28 Oct 2024 11:07:01
 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:06:59 -0700
In-Reply-To: <Zx_NgJnjsGIrW4uF@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028170310.3051da53@canb.auug.org.au> <Zx_NgJnjsGIrW4uF@arm.com>
Message-ID: <Zx_Sw8XVHeaD4ya6@google.com>
Subject: Re: linux-next: manual merge of the kvm tree with the arm64 tree
From: Sean Christopherson <seanjc@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Will Deacon <will@kernel.org>, 
	KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Yang Shi <yang@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Catalin Marinas wrote:
> On Mon, Oct 28, 2024 at 05:03:10PM +1100, Stephen Rothwell wrote:
> > Today's linux-next merge of the kvm tree got a conflict in:
> > 
> >   arch/arm64/kvm/guest.c
> > 
> > between commit:
> > 
> >   25c17c4b55de ("hugetlb: arm64: add mte support")
> > 
> > from the arm64 tree and commit:
> > 
> >   570d666c11af ("KVM: arm64: Use __gfn_to_page() when copying MTE tags to/from userspace")
> > 
> > from the kvm tree.
> [...]
> > diff --cc arch/arm64/kvm/guest.c
> > index e738a353b20e,4cd7ffa76794..000000000000
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@@ -1051,13 -1051,11 +1051,12 @@@ int kvm_vm_ioctl_mte_copy_tags(struct k
> >   	}
> >   
> >   	while (length > 0) {
> > - 		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
> > + 		struct page *page = __gfn_to_page(kvm, gfn, write);
> >   		void *maddr;
> >   		unsigned long num_tags;
> > - 		struct page *page;
> >  +		struct folio *folio;
> >   
> > - 		if (is_error_noslot_pfn(pfn)) {
> > + 		if (!page) {
> >   			ret = -EFAULT;
> >   			goto out;
> >   		}
> > @@@ -1099,12 -1090,8 +1097,12 @@@
> >   			/* uaccess failed, don't leave stale tags */
> >   			if (num_tags != MTE_GRANULES_PER_PAGE)
> >   				mte_clear_page_tags(maddr);
> >  -			set_page_mte_tagged(page);
> >  +			if (folio_test_hugetlb(folio))
> >  +				folio_set_hugetlb_mte_tagged(folio);
> >  +			else
> >  +				set_page_mte_tagged(page);
> >  +
> > - 			kvm_release_pfn_dirty(pfn);
> > + 			kvm_release_page_dirty(page);
> >   		}
> >   
> >   		if (num_tags != MTE_GRANULES_PER_PAGE) {
> 
> Thanks Stephen. The resolution looks fine

Looks correct to my eyes, too.  Thanks Stephen!

> and I'm happy to leave to Linus to fix it up during the merging window.
> 
> To the KVM maintainers, if you prefer a conflict-free linux-next, feel
> free to pull the arm64 for-next/mte branch with the above commit (and a
> kselftest). The other way around is not something I'd suggest we do,
> there are over 80 patches in that kvm series.

Not feeling lucky today? ;-)

