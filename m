Return-Path: <linux-kernel+bounces-404609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3309C459C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879352835FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D21AB512;
	Mon, 11 Nov 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RapZPwUa"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416071AA7A4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352244; cv=none; b=rBlIcQJipdJNX2Lzer1cPr8fdniZbhvFUInWrVRqowf6+Ugin0imTfOqY3v5olYmql0Jz0kE2hrrLY0GYN2sVqsFhhaU664E1BsGtWrQkbB1jXD/wouig8rIYEP8iBQl8IfgGu209RYHFXeeRNQcGIjGZiljiybS7M9rRT1E8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352244; c=relaxed/simple;
	bh=dWtzYqZyc2YGF6ZmEfwI1MrtJ1lAypxbLhaRapqcCYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OrxXwe9Uq0ZncoUBNIJK5QoZqtSGldqugxytKjGILjPxLXLIMBKUq9Ne14xZhzWvEHUx2YRb632N+l/HN8qix0pGKyRJzq+jKEi2FKgHm6fBOGtyQxAStzvkDh9i0FquIHE1keWLEjjXsuNm+8y/ZhDO6YKLMtbfdjEmTIyl4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RapZPwUa; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebeca94c87so85415eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731352242; x=1731957042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oVunbPX+hQzjw8N4pwS8cQ26lQYQ2E2JKsydudMgZ0=;
        b=RapZPwUaO9b3CTYUwx+V5ncCxMGmWAScz3iq7aqXK0iO/+wAYh3MieEfoQ8durei0T
         EyFWGgASa+mXvdPHjRvIg71RZGT8ZcWS3k5YnypgCtIoEdWVutXV7bVp5p4TelLMwEs2
         i2d8n8d2hYsjFaRK9IWGapyo7lLQGHxjnv7F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352242; x=1731957042;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oVunbPX+hQzjw8N4pwS8cQ26lQYQ2E2JKsydudMgZ0=;
        b=FlrJ7FBba3xrtkybUXswzjt0vDWL313jc0ZiCbhNYoVwA8OTYjfKlgroRtYJPtkcM+
         TUHv+6NigKe12LBhDVwKqZiCr5iS3k36JH2GA8UaI0gYuDY/eqdfmj5/5Mf/b58UjfOG
         jmZ1CEEyvv7YsUV/NX+XXIrbjl8r5KXCSXi3Yrxkxu81eC9/28egueYs05zjRazuP3zE
         5QsAIYqijmfxoBzdSVX3perGh9f/VcmnSWlCEfbJqZSOTJJ7Z4hQMfDqalsu2EcY2P+z
         r+nbzkF8O+DFKqqYY1AuPb8xPoj3SZhRTYbfytslZFK2OBOGuB8GkOWVjLV7Z/Khol9X
         mGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB7cVQLdFyb3JmhsmUtv2Z4M/2CnMEn3Mkl6HdsMx8AJ4fEeXW03XTCg6SaZLmq5g3SZik2j3PlCwSQvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQ1YmdP1OoNPBOE/RbU3uFTOV1Ln/4eOo2N8Km0qIVB8x4kSg
	9PYY24OJ42JwyhX0WV3bIr2u3RvBGRBJKOD88SLNEBnA6ZlewRpCZN9GxtWYvAduVRFi/h7oSlu
	VDSyLa6M8aG4VZ+kbhkzp0405Q8BHuUiD7e+z
X-Google-Smtp-Source: AGHT+IEpFmf11bck6bv6giVGNlwr01CEOxwij9HmVNKR3ArfGvUXwv1JnxM37AA0Rduivx4vGLTAuA8GztTXRwykqX0=
X-Received: by 2002:a05:6870:fe87:b0:27b:73dd:2a85 with SMTP id
 586e51a60fabf-295600cb480mr2544177fac.1.1731352242328; Mon, 11 Nov 2024
 11:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com> <agkliam473nmhxirk76psryxh5qkrncdhwzyoyf4w4efkxnubw@vkeini5qa6xw>
In-Reply-To: <agkliam473nmhxirk76psryxh5qkrncdhwzyoyf4w4efkxnubw@vkeini5qa6xw>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 11 Nov 2024 11:10:30 -0800
Message-ID: <CABi2SkW-cWJQtT2E_vO40bFi7Qrr+At3Q0jFVVQt+WZP=jaHHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam

On Thu, Oct 17, 2024 at 9:01=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:

> > > Does it make sense for this to live in exec?  Couldn't you put it in =
the
> > > mm/mseal.c file?  It's vma flags for mappings and you've put it in
> > > fs/exec?
> > >
> > If you are referring to utilities related to kernel cmdline, they
> > should be in this file.
>
> You created a wrapper for the command line, but then included the user
> in this file as well.
>
> hugetlbfs reads the command line as well, in cmdline_parse_hugetlb_cma.
> That parser lives with the rest of the hugetlb code in hugetlb.c
>
> I think this has to do with your view as this is an exec thing, where I
> think it's an mm thing.  My arguments are that you are directly adding
> flags to vmas and it's dealing with mseal which has memory in the name
> with the file living in the mm/ directory.  If I wanted to know what's
> using mseal, I'd start there and totally miss what you are adding here.
>
> Besides applying a vma flag to exec mappings, why do you feel like it
> belongs in fs/ ?
>
The vdso/vvar/stack/heap alike are type of mappings belonging to
processes, and are created during execve() syscall which is in
fs/exec.c.

mm/mseal.c provides core memory sealing functionality and exec.c uses
it. IMO, it is better to keep the provider (mm/mseal.c) and consumer
(executable) separate.

To make modulization better, I can do below adjustment:
if (seal_system_mapping_enabled()) <-- implemented by fs/exec.c
   add_vm_sealed() <- keep in include/linux/mm.h

However, if you have a strong opinion on this, I could move the
parsing logic to mm/mseal.

> > > > +void update_seal_exec_system_mappings(unsigned long *
> > > The name is also very long and a bit odd, it could be used for other
> > > reasons, but you have _system_mappings on the end, and you use seal b=
ut
> > > it's mseal (or vm_seal)?  Would mseal_flag() work?
> > >
> > It could be longer :-)
> >  it means update_sealing_flag_for_executable_system_mappings.
> > mseal_flag is too short and not descriptive.
>
> mseal_exec_flags() ?
>
It needs to be more descriptive because there are also stacks and
heaps to be sealed. I suggest to use below name to make it shorter:

if (seal_system_mapping_enabled())
   add_vm_sealed()

> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 57fd5ab2abe7..d4717e34a60d 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_mappi=
ng(
> > > >       unsigned long addr, unsigned long len,
> > > >       unsigned long vm_flags, const struct vm_special_mapping *spec=
)
> > > >  {
> > > > +     update_seal_exec_system_mappings(&vm_flags);
> > > >       return __install_special_mapping(mm, addr, len, vm_flags, (vo=
id *)spec,
> > > >                                       &special_mapping_vmops);
> > >
> > > If you were to return a flag, you could change the vm_flags argument =
to
> > > vm_flags | mseal_flag()
> > >
> > passing pointer seems to be the most efficient way.
>
> I disagree.  Here is the godbolt.org output for gcc x86-64 14.2 of your
> code (with some added #defines to make it compile)
>
> seal_system_mappings:
>         .long   1
> seal_system_mappings_enabled:
>         push    rbp
>         mov     rbp, rsp
>         mov     eax, DWORD PTR seal_system_mappings[rip]
>         cmp     eax, 1
>         jne     .L2
>         mov     eax, 1
>         jmp     .L3
> .L2:
>         mov     eax, 0
> .L3:
>         pop     rbp
>         ret
> update_seal_exec_system_mappings:
>         push    rbp
>         mov     rbp, rsp
>         sub     rsp, 8
>         mov     QWORD PTR [rbp-8], rdi
>         mov     rax, QWORD PTR [rbp-8]
>         mov     rax, QWORD PTR [rax]
>         and     eax, 2
>         test    rax, rax
>         jne     .L6
>         call    seal_system_mappings_enabled
>         test    al, al
>         je      .L6
>         mov     rax, QWORD PTR [rbp-8]
>         mov     rax, QWORD PTR [rax]
>         or      rax, 2
>         mov     rdx, rax
>         mov     rax, QWORD PTR [rbp-8]
>         mov     QWORD PTR [rax], rdx
> .L6:
>         nop
>         leave
>         ret
> main:
>         push    rbp
>         mov     rbp, rsp
>         sub     rsp, 16
>         mov     QWORD PTR [rbp-8], 0
>         lea     rax, [rbp-8]
>         mov     rdi, rax
>         call    update_seal_exec_system_mappings
>         mov     rax, QWORD PTR [rbp-8]
>         leave
>         ret
>
> ----- 48 lines -----
> Here is what I am suggesting to do with replacing the passing of a
> pointer with a concise "vm_flags | mseal_exec_flags()" (with the same
> added #defines to make it compile)
>
> seal_system_mappings:
>         .long   1
> mseal_exec_flags:
>         push    rbp
>         mov     rbp, rsp
>         mov     eax, DWORD PTR seal_system_mappings[rip]
>         cmp     eax, 1
>         jne     .L2
>         mov     eax, 2
>         jmp     .L3
> .L2:
>         mov     eax, 0
> .L3:
>         pop     rbp
>         ret
> main:
>         push    rbp
>         mov     rbp, rsp
>         sub     rsp, 16
>         mov     QWORD PTR [rbp-8], 0
>         call    mseal_exec_flags
>         mov     edx, eax
>         mov     rax, QWORD PTR [rbp-8]
>         or      eax, edx
>         leave
>         ret
>
> ----- 26 lines -----
>
> So as you can see, there are less instructions in my version; there are
> 47.92% less lines of assembly.
>
vm_flags already  run out of space in 32 bit, sooner or later we will
need to change that to *** a struct ***,  passing address will be
becoming necessary with struct.  Since this is not a performance
sensitive code path, 3 or 4 times during execve(), I think it would be
good to start  here.

-Jeff

