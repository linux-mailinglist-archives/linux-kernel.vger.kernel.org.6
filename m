Return-Path: <linux-kernel+bounces-303832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75196158D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C328207F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6A1D1F58;
	Tue, 27 Aug 2024 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0Ulr3zHm"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECA1D1F4F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780110; cv=none; b=rP2gMG2HdC4rJcdXYMJoTq4h9z85Rol98Ceeshu5dpIdfdM02oforA5PaYvcN1XCNdXsAPl8VZNiQ0lC6BblHsEcKTJ+EZuYSEuw4jXq1vBc1wp2OUEVZsjlWcPVkP5YKb36zbytR3X3E6a0OMAsTLhwt1DIXAVFnzQqGU6WtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780110; c=relaxed/simple;
	bh=1FE0u2nbI7OKJgfT9GgRd3Oz1W1aBhoVMj7q/UIJaRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hi2ZPnva6ezmV+YOtPFT2u0JRJ9DHuYdDb/tT5mCD1XN6hbhVBVsbU8ZSlzYM7LJlrbGKLy+lTZm6mSIMVxz8TA8vIE81hdz9r7cvu7Civ7erOqIzEqO823FxtYQWnCc7zv+YVdSr5HW3GXFE20fNTgZsHt+duwVzUq9uiNglA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0Ulr3zHm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so3889155a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724780108; x=1725384908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIb4mBmzYC43N+oUZo7c8o1exbrEwgUhHvaxeKHnwHg=;
        b=0Ulr3zHmNt5C9ECn+ud8IX62XnpqKmQbICP/DrsweI/FOOXCWzsOOTmPXF15NoHvPy
         1zAokCIFATpSb2xsQ73FHlNJ1szWsgqfQRTe5MJrL3bn+zohzzXRR8pGDZ+5Yt0UJetQ
         flYaWqq9x9UaKOCrQkjxS1cwHXry4LbGP019rLpkSYkTHzo3d9eqoHme4YNgYL+NBeaq
         FhP46wKgbAV6dmLI8umzFF050XEaAcIB1Ww92UIjFAL4YcqGo6T/0InsWcr4v7/4RwKD
         TqxNnW+uWftoDrOgMotHZ60SEyFw5Zc9bP5i69gftKMsd5VQ3Sasai2ktsA8GomNQFU0
         uGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780108; x=1725384908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIb4mBmzYC43N+oUZo7c8o1exbrEwgUhHvaxeKHnwHg=;
        b=FOcNrfY5LdugXa/ZtPX4aRtaCpp24qq2NMnXyFuXy6CX6miXp117WKfTn4hLIryx3M
         IxJFAfKKjgnOpV7lHe0jDcPpRnPEZa+GqOSfwW7I0oE8nXjRC8Yy5Tr3sMcSF+zE3ap/
         4OQpk30Yc9WU2xo3fwSLcsGDgKyWgMloELlw3+povlpyl0Srvng/nNKkMk/Z6oFKKaX2
         Bs6rOqLyWKdkl4Wzx8L6gSgfTDFiff63ksEi97bA83zHPRcWrQRkd14NAPBvVg2fcrrV
         G8IPHGJprD2c9GShrEaEh2AaxyA6s1Z12utsR6avM705onY1eSdnDHO5Br0k4V/lCrAZ
         Km8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ57iG6DAdv6zM0AGjTbA3Ow3nOZty6sg1RCUsbLSOTU+Mq3Hp2ZlCr6xIkjKxXwiUq9tcJYmhZpp5+i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciJE+eisgbL3GxAF/NYMWKE5/21jVoMVrKEu6QdN+TF1ClgZ6
	dm4ofBdnPXcO7mEoMZ1olPwM8vAaR1CSpK7pKsIkzXZ792jRRpcPZKIcZogXbhw+1UI6fn8jevn
	eNU2FQIBM+daMDF0tX0zDqIfn1e8cocZfNpmwRg==
X-Google-Smtp-Source: AGHT+IEpoeoH7TOyIaOd7h4fboy+S0nnHcXXeC+zQ9IGno+NEAoMiGlqk67m7SoNWs89YQLWT1K4UhRWn4UViwoutOY=
X-Received: by 2002:a17:90a:9a87:b0:2c7:f3de:27ef with SMTP id
 98e67ed59e1d1-2d646d7fa7emr12752907a91.42.1724780107426; Tue, 27 Aug 2024
 10:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
 <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com> <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
 <A75E5C30-F062-43A3-A9AF-BB205632C7EC@jrtc27.com>
In-Reply-To: <A75E5C30-F062-43A3-A9AF-BB205632C7EC@jrtc27.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 27 Aug 2024 10:34:56 -0700
Message-ID: <CAH2o1u5bNDpP1Lv1AicEe6uyi5X-ANiApxpvmfBgcxzg4ipH_Q@mail.gmail.com>
Subject: Re: [External] Some feedbacks on RISC-V IOMMU driver
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>, Anup Patel <apatel@ventanamicro.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, Will Deacon <will@kernel.org>, 
	joro@8bytes.org, LKML <linux-kernel@vger.kernel.org>, 
	Yongji Xie <xieyongji@bytedance.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, wangqian.rd@bytedance.com, 
	linux-riscv <linux-riscv@lists.infradead.org>, robin.murphy@arm.com, 
	Hangjing Li <lihangjing@bytedance.com>, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica and Xu,

On Mon, Aug 19, 2024 at 11:27=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com>=
 wrote:
>
> On 19 Aug 2024, at 08:49, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >
> > Hi Jessica,
> >
> > On Mon, Aug 19, 2024 at 1:17=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.c=
om> wrote:
> >>
> >> On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >>>
> >>> Hi Tomasz,
> >>>
> >>> Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
> >>> lot for what we are doing. Below is our feedback on the existing
> >>> implementation[1].
> >>>
> >>> 1) Some IOMMU HW may only support 32-bit granularity access on its
> >>> control registers (even when the register is 8 byte length). Maybe it
> >>> is better to provide a 32-bit access method for 8 byte length
> >>> registers like what opensbi does on ACLINT MTIME register.
> >>
> >> That OpenSBI has to access MTIME piecewise is a workaround for a vendo=
r
> >> not implementing what the spec clearly intended, even if it wasn=E2=80=
=99t
> >> explicitly stated (but is now, in response to that). Repeating that
> >> situation would be a pitiful mistake.
> >>
> >> The current IOMMU spec draft very clearly states:
> >>
> >>  "Registers that are 64-bit wide may be accessed using either a 32-bit
> >>   or a 64-bit access.=E2=80=9D
> >>
> >
> > The spec's description about this is pretty confusing.
> > "The 8 byte IOMMU registers are defined in such a way that software
> > can perform two individual 4 byte accesses, or hardware can perform
> > two independent 4 byte transactions resulting from an 8 byte access."
> > It seems that there is no requirement to implement 8-byte access.
> > It's OK then if we think this is not a problem.
>
> I agree that part is poorly worded. The part I quoted (from Software
> guidelines) is clear on the matter though. My interpretation of the
> part you quoted is that the spec has been written such that software
> can choose to break 8-byte accesses into two 4-byte ones and things
> will work, but if it doesn=E2=80=99t (which is a valid driver implementat=
ion),
> hardware can also do so should it not want to support an 8-byte
> interface (e.g. you have a 4-byte I/O bus).
>

I'd add to the quoted spec the remaining part of the sentence:
"The 8 byte IOMMU registers .... 8 byte access, to the high and low
halves of the register as long as the register semantics, with regards
to side-effects, are respected between the two software accesses, or
two hardware transactions, respectively"

If I/O bus limits access to 4-byte transfers, respecting described
ordering: "the high and low halves", should not create any
side-effects on the IOMMU hardware (mostly DDTP register access). If
there is a use case where hardware is not able to split 8-byte access
into 4-byte transactions, macros defined in io-64-nonatomic-hi-lo.h
would help here and other device drivers.

> Jess
>
> >> Jess
> >>
> >>> 2) In the IOMMU fault queue handling procedure, I wonder whether it i=
s
> >>> better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
> >>> bit. Otherwise the ipsr.fip can not be cleared and a redundant
> >>> interrupt will be signaled.
> >
> > By the way, it seems the irq handler must clear ipsr.fip first to
> > avoid missing out some faults no matter whether a redundant irq will
> > be generated.
> >
> > If ipsr.fiq pending via fqof/fqmf is implemented as edge triggering,
> > then ipsr.fiq can be cleared at first. In this case we can not clear
> > ipsr.fip again after clearing fqof/fqmf bit, as it indicates a new
> > fault to be handled.
> >
> > If ipsr.fiq pending via fqof/fqmf is implemented as level triggering,
> > then ipsr.fiq can not be cleared at first and a redundant irq will be
> > generated after this handler's return. But it is OK as no fault will
> > be missed. Otherwise it is hard to detect whether the ipsr.fiq is an
> > old one or a new one.
> >
> > Please correct me if I have any misunderstanding. Looking forward to
> > the subsequent code.
> >

Correct. The goal of clearing FIP first was not to miss fault,
accepting redundant interrupts to be generated in hopefully rare
cases. To be honest, handling fqof/fqmf faults will probably trigger
endpoint and/or IOMMU device quiesce anyway, and very likely more
fault reports, as the state of the device/system in such cases is
already suspected.

> > Best regards!
> >
> >>>
> >>> Best regards!
> >>> Xu Lu
> >>>
> >>> [1] https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosin=
c.com/
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>

Thank you for your feedback, and sorry for the late reply, still
catching up on emails.

Best,
- Tomasz

