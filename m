Return-Path: <linux-kernel+bounces-572160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4868A6C77D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46420175C02
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D713774D;
	Sat, 22 Mar 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="235hmLLf"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD04BA53
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614741; cv=none; b=ASH/f/LcQ0rtOFV5YlLzoekoSzOhs8N8FElXIDSMpecWdXK7aYnqN3qtG5483TvbJFgt8C6DcnCsXulDt/+N5je66d8oqYtmhFsccMfFNPgnl74eF49YjQL7hmyJQlkcOYi16nymU2mR6QIu81shPppPIA99nGb/90PjldK9SvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614741; c=relaxed/simple;
	bh=SeE51VgTK/L7V/oDw7Jc/5s/5O6ZfgrxdBoPtf5gF6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N734l1J4zrvHSm34c2Sgq/SHS+FZu3nfC7MCocI2ricxLImvDyG5Wi14mEoveGFl72sBSGTv8iZZZeG9st6e79y36MKS8dbVinA+1WZo2lX3ze8trAOqE1brfyIoHNLxLt+6Y3ylT02Ql3Sk1iHRYLmNRkJIVxX5ECdNavbAHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=235hmLLf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4294a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742614737; x=1743219537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taeWF4tOpC/dpbZzcrLZz4r9LKpMvXEAscHhqUcCxXg=;
        b=235hmLLfEH7t8Bia2tq9aP6iNpETydu7PuSaAsHW+gVlvdhYNmCvpe45orq+bms6UX
         MveCTCmYfUDi15E+1+iHulBzu2wyGpg637w6Td7Bq+08kNbWECIvgxSVpGXi2TcQgqrs
         Ni1bT/lD0HV/sTDtY2gM6FeQWFdVnN18r/PlzlaVeLZ4qhxu7Ix9T3Txrlp1EW3KOTOt
         nwVkJD/Dg/iRGFP8zKUwhhZLHltPBevO3KqdAuTv8AHOHscW9A4SI2m/OUiWaYqEfMVJ
         V5RRNJM0mz3AmJg4AvqVYF8m9nD11WX8kmmrckLvkNupw2vYsgD71RkG7ZW+H8GPa9Xz
         Otsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742614737; x=1743219537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taeWF4tOpC/dpbZzcrLZz4r9LKpMvXEAscHhqUcCxXg=;
        b=a6zSbcA3bx/DuJHDlK9IpQGH1V8fAI5IUpVgzXxzZvddNzrDG6QTL6y7T3wMQs6aFS
         7GqHKW8NQZdwrYU0op3jwJqyZ97X5n6MPjQhVuOdDZbwCZqkj0IaIwrDIhgaJws1lUWN
         Cr2Av9tabVYdgQrVzhGsbVRfhcPExI5pOGreqPlKR81Pu1xwboPT9dCvNz+IvY6Z0uQe
         FLwPzgHY26udSJQjKbjXLDg5bB00ATsNlmjbcTVA99mxvXD4U8NsV2kBAGpvSVBIvpNu
         KYmsblcVPKIKRRI+np0LxrC+v3mDkpidSQ3/GEkUJrMPCPHeSuNC8f9JytxHEYB5l8RG
         5ENg==
X-Forwarded-Encrypted: i=1; AJvYcCWj720ZQcLbQScUHe0weiuFWGpP0C9keCPH+OkgEZBWbThzC1GHCLn9GJqhcR6s1A5um3d2cSm+A5htcj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTUzjS1WpW7k0igW/FQ2hwfwAIoVCAiz2h9scbQh7ZJd3juim
	Th+x20vtX5pdzDvNGIVdKez7L3XvXZzvUYcxLjjLB/ChkV5HyBQ99Ye2VurZksF7nst9ac/1FHc
	ShGlOqz7ipFsGLBu+48XnHR4cXzYevIxa5uPV
X-Gm-Gg: ASbGnctiIzZfwP6rsZzxR1vQ3LWyBOQHzooY5taTIGHca5yj60ZJK3H7pc/MxFOOk17
	yl3WOKjY2tZ09TEWmGfRFq0z2/ckFKe7WvhoeoFASlJCVWs8R1QappzP+9yeFeoC/L82hQGcAh3
	K/xxfMhGk0JYrUCWsi/wFGlrlsBf7t96QtIcYsihpla91oPaVRxGMZaxy+nGiwJEX8
X-Google-Smtp-Source: AGHT+IFNrGflVA5cVLtkj7CWn/rMxuADVf09QwjGTQAYNADzVFRbZd+RM0Y15L/a3KXLWPWdZKicKZiySK9z7Q+N71o=
X-Received: by 2002:aa7:d806:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5ec1d9c7e3bmr51324a12.2.1742614737221; Fri, 21 Mar 2025
 20:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321202620.work.175-kees@kernel.org> <20250321204105.1898507-3-kees@kernel.org>
In-Reply-To: <20250321204105.1898507-3-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Sat, 22 Mar 2025 04:38:21 +0100
X-Gm-Features: AQ5f1Jpi8VffjP4kVgfgtjD_F_g43Fb3J-5CEl65oTN-4tWjDA9t4jwdPOVGgzw
Message-ID: <CAG48ez17ZtF4YESkGeegJYMTuQMsRcU3njVkNqbSbgv75jpc5g@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_types: Introduce __is_lvalue()
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 9:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> If __builtin_is_lvalue() is available, use it with __is_lvalue(). There
> is patch to Clang to provide this builtin now[1].
>
> Link: https://github.com/kees/llvm-project/commits/builtin_is_lvalue/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Before you land that LLVM patch, it might be a good idea to figure out
how this interacts with the fun C quirk where you can have temporary
rvalues which can contain array members to which you can technically
create lvalues but must not write. As far as I understand, calling
"kfree(getS().ptrs[0])" as in the following example would cause UB
with your patch:

```
$ cat kees-kfree-test.c
#include <stdlib.h>

#define __is_lvalue(expr)      __builtin_is_lvalue(expr)

void __kfree(void *ptr);
void BEFORE_SET_TO_NULL();
void AFTER_SET_TO_NULL();
static inline void kfree_and_null(void **ptr)
{
       __kfree(*ptr);
       BEFORE_SET_TO_NULL();
       *ptr =3D NULL;
       AFTER_SET_TO_NULL();
}
#define __force_lvalue_expr(x) \
       __builtin_choose_expr(__is_lvalue(x), x, (void *){ NULL })
#define __free_and_null(__how, x)      \
({                                     \
       typeof(x) *__ptr =3D &(x);        \
       __how ## _and_null((void **)__ptr);     \
})
#define __free_and_maybe_null(__how, x)        \
       __builtin_choose_expr(__is_lvalue(x), \
               __free_and_null(__how, __force_lvalue_expr(x)), \
               __kfree(x))
#define kfree(x)          __free_and_maybe_null(kfree, x)

struct S {
    void *ptrs[1];
};
struct S getS(void);

int is_lvalue_test(void) {
  return __is_lvalue(getS().ptrs[0]);
}
void testfn2(void) {
  kfree(getS().ptrs[0]);
}
$ [...]/bin/clang-14 -c -o kees-kfree-test.o kees-kfree-test.c -O3 -Wall
$ objdump -d -Mintel -r kees-kfree-test.o

kees-kfree-test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <is_lvalue_test>:
   0:   b8 01 00 00 00          mov    eax,0x1
   5:   c3                      ret
   6:   66 2e 0f 1f 84 00 00    cs nop WORD PTR [rax+rax*1+0x0]
   d:   00 00 00

0000000000000010 <testfn2>:
  10:   50                      push   rax
  11:   e8 00 00 00 00          call   16 <testfn2+0x6>
                        12: R_X86_64_PLT32      getS-0x4
  16:   48 89 c7                mov    rdi,rax
  19:   e8 00 00 00 00          call   1e <testfn2+0xe>
                        1a: R_X86_64_PLT32      __kfree-0x4
  1e:   31 c0                   xor    eax,eax
  20:   e8 00 00 00 00          call   25 <testfn2+0x15>
                        21: R_X86_64_PLT32      BEFORE_SET_TO_NULL-0x4
  25:   31 c0                   xor    eax,eax
  27:   59                      pop    rcx
  28:   e9 00 00 00 00          jmp    2d <testfn2+0x1d>
                        29: R_X86_64_PLT32      AFTER_SET_TO_NULL-0x4
jannh@horn:~/test/kees-kfree$
```

As far as I understand, this causes UB in C99 ("If an attempt is made
to modify the result of a function call or to access it after the next
sequence point, the behavior is undefined.") and in C11 ("A non-lvalue
expression with structure or union type, where the structure or union
contains a member with array type (including, recursively, members of
all contained structures and unions) refers to an object with
automatic storage duration and temporary lifetime. 36) Its lifetime
begins when the expression is evaluated and its initial value is the
value of the expression. Its lifetime ends when the evaluation of the
containing full expression or full declarator ends. Any attempt to
modify an object with temporary lifetime results in undefined
behavior.").

Basically, something like getS().ptrs[0] gives you something that is
technically an lvalue but must not actually be written to, and
->isModifiableLvalue() does not catch that.

