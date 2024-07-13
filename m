Return-Path: <linux-kernel+bounces-251439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF59304E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E668B1C20F31
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65261FFE;
	Sat, 13 Jul 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDnXpVey"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3647F69
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865449; cv=none; b=QTvLuG4JPRumS42VNLQXBo5CobObK1Z4cBJB2q8icSaZD5jfoFq/z0wZoM5x6HlMT56qjaEcMJYvgOxbGRoYzCxEl4z32wealwMt97qQ4IMs00LY+fcsk6oOXZ3n3rZ0ahs7rDmsqpgc20v/zPWfy4mjMlZXCp0fnSbXRlNvcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865449; c=relaxed/simple;
	bh=qZCU07LwG1y/QxqvDN+bbU9f40dznEGTgZbhCkej5+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHVKVNWXD1NdIpKb0ei7vCAM/OZTBx1w+HWciHnWMkkMakLbk+YukYWy4zBENzRJg/cpRyJEqgEzu1TqdK/GI/gVTGFbE+6bqR8PpnioQAsyPwccgWOeP/ICFh3EnuR2Em+X9txdOAlwPEuWHAOUHqkYExf7QpdJIBZimu1lkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDnXpVey; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720865446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPOxRQTAuOacVTi+37gbzjSwTfPPQBNHpeu0Esbbzm0=;
	b=gDnXpVeyO8eMg8BWezotydMvkBxORKX395Rwgui81QBg/t++vKhHveNWGZZA5gfHUUGtBr
	fsIIDfdIXP+JMenO6IrZ/dvl4GVL6IlxdG4D6zz4YUE5/to9CFm75R3ACeQ6IlIWdjGpgH
	6k0oS+fuw+rXeAwY6y9UTRQDLhCffkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-p60F6Fl7Oti910tczRl3hQ-1; Sat, 13 Jul 2024 06:10:43 -0400
X-MC-Unique: p60F6Fl7Oti910tczRl3hQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265d3bf59dso20869145e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720865442; x=1721470242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPOxRQTAuOacVTi+37gbzjSwTfPPQBNHpeu0Esbbzm0=;
        b=Ab6qHtMH9DzBHBKAc6HlFEbVhxkBDP5SFcsAZ/z8cC1t61vfQ/XUqpPLF84L+fKkp7
         iiEU72uwujHvxuBEahgy5g6RnVaCQVlpzJYkN60fiHs5+GEZ9XFfwjWmAkC2s4umJE/u
         PMcS94FRNPoYqIinAiw87m4hhJYTEpJEp/CpSZdvz/6551Pd9bIYxgCMYJp0Vpcjh1lF
         +hmONw+e/sVZONj+PnI9rgHwETfxdf+3jl3kjnzlWvkyWrX99KbuU2HCXjhQvX3r5GjX
         iT+y8wJwnNb9UxtulpYFfydE/FaR47Xx/J0JbrTLekRFoCwkqEP75YP1vDEAKD24KFcE
         dsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIOraiPfMg0YdwrJ1HrtKB/eqMA1gWYu6D83+qh199+W5HUfE2S2ONoPeK6g16OcB1ZOMr8rrJ4dcU26f4LeSTLXwgNooV5hCzESzj
X-Gm-Message-State: AOJu0YwsshT78irP3etQ+n5Zbqhei0/mI0B74r6S4Om5OSGPnu57Tf9a
	+QKfdjeQqzgSYQFQOlaGot+6sJYs0onFoWd0DA8txj50DTOEtgJLnjVHS1QiO7GOg/ymYrcDtxx
	u2qjHiAUu2P/irwsXS+XVV6nDLytgXyZc4t4hfja3LgGnxRB1R/lVLV80J2TwuzfSiWoagqRlJ0
	AVX997oAVc5MnXqYodmOk+gQUritPhX8XHP5yY
X-Received: by 2002:a05:6000:1fae:b0:367:f281:260d with SMTP id ffacd0b85a97d-367f2812aecmr7034508f8f.1.1720865442043;
        Sat, 13 Jul 2024 03:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB44G62KX/dILIjA2hXQolsbTtw+jRZeMNyH3DC7rg8PhDl8P2sXm1oJvu/5dqgeCXkwWU9NJjrXt0HG+5Ht0=
X-Received: by 2002:a05:6000:1fae:b0:367:f281:260d with SMTP id
 ffacd0b85a97d-367f2812aecmr7034502f8f.1.1720865441737; Sat, 13 Jul 2024
 03:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711222755.57476-1-pbonzini@redhat.com> <20240711222755.57476-10-pbonzini@redhat.com>
 <73c62e76d83fe4e5990b640582da933ff3862cb1.camel@intel.com>
In-Reply-To: <73c62e76d83fe4e5990b640582da933ff3862cb1.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 13 Jul 2024 12:10:30 +0200
Message-ID: <CABgObfbhTYDcVWwB5G=aYpFhAW1FZ5i665VFbbGC0UC=4GgEqQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] KVM: guest_memfd: move check for already-populated
 page to common code
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 3:28=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Thu, 2024-07-11 at 18:27 -0400, Paolo Bonzini wrote:
> > Do not allow populating the same page twice with startup data.  In the
> > case of SEV-SNP, for example, the firmware does not allow it anyway,
> > since the launch-update operation is only possible on pages that are
> > still shared in the RMP.
> >
> > Even if it worked, kvm_gmem_populate()'s callback is meant to have side
> > effects such as updating launch measurements, and updating the same
> > page twice is unlikely to have the desired results.
> >
> > Races between calls to the ioctl are not possible because kvm_gmem_popu=
late()
> > holds slots_lock and the VM should not be running.  But again, even if
> > this worked on other confidential computing technology, it doesn't matt=
er
> > to guest_memfd.c whether this is an intentional attempt to do something
> > fishy, or missing synchronization in userspace, or even something
> > intentional.  One of the racers wins, and the page is initialized by
> > either kvm_gmem_prepare_folio() or kvm_gmem_populate().
> >
> > Anyway, out of paranoia, adjust sev_gmem_post_populate() anyway to use
> > the same errno that kvm_gmem_populate() is using.
>
> This patch breaks our rebased TDX development tree. First
> kvm_gmem_prepare_folio() is called during the KVM_PRE_FAULT_MEMORY operat=
ion,
> then next kvm_gmem_populate() is called during the KVM_TDX_INIT_MEM_REGIO=
N ioctl
> to actually populate the memory, which hits the new -EEXIST error path.

It's not a problem to only keep patches 1-8 for 6.11, and move the
rest to 6.12 (except for the bit that returns -EEXIST in sev.c).

Could you push a branch for me to take a look? I've never liked that
you have to do the explicit prefault before the VM setup is finished;
it's a TDX-specific detail that is transpiring into the API.

> Given we are not actually populating during KVM_PRE_FAULT_MEMORY and try =
to
> avoid booting a TD until we've done so, maybe setting folio_mark_uptodate=
() in
> kvm_gmem_prepare_folio() is not appropriate in that case? But it may not =
be easy
> to separate.

It would be easy (just return a boolean value from
kvm_arch_gmem_prepare() to skip folio_mark_uptodate() before the VM is
ready, and implement it for TDX) but it's ugly. You're also clearing
the memory unnecessarily before overwriting it.

Paolo


