Return-Path: <linux-kernel+bounces-294658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0D9590FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78F7B21EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73621C8FAF;
	Tue, 20 Aug 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CLUzd94D"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB62C18C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195797; cv=none; b=pAob2ltzmInMsFIKSLSIb9Lq6AsE+ocsVNp4LVibf7SoUxmB2tbszq7ylQOHaNsd+30ul6UpuYEMr5pYEz2hUo58/hWTbWV54795APhaOf3/SpzqPhipMQqyUTGW+uKiqQlWB2jwwJzQmzCL+fwSQEDaDhR8s0aeb+XMGL8uads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195797; c=relaxed/simple;
	bh=WZfzdv19Ccv9KUaSF46EvtvrvJ5XeavHq/pzmaJLqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJDas+6MroN/CS/rlrbSKHmN/hwzDyQTlMX+s16aruaikJtUBTUmCc4B2hjrXEjAFUvJXYTfanOrWpyeMDk+XAus36b7wxMLhWy1e/gAyjsNaKsxocKawzkEzzyGoDFKhr2j7CQgLPAYrXaHXbKoXkeTaDQakOOTgyciddKdbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CLUzd94D; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d41b082aecso155602a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724195795; x=1724800595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrZS09AovuuFmgGLEUEH4wrKa3bvYx4Fu0tek9TXx4s=;
        b=CLUzd94DSk91+TackRw6sGuHQ0w3EC7Dl9qbyBhnroD06JX+2lDUy4TLqOS3G3KISV
         TdRqYEg1priiD74dZ83XlFmpsqE8PhbjVSX50NE6cIGnTdnr9jEPa99JvLmT9ARW6lk3
         gOAoMTKS6dG9BoWoSHk0FSu3/mAIqA2CmW/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195795; x=1724800595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrZS09AovuuFmgGLEUEH4wrKa3bvYx4Fu0tek9TXx4s=;
        b=f+UUVxfjxzyK8682fEaY/IKoOzEcqMFpLVnZMh3u0H1/SWm8bzdc7pl1iJdeHb9jjK
         4CIy9UitWqZy0AFsjG+MUcFZWQWSNKA0kt1/zrNQmu2eTsQa28id8W0rWq3H0DImqgWN
         /o2DK5yJHmlV5iHokw5lU2z6d4jjWcVgHW3sBLdRl/lT3AzoF7tiHb7ZPtzc1pbNK7Gn
         AxGPVVr2MYU7P8EjVQAS0p3yFUFh+73DvHEgtlriseuOAGqhhxmd/MSnaJLeRUJUb35Q
         LQRVIJd6lAqzBD9J5PwWXESiHRwoZnLxpNlc/yjaZ9veeI06La5PPbvzs4AevD6L+po8
         LbSg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Tp9LAKJqFkBGry/w/TxUcojneleIoQyZo9F+Nu3A9ge7F6R6lzjRUJ3uMlIEFK4xE6qvx4VWUQdlj4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3o0XE8MazaK1I80Oeb+AZruvRQ5zVq7O+/cdz+HcxY7rYwU6I
	CUk7pk4ZzCQVMYm4rQ/vdn4LufDMgKWfhmLdY1XokgMRyyXjAB5kbFqs2BFERTB9EKQdAW7FqCZ
	GxdavycWeGZbG6dC2HXRt9fp/mjrFbBCkyIZP
X-Google-Smtp-Source: AGHT+IEI+l6X7IR9T6pwKkJ8QZSEtEMczJRLjGREA1pdtgbdvp3Hq8ZiAk6iRl1Auq3JsoyP4nTpyh2MJh7WV6WdkT4=
X-Received: by 2002:a17:90b:1953:b0:2d4:91c:8882 with SMTP id
 98e67ed59e1d1-2d5e99a5c36mr770336a91.11.1724195794885; Tue, 20 Aug 2024
 16:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com> <20240816112741.33a3405f@kernel.org>
In-Reply-To: <20240816112741.33a3405f@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Tue, 20 Aug 2024 16:16:22 -0700
Message-ID: <CAMdnO-LT8gChytPpw0HWqkJvL-=OWqHOY9UUj1gEXawyC=2TWA@mail.gmail.com>
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 14 Aug 2024 15:18:17 -0700 jitendra.vegiraju@broadcom.com wrote:
> > +     pci_restore_state(pdev);
> > +     pci_set_power_state(pdev, PCI_D0);
> > +
> > +     ret =3D pci_enable_device(pdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pci_set_master(pdev);
>
> pci_restore_state() doesn't restore master and enable?
Hi Jakub,
Thanks for the feedback. You are correct, The pci_enable_device() and
pci_set_master() calls are not necessary.
We did more testing without these calls.
We will remove the calls.
Thanks

