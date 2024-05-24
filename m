Return-Path: <linux-kernel+bounces-188349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82008CE0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835961F21F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D28062B;
	Fri, 24 May 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG3aWpki"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4622331
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530740; cv=none; b=QJDf9kZJn5BhRcz+TvXnC++5uPx+O2x8U5DMoES27sv5vmedT1/ECezV5gFNP7RlozKlGvtFr/jqnc7w9ox83cdEeikNc2+0ZvpX/QguR7CQoyx4FngdDVf+nysPL9mgunf4Y+NDBccSk1LIgszsmAXKO3Y2L1rQXpDWUAzmqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530740; c=relaxed/simple;
	bh=kpzy4+Cm7xkKbD//6X6vRTzzibT1rJnotN6vCJgevEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjYa0nf4aavLERm1Qd+vMsZUuJpo7dyzfiwEHOJDaqM1LsuFoOHafiAXvG/V5LaCJScSoDF2XqeDZBWz6CRtDykVUruwLz2zV7RjlM1Y+NuLMNhfuDR/BCu5egLFl8brTqj6O5oWuHgwPTdLYBLv4QLM0N8vOtVhN28CacmdmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG3aWpki; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4e346e36fso2971819276.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716530737; x=1717135537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqf26CfH9Re/+9Pm2biqoGGaxQ7Jt/g4liDQMPY2O3U=;
        b=BG3aWpkikB5ohcF6m4VKSC26RT3DHKCGIC5yocnn6/MHnHNEObeVv5kT/CaMOLCDK9
         vy9DpMnAamqjHUykcl4b/57hvtDGOD+hcgyuI8HBQW5BeamRffGQOY1YMKfeEnWHkddN
         hneLaiJV4/yORqTR4orlkDOI0Kt8705JZDTX4vbgdNcqGH6evlne4cv+ps+mB9jne+rB
         wl0VpZDb/q0daRytlk6ssq6HuEQNxscNlwjTdGnMvx+qR3sVP37ePy5nVs/bAuJRu73t
         TipttlR1+i5V3ram2KUI6GvusAFtSZzy2eaV2/D0UgClG/asg3wBopb+gjUOsFalDnhq
         98sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716530737; x=1717135537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqf26CfH9Re/+9Pm2biqoGGaxQ7Jt/g4liDQMPY2O3U=;
        b=k3kbgOWJu2GSCRMIrA8NTqF6zocE8nRTfYeNn+cCyTqGhDrMIK86ptZnIIB80s41p0
         xKUqiAcvoZHDtChBqp3QRpI8u6vd06Gsm/ajM0nt/DqQaZRuBpb/0/QVEyFGkWU2Ao0v
         sL3Nqvt/tSlyZPudPiwT2kW3daENC0Zj3rMbwfNJPy3WU1a0WdToVZWLCG4tVUUYc//C
         bxciZlyZjd1uj3lpbT4OvMdhPyJjDDFUMh83BzC/Kkpz7S6xgs2bpIpfh2LozdcFQbrU
         d5vECdLuuNDWYwxQgre5TqKy6KfV1BNhF+tWQiufPjIVMh60z17fN7a71/DAfayoRKKr
         EPjA==
X-Forwarded-Encrypted: i=1; AJvYcCWfbb54V0ikKfD5PEt6XCLPLp3356ZP23du9M+xEpA0Z++xXb6Is3eZgKBXNF78ibQNGFosemiju9iaDfrqr4cKaOlvzDtWt37f/GxQ
X-Gm-Message-State: AOJu0Yw1aJAfcSVZxx62VEgBHCetXbyg4Rj37fcgk2uZsUA6rgP2Nvdp
	AtrZaCWnuzbXXdxQV+rYVkcMTuMwyb44cT84c2I0eWC7RRPzY59aIOu7+6sZ8pXt4R1oTmU+jSf
	X/twNOYhGrf/iq6b0RrDH2rJ7hy4=
X-Google-Smtp-Source: AGHT+IGee+Qt9uaBo/fX2ga4vsycCd469jfi6gO7/v7NWE/u6xNyiw74Kwq3zT2+ptn4AxloeMBeekMiROWhGvoeI54=
X-Received: by 2002:a25:8c03:0:b0:de6:1494:f144 with SMTP id
 3f1490d57ef6-df7721a7766mr1317354276.28.1716530737566; Thu, 23 May 2024
 23:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523094325.3514-1-dqfext@gmail.com> <DM8PR11MB57515218B467E28FFDDB6703B8F52@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB57515218B467E28FFDDB6703B8F52@DM8PR11MB5751.namprd11.prod.outlook.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 24 May 2024 14:05:20 +0800
Message-ID: <CALW65jaHrd_AxhpouVm8rq6zTOPeRWMHv029k0cThVtTNDAaCA@mail.gmail.com>
Subject: Re: [PATCH] riscv: hweight: relax assembly constraints
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 24, 2024 at 9:02=E2=80=AFAM Wang, Xiao W <xiao.w.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Qingfang Deng <dqfext@gmail.com>
> > Sent: Thursday, May 23, 2024 5:43 PM
> > To: Paul Walmsley <paul.walmsley@sifive.com>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> > Cc: Wang, Xiao W <xiao.w.wang@intel.com>; Qingfang Deng
> > <qingfang.deng@siflower.com.cn>
> > Subject: [PATCH] riscv: hweight: relax assembly constraints
> >
> > From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> >
> > rd and rs don't have to be the same.
> >
> > Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> > ---
> >  arch/riscv/include/asm/arch_hweight.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/arch_hweight.h
> > b/arch/riscv/include/asm/arch_hweight.h
> > index 85b2c443823e..613769b9cdc9 100644
> > --- a/arch/riscv/include/asm/arch_hweight.h
> > +++ b/arch/riscv/include/asm/arch_hweight.h
> > @@ -26,9 +26,9 @@ static __always_inline unsigned int
> > __arch_hweight32(unsigned int w)
> >
> >       asm (".option push\n"
> >            ".option arch,+zbb\n"
> > -          CPOPW "%0, %0\n"
> > +          CPOPW "%0, %1\n"
> >            ".option pop\n"
> > -          : "+r" (w) : :);
> > +          : "=3Dr" (w) : "r" (w) :);
>
> The above code piece takes variable "w" as both input and output, so intu=
itively, the previous
> patch made rs and rd the same.
> Though rs and rd can be different, do you see performance difference with=
 this change?
> Or any analysis from assembly dump?

By making rs and rd different, we can save some `mv` instructions.

>
> BRs,
> Xiao
>
> >
> >       return w;
> >
> > @@ -57,9 +57,9 @@ static __always_inline unsigned long
> > __arch_hweight64(__u64 w)
> >
> >       asm (".option push\n"
> >            ".option arch,+zbb\n"
> > -          "cpop %0, %0\n"
> > +          "cpop %0, %1\n"
> >            ".option pop\n"
> > -          : "+r" (w) : :);
> > +          : "=3Dr" (w) : "r" (w) :);
> >
> >       return w;
> >
> > --
> > 2.34.1
>

