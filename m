Return-Path: <linux-kernel+bounces-281589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5A94D87B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C768283F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F9167DB9;
	Fri,  9 Aug 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hQDtEnxz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4E146D68
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239993; cv=none; b=ee97bmh8t/fKKloeLnEPAifP4DNjC2CqsLv2WU3HpWz0Oyy8DF+XtFNyV4cnGHHi5oF9F21pDcsNrjjWOA6DbgkhxkJ3YT6mWL9EcDtRl0xhnQ9tyLlK21iQIBb/NKjcmLarYBvXLbJylAlKXojWrVUJYpHHnzGYa/700LkHrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239993; c=relaxed/simple;
	bh=EMwgpbGpqtxK9qM5FstSvh+/i6mMCxd8x/2L36g+U5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+27M8EeQCEtyo/2+MjVL51Oisj5Lea0Dro+cvD8vGocYcUnlkFfeuRwDwmNtmlfXF6bByp0iItJMx2YNZE4g+QilJu8KEVls3/tX+/+NOOgQO8M7B9EsgZpuTyEbNLrccIK8rhUeh63rLGUkzD0HQK5YtvXBto/WU5ghjHQoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hQDtEnxz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so3588733e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723239989; x=1723844789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPcWoPM5T6mXCkBA46P8MiJW+R84UJA1C5ibsXG+NU0=;
        b=hQDtEnxz13bkb4Iy5ZtUlwRJh39fW+th/LE4NJHMTvb6nU+xMnkQ9th/WGM365Fcja
         xG7Y/inKOq5bq3uEzXRoIcvgiZkGUYovewdKqFrEBvHEDboOOQboz2y1kOvKh0vTWOZy
         4aX58RlF/nvIm7+ldwiaoFxk9cKNefqfrn0FvgpRNXZ2t5QjfvY2R6yZch5m74NZbO0N
         kcff8LbKnSd9AIcljpmNahUJqNv8oDYMV6mOrGNTewv8LDDqxyG+StIMuZ8VQwrMof6l
         lsnCQDHAxkROZhPfDui1FtnVjMOkgb3xTmuEP743zvbO2VShI06Y2JwtM5SYdT5TCMM+
         eyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723239989; x=1723844789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPcWoPM5T6mXCkBA46P8MiJW+R84UJA1C5ibsXG+NU0=;
        b=Cx9s2w8TIyrLDi3RSvtn2atn26+fuU2VMFBbuFgx6yNaVsorN8es84CTJxAv2c9bN/
         v4R0yPz1MfpvrTfFkrv8eS9AeioCEZI3rhV5NxexqDn7IRKbNK6atOY2PfCG8GZ3Yvdu
         IRIL2w2QmNT2fH+f7v2KIMR5DVHkJEVByeinSEudiJFzY4BZZSmjClolwHAA5UGjbZcP
         eG9hIjhwBPkQGsF69TlanEHkZqoSDsMBTHqq+5MgZZt6D7og38eWv0jjK/obk8gUhnJp
         tIRmbS6n0uodSpqYEtHWstCev71f6GD5EqZSK92x2h7KCnJU975Uo4EuVeQ4D7RdZdEk
         uMfg==
X-Forwarded-Encrypted: i=1; AJvYcCXgaulZmKMdmZc1PY3rzWy0JWbmrkQgyRNHThvwn6q5n8FpZW7zLNcSkz9fkVHXwWo4QuDufEaHAhqtWiJDy+6VNXg8zvTeZPH+SmWv
X-Gm-Message-State: AOJu0YxQn3xh324itL60jWbrQfC8Vk1DEU6txyXsVjTjjc6IxehOKLfp
	E2S8MNO3kF1leVd7eZw1LjZspXRdUdCkz7yzUYSH8SAl0iNDYpXwn/OTNrfKztZzAA38nlsz/eS
	h/qosYuF5n8XWrTaJXL3GR/Wjq3Y8PfM2+LewMw==
X-Google-Smtp-Source: AGHT+IGUt3SIx098yHI0NOjFFT5huwe1Am0ALs5y4vYy6uypKkqdYWRivXOcblLqYD46P9ZeahVdLkwLe4tHmNVf4K4=
X-Received: by 2002:a05:6512:3b22:b0:530:9a14:f0a0 with SMTP id
 2adb3069b0e04-530ee992c07mr2527402e87.10.1723239988591; Fri, 09 Aug 2024
 14:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627172238.2460840-1-evan@rivosinc.com> <20240627172238.2460840-3-evan@rivosinc.com>
 <ZrO1MxZH+GwC5FQS@ghost>
In-Reply-To: <ZrO1MxZH+GwC5FQS@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 9 Aug 2024 14:45:52 -0700
Message-ID: <CALs-Hssb6R+EJjZsUAEktiFXfPFh4s6xuLqy824TUrEQSEbYAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Erick Archer <erick.archer@gmx.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:56=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Thu, Jun 27, 2024 at 10:22:38AM -0700, Evan Green wrote:
> > In preparation for misaligned vector performance hwprobe keys, rename
> > the hwprobe key values associated with misaligned scalar accesses to
> > include the term SCALAR. Leave the old defines in place to maintain
> > source compatibility.
> >
> > This change is intended to be a functional no-op.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > ---
> >
> > Changes in v3:
> >  - Leave the old defines in place (Conor, Palmer)
> >
> > Changes in v2:
> >  - Added patch to rename misaligned perf key values (Palmer)
> >
> >  Documentation/arch/riscv/hwprobe.rst       | 14 +++++++-------
> >  arch/riscv/include/uapi/asm/hwprobe.h      |  5 +++++
> >  arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
> >  arch/riscv/kernel/traps_misaligned.c       |  6 +++---
> >  arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
> >  5 files changed, 26 insertions(+), 21 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 7121a00a8464..0d14e9d83a78 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -243,23 +243,23 @@ The following keys are defined:
> >    the performance of misaligned scalar native word accesses on the sel=
ected set
> >    of processors.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of mi=
saligned
> > -    accesses is unknown.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performanc=
e of
> > +    misaligned accesses is unknown.
>
> Hey Evan,
>
> This series hasn't landed yet, can you rebase and resend? There is a
> patch [1] that changes the wording of this description to "misaligned
> scalar" instead of "misaligned". Can you apply that wording change to
> these new keys?

Done.

