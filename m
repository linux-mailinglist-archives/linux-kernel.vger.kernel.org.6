Return-Path: <linux-kernel+bounces-326923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7156976E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EA61C23A33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6B15250F;
	Thu, 12 Sep 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VR32OBzf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543B13E02E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157861; cv=none; b=d0rDC+E1+PtcdLPN0acbFTU0WS56nYWm2ZbCl7oDrwErh+pOH7LhQC95mJIx0J17E063h+USA3tyPTQywsx/47LU/27TuirrK0GGMscUfrQ/DLAh5JfiBu2TC3IH8261iZEViqsWEbn+MIVGHtTPsPl5q73I/DiZsLjBDXK29Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157861; c=relaxed/simple;
	bh=sqOCBmz0NeGoOmrLe8YUpkiZEdcp2a6gTbuVlBFKGwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O+IGVZDshuUegEdTqDAe1JvFNboQvxIp7iV94j31gJwmYsOu1Dde08PzQbhek170cuaJlYcb/MmI7R1/q5tB2NzM2a2c8cQCFmi/hVx94f/A+rw5imrnNTW86b98JtRswtbYEvTjoZL9OCHzQg9zDlCyRZqqXx9T0T4T41XgEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VR32OBzf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e178e745c49so1636859276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726157858; x=1726762658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHc8H+AgFlKGz9oROxRBwufdfanAh7CzUD+9HRa3+GA=;
        b=VR32OBzfvOz14JfapTbYgxzaKPXvxL4zmrESNKyDBn2w+18hrpsigrgpGkQSDSfYWz
         PtidutRCuzrgeAbnHx9A7FtYBc6XoAYICw/6H1Mp6fZjpEdNglJMZua35Fr1PayQPI3s
         FNiKE+7PjIm/1O4FfmpBq7h2/kEI1LXdOE94nDAXk5POKEBFYeUJ8BLCVnDrBje6rltd
         fw+zGuEFHHkKK8TmFFURBrvN7XCobigjWrJ5+vRbgNT8954d3iMDfV5RiuU/pdJWG1Ia
         jBvePS4ndx+YpN3UQepo2vnjTY059gQP6iQ5ifMWtLbaYuNymdRrk4V+djX+F40LaamI
         LqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157858; x=1726762658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHc8H+AgFlKGz9oROxRBwufdfanAh7CzUD+9HRa3+GA=;
        b=liHLmAgk1um5rBVpdMydJfJgjXPdXF49ZZCUJTgNrcaeyEA8neSntT89G4bhs/Srik
         aWwISFcVe2FPrSMiMnK1lpbqA3YBqG0PRt0Nf5teelMHqAV4cn5bXFuqFj0i7ng87lbV
         zfes/uqdirEJ2hrv3RwWkDFCqeFnPmKdZefxSLiTuFG3Vb77bzj7oI94Mmgxo92Rhlah
         WyTMmN2uA9oZs+3CXxlbKgEgDQIp3JuoQGTa3Y/+Wqgf78VHlHNEk+du4g/YY21HCPcy
         CPuMTs/JDtv9vsq2wv1HyEi4iletUj6ro95Zl/Wh6ZlB+zFk8skvTfl0Q4ENERhsN5Em
         FF5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLZIEmcmDDA27bDuf+jp62nK9xZiOevIDYXn21Pf1f5YuzJws42TxkOIqxS5HZ2mzDJaUENdBlRYViWyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGgrDEEqnXTM4wY83u21+gVImnc6d+Yoxs2FAgKPObmUACXBX
	IHwRTbS69WOc3kDjB6FXAvmc4fGRUWeSDumhgi2BSNGNv/0rT9cr3w8Vmj7zOn/SEP8VpWrUZCC
	/uQ==
X-Google-Smtp-Source: AGHT+IEJVscKJvuinHeLuj6Vk0WsuDDxtUgSvi9YqWgJNhdyRuKGPX9aioKoGnIVhZDgsM2BQvZ5JjUQZqU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:86c4:0:b0:e11:5e94:17dc with SMTP id
 3f1490d57ef6-e1d9dbd0464mr4681276.5.1726157858129; Thu, 12 Sep 2024 09:17:38
 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:17:36 -0700
In-Reply-To: <20240912-75f992936cd9878d0e507498@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com> <20240911204158.2034295-5-seanjc@google.com>
 <20240912-75f992936cd9878d0e507498@orel>
Message-ID: <ZuMUIPIu5iRuxLCC@google.com>
Subject: Re: [PATCH v2 04/13] KVM: selftests: Assert that vcpu_{g,s}et_reg()
 won't truncate
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 12, 2024, Andrew Jones wrote:
> On Wed, Sep 11, 2024 at 01:41:49PM GMT, Sean Christopherson wrote:
> > Assert that the the register being read/written by vcpu_{g,s}et_reg() is
> > no larger than a uint64_t, i.e. that a selftest isn't unintentionally
> > truncating the value being read/written.
> > 
> > Ideally, the assert would be done at compile-time, but that would limit
> > the checks to hardcoded accesses and/or require fancier compile-time
> > assertion infrastructure to filter out dynamic usage.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 429a7f003fe3..80230e49e35f 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -683,6 +683,8 @@ static inline uint64_t vcpu_get_reg(struct kvm_vcpu *vcpu, uint64_t id)
> >  	uint64_t val;
> >  	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
> >  
> > +	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
> > +
> >  	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
> >  	return val;
> >  }
> > @@ -690,6 +692,8 @@ static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val
> >  {
> >  	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
> >  
> > +	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
> > +
> >  	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> >  }
> >  
> > -- 
> > 2.46.0.598.g6f2099f65c-goog
> >
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Shouldn't patches 3 and 4 come before patch 2 in this series?

Ideally, yes, but for this patch, it gets weird because the output param of
vcpu_reg_get() isn't actually restricted to a 64-bit value prior to patch 2.
E.g. if this patch were merged without that rework, then the assert would be
confusing and arguably flat out wrong.

As for the hack-a-fix, I deliberately ordered it after patch 2 so that it would
be easier for others to (try to) reproduce the bug.  I have no objection to
swapping 2 and 3 in the next version.

