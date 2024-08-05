Return-Path: <linux-kernel+bounces-275298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CC9482F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1321C210B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3916C696;
	Mon,  5 Aug 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvzbsXD2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22116B388
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888680; cv=none; b=Ql9LsECYTpTeRwUN6w0fFjQYMROFLByQh/IAdMUKd1sZ3cJIahI3jUX/bcJx7TaZMS+NdJuPgRbAFSXFQx6wS2nmyZDUwz3zlyJk+xBgWB7gXSEt0wTACCtaCV2QaW6etOY0HhZ4/wm49sEf2c3XpywNv6LX5WsmYI23XshzyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888680; c=relaxed/simple;
	bh=Lgd+kUvL2TZX2jMRRUTnzapBvPtBzmUh9hoqjROxNIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VMfImOVbcYOzYzXPPWmBB5i4HLrFWC7aTfRbuqfsUVUnGei9HNAgX7UIq5xXJQRidsR/WYoQxX3th5ShTuuoplggSb9eO+BfEnHs6QUWZXf9S//X1ujpuIE7l+bxdFjmkZPbbfn2yhkjZAPq9DEbyejuAWxVTYrwF1b4WwcrCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvzbsXD2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0bbd1ca079so9892820276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722888677; x=1723493477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ3XYv8vbRbl6n2xhFfZGwAgnhZe+uZriKCMNILDzOw=;
        b=lvzbsXD2juPpg6aRzAVz/i53hTWHB8oZyisYHUP+rMHnUY49lwy+DjoclHGJnpMhje
         uOaE2zNc3EP1a+5BfA+ZCryC2BfpIKTDYG8SqDNoNPUxxGAkjjf8lKNod/pqKE1Tq0vH
         EvysnYfd5omW7j55DuxoFu73Cn3qFyLKDmRIVfXvop9bX/d/FJC+Rm+DNLzjjgFEWlW2
         3BOwE+yAQA0qcn29jwa7PaniKkfFO3ocF31MPiDV4/JihWkzdxMZafY3QURl7Qo/ePOk
         tyc7e49EiN1HGSZ/e89bDOAMULDoA/vInbKzLZquX9GEZz8gFCCo6rDxQTktgPqc0nKA
         Z2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888677; x=1723493477;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZ3XYv8vbRbl6n2xhFfZGwAgnhZe+uZriKCMNILDzOw=;
        b=fS2Dw8p316Z6z8BJBCpPCB28cVoW5UIAaW6AeAxjBM25t5iovR67tV72V2Qxp08qeZ
         /GisJc9EooLCRjHACrKr5Vg7TtCl+kYcEuYBXFdPkGhZw7rvnx2mgaHefPlXhIHL57/A
         4yTFlz3puejS3aHI4+H+QrVseaM9o8AgoIZ7C8ZOuzkUEKQmDSM29+ZayTrlGny7Q1ik
         PcE+PB2TQm8eO9Xfk+VRIAD3mbQ+y9Fa1YrryEMHtS+SYfQEnuNAkRnylVAzgKoswvh0
         bL94873dnzxKsM2hW+Y9ajr3Gbr16qCvygu51J8fig3MTpoIzaAuHUOoU7ZJiITLw+Qo
         4cgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQFuqh8YmRAMGBV3cnVoOhmJXkkkaTUaKWp74epAuHpZH14tw3Q391bVy1I42fZvWOUhMpje1XtuMQA33vPxBAnU+BWqSmC6QZzXdS
X-Gm-Message-State: AOJu0YyPCL8ZyomAxn1kDdS0qjn7/2I45fQILNNIInWXeRVd5ctAY5ho
	21DbZ7gIc8AJ6p/4JnrKu99/OT1ZDh0z1Ds7plv3aE0FmrIHq5upwzplhLhsWIseCEO4r/DiYIJ
	jLg==
X-Google-Smtp-Source: AGHT+IEqU2AlArCCHC4fMays/2bcUfDHhzQBmI6OBNsXgcq9heLSZ2NfK8PClbmknew6WDJy9JdEoe9cp70=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b12:b0:e03:6556:9fb5 with SMTP id
 3f1490d57ef6-e0bde481682mr268041276.11.1722888677198; Mon, 05 Aug 2024
 13:11:17 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:11:16 -0700
In-Reply-To: <CALzav=few=dq5_9QC=ivRWxEtRvQR47BWh5j5-Sgg3Zy7_Rx0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com> <CALzav=few=dq5_9QC=ivRWxEtRvQR47BWh5j5-Sgg3Zy7_Rx0Q@mail.gmail.com>
Message-ID: <ZrEx5HzBYVHH1piA@google.com>
Subject: Re: [RFC PATCH 0/9] KVM: x86/mmu: Preserve Accessed bits on PROT changes
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024, David Matlack wrote:
> On Thu, Aug 1, 2024 at 11:35=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > This applies on top of the massive "follow pfn" rework[*].  The gist is=
 to
> > avoid losing accessed information, e.g. because NUMA balancing mucks wi=
th
> > PTEs,
>=20
> What do you mean by "NUMA balancing mucks with PTEs"?

When NUMA auto-balancing is enabled, for VMAs the current task has been acc=
essing,
the kernel will periodically change PTEs (in the primary MMU) to PROT_NONE,=
 i.e.
make them !PRESENT.  That in turn results in mmu_notifier invalidations (us=
ually
for the entire VMA, eventually) that cause KVM to unmap SPTEs.  If KVM does=
n't
mark folios accessed when SPTEs are zapped, the NUMA-induced zapping effect=
ively
loses the accessed information.

For non-KVM setups, NUMA balancing works quite well because the cost of the=
 #PF
to "fix" the NUMA-induced PROT_NONE is relatively cheap, especially compare=
d to
the long-term costs of accessing remote memory.

For KVM, the cost vs. benefit is very different, as each mmu_notifier inval=
idation
forces KVM to emit a remote TLB flush, i.e. the cost is much higher.  And i=
t's
also much more feasible (in practice) to affine vCPUs to single NUMA nodes,=
 even
if vCPUs are pinned 1:1 with pCPUs, than it is to affine a random userspace=
 task
to a NUMA node.

Which is why I'm not terribly concerned about optimizing NUMA auto-balancin=
g; it's
already sub-optimal for KVM.

