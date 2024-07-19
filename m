Return-Path: <linux-kernel+bounces-257508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6D937AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8751C21A37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82167145FF4;
	Fri, 19 Jul 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kTDTpv1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48E145A19
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406451; cv=none; b=JPMj+3H84F6eOhQmQRQEcqRbTmcMwtnFGixwupgvdn4hNtCRX3EyW9yQxOJxXw6KIN8v3AHvkHUH3q8jxTPKADfMs/CeUMafnhjBuLQsz5Cz7P9w18nWaGLMGWRhJ7GJqNxTnculQL2jaHi6fnJsnbdxhMcIDkz3ViQPBdJ9Oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406451; c=relaxed/simple;
	bh=1dmbpNdF8tQ+ese8igkpCby0IKOV/lsKj0bq8yiRx3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLSrlcIJOb+ythyVyrf9K9fNIUhQu7ITPbXNVG43u9H1et2pDzrdhcg5BWxbJc570TQ1vICmYTNnjm5INO2Hjn2CxO9TUpkPke+suv296OXFwhgnbkJ8ehmZbf/ggZBLT/Rdf9TDCsW3dUaSkVjdwsHl0xWcpoJ77ybQjn4WoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kTDTpv1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso18862a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721406448; x=1722011248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGU8cW7/Khkrbfb/2lGIxZ/ZxfwEJyBEaz42JmsrIJk=;
        b=0kTDTpv1kqzh1nHPVHjC0c6xFCX5CNbQ/9DiwmLKdw9iRWD0Ia5zXZOGMXLEXmn6qw
         E2hSaefF1VjrAsfUqhPK4lbvxlfHsuhoFQO8qp8uj01vfwFco+dkHaTO+1sesRkB5uwG
         A5t/Af491YLgW1IGIdJHR12bjWCgtJ7tytD5Gy2oU302pzmbv6acAeis2GdJy7zfLZpr
         w+tOKvYXGE9X1aHglTHP4tbtmUILSemoTeQm+/8oRog7nnXq5dtN4xFplQVZ80u1JFgY
         B4Q1SdnZGuIPgb7wTgoOuykPGm4tWAObm/P9fIWwalG6XKxnHzEPcLazzNUBeAzg4MO2
         sO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406448; x=1722011248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGU8cW7/Khkrbfb/2lGIxZ/ZxfwEJyBEaz42JmsrIJk=;
        b=YCPb5KWN8vP7DfLynTYod/trJnAaZR3ZCyxniiYd1rGMHVXymjTN8EKKbD87ZqOtWO
         /dXe3liifBRBhErtO4QcQvO+LFIWQ+l4i8DzoSIxK2rs/87vqWPA8T5YXHCIKT9Cniza
         wg1g50CXzKDzEFjpaq49NseFHchlePlqmO+NoHTO8Ip4gWmFKfIVFTej1cYJh3+WX36t
         7txhXGsNRk0laX+oQ9qIeTPkxC550tplC6rJySHnDHjIjd9w3NVzpGi7jKeC2BNSd4aT
         BjhDh18knVz3C3rv7ko614aFHctyMuWVeQTEdIXjaJZZtzlEPHniMBrM5ULHtnwG4BBQ
         gNHg==
X-Forwarded-Encrypted: i=1; AJvYcCUDtOQMN+ql+WckPCprUkGMAl+dQ5WsnsxRcVMRPc+N9T1wnc/idXy5ALRhaBcuEbJ7weyz6PH4UKRaz3bDsf4NDvjCOgF2zbschw43
X-Gm-Message-State: AOJu0YzIjwsntalErirxEI27/n5FnQN5U1uvuK7Jh6kkUOphl8k3n7GR
	HVDLPFuqI5JzT1/1FLoU/x3Y+qZ0V6s4HmB2M46d+0tZ+sS1V+VnMshRPpTwuw==
X-Google-Smtp-Source: AGHT+IF72w7nkWrKqo33SiqqgvDUo7jNwSKOMGsRU7zBoVw32YikfiO+r/b2VLJAOhl5RiyEVCCe1A==
X-Received: by 2002:a05:6402:5204:b0:5a0:d4ce:59a6 with SMTP id 4fb4d7f45d1cf-5a2c888c3d0mr284589a12.2.1721406447882;
        Fri, 19 Jul 2024 09:27:27 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868bc21sm2007071f8f.39.2024.07.19.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:27:27 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:27:26 +0000
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
Message-ID: <ZpqT7raWOhb3xQ12@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-6-sebastianene@google.com>
 <ZoJsAyrmtge4mXJY@google.com>
 <ZoK6v2_pJnc57LHM@google.com>
 <ZpZEjW1m2LypTHjF@google.com>
 <Zppzj1oIDivlAFpP@google.com>
 <Zpp51BYWYFnZHVW1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpp51BYWYFnZHVW1@google.com>

On Fri, Jul 19, 2024 at 03:36:04PM +0100, 'Vincent Donnefort' via kernel-team wrote:
> On Fri, Jul 19, 2024 at 02:09:19PM +0000, Sebastian Ene wrote:
> > On Tue, Jul 16, 2024 at 10:59:41AM +0100, Vincent Donnefort wrote:
> > > On Mon, Jul 01, 2024 at 02:18:39PM +0000, Sebastian Ene wrote:
> > > > On Mon, Jul 01, 2024 at 09:42:43AM +0100, Vincent Donnefort wrote:
> > > > > O Fri, Jun 21, 2024 at 12:32:29PM +0000, 'Sebastian Ene' via kernel-team wrote:
> > > > > > Define a set of attributes used by the ptdump parser to display the
> > > > > > properties of a guest memory region covered by a pagetable descriptor.
> > > > > > Build a description of the pagetable levels and initialize the parser
> > > > > > with this configuration.
> > > > > > 
> > > > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > > > ---
> > > > > >  arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
> > > > > >  1 file changed, 137 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > > > > index 36dc7662729f..cc1d4fdddc6e 100644
> > > > > > --- a/arch/arm64/kvm/ptdump.c
> > > > > > +++ b/arch/arm64/kvm/ptdump.c
> > > > > > @@ -14,6 +14,61 @@
> > > > > >  #include <kvm_ptdump.h>
> > > > > >  
> > > > > >  
> > > > > > +#define MARKERS_LEN		(2)
> > > > > > +#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
> > > > > > +
> > > > > > +struct kvm_ptdump_guest_state {
> > > > > > +	struct kvm		*kvm;
> > > > > > +	struct pg_state		parser_state;
> > > > > > +	struct addr_marker	ipa_marker[MARKERS_LEN];
> > > > > > +	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
> > > > > > +	struct ptdump_range	range[MARKERS_LEN];
> > > > > > +};
> > > > > > +
> > > > > > +static const struct prot_bits stage2_pte_bits[] = {
> > > > > > +	{
> > > > > > +		.mask	= PTE_VALID,
> > > > > > +		.val	= PTE_VALID,
> > > > > > +		.set	= " ",
> > > > > > +		.clear	= "F",
> > > > > > +	}, {
> > > > > > +		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > > > > +		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > > 
> > > KVM_PTE_LEAF_ATTR_HI_S2_XN is actually a mask covering 
> > 
> > It is not a mask covering here but in the ACK kernel.
> 
> You're right, I should have double-checked upstream.
> 
> That said, how about we move this __after__ RW ? and just use "X" on .clear
> so we can have something R W X ?
> 

Yes that's a good ideea to improve output format, let me move it.

> > 
> > > 
> > > KVM_PTE_LEAF_ATTR_HI_S2_XN_XN, KVM_PTE_LEAF_ATTR_HI_S2_XN_PXN and
> > > KVM_PTE_LEAF_ATTR_HI_S2_XN_UXN. 
> > > 
> > > I believe here what we should do is something like?
> > > 
> > > .val = FIELD_PREP_CONST(KVM_PTE_LEAF_ATTR_HI_S2_XN,
> > > 			KVM_PTE_LEAF_ATTR_HI_S2_XN_XN) | PTE_VALID
> > > 
> > > > > > +		.set	= "XN",
> > > > > > +		.clear	= "  ",
> > > > > > +	}, {
> > > > > > +		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > > > +		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
> > > > > > +		.set	= "R",
> > > > > > +		.clear	= " ",
> > > > > > +	}, {
> > > 
> > > [...]
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

