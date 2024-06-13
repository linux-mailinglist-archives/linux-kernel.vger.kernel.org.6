Return-Path: <linux-kernel+bounces-212569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC028906361
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF921C227C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9980135A69;
	Thu, 13 Jun 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfP8jxB6"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACA4C6B;
	Thu, 13 Jun 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255844; cv=none; b=R0NoTu6XJ+kWpLj3NnyqumRBwQho4E2QmPUHpJjPc6mb8nO64JRV0fOpSuYp20elipR6PhOnC/WqsXgghntRTwCebNOuyxpA6AhGnTAyK+rpQuBKLpUZ0CCX4xZT4lC9yWpuekH1T8Li9ajzOa0ytObyHKV5+rNZZcvisyzu9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255844; c=relaxed/simple;
	bh=mPTXJ9FIYMF7P8QQ2HGfywQBtmmSfyVAMi+4/1zV9Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFpMm25GoIQD6M6mJPzEn7RcQubwZ9LAV2G6MjIq1EywkEO7rGaE0RwkDlE+3DsdvqFLCoZjVSqa19g+QyM/V3njM94jzqc35F9Badt5Qkb+si1wS5KP72QKhH6XluBduuYGK65Uae4YwFeyjUNaqFdqn/HpwVXS0ZzhWE3CtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfP8jxB6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7955ddc6516so39487085a.1;
        Wed, 12 Jun 2024 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255841; x=1718860641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZbJPHVns/walNPI9hYI9ziWHW23YvfpYoKJOsHQuS8=;
        b=WfP8jxB6tuPphqG3ux5+rliKP4pAp4LWnTonZWOVJX5yrvk3ZdlbWrj2zLYComHVUV
         TDWKR4vaTiH4Bb+v5mkNDcYPWYBpdHHPiaTjb/tVSfoIlNgLRhQl8KH7kYUN4nf+NjeT
         7LIAEYDZwcmKm9GAbP55dsm3yiQuLtj/EhUE0dP3uLIaDHwh1M5XOHgBOwAg+zcweNLf
         uu+tUeh56HHNXFxLu5SeZaTygKRhRqo10Kk1aU3O7HebTlXEcdn8wr0t38e0c6BpIZoJ
         xyJflxmbSA5gDLuFa2FFXOAk8DBGW8SqqPIACEmgRuhcKH0/YUYp+RNtuXdJy0cSyd42
         WpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255841; x=1718860641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZbJPHVns/walNPI9hYI9ziWHW23YvfpYoKJOsHQuS8=;
        b=RN2zzxbdVjODo6W1VNWvSkHFnVjVGpXb93bXfiVciVgR1h0JosiPdLzIbEYscPn0f9
         w3Q6fbw5EFoh1fuS5mXB8ZSDD2l42pxFOWrDxdc9vGSNq3STUtfLg4pByXG8E3fgQm96
         j8hEN5JPJ45fHm7gq9SVB1Xzf7eKQuXViA5DgCWwATZ+qrqLa3ozm7VPfCxYaLtP2uNl
         sHirq2a8utAZ6+24SvbPJ7Ihmy/H8to7l4VhfMCwGTnPDmzvKKNeDA2qI0gH0WFACxsS
         ItWkVJnVtUPp0C4JBP8VAvtIuzJmIilZ9wMwIiUyg4cUfKaT31/0Y1qE1fvgf30QFqMY
         mfrg==
X-Forwarded-Encrypted: i=1; AJvYcCWQKig/hXJMgY27pd1kcdwXaLxuT07ZPDwM3PiSjF6TCEaZGRj0uy7fDgeY6f9mXHQCyUgPaMLgCVETQ310l93ojxFdNJ/t4rqdhIiX9onLXu3gIZub6ia3ePcpy2/qebA+Tn2IXb3fCw==
X-Gm-Message-State: AOJu0Yyq8SWbL/gc70BQBQ/0GsK6GDpp0/vjd8Fhs7o30ZSXM9TCUgkS
	uhlT+9luIsv5i4vnwl3gWtq9rrM4Uc/8RRg0Vj1cezBk1CCSf+dCfo8ifJGrAr4qgVJW66DWUE1
	d/3O5gJwN3YcpCRKFPt/F674GBh8F0rLNu3r6KA==
X-Google-Smtp-Source: AGHT+IG2kpOTJxIRJFMaxclBLOzuPjHJPnxPPu+pdtXe1mBL7ZyyIZr5Ve2KlxlCXNxF6aC9zqFIQbDPwAYTOUYRfWA=
X-Received: by 2002:a05:620a:1a2a:b0:795:512e:4ae1 with SMTP id
 af79cd13be357-797f605a114mr383589385a.35.1718255841222; Wed, 12 Jun 2024
 22:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612111623.102868-1-krzysztof.kozlowski@linaro.org>
 <b1f14e92-4491-45f5-90ca-cc3d5ceea81f@app.fastmail.com> <CABjd4YxxmNqDXe7SSzTpr4gsf4-Rp4sgB8x2sYSGzDDx5CWo2A@mail.gmail.com>
 <82482ddc-9f0f-45b6-b1a1-6de2617b6980@linaro.org>
In-Reply-To: <82482ddc-9f0f-45b6-b1a1-6de2617b6980@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 13 Jun 2024 09:17:09 +0400
Message-ID: <CABjd4Yz=DmqvSCQvFFbv+WiwxJWM2uJVw=U6zVAND0xHULxRqw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ARM: vt8500: add Krzysztof Kozlowski as maintainer
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm <arm@kernel.org>, soc@kernel.org, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:43=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/06/2024 14:57, Alexey Charkov wrote:
> > Hi Arnd, Krzystof,
> >
> > On Wed, Jun 12, 2024 at 3:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Wed, Jun 12, 2024, at 13:16, Krzysztof Kozlowski wrote:
> >>> The ARM VIA/WonderMedia VT8500 platform became orphaned in
> >>> commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail"=
)
> >>> and clearly it is on the way out of the kernel.  However few folks se=
nd
> >>> patches to it and it is nice to actually take them, till the platform=
 is
> >>> in the kernel.
> >>>
> >>> I do not plan to actively support/maintain ARM VT8500 but I can take =
odd
> >>> fixes now and then.
> >>>
> >>> Extend the maintainer entry to cover also VT8500 DTS.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Cc: Alexey Charkov
> >>
> >> Thanks for stepping up. A few years ago, Alexey also had
> >> some interest in this platform and knew some other remaining
> >> users.
> >
> > Indeed, I'm still interested in getting it up and running, and even
> > got my good old WM8950-based APC Rock board out of storage for it
> > recently. I also have a WM8880-based laptop and another WM8850-based
> > one at hand, but need to bring them up to speed. Should also have a
> > number of older WM8750, WM8650 and VT8500 (but not WM8505) devices
> > somewhere deeper in storage.
> >
> > I haven't touched the related code in a while, but as the original
> > author of VT8500 and WM8505 support code from over a decade back I'd
> > love to keep it all alive and functional, including reviewing and
> > testing stuff as well as (hopefully) adding extra functionality that's
> > been on my backlog for years. Does that count as support/maintain?
> > Happy to be listed in maintainers and be in the loop if I qualify.
>
> You can take the sole maintainership thus handle patches/pull requests,
> or become added as a co-maintainer.

Co-maintainer sounds great. Shall I submit a separate patch to add
myself next to your name?

Best regards,
Alexey

