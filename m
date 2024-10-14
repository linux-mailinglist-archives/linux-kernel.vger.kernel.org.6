Return-Path: <linux-kernel+bounces-363310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19299C068
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC41C223F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDD1459F6;
	Mon, 14 Oct 2024 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="VHAUuRnd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3113A24D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888761; cv=none; b=YC2qjg8Le2x60OL+ytapMfcgWj+ewxLC3KOcnYdPIasBI6w+qvFEb/C9FzBFb2Ukvo+WsblYwfT+Zxwhv5hKExZS1mIqSpGNTkiOodTlr7i0IiColGXJYVsLHoI9+DJpswp3s1nSzUfV285WneYn35tWnVNHXZ+nCZh+tTtTBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888761; c=relaxed/simple;
	bh=83XRFk3icY9wacBXH9h6a+cfKmvsk+bmke0LBwK7HB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+Etd3xcQbiCBfJ+zfmCKuwUz/yAxfDvmqBH6ahQUzUhZWr9hT4CtQPdirRJRmOJ44oZMCf1SetGxtiSCVaNozws9ChplYLMbNYncfSvmDB8EwROqplicCyTtcpXm6P0M9wijombRBR4gvzB8s5tKFgKC4Zl/TKJ6E7Rcr/IwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=VHAUuRnd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d50fad249so2432239f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728888756; x=1729493556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdmKUc4kFogREmsbxxmoAtht2YH4/2nhAs+tY0ThKo0=;
        b=VHAUuRndYrj7UYwRjDU6JsiGLRTdbKywLvT6jBKs8XPwmgISpyCKBUgVN3RZXZc7my
         GFnIkSfS7KCu39IHfakDM8E0sJY4XCfeKbqC69FCE3nzwKcaMtzxbalMyMohMZ7F9QGw
         06KZBt90CuJYKHUJrloTuRNGwKh9U3jv5jR+2810U3iJMcL5RvGVimN6Q4L1t1Yux1XY
         QyiMyPKRdqRobG19wnyKbJl2JuhE8qog3KrNlwwvvRPZ9wH2obRogX4PSaTTwE/Q3w1Y
         55hjOWzCBnLTaZtqxirapKdODeCs5KcYzPSYLzLgZybkatSZKNh3UBcHlR3cOTvrOg8C
         K5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888756; x=1729493556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdmKUc4kFogREmsbxxmoAtht2YH4/2nhAs+tY0ThKo0=;
        b=RVieLie//OW/ay220KN3h//w+/cOi8uXXxDuc8aV061P0WpCuQ/0k31Zs41RMh6xQs
         2sYD21oCvyQu5JgHzlAnKMqAqgNNhhGhzBLYYRdMnx0NNQf0Xokuvfu9YTHAU7x0S2ex
         paqqIOeZvBcl20Vv6FZUX9inyyTXM4LQmCW72G0D0Nzja5VXJ+/Nlh/mN9fDXTFBcmmt
         DYzWmaq3l7n/Jq6oqJIUqlTCXkDM9TJM36v1A4gAvn5qnt4lY4FDALUURXbygY+Y8aDb
         bYeBNm3r5HRI3srA+iXuGvqRoKeVA2aD7zEeoe2INm1zURgpoRvkXY5mnGAmZoOFH87s
         Q2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWit7aYqx5Ey+b+CGZb7WSOo/YAKmW33vLgmJTMEGQYTHCAFSCfB0a2WxvPaX+6g0lBE98tcxD9nZkJeak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqiaSK3nN459sdnd8bKMHvyBdDNC7FJN1A28RaAUWIKk2h3Dc
	p3xMgnSIZI06lOQafYbp6z5J8jzl+YY6Xr4dY2Kj4LhDcqhKYyaWhGWCFqIL3FA=
X-Google-Smtp-Source: AGHT+IGuyHZT1722tVQ09zXnlH2EaOt5XrcR2LNEFWPIJz5U60GmJ8IMR+aiu+0LiMHuJ+mx11tRTA==
X-Received: by 2002:adf:b31b:0:b0:376:37e:2729 with SMTP id ffacd0b85a97d-37d551f2873mr7123855f8f.31.1728888756451;
        Sun, 13 Oct 2024 23:52:36 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7a05b3sm10628180f8f.76.2024.10.13.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:52:36 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, upstream+devicetree@sigma-star.at
Subject: Re: [PATCH] [RFC] of: Add debug aid to find unused device tree properties
Date: Mon, 14 Oct 2024 08:52:35 +0200
Message-ID: <3316101.aeNJFYEL58@somecomputer>
In-Reply-To: <CAGETcx_+Poy8b_QhKY21Wg9=TBjtxrhCmFWTq8Qv6rLSJMURCw@mail.gmail.com>
References: <20241013200730.20542-1-richard@nod.at> <CAGETcx_+Poy8b_QhKY21Wg9=TBjtxrhCmFWTq8Qv6rLSJMURCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Saravana,

Am Montag, 14. Oktober 2024, 04:37:10 CEST schrieb 'Saravana Kannan' via up=
stream:
> On Sun, Oct 13, 2024 at 1:07=E2=80=AFPM Richard Weinberger <richard@nod.a=
t> wrote:
> >
> > This is a proof-of-concept patch that introduces a debug feature I find
> > particularly useful.  I frequently encounter situations where I'm
> > uncertain if my device tree configuration is correct or being utilized
> > by the kernel.  This is especially common when porting device trees
> > from vendor kernels, as some properties may have slightly different
> > names in the upstream kernel, or upstream drivers may not use certain
> > properties at all.
>=20
> Why not just add debug logs? You can print the full path of the
> properties being read and it should be easy to grep for the property
> you care about.

This approach works only well when I know what property I care about.
The problem I'm addressing is more like  importing a device tree (usually
something wonky from vendor tree) and want check whether all properties
stated in the device tree get actually used.
If something is not being used, I need to investigate...

>=20
> > By writing 'y' to <debugfs>/of_mark_queried, every queried device tree
>=20
> A lot of querying is going to happen at boot time. So, I'm not sure if
> this method of enabling it is helpful. If we do this, make it a kernel
> command line.

It works differently.
As soon CONFIG_OF_DEBUG is enabled, every queried property gets ->queried
set to true.
Writing to of_mark_queried updates just the sysfs representation of the
device tree.

That way one can analyze the tree also step by step.
E.g. learning what properties have been queried while bootup and later,
what was queried after loading kernel modules.

>=20
> > property will gain S_IWUSR in sysfs.  While abusing S_IWUSR is
> > admittedly a crude hack, it works for now.   I'm open to better ideas,
> > perhaps using an xattr?
>=20
> This seems quite convoluted. Why not just add another file per node
> that lists all the queried properties?

AFAICT, adding another file will confuse dtc since dtc treats every file
in sysfs as property.

>=20
> > That way, dtc can easily add an annotation to unused device trees when
> > reading from /proc/device-tree.
>=20
> I'm not too familiar with this part. Can you elaborate more?

E.g.
$  ./dtc/dtc -I fs -O dts /proc/device-tree
=2E..
        intc@8000000 {
=2E..
                v2m@8020000 {
                        msi-controller;
                        compatible =3D "arm,gic-v2m-frame";
                        reg =3D <0x00 0x8020000 0x00 0x1000>;
                        lala =3D "lulu"; /* not queried */=20
                };
        };
=2E..

With my kernel patch and minimal changes to dtc, it is able to tell me that
nobody has read the property "lala" in my device tree.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



