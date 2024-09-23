Return-Path: <linux-kernel+bounces-335436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98A97E5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5BE1F21632
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9811185;
	Mon, 23 Sep 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZPqcIZuC"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CC134B2
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070549; cv=none; b=hj9o2hEucumQdaFDaOE6Lm6xsX28VGrZ9NEPbMjsnw2c1IVwLrXWZIjCf7ps5ePAC4z+PTc5JeyYP8O+h8TWUPirbMeu5p0TP0XIhuzPZzkfN4pjD+BYTbjXo5bJ9rMwxjIl0fUAIQMV3q9GlonCmEAVFevFYkp3Eb+GCb+hO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070549; c=relaxed/simple;
	bh=4QMjrZ/vTCWEG3mQbNt3w7oXUM7KK/d55J81vW+b/wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqSosBgjfTUQ/8knu9M7A4zaloo2zJ0CN3BKbpG1eRMG1NGixoCfh/H78uqNw8DRsqAXptwm+835gZ6qOt8ijoZh8b5B8T3BGFa6WVTF9FhlhDveNe8iQKbLDRn+YPgsv2MNWiKnT0t50dNOWKhTnacwOIeUs+tOi0oESWnMyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ZPqcIZuC; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3284042276.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727070546; x=1727675346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+GqPi7kvfkTPGuMQMG8mgU5U/TLnK6mH7U//v/3HNA=;
        b=ZPqcIZuC/z+rNcENhu0pPCIJTzBz1nPmTTZhbgg8dF8r5ASzxA/KUz44wF/6xHf9OG
         7GBGlvRRFpo5q2XdPZwrRcS9YSbWMFbmfIFEIhrz40WkDsVyYlOkMGlWZ5k+ye57+VUH
         ID41Ymc4OUkHBvmpniZra1k43Jn9FSndbJxtov3SqFZvdg8tI+0C/lAS3MSfZ9ljJ7Rk
         FS4x474gpL8g5GBEF+jyCUypE6w7DjnFhPNVPXYWWUbq9HUfjlq9Q/7AuHHj7SiIjt4e
         GWY0tBNHLGVnYNvrtwn34svNVjpuXcPJBEEfFufnJvFEeLPalIEYGjwYPmNlAdQS4g/3
         ckgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727070546; x=1727675346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+GqPi7kvfkTPGuMQMG8mgU5U/TLnK6mH7U//v/3HNA=;
        b=NViY3xLnStm2P2TImuLjx6t4sgXl9I1X+2FVO+VrDe25z8Rmmo6D0CIMAes1vS2YiG
         M1iO9Aa573jbJjn+hZZ6ERjH0pnPfvfvYOP2k8UrafpzL2ugXKhT7bK30ZfxEmmRrgR4
         cGfGwTm20NZI2yVNhnh7cKQCBGRDT7TLPo/ZeQkNcbV8NhqhfWJiIVW9F6ovGO84+fcO
         T4EWlq7jg4WXvc5+yyalZ34zbs2XCAe4GOE6epvY62sMv797Gr9muVkJ/KUaedNKXE7k
         gvltMGaZmYIUwcasDRUHDRid8eVN8bXbhLYEaaCDnsffW47IZRbXTBhBt91wnZABWPDQ
         vXRw==
X-Forwarded-Encrypted: i=1; AJvYcCXkV1kUb07CPTR8RYVVgVkkdI3Qq93Ki5BgV6LRALdOoxiojsfNr4QTSPxuZ+6o247RKjnNtkl7LES4mzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpT13XmVdDMRiGMiyqFTPphUdwotI1pN5TcHu2DMz0FaXzWrtY
	gp1Oing2dmNjoNQHfxoSKuYTAxDaZzR5D0Ub0XjIzzN74L+xkMR50LxGiLYLQBKBqBCJnMZY1h8
	SHfzbw8tr2rz7hm5GOLHCqVV1JIHTNQl7wxjevw==
X-Google-Smtp-Source: AGHT+IGogvUBK71VcziSAeD3QkSZcxwep197RhAXeoE1QftOmUyPSyvBzNM0uigg5+7kkyAXm2G0F1vRdwacY4hiI1I=
X-Received: by 2002:a05:6902:1705:b0:e21:70df:8a7 with SMTP id
 3f1490d57ef6-e2170df2261mr7346912276.23.1727070546152; Sun, 22 Sep 2024
 22:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-24-patrick.rudolph@9elements.com> <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
In-Reply-To: <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 23 Sep 2024 07:48:55 +0200
Message-ID: <CALNFmy2vWuHnJHXMozStYouPNGTCXWdkuG7fQkT7y-rgi5M4yw@mail.gmail.com>
Subject: Re: [PATCH v4 23/35] drivers/arm: Implement acpi_fill_madt
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Fill the MADT table in the GICV3 driver and armv8 CPU driver to
> > drop SoC specific code. While the GIC only needs devicetree
> > data, the CPU driver needs additional information stored in
> > the cpu_plat struct.
> >
> > While on it update the only board making use of the existing
> > drivers and writing ACPI MADT in mainboard code.
> >
> > TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
> >       Booted on QEMU raspb4 using GICV2 driver model generated MADT.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > Changelog v4:
> > - Read everything from the DT
> > - Export armv8_cpu_fill_madt() to use it in other CPU drivers
> > - Depend on IRQ
> >
> > ---
> >  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/Kconfig       |  1 +
> >  drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/armv8_cpu.h   | 10 +++++
> >  4 files changed, 178 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> I'm still not sure why you are using u64 instead of ulong?

u64 is the type defined in the ACPI spec for the fields within the
ACPI MADT table.
It's also valid for 32-bit systems, even though this code is supposed
to run on 64-bit only.

