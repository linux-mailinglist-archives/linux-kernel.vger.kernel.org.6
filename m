Return-Path: <linux-kernel+bounces-257122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34293758A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C311C1F22F25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40980026;
	Fri, 19 Jul 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fNjwIbjN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B85F876
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380308; cv=none; b=YtSzqUMeK0L8pvIOlNQOHzUCPM3D043uQVaDIndDxDYdBL6clrkXpOxPTUKCSI8jV2Ddr+dt154Y9O4RUY0IGmO6DCkIhYSSphfF/pgYxKX9Sz/iy5txq7Zl0fFDcT2b/TnB9Kpqg8grU0Rc/XmQqVU7dFHcbZll8XXyoYzvCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380308; c=relaxed/simple;
	bh=zSLuKaN+gBA5/2qa6gHM65PDw7SxQxl6CWR+d4GMVCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCWIBbHGnbswrfbEIFfvG0EJBIzJq6k76xDOtUik7319iNBz1h/wA7ayWIqVwwHEzSfo1+Dy4kMv651oG8QlgCUR+TrgCU1FX2yxgQBCBwOSOPJ75+VgaP6yzM6NltmA2a66L8cwcnJvM/cw58PDjsL7kzHXp5HDb8g008+0JJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fNjwIbjN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so910805a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721380303; x=1721985103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLucreB4C7Cq/x6iCkzClVthNh5Hb9jZ55GIvzS0dF8=;
        b=fNjwIbjN9aI1n/fU/uuIOYhXZbN3YDZy11mPKTwmXrdS+pk8/GvOUgQ/1LUOXQeNH6
         jGrXie9odqUYzeX37Wqw8Rp1yN8hyBRNXgzZHry85L0SOqMToUUkSPJkyiFFDKXu+oP5
         u7tk0Wv+MOwCbg5/ud78w+JyaKe2Nw/u2yq2Lv3/aqMISmgtxiODR1kn4Y2x66WIBluX
         c+wiqptc9TDvqGjh9Na0IFquZrMgLAL2n+GnBtXwv17mh1zBwKRzUHegCpIF9Zc3V1ju
         47A6WH6KmT62T2WF1N1UneLWpUphv8ZTLbF8UGEvjrjX9qwosXrIiifMKnXZ/HJq6tJg
         /8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721380303; x=1721985103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLucreB4C7Cq/x6iCkzClVthNh5Hb9jZ55GIvzS0dF8=;
        b=lv+FndFIX+xZsFHTvzcNVmpmBbtQaZftn4wbwJLoQOioFeR6uOgOkgt9CR7bdzh1HH
         h0qm6HXm3MCRybFbaJpBBVebbPq4HN0CrW73CYMw7dhKq+SbBN+vP4YEbuo0FjekjYjG
         4kaM6iKQ3q45QKySeAzbmEcBuAuOpQaLMfhQjAOFtqYRYJohNNxRRcgkn5OhHMe1/aJ/
         cSbVfS6zMZnSelkCSrLdarETC2PC0eXCtKdDc6CrPl7jZ4v6+GZHWYtOOVzPQSeElNCy
         +6DHM0ohYkYwZcRAfdp4YJ82UaKMt0fBGlBdgIEyYxPVC83K1u5UsM8SjI31yqtIQdaB
         Xhaw==
X-Forwarded-Encrypted: i=1; AJvYcCXR6t1XuDlBd+txHp1a2VktLxMuxudHI++LKpL8CKplBjU1SSRaXSNpT3C7bxr44cVmdE7RV5lM2QYqxPoxu8EbrR6tmOR1taUTtZL/
X-Gm-Message-State: AOJu0YzaDEQNQQMjI7UtbV0TYSiY7JlJfFeVY5HfNFAB+yr4vaOu8z8s
	WCDDxcmXI+tH0+/nHihuSGEY5tfcr+JqCoXJgdpz5tXKhZr6cOkDXBtiCO39E/5i9RyDk7UgVob
	0m7yLu8UM1INaxQDcG8Zf0ysQNCh1F21Z/BP3SQ==
X-Google-Smtp-Source: AGHT+IFO6hf+5HOcO5Mu3nZVEBJhdhYQsXgwhq2XadyFC/SlzZiV7DtJ0QY08kz7HxyLbxCqNNPbNHwc+UPc/5DYNsY=
X-Received: by 2002:a17:906:bb0b:b0:a77:c8a8:fd71 with SMTP id
 a640c23a62f3a-a7a01192e56mr514488966b.32.1721380303298; Fri, 19 Jul 2024
 02:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-10-alexghiti@rivosinc.com> <da5ba38a-8848-439e-b80a-3d6584111a78@sifive.com>
In-Reply-To: <da5ba38a-8848-439e-b80a-3d6584111a78@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 11:11:32 +0200
Message-ID: <CAHVXubiUfyPJtTzhm2N7yuv6CPqdDvL+Lm3Fq=8XT=gn77qPMA@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] riscv: Add ISA extension parsing for Ziccrse
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:53=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> > Add support to parse the Ziccrse string in the riscv,isa string.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index f71ddd2ca163..863b9b7d4a4f 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -82,6 +82,7 @@
> >  #define RISCV_ISA_EXT_ZACAS          73
> >  #define RISCV_ISA_EXT_XANDESPMU              74
> >  #define RISCV_ISA_EXT_ZABHA          75
> > +#define RISCV_ISA_EXT_ZICCRSE                76
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG   127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index c125d82c894b..93d8cc7e232c 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -306,6 +306,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >       __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> > +     __RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>
> Please sort this entry per the comment at the beginning of the array.

Done, thanks

Alex

>
> Regards,
> Samuel
>
> >  };
> >
> >  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
>

