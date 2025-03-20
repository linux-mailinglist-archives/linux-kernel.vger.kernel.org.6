Return-Path: <linux-kernel+bounces-570180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D6A6AD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6100B3B3A59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D2226CFB;
	Thu, 20 Mar 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8oYyX7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811A22687A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495879; cv=none; b=Atwy+91pwHIxFR/nclMaKelXOY8cCZRF/WF/SofpKnmEvCt+CbojQUOI8bGel+zlQw40aod2kxlF6BncpHrcrWnPgIxgBp99pcJjkPdDLf+Q8zR7j0yxNdk6HZwcAyqt6DKWD1/GS/C2aPL7NjDofKryKCJv5Xypq4wL0G0bPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495879; c=relaxed/simple;
	bh=5E+gk3dDJBqcJflWQKwzZgMfkBD4hOfi+ZqdjqBbLGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve3H853pkPk7Bh9QokvQpECHULJzARvKyVYK3M0IE2ZOjGVj0gyQRJ3K2nxwn6l+am3JLz4rjmHag/HCJ57zm6vy+vfgGhkAgxzi8rDNhqVw9n8Ni+PQBFhPYv2Org9NnVmJOWhg2xPiqmQ/XYUFC0ZJ6gG/u81iz5MsAdXuP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8oYyX7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742495875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRiCYvHgNuxH1FPgDPD0FFn3xj5XtIWRmSRxdNsJ/mQ=;
	b=e8oYyX7njfZPyHpjBB57oxQ1yh2CTs4GWzKiulPGfztGOeE3pUaHUpMsv3WwwiCw8Zpb0K
	tjoPHZxYL3fn8kQ3AbYPLg5BkzZdphzVXVZEP6O2MCZyXzNAiNmJ4BlGFQgcJI5ZoWNYsR
	fX7QRnMeYg5oQiuRauwJ7P5BSJ/jfOQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-iMGZ3yz8O1Gxbb893nEGqQ-1; Thu, 20 Mar 2025 14:37:53 -0400
X-MC-Unique: iMGZ3yz8O1Gxbb893nEGqQ-1
X-Mimecast-MFC-AGG-ID: iMGZ3yz8O1Gxbb893nEGqQ_1742495872
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5498963ebc3so608262e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495872; x=1743100672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRiCYvHgNuxH1FPgDPD0FFn3xj5XtIWRmSRxdNsJ/mQ=;
        b=sneBCS7Yucgp08WUR8S7v79+gWMZfxopx9e39yi/+89zywYye2DZ/0WyDBd+qbqQe+
         D++W9mn73qT0GhIPLg4ThtjHyxOysJUXT5wOzODNHXqDk2O9LFL3Wdfkl+6LhzZWIn0E
         K52O9p6KcCb6y0p+ZjxlnIBLJUqd/dceyL005rip4VBiMAZK2xDJe3SX0nOmMeR1xSxZ
         jkpumIYFhv21gJ7QlVj2jl6uJMj4fD51kgUFFWF6WXF1vxHoPeFc2jYJkilwUrTYNmKh
         EpjqGzz4hlU2wBAM0pBRnewohWp+VL00/q/z/ylVDtVxFtqvXSa2DNX5ZAw8zA2fD3nE
         itQw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KNYzJxo0T3q6//jt8Asr5YqbW2ISVh6n73ra+ezm129RQ+AevG0igIKbh6Qm9v3Uhr9ZhtfxFViPkpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvnJh6qHxiIaN5iiQ/ciwc2p5s7+5mPoWg32k0hOMO1BC+LLp
	PuImXuE6aS788XdTTeDm65csrDm/yz0d9PlVvqJ6YN20xeOtC0IsVha7LdD6F2eeDYPgHyGfTHL
	FIJ8NX2Dh6eeeUtTipKasyoD9kNe+hh7AUfWBiBBTIse00ASxg3CnO0pURK+Ra8gzFwZ6t0Edps
	iKDdzWul1sVnxmED8DXdPCYLRw8wv0AHyNmDFZ
X-Gm-Gg: ASbGncunYcayv4Pp3BH2otmdq+0S0CbC2XoUw8+ApgYEXfEAD1htE2sgubO7DD/zG+1
	FUHAh/Z2c2KoIa0H2AG0uNngYxRGmUuOyp9QbffUvJo9U3ETwFm9t+qmRYfyKAcW/MT0oPex4Zr
	Xv2kuP8CSfRScoAjXzeIuBRJKPHcQdOQ==
X-Received: by 2002:a05:6512:b94:b0:545:154:52b0 with SMTP id 2adb3069b0e04-54ad648055amr154525e87.22.1742495872148;
        Thu, 20 Mar 2025 11:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWRhpc7Xm1cW0IQ8JmT2HdL/zHrgZbxO1Dog7Kp6xmyYyKeSxwiGV0Gngg8LJz65s+IAsRLc5olv7viGOy/BY=
X-Received: by 2002:a05:6512:b94:b0:545:154:52b0 with SMTP id
 2adb3069b0e04-54ad648055amr154514e87.22.1742495871676; Thu, 20 Mar 2025
 11:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142213.2623518-1-herton@redhat.com> <CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
 <CAJmZWFFyvqivwSMGA-T2HnOTr1GtYAvvWVZ8YuASC+cfSsB42w@mail.gmail.com> <CAGudoHEDAzOrndyJeb7L95cMPmHHk0O5wk=tRCe35FE6GVYs1w@mail.gmail.com>
In-Reply-To: <CAGudoHEDAzOrndyJeb7L95cMPmHHk0O5wk=tRCe35FE6GVYs1w@mail.gmail.com>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Thu, 20 Mar 2025 15:37:39 -0300
X-Gm-Features: AQ5f1Jqz_Ja0pi3GkZE8jnDPS1hdsDo7BWzkrksioOIIocSNp4ReDi6DNZtyLMw
Message-ID: <CAJmZWFFK43eS4oELFsg9OZu9UJr0Eiqy3KHLM75mv0bsXcrHwA@mail.gmail.com>
Subject: Re: [PATCH] x86: write aligned to 8 bytes in copy_user_generic (when
 without FSRM/ERMS)
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:02=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Mar 20, 2025 at 6:51=E2=80=AFPM Herton Krzesinski <hkrzesin@redha=
t.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 11:36=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > >
> > > On Thu, Mar 20, 2025 at 3:22=E2=80=AFPM Herton R. Krzesinski <herton@=
redhat.com> wrote:
> > > > diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_6=
4.S
> > > > index fc9fb5d06174..b8f74d80f35c 100644
> > > > --- a/arch/x86/lib/copy_user_64.S
> > > > +++ b/arch/x86/lib/copy_user_64.S
> > > > @@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
> > > >         _ASM_EXTABLE_UA( 0b, 1b)
> > > >
> > > >  .Llarge_movsq:
> > > > +       /* Do the first possibly unaligned word */
> > > > +0:     movq (%rsi),%rax
> > > > +1:     movq %rax,(%rdi)
> > > > +
> > > > +       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
> > > > +       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
> > > > +
> > > > +       /* What would be the offset to the aligned destination? */
> > > > +       leaq 8(%rdi),%rax
> > > > +       andq $-8,%rax
> > > > +       subq %rdi,%rax
> > > > +
> > > > +       /* .. and update pointers and count to match */
> > > > +       addq %rax,%rdi
> > > > +       addq %rax,%rsi
> > > > +       subq %rax,%rcx
> > > > +
> > > > +       /* make %rcx contain the number of words, %rax the remainde=
r */
> > > >         movq %rcx,%rax
> > > >         shrq $3,%rcx
> > > >         andl $7,%eax
> > >
> > > The patch looks fine to me, but there is more to do if you are up for=
 it.
> > >
> > > It was quite some time since I last seriously played with the area an=
d
> > > I don't remember all the details, on top of that realities of uarchs
> > > probably improved.
> > >
> > > That said, have you experimented with aligning the target to 16 bytes
> > > or more bytes?
> >
> > Yes I tried to do 32-byte write aligned on an old Xeon (Sandy Bridge ba=
sed)
> > and got no improvement at least in the specific benchmark I'm doing her=
e.
> > Also after your question here I tried 16-byte/32-byte on the AMD cpu as
> > well and got no difference from the 8-byte alignment, same bench as wel=
l.
> > I tried to do 8-byte alignment for the ERMS case on Intel and got no
> > difference on the systems I tested. I'm not saying it may not improve i=
n
> > some other case, just that in my specific testing I couldn't tell/measu=
re
> > any improvement.
> >
>
> oof, I would not got as far back as Sandy Bridge. ;)
>
> I think Skylake is the oldest yeller to worry about, if one insists on it=
.
>
> That said, if memory serves right these bufs like to be misaligned to
> weird extents, it very well may be in your tests aligning to 8 had a
> side effect of aligning it to 16 even.

I went back to Sandy Bridge because it was the first one I found
from newer to oldest on the Intel line that did not have erms (and
of course no fsrm). I did change the patch for a 32-byte alignment
before rep movsb in the erms case and tested with a xeon 8280
(cascade lake which is enhanced skylake, so hope is valid here),
but I did not get improvements in my testing. You may be right that
in aligning to 8-byte it might be 16-byte aligned as well, but in practice
it made no difference in my testing.

>
> > >
> > > Moreover, I have some recollection that there were uarchs with ERMS
> > > which also liked the target to be aligned -- as in perhaps this shoul=
d
> > > be done regardless of FSRM?
> >
> > Where I tested I didn't see improvements but may be there is some case,
> > but I didn't have any.
> >
> > >
> > > And most importantly memset, memcpy and clear_user would all use a
> > > revamp and they are missing rep handling for bigger sizes (I verified
> > > they *do* show up). Not only that, but memcpy uses overlapping stores
> > > while memset just loops over stuff.
> > >
> > > I intended to sort it out long time ago and maybe will find some time
> > > now that I got reminded of it, but I would be deligthed if it got
> > > picked up.
> > >
> > > Hacking this up is just some screwing around, the real time consuming
> > > part is the benchmarking so I completely understand if you are not
> > > interested.
> >
> > Yes, the most time you spend is on benchmarking. May be later I could
> > try to take a look but will not put any promises on it.
> >
>
> Now I'm curious enough what's up here. If I don't run out of steam,
> I'm gonna cover memset and memcpy myself.
>
> --
> Mateusz Guzik <mjguzik gmail.com>
>


