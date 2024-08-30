Return-Path: <linux-kernel+bounces-309580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9D966D05
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22C5B23328
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0D18FDD8;
	Fri, 30 Aug 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmwx6/X2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8F175D5E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725062101; cv=none; b=G5laLQYJ/d59aB7tDhfI7zKyoXda1PVPjzfmY7UM+C+DWIVbH3393HD+ggh3vSbJdNeFheB3+du9w+naJYfOcotj1QaZ/QQAo83aEcVM06ZLVe3G7iGLS9D/6kieMPt37tqfHH+SUctY9mTyQ2wbpO1ntkm7OuM1WPvMi4+dgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725062101; c=relaxed/simple;
	bh=+EsYePFzMFNpF6erMIpOe0WO8D6FAuzs9/EQFCfVmyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AJi6JpVrqgXIGuLi1uhqXDuqGhWqr5Wo1vwJ02nUGHzMt45lDNXGDZ9dH4QlJ4rX9j7zom0qHziqmCt1qbubNXVumlK2c4chW/DwiIYy7X/wuwm3ihsuRf2Bzr7Y6B3Vf0q5te5T49so61nPKd4jLgLUuog7p5OgQ4Uhi467bKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmwx6/X2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so47933257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725062098; x=1725666898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mTp89YM4a+JZ2WxsvEPMQELbnbLphEGU34GUEc+1rE=;
        b=xmwx6/X2yBrCzqrYhCN4r8qk6lOACar88BdriaApdOFv2ph9Y3BW7wiPuFGriElTNx
         BqrWoVJ5zsgyioqD9XXTaRW4WEQgl5E3ogdiiGGapPjtBGhn/YO9U6h0h43lZWJASgte
         TqkGO4h3uibNslpkOAwfB9ma9lDgIQ8KtMqO0CODyfwRnUZab+b1JxVT88RspsabsFP9
         UGX6SwJuGFZ2m+qlU1Kp6CY4brEJDx6kNJTEXrNjaQ7ezNRmYRo6sd3Bs1oI7e804Ohn
         6eFk8/MZx0If0vWcpSe2ugEnE/OpJdzvcM1oXfnvWnEzwyKmjZBRt80tcF6aTQN8EUuJ
         /t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725062098; x=1725666898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mTp89YM4a+JZ2WxsvEPMQELbnbLphEGU34GUEc+1rE=;
        b=iRp3jpFzdQEdGfChwfstDyy00Y38TRZg4GjMQPkiukwnMAJd4uUVaZXhSMuPa1C8Ah
         fUNd3c37PdQolhiVbC+KkvC+yVHm6xrJM9qpafVDeTI9F+Bly7Sj7kL+K5Vmw3YDwTSu
         TuqAiFJ4nr1q9X3yeWuUGu4kOW2Hf3ugJKPu+j1zdrS2cC6/j5sejPWMbuzo7I+wv38b
         Y5mwpaYNWO/fV4GnWih0q2SEbBMn2kCIBzGIj87KBJDJcuK4aML7nVnU4bpNCI2GUj3j
         c/etbFLfCtT3+d8wVGeMN29/GPdUSAxooCFDf1C/PsE22uGDnYLuW42llVu6eFT9X2t5
         n4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxijQ5wEgFHkFc6VfNKKRRMapxQIuIKGS2RT6skVTT2v7j+TMhru1cxGM6Rof68/QQRHJY1jFXwPHFi1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NYZOJeD+mxg5yerUEmC4c2RoyhTbPGpIQfGAeFT1Hvm26cBP
	FzPv5+4pQ358JoEg5s45dDdqQC9tE8p0Ft6PMIJWF2X3j8av95hJK8o0SMAgDL2DlK7VZ8QFCgV
	XVg==
X-Google-Smtp-Source: AGHT+IGwZxjO7ktsYm2v/oExs6JzBV3HAZ4YBOgUiAc3Zp4+M4L8o7WExR7rM/tO17TVCN5qdyaZadxEIjw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:dc07:0:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6d4118645a0mr107867b3.8.1725062098023; Fri, 30 Aug 2024
 16:54:58 -0700 (PDT)
Date: Fri, 30 Aug 2024 16:54:56 -0700
In-Reply-To: <Zr4P86YRZvefE95k@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com> <20240809190319.1710470-23-seanjc@google.com>
 <5f8c0ca4-ae99-4d1c-8525-51c6f1096eaa@redhat.com> <Zr4P86YRZvefE95k@google.com>
Message-ID: <ZtJb0M8Y3dRVlSaj@google.com>
Subject: Re: [PATCH 22/22] KVM: x86/mmu: Detect if unprotect will do anything
 based on invalid_list
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 15, 2024, Sean Christopherson wrote:
> On Wed, Aug 14, 2024, Paolo Bonzini wrote:
> > On 8/9/24 21:03, Sean Christopherson wrote:
> > > Explicitly query the list of to-be-zapped shadow pages when checking to
> > > see if unprotecting a gfn for retry has succeeded, i.e. if KVM should
> > > retry the faulting instruction.
> > > 
> > > Add a comment to explain why the list needs to be checked before zapping,
> > > which is the primary motivation for this change.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >   arch/x86/kvm/mmu/mmu.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 300a47801685..50695eb2ee22 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -2731,12 +2731,15 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> > >   			goto out;
> > >   	}
> > > -	r = false;
> > >   	write_lock(&kvm->mmu_lock);
> > > -	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa)) {
> > > -		r = true;
> > > +	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa))
> > >   		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
> > > -	}
> > > +
> > > +	/*
> > > +	 * Snapshot the result before zapping, as zapping will remove all list
> > > +	 * entries, i.e. checking the list later would yield a false negative.
> > > +	 */
> > 
> > Hmm, the comment is kinda overkill?  Maybe just
> > 
> > 	/* Return whether there were sptes to zap.  */
> > 	r = !list_empty(&invalid_test);
> 
> I would strongly prefer to keep the verbose comment.  I was "this" close to
> removing the local variable and checking list_empty() after the commit phase.
> If we made that goof, it would only show up at the worst time, i.e. when a guest
> triggers retry and gets stuck.  And the logical outcome of fixing such a bug
> would be to add a comment to prevent it from happening again, so I say just add
> the comment straightaway.
> 
> > I'm not sure about patch 21 - I like the simple kvm_mmu_unprotect_page()
> > function.
> 
> >From a code perspective, I kinda like having a separate helper too.  As you
> likely suspect given your below suggestion, KVM should never unprotect a gfn
> without retry protection, i.e. there should never be another caller, and I want
> to enforce that.

Oh, another argument for eliminating the separate helper is that having a separate
helper makes it really hard to write a comment for why reading indirect_shadow_pages
outside of mmu_lock is ok (it reads/looks weird if mmu_lock is taken in a different
helper).

