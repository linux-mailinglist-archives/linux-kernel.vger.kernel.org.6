Return-Path: <linux-kernel+bounces-417784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714579D5902
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B83CB22049
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB61509B6;
	Fri, 22 Nov 2024 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcU0yjak"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0922309B4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251745; cv=none; b=b+6Heu2ZJoMC3xdqDlwffln2RcIOcVC7EwBEg3caep29NUyIzLyihpaPv6UlI5hei1ZXDA5/40g8IBVhqGWBbrdAAiCtYZnXpBNiAAxm8F3H+j87HTzoyrjhfYihJvvha2pDeARzgOOm6cWNUCj4Ik7l8ZbwOA/utckBwUNBuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251745; c=relaxed/simple;
	bh=qS801PKOtt5qeQd2rrmw105l2ICVujdW2kRWx0Iz3Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tac2D+NF3lY8PMjEYfAY6pwM1zUshgrJNDabxSOfN/se+jAxpL++KxTqCRCuJJ8QQY/rzxJyY3+KZXbqFlGmBXyT65zk9jdJxctKUPgT9PoqEBDUGldUI3ypGqyMeS3SlyRK7G89eAkiYWOXxd5Ib6n3QS+5WAO577yYUb3Uq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcU0yjak; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so164611cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732251743; x=1732856543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM2OedZjIPfu4sCxCIoKHGUlk/UJAhQ9XCieLskfQt0=;
        b=ZcU0yjak1gL1rb2tgdUkFZ3nSZzz6PFRJ2xKX6SCsRKajNQFpzvUPgyJcZUf5/NDLP
         Yp14Te+4XL6dt1gB8TfKLIdhUbHORGLwMVblDlVHxK9yAJTIvSfq0JHxsWGIJOhvsE9k
         l94p+Xi7TEm0D2hJPXDKLoJev6jsORX8VQkbyHtrFHhqmCMLiVQVM5hqlgaO+d9zPEQR
         rvLgB2C8pGpXkeO5hPrct8RHtdPsv4wTpvWD6TKeHvy14NYQhzzjJkUsz9qlJO3/lXHe
         CnPtMxClsAsC7QYxzdNRLm1MpyjIEHdtZSB6QxoA2GsILSz3xy6APx5Smd44LvXJFvaP
         6NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732251743; x=1732856543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM2OedZjIPfu4sCxCIoKHGUlk/UJAhQ9XCieLskfQt0=;
        b=cS25S1ysIPgRP8B9FxxfoCO8XDRfhWqbX2NhUj1LUxl7rvEG9xIyYUXcFAkHAbeLty
         1ytn+0vtXEYybg03nCQOvhWPTbnPgzuC6cK1reF8OdrdJSTJcIWuV+COOf+6PRQLK/08
         6BsU5NxmeysULJwElNGfjd1VWrY1qO051XUFMdQnLAnY93OyV15tKWk+uYFaP7wR5Xs7
         ZOOHPIw7iDKdOcxtJL7JDlfvauLpkjvwPYCW7BNpkwrCCKUqS3R1kE23rk1+9IZJet5w
         pJceXPRju4u0t+SBIVxv6Vd80TUDtCQX1GQlv7aVMDbrApoaoF8G7l0EQXy19o+uNMrh
         eUgw==
X-Forwarded-Encrypted: i=1; AJvYcCUzflSBgsX+8CQXHcjriXd5oW6527xxovAAKE8oIj46ZkYSeyj28mi8dV/LOib2jEBeEcGTAcn7NEbK5No=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1nmWYElgbHewqsDp10nTCt4PgXqSWIIqRk9HO0U1qNSvZ41v
	TVt63ZsSxlJqc36jAn1vvo4Djs/I8Eh6pPbhUfmosEMwv+ULFT7YRav2i0C1nPxVAaRpnN5ZXMX
	lWpWfeZLUJ1ON2UaeRJpISCZ4Y8fFYLFIZGpV
X-Gm-Gg: ASbGncstpuRjAmVFQ//kdpNb93mcbejRCSdX4l2iR30jLFeB9XnY6rlk6UmQ93+I2be
	lGPqYkzghHTbI8pGKFnTocFdD6WUWIxWtkugnO7/BW8MI1gQ/mV2gZ+PIIVQ=
X-Google-Smtp-Source: AGHT+IGSBdZWAT4cnvExtpdsqL27XrwwPqF3r4InTPu6pwGviu4eUZLWygopHUdvMXgTBRe1ZG+RSJzlreUH80PAKWg=
X-Received: by 2002:ac8:5d02:0:b0:463:6f7b:250d with SMTP id
 d75a77b69052e-4653d5d7379mr1908991cf.24.1732251742485; Thu, 21 Nov 2024
 21:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd252b78-077b-441e-8371-106d71258ff3@alliedtelesis.co.nz> <84d9200e-25b4-4bd8-8eb5-c954ff92ac08@alliedtelesis.co.nz>
In-Reply-To: <84d9200e-25b4-4bd8-8eb5-c954ff92ac08@alliedtelesis.co.nz>
From: Rong Xu <xur@google.com>
Date: Thu, 21 Nov 2024 21:02:10 -0800
Message-ID: <CAF1bQ=RU2dZU3ENy3MLM4FvrZNaZprgPAM5vbRtUVDixJNQ_zg@mail.gmail.com>
Subject: Re: RTL9300 (mips) fails to boot with commit d4a7f2510ff4
 ("vmlinux.lds.h: Adjust symbol ordering in text output section")
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "Han Yao Yeo (atg)" <hanyao.yeo@alliedtelesis.com.sg>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Gotoh <gotoh@allied-telesis.co.jp>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does the following patch fix your issue?
https://lore.kernel.org/lkml/CAK7LNAQSpM2hh2=3DWgribb92nHF5_peRb+gxdO1Bt1Mk=
eL8N+hw@mail.gmail.com/t/

Masahiro Yamada already applied the patch to kbuild-tree.

I also proposed a similar fix as yours. But we believe the above patch
should also work (and probably is better).

Please try and let us know.

Thanks!

-Rong

On Thu, Nov 21, 2024 at 6:29=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
>
> On 22/11/24 14:58, Chris Packham wrote:
> > Hi Rong,
> >
> > I was just trying some of my in-flight changes against linux-next and
> > found that my RTL9300* based board no longer boots (nothing on the
> > serial console after U-Boot hands off to the kernel).
> >
> > A bisect between Linus's tree and linux-next/master points to commit
> > d4a7f2510ff4 ("vmlinux.lds.h: Adjust symbol ordering in text output
> > section"). A build on d4a7f2510ff4^ boots successfully. That series is
> > well beyond my area of knowledge, there may be something that the MIPS
> > SoCs are doing (or not doing) that is being affected by the sections
> > moving.
>
> Based on the sparc change that accompanied this commit the following
> does seem to restore working order for me:
>
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.ld=
s.S
> index d575f945d422..e90b0f68290c 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -62,6 +62,8 @@ SECTIONS
>          _text =3D .;      /* Text and read-only data */
>          _stext =3D .;
>          .text : {
> +               /* Match text section symbols in head.S first */
> +               *head.o(.text)
>                  TEXT_TEXT
>                  SCHED_TEXT
>                  LOCK_TEXT
>
> No idea if that's appropriate
>

