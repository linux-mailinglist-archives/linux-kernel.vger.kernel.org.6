Return-Path: <linux-kernel+bounces-373894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E09A5E98
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ACE1C21747
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B81E203F;
	Mon, 21 Oct 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Z0OZN9zZ"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CD8C0B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499211; cv=none; b=LbdEjx8RKCBhGFKkE28sSsB77G6zysOan88EF4jLi/M+20RhKZL9Livyw/HZY9V2bDps7NcCjtopM5EeEQrWRCzNnZbg0iZGZccfx6wsbbNEgK2a3BKMNTz8pZcYpBMlr48PAr4p1/S88Lv7F4GUhIoF/+Zw5HS5q6tg2K8OR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499211; c=relaxed/simple;
	bh=jqfVzsyngkvkBu2SzS2NfosKPpPk1Q99Ey5zp8J8bFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuBxIDrYxcgFCzbNoxXAe+8cy950z70k1j4PylK0IcWyFS8/lz1PDMuIqdh5+Nbc0FXwrDg4NhlPK8FPGkGoUG/R5md5F0+wlGli58pUY92pbRfEqBXxfl83wUO+BMLTp5GP7eL0cYvToF4GXZ2l4vrVUysNsLfdFibbkyJ8NSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Z0OZN9zZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso3652500276.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729499208; x=1730104008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyqzMIEpp4jRJ8NQc0niwtx3//WyTsOS6NDlUpmRPaQ=;
        b=Z0OZN9zZqrbSoHt2aNy8IuiDHwQBcOtdu4oXNVdiKSJ0jlTPCY/pmEofmV71MCK0l9
         xK118+gGEs3cgYgtgRNBJAAQ+Wu0BtWYdi1sLwCcY2Toqx5ErEzq0J+rXfh+y6DlgR7Y
         +O4gp8/JIlxOwtvBuTIsmtRreIm8AGMR/2fZY77AhiprhHjqav6sikJRTPjlqsweXJCn
         ijnGjOR4B7KIkWSbcye0l3K0uPu5bGhniI74b/dfPc9ngGGh3zJ8D6t4AeFOLIPkcszs
         CJA0KVubFJgwYkCqVmKOC0cfQ3pTe1DRSTxMojGrQmY7MY4nvp1KM7S4ziiyP2sMz+wy
         tgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499208; x=1730104008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyqzMIEpp4jRJ8NQc0niwtx3//WyTsOS6NDlUpmRPaQ=;
        b=XRTSgzcIrOteVYYDyC+USiowvKtG4v9x8pyxlPdfPp4VnpCTA0+4PX5RQrHZTsHs0C
         YF3oZj5thZQR2skZWB/+MuYINrzD+cMUBqATN1TbguNlWl1s7tGsAKWxi9rDSWKy2zKb
         n5Y2Cw2QqYmUZMUc8SVEt+OCnZxHoOm3IipNE/unBFN7ITOKWq3/FcQ0zG1lI2D9Y07P
         Uz3GP8PL9ugJBhN20mMwnkoFOL4vlYpOGLTsfkrJPkeUs/GkpIs7rN8UCVGYEfzd5ywJ
         h818joQkLvfewii5fOTQrVskwFUt6ioeM65EBQtOnTg5WUlya9CWaobiTvwnbGXBwI3q
         QP9w==
X-Forwarded-Encrypted: i=1; AJvYcCWM21m8qTH575YwLbbIh8x1R4TCr155WOW/oLNlYi3Qig7wEOtYCGhohCEItFPvkbWtIvUZJ7hCeLWrKXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzihx/RnAXDuRAqbPtWaTz2quQ64kXBhed6gGZdcMOQrJlk4YpS
	2vcDAYCCn5tlvVV5AENZInVfnNxacXT2S13pHZap4LJulBuiToYr5cn/lJdHVh6z45jYYVu0hdX
	RQVTN/WEuGilzH4Jcu8/+lYd8p7qM5SIPHK9wYxttmOpvhixR
X-Google-Smtp-Source: AGHT+IHnIvuqu3YYS74eKl53uayBWq9bK/JoAAVMxGnENdLNM835JvQTdK2pOZ6bunwh4foYgB+IJzN+/djXOkQIBh0=
X-Received: by 2002:a05:6902:2b0e:b0:e22:4f74:9590 with SMTP id
 3f1490d57ef6-e2bb1428d1bmr10087863276.27.1729499208392; Mon, 21 Oct 2024
 01:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
In-Reply-To: <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 21 Oct 2024 10:26:37 +0200
Message-ID: <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,
On Fri, Oct 18, 2024 at 1:18=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v9:
> > - default to BLOBLIST_ALLOC on arm
> > - Move default for BLOBLIST_SIZE_RELOC up
> > ---
> >  common/Kconfig |  2 ++
> >  lib/Kconfig    | 15 +++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
>
> This is fine, but please disable it for snow since it needs the FIXED
> option for now.

I cannot follow. What needs the FIXED option and what to disable?
I run this patch on the CI and test_py_sandbox tests are still working.

>
> Regards,
> Simon

