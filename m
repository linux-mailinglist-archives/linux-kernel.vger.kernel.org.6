Return-Path: <linux-kernel+bounces-316997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375B96D814
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB75288BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50F19AA5D;
	Thu,  5 Sep 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMYPnkjo"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4109199225
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538444; cv=none; b=Yz8UfPHtbOQSu/f4FpuPazOXJ1/B7JjlVk5d0R2D3T66LWZdCW877jdaoyunysxLMCwXTJNU3N9XKOBhwjV4ag4VV8veHBFYwVvkWdFXrvXP9BhqGvmBJcI7BTPiZFxYQU/WwLqiZnixkLSdbqGo/vmN8yJDLukcIdo9wsRaWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538444; c=relaxed/simple;
	bh=jQAbs0qs4lvk5oXafT0yL0fVfAPA3AhakFfXNjUlLgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyTs8P6z5xg8UkRlHhM1cvRo9AhfcdFlncKV8SeBNNza7JD77tyHIgZPfkwwL86hb4Rhuh5oPzbrv3GgzMqNhAi90D+zJ5APo0Ktiarlqi9I8mjPTRpf/YOgQ6Hqtd90MSZ8Lc+G4V5tsGXsr7KXpPC91yri3OeLmR1713Fvkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMYPnkjo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3f163e379so12883111fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538441; x=1726143241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBZ+0s5SNx30e0+OckzgvauEGclFKpW+V28EViaEY0g=;
        b=OMYPnkjoiliqPYZ/nwUW45oHQLrHyH/EkWDNbKEbgAKA+1GB1nTzalgkyf4NQYevYH
         0CoQIQoSxUM2Xfpkaab5gTQ0ALexZREJOqQ5LOfPwjtRVJ5Z9PKDCY8DA5BzsW4PdThx
         07kMbQ9rnznEZ9GRYesHf5C6oE6jMvRsJJvpC84cJA/4cMKoPz959y2dXTQhon6SMwiV
         j7d5YE35q/2/sMlqGII/I+MDjves9kdO5cbELcU1wQvxvlBKSB04oP2kFcuJn74/GESm
         HfIuiz3qN3hALSugKOuVoR0YeE5joRyGeU48A5npafrfvDNLE0xSJITEMzx+qAN6s0OS
         plTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538441; x=1726143241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBZ+0s5SNx30e0+OckzgvauEGclFKpW+V28EViaEY0g=;
        b=iied5jcSPy0DCAEdZFzIlgGG494MJr97061HnZQHdALz4UlRsjR5qD/+Y2cqwK4Dbx
         qgPzK22DRecyz2ucU7NhYcAPthg3ZGl+xBziUmxZS0KxNDlZ7qadIzc9rRHAYRBFOq/D
         +L1yAw0y29c/rlAUeOrOaQLgikorImxDGHVUZBDcNzTzMVeRsxr37orR2qcd+7sR+GEy
         IbXfApdW6wZ6Q84NOymuIKIeplm2CTZM8qjNw6CslvG/7NakFSltXr+dubeUJ2shp3sa
         UxbhlyqF6TspwNQtqxGqeUKWq/e7jrd/4GfBPUhziHVy48TDsx2TlqGhUIg6hPfYUUYr
         y26w==
X-Forwarded-Encrypted: i=1; AJvYcCVob8BXja/x82ZDtVwX0oXKKMfku5nNWLa8fQMMLnCp15JYo+7noC3fLAi3SkdCK4is9MWe2xMIQ5B9+9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwByfmUpIAakywp6L2FA6WGAg0xnEQSq7zlNmIDziFbZg7bWA
	OQYN2w1qlvRPpGT6sD4gEMP/L0zFCBh9nO4nfwDUhG0gx7NUOKGAo0Etn82VWsG5c8bRrNu4K8Z
	TdlWS46rb23iFTBtgkAbZaKGVRFc=
X-Google-Smtp-Source: AGHT+IFOzHv1i7xTEo6MfsfsTeIwg5gh/XJz+7gOOGAMyWDNK9tyr7ejvUFBveKn0pyO3LBUQiv4J1H4Yis5zAL2Ot0=
X-Received: by 2002:a2e:b894:0:b0:2ef:2422:dc21 with SMTP id
 38308e7fff4ca-2f6108adeecmr227701771fa.43.1725538440658; Thu, 05 Sep 2024
 05:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <c6c7ddb2730611e5877240de033f5af3263fae0b.camel@xry111.site>
In-Reply-To: <c6c7ddb2730611e5877240de033f5af3263fae0b.camel@xry111.site>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 14:13:49 +0200
Message-ID: <CAFULd4bKs9SF95vh94+4wXtJV2TXX7qQ8SwC39X7ZL5JAnWQ4A@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:58=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Thu, 2024-09-05 at 19:47 +0800, Huacai Chen wrote:
> > > +#define _percpu_write(size, _pcp, _val)                             =
           \
> > > +do {                                                                =
   \
> > > +       unsigned long __pcp_val =3D __pcpu_cast_##size(_val);        =
     \
> > > +                                                                    =
   \
> > > +       if (0) {                                                     =
   \
> > > +               typeof(_pcp) pto_tmp__;                              =
   \
> > > +               pto_tmp__ =3D (_val);                                =
     \
> > > +               (void)pto_tmp__;                                     =
   \
> > > +       }                                                            =
   \
> > Emmm, in V2 I just confirm that whether it is worth to use macro
> > instead of inline functions, I think we don't really need such a
> > checking here. :)
>
> It's still (slighly) better (just from aesthetics view) to use inline
> function instead of macro.  Is it possible to clear the header
> dependency and break the circle so we can still use __percpu in arch
> percpu.h instead?

Unfortunately, it is not possible. __percpu will use macros, defined
in <include/percpu.h>, and <include/percpu.h> needs
<loongarch/include/asm/percpu.h>. Up to now, it was enough to include
<include/linux/compiler_types.h>, so it was possible to avoid
unresolved include dependency.

> (Simply removing __percpu from the function parameter list causes many
> warnings with make C=3D1.)

This, and if/when loongson will use percpu named address checks, it
will break compilation.

FYI, it is possible to implement the same percpu address space checks
for loongson (as for x86) with clang and its address space attribute.
The compiler has to provide __typeof_unqual__ and the arch has to
define

# define __per_cpu_qual __attribute__((address_space(1)))

in its percpu.h file.

But we are not there yet ;)

Uros.

