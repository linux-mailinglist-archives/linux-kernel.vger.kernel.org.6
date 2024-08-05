Return-Path: <linux-kernel+bounces-275479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DC94864F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A311C222C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24816F0CE;
	Mon,  5 Aug 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hxt0O+7K"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF3166F3B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901463; cv=none; b=W6bRErm7PFAqCfFE8ywN4mG7l4iTfnsHn3ccOFrv2qNRukpB5r6YbWB65rvloNAXGN///FmC10PGZoJ92eAJyzBpx/wnJwz6wsyNZX9I9Y/pkpIiB2D3OoA4ybiMOGO9St+xZKnkPseZg1PkGMifj/GAh+Nt7+uDc4cVCFZaBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901463; c=relaxed/simple;
	bh=N36BgzP/Ze7QI1FmjnSinfkcU4TKCKVAfKUS3FFhhCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJFBrK0OJTLVbcoEsqTrvAlnqgWiWS1RvhTNt/wRbWVEWIQfz1Hw/F6afbSlHVE6/cYZTdLM3kJ/n+pA/Ke5cgBVhlvfR4S01a8JY7Y8fpj/dcfc+EEfrCjAJstnHEPHVLU3VV+bvXD2HoskYlzf6ldeAbRdw6FcVwG+5LUybhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hxt0O+7K; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so58960061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722901460; x=1723506260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ldf/5dV/loYFjBwyCn5nK6gnfSKwn5dyvPTT5/+hrg8=;
        b=Hxt0O+7KivZfcyasMKLnfYIzaXxvHvaX4e45o+khL6U0hf0sPrQjNs4ilukfmMVPkc
         8AZnFrJMYPJGiH/98DkgTwV6MDsfSt+PKJBc8vJHfheGRk1jQo8tvk8mclbBpjF0mZI5
         IPLZMvndIjAlynZ2pPGN49npQZaEkJ/hjhfWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901460; x=1723506260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ldf/5dV/loYFjBwyCn5nK6gnfSKwn5dyvPTT5/+hrg8=;
        b=EIZmrayJrUDfTiHg4aUMmvQdZvhJYrrfuX3wjlk2KiktGhFb6MXWosWtxRsmgjoH+K
         o6XYyBtMFN0fWyVcA32szxlti/7qDM8FLtUngwI9eYuDZQbsylOY2JPGC1ji+84BbO+c
         WfPJHKpQTJJXAX9ovM3Yz/INKIRH1Ytw6FzOXEFUdiG9eLP3roXxPqCOKyMCwyEmO21/
         YFBJKN8E+CyZIk6bJXmMsaiFtiwiU4kYwUWcjiPudCyxx6LuskzN9eM94ND97TGiytf5
         3Unr6vB35gay4FyIgBUH9hzbPN5d8cozD9+HUddRNfTNgaYVVhSaL3YHWKQizcmgTVmZ
         i7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfkO2rYFu7jL9+/3Y3PevS2WY2NTyjN0p/kFqhZ3fgExByKgkvtQ9arnlibOiGM0DNDYTy9w42SvnR2ey8aYN2lepTclXXG+yaqaMY
X-Gm-Message-State: AOJu0YwXMApBcGLRNmTx+UJJ2LKSeSI+CQaiQ51cQanavJ0X882J3E62
	gDLHii307mv55MTX01wmIp4/TP3Q9rJFYQHE0JY8xWR3ftLVGGeTVhDSQA80Jjhb5YIR368h/zx
	6XinKIcHRZpYbKc3DYnYKEB5pxhSlOOK5uUpB
X-Google-Smtp-Source: AGHT+IHIK0kYEUYapI5tIc8vSMvjbESuyPpwn3iTc/MzDz8eRJWcfhJa0eyJoudkIswN6TS8V0q74Bp34S0uh1BvkQE=
X-Received: by 2002:a2e:9004:0:b0:2ec:347a:b020 with SMTP id
 38308e7fff4ca-2f15b13c649mr36224431fa.12.1722901459336; Mon, 05 Aug 2024
 16:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <ZnXHQid_N1w4kLoC@google.com>
 <87cymtdc0t.fsf@draig.linaro.org>
In-Reply-To: <87cymtdc0t.fsf@draig.linaro.org>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 6 Aug 2024 08:44:08 +0900
Message-ID: <CAD=HUj6gjqthaenpZUr2Lci3WJW86OWe559YrDWiUSVfZBNHiQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] KVM: allow mapping non-refcounted pages
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Sean Christopherson <seanjc@google.com> writes:
>
> > On Thu, Feb 29, 2024, David Stevens wrote:
> >> From: David Stevens <stevensd@chromium.org>
> >>
> >> This patch series adds support for mapping VM_IO and VM_PFNMAP memory
> >> that is backed by struct pages that aren't currently being refcounted
> >> (e.g. tail pages of non-compound higher order allocations) into the
> >> guest.
> >>
> >> Our use case is virtio-gpu blob resources [1], which directly map host
> >> graphics buffers into the guest as "vram" for the virtio-gpu device.
> >> This feature currently does not work on systems using the amdgpu drive=
r,
> >> as that driver allocates non-compound higher order pages via
> >> ttm_pool_alloc_page().
> >>
> >> First, this series replaces the gfn_to_pfn_memslot() API with a more
> >> extensible kvm_follow_pfn() API. The updated API rearranges
> >> gfn_to_pfn_memslot()'s args into a struct and where possible packs the
> >> bool arguments into a FOLL_ flags argument. The refactoring changes do
> >> not change any behavior.
> >>
> >> From there, this series extends the kvm_follow_pfn() API so that
> >> non-refconuted pages can be safely handled. This invloves adding an
> >> input parameter to indicate whether the caller can safely use
> >> non-refcounted pfns and an output parameter to tell the caller whether
> >> or not the returned page is refcounted. This change includes a breakin=
g
> >> change, by disallowing non-refcounted pfn mappings by default, as such
> >> mappings are unsafe. To allow such systems to continue to function, an
> >> opt-in module parameter is added to allow the unsafe behavior.
> >>
> >> This series only adds support for non-refcounted pages to x86. Other
> >> MMUs can likely be updated without too much difficulty, but it is not
> >> needed at this point. Updating other parts of KVM (e.g. pfncache) is n=
ot
> >> straightforward [2].
> >
> > FYI, on the off chance that someone else is eyeballing this, I am worki=
ng on
> > revamping this series.  It's still a ways out, but I'm optimistic that =
we'll be
> > able to address the concerns raised by Christoph and Christian, and may=
be even
> > get KVM out of the weeds straightaway (PPC looks thorny :-/).
>
> I've applied this series to the latest 6.9.x while attempting to
> diagnose some of the virtio-gpu problems it may or may not address.
> However launching KVM guests keeps triggering a bunch of BUGs that
> eventually leave a hung guest:
>

Likely the same issue as [1]. Commit d02c357e5bfa added another call
to kvm_release_pfn_clean() in kvm_faultin_pfn(), which ends up
releasing a reference that is no longer being taken. If you replace
that with kvm_set_page_accessed() instead, then things should work
again. I didn't send out a rebased version of the series, since Sean's
work supersedes my series.

-David

[1] https://lore.kernel.org/lkml/15865985-4688-4b7e-9f2d-89803adb8f5b@colla=
bora.com/

