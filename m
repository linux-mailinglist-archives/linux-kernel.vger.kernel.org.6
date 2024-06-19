Return-Path: <linux-kernel+bounces-220464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C890E215
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9740F1C215AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1B4AEC8;
	Wed, 19 Jun 2024 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LqpYF0u5"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76382139D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769208; cv=none; b=cYitAFFK65SeVZqI5Nu+IAojaPEEM0lTaS7v6/i/S6b2vG4bNnXatqdPLrhpQvCWUTO3ZzjL241lYSEdz9rufY3xffJOz7MLt31jE7fiRqgGfs0xIhArvaiYdrdFqAdU6WVtMUAfZc4aPrJJ29TUtsqFLkPTKT5HrWTblORFc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769208; c=relaxed/simple;
	bh=pIHz5KtagP0i0syBXkLoiOtsCIJGYTnI3byypHOLScY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuX8Vj8mnsW1UDu8PqVj+4txGslxdD8mtR19AyDq5BK+6yIjcEZL5bMHWv9cYPh+9uCV+EoB+LW/dMm9Xo2CvIza52sosWabX4QkglF3+b7oLE6+W1cdZYmC6yB/5xW8fcwiEs6MjB8qIK1I2mKUiJXiWmSsLRb97vUJ4C7rmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LqpYF0u5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70a365a4532so2422489a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718769205; x=1719374005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4mXtN5dINh8fXJ9StUQgoLkncIjUdBt0xjsRSEbe2c=;
        b=LqpYF0u5R/nmgZ1mj6t6yRTLXJA831spbjClJDn7AhREm/8YrRAMYTzcpoIPybGLfb
         hxXDAaY5Xjovuo4eUj7d1Csl/ST13s5wZjYJQ8bDzgluFA7JrNsSRRIl4pMljyP+Aks0
         rzfeLHF4ECiUTtDbtoRDnGEa/zk50NZfLpxyiCvPYYfseXvMjqEU2r0bNtcCNTTQbHDf
         n9WQZqaQI3Vux0FWMdZCTgDvJY7iqUZVFmaEKzlVnaIGhlj+sdxZFIbdOwmmHgSPl9Vy
         Bm1ib8XEBEAvWYLVW8ErBHeMWclfJWJ8TY9v+TvpP2YKzms0D1b+hf96AbffuUJjuE/x
         9uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718769205; x=1719374005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4mXtN5dINh8fXJ9StUQgoLkncIjUdBt0xjsRSEbe2c=;
        b=vKQcidkEOKEwCfZIGIAk/bonnDEqI1MUvok4ITK+GTQYMi1vyKg9Of/IuO+cpb6Fmr
         85kGQiTmSzftzDiYRLlrg5xi0OFFl72rftGcDyObmBUiqJfUDCAt67zW+78/4CECUhwf
         /F0jjB7ZAoaNvn/xK1yJX8aj5HfBoj5ocFhoX8gnfrr15iZKW4nfh2dFUP76GprSYsFI
         +OvMyEhTAtpHULEu88sup8PvTrMDokGQyNf37Zz4Lc8KYpDEqkDW2th4t9Qaute8GCRk
         sFHrH6CODK3QorSP9+sMvVI5MixVkqdyrjH95VjnRw71NZBRBByYQIACwpGQ0I6LrXCs
         f0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoyvJwd0lKY+i3Bx5v5CMrLGHXmuWdBMN3U9hv8ldpIsGj0+Rg+nfEU4JG3DlK5rg7GDbitQpDhMfwgkUEt0vnRME6eR5mX6aNICmn
X-Gm-Message-State: AOJu0Yx78KlVU2urBUi4pTCipvtLgiF/NJ17/1t7yvFqi9GPMAn5a7dp
	DSvKk37jTAilxLpZebe1lsUA95ItmtqujJRZRF4XMdGbwuoJArUym236vDIkE3sdAnxyZrqXyPa
	6wwzxU6D/HSdU0mNdHzixg+DapuR4K9wtf7suqg==
X-Google-Smtp-Source: AGHT+IG8myJ10Gv4rgdI0AE0LBkAKwh/LKCs0T5qlEmgvDKP08qqEdYSjjLe+WuTC0rtZlde65DDWNY4XKIwTLjJ+5Y=
X-Received: by 2002:a17:90b:3717:b0:2bf:f248:3506 with SMTP id
 98e67ed59e1d1-2c7b5b7aa9cmr1419260a91.12.1718769204926; Tue, 18 Jun 2024
 20:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
 <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
 <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com>
 <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr> <ZnFqDRXRjoHMaJXW@andrea> <9268589d-9ccc-4cdd-9de2-5019407ef313@ghiti.fr>
In-Reply-To: <9268589d-9ccc-4cdd-9de2-5019407ef313@ghiti.fr>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 19 Jun 2024 11:53:14 +0800
Message-ID: <CAPYmKFu8_72K21GL15W6fwyUv36FfEOcQKCv7dKgoT29gOwhSg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrea Parri <parri.andrea@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Jun 18, 2024 at 7:52=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Andrea,
>
> On 18/06/2024 13:05, Andrea Parri wrote:
> > (merging replies)
> >
> >>>> However, if local_irq_save() is called when irq is disabled. The SR_=
IE bit of
> >>>> flag returned is clear. If some code between local_irq_save() and
> >>>> local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STAT=
US
> >>>> back to 1, then local_irq_restore() can not restore irq status back =
to disabled.
> > But doesn't that represent some bogus manipulation of the irq flags? cf=
.
> >
> > config DEBUG_IRQFLAGS
> >       bool "Debug IRQ flag manipulation"
> >       help
> >         Enables checks for potentially unsafe enabling or disabling of
> >         interrupts, such as calling raw_local_irq_restore() when interr=
upts
> >         are enabled.
> >
> > in particular, raw_check_bogus_irq_restore() in raw_local_irq_restore()=
.
> >
> >
> >> This got lost but this is still correct and needed.
> > You mean because of the mentioned rtl8723e example? are there other suc=
h
> > instances?  IOW, why do you say that the changes in question are needed=
?
>
>
> Simply because the scenario in this driver and I looked at the arm64
> implementation which restores flags unconditionally.

Indeed, ARM64 implementation restores flags unconditionally.

Actually in the beginning I found several drivers use
local_irq_restore after local_irq_enable.
Such drivers include 'scsi/arm/acornscsi.c',
'net/wireless/realtek/rtlwifi/rtlxxx/hw.c', etc.
I wonder whether the semantics of local_irq_restore should be
restoring irq flags unconditionally and thus I submitted this patch.

>
> But if that's considered bogus, let's drop this. Sorry Xu for the noise,
> and thanks Andrea for pointing this.

It's OK if we think this is not a problem. Just ignore this patch.

Thanks!

Xu Lu

>
> Alex
>
>
> >
> >    Andrea

