Return-Path: <linux-kernel+bounces-348715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D698EAE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AF81C21A38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FC12C7FB;
	Thu,  3 Oct 2024 07:57:51 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418E53363
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942271; cv=none; b=mKYAq4btRbf/vXgkF5jUj9wEwAVCK7hjpikHrAkejXePZc9Sd+aZbYF7cxBM09UdmSeOcYH2epSZp8VZcnhsUCXHG401XroqqPjik8pKpPEsnK7abUPbw6R4kK7eXG//3riUsMkYdfdBVtSc7TOgGN0J31rpAAozkCRAThNrZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942271; c=relaxed/simple;
	bh=P6D8C+Qcs8klJaF2+jr6gTI/okBuq1w42TDRnsZx8/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk6eTCFNkwJ0pwWPiZ95XRj42rSCS71sMsIoBruLxr4VOCpQlxd+0A3B//S3pBV4bVgKz1rNZ9F7KvcaHfmEzidDFfUnlSPjbezvrEybGwq5egqHDJNEffmElrFA7sJWcMHuAVQENFT1nEFnrkw+0yPJwSeSuG31HB4345+X1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac187eef2so8376811fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942265; x=1728547065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RD0t/Z2NUMuzWftZvrrW0m73y6hWXplEq2Auw33NSE=;
        b=Mt1tZCfKc9L9h9vIGNAvkIwI5u/fuoyZ6Cluvfw+a2K/N915yJcAoxsynAEAGGy70S
         gpMwLBHV6Jv+LXm2Y84cAJViP0nyI/F+XpT/tWcJ48KafD4Li2CgiZfI1P/R9ByBbH4g
         7MZkWAg8TK43OaMExi/QEWv/OsEke7utBoEIm43AdB5IBu6UfII7TBK/mkwT7bf4e9wM
         9+nVo7K9/g1FOZG0HUhele8kIr7oPigLv9dIln4zl+RbHABVkLpApQDFIMq8fVqAv/Cq
         pNYLdrAudh0LG/1sewDPmwgt32I6JnwUlS73nttwHvMNEdJsa031Y7wAoYJV0tUAqnVi
         aE7g==
X-Forwarded-Encrypted: i=1; AJvYcCWV75UkBEzKRNGb9honNEjMjGvLbR5MGPhBy7t32eWlR7XUoh4VqTGNdYgqOdxTViHNdoL644tcFWCL6eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEIT97vnxHw8mLlc4zxUD9a6tM2qyCtv9Vpwp1DF25ooopirn
	AoQs2lsxkF67UYUZcKu7UfE73/dMQii7qvJlpdRcF96oHlpF9krV6WJ9em4C
X-Google-Smtp-Source: AGHT+IHaIW2/LihhlTBLq/khQNwl+sCP88YC+WaNmHFjbP2NTfOPP27QamehPjtGQ6q+ELncZMNbDg==
X-Received: by 2002:a2e:802:0:b0:2f7:9d20:3882 with SMTP id 38308e7fff4ca-2fae105f2bbmr26850451fa.22.1727942265111;
        Thu, 03 Oct 2024 00:57:45 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc6b443sm1473201fa.98.2024.10.03.00.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:57:44 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2facf40737eso8183801fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:57:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3zkLgsF+jkdU+aSqDGkZ+AVxO2BgxA5SsmOyt8ZjR25xrxHZHogxoux84MNX2+REGk4ukr9ShtzQAvCc=@vger.kernel.org
X-Received: by 2002:a2e:be9e:0:b0:2f7:53b8:ca57 with SMTP id
 38308e7fff4ca-2fae105a685mr37369921fa.19.1727942264767; Thu, 03 Oct 2024
 00:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home>
In-Reply-To: <87zfnmbfu7.fsf@igel.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Oct 2024 09:57:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
Message-ID: <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Wed, Oct 2, 2024 at 7:00=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
> On Okt 02 2024, Geert Uytterhoeven wrote:
>
> > + * Optional: only supported since gcc >=3D 11 (partial), clang >=3D 13
>
> This is misleading.  gcc fully supports it since 11 as long as binutils
> supports SHF_GNU_RETAIN.

It fails for me with arm-linux-gnueabihf-gcc-11 (gcc version 11.4.0
(Ubuntu 11.4.0-1ubuntu1~22.04)).

$ arm-linux-gnueabihf-as -v
GNU assembler version 2.38 (arm-linux-gnueabihf) using BFD version
(GNU Binutils for Ubuntu) 2.38

In response to v1, you replied:

| That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).

So binutils 2.38-4ubuntu2.6 is sufficiently new, but it doesn't work?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

