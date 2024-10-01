Return-Path: <linux-kernel+bounces-346680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5F98C77C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3141C22BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CDD1CDFCD;
	Tue,  1 Oct 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvE7kiBX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC519C56F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817686; cv=none; b=iFX8Fn6hN5j1aHgrlkHtgEayLOsk/hkVRDhcCrPC6GhFScALk9Ytb2igAGjvGvVeT2C/hKQ0nkXyaNHy89NYAKs/UnpWPH18tUQk0PW0igrCzd6v28G/pqe9Uwu/bt2cy+RCQyed1zY53OxwzyhS12y9htKczj5/tgiU2wKX03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817686; c=relaxed/simple;
	bh=EQjfFUP6V15WHbsMfHvl8IITEfL2R5znZ0//S7cqib4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkznMtE11lye3dGN5fzscv/weYFJg9RavDrZkX/xn31tICyvXJVxiyg+dlEON0twj15RFXHo3wXic+PKaayJYOThGekXHcUrlVWII/gGeQAaR/COh+t4oVAdjuQrx5H9A+lCtv7ZW10eTdpUYUSCDncba8q2+5XRVEuRQKWo4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvE7kiBX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398c2e4118so8163e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727817683; x=1728422483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoWrsU7z+qdIIFDpkMHhN4PhrREusH4jkiAl/mJtNdI=;
        b=FvE7kiBX8ZtLZa9UpwtJfNIQrFOiEzSoWeAXMqTVzC/H2VHvnD/MOVgjvO0BPoNHTZ
         DLgqN3x8qnWckY/gGPNv/Bwd2FK9OnqD3D6YIAbjWpTofZuNBgtspGjf7KejVXlwlYMo
         39cx8VrQsjE7n66dpjeoz+zzskC2COm2H5qxWCBxWj/IJf2S2qOom62uSkEQgh1CmEK4
         ks7Q6jEiCTLjB5NGmyjK5mhTnyS7+epwMCv8pMAbYhqCYY8B0H1yzi/lhA2XG5bP/deA
         i2BIFNwkzAwJO7O4KRmSVFAVvNG+TPQ4k3xCujBD4hFgvH58NuF8NJEQPhSRooSCldoV
         l6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817683; x=1728422483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoWrsU7z+qdIIFDpkMHhN4PhrREusH4jkiAl/mJtNdI=;
        b=YywBEj5+nBrOTR/xfYsESNmpH/YGRzNc2ES6D+8Q0MgBHjK32TY70R5yTttryrhPWu
         IPN1qZy5PRj7aZePUOBz0LPr+/x47Ho+JWx7elL07XDRRb8a9JQDrRblYOZ5ElfS/MjR
         ddiCeTJsyIgVPVlhPpAGIPA3FRnOv/1EVxHQ8kLadC4Y7CAPoeJZCeXmSZsj+N9Fz48a
         9QwaTe5wYZdFN6Utg2MJkI5oIAxRDr6PCVqExaYANKIJB8Rvc4/LyEWsV8G2HJ0gO4QF
         8A4biGBkY82JrELkHthlwO9IYIo8ToKB9mreHTAcaYSD2Isnf6vsjkhav16f6epx0ZBE
         XLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2EdvHR6kICBOa45ClzhloyOlvrxotiHLrlZTTsztXynoXqzeF06NgXT1aEv4HaV+6R/pM3xwizweF8AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwL4PxIeHMFs/k0cSrqBXrmiY5UBBTAd7VbgjbLk+/WsDYDlPL
	JTm0OUCNVAJe/5kaDudvM7zvawNUYKUSn1DCLYJaAlv8/XvhxXoCeJsccGHuOA/+NjZ7CaodbN8
	spNpWZxzdtsRHamPxNi7ZPiQybDI0W/0Pvnmc
X-Google-Smtp-Source: AGHT+IGgP22tnj35LCYM0fX1Dz0p+NCTjOYdsvD+bPVZjH0BMXExjm00WWuhd0WmAK7axQvJ/g54h5N5+4LKt45smrY=
X-Received: by 2002:a05:6512:239c:b0:539:9ff9:5cbe with SMTP id
 2adb3069b0e04-539a0f0695cmr152225e87.4.1727817683249; Tue, 01 Oct 2024
 14:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-32-samitolvanen@google.com> <f0eee8a9-766a-463c-bc36-676e49efe950@suse.com>
In-Reply-To: <f0eee8a9-766a-463c-bc36-676e49efe950@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 21:20:41 +0000
Message-ID: <CABCJKudn0WcOAg89ouTQoEHQC5n90SdetxHYG7GvQWmWo6WQ5A@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] gendwarfksyms: Expand structure types
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:16=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > +static void process_variant_type(struct state *state, struct die *cach=
e,
> > +                              Dwarf_Die *die)
> > +{
> > +     process_list_comma(state, cache);
> > +     process(cache, "variant {");
> > +     process_linebreak(cache, 1);
> > +     check(process_die_container(state, cache, die, process_type,
> > +                                 match_member_type));
> > +     process_linebreak(cache, -1);
> > +     process(cache, "}");
> > +}
> > +
> > +static void process_variant_part_type(struct state *state, struct die =
*cache,
> > +                                   Dwarf_Die *die)
> > +{
> > +     process_list_comma(state, cache);
> > +     process(cache, "variant_part {");
> > +     process_linebreak(cache, 1);
> > +     check(process_die_container(state, cache, die, process_type,
> > +                                 match_variant_type));
> > +     process_linebreak(cache, -1);
> > +     process(cache, "}");
> > +}
>
> For variant types, should the tool worry also about DW_AT_discr and
> DW_AT_discr_value?

Hmm, I initially thought they were not necessary, but looking at the
rustc DWARF output a bit more closely, it might actually be a good
idea to include this information. I'll add these both, although since
DW_AT_discr just points to a member DIE, it's probably enough to just
process all child DIEs for the variant_part instead of limiting
ourselves to variants only.

> > +static void process_unspecified_type(struct state *state, struct die *=
cache,
> > +                                  Dwarf_Die *die)
> > +{
> > +     /*
> > +      * These can be emitted for stand-elone assembly code, which mean=
s we
> > +      * might run into them in vmlinux.o.
> > +      */
>
> Nit: stand-elone -> stand-alone.

Oops, I'll fix this too. Thanks!

Sami

