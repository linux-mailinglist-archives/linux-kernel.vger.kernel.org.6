Return-Path: <linux-kernel+bounces-562000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70836A61A23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE16B884EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82ED204C39;
	Fri, 14 Mar 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VP/Rzydu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588D2046BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979197; cv=none; b=Ks301c6wn96+ptWrjz6YoFniZ4Qu9CFftUQ6TnNQn2yZx5w/aDgam986NDoVbf7/SXIN7Mol4LfQIvNJnu8widj5pBaNZiXOlRIEgYX4WCcHdAZ7BBfhFU7ms8zANCtRYUPniii7XY4w1yh2z0EFHRdzsv2a0P1nDNxHLpHbXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979197; c=relaxed/simple;
	bh=Rpi+VmmfdYNCwEyPaoJFJdoos1/f8TlyaHa5MS+GajU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlLfYAYwj2IONEcsRrQcU9jRMFLWKxoMevv3Owr49XKGesN76FJMp1DQsPJeYj0H7B4PRGQdPavJRayUcvRV5D7xo258qjQeu4pJPCpnVuu4nNAHyC0T3RWwqv/o/H2QFacJN2zNkumx+eYcl971ElvpB7wpXsRUK3LyYxC5bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VP/Rzydu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso506245266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741979193; x=1742583993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BE61at43f22mEXQVSTJ9JgGSrhqSvuaDOlaLhUV1jzk=;
        b=VP/RzydulaV6wb+L2elp6NpsHg2eBIIKumhuydpSPSKAhfrpHg7BhYsoaNOYZHKpTo
         TO8JduQFfLUyU9/2lSVxLWCWeuVNG/6NQbZRfc1JWEcY7s4ZKZH83ojLhR+1oHAm1fID
         o9w9Mil5tKHvP2fqiYzVJqKybHrF1LDjh+5/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741979193; x=1742583993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE61at43f22mEXQVSTJ9JgGSrhqSvuaDOlaLhUV1jzk=;
        b=aj0NsKZl6YDOz0GzSOd6beraFY2D3mEznmfjv9xDT5RiLeSAtmfrLzi+WNI4mErKaX
         dnevhcWHEzBeEvaMhwd+//C1hOyP/zQKKZ7sjOxkDjafyBxOC130MLlp0WY8flf0biPK
         X3hCSrOUb9WvQQc9tu5iDrguZflfL8pgexl0baazVe/QPc19Y7wJwi+sfjWnbOA+jMOR
         97smz6RwaCYIZNlzwIPvoJBlqPgJMI7Kvwc9WlGJwXcagvKPqT1YEmflq5icEDJnJ+zh
         TsbZCAaB+gij1LgXQcF7FAc5iVrk38B32Io0hmNT0SXhfKVj3flwQcipKLsmTMquyJuT
         07Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXkEYHYiev3XqOWcnOtf9hbM2uJZfTp6/qo0FL9BpAPBVNB1h7oRbNANfLIXeocMQ1HvUWtYWGUkohTolk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHq85J/7PMi1ZEsj9xob7VDuXlhHB7ov1OIMDupphsmm9Pp4F
	Ps3Tj1KAUknT1X6RehMoWWzquvaNqjW4F8gw+0q8pob+vuGPP1RMp0a23R+ozDZfuXjpYkDLiVE
	2Aa4=
X-Gm-Gg: ASbGncuVRtR0h4CDIrimGiDakJ64mjKUwRgMkGvTf8ZuRY1vCO6K7fGBpLR6t2XBiMd
	Q+Q0ipWdHOYxKb/Qmyy4ijC0QZM6539o/YA3RlCAGZ2wMa6g1mj1Eq6EqzqfZu1iMlawgZiZsll
	i/bhRFUKxEy/Ihkh0ERfUysHgDNjuLQncjySpV3JMISDC6Ivs8DTJlXigObmnlCURqSexekKQ1/
	SUwYe37g5DpAaiIX1Nhs1mUsW9TFEFsuFRQDj7UiM+HK6RXnYCw74mjgPFjQ/SwhjXo+dBkLw9w
	APXN/Eq7rMBs0mD0UNdV4lYYNvyMHc6ZFoQklQJhGekGnn+2dcVl3b1WVYL0BSx0ZhVVengKIXo
	iuWqE/0EJifYD0ZEYO8E=
X-Google-Smtp-Source: AGHT+IFmBe3IQXjEX11ocYIFqFg1sexVuu/0XrK0qnukn1Sw+FOiLjadL92LRZrs65i361V7OHFqlQ==
X-Received: by 2002:a17:907:9725:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3302f36dfmr361295566b.25.1741979192683;
        Fri, 14 Mar 2025 12:06:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a4856csm258319766b.156.2025.03.14.12.06.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 12:06:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so437513866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHEG1DitBkSfbj7scsn1AHnXshxoUOPTWcTM55krZJtXbIrR4VQ5vrmENNlqmngQlluYGt1PTx1k4cM4g=@vger.kernel.org
X-Received: by 2002:a17:906:6a0a:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-ac330441f51mr440110666b.40.1741979191319; Fri, 14 Mar 2025
 12:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314175309.2263997-1-herton@redhat.com> <20250314175309.2263997-2-herton@redhat.com>
In-Reply-To: <20250314175309.2263997-2-herton@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 09:06:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
X-Gm-Features: AQ5f1JrnIw3DYwt_tRqYgbKHYk5Q4wAthVqMQSlrggYtOWKCfDmh5ydW22WIL9c
Message-ID: <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8 bytes
 in copy_user_generic()
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	olichtne@redhat.com, atomasov@redhat.com, aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 07:53, Herton R. Krzesinski <herton@redhat.com> wrote:
>
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -130,7 +130,7 @@ copy_user_generic(void *to, const void *from, unsigned long len)
>                 "2:\n"
>                 _ASM_EXTABLE_UA(1b, 2b)
>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> -               : : "memory", "rax");
> +               : : "memory", "rax", "rdx", "r8");

Please don't penalize the caller with the extra clobbers.

Maybe it doesn't matter - these functions are marked always_inline,
but they aren't inlined in very many places and maybe those places
have registers to spare - but let's not penalize the FSRM case anyway.

And we do call it "rep_movs_alternative", so let's keep it close to
"rep movs" semantics (yes, we already clobber %rax, but let's not make
it worse).

As to the actual change to rep_movs - that should be done differently
too. In particular, I doubt it makes any sense to try to align the
destination for small writes or for the ERMS case when we use 'rep
movsb', so I think this should all go into just the ".Llarge_movsq"
case.

.. and then the patch can be further optimized to just do the first -
possibly unaligned - destination word unconditionally, and then
updating the addresses and counts to make the rest be aligned.

Something ENTIRELY UNTESTED like this, in other words. And I wrote it
so that it doesn't need any new temporary registers, so no need for
clobbers or for some save/restore code.

NOTE! The patch below is very intentionally whitespace-damaged.
Anybody who applies this needs to look at it very carefully, because I
just threw this together with zero testing and only very limited
thought.

But if it works, and if it actually improves performance, I think it
might be a fairly minimal approach to "align destination".

            Linus

----

   arch/x86/lib/copy_user_64.S | 17 +++++++++++++++++
   1 file changed, 17 insertions(+)

  diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
  index fc9fb5d06174..1c3090af3807 100644
  --- a/arch/x86/lib/copy_user_64.S
  +++ b/arch/x86/lib/copy_user_64.S
  @@ -74,6 +74,23 @@ SYM_FUNC_START(rep_movs_alternative)
        _ASM_EXTABLE_UA( 0b, 1b)

   .Llarge_movsq:
  +     /* Do the first possibly unaligned word */
  +0:   movq (%rsi),%rax
  +1:   movq %rax,(%rdi)
  +        _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
  +        _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
  +
  +     /* What would be the offset to the aligned destination? */
  +     leaq 8(%rdi),%rax
  +     andq $-8,%rax
  +     subq %rdi,%rax
  +
  +     /* .. and update pointers and count to match */
  +     addq %rax,%rdi
  +     addq %rax,%rsi
  +     subq %rax,%rcx
  +
  +     /* make %rcx contain the number of words, %rax the remainder */
        movq %rcx,%rax
        shrq $3,%rcx
        andl $7,%eax

