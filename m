Return-Path: <linux-kernel+bounces-304905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70324962680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02781C215A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3F172BA8;
	Wed, 28 Aug 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i62L/Kzi"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDA166F37
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846645; cv=none; b=axA7JCyY8zr0O47jHA8U3Wrq7Q4zVQjSai/eqdtCbTpLkwj4SopuSBA2RPYXeTCWMvk5hwd+Fn6dqpH1GmkVXgDADcIlh8PQz7y9lPvuyZFTORuxm16ewqcYVgAePH8sWzj6HIYiUruMYjE9np17K5RPSMvhmhC6lzVDgU01ZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846645; c=relaxed/simple;
	bh=ipqJ60XxY2Y88OgHO3NKkVnWMl8i2LM+m2jKY6Xjv6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+qH2uPIJXWVZlHnormJdti+VVClVU0A5si2f9MxfuAw0iko4/0NTEDRZ2WzJuhFATyVApsP4pchOlYlyL1G5m4fz7hHI5yK2eeLvRmUOB9q2l8Y5pZnifMOuYfTLsw9jpejBk6680ueXqzhzTs7wgpaz+OC5kZHYnkv6skpweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i62L/Kzi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso403081a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846643; x=1725451443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdcnjVgF8yb/N7ua+ROvl3/+kpGiPAKNxPZFFKZQDrk=;
        b=i62L/KziYfbBBIRpUR7FaVPF0Tl0L7H8LYkUIsdKIrZNf+RdZbxSLyvwqdUHDrjDdJ
         +CDbaTLZnzM+hXd3BWyr6/AhCqOq3D4fPMQ2gRuJeP7e9AgqwX5s6OVYzPzgMJxrYRi2
         OZc0UdhDiWzySjdMGxE1mdQqWBCWNPckG3Q6yLwODZ4tKxKqvG3lGQT1Aqs0R+aQf8ZK
         vMbbkgZdeXADg4iQJL8+5cUBiyC7WIblqPyxyUrXTrb+UmvthlT9/HkS10BigwWQ1bYG
         7nOBlnqTHm89H22ZJzySB4kZdiF3nS55Kn0ARi/fAhWiooJevzA0LQBihapCAgpgD7Jg
         zHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846643; x=1725451443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdcnjVgF8yb/N7ua+ROvl3/+kpGiPAKNxPZFFKZQDrk=;
        b=oqcgg6VP4FNLy1oaaLsYZFHIjHxSCQTJYgUE0hW2urMXW7PHeOu8wfiGPGhMElGWEY
         sGXrzJ2Nqz1RTrJVemcQSLWuw5mNmwCg3gX3mu4rvcmepup3D0rx1TgcpjBvrQeny9lX
         exjsKKyewShKuPuHD59ab0lQmgTRox3Oq+bRVDN1gUwx4nWLhSDS5UGvPAp+VGA1H8zQ
         2NfhmqsnVWFTaq4uhHMEDyr007Lvfq+aashRE3EtFM8fjLh1Is+lRxr7h7KCPBrDxlml
         /UO89wqdrnfAJfqQV1KbQ5OP54gDgH/nYqrjhMgJiQiDVoCy5wKf7HjIVDVy6oKcVVIV
         nzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYrGL8VJXPaon5fFHS+zd09i5R8l3jIfuBdlhvZN6jG6flKCO+OQxbhTUGY7vi2T95hKgpGA+7iELbrlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8dMerGF6QZgWda7RcZ6qHG5i97jRZdgEa3aGbkF3mQI4+r8V
	le/PfY7rVmSD6uk0tonMOKBP3cLN20XjgUX3i8JeLshjvYJ3/Lu5IlxEHRK3POIfZAnSLwk8yWP
	jerIOM59NKscN8N6yA9Glw5v+DPDyEAAA
X-Google-Smtp-Source: AGHT+IHcumZEfE9db9FF97yVvyhpVT1EUbVle6yVWXa1JPCNXd1id/6gneCtY+FPC9fmcjcA/VWiAhUDGr9urxwFoEM=
X-Received: by 2002:a17:90a:a004:b0:2c9:35a6:e185 with SMTP id
 98e67ed59e1d1-2d8439f8059mr3005493a91.0.1724846643092; Wed, 28 Aug 2024
 05:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827095550.675018-1-wenst@chromium.org> <20240827095550.675018-9-wenst@chromium.org>
 <e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com> <CAGXv+5EcHQ7E979fKPEci2qwXBnKPfVHc_aB02amUbdVB3KTxg@mail.gmail.com>
In-Reply-To: <CAGXv+5EcHQ7E979fKPEci2qwXBnKPfVHc_aB02amUbdVB3KTxg@mail.gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 28 Aug 2024 15:03:51 +0300
Message-ID: <CANhJrGPiPUfq-3W_oLypEncreX3KTKyEkxouWDG6pZ47a_veAQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ke 28. elok. 2024 klo 10.53 Chen-Yu Tsai (wenst@chromium.org) kirjoitti:
>
> On Wed, Aug 28, 2024 at 1:55=E2=80=AFPM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> >
> > On 8/27/24 12:55, Chen-Yu Tsai wrote:
> > > kernel-doc complains about missing "Return" section for the function
> > > regulator_irq_map_event_simple().
> > >
> > > Add a "Return" section for it based on its behavior.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Thank You for improving this! I appreciate it :)
> >
> > > ---
> > >   drivers/regulator/irq_helpers.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_=
helpers.c
> > > index 5ab1a0befe12..5803ef016b7d 100644
> > > --- a/drivers/regulator/irq_helpers.c
> > > +++ b/drivers/regulator/irq_helpers.c
> > > @@ -414,6 +414,10 @@ EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
> > >    * notification helperk. Exactly one rdev and exactly one error (in
> >
> > I just noticed (an existing) typo "helperk". I wonder if it was Ok to
> > fix it while anyways changing the doc. It's not strictly speaking
> > related to the return values though :)
>
> Why not? Only the kerneldoc this function is touched. It looks like the
> 'k' belongs to the "callbac" on the previous line.

Right. It'd be nice if you fixed the typo as well if you for some
reason re-spin this.

> > >    * "common_errs"-field) can be given at IRQ helper registration for
> > >    * regulator_irq_map_event_simple() to be viable.
> > > + *
> > > + * Return: 0
> > > + *
> > Anyways, I agree with Andy about not needing the blank line here - but
>
> I disagree because of the formatting result. See my other reply.

Fair enough. The "errors" or "notifications" indeed don't tell if this
specific function has failed.
So, if you feel the @rid is not documented well enough, maybe add a note in=
 the
respective parameter documentation instead of leaving it alone at the
bottom of the doc?

Well, I don't have a strong opinion on this so you can keep the RB tag
also with the blank line.

Yours,
  -- Matti

