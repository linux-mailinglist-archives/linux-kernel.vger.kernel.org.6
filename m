Return-Path: <linux-kernel+bounces-243345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A99294FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E2E2823BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF113C675;
	Sat,  6 Jul 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jWPBQw6s"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC613A3F3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290398; cv=none; b=WYzi8MNDR3O6l8b6QqV4evEklbV5k9UL/R9Ve5Wst95l1ntcwe9vRfVuFvl3R/2MF0TBtcIKv/7adAyFDeFmN63T2GJf65EIcPJOEmqg9mT8LDIG0/R3A0fovg57IICEAOtQ+rsAe0lryPFdPZiVkrBbhgKX+vH1/V/j6u+ApZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290398; c=relaxed/simple;
	bh=7fYaEdzNSEyfDMOG7Pv9Ra+i0/C5BBYznSOJg0yT8To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRB01Qj3r0/O94PnZvZZqTFAnp6b5er2vUebTiqWiQ4qCOrQkPpbqqLXXSKJ8P3zBo3AKZVeC+urOjcgXcpNo59LlfsQfcTJUewsBG+5B5jZb/77WbjbHPOn+ZHKmcyRW3TZnUZ3Zk6wImbFBPKBU0jemJ/3TEurT6GFDRfgSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jWPBQw6s; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea8320d48so962715e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720290395; x=1720895195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYpm0LjvFlXViS4+8MqH1iB/wE5so+w6dRtWxQ8iiaE=;
        b=jWPBQw6sUnPOGHIz5RC82AyflyfiI0IFnjMz3SzKYvW1DXQcu5pOCAXPsdlf8CaPH8
         35TcCT7x1ZFoYC4W7h6EFQMCQRSHkNtn44Bfg/XPmUDW/bZJhrlRKQc7ZONyjs1TZGpO
         W212pfl6b5oGh/0ah0bCyfprODbBSIONgSGRc8sN4sDpa3YKcWdkIUUB9Lk49obi2/DZ
         6uuU7Jn6H/FEcN31khh1MrVjuBv1T/BdcmlPtpMOQBhmw0KvdRFT6QvD68Sm69+PDUyM
         X3P1zHm/cpr+vRyfkGLgqUwvRU83upM+3XUkH7c8/z/zjlQT7NFQmYbIKxNtcPvoqO9w
         Azug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720290395; x=1720895195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYpm0LjvFlXViS4+8MqH1iB/wE5so+w6dRtWxQ8iiaE=;
        b=ThwHJkraVuShFlaUvsG/Xzqm2BFsFLfcGWSHB0Qa//YXmjCxCjkI/HUS20GC1zr3QX
         kNHMuKRAhKU+ZFYFrvvOnxptpgpPKbangwDcl74ONif1vQ6ismzuhUvhG6/nUTsUOO1N
         ikMJMDt5DiNHYapPfHUkVUYnbPcljBibwRYYc/KYpNr5M6K2aRqV8lQQ70GPkiixxDCo
         578epfI6p3PcOkp2ifmYaf1R1ZsJ9+ZNRu3Ywjvv9LilhJ1/reN5beRp7KipEF1ChBPJ
         q6F89Nl/S9Y/p685l4/OBobPovbmLxcWxdreh8hUJSSeuY5XGmU2c/Py3y6HP8T6saac
         TLOw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Kg359oR3QSLtzKodiA0z4fCpyEOPP1Mjmu8CqQ1cwUDsDB37qmqCHkfATYdLxcP/tmEWdpO2vUhlP/R8ovZSgXkUMewrdI0EPgTF
X-Gm-Message-State: AOJu0YyWdbQDYIOw7Ktg+xj5Hg6BYGBU5tPLlqIzOPc7VZKsK5AKzZ0y
	4hPmtEjz2gmEqs5l0s4iIzvIhy4gXrLGT9W+EWLxF1K9xiFofFVua/DBOEUNVVkyRtPNsS1vGt/
	m9y7gXPtTF1VxWLTxxHYGVp4UTgvD2je7lAPG0w==
X-Google-Smtp-Source: AGHT+IGM19hvzO1rpuqaHQ4CbSztmE5as45qmfX1rA+MbFRDVnMQFujgVaztKZjv/5oq0oDW+cPPID80fr9iB00GHII=
X-Received: by 2002:a05:6512:2009:b0:52c:89b3:6d74 with SMTP id
 2adb3069b0e04-52ea0dcc74cmr2477917e87.6.1720290394651; Sat, 06 Jul 2024
 11:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703181132.28374-1-brgl@bgdev.pl> <20240705170440.22a39045@kernel.org>
 <CAMRc=Mc8BxJ+8U3gs1yHX=a3ZFcfqn+Dke6Rz_LcAOeqT3Cjmw@mail.gmail.com>
In-Reply-To: <CAMRc=Mc8BxJ+8U3gs1yHX=a3ZFcfqn+Dke6Rz_LcAOeqT3Cjmw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 6 Jul 2024 20:26:23 +0200
Message-ID: <CAMRc=McHVQ8oRz=dm2Zu39pV49r2QWRg5eiJ-HoqhepYtZXDXw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 7:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Sat, Jul 6, 2024 at 2:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed,  3 Jul 2024 20:11:27 +0200 Bartosz Golaszewski wrote:
> > > [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115=
c
> >
> > Doesn't seem to apply:
> >
> > Applying: net: phy: aquantia: rename and export aqr107_wait_reset_compl=
ete()
> > error: patch failed: drivers/net/phy/aquantia/aquantia.h:201
> > error: drivers/net/phy/aquantia/aquantia.h: patch does not apply
> > Patch failed at 0001 net: phy: aquantia: rename and export aqr107_wait_=
reset_complete()
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > hint: When you have resolved this problem, run "git am --continue".
> > hint: If you prefer to skip this patch, run "git am --skip" instead.
> > hint: To restore the original branch and stop patching, run "git am --a=
bort".
> > hint: Disable this message with "git config advice.mergeConflict false"
> > --
> > pw-bot: cr
>
> It conflicts with the fix I sent separately to add include guards that
> I had in my branch as well. I'll resend it.
>
> Bart

Actually this conflicts with commit 61578f679378 ("net: phy: aquantia:
add support for PHY LEDs") that was applied to net-next recently. The
resolution is trivial - just leave both sides as they are. Can you
resolve it when applying or do you want a new version after all?

Bart

