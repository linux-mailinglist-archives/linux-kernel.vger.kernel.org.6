Return-Path: <linux-kernel+bounces-413333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59D9D177F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE44B2834DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8851C1F1B;
	Mon, 18 Nov 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAI6wHU2"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07351D0DFE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952823; cv=none; b=Ma7971k0Z2WKLj2RKmNYPt1xSEe4y0h7Yp1tIw2mZ2hSHhOXUIpjpUQOueFPIKABkp/MIq8RJi3+yUXvRAEAnw/cZbXk/VG6WOAnssDNeGIHUIgor5/BLxIJIsMeRH0BMwC1PZNNR2a7CF0/xghJdco+Ma1zvJ3kS4QK4yCbjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952823; c=relaxed/simple;
	bh=QsjSrbMQadoK4kWwZoO09P1xz68z2hpgAaGO9d7ls5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWyvu6vP/42pNFz6P728cB1EiP63z16ii0RKrRtm+2Zqn8xP2A1iTYF+oBRwAKxHATfRXU/Wn9US0el08Qlv9iza+sNuAVHe1HFCSoSixCoqIDQ6lFuMUHkk9fTUWRerTW2J3IyKeope9AwxSgtEJwBaelvjQ82/o70zoPt8JQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAI6wHU2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1483288b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731952821; x=1732557621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paCLR7IijVyeUeVe8LL4hZL7nuFgS1QPO7Bsd6hORws=;
        b=XAI6wHU2stTL3lryYCFXJsQASRpddrNLAFT+QUZ+hdLoBL62jISNWh4MWQijOTX3MS
         lQ7ZsdCm7+W5ox2QVDmOxhDDi4pi5muHVyBFg1zVta/8kFtAwA6hbL6nBvuAv0lbGIBL
         x4u+4nC9HyIqFQT2F/+KiPv46Nx1IhETDd/9XezaOWNxzYBBe21BzjjPH68L5LOOuuMU
         4md3M+POizYuNBd0w23+Qpvl97XIPXqXBZ1uLnOBNTmhcgKbysx8BqcNjCQb2ZSBze86
         DSW2kwUZqH5jMzBY5Q79aG+x+VdRNcvqJHstv3L5WTHGj0w5T6wNW23XDJqtjSAtfng0
         sg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731952821; x=1732557621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paCLR7IijVyeUeVe8LL4hZL7nuFgS1QPO7Bsd6hORws=;
        b=kWVAxXdkrFHcM/FugawnxzKAJsw2VN7qplUwFuQg2EwyF/zOysv1217oEDwBpi0BZr
         9avznu2bLYrF5xhrlNE2PdRg8cUwI7rr+ydRGU10/TorobL2izpVx7diktM4+BPTz+bC
         gmS6dbId2wbc5LtK9dCxANzXEOMborq6it7PyUMhZMmaocauMD/Ti+94tqWhSjiECFKP
         bG1rlXWBVI1n4pQTFCRpgK+1JPu8YW8XlyjSYg6Il2DBtTJOfphX/rhzgbwYUZUFnJ8N
         sImBOZriowc/zFu+A1/2iCJjih6u8rGh5UCh0+b1MmIWjOvT0Cud0Zd5iog7k2ruU+Qa
         D0ew==
X-Forwarded-Encrypted: i=1; AJvYcCVJUDtmwxno95nelonSYhnAwnM+nH74DXyqm9gwywpc9iWGFydDcTUg+TpLxwVoasDlSmnEmlbNaMp+zAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHRp/poUw1Sc/LSdJpKtDVkJDJdMdTcyj1kOoTvLRhGnwxlXE
	onmvLC3mMJf+sgFTlffQnS/ko78Qg96bhoQd9PCxTQDU9jCON9tiwKAsv4kfMiQmevDLCPsOLH0
	9t7to7QN6XaXszcYgZ+X1c89u+bew8uzDadXW
X-Google-Smtp-Source: AGHT+IEvP+Hgm5H20x8pvUxEcKp1XAOvvO4NdK41CM3JBoEaSiwByV//WtdDkIh33mYoYd53GkX130MHcohV2iDxSxc=
X-Received: by 2002:a05:6a00:3a14:b0:71e:3b51:e850 with SMTP id
 d2e1a72fcca58-72476b72b0emr18120513b3a.2.1731952820747; Mon, 18 Nov 2024
 10:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709160013.634308-1-tadamsjr@google.com> <784f6b4a-7c43-4484-988e-73fad594c99d@oracle.com>
In-Reply-To: <784f6b4a-7c43-4484-988e-73fad594c99d@oracle.com>
From: TJ Adams <tadamsjr@google.com>
Date: Mon, 18 Nov 2024 10:00:09 -0800
Message-ID: <CAL54JgdupgdfeBQwETPv3jCh8iYROqA_DthLQ8cJf7Th1XSV_g@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: Remove msleep() loop from pm8001_dev_gone_notify()
To: John Garry <john.g.garry@oracle.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late response.

> > It's possible to end up in a state where pm8001_dev->running_req never
> > reaches zero.
>
> Is that a driver bug then?

I haven't seen this unless artificially creating the situation. This
is a preventative change rather than a response to a specific issue
seen.

> > In that state we will be sleeping forever.
> >
> > sas_execute_internal_abort_dev() can wait for a response for
> > up to 60 seconds (3 retries x 20 seconds). 60 seconds should be enough
> > for pm8001_dev->running_req to get to zero.

> May I suggest you drop running_req at some stage, and use other methods
> to find how many IOs are active?
I haven't given much thought about better ways to keep track of active
ios, so it will have to come later but definitely noted!

On Tue, Jul 9, 2024 at 9:09=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 09/07/2024 17:00, TJ Adams wrote:
> > From: Igor Pylypiv <ipylypiv@google.com>
> >
> > It's possible to end up in a state where pm8001_dev->running_req never
> > reaches zero.
>
> Is that a driver bug then?
>
> > In that state we will be sleeping forever.
> >
> > sas_execute_internal_abort_dev() can wait for a response for
> > up to 60 seconds (3 retries x 20 seconds). 60 seconds should be enough
> > for pm8001_dev->running_req to get to zero.
>
> May I suggest you drop running_req at some stage, and use other methods
> to find how many IOs are active?
>
> >
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > Signed-off-by: TJ Adams <tadamsjr@google.com>
> > ---
> >   drivers/scsi/pm8001/pm8001_sas.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8=
001_sas.c
> > index a5a31dfa4512..513e9a49838c 100644
> > --- a/drivers/scsi/pm8001/pm8001_sas.c
> > +++ b/drivers/scsi/pm8001/pm8001_sas.c
> > @@ -712,8 +712,11 @@ static void pm8001_dev_gone_notify(struct domain_d=
evice *dev)
> >               if (atomic_read(&pm8001_dev->running_req)) {
> >                       spin_unlock_irqrestore(&pm8001_ha->lock, flags);
> >                       sas_execute_internal_abort_dev(dev, 0, NULL);
> > -                     while (atomic_read(&pm8001_dev->running_req))
> > -                             msleep(20);
> > +                     if (atomic_read(&pm8001_dev->running_req)) {
> > +                             pm8001_dbg(pm8001_ha, FAIL,
> > +                                        "device_id: %u: Failed to abor=
t %d requests!\n",
> > +                                        device_id, atomic_read(&pm8001=
_dev->running_req));
> > +                     }
> >                       spin_lock_irqsave(&pm8001_ha->lock, flags);
> >               }
> >               PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
>

