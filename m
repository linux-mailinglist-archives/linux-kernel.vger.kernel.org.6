Return-Path: <linux-kernel+bounces-347708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175798DC05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F14DB23119
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D81D2B02;
	Wed,  2 Oct 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ftLKU5+I"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A71D223D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879483; cv=none; b=qATgPS79XOa1RzD6mR6EmePA2wXSHUdiZ3huX20USw2voyff+ANnSMwAmpRFn8hkgWK/9d1MJu2CT5z89phkQUBZbJPCUzmfdQyRcmLuZmSuBITQxirlIWD/mNmYAN/egcgt6OhY0vQJhdvsjkj2vYvvXlfZdo5GwlMJIfbXYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879483; c=relaxed/simple;
	bh=KCplPbQ9YtntQwYxbaErQ9DGkEA6PvlTzAFSC6yTqe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHsAmQBR8RWZ97lExnR95ByZea7m7iaxV8Ep/Di1N/NI7xfT0zsXmw/2PrsoM6OeLBk7+oevV7foqGEw8doyLJ8u80YirvG4+60ootuNYLF6sk3Zat/T4Oc+kGasZM9R4RMvQ8MaC9e/mwpPhRhdaJbpS85buxAl1OSU4DCwJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ftLKU5+I; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad784e304so27590121fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727879480; x=1728484280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCplPbQ9YtntQwYxbaErQ9DGkEA6PvlTzAFSC6yTqe8=;
        b=ftLKU5+Iw1ywFp8Dx/UsNA0xCiAQiURm//kjCbdZYjwtiTJwYDUCmWXiK3AXVm4J31
         oPkhu/Sx/CYDGUvGXs7GVA6Hc/VNPzn8jAhQ8Rgf4TGWhcHqsDqJ1AJU2ZzMfBUdYSxe
         qOKaSWFFeX08XFeGztcaBWuhix7RBhvjZIfgFHtD1iUqwy8Bqay8kGDPyp5CJBhrc+fT
         55+vinJ9lu5/+e8rQkyNCUxXMHpcUFkeYxerV7ltv+OR5RhgGw7F01AF9yh1CohmvvQE
         78vTNSpG+sJqUMnJE9CGnt6t0im59Fy40vW8Ukyv8id/z85EoxEn6k+1nUclDgQaoP5R
         x2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879480; x=1728484280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCplPbQ9YtntQwYxbaErQ9DGkEA6PvlTzAFSC6yTqe8=;
        b=QAnQPFKPEKUCujwFIkEj1dUVHo3BKBfLtY5H8aPP5w7FCgpH1VVzBbh0dPcaFTgqgo
         KvikqVyxZ9+tcwtfJtRLFVocTwZWAMdd4EbgEV8fP9vo7le4f3+ILcWiLwt3jzi54IrP
         tzm7Qap95CgU6Q41aoXvcv+As65Ok6d9dDpAne1076A5nL9Ye1cUVHsm7am667h8TocA
         fsnht0fZUhpROu5Amesq1YXHYLk74BwCBMypjMx04Zcz52Z2m5YQ1Q6L2wLGwkVrN+NM
         ns+Rxc2zAbA7EZxQD9PK2h4My1Fg4K1BiUgRDUCl+5n0p4rcE1kUQ+sIFxEdAokoBjoe
         cwXg==
X-Forwarded-Encrypted: i=1; AJvYcCWyNdAU6uEyy75f5QgtqERL1qnAkLxaAiYMS8OXDmuEcEj4X3l/gql8t7x0m4Z3FgK56whQfWWFgr166Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oqUIXXWImhkS2M4+vWlD/KPw7/ZAoW1PME5hj/rurnwLq6b9
	eRDg1s/5IOA+YW/lhPJYbX8Q8XpUUwVi1CMW23aCLPb4dtkagSeUumbL5BdtOAXr5vbscOR5DlY
	BnjhpE9ZygH56rYLW+Oax0ZqQSk5r1/dpROcVUw==
X-Google-Smtp-Source: AGHT+IF0VGVcIscjWdIkcQ7OdCvvfD4kfboX2NBFzefh7Wob7IOW5GpAgb2GlIiXbvzCdrcw7O8wXLo5/ikHCmnOth4=
X-Received: by 2002:a2e:131a:0:b0:2f3:b582:a914 with SMTP id
 38308e7fff4ca-2fae1099897mr16703651fa.41.1727879479875; Wed, 02 Oct 2024
 07:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927074221.9985-1-brgl@bgdev.pl> <CACRpkdb_1LrtbUssBEgYqOLgUY9XAbVBr+tezt5FCM3tdB9RYw@mail.gmail.com>
In-Reply-To: <CACRpkdb_1LrtbUssBEgYqOLgUY9XAbVBr+tezt5FCM3tdB9RYw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Oct 2024 16:31:08 +0200
Message-ID: <CAMRc=McaakkZZ0BWeneG6PrNKPto+Wc4T4-GGiUUnEqrQrxnWA@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: sysfs: make the sysfs export behavior consistent
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:12=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Fri, Sep 27, 2024 at 9:42=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > For drivers or board files that set gpio_chip->names, the links to the
> > GPIO attribute group created on sysfs export will be named after the
> > line's name set in that array. For lines that are named using device
> > properties, the names pointer of the gpio_chip struct is never assigned
> > so they are exported as if they're not named.
> >
> > The ABI documentation does not mention the former behavior and given
> > that the majority of modern systems use device-tree, ACPI or other way
> > of passing GPIO names using device properties - bypassing gc->names -
> > it's better to make the behavior consistent by always exporting lines a=
s
> > "gpioXYZ".
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I'm in favor of this.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

I take it this also applies to v2 and am picking it up instead of this one.

Bart

> > Story time:
>
> That's a good story :) Fun to see how you arrived at this.
>
> Yours,
> Linus Walleij

