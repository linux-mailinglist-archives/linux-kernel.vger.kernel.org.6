Return-Path: <linux-kernel+bounces-285874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB39513B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF2B21A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45497558BA;
	Wed, 14 Aug 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waymo.com header.i=@waymo.com header.b="lY50OUnU"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679A55898
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611501; cv=none; b=bLTR7eihg53OsQYBRaf6YtU5N8oQNA76ZnKtmISiR+mf4o+fz/a1yrLjjvMZxLV9oJcvbVfwzdQxTkNYs6IqTANB7nCpkA+jiKOAsBqFHuLvoHBNfB2TjJPoyY/K3TTopLqou4sbSrEyruBuSGNzmbMU6E272UpmJL2eEYa6eME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611501; c=relaxed/simple;
	bh=PBcv7AEUH9uG2X0lUtNcI/Bqxmh4kq7YdmO9pd7bAQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loCh7kcd73+nyw6tUbpS77Pd1QqMrEeXSTXdP0Eipp8OTlSBIzZ6++tZFG2fbLWua4mZym6E1w5763V50FCIK/G+jlCzp6Ynh/Al6VppfxUtLKcG4zfDnmr191xKM4MSDbmVFilCNGjXnBKuKD/G6AqqSirG5EpLn4JZiFjYjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waymo.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=waymo.com header.i=@waymo.com header.b=lY50OUnU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waymo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bb5a4668faso35984246d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20230601; t=1723611499; x=1724216299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZbsYN7hywOio9CebOtG5ipZd6XqFXAATkmmHXXoYiY=;
        b=lY50OUnUBITPCdeiU2ovLyNK3tW8wfIfX90NAYJi5jC3vN5p0jybmuvmSGJPmi4VzY
         55v+uFvsF8WIG8DVoLYAynY22EEmO3Pl4UgevnYHWk3cvlOFCREPRJVLf0IcVCcDr7EO
         MMRwDxVZpPmO+NbsmcLxLGts6qzZPkqezTfAopDYaJebcSOTbtKKKD3dxHb6oGY+WEMa
         qgy96SDlakupDbCTxyXOgYlF4GZyKAtVxjGa80XfDIB6TClO4ltqm20u+dkbDFGGck5n
         VLXsHmn8OF/ywZvvYreo+UT44+RMak2mw2/0DKwpvnHngavsACVsT/RsPdP/ZW7Ob4T/
         iDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723611499; x=1724216299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZbsYN7hywOio9CebOtG5ipZd6XqFXAATkmmHXXoYiY=;
        b=sx7SNn1K2PDif7Y/78qTWfqpPwdDlu2INdEFd24pnnRGZd6v2Mzc901V1xmPGWJFNi
         P6T9R02uZv10vW4ONXmMhLcfniLyBF5TEWaOzs8Q6UMGdDLH0gIUPevK4f+PhAistILX
         cQmjBQdEyGbR1Jg18RIGqg2p1LkIQcAIQZwI3Jf3D6Xjv8PMQVpYMO2TE8jxLwxlmptF
         C1IQmbCwFnSPNn8Z3jTwWYDCybfbRP8SQvbkWz4bkQkYbv7Z7lWfeqPJxJytOSFhYHWU
         7Ue1B8Swi3HlgJS35ZeHFqIS8yNfmmpYUbYyUW9rpE62d8LYORH/2jI1w/NsCnjn4fxJ
         HRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVETjiqSd+l+VhCcZm9qv2xCkOziRQAQvAbpeXXh6hLu4fMxEb4Hwco2Nom9Mou9PMkLodv7HBbub3jVrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMDBr6542ZeQhSt/NedNqytwo426YPF3un3fpZqlK+vKQiJMc
	A7S1mXQnuzRJdj+AhD45orOtfPt+Ks0C7PPdA+kQGhspk/rxaxFgKuJiJLC3YvyCG27w94nVvqs
	Mae8xPoxBf0mgJt48dsl+8puxqOW6GocBhCU=
X-Google-Smtp-Source: AGHT+IE3wmqWQC8hH6zZI3LxdJ0W45BhWmHg3wpq0EuaM73ZIPGiS2LC/8R6MAF1HWhkBv59JXB0Iutnq0JiQV7NQ+E=
X-Received: by 2002:a05:6214:4909:b0:6b7:b1b7:c44a with SMTP id
 6a1803df08f44-6bf5d1846ffmr17979386d6.16.1723611498599; Tue, 13 Aug 2024
 21:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sev9wrkj.fsf@intel.com> <20240813033508.781022-1-daiweili@google.com>
 <871q2svz40.fsf@intel.com>
In-Reply-To: <871q2svz40.fsf@intel.com>
Reply-To: daiweili@waymo.com
From: Daiwei Li <daiweili@waymo.com>
Date: Tue, 13 Aug 2024 21:58:06 -0700
Message-ID: <CALhna8C4Ux27SWYRxY4iViwRPSjReUgQpiJtfivNT-bCZLhuqQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] igb: Fix not clearing TimeSync interrupts for 82580
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: anthony.l.nguyen@intel.com, daiweili@gmail.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	kurt@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, przemyslaw.kitszel@intel.com, richardcochran@gmail.com, 
	sasha.neftin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the review! I've sent out another patch that hopefully
addresses the comments.


On Tue, Aug 13, 2024 at 3:26=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Daiwei Li <daiweili@google.com> writes:
>
> > 82580 NICs have a hardware bug that makes it
> > necessary to write into the TSICR (TimeSync Interrupt Cause) register
> > to clear it:
> > https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/
> >
> > Add a conditional so only for 82580 we write into the TSICR register,
> > so we don't risk losing events for other models.
>
> Please add some information in the commit message about how to reproduce
> the issue, as Paul suggested.
>
> >
> > This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sy=
nc events").
> >
> > Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
> > Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn=
6f7vvDKp2h507sMryobkBKe=3Dxk=3Dw@mail.gmail.com/
> > Tested-by: Daiwei Li <daiweili@google.com>
> > Signed-off-by: Daiwei Li <daiweili@google.com>
> > ---
> >
> > @Vinicius Gomes, this is my first time submitting a Linux kernel patch,
> > so apologies if I missed any part of the procedure (e.g. this is
> > currently on top of 6.7.12, the kernel I am running; should I be
> > rebasing on inline?). Also, is there any way to annotate the patch
> > to give you credit for the original change?
>
> Your submission format looks fine. Just a couple details:
>  - No need for setting in-reply-to (or something like it);
>
>  - For this particular patch, you got lucky and it applies cleanly
>  against current tip, but for future submissions, for intel-wired-lan
>  and patches intended for the stable tree, please rebase against:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/
>
> For credits, you can add something like:
>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> >
> >  drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index ada42ba63549..1210ddc5d81e 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -6986,6 +6986,16 @@ static void igb_tsync_interrupt(struct igb_adapt=
er *adapter)
> >       struct e1000_hw *hw =3D &adapter->hw;
> >       u32 tsicr =3D rd32(E1000_TSICR);
> >       struct ptp_clock_event event;
> > +     const u32 mask =3D (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
> > +                       TSINTR_TT0 | TSINTR_TT1 |
> > +                       TSINTR_AUTT0 | TSINTR_AUTT1);
> > +
>
> Please move the declaration of 'mask' up, to follow the convention, the
> "reverse christmas tree" rule. Or separate the attribution from the
> declaration.
>
> > +     if (hw->mac.type =3D=3D e1000_82580) {
> > +             /* 82580 has a hardware bug that requires a explicit
>
> And as pointed by Paul, "*an* explicit".
>
> > +              * write to clear the TimeSync interrupt cause.
> > +              */
> > +             wr32(E1000_TSICR, tsicr & mask);
> > +     }
> >
> >       if (tsicr & TSINTR_SYS_WRAP) {
> >               event.type =3D PTP_CLOCK_PPS;
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >
>
> --
> Vinicius



--=20
Daiwei Li
Software Engineer
Mobile: 415-736-8670
waymo.com

