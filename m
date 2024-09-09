Return-Path: <linux-kernel+bounces-321716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E412971E73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5160C1C22575
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D4763F8;
	Mon,  9 Sep 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahdkASbm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618C3B791
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896986; cv=none; b=paka2V9UfbYOG62nd8VhG1SG2obXcEADlxmxNjKqNfYfrcrEw9LjPB7RL6X8++CWP18FnC3SpWki7UnuvynCxS3IpXBRi2MqbtBe8eyUdgZ54HP8bSx4lMevX3hd7EfdgCS2ltXkXzKsmTKWwkBibTjnVBTvK5kVPzItgRPqGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896986; c=relaxed/simple;
	bh=sLE8/LlAfbnGrOzaBSQACzUkdA3fCwIsnzI32ChO6mQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJbhvkYjnAS0hdsRseAQEtshlfSEsNRCjR/IBuQh91ACmNAgl6U6VGKNqnRlxbE7jurd9TrZemms1klBTt9VR3xfY+t7X6b+UJcQfRTep/Ov0pmF3VjAnOumpje207/oTwMzGBJ6lXGtV2im5Ag467jVP/JZyn6anAozoVG82Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahdkASbm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8de19f5fso9342681276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725896983; x=1726501783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNwoFKLm/N/Hcz6rIQxwMOO5QV8YU6AFj1EsPbHngTk=;
        b=ahdkASbmjT4LU8S23rQQ9bMqK6j1/yhDSgk10A7s3kFFuNdmSqgMDfhVNnx2JuZgPK
         B+0Ao95dbqV0W3HyJWSsEM9ppfTyrpwSOcG/MPa3ksvXqgwyTLbiP9WVwtWmjIyq+l5N
         Mty3dxUnQcNDMri4DHM5er1pMj9kjPsWpnq7xoReYUdryrTYpr5xXVVDCi0bfwS7WsxB
         /1gZbmc06CDY3Fn1iXsuJroYRRgLm6E16pZXzAMopLJ1w3NLk92Wz9bBniD43is1y2jJ
         xAUQe064B/hWNUua7ZnWRIAiWOSCBonYh/NLFTVeIImdMp01I4hTLbGswBchX8EstY0m
         WoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725896983; x=1726501783;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LNwoFKLm/N/Hcz6rIQxwMOO5QV8YU6AFj1EsPbHngTk=;
        b=HFJgBOgcsXN7a5JMiDTkAodufVyyXedsi8RRmqNWeOYRfK5iljjEx+i8IsB276YahZ
         Yh4z28nDbtZtOMC9paq3BOHlHD8je57eEprJYpL5M9AJrncwz1IoGHqz0FW6mv1NbdKw
         c5SUsNOcYozQc1E2xe7SbJHCzHjb/9mVfzKNwTDgA8bq3/+cR+8kpavPtEUZIxpdvIBb
         GXHrQlR/mxPt8RLU/Zmy4y0m6UgDcBt2x6UG44bNGNpnQt5uEpZTIbPJr8d/T3zHTy/K
         JFknIuJGqO5ELPPfi2Q40ChYQPVGIk47DCR/dSSt3KU/B+JZleESGxFWWfvL+JICwurp
         XnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXatG3QijoxJ4inq/zowRXSv8JCtbZyARP7xkfpgU/fi9j4ZUjL1RmqpOMF5TZQthp9X+sRAnuAw12JwwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwguabIUSEj0hrYVKR/AxjCKaznCMIMDT57GjbOkVbw4XQH5Cn
	9oRmhvn8sIcUIiLF8bt1E1HScbFr9LgZORJypjymbWRI6Mn0HDYjN0HshWkyRMSrM3QoIBkg4BS
	YWg==
X-Google-Smtp-Source: AGHT+IEYtk8RynB49lyU1BQzsbnYAWn1zVMeMkLeBfvik8eAFfX7nhTd9PF8qmZ+/sTYwdMzlVfyVDhf8dw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aa2e:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e1d34863413mr145259276.2.1725896983267; Mon, 09 Sep 2024
 08:49:43 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:49:41 -0700
In-Reply-To: <CADrL8HVaZk7m73FftxXYEXvAqjKa8vc4QG_1FAMXTYSfOE7jhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-10-seanjc@google.com>
 <CADrL8HXcD--jn1iLeCJycCd3Btv4_rBPxz6NMnTREXfeh0vRZA@mail.gmail.com>
 <Ztuj7KapTJyBVCVR@google.com> <CADrL8HVaZk7m73FftxXYEXvAqjKa8vc4QG_1FAMXTYSfOE7jhQ@mail.gmail.com>
Message-ID: <Zt8ZFYL1l8ni4wgQ@google.com>
Subject: Re: [PATCH 09/22] KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024, James Houghton wrote:
> On Fri, Sep 6, 2024 at 5:53=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >  #ifdef __x86_64__
> > -                       asm volatile(".byte 0xc6,0x40,0x0,0x0" :: "a" (=
gpa) : "memory"); /* MOV RAX, [RAX] */
> > +                       asm volatile(".byte 0x48,0x89,0x00" :: "a"(gpa)=
 : "memory"); /* mov %rax, (%rax) */
>=20
> FWIW I much prefer the trailing comment you have ended up with vs. the
> one you had before. (To me, the older one _seems_ like it's Intel
> syntax, in which case the comment says it's a load..? The comment you
> have now is, to me, obviously indicating a store. Though... perhaps
> "movq"?)

TL;DR: "movq" is arguably a worse mnemonic than simply "mov" because MOV *a=
nd*
        MOVQ are absurdly overloaded mnemonics, and because x86-64 is wonky=
.

Heh, "movq" is technically a different instruction (MMX/SSE instruction).  =
For
ambiguous mnemonics, the assembler infers the exact instructions from the o=
perands.
When a register is the source or destination, appending the size to a vanil=
la MOV
is 100% optional, as the width of the register communicates the desired siz=
e
without any ambiguity.

When there is no register operand, e.g. storing an immediate to memory, the=
 size
becomes necessary, sort of.  The assembler will still happily accept an inf=
erred
size, but the size is simply the default operand size for the current mode.

E.g.

  mov $0xffff, (%0)

will generate a 4-byte MOV

  c7 00 ff ff 00 00

so if you actually wanted a 2-byte MOV, the mnemonic needs to be:

  movw $0xffff, (%0)

There is still value in specifying an explicit operand size in assembly, as=
 it
disambiguates the size of human readers, and also generates an error if the
operands mismatch.

E.g.

  movw $0xffff, %%eax

will fail with

  incorrect register `%eax' used with `w' suffix

The really fun one is if ou want to load a 64-bit gpr with an immediate.  A=
ll
else being equal, the assembler will generally optimize for code size, and =
so
if the desired value can be generated by sign-extension, the compiler will =
opt
for opcode 0xc7 or 0xb8

E.g.

  mov $0xffffffffffffffff, %%rax

generates

  48 c7 c0 ff ff ff ff

whereas, somewhat counter-intuitively, this

  mov $0xffffffff, %%rax

generates the more gnarly

  48 b8 ff ff ff ff 00 00 00 00


But wait, there's more!  If the developer were a wee bit smarter, they coul=
d/should
actually write

  mov $0xffffffff, %%eax

to generate

  b8 ff ff ff ff

because in x86-64, writing the lower 32 bits of a 64-bit register architect=
urally
clears the upper 32 bits.  I mention this because you'll actually see the c=
ompiler
take advantage of this behavior.

E.g. if you were to load RAX through an inline asm constraint

  asm volatile(".byte 0xcc" :: "a"(0xffffffff) : "memory");

the generated code will indeed be:

  b8 ff ff ff ff          mov    $0xffffffff,%eax

or if you explicitly load a register with '0'

  31 c0                   xor    %eax,%eax

Lastly, because "%0" in 64-bit mode refers to RAX, not EAX, this:

  asm volatile("mov $0xffffffff, %0" :: "a"(gpa) : "memory");

generates

  48 b8 ff ff ff ff 00 00 00 00

i.e. is equivalent to "mov .., %%rax".

Jumping back to "movq", it's perfectly fine in this case, but also fully
redundant.  And so I would prefer to document it simply as "mov", because "=
movq"
would be more appropriate to document something like this:

  asm volatile("movq %0, %%xmm0" :: "a"(gpa) : "memory");

  66 48 0f 6e c0          movq   %rax,%xmm0

LOL, which brings up more quirks/warts with x86-64.  Many instructions in x=
86,
especially SIMD instructions, have mandatory "prefixes" in order to squeeze=
 more
instructions out of the available opcodes.  E.g. the operand size prefix, 0=
x66,
is reserved for MMX instructions, which allows the architecture to usurp th=
e
reserved combination for XMM instructions.   Table 9-3. Effect of Prefixes =
on MMX
Instructions says this

  Operand Size (66H)Reserved and may result in unpredictable behavior.

and specifically says "unpredictable behavior" instead of #UD, because pref=
ixing
most MMX instructions with 0x66 "promotes" the instruction to operate on XM=
M
registers.

And then there's the REX prefix, which is actually four prefixes built into=
 one.
The "base" prefix ix 0x40, with the lower 4 bits encoding the four "real" p=
refixes.
From Table 2-4. REX Prefix Fields [BITS: 0100WRXB]

  Field Name      Bit Position    Definition
  -               7:4             0100
  W               3               0 =3D Operand size determined by CS.D, 1 =
=3D 64 Bit Operand Size
  R               2               Extension of the ModR/M reg field
  X               1               Extension of the SIB index field
  B               0               Extension of the ModR/M r/m field, SIB ba=
se field, or Opcode reg field

e.g. 0x48 is REX.W, 0x49 is REX.W+REX.B, etc.

The first quirky thing with REX, and REX.W (0x48) + the legacy operand size
prefix (0x66) in particular, is that the legacy prefix is ignored in most c=
ases
if REX.W=3D1.

  For non-byte operations: if a 66H prefix is used with prefix (REX.W =3D 1=
), 66H is ignored.

But because 0x66 is a mandatory prefix for MOVQ, it's not ignored (at least=
, I
don't _think_ it's ignored; objdump and gdb both seem to happy decoding MOV=
Q
without the prefix).

Anyways, the second quirky thing with REX is that, because REX usurps singl=
e-byte
opcodes for DEC and INC

  In 64-bit mode, DEC r16 and DEC r32 are not encodable (because opcodes 48=
H through
  4FH are REX prefixes).
=20
  In 64-bit mode, INC r16 and INC r32 are not encodable (because opcodes 40=
H through
  47H are REX prefixes).

i.e. uses opcodes that are actual instructions outside of 64-bit mode, the =
REX
prefix _must_ be the last byte before the non-prefix opcode, otherwise it's
ignored (presumably this avoids extra complexity in the instruction decoder=
).

  Only one REX prefix is allowed per instruction. If used, the REX prefix b=
yte
  must immediately precede the opcode byte or the escape opcode byte (0FH).=
 When
  a REX prefix is used in conjunction with an instruction containing a mand=
atory
  prefix, the mandatory prefix must come before the REX so the REX prefix c=
an be
  immediately preceding the opcode or the escape byte. For example, CVTDQ2P=
D with
  a REX prefix should have REX placed between F3 and 0F E6. Other placement=
s are
  ignored. The instruction-size limit of 15 bytes still applies to instruct=
ions
  with a REX prefix.

So even though the "opcode" for MOVQ is "66 0F 6E" , when encoding with REX=
.W to
address RAX instead of EAX, the full encoding needs to be "66 48 0F DE", ot=
herwise
REX.W will be ignored, e.g. objdump will interpret it as this, even though =
the
CPU will decode REX.W as part of the MOVD.

  4024d1:       48                      rex.W
  4024d2:       66 0f 6e c0             movd   %eax,%xmm0

And because _that's_ just not confusing enough, there are actually _six_ di=
stinct
opcodes for MOVQ (I think; might be more): two which are REX.W promotions o=
f MOVD
(6E and 7E, ignoring mandatory prefixes and the escape opcode 0F), and four=
 that
are straight quadword moves that can't target registers, i.e. can be encode=
d even
in 32-bit mode (6F, 7E, 7F, and D6).

So yeah, MOVQ in particular is a disaster, especially in 64-bit mode, so I'=
d much
prefer to just say "mov %rax, (%rax)" and leave it to the reader to underst=
and
that it's a 64-bit store.

