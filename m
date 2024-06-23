Return-Path: <linux-kernel+bounces-225917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B291376E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937401C20FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A9DDA5;
	Sun, 23 Jun 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuecHU3T"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1F64D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719111358; cv=none; b=kD18FMZnlJl09Xf4gt5wtTmYzWIqFxMQqam1IQaOUFVq31rniQUD/PWEFrWoTXU/AgPKwAZMPsGA3kjghFfhkvw9T6EMvEYsjgiK/4ZxucVun1E6SX3xvCoGeg7hLGMb6oK7bVJRmljAgD6b1zrmAPFdixNB8ZSCOkOUr7ql4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719111358; c=relaxed/simple;
	bh=kk0dfKY/ENx9zMKY0Wwe7kBZPbykdaRiDaEX5FNLjfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAR0HCYupK2ZYllpJR/868/4KXIh2gtqnFipp3cWtd99ONwvpuu0DI56DXJsoo7zi8rXZGTkK/zPUV+uXapNKvMudiVyaA1VecCgowetL7qbUtB/hDF2TXrV7olaEfupIh6iJAFg6NJouQ6SeXmACTK//vMbB8OrtvlTMAESC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuecHU3T; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724b9b34b0so8908566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719111356; x=1719716156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+dNGdqvPyMhPucHTr5/gO5LwLxeQdkY1pTtydDZXYM=;
        b=MuecHU3TwNuhnn6NX4YHk+Uf5CxqczI/cHpHhW4BDruFBb/HRScMVoQCrBsyVAprqw
         ojlUQweq+dt61wFBm+nW576dXZkfyuMAiHQD7qkvlyWqSkKy3Gt27MoQSsAB+/2C/HJ/
         v0FxK0KnEmNqhG1eek94VhRQ3QG7mK0Dz3A+ezaj5adblo2GHs4xaRNDgt7xcz9HKwed
         knSiptqyGPBi0Ee8G48OMHIw3TixdfNichc2beJH4L3UWMSofi0ZAKwpPKdg3vC531cK
         NYFyXlLVLGfNdKHOfeYiHU9gx1v8TFY0P64tpeN+mI1AmwYKhSgEXh79FV0zULHtJ03r
         QtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719111356; x=1719716156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+dNGdqvPyMhPucHTr5/gO5LwLxeQdkY1pTtydDZXYM=;
        b=j8y64Evy4IFy+4QrPL5y24Z2AfK2dmcfpUIXyDUQNAZcnKsZIuR/BfnkNe8k5wNMuf
         NnrxSNmuZGfOwOPN1pU3GT/+vyFWiaKe9+n0t3blTuhzhV+KYeQIuEdp3eFAc/Co4yFE
         NGlDfzn5ZcVTw8RvRWQ6FGJJJDcQxXS7sg2QCpL+0uRacLDl8Lij5Fh/f96J+pVBrp9N
         yKBh/wxD3fNtd3h8opoethT3BVUq24OleWAni+5NAcw1oJJaPsxB4vMLT7YlP7DlsQAH
         Ai6NUgm1MAK+PIynFAu1FQAAaih+64xkYCg1HbkTmZqaWkwyrY2uQc+9xFfn/gEulqR5
         GZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUNmerkA2w4Uz+i0XlbL983kHxCGAzzzBM2vu5hFtn+p/7YFz1+ThtrUDuUDWm0DhjKCmQa0RjN8tt4b6oMkc8uEIx7EBG7TZuQKb8
X-Gm-Message-State: AOJu0YwjrACkKcEkBTbKw3Cvg4veP/sKcHeHuLrPYsiezbDSeMggoHeV
	ew+uxrX/6lAck8E4SPKHWGmtqQALnBT352WaxLGYpmP8gjK/gaoD47klJWmiQxwMVlgkdTnQphS
	43+Qrv51xbS853Gqu3Sv5mqcYjOw=
X-Google-Smtp-Source: AGHT+IEKf/HkETPEeYzE1trwKs/NC1T9SkiEZfGUqAoH7CdTHB7ab/SUVkf5pHuQJagpNs0bWjagrPmp2+e8SiSEWys=
X-Received: by 2002:a17:907:168b:b0:a66:c338:65cc with SMTP id
 a640c23a62f3a-a7245b8f006mr63395366b.19.1719111355198; Sat, 22 Jun 2024
 19:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620020625.3851354-1-chenhuacai@loongson.cn>
 <87msnem3i1.ffs@tglx> <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
 <87pls9z3g0.ffs@tglx> <CAAhV-H7noyrYJzyVML8y1gHPiB6qZzXy7j5L_AqjxwLZW2J06A@mail.gmail.com>
 <87jzigznai.ffs@tglx>
In-Reply-To: <87jzigznai.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 23 Jun 2024 10:55:43 +0800
Message-ID: <CAAhV-H6u-5EHATP3O=23SM7mMw3-xqOwn22YE4vWtj=GFELC+A@mail.gmail.com>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Sun, Jun 23, 2024 at 5:21=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Huacai!
>
> On Sat, Jun 22 2024 at 19:23, Huacai Chen wrote:
> > On Sat, Jun 22, 2024 at 6:17=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> That does not make sense because it's exactly the same situation when
> >> you compile a kernel with NR_CPU=3D8 and boot it on a system with 16
> >> CPUs. Then early_cpu_to_node() does not give you anything either.
> >>
> >> So what's the technical problem you are trying to solve?
> >
> > Frankly, there are some drawbacks on our hardware. On a dual-bridge
> > machine, there are two eiointc instances. Even if nr_cpus limits the
> > "possible" CPUs, we still hope the eiointc driver can initialize
> > correctly, otherwise the machine cannot boot.
>
> Hope does not help with technical limitations :)
>
> So if CONFIG_NR_CPUS is not big enough to map the second node, then the
> machine can't boot.
>
> If nr_cpus limits it then early_cpu_to_node() because that mapping is
> only limited by CONFIG_NR_CPUS.
Yes, if NR_CPUS is not big enough, then we have no solution.

>
> Right?
>
> If so, then please explain all of this properly in the change log.
OK, I will explain in detail.

Huacai

>
> Thanks,
>
>         tglx
>
>

