Return-Path: <linux-kernel+bounces-370274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4389A2A36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364D62820A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105751F4720;
	Thu, 17 Oct 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXkTu4E2"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C981EF936
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184307; cv=none; b=gqAIaG4qxGMI7OBw+IMVGckVwpQH0uiq8iBeh/bx4nSq6KvvDtjHJDxO3YEjEJtIb2NL9jF/TwNbV0KLnDOS7gFbGd05W7K0Np+UsBF3ED5lxfmLDsGpEc8q1jgtvkk6+TTbyTWhGyaoVINV3PMT9sHb42L2ubcYj7h5a5dUk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184307; c=relaxed/simple;
	bh=ybHhA5/R7pbdbj45UZ3zkxXyZMiIBdZSFEF4YHrgap8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egxbXyY718l0zQAfE8b+pgqx9U1Ml9pdRiyVBoxGlgDVTlAvpo8UJP7nmYLvpm8fxQo4IigGt423DjRg13It8dzDBn8blYms8zl3UlDJ3KsAHxYPi9/CEqDebqggi0srPtbykAdrKcl97+YDOj6aRFFk71wkh6BlBwAa5+Wg1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXkTu4E2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so10531cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729184301; x=1729789101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZAuyvgP7Mex+OXNMQOiLN+FLzq1Ru9ajNrmNmE+0Cs=;
        b=xXkTu4E2S70AKa0A2E9A8v/q26G6g1Bcxo+EfZuxT2hpbTdUoyjvF1v09U+ve2aRUK
         ikMSGkCxaGFe9LWSGmGxXj6R4DZs1QSEOhKYoxkAV8Q+66Hkl/gSxFBr5Xc/U7aVECw0
         LGxBfypVM5S1Mv/dkEI29a21M+5m/zcaEtgQvM/DBi+Cxjd3xNcc1OGSdkeRDjdZG8z7
         a8DDesPlqHT+FZ1Jb9iVxfEMmjmVNz9cLXgux3nBWnuT41WENHGWZnsV6WD7qO9SdTVf
         hdKYCGLU4qCngS0KQ6hewnVzQ7rARz8HVKuzVDu2f9ur9XHY+PJnbV6KTrQELpahL+Pc
         KBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184301; x=1729789101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZAuyvgP7Mex+OXNMQOiLN+FLzq1Ru9ajNrmNmE+0Cs=;
        b=H5jDY1Q0ujyHbpMNCAZ5/xD/+w9cR30Trntifc4A0opFfkBXqK+Jjuy/Yis8/v/kVF
         Kl+ZAy3bayu6VTa+qckSPao2KOXJcpky6jaTAlq2esUijaRhhVPzxsxrWfj9hjpqte/4
         7pvRS2YBZ0tzj8RWtrp369Fs4wwk8sw9FkvNNsW2BobdIWlUpzOgZehRtGBuYbTtuyYA
         zdQNYgytDSY55MSwnt+VxcXHkcLbxU37vHbQrQyweC59V/dg9yGzh5LTPwONhWJeAAFN
         y9mmfnwKRDB63D/JwH0YWtjDmEMmhs7sr0ZCTNgOh1YziwQduwjEY+HlydbLBmVRQAdG
         B9tA==
X-Forwarded-Encrypted: i=1; AJvYcCV0bQ7glsJQubDeGo5tQVP+8fq5U15oUQynVLHBGO6YQeHTni1MnNMEtEUd0/0JCZV7wT30hBZDBLOsNI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGzyY2K9YtAg5rlwjC6ErWuWxK9FNQq37m0w4IGivQ9wQPv7X
	16mxlycM4jOy5JaSOFg3H8sJTz5aeEZXvzbWMXgIOgrBfufLSkYDYjHWbdLHurS7lAevw8Kl1Kj
	oqV58A2r8iFwygz4bfVL0u55PCkarjHK/IzKq
X-Google-Smtp-Source: AGHT+IHfBZeQIa7ROJrJ7k/xkA9z0KhNnu9hZirf3xo7+oJZYUkRAFCzIM5kFIuF81OI4I4P86ABcKSVB+ao/9rVsKM=
X-Received: by 2002:a05:622a:5b0f:b0:460:44ee:9e6a with SMTP id
 d75a77b69052e-4609bfd7787mr4184611cf.0.1729184301134; Thu, 17 Oct 2024
 09:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016220944.370539-1-salomondush@google.com> <CAMGffEmEJp_oVAsbCVV9PKs7vOKWLrUhRGcBGoUSx7+t4ZtsQA@mail.gmail.com>
In-Reply-To: <CAMGffEmEJp_oVAsbCVV9PKs7vOKWLrUhRGcBGoUSx7+t4ZtsQA@mail.gmail.com>
From: Salomon Dushimirimana <salomondush@google.com>
Date: Thu, 17 Oct 2024 12:58:10 -0400
Message-ID: <CAPE3x15ryZw4s=qA=7HSDyZZXf3FUz2Ms7cxXHjc_R+UbPZTwA@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: Use module param to set pcs event log severity
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bhavesh Jashnani <bjashnani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

3 works well for Google, but a different value might be better for
others. Having a module parameter would allow users to customize the
level of logging based on their specific needs. If that is not a
concern, I can change the default to just 3.

Thank you!

Salomon Dushimirimana


On Thu, Oct 17, 2024 at 2:45=E2=80=AFAM Jinpu Wang <jinpu.wang@ionos.com> w=
rote:
>
> Hi,
>
> On Thu, Oct 17, 2024 at 12:10=E2=80=AFAM Salomon Dushimirimana
> <salomondush@google.com> wrote:
> >
> > The pm8006 driver sets pcs event log threshold very high which causes
> > most of the FW logs to not be captured. This adds a module parameter to
> > configure pcs event log severity with 3 (medium severity) as the
> > default.
> upstream does not like more module parameters, can we just change the
> default to 3, any harm?
>
> Thx!
> >
> > Signed-off-by: Bhavesh Jashnani <bjashnani@google.com>
> > Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
> > ---
> >  drivers/scsi/pm8001/pm8001_init.c | 4 ++++
> >  drivers/scsi/pm8001/pm8001_sas.h  | 2 ++
> >  drivers/scsi/pm8001/pm80xx_hwi.c  | 3 ++-
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm=
8001_init.c
> > index 1e63cb6cd8e3..355aab0c982a 100644
> > --- a/drivers/scsi/pm8001/pm8001_init.c
> > +++ b/drivers/scsi/pm8001/pm8001_init.c
> > @@ -68,6 +68,10 @@ static bool pm8001_read_wwn =3D true;
> >  module_param_named(read_wwn, pm8001_read_wwn, bool, 0444);
> >  MODULE_PARM_DESC(zoned, "Get WWN from the controller. Default: true");
> >
> > +uint pcs_event_log_severity =3D 0x03;
> > +module_param(pcs_event_log_severity, int, 0644);
> > +MODULE_PARM_DESC(pcs_event_log_severity, "PCS event log severity level=
");
> > +
> >  static struct scsi_transport_template *pm8001_stt;
> >  static int pm8001_init_ccb_tag(struct pm8001_hba_info *);
> >
> > diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8=
001_sas.h
> > index ced6721380a8..42c7b3f7afbf 100644
> > --- a/drivers/scsi/pm8001/pm8001_sas.h
> > +++ b/drivers/scsi/pm8001/pm8001_sas.h
> > @@ -96,6 +96,8 @@ extern struct list_head hba_list;
> >  extern const struct pm8001_dispatch pm8001_8001_dispatch;
> >  extern const struct pm8001_dispatch pm8001_80xx_dispatch;
> >
> > +extern uint pcs_event_log_severity;
> > +
> >  struct pm8001_hba_info;
> >  struct pm8001_ccb_info;
> >  struct pm8001_device;
> > diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm8=
0xx_hwi.c
> > index 8fe886dc5e47..9b237a764d0b 100644
> > --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> > +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> > @@ -763,7 +763,8 @@ static void init_default_table_values(struct pm8001=
_hba_info *pm8001_ha)
> >                 pm8001_ha->memoryMap.region[IOP].phys_addr_lo;
> >         pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_size          =
 =3D
> >                                                         PM8001_EVENT_LO=
G_SIZE;
> > -       pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity      =
 =3D 0x01;
> > +       pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity      =
 =3D
> > +               pcs_event_log_severity;
> >         pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt         =
 =3D 0x01;
> >
> >         /* Enable higher IQs and OQs, 32 to 63, bit 16 */
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >

