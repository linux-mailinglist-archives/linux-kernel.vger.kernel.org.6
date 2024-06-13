Return-Path: <linux-kernel+bounces-214108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9E907F86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6CB282EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689A14D703;
	Thu, 13 Jun 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sasEoIn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549C14E2E7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321608; cv=none; b=WnF2DyOHa5Hpc+yRKyAkbDznrd3rUGh6Xx8AK97l+BVUKMG73EbIglHDPWDMgdwgfFa2ywP659Y06SdzcbPj7GCzFe/Ne3eO4boGDJHB7sthoGDJzqNgh3CXwmSn+FOlRU/k3QqH9xSSMkQn9OX7Tu9TrS5i0dGaKO4y15D6Nlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321608; c=relaxed/simple;
	bh=qAt2UhvpvEnOSzh/aTun94gQOxAFglIb1x68LgT5u/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fh/tQs0cMeULRIvW5fohMdGvGC0k+XPf+aqEhRFkWiIE73MwZ5D2yir9Crp5etxMGYHdFO3hie8WS1JbZkRge1pwCNCPsv154a6TA8uxSK88HBGEUoaRDXgQ6ozYdWBk2S0e+Ku+FHKTxuzhO4jjBcZNt3m4xGyhuMavThr8eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sasEoIn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfeff072f65so2455518276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321606; x=1718926406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/IekIUszeeugklFzZ/8PWVNYpSQN15CTup3urqE43g=;
        b=4sasEoInUqj1CeNY/ryElq34gXJktIoRPvl46p/YjtKF/YaLvsItdqF90lJeAoBwHr
         xuj/4z8sx9kBxvVigH9tIzjDRKfVqaak12gq8Tt0Ra5mdgHJwbUStxyCr9CzKGBmmPOw
         xcroUBlF0+aF4gEQqz5YuJ5ERwKRzlNHPHijfPa7364q9DElP3vccPzSjSyIyPbUzaa3
         Bnq8iB5XkxlIgZYOgawDvc7CutvMu3Wokx1UKihu6heFWIfnmRqQNKGgrBewUfqsiLF9
         tDkbWQ+Bk1DmlLBQFygDsmBzuvgZh9x8a3CjTSQ/RMmDw89BAfLYhhsF6bgVFE42Sqdi
         Tm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321606; x=1718926406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/IekIUszeeugklFzZ/8PWVNYpSQN15CTup3urqE43g=;
        b=RoAuFup3gplj3qkp5qfw69mHMJGcp1mbjDDfGT7BuuDAAa3VA4IjGnM2lbwce9VFXR
         JQ+avyG0XTaiHrESgv3vv/jcvDWOlunE7syrLC6rlJfEeMFSYdiaA9QoyGJLij5J52LX
         53qSE4wOfnyBB8QJ+d51e9nIA82r1t42wAqu6R9pBrN7wlQ3665buzbBu1LJdEhDVizC
         KUJYlmKr/ZI1ff8aEad23X+AwCdF/KEtEjsME8RiWb6yH+YX1Pvfd7U0X8EmtdjeYFB1
         x/Fc6SFIBMtGjc8zFkJDNsdkXsXLvLMAbR3n/vf8FZjJ7T01vcwCreI/L/IoAOELK9R8
         QXkA==
X-Forwarded-Encrypted: i=1; AJvYcCVVM8BNmIWWOQtW5lZUWV2FjdldEd4+sy/E6WEnaBpOy9hgA9rQyg10hjk6yca3T1oQ+Gf0KYbDoqUYepo8rwhSYJUzSEbM6JCC8osx
X-Gm-Message-State: AOJu0YyF/4jzm6MTZV+TcdUa9OWpfTLzH5HQzNjZ2NRvbJ6ENeOmLX4J
	ITBJJ8D860B30vCjnSEc3SbfPRMNLo9/Fxy2eX0jjTvqNXgGQpJfq9rJPUNuTat+Kb6ZtR/VdUT
	miA==
X-Google-Smtp-Source: AGHT+IELUA3WIM5Wphps0xkQTRhby+UDCJjkk/RQ2PxIjMMY045f/NVk5on7zOgMXu0rVeJlBwRipETmKZ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:adcf:0:b0:dfb:c58:6beb with SMTP id
 3f1490d57ef6-dff153d0fdfmr32821276.4.1718321606405; Thu, 13 Jun 2024 16:33:26
 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:33:24 -0700
In-Reply-To: <ZmthZVGmgcM5NQEm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611215805.340664-1-seanjc@google.com> <ZmthZVGmgcM5NQEm@google.com>
Message-ID: <ZmuBxFwWLAReYUn1@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Clean up function comments for dirty
 logging APIs
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 13, 2024, David Matlack wrote:
> On 2024-06-11 02:58 PM, Sean Christopherson wrote:
> > I don't actually care too much about the comment itself, I really just want to
> > get rid of the annoying warnings (I was *very* tempted to just delete the extra
> > asterisk), so if anyone has any opinion whatsoever...
> 
> I vote to drop it and document the nuance around PML in the function

As in, drop the function comment entirely?  I'm definitely a-ok with that too.

> > @@ -1373,14 +1354,26 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
> >  }
> >  
> >  /**
> > - * kvm_arch_mmu_enable_log_dirty_pt_masked - enable dirty logging for selected
> > - * PT level pages.
> > + * kvm_arch_mmu_enable_log_dirty_pt_masked - (Re)Enable dirty logging for a set
> > + * of GFNs
> >   *
> > - * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
> > - * enable dirty logging for them.
> > + * @kvm: kvm instance
> > + * @slot: slot to containing the gfns to dirty log
> > + * @gfn_offset: start of the BITS_PER_LONG pages we care about
> 
> Someone once told me to avoid using "we" in comments :)

Darn copy+paste.

