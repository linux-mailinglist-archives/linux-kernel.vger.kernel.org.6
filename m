Return-Path: <linux-kernel+bounces-549526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C1A5538C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114B01758AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFD25C6E6;
	Thu,  6 Mar 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FhXbOlJk"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E925C708
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283640; cv=none; b=q2Zrn6nAhpCGXQInJAIgCqvgpGcpKk9AXE9fKkMe/CDQmgEFrlsen2zWhkY+MLoPObGTBHzj+W1oYDkIs28IuPtclVK80V/Q3EKDJCzkAVrDMMtAnGDwk6zHHevld7eS+noUU48485O+b4XcYVQTQ4wH6YpHeQBMi6mwz8d7fxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283640; c=relaxed/simple;
	bh=VcmDipHwuj8PgRhQ4UBe7gUhRK502GziUS3SiEtvIAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IappOdSNhWBa6bZqNH6ZCDqIeGVZA7jTnFXxAJ2MA0G688n2EzCjTE9mHj1kBK63MMfmGaXcLlidrr72D3hDxTlwrzc/7AvFUpoRihMcFrKbXhL1N3OhSj+F+OXMfTNG08HNCdcVOcxcgDl+F8TD9kOOsQf/oS76T4dRyr6Dr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FhXbOlJk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54959d1a856so2630445e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741283633; x=1741888433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcmDipHwuj8PgRhQ4UBe7gUhRK502GziUS3SiEtvIAg=;
        b=FhXbOlJkaGqHLAxHA/n8S7KSyIcFRnoigqKNOYYcXYYHgHTah7VB2OV6qX15HPwpRr
         k+KXbr1AfmxJHGiCzlbqPKv4y+XtSN2SgVsZb5/YEnbXBRjW+1L4501ZQU675CfJUVQ2
         Ot4HCaYF2tXleKJ6vpqfR1PBoAYoNEZlpNH1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283633; x=1741888433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcmDipHwuj8PgRhQ4UBe7gUhRK502GziUS3SiEtvIAg=;
        b=kGprXWtlnlgyoYAl0mTPVAu20RFOh7kZx55KpA737dhQJar8gUkP2P9d7wGQSYUnNK
         MtWwwsB53N0vStiZHDPrdisAmG5NnAU1B1LeZqEIOwHJQFa9FJk/et+BqramQxhcQnNV
         MyivkWH1X81XIppqgmr0vwqpqAojaKKXeDbJRn7a+YkpkK8LfBn+4TEMg0HvV5rIkj0A
         oRieLfT/EgmGlSvq97gepEiexswDFAJ6u9zofzCdmYHSmtRmj90HWpT6pxpT3m92D3ho
         4zIz2p2SDKSr9I9JKrhm79V9ExCc5rtAbTw+DFf1iIC0q4b6YSiNsXTyFj6Ql8sgt6Hb
         z0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjrg1oTfM6dJQBtnRyggKF20mtNnTLkKzImRdHobmw/Wg+xSO8nw6KO44+vF1zrci5kL1of0yRuVbh4fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/AfLSCEEnbERaFZjNfhIGCmddDFQreAFQDC9QXF++tH6TSff
	Qlyuyf+vVbbHkrcldHKFLniDxkY7FP08XodV9ugfsN/9LlrYi0RY3i9cQD/jmkKYoFwtUCpAWTk
	gc/rA
X-Gm-Gg: ASbGnctXpmZYLTP2gwqdPaR4NjGqiAX20WN1Gw6Q6HFN9/UIcFcimPYKcG5LknmVdkK
	yd9Vp395p83jYXkqrAabZe2KjKIAyXopvGbwJgmV2p+88l4OaCi9teFMfKYZKoFyJ+XuKeYBJAe
	NXRjr6V/Lh1aDgNwaQlPUj6WrCfTET/ZUVWn/LS4g4+eNoTl8PG5lZtq4Dm48xemB+cGOdZzlsJ
	FCYbsPVNcJQVhUQgqJaBgTf9KvlFG+bOeqpSvPE5d1VLcfjNhRigwj7i1RDchRyoB4uWIrVjLUG
	93REVjCTaDD9vLadW+vVYbj+XSy9K+0YMdKKavzKvfjBGnl2TFyNCD0I6lYXpIhTLOjTY3Ejnon
	0j0vUTckVYjlt
X-Google-Smtp-Source: AGHT+IGE/qpOq1hMT9YtTX7SEzMNKSZR2HbDjXZ4YIJmBDGxaKyURHPa3NsnbIHw/3xzDW75u9i6Wg==
X-Received: by 2002:ac2:48a3:0:b0:549:8c0c:ea15 with SMTP id 2adb3069b0e04-5498c0cec7emr1016881e87.0.1741283633267;
        Thu, 06 Mar 2025 09:53:53 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498fc0ac2asm54739e87.192.2025.03.06.09.53.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:53:52 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307c13298eeso11618551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:53:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQiySX4KR2sM3zmceTzCcvZXLFPxkOPU0x61oGN6LoBdcs0GJkWtnYom9dpNp43FmbCwisScuo0sfKKxw=@vger.kernel.org
X-Received: by 2002:a2e:9187:0:b0:30b:f0fd:5136 with SMTP id
 38308e7fff4ca-30bf0fd5290mr6793931fa.18.1741283631322; Thu, 06 Mar 2025
 09:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
 <20250306-clever-lime-tanuki-e2fc43@houat> <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
 <20250306-brave-wonderful-sambar-3d0bc5@houat>
In-Reply-To: <20250306-brave-wonderful-sambar-3d0bc5@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Mar 2025 09:53:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZJjNpzUgvGog0pFGwqUR09SocYFEk5355eptbK_gjqA@mail.gmail.com>
X-Gm-Features: AQ5f1JrRJDiXo61n02Hjt29_oRyhxwMEG-u37b6Vvo-aWJLulx2MO1UpXmYjZko
Message-ID: <CAD=FV=XZJjNpzUgvGog0pFGwqUR09SocYFEk5355eptbK_gjqA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
To: Maxime Ripard <mripard@kernel.org>
Cc: Anusha Srivatsa <asrivats@redhat.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025 at 9:20=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> On Thu, Mar 06, 2025 at 10:08:24AM -0500, Anusha Srivatsa wrote:
> > On Thu, Mar 6, 2025 at 4:31=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> >
> > > Hi Anusha,
> > >
> > > On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
> > > > Move away from using deprecated API and use _multi
> > > > variants if available. Use mipi_dsi_msleep()
> > > > and mipi_dsi_usleep_range() instead of msleep()
> > > > and usleep_range() respectively.
> > > >
> > > > Used Coccinelle to find the multiple occurences.
> > > > SmPl patch:
> > > > @rule@
> > > > identifier dsi_var;
> > > > identifier r;
> > > > identifier func;
> > > > type t;
> > > > position p;
> > > > expression dsi_device;
> > > > expression list es;
> > > > @@
> > > > t func(...) {
> > > > ...
> > > > struct mipi_dsi_device *dsi_var =3D dsi_device;
> > > > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> > > > <+...
> > > > (
> > > > -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
> > > > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> > > > |
> > > > -mipi_dsi_generic_write_seq(dsi_var,es)@p;
> > > > +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
> > > > |
> > > > -mipi_dsi_generic_write(dsi_var,es)@p;
> > > > +mipi_dsi_generic_write_multi(&dsi_ctx,es);
> > > > |
> > > > -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> > > > +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> > > > |
> > > > ....rest of API
> > > > ..
> > > > )
> > > > -if(r < 0) {
> > > > -...
> > > > -}
> > > > ...+>
> > >
> > > The point of sending a single patch was to review the coccinelle scri=
pt,
> > > so you must put the entire script you used here.
> >
> > I was actually thinking of sending patches per driver this time around
> > since Tejas also seems to be looking into similar parts....Thoughts?
>
> Not really?
>
> The point of doing it with one driver was to make sure the coccinelle
> script was fine before rolling it to other drivers. And actually, it
> doesn't really matter: the whole point of putting the script in the
> commit log is to be able to review and document the script you used. If
> you're not going to put the one you used, it's kind of pointless.

Personally, I don't have any interest in reviewing the coccinelle
script so I don't need it and, from my point of view, you could just
remove it from the patch description (or point to it indirectly or
something). I'll review each patch on its own merits. I am a bit
curious if you ended up fully generating this patch with a coccinelle
script or if you used a coccinelle script to start and then had to
manually tweak the patch after. Actually, I guess I'll take it back.
If you manage to fully generate conversions for all the panels with a
single cocinelle script, I would love to take a glance at your full
script just to satisfy my curiosity for how you handled everything
properly. :-P

-Doug

