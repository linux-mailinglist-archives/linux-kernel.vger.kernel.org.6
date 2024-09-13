Return-Path: <linux-kernel+bounces-327709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81334977A21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB5D1C25319
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795791D589D;
	Fri, 13 Sep 2024 07:43:31 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC391D54C5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213411; cv=none; b=HrXDQ9utcQ66gz8QDyo54/16azNBE146mRXVn+D5UvdX6WNyJYi43ZN4b3bzzAOSQqGragz8xnktIiAet3ZNf28CpeYbGfIqVtkXGUy+11Qc3LDB2s2Mv6CKftlfIORAhjaUKbDPnG4uwpCanXrcVTO6zCjgjzU0Q3Oxxj+QKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213411; c=relaxed/simple;
	bh=yhmuZNYq1MmF/ZYy4MTPzdt4rwr5KfY+aAE6ylA/6kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzi7U1Xo5DVuGDDcdCBFA11R2Zj5jYxIoH+HIZAr2EnSU23s2GM0mqQnlHJNAFumPxKEOGgYE+uqvQF8tdadme989ZKpzvp7kQ3sd8qwKmPWpfCXy0vD2slSpLH452J8paa4MjmFyFpI58IIac4lVdUbccLF5nXW1EjV7OqXZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso1820829276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726213407; x=1726818207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uob8wHcFsSqO1Ywd9b+SmTX4fajQu+yvDZdClendtRg=;
        b=DF0waJCjIShZ/qccP9ys/AzRZCFtg/iYAqNvo+SATCd/vWt92/FfgHcqeKGq/1SR2t
         OY1Iwzoi8oKTHbPMmk1ebepQoOPANNQOCsP7biW3yRpFHGyHfriqFVwaqUG0iqfPlFYv
         AV4X9kobITk0x8fhCYSlA+S9qX2yttsoz2ST+S2IzWf8Bs8FVnaYLzxQuvNlR1UByLdN
         B/7S+3Zyk8+az2Be/N4fFC/6ZLXPK+Gp1jyQQMP8xdZPs3z+qmA0600hlS8UcIAAGm2p
         3OcUHjmAIshZ++083QInd2Nbm5we8wVzFhqRRSAB6uR9wsCzVL9UHSC9kWkHJU1hsnZg
         nxGg==
X-Forwarded-Encrypted: i=1; AJvYcCV8LC8/OLRRILLFQTKVcC/i8TLDVDReqAARDIWv4HfiCo5OaZ5DuAA/+fsjTSlWHaZR9xtRjaYGwNHvP2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2FyR9l2Vtvo8Dd4EXEuNKMQYJ3NCa4GBR1nZ6lXRVWphFhrh
	7KcPKWpR5emdilAnEWfzXe6Pf+Kcxdd1Z68bQJ+0cVXmg4DgUBorFF6Zmdq3
X-Google-Smtp-Source: AGHT+IEpbo1hA4HG+LelP68Eo3j7WTfhanWCl6OEbvz+xdpngR3bGo8F9W6fPjtOHZYh0JHL406HTw==
X-Received: by 2002:a05:6902:1b04:b0:e16:4a59:c3a7 with SMTP id 3f1490d57ef6-e1d9dbe1a36mr5330132276.32.1726213407115;
        Fri, 13 Sep 2024 00:43:27 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d7b9db6c2sm1398278276.9.2024.09.13.00.43.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 00:43:26 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d3f4218081so16837327b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:43:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVt87d46uZb3+tk+9YEyt8bEUnP1TXBpji8R121XfVmpii0hKdyaqu47AXCwv5/BqcJIb6sP1hqIzKLmXI=@vger.kernel.org
X-Received: by 2002:a05:690c:a8b:b0:6db:d27f:dd96 with SMTP id
 00721157ae682-6dbd27fde76mr4703747b3.45.1726213405883; Fri, 13 Sep 2024
 00:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171142.3241719-1-devarsht@ti.com> <c501c5d3-d715-4ac5-98be-35d23ad1cfbe@kernel.org>
 <3y4pqlazkuofc37s6zlw7waqzmtdl5iydhm4i3i45n6d6pnflc@osyocv7wxtif> <87ed5oypeh.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87ed5oypeh.fsf@minerva.mail-host-address-is-not-set>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Sep 2024 09:43:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYtsERgJH+Epq2d0P34PfVtEG69HHDLgz_nsKaxbDu4g@mail.gmail.com>
Message-ID: <CAMuHMdWYtsERgJH+Epq2d0P34PfVtEG69HHDLgz_nsKaxbDu4g@mail.gmail.com>
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Danilo Krummrich <dakr@kernel.org>, Devarsh Thakkar <devarsht@ti.com>, jyri.sarha@iki.fi, 
	tomi.valkeinen@ideasonboard.com, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	praneeth@ti.com, nm@ti.com, vigneshr@ti.com, r-ravikumar@ti.com, 
	j-choudhary@ti.com, grandmaster@al2klimov.de, caihuoqing@baidu.com, 
	ahalaney@redhat.com, cai.huoqing@linux.dev, colin.i.king@gmail.com, 
	dmitry.baryshkov@linaro.org, geert+renesas@glider.be, 
	laurent.pinchart@ideasonboard.com, robh@kernel.org, sam@ravnborg.org, 
	simona.vetter@ffwll.ch, ville.syrjala@linux.intel.com, 
	wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 9:38=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> > On Thu, Sep 12, 2024 at 10:47:31PM +0200, Danilo Krummrich wrote:
> >> On 9/12/24 7:11 PM, Devarsh Thakkar wrote:
> >> > Modify license to include dual licensing as GPL-2.0-only OR MIT lice=
nse for
> >> > tidss display driver. This allows other operating system ecosystems =
such as
> >> > Zephyr and also the commercial firmwares to refer and derive code fr=
om this
> >> > display driver in a more permissive manner.
> >> >
> >> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >>
> >> My only contribution to this driver was through DRM refactorings,
> >> but anyways:
> >>
> >> Acked-by: Danilo Krummrich <dakr@kernel.org>
> >
> > Similar for me. I only touched one of the affected files with a
> > refactoring change (34cdd1f691ade28abd36ce3cab8f9d442f43bf3f). I don't
> > assume this gives me any copyright to that driver, but to simplify
> > things:
> >
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Similar for me too. My only change to this driver I think was to add DRM
> panic support in commit b2cb6011bcaf ("drm/tidss: Add drm_panic support")=
.
>
> But I'm also OK with the change, so:
>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Similar for me, just a forgotten comment update.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

