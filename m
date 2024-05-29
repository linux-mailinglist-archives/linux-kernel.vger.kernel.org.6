Return-Path: <linux-kernel+bounces-193495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5758D2D04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CCF1F24AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C911607A1;
	Wed, 29 May 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EGPOj2ZR"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354B15B570
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963356; cv=none; b=LRuwc56NQxO2CrN4aCZ+FikVJ4shMT9vrdNGXq3ci0v7LarhiS1nHfBkFAcV815jsPQTRHjS4ZQqyfBgpmI3b5nCrqome9I1qPCNpingREkXG3kHXy+mp+7BHPPD957IdqzTkxHcsEn4ra0dLZBBkXd+twB87tTIwRGUvxQZqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963356; c=relaxed/simple;
	bh=J+6g85MacrkhD1shRZPgIPHazStFB7uwlbQPh89YIGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePrZr+4B2lYH3d4FPpgRdDMiFWoqDpW2CvdTlkqh5sdfrmR0Wlv5xMmcKLGpHnmIY3JAwqi+PzSHCywopFIPB8UcjY30qXdJtCQuQfjBp708wmv2PRLDMoNPV1s3JxnlubFQBSWLkz4aDja5P60X9Bs7dKvPQvkeNdJbt2SS69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EGPOj2ZR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so30903961fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716963352; x=1717568152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh0ieLiOPTlnWO1kYS9M0GlqV4zOVJ6IiYKninn4+tc=;
        b=EGPOj2ZRwNYZVsmt/xgNAaN9Qh5qC4/ahKgdB3FqJjCONzi86G8l+ARNLbKC9Del6D
         48MX40fWduWhtP1Hb1LU2oIexalqNfhTR+kkMptf22G5vL2sqPdFTEJ8eu4fuQGyjPfP
         kaSG/5a2e41Pbe6Lbe0Yqa1S9AWjdPaD3FPQHN/oh3/zTx8AbRPCyjS3otOI0XLIrZPE
         ApfiZzQ27DYv0Cc3enDA4yLwPaAvPsSk80YarMdxUkdLD6aT641w2sYMhpLIFtZTcE/Z
         AhNID7YbXTc8dn1q7O0MnOKGgHhWAfnxfKbQT6MBGwB5TjDlUpXTI4+6u0NeWVb+Rf+Q
         PIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963352; x=1717568152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh0ieLiOPTlnWO1kYS9M0GlqV4zOVJ6IiYKninn4+tc=;
        b=ZfnZ5AH9t0xsivpEVMc7naGF7Wwj40vusjLdvjDYaKdFI5lqyCndDN/yN+iF47Dwb5
         Ted1PRxYcGWOlUPSO+eMu7QzM9SHlUu/YSV73Q0p7ZhNYZYrovPkgXgiLCbknySHXsAA
         eTVmWsXMBHQkBV4Cs8sMowYEG6iCqG/0CnVLT6mZc5yAi7HCBZzT1x96t9m92C1QBgEn
         pKF/bgoFhX3QEoxil/9A3TzuxnilKs6kWstL7ZtopCkqG6rz1BX4VUbUd5LoGSFdTbEo
         CkPQtokqQnzplGi2kQaN5XuIuiDk2YHibsXdl2P0Rt6aiADde7ZxzlU5zYUttUEdxaoX
         nRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOEZ7vsuL58s/X7khduXyu76T3mFUl+NM7vKLVFSz7j5z0B0SMp+6P+Nr7fP7yjkI50v5TU7EGQVC7Ph+ZsPIAjdwoOsll6MFXv/Jz
X-Gm-Message-State: AOJu0Yy1GI3ta99eVy+XRda6phUrC8rk00tas+QsSEgJOOeg2G8S92gc
	CGBameadIVTJZ8BGtQYEZGOgOtPkH19Kl+aSTc61Ur2EhK0bgZy8Gb2mxsD+YVn6v8p1zEb9zjl
	PXAyGv0cpxRZAnxcx4licIiJnkx3IsyARaU6U0A==
X-Google-Smtp-Source: AGHT+IEm6bYc2ftZFt2uXoqzzY7bu2Oy5wbaxhF7xACheYlMcKXX+Saw39KXwd1j/qas7p5N+0C1MMzLyv9RtXFbmuc=
X-Received: by 2002:a2e:968a:0:b0:2e1:c448:d61e with SMTP id
 38308e7fff4ca-2e95b096f52mr108173371fa.15.1716963352171; Tue, 28 May 2024
 23:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-5-alexghiti@rivosinc.com> <20240528-prenatal-grating-2b6096cc2a1b@spud>
In-Reply-To: <20240528-prenatal-grating-2b6096cc2a1b@spud>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 29 May 2024 08:15:40 +0200
Message-ID: <CAHVXubhsqOp2hSxVg7eGjjLN2-iTUFz1AMDTeEvyJh01iypzrw@mail.gmail.com>
Subject: Re: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Tue, May 28, 2024 at 5:22=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, May 28, 2024 at 05:10:49PM +0200, Alexandre Ghiti wrote:
>         \
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e17d0078a651..f71ddd2ca163 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -81,6 +81,7 @@
> >  #define RISCV_ISA_EXT_ZTSO           72
> >  #define RISCV_ISA_EXT_ZACAS          73
> >  #define RISCV_ISA_EXT_XANDESPMU              74
> > +#define RISCV_ISA_EXT_ZABHA          75
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG   127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 3ed2359eae35..8d0f56dd2f53 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >       __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> >       __RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> > +     __RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
> >       __RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >       __RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >       __RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
>
> You're missing a dt-binding patch in this series adding zabha.

Thanks, I will add that to the v2.

>
> Thanks,
> Conor.

