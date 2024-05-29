Return-Path: <linux-kernel+bounces-193395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A448D2B58
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82119B233B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD31391;
	Wed, 29 May 2024 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t+Dv74Qj"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599A8BE0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952691; cv=none; b=Gc6v6jDY7FiOz9qiZ/Ze4Pzslnv9SavULEtAE71LWnSDOfv1YmJoM3sCqV93hgMylT1NaNnhFk2QtA/yDW/F1TKR72JG9i/b7nTat4FqfcqDgIyu2JYeKamwvgvRkzVPlfVWjzueV6NQ29PcObD2KNNtW9K1wCgnXy8iH2TgzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952691; c=relaxed/simple;
	bh=jbfmJS2BdmG5oxbEaUOnRzLbKYW8OnaBkBN1o+oKM5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm4SKyV9Dmxd2raj5Mez3LagZTCAFjRCHmsxQBUQ+b7Pfl8hN+X3F+PlvBi18csQipvKsunhqO0NaxtiNhX7MVGt7vN4KyLmplW5NjCweXN5lsGZLBcTQZ80ZfGMCKMh2cVoWtvsB63bCl24RhB0yKpihaa6ALjtlqDa1aCj4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t+Dv74Qj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA5023FE69
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716952681;
	bh=wzuecrJ0JFchccEBCmxLIDXRwMQkEzpCJKJ1c3kKpP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=t+Dv74QjPBGB3y6rduoyaeebj2bggcd/YFdZKtrr0hf84X9Ch0PPOOr2BqRtOiDF2
	 cmClN8xl4kB0eG9SYieYppNrcMvi0scG0zGBt2dJFPyeurgtYRlgbYjXuk1xI97U9O
	 sjWdqaXYlJgkKFLaeuZSbeFinYCx3nxdmDSyIO/Bi9ljK5EcYE6yhJL/SOTugrPX/x
	 we0iB4h/b6sY+nGpZV3sVvseCz4P5HKZBkPkMh0lCV6Wt7eKWV+XL9OffDKOX+3LPk
	 L2SI94OmH/0SRbl/WVH/a7np68r7p1uajOmg84oWySpwnnfnwbXpmuD+CMzhAwFg+z
	 FLTaniWLfq1jw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-357ad1f7b08so812289f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952681; x=1717557481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzuecrJ0JFchccEBCmxLIDXRwMQkEzpCJKJ1c3kKpP4=;
        b=JScFZoV+XWTqiYPJ1j/RxnlemXAvXc8k7iIonWqaVUqoX00GlxzsVYPi6GArPu6UFV
         dxp79vCTQ6Vmm8SPpnqKsAOtWEK2XIKjtK0g/kHu4+OhXXUbNJtufzTUvSVKuU27xJOs
         /h8v6iHZNMiT95TLpHdLZGEI5++81jDD9K2INjbqgYblL7I7kWXI8uqrizLDBGVtKrjH
         zjd4Jc/90wti6xUko2cKSelgYpB8YqWC57mtDjnucYIVG51wU9CXbGNb+oerKHEgQnF7
         HFZaULbbiV5JS/OzZYOqUO7wCUUbOTxu8i5ABa6rvvMAYnc2dg/GMaR0drdFeShr3Hv7
         0Mcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrdZFRv1toUQGxcPDniPHVJvGMaLixBGEYyR5PJxwxYlkMOdMLDJugHIws74D9tp2qAimIQUn5PcN+oPjLXeGdrUP4oziABSt0r0fw
X-Gm-Message-State: AOJu0YzlpsnmlCONPbpk4zzwtMVErn+c2a8ADx6nXsBFJrMPHHxpYx2M
	L+fjHn746ubmNmOiSpuRCsmFUdUgEqY1I8kzHCnAlXkbL+/zQnyypY7OPpf00KcbY5/Ab+Sgq4l
	xeqQnTRNi/Lm4tKrt0edOwxYuoCjm7JL4EoKm0oPKWwPhZsXS+nDUHpZwg0Y62nayB1o4ZhJH+5
	Zg0r5mhFe5+jYlRXv5UA2VbD0bU+QkNqTf6fvQWT4eGa+jbvlVlUb5QtySmjLwrhY=
X-Received: by 2002:adf:fa44:0:b0:354:fa0d:1427 with SMTP id ffacd0b85a97d-35526c25695mr13910661f8f.15.1716952681276;
        Tue, 28 May 2024 20:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCJ+0J4feg5DWmCamoCmdHKV9NdQcsZdg5GrTQwmVV6HKgfUo06EW5RnIGllF7jaxWmj3OWvP61y/5+LdyDY=
X-Received: by 2002:adf:fa44:0:b0:354:fa0d:1427 with SMTP id
 ffacd0b85a97d-35526c25695mr13910642f8f.15.1716952680890; Tue, 28 May 2024
 20:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528100315.24290-1-en-wei.wu@canonical.com> <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
In-Reply-To: <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 29 May 2024 11:17:50 +0800
Message-ID: <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after suspend/resume
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org, 
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your kind and quick reply.

> I think this should be called later in the reset path IMO.
> You should call ice_deinit_rdma in ice_prepare_for_reset (replace ice_unp=
lug_aux_dev),
I'm afraid this would break the existing code because in
ice_deinit_rdma(), it will remove some entries in
pf->irq_tracker.entries. And in ice_reinit_interrupt_scheme() (which
is called before ice_prepare_for_reset), some entries have been
allocated for other irq usage.

> What effect does this have on resume time?
When we call ice_init_rdma() at resume time, it will allocate entries
at pf->irq_tracker.entries and update pf->msix_entries for later use
(request_irq) by irdma.

On Tue, 28 May 2024 at 19:12, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Ricky,
>
>
> Thank you for your patch. Some minor nits. It=E2=80=99d be great if you m=
ade the
> summary about the action and not an issue description. Maybe:
>
> Avoid IRQ collision to fix init failure on ACPI S3 resume
>
> Am 28.05.24 um 12:03 schrieb Ricky Wu:
> > A bug in https://bugzilla.kernel.org/show_bug.cgi?id=3D218906 describes
> > that irdma would break and report hardware initialization failed after
> > suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).
> >
> > The problem is caused due to the collision between the irq numbers
> > requested in irdma and the irq numbers requested in other drivers
> > after suspend/resume.
> >
> > The irq numbers used by irdma are derived from ice's ice_pf->msix_entri=
es
> > which stores mappings between MSI-X index and Linux interrupt number.
> > It's supposed to be cleaned up when suspend and rebuilt in resume but
> > it's not, causing irdma using the old irq numbers stored in the old
> > ice_pf->msix_entries to request_irq() when resume. And eventually
> > collide with other drivers.
> >
> > This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
> > clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
> > irdma if we've dynamically allocated them). On Resume, we call
>
> resume
>
> > ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
> > MSI-X vectors if we would like to dynamically allocate them).
> >
> > Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
>
> Please add a Link: tag.
>
> If this was tested by somebody else, please also add a Tested-by: line.
>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index f60c022f7960..ec3cbadaa162 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
> >        */
> >       disabled =3D ice_service_task_stop(pf);
> >
> > -     ice_unplug_aux_dev(pf);
> > +     ice_deinit_rdma(pf);
> >
> >       /* Already suspended?, then there is nothing to do */
> >       if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
> > @@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
> >       if (ret)
> >               dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret=
);
> >
> > +     ret =3D ice_init_rdma(pf);
> > +     if (ret)
> > +             dev_err(dev, "Reinitialize RDMA during resume failed: %d\=
n", ret);
> > +
> >       clear_bit(ICE_DOWN, pf->state);
> >       /* Now perform PF reset and rebuild */
> >       reset_type =3D ICE_RESET_PFR;
>
> What effect does this have on resume time?
>
>
> Kind regards,
>
> Paul

