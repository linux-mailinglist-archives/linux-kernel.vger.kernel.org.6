Return-Path: <linux-kernel+bounces-209302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD4903240
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52567B2684A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E52171090;
	Tue, 11 Jun 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alGWbjtX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02617085D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086183; cv=none; b=pFx2lbJBY/48w/EvcpkWl9Ojq97nKXB+uYV/8DnhN99ftCCLKml3iGtgycF/h5+wRHkA5mLJYcDYvvduZgKRx0ZbbejDGS8/7iGxcQ3Kn+4/gFeIDrLxMptBmcQY6uXSwEW3vqwC9sCDK8vwQiAUyLhtM/T2luNeR3IW0riXEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086183; c=relaxed/simple;
	bh=eR96Qh/5iRQhSkLZ49faQ1/ZfLRyT1ZDLdu0PUbUwIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMdOtYKG5VX9VqW2F+4PCT0jXCpV713u+nRBJ2x+qh+FHJS9CRUyjJyKsuCQoBB62qR7ja7oLfn3HP9ycjfo114FQ4mEVH3BYRZxwW5zvQMaIeGaHgcuJhaq3QtyXmumZQPETkKSuQSMwDLNGt1Qdb94g00kofkGYX5NGQ8T/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alGWbjtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718086180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRVRX12wifRb77ucqxD8SoxcD6QmCklA7Z5uOhaawh8=;
	b=alGWbjtX06LOfXJshq1mdrz52RwF7NEqsNrwmL2lAwoPpTr2CHQsPNvvu0/0BiubLuhHG1
	IyxTvCkUM1ZLtkmJPQ5Y/NGe+aMnZnypGUOVXzXhMagFOWxDBfsc3kwUuI6Zl+mr5TOSlb
	T3fuy4dWl3iADQ7oeV9R3sARuIS5PSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VrLuMGYaM7uRrC5HJUWIKQ-1; Tue, 11 Jun 2024 02:09:39 -0400
X-MC-Unique: VrLuMGYaM7uRrC5HJUWIKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421292df2adso34116065e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718086177; x=1718690977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRVRX12wifRb77ucqxD8SoxcD6QmCklA7Z5uOhaawh8=;
        b=aXXorE8WjUStCgBLmIr4UnQv2//BmXAo/y+jLlNEfXbe/Fv21uyyqiPeoy5Imun2va
         qLB4GUODD+h9moJ9H1HbsfHmAgUJZq47HCCuT24Adq4iAjIelUcXXxgQLAYl41vOqiei
         FcoUNyctzY5AAW7OMMCl5FsJytdoH8EN/SaAwHP/Z+B/3BnmZIXaih7H6waI9bIsGyjc
         6TGhd/SmxbUHBqPuPWr94t6hH5kKQVhKL/FaUDG58SBCeLiqICNRjRUPUfv/zSFVbd95
         9lFgTmu2tXRJU+PnCKWRCUHJ+BhD0uqB4lZSpey1C6imzxf2RghVRbyn387++7BI5d42
         Qugw==
X-Forwarded-Encrypted: i=1; AJvYcCUD9Kk++iqIAxG8mDdUkcld9iFKonjgXc2pZ1ZghN8Y0R27luKsPFWrEa2zE3l/VuTt0Q3CUCK4E7CrGTAbbRQHJ6SUdeOc1NY8g3tX
X-Gm-Message-State: AOJu0YwMg8XfTi+sAYFE7ysidOQ3WYtyyHFt0UVYqavGKQ66ZYgtiLfe
	DwiJHvL0zWRPjamDZV701lfNQEm+cMCib4Gm4nPW2a3QVEqubHc7BcvONUNDfgJvJbAVazlA9XF
	yZ4ZRKH/+mHDpnVns33hoFyBhpXihV5Jrtx1dpNLHVMy9UyKdrkp9HuB1R+1ObsRrRwSgw0DdgN
	UI61RIdfjAUONNfCNBXxv2CJtyCjqns8wjxd4N
X-Received: by 2002:a05:600c:3544:b0:421:7b9d:5b9b with SMTP id 5b1f17b1804b1-4217b9d5c65mr60564965e9.15.1718086177718;
        Mon, 10 Jun 2024 23:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+n+/GQx5Q2Plr7xS1cjRck09sfOnGE3ZBQ7ZXSoS1tggqh8IRk2hnXH6/xd9Hk313u99VaVhOTNpTiufCh/Y=
X-Received: by 2002:a05:600c:3544:b0:421:7b9d:5b9b with SMTP id
 5b1f17b1804b1-4217b9d5c65mr60564835e9.15.1718086177335; Mon, 10 Jun 2024
 23:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423235013.GO3596705@ls.amr.corp.intel.com>
 <ZimGulY6qyxt6ylO@google.com> <20240425011248.GP3596705@ls.amr.corp.intel.com>
 <CABgObfY2TOb6cJnFkpxWjkAmbYSRGkXGx=+-241tRx=OG-yAZQ@mail.gmail.com>
 <Zip-JsAB5TIRDJVl@google.com> <CABgObfaxAd_J5ufr+rOcND=-NWrOzVsvavoaXuFw_cwDd+e9aA@mail.gmail.com>
 <ZivFbu0WI4qx8zre@google.com> <ZmORqYFhE73AdQB6@google.com>
 <CABgObfYD+RaLwGgC_nhkP81OMy3-NvLVqu9MKFM3LcNzc7MCow@mail.gmail.com>
 <de1b0bbc-b781-4372-88ad-81f26c9152c2@redhat.com> <ZmeOxAtwfTsDCi1x@google.com>
In-Reply-To: <ZmeOxAtwfTsDCi1x@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jun 2024 08:09:24 +0200
Message-ID: <CABgObfbvhz10ikVbeguUwSDpxFr+wm73cTZCKU9JRDyZdUJapQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
To: Sean Christopherson <seanjc@google.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, michael.roth@amd.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:41=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jun 11, 2024, Paolo Bonzini wrote:
> > On 6/10/24 23:48, Paolo Bonzini wrote:
> > > On Sat, Jun 8, 2024 at 1:03=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > > SNP folks and/or Paolo, what's the plan for this?  I don't see how =
what's sitting
> > > > in kvm/next can possibly be correct without conditioning population=
 on the folio
> > > > being !uptodate.
> > >
> > > I don't think I have time to look at it closely until Friday; but
> > > thanks for reminding me.
> >
> > Ok, I'm officially confused.  I think I understand what you did in your
> > suggested code.  Limiting it to the bare minimum (keeping the callback
> > instead of CONFIG_HAVE_KVM_GMEM_INITIALIZE) it would be something
> > like what I include at the end of the message.
> >
> > But the discussion upthread was about whether to do the check for
> > RMP state in sev.c, or do it in common code using folio_mark_uptodate()=
.
> > I am not sure what you mean by "cannot possibly be correct", and
> > whether it's referring to kvm_gmem_populate() in general or the
> > callback in sev_gmem_post_populate().
>
> Doing fallocate() before KVM_SEV_SNP_LAUNCH_UPDATE will cause the latter =
to fail.
> That likely works for QEMU, at least for now, but it's unnecessarily rest=
rictive
> and IMO incorrect/wrong.

Ok, I interpreted incorrect as if it caused incorrect initialization
or something similarly fatal.  Being too restrictive can (almost)
always be lifted.

> E.g. a more convoluted, fallocate() + PUNCH_HOLE + KVM_SEV_SNP_LAUNCH_UPD=
ATE will
> work (I think?  AFAICT adding and removing pages directly to/from the RMP=
 doesn't
> affect SNP's measurement, only pages that are added via SNP_LAUNCH_UPDATE=
 affect
> the measurement).

So the starting point is writing testcases (for which indeed I have to
wait until Friday).  It's not exactly a rewrite but almost.

> Punting the sanity check to vendor code is also gross and will make it ha=
rder to
> provide a consistent, unified ABI for all architectures.  E.g. SNP return=
s -EINVAL
> if the page is already assigned, which is quite misleading.
>
> > The change below looks like just an optimization to me, which
> > suggests that I'm missing something glaring.
>
> I really dislike @prepare.  There are two paths that should actually init=
ialize
> the contents of the folio, and they are mutually exclusive and have meani=
ngfully
> different behavior.  Faulting in memory via kvm_gmem_get_pfn() explicitly=
 zeros
> the folio _if necessary_, whereas kvm_gmem_populate() initializes the fol=
io with
> user-provided data _and_ requires that the folio be !uptodate.

No complaints there, I just wanted to start with the minimal change to
use the uptodate flag in kvm_gmem_populate(). And yeah,
kvm_gmem_get_folio() at this point can be basically replaced by
filemap_grab_folio() in the kvm_gmem_populate() path. What I need to
think about, is that there is still quite a bit of code in
__kvm_gmem_get_pfn() that is common to both paths.

Paolo


