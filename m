Return-Path: <linux-kernel+bounces-416096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA389D402F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149231F2160D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C019153814;
	Wed, 20 Nov 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiVh/hzr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF714AD3D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120581; cv=none; b=kToUVbAqd2FBYaFw4uyR9e3bhErYA3tWogkDJWJfS6F+NdvUSKZmgQGWAIh4GwSM/PxicXItLjVLxJ3+Orh6fUWE/dj8Rkcfqz59dSUQ6nYNufqh5MM/u9NpLEn1iIz5SlT/f1TVAOVX0NtWc0v37mkABfPDjxjy8aDJNyzP98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120581; c=relaxed/simple;
	bh=VfR9wdxer9kVXX+JA4Pugu2yWhtmDNWs7LhPukfN9pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDeYOKFuWVl9cmbz/GxfuauFOekzdyeRoUb6Mo6eEfbKtdS0KjopWmTmMlfezZWtbor+FpIriL1+py4pcSsxHu5Ft1IO+CyA9J2fRbGOTQHZFcbZ+pkdLmPVkcXHlgJSZeACNBpdWg71ekaXPw9vcBskrH4qbVmkf2g9hJL3ZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiVh/hzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732120579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhU3S0A4Mnpsnqs/3/13cFEa605q4UA1j817veP3A6U=;
	b=RiVh/hzrbl2C6NbK9kYda3B4naVZmX3s0UjEV5cv+H0RcJFKVF2SgPYumMgxhunHG3Ktvp
	Mcii5d+BSD3WzLjB2Qi0p2IgYjlRGVZpku+Z1LLAwP2zy42sRVjF4MsSa+BuS7rsHC6iKN
	A7UztKCT4UGaBdViIRzIUlgiXu6OT4g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-8GrjGyztPAKbPyOARDdjdw-1; Wed, 20 Nov 2024 11:36:17 -0500
X-MC-Unique: 8GrjGyztPAKbPyOARDdjdw-1
X-Mimecast-MFC-AGG-ID: 8GrjGyztPAKbPyOARDdjdw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-211555dce08so53590695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120575; x=1732725375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhU3S0A4Mnpsnqs/3/13cFEa605q4UA1j817veP3A6U=;
        b=Qby+vcDIdlJ1YCGOO2yTOyK0kpqZOsV9cX7eGM/o+BQ+2SRVItAWfQ9Gnw2YALe6PY
         XH0eqxxIJGOyX4F3y1Y5LmU0g3OupkCC/mTld7+NtACGaULmJbSyP8bP507zly1Fg+RD
         85Bh0Z9tcnrj40FCJolCCmU0nwsWyqQYyQwFMHMHPCz7mAkRt/D/FslW6pCRuXYZ5NLN
         Ry2kddzxnimvEObAj8pQbVexvQDzXC5VVpAUD1WtWyqX07UTdvZ4w0Hfq11Sgh/aT6oc
         ilX/J+sk4sO/YJN5Ge9ex8c18vBG8RQ2DbnpkuCFAuNntVCjqUVvoci6QfMisyhA70mF
         u+nw==
X-Forwarded-Encrypted: i=1; AJvYcCUkrBrhNxMl/pLLrPm4nVMPjrcEdexQWCAQxx5qFeuRH2x28G6EC37vj13OFAJtUsWuXoeH3Go6y6GyAAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZgSoFBmdH6l1Rw2ryD4Z01rxLPBuj+F2n95RIb9s9/cM8vZF
	jh1tRHwsIZ5rRX39G0BMCdQjqCx+zDeJvxS8DQlyGVWey5Weute50tLdAqbF2ctGTETgRIVul4o
	Yav4fwwCi2nqSDtaYz2c9u1pdSC3WGq09QJcfdgjSK48gmkXKQVFhMOZT85GT5MuGsS0OlLmUYD
	wXsYKbc8utUEjHFlNgUNUHd9QWppLORT8dr/g4
X-Received: by 2002:a17:902:ccd1:b0:20b:b40b:3454 with SMTP id d9443c01a7336-2126f9fb108mr36420065ad.0.1732120575530;
        Wed, 20 Nov 2024 08:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEndC+AthKB1mpAbXnqOydUaK60UqI1oD1suHPMIJwIkfHNBJIHODhd4fFPf5EbSrZJ9RZvD8mL6P1+1iEOyY=
X-Received: by 2002:a17:902:ccd1:b0:20b:b40b:3454 with SMTP id
 d9443c01a7336-2126f9fb108mr36419915ad.0.1732120575211; Wed, 20 Nov 2024
 08:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
In-Reply-To: <20241120102602.3e17f2d5@gandalf.local.home>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Wed, 20 Nov 2024 17:36:04 +0100
Message-ID: <CAGegRW74BOvkAmo4UiH-D45o4HijL7B4CPvEvNfze3AEoTKfCg@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looping selinix Maintainers into the conversation.


On Wed, Nov 20, 2024 at 4:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 20 Nov 2024 14:53:13 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> > > -static void print_unreferenced(struct seq_file *seq,
> > > +static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
> > >                            struct kmemleak_object *object)
> > >  {
> > > -   int i;
> > > -   unsigned long *entries;
> > > -   unsigned int nr_entries;
> > > -
> > > -   nr_entries =3D stack_depot_fetch(object->trace_handle, &entries);
> > >     warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\=
n",
> > >                       object->pointer, object->size);
> > >     warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> > > @@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *=
seq,
> > >     hex_dump_object(seq, object);
> > >     warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checks=
um);
> > >
> > > +   return object->trace_handle;
> > > +}
> >
> > What I don't fully understand - is this a problem with any seq_printf()
> > or just the backtrace pointers from the stack depot that trigger this
> > issue? I guess it's something to do with restricted pointers but I'm no=
t
> > familiar with the PREEMPT_RT concepts. It would be good to explain,
> > ideally both in the commit log and a comment in the code, why we only
> > need to do this for the stack dump.
>
> In PREEMPT_RT, to achieve the ability to preempt in more context,
> spin_lock() is converted to a special sleeping mutex. But there's some
> places where it can not be converted, and in those cases we use
> raw_spin_lock(). kmemleak has been converted to use raw_spin_lock() which
> means anything that gets called under that lock can not take a normal
> spin_lock().
>
> What happened here is that the kmemleak raw spinlock is held and
> seq_printf() is called. Normally, this is not an issue, but the behavior =
of
> seq_printf() is dependent on what values is being printed.
>
> The "%pK" dereferences a pointer and there's some SELinux hooks attached =
to
> that code. The problem is that the SELinux hooks take spinlocks. This wou=
ld
> not have been an issue if it wasn't for that "%pK" in the format.
>
> Maybe SELinux locks should be converted to raw? I don't know how long tha=
t
> lock is held. There are some loops though :-/
>
> avc_insert():
>
>         spin_lock_irqsave(lock, flag);
>         hlist_for_each_entry(pos, head, list) {
>                 if (pos->ae.ssid =3D=3D ssid &&
>                         pos->ae.tsid =3D=3D tsid &&
>                         pos->ae.tclass =3D=3D tclass) {
>                         avc_node_replace(node, pos);
>                         goto found;
>                 }
>         }
>         hlist_add_head_rcu(&node->list, head);
> found:
>         spin_unlock_irqrestore(lock, flag);
>
> Perhaps that could be converted to simple RCU?
>
> As I'm sure there's other places that call vsprintf() under a raw_spin_lo=
ck
> or non-preemptable context, perhaps this should be the fix we do.
@Paul and @Stephen do you have any feedback on this idea?

>
> -- Steve
>


--=20
---
172


