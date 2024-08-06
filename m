Return-Path: <linux-kernel+bounces-275550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C018594871B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46698280D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D55AD51;
	Tue,  6 Aug 2024 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fl/ZfEuw"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD645680
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909427; cv=none; b=ZPgvVQfKD/JEe68CSqZk0DYmvXO9IMBIdO+TaAZ2GXx9tx6xWo1KOTrcLsdI3P0CPnMeSpne1ICCkKB+ebAWi8AiVz9vDRzeIRFiy1OQLmBOfTDJUzzMj1fd3pwmIfDcKHfMz/kOJCFysd73g5ps97zHU70p8pnJWcmt+WHpZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909427; c=relaxed/simple;
	bh=o5ubZySqM898YMKI6B44D6+HzEqA4goif3s72XtXPEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9CaqVA3H1+se/B4lrRxq8ifPup64ZX7no/F65l4spIronys9TDNBauT87J8V0tUt8qxRRD2DZSHZR7UIo+tt5LSaO8D2P4P62D5/aR+MwKaCs3uVGT5Cy2nAUI982M6Qm5u1C2NMBeuA5DiAGGwdg6ozaagQSIlUhvjDoNcl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fl/ZfEuw; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so68155e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722909424; x=1723514224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IBhLwxtqkmorMtQaTuVRdda8fWR3f/wiJqz/bSky3o=;
        b=fl/ZfEuwLqvt05Yrm48nuIjQNGXb3jOArbAJT46tXE57LBQllva1uwCi6k8h7tQy/L
         Et+UFln3sJuEKfMVxq0cqmqyYok/i6MqC+0O1knJml67mmTyY68tqHfhoVl/arHmHcUf
         VarwGEuZg3M/1w6A1aCUxhaGx9Og/+SNvngEVCf4jQ1KrSoIJ4TaW3DsCm33mxT+PX9k
         Q7CffZkJy5kJOIBRa/5md8HXSOAD2X7N+dPUkWMtMs/ip6YGC/06xj8VeS5Qg/oUEtw0
         qpbDNwiHNOwObx+q3l3MBFyBWsalAmkMTTUO4KNqshVzqUe06smg02HsdLn+NEzCmn+L
         ikIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909424; x=1723514224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IBhLwxtqkmorMtQaTuVRdda8fWR3f/wiJqz/bSky3o=;
        b=ov77mA5rzRvoxbgayMwbMxnZeJpw15OnhTa+iFU602RT6yX/gxpBhDVnDuhfWWeV5J
         aaE5fSCThUHEVkQX5T7nO47L7wdjS+1KR64GNTxYzoe6JjkdyGjT1GCjt7l+TEjifA2l
         YCbrIvqcI0xDQSlFXXnUHDAZkMW/8ni/VoH1LneB6GrNz/cVcJEjez38QsmDKBOMEcMy
         Hc+SJusi7FLxi5ZR+P8yni8gyS62M2VAMe+dhOpOCekZoAuQGVTs73GODS/THQTZ0dVQ
         gCcMBX66QEsfNqqjdxG8FFLvLI91I9/ESdMjzDbUULofApsRF2ftq5sQ8sJYadkj4+wk
         dnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7NKOxs6RqA0n0Q2Jrui9cA9eGVPhwAnRXESrhcGGVdlEc05ZXUJUG45KUeNE7EI61jYp1t5/tuv3lZ8MZUBmgfD0BTJcy3bX6cJRW
X-Gm-Message-State: AOJu0YxQ1qPEx4jPAWG3o65j4+PwQza4wKR03o9WwFqtlglw2p6/Ghm+
	GyUt4BNeTg6JahzLcmCpnLamC3Eqnz9kDDbEd/mhjaOwhTaYwvMg7aVBslT+MqO8inDje8d51Yn
	/EePWCYc4cvcnM40iGaxVe2RhItFegpVmHqN0tQ==
X-Google-Smtp-Source: AGHT+IG6uYp/qeARWmcfys9e+xhKBRJ3fLh+ZcQoOxPy1mUlLhZ7LB67in6o5dtQKoMQbvfW4vU8Bcr9rD2b/bQNxDQ=
X-Received: by 2002:a05:6122:4584:b0:4eb:5cb9:f219 with SMTP id
 71dfb90a1353d-4f89fe84d6fmr16806238e0c.0.1722909424192; Mon, 05 Aug 2024
 18:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802075741.316968-1-vincent.chen@sifive.com>
 <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
 <CABvJ_xgcbyQKa1+U1MC7cLEB-SUzzNaWqKdXFp+13mni0YSvNw@mail.gmail.com> <87sevj5r45.ffs@tglx>
In-Reply-To: <87sevj5r45.ffs@tglx>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Tue, 6 Aug 2024 09:56:53 +0800
Message-ID: <CABvJ_xhMAU+Ft-Ut2hMapO9dCSkz4M2PqxvdCrJS6eaSz02hLQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Aug 05 2024 at 10:43, Vincent Chen wrote:
> > On Fri, Aug 2, 2024 at 7:03=E2=80=AFPM Anup Patel <anup@brainfault.org>=
 wrote:
> >> Secondly, changing compilation order in Makefile to influence
> >> the probe order will not help in any way.
> >>
> > I was confused here. If possible, hope you can help me clarify it.
> > The following is the backtrace of really_porbe() dumped by GDB.
> > #0  0xffffffff8092318a in really_probe ()
> > #1  0xffffffff80923516 in __driver_probe_device.part.0 ()
> > #2  0xffffffff8057c856 in driver_probe_device ()
> > #3  0xffffffff8057c9ba in __driver_attach ()
> > #4  0xffffffff8057aaa4 in bus_for_each_dev ()
> > #5  0xffffffff8057c3ea in driver_attach ()
> > #6  0xffffffff8057bc4a in bus_add_driver ()
> > #7  0xffffffff8057d75a in driver_register ()
> > #8  0xffffffff8057e83c in __platform_driver_register ()
> > #9  0xffffffff80a2455e in imsic_platform_driver_init ()
> > #10 0xffffffff8000212c in do_one_initcall ()
> > #11 0xffffffff80a01188 in kernel_init_freeable ()
> > #12 0xffffffff80928d80 in kernel_init ()
> >
> > According to this result, the source to call really_probe is
> > do_one_initcall(), regardless of whether it is APLIC or IMSIC. The
> > do_one_initcall() function follows the placed order of the
> > initialization functions in the __initcall6 section to invoke them.
> > The compile order determines the order of the __initcall6 section.
> > Therefore, I try to adjust the compile order to influence the probe
> > order between IMSIC and APLIC. Do I misunderstand something?
>
> There is no guarantee that this order is retained. The linker can freely
> reorg the section. That's why we have deferred probing. It's neither a
> bug nor a problem, so what are you trying to solve?
>

Hi Thomas,
I understand now. I didn't realize that the linker could freely
reorganize this section. This patch won=E2=80=99t actually adjust the probe
order. Thank you very much for the explanation

Regards,
Vincent

> Thanks,
>
>         tglx

