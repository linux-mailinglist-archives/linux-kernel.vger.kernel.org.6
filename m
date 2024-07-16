Return-Path: <linux-kernel+bounces-254244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF859330AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31441C22AED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37EE1A00C2;
	Tue, 16 Jul 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YZeiCBxt"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783CE1643A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155755; cv=none; b=Kv7HOJFdHynm+Bv3/pcKOF01xRXVQeFwYtzZ5vMZN5XV4MW/XNLjtqH0ggLAp9Q/eWDjBVBLjNiwYMD/xlSC5oexMv3oYQoGS4Ubur+IS1lZjkM9GCyKw/B7cj93S9wtRQQ3K/gM2VH2NCFxyE5q3aLJghfOPvGAx/t1VFYsZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155755; c=relaxed/simple;
	bh=cF3LVwQ6uUCjs8vvD7smezICijmUnzP/qRxxOPn0ueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nouRz4LSndBCq69v2QnQMbDKfix1Kp2KvGUjEJ1tHEN3tUXFBAht5+5Oq6wYQ8b1F8mtC7Rxs04cszX0rYr/9hlR9iyTWq3L2aoQckBN45t+nC12lvPuZdwyNq26PmxIy97iKPmhGJpYEhh+2bmxqDz+7/dNmO+yj7XO1F3CxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YZeiCBxt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee817dac89so417841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721155752; x=1721760552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KhgLmJzF0SWWsLaDdoCGwx7sJaZZjiB4NDQ1hg4zPI=;
        b=YZeiCBxtSR3k8QS8qBZEhIPv/LF7JY9wZPhZV+Ll5T+w+uWwySlJ8V6MeLiTM5vOhB
         2BM2GSUL04dpiLGk9slYqbyG8rGfE+tP18j2SlIr8r+20uip4L2UNxZSFD6twSwuhHpq
         ZpuYLtRAycQbKDQw4LVbudB9tIpd3QFifUZOEUq5cqloVpgexU7XkpTM5vpMugtUosi2
         seXiOJO7RX/cbXTcuhxuUW1HP9vWaleBXjuQZsKUpL2swATJ2wOgEiVCmA/Iu+bOG6zY
         u/oT8czDVIkj8blkjT+DiPDBmujabEzDj89M1h1f9H92pbXCFs0uiRClhWDJXJXfNezK
         DhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155752; x=1721760552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KhgLmJzF0SWWsLaDdoCGwx7sJaZZjiB4NDQ1hg4zPI=;
        b=SuFY6zXoSt5QhdktNEPnmE72HpLfL6hrByDE3zeeQZA0hLHrbp3+qOqChItuqRvavS
         enD5oPApnyOacpPUcssIUgnDpsOZewhyIKBZjw+V7RPPkZgZ17FdtSrWXK34IAySYVMl
         v0HG7l+7nawL52NI5RlMd71iPnam5U2KCqJ1H0R6VVZO6yeuHvsWSqU7s++v+pjGE8oO
         PgJCh0cpu/TdB+rG3xKRDsxAbiRfnVmIQAIeRpzQkCj20px873YNdh1RxH9O/vHbI6+w
         lwyKLh8t87qSBSdP3zgdyHTj8weJx0pMpmqYi8VPp2Iy+QpGfkY2+Wag8bGSJZK6dqMy
         Fb1A==
X-Forwarded-Encrypted: i=1; AJvYcCXtS+eoxuLv0RFC2jxcQpEHw6XikjGWIkw1V68z7+xQotEwAJXuOTrfLZauzI2tbzoo3Yonnb8ATfovwcrU/Gw0rNZSNqgY62v0xVlu
X-Gm-Message-State: AOJu0YxMOaNmzLGMLpEQzZRLI731ubLM2zkzna35E+Om0/LBNaJ3VrEA
	EeF/MB4eEwJaJHRlwp2ZJgdf+BQdB7TolipYCrXmPmERXiSs2Yd+XNwZKz3v6C9TQ9gPk6fk1xy
	IEKwCXKE0bhiwXmlZVAs1tlRlcLOfC3DSorzxug==
X-Google-Smtp-Source: AGHT+IEZMw76FXm6ot0bsZAM4mhixLO229IEyn6XfMcbFPHJP6T9l/LLjNPp2I7LLmbp65K6cGxGFYcaG+fuqjewhOY=
X-Received: by 2002:a2e:a609:0:b0:2ec:5324:805c with SMTP id
 38308e7fff4ca-2eef56c6298mr8166411fa.11.1721155751656; Tue, 16 Jul 2024
 11:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org> <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
In-Reply-To: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 20:49:00 +0200
Message-ID: <CAMRc=MdvZQSwC93MuAse2cGuKpNCHO+0jGOjMRNyXYwvCrY_dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check for the existence of 'dev.of_node' before
 calling of_platform_populate()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 01:04, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > -       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
> > +       if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_b=
ridge(dev)) {
> >                 retval =3D of_platform_populate(dev->dev.of_node, NULL,=
 NULL,

While at it: you could replace the dev.of_node here with dev_of_node()
too. I seem to have missed this helper.

Bartosz

> >                                               &dev->dev);
>
> I think you should just drop the IS_ENABLED(CONFIG_OF) check entirely.
>
> afaik, dev_of_node() already returns NULL if CONFIG_OF isn't set.
>
> So the bug was literally that you based the decision on something
> pointless that shouldn't be there at all.
>
>                 Linus

