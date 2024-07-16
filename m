Return-Path: <linux-kernel+bounces-253592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C094932381
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F0B1F21E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50601197A7D;
	Tue, 16 Jul 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXP9s1Oj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A225624
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123989; cv=none; b=VICaEpSyIqekTHKHDEasX3CEXoyfvwCZF0SMNCU3XxUypuGLqmrlHlaK6Q2xgKQX4DOHmXkRV+tO02ATy5VCu65LjmL2qPza81LYtExL4h2e4ybSb/yp/cz6oTD3XxRDnPW0dsWzBQR2wHQFqgCmE+YzT5YQJ3MYc3iSEsf4PLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123989; c=relaxed/simple;
	bh=t8aLSjzjauG7Ud/wMgIkxjFDcS/pCbqDGOTsvtDGzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPbYzuspNgxAhoo5T6EnZU+tNjpOzF+G+czZA+A9/BdRKHVBBTtixLX2xSJiGi0hyq3e3BVk5h/3yQcJGubzPDx+Evmu/9WokQSGUKGSMHte0EXbKhTfQ74WyLnruwsf0xDG6aG/rnkMU5XLE4LlGdQ48r95uCk9oVAHu8UeLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXP9s1Oj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368255de9ebso338700f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721123986; x=1721728786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB06lOjeb/uE3iisxwCP6Tm1CK/MivC/LclbamO9xAM=;
        b=VXP9s1Oj3iGMcqndS2vHvmUU54JY1qGER4Ve/xCNX/gL5JU/XZtQ4vqi00ujYwtsCi
         d3EZbRgTsU93h7Nj/SR2RsC1k5bRg7nHF5mTj4LBbhZi7sSstl4cLgCASHnKMkLrHJky
         2ZqQ6e7oDeJ5xWzXVsDm0qkFhEWWSCbWEFw0uW+qL4khgzf01SBdSsb/qG0StXrmFt3N
         iFHIdwJh6DHSi7/ZyuqybyB6j3l/GZcjWKzplhhxvJtyitH8iMBYZHYEvcTwfz3zyykQ
         Q2nwQKcUcS3ns069WiDgoP1doiP8UY1p/PI9tHv/sTfoTiQk3wZN8zTz7G8OkBd688OC
         YqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123986; x=1721728786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB06lOjeb/uE3iisxwCP6Tm1CK/MivC/LclbamO9xAM=;
        b=wAlhzTodWnLOg/pg2WJtquxPRRs0KHcVbgwAxR9KXpwpZpcoLNT15Vetv+HZkmsusW
         qZyV9onZyBW7Q7FLtZacqWti0ORklm9nm3CqVDpgvdWLBUUmrNNT6xI/Z81+EjRaOMik
         y0euhmbFqkgTHjILJ3o+pJDkjWwJ8E2qXxOietG2PIclwD/4FqkRLFlu26uaTcS3nsIZ
         8oDVKRwQYKzfBLy7a1QVkuYD5C9j38OXv8boohr4TtP0lbas6ahuLng5NDYeRQSBXMUE
         JsV9M1n8nzY7LnNe6Zq5AvjXTvgkNzx4rib5CCcPSthuvSqcOUzpHUuNFjOoMvMLq3JJ
         EnQg==
X-Forwarded-Encrypted: i=1; AJvYcCVsRX8C0VfoqBO5i1CjlZPby8PudA1wY3h7cfSj1nUzg8IJ7NtsxCJKjEHD5z2HXQMVB0V0ais1gCLT9plU/Rgl2o26Ie7khO6jjA6R
X-Gm-Message-State: AOJu0YwBicVbqQGlhXMIQSPjkrokzssJ6Tghxn5TA0Cy6tr0oOQ9nrMm
	YSEx2dM7Y8VHDJ62KWj3waRdBWv4OI5epjCF1ZtNTrBqFSz4sv8bfr1bhDwoGg==
X-Google-Smtp-Source: AGHT+IF69v24Yzf9m7VOZnyEAWiFMAW/hbg7ZrSdOQ+vI1WyHZxOGGlPFzoPDdIVKnZQD4NsWWgIYA==
X-Received: by 2002:a05:6000:1e4e:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-36827498d65mr1116597f8f.25.1721123985921;
        Tue, 16 Jul 2024 02:59:45 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbe9esm8515847f8f.78.2024.07.16.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:59:45 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:59:41 +0100
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
Message-ID: <ZpZEjW1m2LypTHjF@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <ZoJsAyrmtge4mXJY@google.com>
 <ZoK6v2_pJnc57LHM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoK6v2_pJnc57LHM@google.com>

On Mon, Jul 01, 2024 at 02:18:39PM +0000, Sebastian Ene wrote:
> On Mon, Jul 01, 2024 at 09:42:43AM +0100, Vincent Donnefort wrote:
> > O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> > > Define a set of attributes used by the ptdump parser to display the
> > > properties of a guest memory region covered by a pagetable descriptor.
> > > Build a description of the pagetable levels and initialize the parser
> > > with this configuration.
> > > 
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > ---
> > >  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 137 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > index 36dc7662729f..cc1d4fdddc6e 100644
> > > --- a/arch/arm64/kvm/ptdump.c
> > > +++ b/arch/arm64/kvm/ptdump.c
> > > @@ -14,6 +14,61 @@
> > >  #include <kvm_ptdump.h>
> > >  
> > >  
> > > +#define MARKERS_LEN		(2)
> > > +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> > > +
> > > +struct kvm_ptdump_guest_state {
> > > +	struct kvm		*kvm;
> > > +	struct pg_state		parser_state;
> > > +	struct addr_marker	ipa_marker[MARKERS_LEN];
> > > +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> > > +	struct ptdump_range	range[MARKERS_LEN];
> > > +};
> > > +
> > > +static const struct prot_bits stage2_pte_bits[] = {
> > > +	{
> > > +		.mask	= PTE_VALID,
> > > +		.val	= PTE_VALID,
> > > +		.set	= " ",
> > > +		.clear	= "F",
> > > +	}, {
> > > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,

KVM_PTE_LEAF_ATTR_HI_S2_XN is actually a mask covering 

KVM_PTE_LEAF_ATTR_HI_S2_XN_XN, KVM_PTE_LEAF_ATTR_HI_S2_XN_PXN and
KVM_PTE_LEAF_ATTR_HI_S2_XN_UXN. 

I believe here what we should do is something like?

.val = FIELD_PREP_CONST(KVM_PTE_LEAF_ATTR_HI_S2_XN,
			KVM_PTE_LEAF_ATTR_HI_S2_XN_XN) | PTE_VALID

> > > +		.set	= "XN",
> > > +		.clear	= "  ",
> > > +	}, {
> > > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > +		.set	= "R",
> > > +		.clear	= " ",
> > > +	}, {

[...]

