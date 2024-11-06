Return-Path: <linux-kernel+bounces-398357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCA9BF002
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F5BB23D66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5B201244;
	Wed,  6 Nov 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYi9GZnH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7F201101
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902953; cv=none; b=DujT1pKrer3LijH47nKKgwHQ2Xj7zlUgJctLynZFUjkG3EBnFmiHby5sfZJjA4lGsrsz2A7f93TfWYvCU/0BzAZgxOmz3U8IjcIw1CzaYFBhNbRlAVDywgnX9MIxg1G18oNGzXoXOjBO4D9lhbykf+T6KTllE0rkmhNgJY4I1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902953; c=relaxed/simple;
	bh=2RrRshAwwq/rLLyF9+NvZZVYeWwe9X42/D4oP7Q7l+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1Mwn0XljfWNNHDg0zTVqtimZ3H9uk04IJ5q7s3LQmHFZsiKwv7W3DJ5Uuvz7Gy6ckJ5vzsYcV4L5WdQBS8KaaQenB/ycf919+StDZb2snkq0I8n5pN4ZTgQAYPn2obQ4AP8XDUN2eF9/kFCbN0BsmPXgqRlK6ICdLiQIgU5xyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYi9GZnH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ba241e7eso12035996276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730902951; x=1731507751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2PosAXqUXHksT5Nr40T4bAAzCG1JJO1zeG2zISTFXQ=;
        b=iYi9GZnH2MGeDtwk6CAK2plrxY1zjyxRJh9G2pPoNwjZ5aysF+diTDN9UzpqH9RXs4
         Yr3JW3BW0nLnIk6y9e4goq2VU/64YmKSTDt4MN/v4Na3KAHRSpOlSlmPOfMAI4zD16/P
         MRq+WvRFY/p43lXHHAIIpSCtEER+b0immekG0YtvzfCzjE2mnZNSgj0viYf2JJhs1YpC
         s/E1fegXNczIGnOSBWKu06Pit9I3L1/hg1zJvFVLf9n8qMh6BIs5IctMQillkgGtqJ1r
         0hEGJntgT1vdyJzC3JuhJHn1q2bB5aHmaeJvWqj8hfXysqQCWgrM+nadHLyezmE4tZxe
         UTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730902951; x=1731507751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2PosAXqUXHksT5Nr40T4bAAzCG1JJO1zeG2zISTFXQ=;
        b=hR28m0NXixuvXp4/dDoia6ookl5Wgu2wAeOg7Pc1sd/2sdSWaAET51V5ZaOnEmjwmb
         QmcpeqcMqpRLTHH4f/lebX8AMLGfJplFGB9bzRcz3HB+J/tjMhJs0SvGpJlF6t+Weemb
         Rj1tHKisaqOI6mOpWqs1Bhq8+aVNUtRACLYCHY/2XObPdCpOg7MIz85j4A4QMQjdgSA7
         BrqUk7B7Dn09GoxuPRNWueeGJY59D743PHXMHqaScCAnsKvn6BTd3CMyJBjm7oi6OpV+
         cMI0++ljhph5cJdBnNqr+gOSVShSpXX195EQIL5ucMurAwXBBt1oVHWuD4Oc2GeJBBb2
         U3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVkFLipbz6ctnS3KyU56RjA85ISx0cNlVbFa1MF7bItjRY52WrV4BY/dQsX0jbzNLk7inKPtAdMXOwGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsbqczGaYqvZTWzvPON+RlJj6vOPvccuYbWaEnDCL+zGyBJqV
	YtnSeotHfgNazUs8sJV1ggqAy6KtCITsX07S4aXofjplch1mhfNmHKBE0OFUIfoZjJNqYG0r66p
	f7w==
X-Google-Smtp-Source: AGHT+IEL/HSJ/Y438gEKgbUOzxIrR+9r15c0yQjhJjDLKV7XMHrGjW0jP7GQ37ELTFFEw/sxEtmKy31BxBk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:abe9:0:b0:e30:b98d:a33d with SMTP id
 3f1490d57ef6-e30b98da4f0mr49921276.5.1730902951154; Wed, 06 Nov 2024 06:22:31
 -0800 (PST)
Date: Wed, 6 Nov 2024 06:22:29 -0800
In-Reply-To: <ZytHAtKgixnZ/AOD@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106015135.2462147-1-seanjc@google.com> <ZytHAtKgixnZ/AOD@intel.com>
Message-ID: <Zyt7pVYx1o6jUKMy@google.com>
Subject: Re: [PATCH v2] KVM: x86: Unconditionally set irr_pending when
 updating APICv state
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Yong He <zhuangel570@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 06, 2024, Chao Gao wrote:
> On Tue, Nov 05, 2024 at 05:51:35PM -0800, Sean Christopherson wrote:
> > arch/x86/kvm/lapic.c | 29 ++++++++++++++++++-----------
> > 1 file changed, 18 insertions(+), 11 deletions(-)
> >
> >diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> >index 65412640cfc7..e470061b744a 100644
> >--- a/arch/x86/kvm/lapic.c
> >+++ b/arch/x86/kvm/lapic.c
> >@@ -2629,19 +2629,26 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
> > {
> > 	struct kvm_lapic *apic = vcpu->arch.apic;
> > 
> >-	if (apic->apicv_active) {
> >-		/* irr_pending is always true when apicv is activated. */
> >-		apic->irr_pending = true;
> >+	/*
> >+	 * When APICv is enabled, KVM must always search the IRR for a pending
> >+	 * IRQ, as other vCPUs and devices can set IRR bits even if the vCPU
> >+	 * isn't running.  If APICv is disabled, KVM _should_ search the IRR
> >+	 * for a pending IRQ.  But KVM currently doesn't ensure *all* hardware,
> >+	 * e.g. CPUs and IOMMUs, has seen the change in state, i.e. searching
> >+	 * the IRR at this time could race with IRQ delivery from hardware that
> >+	 * still sees APICv as being enabled.
> >+	 *
> >+	 * FIXME: Ensure other vCPUs and devices observe the change in APICv
> >+	 *        state prior to updating KVM's metadata caches, so that KVM
> >+	 *        can safely search the IRR and set irr_pending accordingly.
> >+	 */
> >+	apic->irr_pending = true;
> 
> Should irr_pending be cleared after the first search of IRR that finds no
> pending IRQ, i.e., in apic_find_highest_irr() when !apic->apicv_active?

Definitely not in apic_find_highest_irr(), because there are ordering issues on
SMP systems.  Huh, and apic_clear_irr() and kvm_lapic_set_irr() are buggy; they
subtly rely on atomic accesses to provide ordering, but really should have memory
barriers of some kinda (off the top of my head, I'm not entirey sure what barrier
is appropriate in apic_clear_irr()).

And definitely not in the context of this bug fix, because that performance flaw
exists in multiple other scenarios.

> Otherwise, irr_pending will be out of sync until the arrival of an interrupt.
> Not sure if we want to avoid the unnecessary performance overhead of repeatedly
> searching IRR.

IMO, it's not worth the risk.  That overhead effectively exists at all times on
modern Intel CPUs, as APICv is highly likely to be enabled, i.e. irr_pending will
always be true.

Hrm, but looking at this again, I'm not sure I like v2.  Ah, it's not the code I
don't like, it's the name of the helper that's flawed.  kvm_apic_update_apicv()
makes it seem like it's only releveant when enable_apicv=true, but that's not the
case.  E.g. doing apic->irr_pending = enable_apicv would be broken.

But that flaws exists even before this patch, because kvm_apic_set_state() and
kvm_lapic_reset() rely on it to update apic->isr_count (which needs to be cleared
on INIT for the latter).

I'll send a (not for 6.12) patch to rename it, e.g. to kvm_apic_update_sw_caches()
or something.

