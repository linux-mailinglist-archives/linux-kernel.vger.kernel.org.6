Return-Path: <linux-kernel+bounces-206359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C690085D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8261F21DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB09198A24;
	Fri,  7 Jun 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGF5ChVz"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061A198846
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773199; cv=none; b=CyQ41cH/J1KX7DHvobI60Huhjo4FlrZlsYdqydPNHjxOWY5Ja07rvIAcMtph3I8766+AqthCQsRFG1TEAxLQtx/cNXpuQmjXlSujEsERR/xqHIhnVmBRz0kN92ZFoo5l2DEKHmFXqnKMlbGKeAoBeosN6aFnuivVigT6I9ckvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773199; c=relaxed/simple;
	bh=7n0apmTpqZ+tog798fnZb4ZTZm7Gl3vutnIWL1LYnuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsbeQo2aYtRn7+XZaGQjUkDfxG7RkQZXAJrPvX3Vk7OK3mG24GR8HZ9w8uLML179OpoETBt54w5+pUI6rCMYBai8Y+z6OZIhVIYlMka/dUFWOIbf2rma0xLFoczIwynqOXo0OFg+N2/fGBTRXledCcjBFwZTsHKfu72Po3EZ35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGF5ChVz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so9067a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717773195; x=1718377995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9DLoOIliT2vV+jCDlYYVBA1v56GjGd/sBFCy6REvhs=;
        b=oGF5ChVzmkSrf4CDt2HjlSTVWxz0aYNl3lhxr2e67cX6NlsRsWve/wt9BUszmxwKV/
         KOi8z8tpmG6DM9EVZZE6v7rpbNsSJaKmwxQav+hh8XcwWF0tMjgtsZ+YippmyST/Ccc1
         HINUkWQYHln80yuBonj6B/0l4uXQ/xLdBD9n3xRqYJLSayvHUOiAJU+pK8LWVSZ2Jd2s
         yWcydFqS/ro21AUCmgZdpHYS6Mli4NdHd+3oKYvPIWhY+HxAaXYTd63tAiU6b4LdYASf
         ODfoYPGtmG202PkiEnCOF+xh+B9BE/4q8Lfh3z4hKQiEYW/OuUqqmhWzZQdFPy15YQ2J
         QTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773195; x=1718377995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9DLoOIliT2vV+jCDlYYVBA1v56GjGd/sBFCy6REvhs=;
        b=QiIFq+AFFvgbAu4ZqyvUYgsbD0GM6X7M0AqrD6IPJCVBw7SNd/EnNxM3/8OEJ/KJrO
         ZseT56ndRbxBSC42aNJ/MMNZ7OXFsvZVBMoJRuN+rd7mK4LFG8aQ9hn/XgpNZVu3ur9S
         VLn0BAjWG3QbcOJnAiibr0Ts2E9qmQs+XsJu6i4IVFZ0p9Ab7j+/+MPAJixeZWAMh05j
         OchpwTonU8KX5ob0op6ruhAyFURx8JRwzHzvtI4jh6EEs0DB2yAV6iiL2sTsfJjHZJlc
         gGvkptutK/j6M2YdzTk/b7NIzWrgDeNQdn+k7jAWnCN7N26XknnJEGxun+Iy3AqkMGgm
         jsHg==
X-Gm-Message-State: AOJu0Yw5ScDQVyFu6jTMilRJUMi3wDrR6ifkdMvMIKRKRvKyEavp4SW6
	kOaaCcM7U2p046cDDW1J3eq2oZzwz11FMXCEfxYAICQBn2RKet9060BQaKUG6eeKKVVE1HdWByB
	W8qOD1cYK/uc6JAMTtYVHIwqsOyGrOrq8wYXHfQ0HT9vZkd7pcjdc
X-Google-Smtp-Source: AGHT+IGgwajHKpYdDWMQLIOmMJsfkmT9wQMD93gE5Vvy1QzU36KDO2gHuZ/Tqx8lOxhLvhtrGDMlAetFVDjv7C4htvM=
X-Received: by 2002:a50:fb96:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57aa6e8e2e9mr588051a12.6.1717773194672; Fri, 07 Jun 2024
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
 <Zlm-26QuqOSpXQg7@zx2c4.com> <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
 <ZmMamtll1Yq1yfxc@zx2c4.com>
In-Reply-To: <ZmMamtll1Yq1yfxc@zx2c4.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 7 Jun 2024 17:12:38 +0200
Message-ID: <CAG48ez0pan8aLGjHtoDdrpiP+e5YrGeuD_RzDXgzUwkUvWYLjA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:35=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
> On Fri, May 31, 2024 at 03:00:26PM +0200, Jann Horn wrote:
> > On Fri, May 31, 2024 at 2:13=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > > On Fri, May 31, 2024 at 12:48:58PM +0200, Jann Horn wrote:
> > > > On Tue, May 28, 2024 at 2:24=E2=80=AFPM Jason A. Donenfeld <Jason@z=
x2c4.com> wrote:
> > > > > c) If there's not enough memory to service a page fault, it's not=
 fatal.
> > > > [...]
> > > > > @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_=
struct *vma, unsigned long address,
> > > > >
> > > > >         lru_gen_exit_fault();
> > > > >
> > > > > +       /* If the mapping is droppable, then errors due to OOM ar=
en't fatal. */
> > > > > +       if (vma->vm_flags & VM_DROPPABLE)
> > > > > +               ret &=3D ~VM_FAULT_OOM;
> > > >
> > > > Can you remind me how this is supposed to work? If we get an OOM
> > > > error, and the error is not fatal, does that mean we'll just keep
> > > > hitting the same fault handler over and over again (until we happen=
 to
> > > > have memory available again I guess)?
> > >
> > > Right, it'll just keep retrying. I agree this isn't great, which is w=
hy
> > > in the 2023 patchset, I had additional code to simply skip the faulti=
ng
> > > instruction, and then the userspace code would notice the inconsisten=
cy
> > > and fallback to the syscall. This worked pretty well. But it meant
> > > decoding the instruction and in general skipping instructions is weir=
d,
> > > and that made this patchset very very contentious. Since the skipping
> > > behavior isn't actually required by the /security goals/ of this, I
> > > figured I'd just drop that. And maybe we can all revisit it together
> > > sometime down the line. But for now I'm hoping for something a little
> > > easier to swallow.
> >
> > In that case, since we need to be able to populate this memory to make
> > forward progress, would it make sense to remove the parts of the patch
> > that treat the allocation as if it was allowed to silently fail (the
> > "__GFP_NOWARN | __GFP_NORETRY" and the "ret &=3D ~VM_FAULT_OOM")? I
> > think that would also simplify this a bit by making this type of
> > memory a little less special.
>
> The whole point, though, is that it needs to not fail or warn. It's
> memory that can be dropped/zeroed at any moment, and the code is
> deliberately robust to that.

Sure - but does it have to be more robust than accessing a newly
allocated piece of memory [which hasn't been populated with anonymous
pages yet] or bringing a swapped-out page back from swap?

I'm not an expert on OOM handling, but my understanding is that the
kernel tries _really_ hard to avoid failing low-order GFP_KERNEL
allocations, with the help of the OOM killer. My understanding is that
those allocations basically can't fail with a NULL return unless the
process has already been killed or it is in a memcg_kmem cgroup that
contains only processes that have been marked as exempt from OOM
killing. (Or if you're using error injection to explicitly tell the
kernel to fail the allocation.)
My understanding is that normal outcomes of an out-of-memory situation
are things like the OOM killer killing processes (including
potentially the calling one) to free up memory, or the OOM killer
panic()ing the whole system as a last resort; but getting a NULL
return from page_alloc(GFP_KERNEL) without getting killed is not one
of those outcomes.

