Return-Path: <linux-kernel+bounces-374757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C819A6F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345B2283F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C8199385;
	Mon, 21 Oct 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xal1duxQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656E14A90
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528343; cv=none; b=XHwm4HtM6wnZZBSkcanVpOOY5g0O0w0wPODLTcbukSUS9Un6MLZ07aBvknOJmuxCwEvdpICC7apG01BEPtHQYJhmLu4DUpDNHgIXqUurZbnIRs3ZfoW/5srWCQj87Dck7APTDtk7qgwWcnu/2QO76vysnA1fX7S9g4gMf3InO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528343; c=relaxed/simple;
	bh=JHMFK2xXvVItB7qlUF9MmGCs4Jw8lsHIYAtCyBvvjcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meegT9dA9oK672699cK4D4vlbWCIsuYL/rLvwzpBz8R3JFHyd7h5wxJIZrHn/uZz7V/ayLrOXXKr8T9wfZI+3gsW8PMhBDRd96ex3C7u966fcNiDkLXeLELTIxoKowauu/QWZVMzTLB9ab28QhatEEcLmZHRZPdckWewxr24Jp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xal1duxQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86e9db75b9so607864966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729528339; x=1730133139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIDJKRWb1cH4lDJYBto2MTh7jITssmP9GARA0z6Bd+U=;
        b=Xal1duxQjCPMFMGK+Lt+wlldsEcN/jZeWOb4gimG+FmH5lQb2EUCIk5QsMTdb0xX1h
         dzwUJiEtwGlaJO/bDF30k1WdYkW9BJpWyKT7VzfBaHwra9Q5Ok02xPyAhS6Tt16/cHm4
         +RqjS+3SzB7jrP9P3lAAysPRLMCrDOGNV3Ep8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528339; x=1730133139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIDJKRWb1cH4lDJYBto2MTh7jITssmP9GARA0z6Bd+U=;
        b=RCs6N07JXZ9cl718hrPa8IZrSToAr9mw75l3Inlp9cApnKVBM5L1uQwRobYBH9THne
         F4nhO9xajt24wt5zDfLpORnXlzWND0wsHlDr7u5GkrECt2cYWxoCLy8OsLuW/ThBVrwa
         rmRaLInJJopdtE+coLHHUszKIateQ0H0w8fo6E7NYysXA7sDoteIVKw+UcOt/slpaR06
         jaySjrCvOeH6iZjt6aVjCtRKrqjzWIxkiV3FJKMyR2iGbvdYWTO+x5FS0YKnzx6ZSU52
         vRr3hQcrEKpPZS44QvhVvct36Lbhk6R0UKNZSHVjK0ksz38HDfifL0XrfUrqb56XzWF3
         qdrg==
X-Forwarded-Encrypted: i=1; AJvYcCWueM7RT2sbAyePyNoSh6ZF180jCfIDKQ+L1O8LiT512Yx3YvFk9XUNBC82jCRRwgiUUmKxapaJPI4428s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbRuaibVBCTPF9coTyYtaD13msyK/jRaCLHJeIBgqh1usPhHl
	nh3IcYFvpWxrZyYTUEf51WOcLUphrVbM5Svp2UrdOGnq9pJv4cGAO8c5yfloh5yUzT2I0/I91bN
	JDQv8FUdRUoWe68+SmhZPrtlMQAsvNC3FSYJlAabNKTEzW4mkM2YU
X-Google-Smtp-Source: AGHT+IHXW5R+bsYMSSY63PBgSLcKQKDMLs1h9/ESwcRqvN18aTVxUg33p/wVSRSApUm6mg8DEyvByDu1/dtn038UcwA=
X-Received: by 2002:a17:906:4788:b0:a9a:38e6:2fdf with SMTP id
 a640c23a62f3a-a9a69cdf917mr1121164666b.64.1729528339551; Mon, 21 Oct 2024
 09:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
In-Reply-To: <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:08 +0200
Message-ID: <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 21 Oct 2024 at 10:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Fri, Oct 18, 2024 at 1:18=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changelog v9:
> > > - default to BLOBLIST_ALLOC on arm
> > > - Move default for BLOBLIST_SIZE_RELOC up
> > > ---
> > >  common/Kconfig |  2 ++
> > >  lib/Kconfig    | 15 +++++++++------
> > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > >
> >
> > This is fine, but please disable it for snow since it needs the FIXED
> > option for now.
>
> I cannot follow. What needs the FIXED option and what to disable?
> I run this patch on the CI and test_py_sandbox tests are still working.

I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
if you make ALLOC the default you need to change the default for snow.

My lab is still not running, unfortunately, but I will try to get it
sorted out soon.

Regards,
Simon

