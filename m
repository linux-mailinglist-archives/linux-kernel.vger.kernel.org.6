Return-Path: <linux-kernel+bounces-343093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D244C9896AF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C33B1F22F87
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106A3BBEB;
	Sun, 29 Sep 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVucsDOA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F817C8B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632400; cv=none; b=btHjVOHRwWvMmWmzWBfxsoDxm13On4SeTBJudSL916I6ni26xp57EW9ow+KDqR7Cij/l3WwfEiBUUZsoE3m7ePQdpwwvb3ZfGkqlxmTxurhBjMsC8AwQaqh59REmOqEH2c/FYQVsg1x65QjcVZh26QNejlpnPzCofJP7HuYc9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632400; c=relaxed/simple;
	bh=mog8BBbqZUUDMNTqo8+tC3/dQa/uqpMzDqpfYS+GKmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiXB15EiaLQioYWtj4ib4/6HfSdDO3DRfVH0z9I29gmDndmPa6NEhWZEGJibzF0jT4YqNcnYWDV5CI2Iu2exevS2MCL9UGno78FRDUTIhp3k+aNtEJItaaBuhL7NSPwb5n1JvF+6s29y0buPNFwmoI3MRDLbomyrOYrmGubA3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVucsDOA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso672384a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727632397; x=1728237197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e3q6pQx8LC8UMQvvho6vpmVFeh1TSmxpF/C2NmQN4k=;
        b=aVucsDOAsMBHFsi7DCAKKQe9qgEZxFowPPjbSJyA10ko26QTc5X6lXK75MrGp2kC/r
         XlqRdbP17zODpNmOingnoT8AePI+jezBEkIdWSZxP4YzFca6ywCLompsFdfhGPZbzPpq
         WikplGceZMS7yigUvYjoSSfqjZOBqC5D9YMj1zmPo04uIt3EjIka7uXKaSN9RUKCqw4z
         YVnYZB5MEH8GtYHROrpS4qaAblbNsh6W/7dvR/v9Vw8iTmCHTypA326DZXZoUfCxrezM
         JsFaB9D4jQp98WxcZlqokuwv+OjWmi9FZJEj5nsjFnKTcNptSvuRDYesVsg64BNDMeqe
         qLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632397; x=1728237197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e3q6pQx8LC8UMQvvho6vpmVFeh1TSmxpF/C2NmQN4k=;
        b=DiWczv9KOGlrQ9Tn/lICO2114aqnNTJkG9tv3p+1+l9g87rrDeCmIUw8S14ptn6tQN
         b+ofRN8IuZt/7lXqb76+oTIhSXdD49VANvzZE4pvt6TpZK/Jk6O+GKBhM9uYC1OYYQvO
         WDtGXvZkURTSlSMKAaDtdOIpXyMQzokvzp4hltkh3oJ7zklSS3N6Zrpzay1Gt3UdinYN
         78DLDYIJJUON2r12QKRFSptASledX11DD1sjcruzRATXa+bk4AuOsM9I1iRnj1mlZWfo
         YTqUZe67eu8cdVmPrYbkvzi3GrplZhOPflBa8mzTRduA5N6OJHBLsJ0Vl0yCTy6X/pfx
         685Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6IF7UC/HeX6BIrz0e5YNszWGdOq/fuh21k5muhaDmFcXX+yzKzmeCsaiXfPzISonDMGYFF7clm74imQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxjlEyECeClpK1N98M5u+xS2RbeCyjJdgi8GOB72cO3cX4YQk
	LXcm7NoEsosLzZOVscyKyqk3MEVvBESPLbO0P8HRQkk+rQJmXxtioYZYaRf2dkn2K/fmHkBFVYp
	LRMHt+vWIm9znqte2EykYbtpEGKo=
X-Google-Smtp-Source: AGHT+IGxm3I0sEJHupmtoU2j4d2FC/PhFCiaqh6X8BgIKn70LuJhT/bjvSh4c9q+F+bB3PDgeDfr4p1iYTGHEe6PGV8=
X-Received: by 2002:a17:907:9344:b0:a8d:55ce:fb7f with SMTP id
 a640c23a62f3a-a93c4c40561mr984544066b.62.1727632396823; Sun, 29 Sep 2024
 10:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.498161564@infradead.org>
In-Reply-To: <20240927194925.498161564@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:53:05 -0700
Message-ID: <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com>
Subject: Re: [PATCH 11/14] llvm: kCFI pointer stuff
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> Quick hack to extend the Clang-kCFI function meta-data (u32 hash) with
> a u8 bitmask of pointer arguments. This should really be under a new
> compiler flag, dependent on both x86_64 and kCFI.
>
> Per the comment, the bitmask represents the register based arguments
> as the first 6 bits and bit 6 is used to cover all stack based
> arguments. The high bit is used for invalid values.
>
> The purpose is to put a store dependency on the set registers, thereby
> blocking speculation paths that would otherwise expoit their value.
>
>
> Note1:
>
> This implementation simply sets the bit for any pointer type. A better
> implementation would only set the bit for any argument that is
> dereferenced in the function body.
>
> This better implementation would also capture things like:
>
>   void foo(unsigned long addr, void *args)
>   {
>     u32 t =3D *(u32 *)addr;
>     bar(t, args);
>   }
>
> Which, in contrast to the implementation below, would set bit0 while
> leaving bit1 unset -- the exact opposite of this implementation.
>
> Notably, addr *is* dereferenced, even though it is not a pointer on
> entry, while args is a pointer, but is not derefereced but passed on
> to bar -- if bar uses it, it gets to deal with it.
>
> Note2:
>
> Do we want to make this a u32 to keep room for all registers? AFAICT
> the current use is only concerned with the argument registers and
> those are limited to 6 for the C ABI, but custom (assembly) functions
> could use things outside of that.
>
> ---
> diff --git a/llvm/lib/Target/X86/X86AsmPrinter.cpp b/llvm/lib/Target/X86/=
X86AsmPrinter.cpp
> index 73c745062096..42dcbc40ab4b 100644
> --- a/llvm/lib/Target/X86/X86AsmPrinter.cpp
> +++ b/llvm/lib/Target/X86/X86AsmPrinter.cpp
> @@ -143,11 +143,28 @@ void X86AsmPrinter::EmitKCFITypePadding(const Machi=
neFunction &MF,
>    // one. Otherwise, just pad with nops. The X86::MOV32ri instruction em=
itted
>    // in X86AsmPrinter::emitKCFITypeId is 5 bytes long.
>    if (HasType)
> -    PrefixBytes +=3D 5;
> +    PrefixBytes +=3D 7;
>
>    emitNops(offsetToAlignment(PrefixBytes, MF.getAlignment()));
>  }
>
> +static uint8_t getKCFIPointerArgs(const Function &F)
> +{
> +  uint8_t val =3D 0;
> +
> +  if (F.isVarArg())
> +    return 0x7f;
> +
> +  for (int i =3D 0; i < F.arg_size() ; i++) {
> +    Argument *A =3D F.getArg(i);
> +    Type *T =3D A->getType();
> +    if (T->getTypeID() =3D=3D Type::PointerTyID)
> +      val |=3D 1 << std::min(i, 6);
> +  }
> +
> +  return val;
> +}
> +
>  /// emitKCFITypeId - Emit the KCFI type information in architecture spec=
ific
>  /// format.
>  void X86AsmPrinter::emitKCFITypeId(const MachineFunction &MF) {
> @@ -183,6 +200,26 @@ void X86AsmPrinter::emitKCFITypeId(const MachineFunc=
tion &MF) {
>                                .addReg(X86::EAX)
>                                .addImm(MaskKCFIType(Type->getZExtValue())=
));
>
> +  // Extend the kCFI meta-data with a byte that has a bit set for each a=
rgument
> +  // register that contains a pointer. Specifically for x86_64, which ha=
s 6
> +  // argument registers:
> +  //
> +  //   bit0 - rdi
> +  //   bit1 - rsi
> +  //   bit2 - rdx
> +  //   bit3 - rcx
> +  //   bit4 - r8
> +  //   bit5 - r9
> +  //
> +  // bit6 will denote any pointer on stack (%rsp), and all 7 bits set wi=
ll
> +  // indicate vararg or any other 'unknown' configuration. Leaving bit7 =
for
> +  // error states.
> +  //
> +  // XXX: should be conditional on some new x86_64 specific 'bhi' argume=
nt.
> +  EmitAndCountInstruction(MCInstBuilder(X86::MOV8ri)
> +                 .addReg(X86::AL)
> +                 .addImm(getKCFIPointerArgs(F)));

If I'm reading this correctly it will be an 8-bit move which
doesn't clear upper bits.
If consumer is in assembly it's ok-ish,
but it's an argument to __bhi_args_foo functions,
so should be properly zero extended per call convention.

