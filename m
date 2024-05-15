Return-Path: <linux-kernel+bounces-180217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8E8C6B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660552841DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9C47F63;
	Wed, 15 May 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9HJpiRk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3B28680
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794427; cv=none; b=ZPB7DJ0RlTquKu3yIRbUmBfXM/BVjzmwaigRi/cZNMHE7j3Lk/aPTkcj+G7UL2mZE0VFxS+1Oud3++Gk34lTBWqcALQU3xAtUMOmFBl5i3rYb/0rihgE01KTHhY93E2raCtPK+rK0iHrIzj6a3aToVn/W0+KI7TVAlqllQQQ+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794427; c=relaxed/simple;
	bh=BczV/FF4eIzKWVrSkkC8DYFt1QqsMU4CdnShIk6/U3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCcdxwhw9uhcApmNnQRj5NsZcJtJD0ffRij+IeGX24bMAJfiFsEkHew8SErkZoUwDXGck2byiczatIYlo+VvV0zTt3/7dD/tUYXg7Io5cQvwif7z5WwMuCXGdu2UVJRL/GfayhrZUOfPP1BfnrvpQfdnbWV1NAAPbpCz5MmpbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9HJpiRk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34db6a29998so5551281f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715794424; x=1716399224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REXKNTAxo862A8ReBddrMUjz3K+lbyLjZMQEflUAct8=;
        b=s9HJpiRkvmLjvVF7EK6rqcWhZkYTfdp2i6sAc9gf8G1joqcuqe2fWvimC+lsmN3Iyd
         F/cIbxok4h0TDxs92Inlt/2O7VG4Cj+87c3kIDhEPkVtlaA75A2wV+zbyZ28dHNYFFfW
         /jeTm02s5ZuxCBjiLa1zQGr0Bw/smD0d1UnSLujEVLuVuJqK5b+69a0I9Tf81n3wVNdC
         qhhieCMWqWhp8PCF9wYIQmHJnuq47Gk7fK0NsKMua0j/90CLBIpTpGhG++B7aKI/4AzA
         vOydfcGb1+1O9u6VAR213zUoSTE2hjdn0Yg8JN7KyVjWX98U2tJ6uee3uH3TrK0r3ffv
         ChDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794424; x=1716399224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REXKNTAxo862A8ReBddrMUjz3K+lbyLjZMQEflUAct8=;
        b=vHcRvFv0BLER0gWQrsygUUvVcagI5K4a94DIphR8C6EMcCSdthu3YS1OyZnepHKESx
         w9qUQYJo/NgXTj2DDfw927ZAVCN0qInwDZOKNzUsut+fqt1l/SiJfE4uOdMl8yruOau0
         z+DCJtn66ddTsx/88gmW0HCviOT5wbIEpBbUSiW2TRyK2OAtIHGaCYetkGt3IMLz+5Ld
         WnhIlc9WJKEf3PWHCDqrWuP9rs5WPTQE0qsc9gW3SYjPVxjQfc+Zvm2U497VsNYq5CCF
         1ez9LdnNCKusivdEc5NFmoQOWFUutTVfP5Q3A4wki0zKvrAqIov+NAn/TaRFLrHXBgqk
         wSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvtzdhLFIVg7ui4WCiqzHLHvVSJSNXlQulNfrTLwJW0mgoPxRu13SkN29IwijYPTYn9tkVAbqFwogDE4SdBJQT4Ke8C8LSrKu2ILKx
X-Gm-Message-State: AOJu0YzqfDEX42nR3RVNA6disxGeugOIcg0sbdauJ+nrvx8/lniendPN
	lky4TIN/3cc4E3J6WDvuYgvShuqNiQ2a/6ZzMAQW1kcI/iZEdSbP0uuxyZRR2sqK7gqBfO22AHr
	Qj94mQjdfX8zhZSjSHArMzujjLZmoU3dFgZyb
X-Google-Smtp-Source: AGHT+IECmpnR3hqErRAHKi5zZVxQqX+AzRVW0B5FrzgG6JtiQjlGQI3473zUOeMvDrH067XEBa75l4kB51sO6OrPOMs=
X-Received: by 2002:a5d:5351:0:b0:343:e02f:1a46 with SMTP id
 ffacd0b85a97d-3504a62fb12mr13056195f8f.2.1715794423681; Wed, 15 May 2024
 10:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com> <20240515104142.GBZkSRZsa3cxJ3DKVy@fat_crate.local>
 <ZkSUaVx3uCIPkpkJ@localhost.localdomain>
In-Reply-To: <ZkSUaVx3uCIPkpkJ@localhost.localdomain>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 15 May 2024 10:33:03 -0700
Message-ID: <CAJHvVchGGJkEX=qroW=+N-RJDMDGuxM4xoGe7iOtRu9YcfxEEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker poison errors
To: Oscar Salvador <osalvador@suse.de>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, John Hubbard <jhubbard@nvidia.com>, 
	Liu Shixin <liushixin2@huawei.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:54=E2=80=AFAM Oscar Salvador <osalvador@suse.de> =
wrote:
>
> On Wed, May 15, 2024 at 12:41:42PM +0200, Borislav Petkov wrote:
> > On Fri, May 10, 2024 at 11:29:26AM -0700, Axel Rasmussen wrote:
> > > @@ -3938,7 +3938,7 @@ static vm_fault_t handle_pte_marker(struct vm_f=
ault *vmf)
> > >
> > >     /* Higher priority than uffd-wp when data corrupted */
> > >     if (marker & PTE_MARKER_POISONED)
> > > -           return VM_FAULT_HWPOISON;
> > > +           return VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_SILENT;
> >
> > If you know here that this poisoning should be silent, why do you have
> > to make it all complicated and propagate it into arch code, waste
> > a separate VM_FAULT flag just for that instead of simply returning here
> > a VM_FAULT_COMPLETED or some other innocuous value which would stop
> > processing the fault?
>
> AFAIK, He only wants it to be silent wrt. the arch fault handler not scre=
aming,
> but he still wants to be able to trigger force_sig_mceerr().

Right, the goal is to still have the process get a SIGBUS, but to
avoid the "MCE error" log message. The basic issue is, unprivileged
users can set these markers up, and thereby completely spam up the
log.

Also since this is a process-specific thing, and it's not a real
hardware poison event, it's unclear system admins care at all at a
global level (this is why we didn't want to switch to just
printk_ratelimited for example). Better to let the process handle the
SIGBUS however it likes for its use case (logging a message elsewhere,
etc.).

That said, one thing I'm not sure about is whether or not
VM_FAULT_SIGBUS is a viable alternative (returned for a new PTE marker
type specific to simulated poison). The goal of the simulated poison
feature is to "closely simulate" a real hardware poison event. If you
live migrate a VM from a host with real poisoned memory, to a new
host: you'd want to keep the same behavior if the guest accessed those
addresses again, so as not to confuse the guest about why it suddenly
became "un-poisoned". At a basic level I think VM_FAULT_SIGBUS gives
us what we want (send SIGBUS to the process, don't log about MCEs),
but I'm not confident I know all the differences vs. VM_FAULT_HWPOISON
on all the arches.

>
>
> --
> Oscar Salvador
> SUSE Labs

