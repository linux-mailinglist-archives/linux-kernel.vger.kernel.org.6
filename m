Return-Path: <linux-kernel+bounces-242739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E493928C69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB3B24761
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5E16C42C;
	Fri,  5 Jul 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0HRefP9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABB2F32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197840; cv=none; b=Xp90PISDQNjxySrJRp2MzuhjGsJehKFMKigYtTJ5ORrxbc0tbC75c5KuLFZXBnG05/dHl1jTRV1G0Oum1FzTeaerhcoIxHfCp4FAs9l5eiG79aXmujwwDYSJxchoVAwGm75LZtQEWYbzBq9dDlwYnB9bXW2YU5CglVxv1T7UQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197840; c=relaxed/simple;
	bh=iPqi9oX8Pg+KoXl3Dj7ioxuGItMxwCEJOz2c4ptlEr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK8/phgfSci1XWQQNW28Ci/NH7QGsEhHNTcHpv2jyk6mBc6GJwQ5ey924bEKo6+L8Rs6NAlMozxXKa0M+n8/0RdQhLp8PK3Ry9BpxGOnYgHDnIfbL/f6l14XzVyDM6hFTjiX9OAyiI5OM2ybV0uGP0zZhqN3jvYWxTtCx9+TJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0HRefP9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77b4387302so235381166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720197837; x=1720802637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJenFuhYTgsk0Co2eVcbS7MuCtTS3fgyqVgRI/D0SG4=;
        b=c0HRefP9S3EGtTk0LiCE1BRzTy94lysH5HfMe72dP9aYyVerxr6cD+8R9BPqXgYXMs
         EgvLAlf1WqUoxPBAdGVON7NCE7cvXvEHswvlfGQxzmaho3ntftAbSt5aCdC+DRyXsO6P
         Uwo5Okf6w94nwp1NJY7mjzpMNL/efav93LjSouXqkfVrCH1yNkTQGPmQ5rG3wprPtBOb
         uZhhq8gT5l0HXhAC5njjc8wi3LooKQEcyr0ulDP426MbTsSyLPA/KmYPhLtVOH9ygZhJ
         3/pkheFIlxHKDxiB6VCMqviW+GeSDY6dzrsbcObYemYIf3LrftMiExIRRv/bjNU9KyKE
         Y6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720197837; x=1720802637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJenFuhYTgsk0Co2eVcbS7MuCtTS3fgyqVgRI/D0SG4=;
        b=oVF3n5tnkcqNDntSDs1lT1GruW6bfPOladfnlvbcjJxmETltvbcGZA+dFFahamaWUU
         SHZdL6BDmDRJLaJJNNqB4qR4R+fUTMZy7e5PLPNy0i9ZVl5YvV+Ifd2z1yFL5YjjtU9F
         XT6gTYd4ZR6hG6D2ZdB7ZDI9+M40I18crL/ddW1ag/UtymtYywh8Ps214Y1jrpEuXdSF
         TwCY/0o+UPI6pkDx/N/yXjeCF5uvyEyX8Rpg5shMx9gFQ+q8ts/jVIVohsn5m1dDqPbH
         xmtew0HxOTNhgV5LeJiqjJZ8sFOo2kvZwoNoN73fcriABRxzyWtWyQIRrfivMTYQWP11
         4liw==
X-Gm-Message-State: AOJu0YxZA7u3xYn98a1Ps4q/k69t/2WA4fWc/e3De5sF4sIFArV4tE+B
	BuAcQ9qX8MVsJXQtu6V8se4CcjpBNqrQmOnF2ixpacYLezNf8NaESj6RyTpPpuJWzRNxbLc0C3m
	1aWZPDNtZuiG+O8etrn0OS0TN5qg=
X-Google-Smtp-Source: AGHT+IGcaZiB45U0dGEbln18cDiJd3sDca+NpmXy0yPlfGtDlVRVgn7AC9FOVqrMmcrnP05WjpdOAvlQdl8HbklmSXc=
X-Received: by 2002:a17:906:17c4:b0:a72:9963:eb8e with SMTP id
 a640c23a62f3a-a77ba46f9aamr317906466b.28.1720197836518; Fri, 05 Jul 2024
 09:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com> <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com> <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
 <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com> <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
 <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
 <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com>
 <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
 <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com>
 <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
 <CABb+yY2-KWYORo_-ZWafyM0VJnh8-2wefvCpeDsK204qB0TchQ@mail.gmail.com> <3f655bc4e1e60cd5e0dfc9baa018553fa8892826.camel@mediatek.com>
In-Reply-To: <3f655bc4e1e60cd5e0dfc9baa018553fa8892826.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 5 Jul 2024 11:43:45 -0500
Message-ID: <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:11=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> [snip]
>
> > You may disable one to make it easy to capture.
> > Make sure your kernel prints have timestamps.
> > Over your patchset, apply the following diff and execute your
> > usecase.
> > Then share
> >  $ dmesg | grep Jason
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index bafcc7b0c0b8d..90c0620c0ae63 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -284,6 +284,7 @@ int mbox_send_message(struct mbox_chan *chan,
> > void *mssg)
> >  {
> >   int t;
> >
> > + printk("Jason %s: %p\n", __func__, (void *)chan);
> >   if (!chan || !chan->cl)
> >   return -EINVAL;
> >
> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
> > b/drivers/mailbox/mtk-cmdq-mailbox.c
> > index 02cef3eee35a5..6436e1b22f353 100644
> > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > @@ -317,6 +317,7 @@ static int cmdq_runtime_resume(struct device
> > *dev)
> >  {
> >   struct cmdq *cmdq =3D dev_get_drvdata(dev);
> >
> > + printk("Jason %s: %p\n", __func__, (void *)dev);
> >   return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
> >  }
> >
> > @@ -324,6 +325,7 @@ static int cmdq_runtime_suspend(struct device
> > *dev)
> >  {
> >   struct cmdq *cmdq =3D dev_get_drvdata(dev);
> >
> > + printk("Jason %s: %p\n", __func__, (void *)dev);
> >   clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
> >   return 0;
> >  }
> >
> > Thanks
>
> It seems CMDQ driver is not suspend over 100ms.
>
here are the time deltas in milli-seconds
10 6005 52 85 304 59 27 203 29 24 25 38 33 57 34 20 41 28 36 48 71 35
21 45 51 22 30 46 46 23 16 16 16 16 16 17 17 31 16 19 31 16 16 17 16
16 16 32 17 32 17 30 21 16 32 18 30 28 25 29 24 31 27 16 17 19 34 30
15 33 16 35 35 29 18 31 16 16 16 16 17 33 35 33 39 20 21 14 34 49 22
42 32 13 21 24 9 130 23 32 35 31 32 16 18 31 36 37 26 14 68 76 111 515
452 64 484 487 497 501 507 161 336 516 486 495 504 495 504 501 500 495
507 495 499 505 496 502 501 502 500 495 501 507 499 499 496 506 501
498 507 490 504 496 501 506 413 28 207 31731 34550 3784 30 23

For detlas <100 we don't expect suspend because your set
autosuspend_delay to 100ms.
For deltas >100 you should have seen suspend. Apparently the changes
you want in the api still don't help you.

Also I see messages are being submitted on 4 channels, but only for
the  '000000000a4d37b5' channel cmdq_mbox_send_data is ever called.
Unless you selectively printk only for that channel, your driver has
some even fundamental problems.  Maybe trace without your patch and
with pm_runtime_xxx commented out (to avoid stack dump).

-jassi

