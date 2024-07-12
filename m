Return-Path: <linux-kernel+bounces-250759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3C92FC62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE61F227BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540C17165F;
	Fri, 12 Jul 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjVqiMFJ"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557816FF28
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793967; cv=none; b=NddSE62076K7W7KsXLV0cFyZn5XoEfz1hDnoSiUt9EMTzoeCNQpuetlgfJHF7lEih1Eh0CpOoEW5MBqvNwxsVuPbmv9i8sUfU5YOT3lrsPCekk0mUssUBadxJ/Qb6ONKSvqH5+IrwKDgKrr10L1QWMjDCSQxP6zU0f34+BCt5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793967; c=relaxed/simple;
	bh=bLsNBKMCo23yjeOx3HG7eMC+4hTmeK8khZfw73qKBGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6LY2shizHO/zB6QphK/BDwmKQoVieB40FQ+ARs8Uw4hA+TVJ4WsRKXBn0Zc0s+YAOPUCK76JcrBu9S2zDDLSgJNlG14Zx1gPHy4Gqa/qKmwk5u7Q0uLz6QU359rlgDfWE1Q5P5RDLR0nbDV12xjRUzthTcrZ/vsg/Qj8WSosw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjVqiMFJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65bceed88a2so18997077b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793964; x=1721398764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Va4y9B5heielT69BIMm119BAdoXPwpSgrlukrq1xmq4=;
        b=xjVqiMFJdkuR0aLdO86IRxcBryf6gXDnmElJwcxaS6Tx3gcQue4z7HpcR1BGTmWKTh
         s+MlIG5kLkYU0xK8CAtyM/vO1cekXx/ZlHguF9ipmHzBbZSswLQ0iDPdXfCzNREatD40
         lBcLcvUkG9K7aNKbw8hud1qSRUTFuIT3Rqa34+atEcaTo+N/qdX/HznsHx9qWD94i6qV
         tdNbVlsRanWS+w81ZwcLy/0q+v1rwHReMNr7SMC29mcpe7lGRlVKBbPp0TH3MuvLKO5x
         AdHOC00eO4IbtvzMONZyzt/8OkRxMWmBC7HCCbIcmzOpMUy8icQzu51InJnkzqyFiwMr
         CNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793964; x=1721398764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va4y9B5heielT69BIMm119BAdoXPwpSgrlukrq1xmq4=;
        b=B7nbEyEXzzx511I+Ii2lSrlwQlWufY5UxDRNWc+YN7z+utAPNlDMxEwwMqEpaaN4ZR
         B2wGpXVD15+H9mvRkxKIeV/hd5PvaYyCPBhup5XjMpJ6EjNJBenl9Nf8hxY8A3ICvQ9e
         ugNTELC/X95OiJku1d4JLlpHwaVNwXHzfTT8kTWqQ/w5omftf3V69wGbRZOy802Y1eO7
         f+29t57lIXyX/u4sAKUnolrBVuhtEpattdYTTvDSJ1zJLn/jm4ryp3NKY699EVVvP4lO
         WXTNqeqvCw9qW1SJkPpHgSlzehOjO4mey/+mJ4YbP5rZs8ijWpFZbXxBZndRegn2v3YS
         I6ng==
X-Forwarded-Encrypted: i=1; AJvYcCUxW9FhNstPb02b3IlsXwsrc3W3gE92Q/zjfoXao05o9ylsKp50j5vqqTdGo3EPbTMDF8P11jj66x79pbQWWDZW4Rf6EBXJdNBlOZSM
X-Gm-Message-State: AOJu0YyZZKrmfu+gXaV6XLd3Goq4BKpw/juLVsbO0OYvnt4PfCHTlhQd
	If/decppLn09lwzv7gil2j+EjHYgdQ3TYC88AM7uA2b/7LO2A3fZSgy6e48Ci28MJ7brXt7JJ9M
	VSCA8JSB/krqPiRihdJlYHGv9r2ZNBtIqopweyg==
X-Google-Smtp-Source: AGHT+IEkX6jQZ9TaNPruelUJVLjkK+umjiJ57WKLuEuaKgKpUSMdwD5mUaTD/Fqj+UovSuUiuJAUfTVDOlR2XKlAy0o=
X-Received: by 2002:a0d:f684:0:b0:646:4cd7:76aa with SMTP id
 00721157ae682-658f09c910dmr128553817b3.36.1720793964377; Fri, 12 Jul 2024
 07:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
 <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com> <b833c93e-ae8f-449f-b7bd-8d315aa52703@suswa.mountain>
In-Reply-To: <b833c93e-ae8f-449f-b7bd-8d315aa52703@suswa.mountain>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 12 Jul 2024 16:19:13 +0200
Message-ID: <CACMJSevheOfX91Up2_fphzemmzpqsckwHSQLHpEaCEKBEfGUkA@mail.gmail.com>
Subject: Re: next: arm64: defconfig: gcc-8: drivers/bluetooth/hci_qca.c:2501:2:
 error: label at end of compound statement
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 15:58, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Fri, Jul 12, 2024 at 03:34:19AM -0500, Bartosz Golaszewski wrote:
> > On Thu, 11 Jul 2024 16:34:35 +0200, Naresh Kamboju
> > <naresh.kamboju@linaro.org> said:
> > > The arm64 defconfig gcc-8 build failed [1] due to these warnings / errors on the
> > > Linux next-20230711 tag. But the gcc-13 builds pass.
> > >
> > > LKFT is testing older toolchain support till gcc-8.
> > >
> > > The following recent changes cause this failure.
> > > a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for disabling the clock
> > >
> > > Build errors with gcc-8:
> > > -----------
> > > drivers/bluetooth/hci_qca.c: In function 'qca_serdev_remove':
> > > drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
> > >   default:
> > >   ^~~~~~~
> > > make[5]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o]
> > > Error 1a887c8dede8e1 Bluetooth: hci_qca: schedule a devm action for
> > > disabling the clock
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Build data:
> > > ------
> > >   * Build name: gcc-8-defconfig
> > >   * git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > >   * git_sha: f477dd6eede3ecedc8963478571d99ec3bf3f762
> > >   * git_short_log: f477dd6eede3 ("Add linux-next specific files for 20240711")
> > >   * Config: defconfig
> > >   * arch: arm64
> > >   * toolchain: gcc-8
> > >
> > > Steps to reproduce:
> > > -------
> > > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> > > --kconfig defconfig
> > >
> > > Build log links,
> > > ---------------
> > >  [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j5nr85T4iLl99RjcJ9oy9O3eo2/
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
> > >
> > >
> >
> > The actual code looks like this now:
> >
> >       case QCA_WCN7850:
> >               if (power->vregs_on)
> >                       qca_power_shutdown(&qcadev->serdev_hu);
> >               break;
> >       default:
> >
> > What can be done to silence this warning? Or should we just ignore it because
> > it's gcc 8?
>
> Just add a break statement.
>
>         default:
> +               break;
>         }
>

Yeah, it was already there in the file added by Luiz, that's why I was confused.

Bart

