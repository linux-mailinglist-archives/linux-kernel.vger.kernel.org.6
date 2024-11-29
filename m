Return-Path: <linux-kernel+bounces-425581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47049DE703
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E967164C19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339119E83E;
	Fri, 29 Nov 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHK7crIE"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B841156991
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885850; cv=none; b=RO1QCyU8uGEk8APUmu+wNKBywLR+vthLGZe7leBC2T8JKFWD7oeCxtrseeTozDpoZ/6jF1aj08cWl+QWeVkjiHmC6Gi1eYIS8I+wNXGztFOIPMKOd5sxvUW6WQRIGZ3niqoa6+fnliHr6p1ZB4tJ5LI6G0/wCtKT0mEF3Fw7nI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885850; c=relaxed/simple;
	bh=2tCjuOPED//3wVHlOYnA5EqRmXXYDjuVZ5VnkrbozuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMmvdFS97O6D53teRdNawQCj8R34ifEZ376YzpQRIk4kfrqjrZQiheqC/5oOgf0oeX9VS+5Ph7V6rb9tPdmrvk43pRMGPVekTzPq/yNjIGTARNtQXKAfwyvtT8JhTqIs40BhKkzBM/mm7pf+BrLgPs368X6jYFbgJMW++4gK0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHK7crIE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e8522445dso234275666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732885847; x=1733490647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm3r4VcFovoN7vV/Z/7/O6DCsQhUW6XXm/ZhBzyEdx0=;
        b=cHK7crIElqwZNyMUWB5t5Iw3Fenz+MyYSJVEa5GzpoqqOk1eeoDVqRECoWabD0UcOB
         gM4DUW3uW9xobEqEO96bUl8RNRwN89Pnq274k36I4uX6nED5fQllY5utRnwSX7nbh7jW
         Z/I54ugj7JW4h0zovkcHTNtf8+oO+UD/cUTLBgZaFii2Ea3k8X6zbfbc5s/+dp0soW67
         EwP0z5YRhlj1k7dugFK7wa6PX/W8ECCJjG7aEWlyqGbubxLKqtqddjiRfr0iQvZ6Q0q6
         Yoq59fHHdUf7VaB2v35xKwkOuEJRaFGjOHgf1kvk+aXolJJG+o7quCM8NDxHOiNQNjiD
         dR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885847; x=1733490647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm3r4VcFovoN7vV/Z/7/O6DCsQhUW6XXm/ZhBzyEdx0=;
        b=Uj2/36sHGzlfelF83Alz3muCuNVK9GGqW2Z5eYuFGDfJoVW6XdprtEFbe8a24tcw68
         aJXtmWwL5Svh8kXHfm2viL8XBsrix6LwR0xjg0m8dTv3biwJv22nHruee35ca1NpNOQf
         FAxRlHUnpINodi2EwPvJzdkfptlzSTZswsDYaD22OeNjfWIndhTAYJUdmsGS7xOYx+Cx
         mIs1TDVw5NmvaKhywECV9YEF6UhygWSLsOLE5a1mF+2/xLh9r+j8oJaEqQlnw346cSeZ
         dnU1oN82meV6ORuBNUQJkXOlKfAu71/oGFK3j7heuRexP62oV1Zg4GndH7d+hEn6WIc4
         DvVA==
X-Forwarded-Encrypted: i=1; AJvYcCWER8IL4hpCqgyYwChSWTeinRH7/oeQkz1jCUVQowefCc+LnfMlvBmUZEf1sps9cOCJjJyk40I6hHenb5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BkyIGCsLLm9StQritjcqsQ24FzXnXPIwaZthQtgEkZOtUbZ+
	4zhe71V2JEKXWLBWDtg3sVY8VLlBNiz6KD7rI2NdDQLlsRMqxPC9K1Qxi4RVXg==
X-Gm-Gg: ASbGncuyNuMIFQbgMBc9KK3Qgiq65O9BjxfQOHUlTTR4wIagKQqyHNZMBVj2Qih9MXp
	Gk5WCemDUqb2pA5XtjBvxjhuixt6TjCY/UyRLMWDpNptnRRLUTcnOh9b9gKnxeSMaHc0BW/8JIf
	R1J59kAZbDoH+AF9veZwpc2tezN+S5SxEMW7sR/kfxfczq1P9/spODNkcAvHnTLv9SV0n1sZ0Vd
	a31WMcbVLY054Hveq2ScnwY49Vosu+MHdjfVK67+JWbGmFx2AOMV2gCO6sP2EWKlAcEFWhWVKDG
	BY1Grc69
X-Google-Smtp-Source: AGHT+IEWryAv62jI6ZAYM2AouC0F8zHOcrJl/X+93V7MahOSmgmNr39a624Qy4c77JELRVfcnOj3xA==
X-Received: by 2002:a17:907:7852:b0:aa5:1d0c:3671 with SMTP id a640c23a62f3a-aa580f2c498mr828473066b.23.1732885845504;
        Fri, 29 Nov 2024 05:10:45 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55eesm172306766b.80.2024.11.29.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:10:45 -0800 (PST)
Date: Fri, 29 Nov 2024 13:10:41 +0000
From: Quentin Perret <qperret@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Always check the state from hyp_ack_unshare()
Message-ID: <Z0m9UXJYcjzf-pgX@google.com>
References: <20241128154406.602875-1-qperret@google.com>
 <20241129095812.GA4298@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129095812.GA4298@willie-the-truck>

On Friday 29 Nov 2024 at 09:58:13 (+0000), Will Deacon wrote:
> On Thu, Nov 28, 2024 at 03:44:06PM +0000, Quentin Perret wrote:
> > There are multiple pKVM memory transitions where the state of a page is
> > not cross-checked from the completer's PoV for performance reasons.
> > For example, if a page is PKVM_PAGE_OWNED from the initiator's PoV,
> > we should be guaranteed by construction that it is PKVM_NOPAGE for
> > everybody else, hence allowing us to save a page-table lookup.
> > 
> > When it was introduced, hyp_ack_unshare() followed that logic and bailed
> > out without checking the PKVM_PAGE_SHARED_BORROWED state in the
> > hypervisor's stage-1. This was correct as we could safely assume that
> > all host-initiated shares were directed at the hypervisor at the time.
> > But with the introduction of other types of shares (e.g. for FF-A or
> > non-protected guests), it is now very much required to cross check this
> > state to prevent the host from running __pkvm_host_unshare_hyp() on a
> > page shared with TZ or a non-protected guest.
> > 
> > Thankfully, if an attacker were to try this, the hyp_unmap() call from
> > hyp_complete_unshare() would fail, hence causing to WARN() from
> > __do_unshare() with the host lock held, which is fatal. But this is
> > fragile at best, and can hardly be considered a security measure.
> > 
> > Let's just do the right thing and always check the state from
> > hyp_ack_unshare().
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index caba3e4bd09e..e75374d682f4 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -783,9 +783,6 @@ static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
> >  	if (tx->initiator.id == PKVM_ID_HOST && hyp_page_count((void *)addr))
> >  		return -EBUSY;
> >  
> > -	if (__hyp_ack_skip_pgtable_check(tx))
> > -		return 0;
> > -
> 
> Acked-by: Will Deacon <will@kernel.org>

Cheers.

> I suppose __hyp_ack_skip_pgtable_check() is now quite poorly named,
> since we only want to use it in cases where the page is PKVM_PAGE_OWNED
> by the initiator.

I don't mind the name personally, but happy to respin if someone can
come up with a better one :-).

> Hopefully nobody smart tries to add it back here!

Right, so here's a patch adding a selftest for this stuff:

  https://lore.kernel.org/kvmarm/20241129125800.992468-1-qperret@google.com/

That should help catch future regressions in that area.

FTR, I've started hating on the skip_pgtable_check() logic altogether as
enabling CONFIG_EL2_NVHE_DEBUG happens to 'solve' the problem -- it's not
exactly intuitive that enabling debug options improves security. The
np-guest series moves the host state to the hyp vmemmap, so we can
probably nuke __host_ack_skip_pgtable_check() with that as the check
becomes really cheap. And we could surely do the same thing for the hyp
state, and just always do the cross-check. I'll give it a spin.

Thanks,
Quentin

