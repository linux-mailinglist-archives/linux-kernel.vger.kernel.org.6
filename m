Return-Path: <linux-kernel+bounces-283366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0894F18B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB841F23641
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50673184520;
	Mon, 12 Aug 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYSxQH1O"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A56130AC8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476134; cv=none; b=TvF95qYm121pE2pysrDbGF+Hdsf2/rwFoaPLsXphqaDayc/F4Chs8Lbh3XP5gkysvcGaCMuKxVtwVUoRFWBR0lvJodHDYxL3XYa++sqd6Ae/lH67AfKMWz1IGGU0Vg1Y1I8hmaJiQ582m8m8xNE119D9DDKHaJSdh+o5QP4MVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476134; c=relaxed/simple;
	bh=b21qcrm+S8sKxvBwdpqDyjaS7WouOqGHZknEh+zAIjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwznU2LXOV724pa7/r0zQqyV2pz5+kY+sESIbJG2z9usqVnR9iTIIdjYgZPw/mvu/AifooXX0wMZFwnBFxrT35p6WiUwv6N9J4vEYmAeRd7twRCtUCkkDHSduWajUw15LCOSJoBY+2LSCvOSxmX6TO3aBk4/tTRxuyT9g+TbeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYSxQH1O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cf1a80693cso5200203a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723476132; x=1724080932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH2ao2IGJbmgrkvcFBA8i8xzxhOUQFYAwmt8A+nqcs8=;
        b=iYSxQH1OY7qoXCeNKQKanDnqa9laBBWPlGloXGvSvWt9pJHdQk3hihHuxC10FDYqFM
         5IVggsOAA4Cjghx1VgGv5vKiDsW25iDqzOsV0rR0+TTG2TwxvvK2tMYxqe+5l5JYxi+N
         nxPP2wXpKopRMAUWNnNhKEIl0GK+dwXlj/l6B25ph7brtlLcj1CubgohRiccvfmj0005
         E/nf+SYgTynHvHnmfxvDeS6xrYVyJcpRSPrAu/pEBfIWkv1kDYjx2xWU6bAGiLUmSP1E
         mmPsbJCgplyBjuisUcnh0GcF4E3cuMfcSjZr3yKN2zcI5gMvtsaEDdnjRnYwVVNOrX1p
         uR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476132; x=1724080932;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AH2ao2IGJbmgrkvcFBA8i8xzxhOUQFYAwmt8A+nqcs8=;
        b=nKNEF8ET8+JX6qBECYVN5OaPzPlH5ytn7DMOD3JcB5TR4vyiimYeayNdoVyrwSYn1F
         56fIJI7bKg6vYN0CrL5SaT+DBbt4wCaahEEGaENY1vT5HqEF1bcTyVLB2DbdZFu+o5Cn
         pOgFylPSwxGHDBWW4lc2FkQxE+z3plNWFFOIiw/2DFqPknAm3ma5m2LR50o2qMbhAPwc
         cQCv6BvoAQ4SSGzSsP8mVW45ERP6SkgAHRKMpXCRj4rd45aCRJ9/GUPQsYc544rQ4Yzb
         j+yupYvwEBntJDOEh78q1x8jAZmX9mp79acGVtAU0f7l8SHLigwWMCyotBv1fgGIyACM
         fEMg==
X-Forwarded-Encrypted: i=1; AJvYcCWg89YfQNsBbxE/zeN/E6WjcIQS0vreqbhhBVMyDjH+SgmivI8g5UusYB/PkIqAZgoCv7Cix/vNfkF60/eTubmbVRTODKyjicaGlX+y
X-Gm-Message-State: AOJu0YxHmexdDPeWMiKy084s2Q7IlaGYYKTPYSKjCspli5XJuUB2lcA8
	eADKRlFD0tTTEeohh0WUpXBIjibdtfwINUzch0BTBmMJmY7aqlUIV8lL7V2YrTZC1XJSFqNB605
	jcw==
X-Google-Smtp-Source: AGHT+IF5TxICpEgJNNaxPl2At7Hpo2uBQDuQJeY4CGfqjHedHjuOWEpukoYm6rVl8rxhvO9f6W4tfL2aE8M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f2d5:b0:2c8:55e9:7874 with SMTP id
 98e67ed59e1d1-2d392214b22mr1604a91.0.1723476132491; Mon, 12 Aug 2024 08:22:12
 -0700 (PDT)
Date: Mon, 12 Aug 2024 08:22:11 -0700
In-Reply-To: <CAJhGHyDjsmQOQQoU52vA95sddWtzg1wh139jpPYBT1miUAgj6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
 <CAJhGHyDjsmQOQQoU52vA95sddWtzg1wh139jpPYBT1miUAgj6Q@mail.gmail.com>
Message-ID: <ZrooozABEWSnwzxh@google.com>
Subject: Re: [PATCH 19/22] KVM: x86/mmu: Add infrastructure to allow walking
 rmaps outside of mmu_lock
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024, Lai Jiangshan wrote:
> On Sat, Aug 10, 2024 at 3:49=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
>=20
> > +
> > +static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> > +{
> > +       unsigned long old_val, new_val;
> > +
> > +       old_val =3D READ_ONCE(rmap_head->val);
> > +       if (!old_val)
> > +               return 0;
> > +
> > +       do {
> > +               /*
> > +                * If the rmap is locked, wait for it to be unlocked be=
fore
> > +                * trying acquire the lock, e.g. to bounce the cache li=
ne.
> > +                */
> > +               while (old_val & KVM_RMAP_LOCKED) {
> > +                       old_val =3D READ_ONCE(rmap_head->val);
> > +                       cpu_relax();
>=20
> The sequence of these two lines of code can be improved.

Oh yeah, duh, re-read after PAUSE, not before.

Definitely holler if you have any alternative ideas for walking rmaps witho=
ut
taking mmu_lock, I guarantee you've spent more time than me thinking about =
the
shadow MMU :-)

