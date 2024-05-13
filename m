Return-Path: <linux-kernel+bounces-178132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F88C497B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD9E1F21DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D484A5B;
	Mon, 13 May 2024 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="j23Uyvqa"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEF80BE3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638104; cv=none; b=i+B+LSCIY1Sg+9tlxwv1Bm6CcvZpmX1+uDIcTfgzRMik4TDwTXkSN1uhnDa2NqmfMCy4nl/gTl+8OclxG8Vr+I5U9XkGGeXMT/PHOa4OY1P5EM5sT8DnkSIXH7lbi3UgGN6WTaxBWLqxuISirlVlWrOyY+kqRf7HOOOyBcGK27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638104; c=relaxed/simple;
	bh=dEkg9sqCSTUh6OfERlj2DZRvvgB1ehgJLUUyf9z5i3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CD1beUaVcZZ8PRTeeUTBZKpm1cxfyYCthrb66xxFxXB6nJs80CF4Wld0oIdzuTsn9jYdvcBiTdLbMQzZ+zlIY9nOcdiGKPvtbNeoQlfTEBaMxlpBgTG+CBtgfpN7j1a50qNTStxPL+moCiimh4BoKwyaJ99E/ga7vO0BgE+JHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j23Uyvqa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f474d5a8dfso3518967b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715638103; x=1716242903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+ImMk5mMg/Ph6+UMWEFe1i6y50T+E5sNxxEArfpRbc=;
        b=j23Uyvqah4Asrza+3JC4aOvX+Ny+nxrvHdX0EYt+656I2nzY4vYruzPJ3EXW0F/SXX
         SLaImVn0ICN39fQLoiaIJwLB2e5VsN1/rVijL5PyDuWwu4/SqQ3TfWumLbqmlJJV8xY+
         i4hla7obzANNVYcHO4ZQS4LY5VyoxK7cuay22C0ki4AyclxI8c1n5/dpYwUjOUAettfV
         ZuZ1ezZnSdUFI5iEnz4Y5IV9/7p02rxhz+WO1FrkXs32/00WeSpEPHRMTXpI6VdB3uva
         oM7UtewhhOQ7v+PbmQ6dlCjP4jOYo9ecQLCsQiQw6FP8jQP19Yy1uIDXSZtKkO4Rp5Wf
         9aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638103; x=1716242903;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+ImMk5mMg/Ph6+UMWEFe1i6y50T+E5sNxxEArfpRbc=;
        b=iH4SD+mOd+9CLEkKwvN1KgKZrOisg/irEx4Ap1tVR9jnyEnVLHLugjIC2RgHmuS6H4
         6VrnXjXtphuJ70wrEfl2efXvAuJmKOJStrGyb03ZIvYaSUf3Xqxt5Ck1sn9/J/tJCbGX
         IhLI7aGSY58E/1dVxjz2otgZfXuMOykwsYc/150rS7h+P6DqK8vY1gqXYC4w43uNWg+y
         FZ1nPza7LWV0AThgJXPCFq1J1gqoAQD0Jv0znAQ4vFbviJ2a9YKPizAVkyodnqhKNY9o
         YSwFy7cCPo5rTHnUM11AzTu7uWI+TIFBjYaxmDPHG8YdkjrU2UqXLyHgEA+OLDa1tfEO
         8xTg==
X-Forwarded-Encrypted: i=1; AJvYcCXvnp2wclcXGwdXpQ+xM+NAT8TZQx0LmcaONLSSKRuR7bVVrI5xBO3I+LQ930X3JjV+H5b4VJky62GwZfbGxRlvGEXL4wG8fVxAqCvc
X-Gm-Message-State: AOJu0YzmUDbDexJPiKAiFPJlv7iV0nKGp9iiIuqtHXhJTZp6QpsodZuY
	BNGkQhjFHa2VzPZQicji09mLcIgVUMJ52u8vlXYmXEgv3D9egZzMJTm2QdKEvL/WrHXkUX57N4J
	TFw==
X-Google-Smtp-Source: AGHT+IG/zTzeKngjsr80XFMiQVLcYBKJaamxbE5SgnpVzmy6rN4iBqZOwzyNNwZSjtZ3zMA04MvOdqL+ZuY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a17:b0:6ec:ceb4:d9e2 with SMTP id
 d2e1a72fcca58-6f4e01b9126mr999510b3a.0.1715638102944; Mon, 13 May 2024
 15:08:22 -0700 (PDT)
Date: Mon, 13 May 2024 15:08:21 -0700
In-Reply-To: <CABgObfZ=FcDdX=2kT-JZTq=5aYeEAkRQaS4A8Wew44ytQPCS7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <CABgObfZxeqfNB4tETpH4PqPTnTi0C4pGmCST73a5cTdRWLO9Yw@mail.gmail.com>
 <CABgObfZ=FcDdX=2kT-JZTq=5aYeEAkRQaS4A8Wew44ytQPCS7Q@mail.gmail.com>
Message-ID: <ZkKPVT8Xpp4lh6Xa@google.com>
Subject: Re: [PULL 00/19] KVM: Add AMD Secure Nested Paging (SEV-SNP)
 Hypervisor Support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, jroedel@suse.de, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, pgonda@google.com, rientjes@google.com, tobin@ibm.com, 
	bp@alien8.de, vbabka@suse.cz, alpergun@google.com, ashish.kalra@amd.com, 
	nikunj.dadhania@amd.com, pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	papaluri@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024, Paolo Bonzini wrote:
> On Sun, May 12, 2024 at 9:14=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Fri, May 10, 2024 at 11:17=E2=80=AFPM Michael Roth <michael.roth@amd=
com> wrote:
> > >
> > > Hi Paolo,
> > >
> > > This pull request contains v15 of the KVM SNP support patchset[1] alo=
ng
> > > with fixes and feedback from you and Sean regarding PSC request proce=
ssing,
> > > fast_page_fault() handling for SNP/TDX, and avoiding uncessary
> > > PSMASH/zapping for KVM_EXIT_MEMORY_FAULT events. It's also been rebas=
ed
> > > on top of kvm/queue (commit 1451476151e0), and re-tested with/without
> > > 2MB gmem pages enabled.
> >
> > Pulled into kvm-coco-queue, thanks (and sorry for the sev_complete_psc
> > mess up - it seemed too good to be true that the PSC changes were all
> > fine...).
>=20
> ... and there was a missing signoff in "KVM: SVM: Add module parameter
> to enable SEV-SNP" so I ended up not using the pull request. But it
> was still good to have it because it made it simpler to double check
> what you tested vs. what I applied.
>=20
> Also I have already received the full set of pull requests for
> submaintainers, so I put it in kvm/next.  It's not impossible that it
> ends up in the 6.10 merge window, so I might as well give it a week or
> two in linux-next.

I certainly don't object to getting coverage in linux-next, but unless we h=
ave a
very good reason to push for 6.10, which doesn't seem to be the case, my st=
rong
preference is to wait until 6.11 for the official merge.  I haven't had a c=
hance
to look at v15, and at a quick glance, the SNP_EXTENDED_GUEST_REQUEST suppo=
rt in
particular still looks kludgy.  In general, this all feels very rushed.

