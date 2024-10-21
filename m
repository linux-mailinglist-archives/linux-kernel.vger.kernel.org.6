Return-Path: <linux-kernel+bounces-374589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32189A6C83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A9282A33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD71FA24B;
	Mon, 21 Oct 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="edXrrwmQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91D1E7C34
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521990; cv=none; b=ZGSrimgb8yAGR0Tf4vlnXIzcGPP1oQxErOxL4/YBsIa2pFeYsdh9VFC5O0faNzJBotKezz9sJhSPxgW38xwWf6osO3iY6ZFHPNKMDfDHBj8TZ2pA0yIvseafGYjnjA+L8/DLU92rPKA1G5F8l8mv5bYGDdTPDaaQEZKtx1jVfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521990; c=relaxed/simple;
	bh=ET2SqcFOVyWL1ZMQR047EaDNP6wWKMmrRf9/K7m2/Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0F+0YQ03peMPEPwW9/19PZd4n9bwWQYP+Sz1Zpjlxh2s7QlY6YLn+/rdMU72TpiiTNrKCb0KOh8OUxazUzXFhO9Sh24JOM7kvsUJ+zIsFCnpJ2uAzUubfGng9bK+55+XBRaXSvgKoqypIfk/eSVXJePHmwT2vNa4k4bqJGu2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=edXrrwmQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f53973fdso3598014e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729521985; x=1730126785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdcnb8e+gAkVMVmccz9fiNE3PWRs3Kz7gMuReYmqkSU=;
        b=edXrrwmQPP5N/L2bq9ZNLvzcUNt6sJQMFtxaP7vegQgIHdmST8S4Dj8c5JtD6VGjsZ
         olg2cS2n3TEg1gcLb5m4YJ3vhmi3oUru0FatgYaJP/REZ+lQs6d15AZ+PTnVxth59mvm
         qLe9y9dtUh7aB7CDfAkQJ4NdmWrmEGBg6LRFCg0JAfhyiQ/Qu4F4vWOn6THPMZCiAA5P
         KCuvKFOjDaBqmV8ZRvw7jvOk8QFJflqNvdabMHuxePiW9AVK1DSddm3rOrtZqTfdid8F
         E7LgsQ9+eVt++iFiQhLS6Kmug7Mke0vLYUXPNu0hJuziIN40LS67Hk7fEg+WSj0fjiD7
         69Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521985; x=1730126785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdcnb8e+gAkVMVmccz9fiNE3PWRs3Kz7gMuReYmqkSU=;
        b=tTTci6aovAW890ERNYR8gDTMr0tqdM6ag4Pk/FM0iYr6N9EjjJTg2SqpXCzBSVraNU
         lC9R4Jh+87DXQXYPDw8rVlmRYSYdSkTgPSXv8jby9yMWJBsUx1Z7R7xfs+z69uXGSJI+
         qoi7HRU3qGUT7zStfohHP13F/F8sG6+IRVEORguh5BpWUfmCYnBYB3CGx1neAERFnXxK
         DvDBIy/unmdl42BKC3fVaJ8R9/RasGAbKo99t6cVfLSnkkGVn9za1oKwARVvC55ZN7/u
         pGcicQ0YbirNIK01TQD4fpPbVhNw57Z8Z/LcrjUfg7Yr64C0Emy9VMX/rvf/do3At0as
         QkCw==
X-Forwarded-Encrypted: i=1; AJvYcCUltl+41mHSCQCmXocC810eZ8srwHWNidRRC3+lsqGVnfBiRUq9+PhJUqkgo10kWTimlyQEdcymMFd1qqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvifbR/60tKb1al+r+geuw9fUjC/OzVwioDWEyRE/N8HgkSQ3
	zlp+cuRZqyhLO4SSjHvzhyDQnmgptbDiePE3FdoOfeuIixJPPnFeGh2R42OY7vBAjqkluiwcPd4
	EPjjBonRnlwsEaFcIQy1d7VDGrXuPmMN3c7F2
X-Google-Smtp-Source: AGHT+IHf+afc+3dWOGjqHiHk7wI602WMKF/U5GM48Chg/0UeTO2DN7TWOG/oDA2tQT92u65DlKFaHyV+8qxw8jlm9XY=
X-Received: by 2002:a05:6512:110f:b0:52f:27e:a82e with SMTP id
 2adb3069b0e04-53a15b8332fmr3505306e87.21.1729521985432; Mon, 21 Oct 2024
 07:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012150710.261767-1-devarsht@ti.com> <20241012150710.261767-2-devarsht@ti.com>
 <3d85ac05-150b-4917-a374-5974d376e416@ideasonboard.com>
In-Reply-To: <3d85ac05-150b-4917-a374-5974d376e416@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 10:46:12 -0400
Message-ID: <CADL8D3ZiGA+XnyvyFCQbcK_SCffrfbhMXFpWzxWVjhuOFeu-Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/tidss: Clear the interrupt status for interrupts
 being disabled
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, jyri.sarha@iki.fi, airlied@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, simona@ffwll.ch, 
	linux-kernel@vger.kernel.org, praneeth@ti.com, vigneshr@ti.com, 
	aradhya.bhatia@linux.dev, s-jain1@ti.com, r-donadkar@ti.com, sam@ravnborg.org, 
	bparrot@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding the e2e thread that has instigated this change.

https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1=
394222/am625-issue-about-tidss-rcu_preempt-self-detected-stall-on-cpu?pifra=
gment-323307=3D1#pifragment-323307=3D2

Summary of original problem: An AM62x device using the TIDSS driver,
can lock up after hours of running.  The lock ups are often detected
by the rcu_preempt system.  The lock ups turned out to be caused by an
infinite interrupt loop (irq storm?) in the TIDSS_DISPC driver.

The k3_clear_irqstatus function which is responsible for clearing the
interrupt bits, only clear the the level 1 interrupts if the level 2
ones are set.  This leaves a small window where if for whatever reason
the level 2 interrupts aren't set but the level 1's are, then we will
never clear the level 1 interrupt.

The change as submitted is not sufficient to prevent the irq storm.
I've tested these two patches for several weeks now and they reduce
the frequency of the irq storm from once a day to once every few days,
but don't prevent it.

I suggest that the k3_clear_irqstatus function needs to be updated
such that it's not possible for the level 1 DISPC_IRQSTATUS bit to
remain uncleared.

The following hack proposed by Bin and team removes the possibility of
the irq storm happening, while introducing a small chance of clearing
interrupts that weren't intended.  Though I would assume that if the
level 2 interrupts aren't cleared, they would reassert the level 1
DISPC_IRQSTATUS so maybe that's not much of a risk.  Most other
drivers when clearing interrupts do a read and then write to clear
interrupts so there is precedence.

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c
b/drivers/gpu/drm/tidss/tidss_dispc.c
index 60f69be36692..0b8a3d999c54 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -900,27 +900,27 @@ static
 void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t
clearmask)
 {
     unsigned int i;
-    u32 top_clear =3D 0;

     for (i =3D 0; i < dispc->feat->num_vps; ++i) {
         if (clearmask & DSS_IRQ_VP_MASK(i)) {
             dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
-            top_clear |=3D BIT(i);
         }
     }
+
     for (i =3D 0; i < dispc->feat->num_planes; ++i) {
         if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
             dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
-            top_clear |=3D BIT(4 + i);
         }
     }
+
     if (dispc->feat->subrev =3D=3D DISPC_K2G)
         return;

-    dispc_write(dispc, DISPC_IRQSTATUS, top_clear);
-
-    /* Flush posted writes */
-    dispc_read(dispc, DISPC_IRQSTATUS);
+    /* Always clear the level 1 irqstatus (DISPC_IRQSTATUS) unconditionall=
y
Note I'm not sure we are confident in the reasoning outlined in this commen=
t
+     * due to an IP bug where level 1 irq status (DISPC_IRQSTATUS)
would get set delayed even
+     * after level 2 interrupt (DISPC_VID_IRQSTATUS,
DISPC_VP_IRQSTATUS) is cleared.
+     */
+    dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQSTATUS)=
);

I had proposed a more complete version of this patch but there hasn't
been much discussion about it and I've mostly tested Bins version.

 }


On Mon, Oct 21, 2024 at 7:15=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 12/10/2024 18:07, Devarsh Thakkar wrote:
> > It is possible that dispc_{k2g/k3}_set_irqenable can be called for
> > disabling some interrupt events which were previously enabled. However
> > instead of clearing any pending events for the interrupt events that ar=
e
> > required to be disabled, it was instead clearing the new interrupt even=
ts
> > which were not even enabled.
>
> That's on purpose. When we enable a new interrupt, we want to first
> clear the irqstatus for that interrupt to make sure there's no old
> status left lying around. If I'm not mistaken, enabling an interrupt
> with an irqstatus bit set will immediately trigger the interrupt.
>
> > For e.g. While disabling the vsync events, dispc_k3_set_irqenable tries=
 to
> > clear DSS_IRQ_DEVICE_OCP_ERR which was not enabled per the old_mask at =
all
> > as shown below :
> >
> > "dispc_k3_set_irqenable : irqenabled - mask =3D 91, old =3D f0, clr =3D=
 1" where
> > clr =3D (mask ^ old_mask) & old_mask
>
> That's a bit odd... Why was the DSS_IRQ_DEVICE_OCP_ERR not already
> enabled? It is enabled in the tidss_irq_install().
>
> Or maybe it had been enabled by the driver, but as the HW doesn't
> support that bit, it reads always as 0. I have an unsent patch to drop
> DSS_IRQ_DEVICE_OCP_ERR.
>
> > This corrects the bit mask to make sure that it always clears any pendi=
ng
> > interrupt events that are requested to be disabled before disabling the=
m
> > actually.
>
> I think the point here makes sense: if we disable interrupts with
> dispc_set_irqenable(), we don't want to see interrupt handling for the
> disabled interrupts after the call.
>
> However, if you clear the irqstatus for an interrupt that will be
> disabled, but clear it _before_ disabling the interrupt, the interrupt
> might trigger right after clearing the irqstatus but before disabling it.
>
>   Tomi
>
> > Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Di=
splay SubSystem")
> > Reported-by: Jonathan Cormier <jcormier@criticallink.com>
> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> > ---
> >   drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tids=
s/tidss_dispc.c
> > index 1ad711f8d2a8..b04419b24863 100644
> > --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> > +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> > @@ -700,8 +700,8 @@ void dispc_k2g_set_irqenable(struct dispc_device *d=
ispc, dispc_irq_t mask)
> >   {
> >       dispc_irq_t old_mask =3D dispc_k2g_read_irqenable(dispc);
> >
> > -     /* clear the irqstatus for newly enabled irqs */
> > -     dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & mask);
> > +     /* clear the irqstatus for irqs that are being disabled now */
> > +     dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & old_mask);
> >
> >       dispc_k2g_vp_set_irqenable(dispc, 0, mask);
> >       dispc_k2g_vid_set_irqenable(dispc, 0, mask);
> > @@ -843,8 +843,8 @@ static void dispc_k3_set_irqenable(struct dispc_dev=
ice *dispc,
> >
> >       old_mask =3D dispc_k3_read_irqenable(dispc);
> >
> > -     /* clear the irqstatus for newly enabled irqs */
> > -     dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & mask);
> > +     /* clear the irqstatus for irqs that are being disabled now */
> > +     dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & old_mask);
> >
> >       for (i =3D 0; i < dispc->feat->num_vps; ++i) {
> >               dispc_k3_vp_set_irqenable(dispc, i, mask);
>


--
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

