Return-Path: <linux-kernel+bounces-225181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C4912D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2511F25634
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3917A934;
	Fri, 21 Jun 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EmLLbzhg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50898548F7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994655; cv=none; b=LAJIL8rH/Wp2I3IaCpduOju1aRSS81KyzzW58XZ1nE2Ujt+5Rxd/nwv7OvNoee/6mAS5OdLpbCa6C/H/moF7NcZSq6lMORlZxEzCYLk24+2dKiaqcI6Oin4lK5IgWLLBKR9zOX93GFbQUbpsQO3UvTmjEcueHt6MRIJ1xy16mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994655; c=relaxed/simple;
	bh=oqjIz3PeQBH2hn2o/YZ1k+AKyjnZX4YosabOZqJGSF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEf62YXHDtlsGpZ0cS6/ZRs6FWhNqk7B0RQMy5qAbocTXdaWhJ+SZ3FtP9xQPTB/fHo24/IOLKn5LdokCD6tIKyt3Tb3gy8MfzCpFrM1a3Nswr6/NOC5UEtLiM2C2L6KvTyiCq5bk0+WTPsCHQMW9yW5aeGk2ZGk7MpL9hJsPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EmLLbzhg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so21214485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718994651; x=1719599451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDBJP06DmRWkDW63XRl13F0vqR5/B3xF+ky6e3VTjKM=;
        b=EmLLbzhg4phvj9S9l3ZM+y0HoffEOi9d2CrQxdAJFwlS0GEPE3ngDnKt+AmFQ1NM1w
         ETomRgCdUbhxY/10xLVYstOjQSOW1wdG+M1xeLaMx1JSQ54CI08EPqOYVVClxGwqeFMl
         HpkLC8A2BfWryD+VWc335YXs6sqSlyVICDFj19OeF+Bs4LormM7/jahXHjOp7iuHxgCc
         3PgeWcSvW3O8OK0x6fpH8UXSvCnWU1fTF3u3JqkoI/GWNqd2aOKoU9gQU2B94Y1+qC2o
         vPu/Gs4fkJgkgCtMOvSjkoAyNpjKdlllWi9RM3WfMmDHCFtNqkPJqsao9Ec32/KaIFH5
         kVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718994651; x=1719599451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDBJP06DmRWkDW63XRl13F0vqR5/B3xF+ky6e3VTjKM=;
        b=qausbRroELclpjsYnyvNnHmUWY8F+XSamnT+lUvCBWEzorv9XSP81xoWqwl2nD8PLC
         94KgHXQMmQit0+a+Y1MbnclWJ+/JLWpBwoNxX/1OD4102sFiDEPNrPBYQ3LWXTjcyAdw
         s2Fd0Q8lKNRBltEA77szwGgoXLij6OWFynNENF1/BJWFaqguo1jiU6idxNq5F1k0HPaK
         OsGCZPHDPEef9tfSSIjLP2+5xjTLNZFrDFiE9BY6s+2hs5De8tQYa+yUqAroWLCtgbHh
         RrkPhUGrdj4BofehHSAH5IryQ8K2qesMxaZmiqTp3AEVEAzkJw87oEr5yvacFjMSYutM
         Ychg==
X-Forwarded-Encrypted: i=1; AJvYcCUVwqJSPK+oi5d4gs5MneYdf8wg6IWWYZLiZJeUvb+kGz40Rbw7/L5LJ7BvPKdHKSTwmifhtcEjDqPMBmwZUBRFeLsPfAOAlMxsrEbT
X-Gm-Message-State: AOJu0YzyNvAczAw+72SlYmP0v/dxOpK2Ihr7FZvVp9co+4q6vvASOJ9D
	QvJn8e6FcdlrOkFgaco69XgAu36So1Isnuv0a66O2jmd2ydqrRO+6aKS2B75QBy/zMP9fjgC7IW
	brsxxUnWC8EZ2N5awLrDQufmuP1iZJDm56rd76g==
X-Google-Smtp-Source: AGHT+IHeBc37pbRnvfEykUpBvFqq4/wFdfQ/OI9yo+wiCiO9O7Ii/6NMT9RkrVuB3eccZMg8VBewVzuX8+kx9wTxJnk=
X-Received: by 2002:a05:6000:1107:b0:364:e290:c60b with SMTP id
 ffacd0b85a97d-364e290cbf5mr4499397f8f.38.1718994651598; Fri, 21 Jun 2024
 11:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-7-jesse@rivosinc.com>
 <CALs-HssqVkEX0=x+jhQDjwjRQb9TjbskLvrpvzFG_g-2iDXy3w@mail.gmail.com>
In-Reply-To: <CALs-HssqVkEX0=x+jhQDjwjRQb9TjbskLvrpvzFG_g-2iDXy3w@mail.gmail.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 21 Jun 2024 14:30:39 -0400
Message-ID: <CALSpo=ae6Z75SJ7uWj7H_D2GZZaU1genFv+shNCT01DhGYQCTw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] RISC-V: hwprobe: Document unaligned vector perf key
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:52=E2=80=AFPM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Thu, Jun 13, 2024 at 12:18=E2=80=AFPM Jesse Taube <jesse@rivosinc.com>=
 wrote:
> >
> > Document key for reporting the speed of unaligned vector accesses.
> > The descriptions are the same as the scalar equivalent values.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > V1 -> V2:
> >   - New patch
> > ---
> >  Documentation/arch/riscv/hwprobe.rst | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 7085a694b801..344bea1e21bd 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -236,3 +236,19 @@ The following keys are defined:
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int whic=
h
> >    represents the size of the Zicboz block in bytes.
> > +
> > +* :c:macro:`RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF`: An enum value desc=
ribing the
> > +  performance of misaligned vector accesses on the selected set of pro=
cessors.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN`: The performance o=
f misaligned
> > +    accesses is unknown.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_SLOW`: Misaligned accesses =
are slower
>
> Should we specify what size of vector access we're comparing against?
> In other words, crispen up what "misaligned access" exactly means. I
> realize you copied this from my text. I really should have said
> "misaligned native word size accesses".

In arch/riscv/kernel/vec-copy-unaligned.S I set WORD_EEW to 32bits.
The rationale for using 32bits is
("riscv: vector: adjust minimum Vector requirement to ZVE32X") in this set.
https://lore.kernel.org/all/20240412-zve-detection-v4-0-e0c45bb6b253@sifive=
.com/

I'll change faste and slow to start with "32bit misaligned accesses are"

Thanks,
Jesse
>
> > +    than equivalent byte accesses.  Misaligned accesses may be support=
ed
> > +    directly in hardware, or trapped and emulated by software.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_FAST`: Misaligned accesses =
are faster
> > +    than equivalent byte accesses.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED`: Misaligned ac=
cesses are
> > +    not supported at all and will generate a misaligned address fault.
> > --
> > 2.43.0
> >

