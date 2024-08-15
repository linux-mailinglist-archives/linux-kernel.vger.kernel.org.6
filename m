Return-Path: <linux-kernel+bounces-288547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0764953B85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C7C287513
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF114A617;
	Thu, 15 Aug 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBWTX8bf"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFB1448C3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754036; cv=none; b=p5tsqBn0STDZCwL552+EeE1U4ePPbup+sL+PL6UWW+FNXJz9YWHS9iQ5RwnwLCFAdnmcrnW0gie9KzdvWPY2SGIZ6FAj9Z26KhLMbnirgjQ3GVkSPGE4z5Sx57GlR/t1sbzaQOSe+RYuLlcYL9aTxAs4Y3SdWs8bM10hHu84vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754036; c=relaxed/simple;
	bh=SR+HJls7rN8EZRV4DdYxnxKWzOEinOl5EQrLPe0+yRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxEOWsHkIz+0Kvr5uSVPPlgDXfyIf9Qi8qgXN6NpzLfI1KCP5jIltfR8isuxCtkqgFgqRupapznFOWbn+Koa8m/cUf6YOSqYp/Ev3hKTmVISGKg2CySndJa9YB40NgKG8uPur8I61VyqBJjItutBrdtVajm7Mysdes2VIViUbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBWTX8bf; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-493d7455231so479817137.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723754034; x=1724358834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUB5DtqEXasUqeTn5ggBGYiSPHH9LQLM5I6fa/JbtdA=;
        b=vBWTX8bfVNwCAXzVCaJZ0CtOCATQMCbLjd5BmgDof51ZSLy2q/iJbYwkT0FnoX6a/o
         BtKd3Fxk0OrNAQcNIA7Fna0xUXnsd8Bpsil9+yt3fSi7z31A9tzEBD8XOxWfOVugH3/V
         BYZlZxCP3mAUwZWY2BnXDnsXG1jJ6+KdSiex8yU0yPqs3DQWiQNQbDCwq4NVKBuwj5hR
         bSdPktJ870ns9ss5pDa87z9KSMOLMu7MsUS0JgHu7ahmZ1SxVfqfjbkW3hPihJRYp3Tf
         ZZUJ+iCZkh7EZA+viThthqlHacztHrCPIWVq66w/+56df5/v+Bnlxeqysm1ENDwguY1g
         tN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754034; x=1724358834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUB5DtqEXasUqeTn5ggBGYiSPHH9LQLM5I6fa/JbtdA=;
        b=voKam/h6NDjhHPbvwKVdM8LTBjj2+kRJitLOo3FTguIBju7NEuncDaS5aRoFK9FA2c
         ZP9HVlzkyaPQLAt4slsf7eO2ClULu8kQjaaV3uD1f0rIqAvPopVmeC8fxmX2NYkbkaS3
         g5/LRLWjcftiD/DAXNpClsH+n+P5SYNQH5cGirb6WEmcPUUYkb+3K8FYRcQJQbv9Q9xI
         rdAxv3WAwUUgUf+uBDXGzp2aMzmJ8S4HIgt0yvG5olmMcjDEh56cFNm0GX8SLsvHGb/S
         K+YI17xzbm3/1QdUXi1dWE6kaql+HIXPNED1zALbgq2gpHOuwDA+IvZUIV7ZtDbV1M4I
         spSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh4fR7in16U0FhdSHzGf8I6Hpcb2f+2cuhXparvOgibJBKJxAf7zSsWFW41j6UU10StHwP+2n3d9OtoQT1EHXLi+ssSABjMSgI7zzR
X-Gm-Message-State: AOJu0YzGZ7iyab1hygGKTi6riZ5Lhxu8tLBWzrwhSw1E64Zzl4093cna
	uecNYKXOilA1YxtitzXqXPIgWtzglNArzFj5fhN4wumAKGjnlgcHrVyrBCpEeMb7AtDvVlYzVC2
	bjownJYidS73BWGFVrX5Nf7LlLBKhZ6TLK85i
X-Google-Smtp-Source: AGHT+IGfmuESjcg91WnDqUqkDtn8UIkv+97xiwN4+ScLJKsVEkWIs/4dVOABxE4IIaU7W5co17m4OAQqJ19lGvWOC8s=
X-Received: by 2002:a05:6102:41aa:b0:493:d41a:1185 with SMTP id
 ada2fe7eead31-497798dc938mr1347334137.17.1723754033614; Thu, 15 Aug 2024
 13:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com> <20240806212106.617164-15-mmaurer@google.com>
In-Reply-To: <20240806212106.617164-15-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 15 Aug 2024 20:33:15 +0000
Message-ID: <CABCJKufJK0WO92wnW09VTLqZk0ODxhuKQG=HbKE-va0urJU1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] modules: Support extended MODVERSIONS info
To: Matthew Maurer <mmaurer@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Tue, Aug 6, 2024 at 9:25=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
[...]
> +void modversion_ext_start(const struct load_info *info,
> +                         struct modversion_info_ext *start)
> +{
> +       unsigned int crc_idx =3D info->index.vers_ext_crc;
> +       unsigned int name_idx =3D info->index.vers_ext_name;
> +       Elf_Shdr *sechdrs =3D info->sechdrs;
> +
> +       /*
> +        * Both of these fields are needed for this to be useful
> +        * Any future fields should be initialized to NULL if absent.
> +        */
> +       if ((crc_idx =3D=3D 0) || (name_idx =3D=3D 0))

nit: The extra parentheses are not necessary.

> +               start->remaining =3D 0;
> +
> +       start->crc =3D (const s32 *)sechdrs[crc_idx].sh_addr;
> +       start->name =3D (const char *)sechdrs[name_idx].sh_addr;
> +       start->remaining =3D sechdrs[crc_idx].sh_size / sizeof(*start->cr=
c);
> +}

Is this missing an else condition or a return? Why set
start->remaining to zero and then proceed to assign a possibly invalid
value to it anyway?

Sami

