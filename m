Return-Path: <linux-kernel+bounces-414942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CE9D2F86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EC128338A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471671D414B;
	Tue, 19 Nov 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="CqGo0o+u"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AF1D12FE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048361; cv=none; b=pAlqHAL+wrLCZIwlP8QLFsNVZMI/0itM1hV2dBSILHC4yIV/uHAmrFNu2ndln3XWnv42f2oGLWS0+wIDLwc24fMZf+ATQid7Jr0R5rRDYKGopWkLSqC1W/W85jhE4E9iWt4aePAUDNwIzVGdrSOVbi5eEFsOA3mHYY2MrhozSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048361; c=relaxed/simple;
	bh=GLCB1gqgidh2CB3MXuc8Qvp3m7YFBIgllq1uKS/FUeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWTaYkIfsw6My4ukiMZfnzR4IVVyfm64iOzhsRnbri30Zn9aOZmJjj/Knt1ewJh4Pbv4L+F1iClpQW8+qUoAN2vyZxIPiSp+rin1aSoVTuyVPybyvlKnSPwAsh1GzQOyj+ueEvCbZhHMy5CfuLIrm5oOeivSvpsNKp/c3lOURY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=CqGo0o+u; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53a097aa3daso3432380e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1732048358; x=1732653158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWYEkOWioHzgVeGfpq57ujDZosgAfTiRf1WJliLcrIk=;
        b=CqGo0o+uHVyRUto5Dbc+EW+KMonBs23jHfxJDdcP7wV2wn2ExNzBAdZc9dVR3dtsht
         axlUsGQVCT6wuhX6h+LSbVm8NUn/X1T2dR0MDSszzuDr1EzEZjMui8chFEeCu+z5bSno
         AAsfkdxMh5YDhLjQQstYhCw3DCD+wGuMM3JPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048358; x=1732653158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWYEkOWioHzgVeGfpq57ujDZosgAfTiRf1WJliLcrIk=;
        b=GBLQ8p3qu9Plqz1nk6kgRs8eXK7CA+Y7KPnCXs8MMJInvluk0/kcg6iwqZgvALgIFu
         IcJYxSshBWpgshvydAxoyY/9ZD9nz1aYsX3Z7zUuJmun1+kRY1LrJi5Te9uGg4VW986q
         bhWFENMIuhEgIz3dZSC6yOlKR0HFDP7ozddDA/GwWWBSuxJO3q5dUGJxMvQEFOpZkybt
         97Ttw3h+QElI3JVjRVU3fiI2VxC5b1qIXgo32mrbvxsPf308VCBihBLuXkRswF9kLm8/
         I9DY4/lJw4E2yMLYIOYwL1ab5xwSgVyTAudMgPEgo5H0P8TaCSnfegGvDwIQ0kR2JpGA
         pISg==
X-Forwarded-Encrypted: i=1; AJvYcCWGuuTqupaz8fdI77IyGvG0CT0/8Vp7+d9svKigkRGeUiOss8WGbkcYQI73PBJOT0o2Qu9qWt4Wo2VbgfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1e6ReQInQSCq7g/0m36nbSP+SzkxCDR+XKlxaJfHhuDgg1nn
	BWNJDnonsYTxpHbQZa/1fOZU24jtcBIkuAg9vdBbIvBau1TPQn2g5KYghimC7LNbILY0CpbhqGi
	WX7n1GfAyK5qRbirHIJjHyFhp0rdP60offgZ+
X-Google-Smtp-Source: AGHT+IHehrUYEzEiAX5rp04UBz9YHJyIrQz3EVW0EutgehQKYe+7DHzI9LMwa0xr58vt5qaV/wiuwXsHZJodWJ94xHY=
X-Received: by 2002:a05:6512:2347:b0:52e:98f6:c21f with SMTP id
 2adb3069b0e04-53dc13338a9mr32181e87.16.1732048357488; Tue, 19 Nov 2024
 12:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
 <20241105183513.1358736-3-valentina.fernandezalanis@microchip.com> <20241111215220.GA1993016-robh@kernel.org>
In-Reply-To: <20241111215220.GA1993016-robh@kernel.org>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 19 Nov 2024 12:32:26 -0800
Message-ID: <CAOnJCU+ac07aT9jLf5zqB+HnzHyqLMZE-Mz+cJDTdMAkS6LRTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] riscv: export __cpuid_to_hartid_map
To: Rob Herring <robh@kernel.org>
Cc: Valentina Fernandez <valentina.fernandezalanis@microchip.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ycliang@andestech.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, peterlin@andestech.com, 
	samuel.holland@sifive.com, conor.dooley@microchip.com, alexghiti@rivosinc.com, 
	ruanjinjie@huawei.com, takakura@valinux.co.jp, conor+dt@kernel.org, 
	jassisinghbrar@gmail.com, krzk+dt@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:52=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Nov 05, 2024 at 06:35:11PM +0000, Valentina Fernandez wrote:
> > EXPORT_SYMBOL_GPL() is missing for __cpuid_to_hartid_map array.
> > Export this symbol to allow drivers compiled as modules to use
> > cpuid_to_hartid_map().
> >
> > Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip=
.com>
> > ---
> >  arch/riscv/kernel/smp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index c180a647a30e..d58b5e751286 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -43,6 +43,7 @@ enum ipi_message_type {
> >  unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init =3D {
> >       [0 ... NR_CPUS-1] =3D INVALID_HARTID
> >  };
> > +EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
>
> Why can't riscv implement cpu_logical_map() like other arches?
>

We can and we should :)

> We really should have a common implementation too, but that's probably
> too much to ask I guess.
>
> Rob
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish

