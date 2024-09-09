Return-Path: <linux-kernel+bounces-321426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C4971A4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20B71F20F42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D01B3F32;
	Mon,  9 Sep 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pesoIBQJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3391B790E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887096; cv=none; b=FnpTb7pMUsxrxTNRJJpWa+RCTSw78syygp/Nae+QNCxxOVn7CT6uat+3yJAirhtG90ALQkgVAWST0xnPqovrKoid4QF5fuJBgZc1S8hDpNX6AJmg/LECvhxX6oypZmt/6ILFhFie/dCGq0HFVFeoIGzbieafK58N8s4W6Kz2NnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887096; c=relaxed/simple;
	bh=L0vwODwwSSBymebWFKwW4WyiZMvG/NRkmKNHnmKLW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIfG8TYGhEwYi+djGIuM1hKTj/BCJaxThYzAXeOBy/76e0X7GyQV2Fni3c3YfOVp4d9iQKnP2girgnasftxO2omdRAu3FFXw2Ybj2Lfe7u23KFgfzT05IsiriHKaB+eajZkct0a8CoHbsmlhO639BVclBHxVQNTrSegciEOPm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pesoIBQJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717929b671eso3352794b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725887094; x=1726491894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVvLY2VfZB6N+n3cVr06yApvKJo36SMbCLMd3Fv1sX4=;
        b=pesoIBQJUSdFbRlfhQde9T7B304uCBdnIA2I5yzQMnsz+wzmHUMhe7VJXHmLcVPWWc
         Q21YfhoEC3K3ODRB74nrHSMAe83mzTjoZ9+ZHPA0AfrA8gA/9oy7evvCdlpa2qLcPKvT
         IsWbMXSSEXCTAgNPe4m027/BMFPVRXxRVFHJFRISuiTdB903wEZxPj0FNDzzp7BwEt7a
         1+rNSDORygNfJvXzoquEhs3m48EwfDSZT3Jx7DR9y3o2eL7zU3xHx1miu2UtPtV7GiZV
         e1Ed48cLDcnXYSCp6Tqtx3lhxofcN1hRjggtkYYFyzQoJxNI2zUozLyLG32qzVxDjfBI
         2Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887094; x=1726491894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVvLY2VfZB6N+n3cVr06yApvKJo36SMbCLMd3Fv1sX4=;
        b=MVQ+Vin27g8sz1/NPoe4my58z0O9G5XxpJCdeXiC+louHTNnB0VjsqwcaYauKNAlPs
         hRGDy1Xlg8p9VGaamnXVMrBwfKVCBgcnJtTu77dyt4m+EvDYcnbWrsCv8iwUOBnhD7lw
         xMnmi4AqwfQ0T82f4ZbN9JbOTQO7XjGRjUgTai0l8+xPrfCP3yaZ5nSKfDePqNn5Nhv+
         YxW1BeWEzP2FODziznn4jFbfcjfnruTcEDmymKkNUORuj3M+EYAfP4hTrAqr18zkZA+b
         tc3D+P5GqSvegbsu2T8KA3wsr+LFw2CsbHm4FF4DTMmFKg9NosTqW4Q0y5qmHydraO+2
         7ZVg==
X-Forwarded-Encrypted: i=1; AJvYcCVPsJ+iOU1XTBl78IHGrNlVkSpFnatqU/Msvx1hPCwsBNn6nmrdSruI3GJrlxNn76w43l7Rb3nlqfWnjB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuMtSE+3csCnyIYhnDFKmT+DhM6pCvON+PPEe851O+BQffmSl
	O04ehqgK3/biNHOFwSIlyR4zRr69AAXa+NlidPeXwIt4Hau1e7JjIvtjE0Ob8FT7rnIYjyIsw7l
	3rKsEuXzJcDUUiKgLWdN5T/SuhAUws2vrX4pO
X-Google-Smtp-Source: AGHT+IFDy1qA+jlhwHF+kHq/KdBfZulF7F5n7E3iDmjlp1f+VOo/2osLQxLbnpMn7rApXlRIUljt3vDobqmAHL+Uua0=
X-Received: by 2002:a05:6a00:99f:b0:717:87af:fca0 with SMTP id
 d2e1a72fcca58-718d5c3644amr12733053b3a.0.1725887093727; Mon, 09 Sep 2024
 06:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906092732.113152-1-snehalreddy@google.com>
 <86ed5wvixw.wl-maz@kernel.org> <Zt6gvd4NwMmjS8JB@google.com>
In-Reply-To: <Zt6gvd4NwMmjS8JB@google.com>
From: Snehal Koukuntla <snehalreddy@google.com>
Date: Mon, 9 Sep 2024 14:04:42 +0100
Message-ID: <CADTD=jYYWSi-J08T17YAhjFYDcCjMegpwuO9hVPfWMRQ4=6E7g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Add memory length checks before it is xfered
To: Sebastian Ene <sebastianene@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks Sebastian for replying to Marc's comments.

> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(cons=
t u64 func_id,
> >
> > /facepalm: why do we have this __always_inline here? Nothing to do
> > with your patch, but definitely worth understanding why it is
> > required.
> I don't think it is needed, we can drop it. Maybe as part of this patch
> ?

I will send an updated patch removing the inline then.

> > The From: and Signed-off-by: tags do not match. You may want to add a
> > [user] section to your .gitconfig with your full name so that this
> > issue is sorted once and for all.

Thanks, I will update my git config to fix the inconsistency.

Thanks,
Snehal


On Mon, Sep 9, 2024 at 8:16=E2=80=AFAM Sebastian Ene <sebastianene@google.c=
om> wrote:
>
> On Fri, Sep 06, 2024 at 05:35:39PM +0100, Marc Zyngier wrote:
>
> Hi,
>
> > Hi Snehal,
> >
> > On Fri, 06 Sep 2024 10:27:32 +0100,
> > Snehal Koukuntla <snehalreddy@google.com> wrote:
> > >
> > > From: Snehal <snehalreddy@google.com>
> > >
> > > Check size during allocation to fix discrepancy in memory reclaim pat=
h.
> > > Currently only happens during memory reclaim, inconsistent with mem_x=
fer
> >
> > Can you please elaborate? It doesn't seem to fail at allocation time
> > here, as everything is pre-allocated. Some context would greatly help,
> > as my FFA-foo is as basic as it gets (I did read the spec once and ran
> > away screaming).
> >
>
> Right, I think what happens is that we use the fragmentation API to
> transfer memory to Trustzone that normally won't fit on the reclaim path
> where we use an auxiliary buffer to store the descriptors.
>
> All the descriptors are identified by the same handle and the reclaim
> will try to store them into the ffa_desc_buf before nuking the FF-A
> annotation from the stage-2.
>
> > >
> > > Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
> >
> > The From: and Signed-off-by: tags do not match. You may want to add a
> > [user] section to your .gitconfig with your full name so that this
> > issue is sorted once and for all.
> >
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/=
ffa.c
> > > index e715c157c2c4..e9223cc4f913 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(cons=
t u64 func_id,
> >
> > /facepalm: why do we have this __always_inline here? Nothing to do
> > with your patch, but definitely worth understanding why it is
> > required.
> >
>
> I don't think it is needed, we can drop it. Maybe as part of this patch
> ?
>
> > >             goto out_unlock;
> > >     }
> > >
> > > +   if (len > ffa_desc_buf.len) {
> > > +           ret =3D FFA_RET_NO_MEMORY;
> > > +           goto out_unlock;
> > > +   }
> > > +
> >
> > It took some digging to understand how the various queues are sized,
> > and a comment explaining the relation between ffa_desc_buf and the
> > other queues would be very welcome.
> >
> > I also notice that we have other places (apparently dealing with
> > fragments) that do not have such checks. Do they need anything else?
> >
>
> I think we don't need that check in other parts.
>
> > >     buf =3D hyp_buffers.tx;
> > >     memcpy(buf, host_buffers.tx, fraglen);
> > >
> >
> > Finally, this probably deserves a Fixes: tag and a Cc: stable so that
> > it can be backported.
> >
> > Thanks,
> >
> >       M.
> >
>
> Seb
>
> > --
> > Without deviation from the norm, progress is not possible.

