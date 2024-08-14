Return-Path: <linux-kernel+bounces-286830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0991951F87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06301F24040
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D31B8EA4;
	Wed, 14 Aug 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5z/Mbrw"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B451B86D2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651872; cv=none; b=t64Td11+W73cz6gm509THWM1L7l/aw6Qkca+IEl4n1dFGBunPx6TXiD88uow4vi6dhYcfG0vY6S5LJkk6VQmAv0s8Qee12sGKdadZuERDHT7L9KEY/9QF8FPxLgNfzKaJgsOEbh8/EG2Fn+XIhSqDLLja7k4yHJJhrDPA4dudG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651872; c=relaxed/simple;
	bh=YojC52uHbpPliLtyLOZFETHeNy9jnfDl4e/WZwHCFg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIEmMXvQYcKy6B8GLsLjE9u5xMurjnzRS1vfmiBCs9/NhvZdTojX4OStFHWuh2qN8rlmWRy1k3ZSWPZGCYcCjPr4Dqrd0Euh9o3JB4VcnnMk3YY1oDtiAX58P07Ot7jFHFNyyj+RgU9WinJa83TDE4YXZrz3kIguj0433isfuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5z/Mbrw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093ba310b0so2985784a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651869; x=1724256669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YojC52uHbpPliLtyLOZFETHeNy9jnfDl4e/WZwHCFg8=;
        b=E5z/Mbrwbh8tINNJI99hxBC6NSbX3gscp9qDkMMOT4bD9Il3+Yzq8NZe1WjTKAUI2h
         jpKf/Gp9Fwghzpa00ibaSjyabZNXZDZjRv5pjNdSue0SSMlIxXCLoXWInHHE7T05RLdN
         076sUEvwqUPy4AbUmhXz+cAUd+1f3J2KA2Ta8H8V1nyykaQBmtS2rIClWPMDOwsHzKPr
         aVED5DXASOOZOkkSLI+SFu9DVFDjLi+uRD4NNyC2j+9Nlc2XzjgNxiX1SnvjjD/3lxvJ
         Cf+1gYWbVxqOdmftk26rJGh/+UBQ4yhFbdqi9bL8rWdDzT/eI+RvMtsuxyoMJ17odflD
         LgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651869; x=1724256669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YojC52uHbpPliLtyLOZFETHeNy9jnfDl4e/WZwHCFg8=;
        b=jHgcZaIr+O4DNZtKZzvDBvgHgODqJGT9igLzqop3Wdn6/zJkM/BLI2lX2+sZ/nIgGS
         5q8k6dhUq1McCowfhWpSG+XpUsk6n3blvRA+J1LgH5llc3H52X8lO69bzHR2VC1JeIn5
         9dwyEB0vsvbTiSm+HCQnwvg+3fPIhi5VL6Nw/sNx9ZCFbLC2ZJZQH6EE8x/AV0FR0PFF
         BNxFIk3YFoLKYWzWKC5XzQube2Q0jd4qASvM6GLDuCy4kyRO6aMmMdX8WyYwuJTk7vLO
         A7NYkIvR2F9jfenii5RJRLQbL2ecHRT4vw305oZIZ/TpDm3Djs6bucHPB7002U0Y47i7
         sZkg==
X-Forwarded-Encrypted: i=1; AJvYcCU2amtwuuiaX43r7k5/HxvIaufZ3GI1C/Y2+Ry1CH+p0PA7HamNFvdjdqaqOwsd9Yjk6rnmuwGau1ha/H6UU34aKUkWhK8c1REaJilE
X-Gm-Message-State: AOJu0YyFRYV35p2MyyAcmjPKwKvgqNseX8w8F665rLG56oWjlbUrEANk
	cLlQhPWvm48Kh+AD1J1oSNoSqZ09SnwbJAqdH2P5NKHHJnuB3HuZHRvrruwAhsNTTVxEnZSBOHi
	yNGc3jI/S7z3paNpyJIVwI4rbz+g=
X-Google-Smtp-Source: AGHT+IEOu0Zcu88kcsI8Ws76Ej67Sjrk+T87Q9CnQkmM3dkYYSvAW3tzOsVVaTPgvwdLIDUc0jgHqvGUeg8M4MIr4Dw=
X-Received: by 2002:a05:6358:7244:b0:1a4:ea23:b5f3 with SMTP id
 e5c5f4694b2df-1b1aa9aacd8mr407202755d.0.1723651869531; Wed, 14 Aug 2024
 09:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813224027.84503-1-andrey.konovalov@linux.dev> <CANiq72mCscukQTu7tnK0kXHg05AiMtB8sHRDTvgjWgcMySbhvQ@mail.gmail.com>
In-Reply-To: <CANiq72mCscukQTu7tnK0kXHg05AiMtB8sHRDTvgjWgcMySbhvQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:10:57 +0200
Message-ID: <CA+fCnZeD4CJheGP6D+x5dzUc4ABRZz1Db0h7hNVmwH3gUC2zyg@mail.gmail.com>
Subject: Re: [PATCH] kasan: simplify and clarify Makefile
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: andrey.konovalov@linux.dev, Marco Elver <elver@google.com>, 
	Matthew Maurer <mmaurer@google.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:37=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Aug 14, 2024 at 12:40=E2=80=AFAM <andrey.konovalov@linux.dev> wro=
te:
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> It is easier to read now, and indeed GCC 5.1+ and LLVM 13+ both
> support the flags, so `CFLAGS_KASAN_SHADOW` can't be empty.
>
> > +# First, enable -fsanitize=3Dkernel-address together with providing th=
e shadow
> > +# mapping offset, as for GCC, -fasan-shadow-offset fails without -fsan=
itize
> > +# (GCC accepts the shadow mapping offset via -fasan-shadow-offset inst=
ead of
> > +# a normal --param). Instead of ifdef-checking the compiler, rely on c=
c-option.
>
> I guess "a normal --param" means here that it is the usual way to
> tweak the rest of the KASAN parameters, right?

Yes, clarified in v2.

> > +# Now, add other parameters enabled in a similar way with GCC and Clan=
g.
>
> I think the "with" sounds strange, but I am not a native speaker.
> Perhaps "in a similar way with" -> "similarly in both"?

Sure, done in v2.

Thank you!

