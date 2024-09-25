Return-Path: <linux-kernel+bounces-337989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655869851EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967831C20F06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ECC14B09E;
	Wed, 25 Sep 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rop2QYn4"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC40136664
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237538; cv=none; b=qOnTtbukkD/UyqSggJ3kurTpK7kxI3PB7kSsrOSuo4oGF1XjmMMsOj/tjaT2kRJGKjA+JWnIMFCpnzt22VGiYMDB0CGKbMtyWkx4uVIxf346JdN4iq4U286mgSEWP7U9vYNi3k4JwapafrHxWyEUtF4GQShR5wxNmLOLePt4dHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237538; c=relaxed/simple;
	bh=MCCHOcW6PDYekuFAKP/cXwDkj9QRVyrD+2nvry9Ki8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+z3nISDShnluwbLH9i0F3JI1WdjA7rydnc2d2+z1FRXTEkfCqw9cPh/vxSnSIMheLwqKy1jpV991hSUf/IlUAleTSDHB7hTOlai96TqTmWu+IvXaoaYkIA6oIwrHtba/aPYcvMR6dGNH3c3ny/gsjnNTSXXdwAUDO1covbq5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rop2QYn4; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710d77380cdso3464683a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727237536; x=1727842336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCCHOcW6PDYekuFAKP/cXwDkj9QRVyrD+2nvry9Ki8c=;
        b=Rop2QYn4iYowgcQV5aaZVpACx+i3PiNM0PRTWzNKf7x1eBuMEJ9b+VehJt1LdZFiGQ
         6QbkAjSooAisGNlNABIsQxosx41oKXtZrq4N4uvs0JZNmmPEhHH5pKHacnKYrE9IQ/mk
         U4GHOHF1BJK+TmMdThCOiHPa85pwICam5yuTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727237536; x=1727842336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCCHOcW6PDYekuFAKP/cXwDkj9QRVyrD+2nvry9Ki8c=;
        b=L/fTd53puQbRdHVc/sjgGF8zx+1okaNQT4Y5vHQ1PE7TvZvMQjObuuyaqp+LH4J2lE
         iAg8IQQ67mV8HZzBYa9+ELpx/N4En97EOtMr6GlhLCiXuWiEY90uL3+C2t57S6ZABCyA
         wDTEQCkKOe2kX2lL4Qdd+FKcy+KJnkQYmX3XoTdTV5gmF8EC/FQ6RhDUQB1/ga8ewidq
         BNvCItURmget0mhCrzkvLXhF/NpKGmbZ+4hHDtiJABCy6Huf2SrxPH/U8sYCE5tRTbpP
         yWxYgjg03iYXub+IaQkqAEZ9eMd6ZRrPoQtI4A1j/gl+ffQOg/d9MGc0hvS7HYXNqSzb
         iPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlKt4NK8hS1uCOXtUtyutTIhh10xRi4Dq3vzm6qw/Y30Ivy6ippaRlIBkf2L3o5/0U8IRMYMdjX4sXBAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydhs8xMhP7ZWFOyw0ZOGkVQmL3Nacyw89mxsgCynd+vqoQJAcc
	LGQssdRjw24uqlh28mEqnjf8RPIRcoKwQPjFYkwjznKTeWKqbe/6Tx1BILeg00NfzgJ/Qt+Pa9W
	DVkSxCIk2OwKRI/zS9APPgDo+kldU7LDFS7ac
X-Google-Smtp-Source: AGHT+IEen4KEwECA8Pn5n5uArtwXa5aiPy709MZmXOWELSNauMqF45DgHEuB+OYeDI80hjN84eq4La4V59Sb/VriRfA=
X-Received: by 2002:a05:6830:310f:b0:711:3ed:4226 with SMTP id
 46e09a7af769-713c7d96e0dmr1136133a34.7.1727237535820; Tue, 24 Sep 2024
 21:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924035231.1163670-1-treapking@chromium.org>
 <20240924035231.1163670-3-treapking@chromium.org> <CAD=FV=X2V+LQ1XOo_eJ1Vv3Pn+E309kvyY9FOzaZP_j8ToXM2g@mail.gmail.com>
In-Reply-To: <CAD=FV=X2V+LQ1XOo_eJ1Vv3Pn+E309kvyY9FOzaZP_j8ToXM2g@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 25 Sep 2024 12:12:05 +0800
Message-ID: <CAEXTbpfHUfq6rmSZkXdAYZ-W03t7vMcACUmyco6xL5A4T_Ok=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: it6505: Drop EDID cache on bridge power off
To: Doug Anderson <dianders@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 25, 2024 at 1:48=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Sep 23, 2024 at 8:53=E2=80=AFPM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > The bridge might miss the display change events when it's powered off.
> > This happens when a user changes the external monitor when the system
> > is suspended and the embedded controller doesn't not wake AP up.
> >
> > It's also observed that one DP-to-HDMI bridge doesn't work correctly
> > when there is no EDID read after it is powered on.
> >
> > Drop the cache to force an EDID read after system resume to fix this.
> >
> > Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> Ah, I guess this answers my question in the previous patch about
> whether caching was important even for external displays since this
> driver only supports external DP and the commit you mention in "Fixes"
> says that caching was important.
>
> So this looks reasonable. One thing I wonder is if you're totally
> guaranteed to get a PM Runtime suspend whenever you get an unplug /
> replug of a display. I tried to dig a little bit but I'm not super
> familiar with this bridge and it looks complicated enough that I guess
> I'll have to trust that it's fine. So...

it6505_remove_edid() is also called when the bridge reads HPD low in
the IRQ handler or the DPCD sink count changes to 0 after a HPD_IRQ
signal. The assumption here is that if the bridge is still powered on,
then it should be aware of the monitor change events and drop the EDID
cache when needed. This patch addresses the scenario where monitor
changes are not communicated to the bridge when it is powered off.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Regards,
Pin-yen

