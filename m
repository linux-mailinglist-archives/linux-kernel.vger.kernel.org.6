Return-Path: <linux-kernel+bounces-233669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962291BB52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AC1C22758
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9E14F9DC;
	Fri, 28 Jun 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HEfJ7MU/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCE1465A1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566507; cv=none; b=UmreX0JvC0CO5uMyZWVYwSdK2amhzulJwCjh5IvCedoE7XsKvrPhSkRlVQDEPtgGa+L9jszmrRxRy4zv44Md5iURHNODgC5SDOOPQnjtvDpY4dLflVcMJ1HM4ZStg+4Wlbt3xBlu281O3sNWStdG4ZGNNBOmvkU3DzIx/ovzaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566507; c=relaxed/simple;
	bh=GUUeOl5OTYU1P+SJ7athIDCY6ruVMMiJN7zw6ctaH28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rST769345ztjboIcfAAHyN6EVTm899wp9VEWlVWBrnbCfQtt9g3frzqaHR+ticQbf3o3GuGa37rFLs2MRc+SbLFztrjEG6oiTlRTe5TpG81MjlAeRi99OLxms81lG8qBP3UlgD3gkf8X5cCzZ9NijgJzCazjaKOldKcNJf5p2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HEfJ7MU/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724958f118so49508066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719566504; x=1720171304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUUeOl5OTYU1P+SJ7athIDCY6ruVMMiJN7zw6ctaH28=;
        b=HEfJ7MU/Jd8lvzm4b7NXvefu3oBBI3aUQ3HmdY7Ka56nU3D0ZZP3y2ORxf13STq/C/
         wTQXlc7UO1fVVdor7ThEnexkyUYPY3LHWOrps/FmnuwQnc54EOumZd7Is0f0zh82RKov
         w8pY/WDfzS0DsJ8X53O9j/juGaGuZ/MEZ+d+ul7bBfhhEoPfmjBtzo9APQvWKqBk2IzY
         T1RFdypLm47gT/wd1hhCt45AM+V/AXCEjoGJFXL+ryuPpQJbfw2gcdgT/vwixiEr5tSe
         +WST1RarTHp5gBwqd1WSHR6o5w0/B/GaboXSoT9dHcqKTFff7Sf+BXrJq7ddK6jYTKBZ
         5c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719566504; x=1720171304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUUeOl5OTYU1P+SJ7athIDCY6ruVMMiJN7zw6ctaH28=;
        b=WT4aWDVeYzbCXxJKSzNL3qtSHqV1zKuvPpSpGu7HFGMMNRcIYtgAdP5BqzwtPcwMeM
         ebK20tJMJCVBsohi8KnGp8uUky23v/FXA42qX4QaxtJBQtZ4SekYrVNKQRvr5ou8C4VJ
         m5gjx6gSi2byANB0fUTtRBsODSOy+uL3HT0pw+pSTGtUV42XZFGLTxJojN80OjiZLeMz
         e/hLWMxhTuBZPqoAL/xWn6mEfJv2ysfR+qbjt+vob1AbR9r13lnRimwltsX+MW/guWqs
         InQ/mk7NOaWHCiKFtMOtwoAutJywin8XnE1q2rtuuBQErSbLSbg8JCet+t2Jy0YN875m
         HqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUzdEb7gegViy9YxTIHi2AeN6vVcCDqxqREKJ73lpn/pB17/BZJlHoOgTUWQSqufwwbMNcoRGghTv5D9KBEcDje+j9HZFaU+v9YiIA/
X-Gm-Message-State: AOJu0Yy1OAdh7ku+4SczIi8EfkSIxfbLjLjlk/Z2VUGRpiKw8VW3qfWc
	DeOmKJDEUPW1GrUJ4ohcdgvXQVzfQNh20XNjD2YbbtrJ/018Bo1nBQN6cad6Cod0Q3Zze2MW/WO
	hWxqkbPLD0dQn6NJW8eUD7NkdmhRURgKGElZR0A==
X-Google-Smtp-Source: AGHT+IF7NFei1EQBJfySUv3C79EdZFXolxqVCoTcA7eZAbhURusjPaToikXelhSoNh/rrjdKoBeJoJz3xOL6E3X1Vt4=
X-Received: by 2002:a17:906:c44d:b0:a72:548a:6f42 with SMTP id
 a640c23a62f3a-a72548a702emr1002466966b.18.1719566503875; Fri, 28 Jun 2024
 02:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626171652.366415-1-jesse@rivosinc.com> <20240627-boring-handgun-40ae5bf2651e@wendy>
In-Reply-To: <20240627-boring-handgun-40ae5bf2651e@wendy>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 28 Jun 2024 11:21:33 +0200
Message-ID: <CAHVXubik-T=dv3hds4VuJFFxen1CRhfintGdOu3JsdAeouuOtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: pi: Force hidden visibility for all symbol references
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Wende Tan <twd2.me@gmail.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sami Tolvanen <samitolvanen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Thu, Jun 27, 2024 at 12:35=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Wed, Jun 26, 2024 at 01:16:50PM -0400, Jesse Taube wrote:
> > Eliminate all GOT entries in the .pi section, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > Include linux/hidden.h in Makefile, like arm64, for the
> > hidden visibility attribute.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>
> Did you forget to add --cover-letter to your format-patch incantation?

I admittedly don't understand all the details but it makes the GOT
entry disappear and arm64 uses it too, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

