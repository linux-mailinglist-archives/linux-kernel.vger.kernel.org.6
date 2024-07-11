Return-Path: <linux-kernel+bounces-248554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E094092DEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D1B21B45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C41A291;
	Thu, 11 Jul 2024 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9rrBC5z"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627DEAE4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669666; cv=none; b=mwdPNvDTh54U9j5nXbE9GtPf6jIyGkQiGQ9kL2EfNg89ERwwyJiSDtBsm6nzLs5G2tO2gTM2VI+hxv5l8v91ZghlQouiy9Xrh2qNt1wzCTWH/TGuS0opA/jfqQVUT2pWA1z7PsPOpUuJGP4gvY6Oky+SOlJsc0QUaIFQftq/+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669666; c=relaxed/simple;
	bh=LQavSO2QkuwioyYFJztw0bAnwpOeE/gQ4pDRDvQFYSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1UAbX6mMtuPqdw3N4n5m1EJjM+sC4IgrcfgVhTnQ3vNj/YfB5MbrGGNaGyEt0Bg0v9jr23OGHt3F4kv8/TLUSsLh8VfTEdgN/oqWtdbC1+0fzxVcpkRFxtIHi/w0ybUeFmQd+SUQBQ8Tqt12kQyRFS7Sy3hBQ/wStSGth3sqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9rrBC5z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c9d3e593so40623166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720669663; x=1721274463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpOmGWaPs+ZJZCC0I9Q/piIlH+/AVFYjnCcsvYrQiVE=;
        b=F9rrBC5zthSJzy7v/QL6zzuU/5mj4qHuuciseoS6NKwjVooT1QjK01q31jO/X8KTcg
         DGBuyfvrSvhlhcB6VbjEXtc+reRaOENXtyY2SNs98JN9sGSGxfMv011hkMnGd1p+ZYGK
         X3//BvkxkcVForU5HdI6Mo7ebcPnF0FVXw6qk7bjBEDaGKm/UmqKhUSUaExpomYr2YTw
         o/lbYu5Ly8UeBLxnPqcRQw176jzZg5ds3VlMCyNOC/2wabr6UNEbJ87q9/ac6HjU16A3
         Hp3CFE+obn1fmiB7IPEdc5yaQH2QR6BFLDhdeCOx/P1LAZ12SLw+sQvVfkTMr3Ro/2K8
         DNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669663; x=1721274463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpOmGWaPs+ZJZCC0I9Q/piIlH+/AVFYjnCcsvYrQiVE=;
        b=l2Ywy7AdHRuhEqLpuQ7oNH5CcC79Ee5ODkJwvjZ/xcgGrMVKUL+fbGqJ0uKV6rorvG
         7sW2KGRC/xKKQVMTG2kyr7drHWbazK1Vz5yIsE7EQOdOUS6Q00gsA23U86f3NZ73lWdX
         ktB/nNjxrtzn0Lhi2i0ziqAZEhd0nQ7O1tf3LBNkTNK155DsU9ckPyyL30bc30z+D8sq
         kctcxZydHpHvYSEYbawfiTxqW9HqpeqU+gZD7xQtNd7B/gQ7Y4HMrDUK9vYmIUrWa3MA
         ZFVWKqZC/sZG8vyYE+Ew7lbWGzwJq0ias/zONf73bUq88rWZyxvnuxwTUrjKNeLvvfqZ
         ZLUg==
X-Gm-Message-State: AOJu0YxIUQxuedqXG0uYWPsoPzP+WXYEi15VYtdflr0w9pjbyjhwwna/
	LxvWMCVRLmiiRj2S6OShBV9dLHD0/J5HO9wd4lPRsX5EnKneDocoFZBONuvTtQ1QBejooUxzbQ1
	VENReD5uNviX45b+Fjn7WTD5VtDw=
X-Google-Smtp-Source: AGHT+IF5f5jDWbiu4aJ26+hkrJW6To96uJgmyGIL+WmqbDVbCZWbe++pKvx5M9RDu3QukliDRRQlxs3XRKIjVfg5Kn0=
X-Received: by 2002:a17:906:a399:b0:a6f:b5cc:9190 with SMTP id
 a640c23a62f3a-a780b6b18d7mr416400566b.28.1720669662677; Wed, 10 Jul 2024
 20:47:42 -0700 (PDT)
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
 <CABb+yY2-KWYORo_-ZWafyM0VJnh8-2wefvCpeDsK204qB0TchQ@mail.gmail.com>
 <3f655bc4e1e60cd5e0dfc9baa018553fa8892826.camel@mediatek.com>
 <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com> <e860d67f578f1963d785dcc0423936fe5de20547.camel@mediatek.com>
In-Reply-To: <e860d67f578f1963d785dcc0423936fe5de20547.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 10 Jul 2024 22:47:31 -0500
Message-ID: <CABb+yY0mYrUyfpNLVKZt2aDdzZPf+VjawcwVSpMG8H_=pwKLbw@mail.gmail.com>
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

On Wed, Jul 10, 2024 at 9:00=E2=80=AFPM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Fri, 2024-07-05 at 11:43 -0500, Jassi Brar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Fri, Jul 5, 2024 at 1:11=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5)
> > <Jason-JH.Lin@mediatek.com> wrote:
> > >
> > > [snip]
> > >
> > > > You may disable one to make it easy to capture.
> > > > Make sure your kernel prints have timestamps.
> > > > Over your patchset, apply the following diff and execute your
> > > > usecase.
> > > > Then share
> > > >  $ dmesg | grep Jason
> > > >
> > > > diff --git a/drivers/mailbox/mailbox.c
> > b/drivers/mailbox/mailbox.c
> > > > index bafcc7b0c0b8d..90c0620c0ae63 100644
> > > > --- a/drivers/mailbox/mailbox.c
> > > > +++ b/drivers/mailbox/mailbox.c
> > > > @@ -284,6 +284,7 @@ int mbox_send_message(struct mbox_chan *chan,
> > > > void *mssg)
> > > >  {
> > > >   int t;
> > > >
> > > > + printk("Jason %s: %p\n", __func__, (void *)chan);
> > > >   if (!chan || !chan->cl)
> > > >   return -EINVAL;
> > > >
> > > > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
> > > > b/drivers/mailbox/mtk-cmdq-mailbox.c
> > > > index 02cef3eee35a5..6436e1b22f353 100644
> > > > --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> > > > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> > > > @@ -317,6 +317,7 @@ static int cmdq_runtime_resume(struct device
> > > > *dev)
> > > >  {
> > > >   struct cmdq *cmdq =3D dev_get_drvdata(dev);
> > > >
> > > > + printk("Jason %s: %p\n", __func__, (void *)dev);
> > > >   return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
> > > >  }
> > > >
> > > > @@ -324,6 +325,7 @@ static int cmdq_runtime_suspend(struct device
> > > > *dev)
> > > >  {
> > > >   struct cmdq *cmdq =3D dev_get_drvdata(dev);
> > > >
> > > > + printk("Jason %s: %p\n", __func__, (void *)dev);
> > > >   clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
> > > >   return 0;
> > > >  }
> > > >
> > > > Thanks
> > >
> > > It seems CMDQ driver is not suspend over 100ms.
> > >
> > here are the time deltas in milli-seconds
> > 10 6005 52 85 304 59 27 203 29 24 25 38 33 57 34 20 41 28 36 48 71 35
> > 21 45 51 22 30 46 46 23 16 16 16 16 16 17 17 31 16 19 31 16 16 17 16
> > 16 16 32 17 32 17 30 21 16 32 18 30 28 25 29 24 31 27 16 17 19 34 30
> > 15 33 16 35 35 29 18 31 16 16 16 16 17 33 35 33 39 20 21 14 34 49 22
> > 42 32 13 21 24 9 130 23 32 35 31 32 16 18 31 36 37 26 14 68 76 111
> > 515
> > 452 64 484 487 497 501 507 161 336 516 486 495 504 495 504 501 500
> > 495
> > 507 495 499 505 496 502 501 502 500 495 501 507 499 499 496 506 501
> > 498 507 490 504 496 501 506 413 28 207 31731 34550 3784 30 23
> >
> > For detlas <100 we don't expect suspend because your set
> > autosuspend_delay to 100ms.
> > For deltas >100 you should have seen suspend. Apparently the changes
> > you want in the api still don't help you.
>
> I think "deltas > 100 ms not autosuspend" and "calling
> pm_runtime_get_sync() in atomic context" are 2 different problems.
>
Fixing the first may avoid the need of the second on your platform.

> >
> > Also I see messages are being submitted on 4 channels, but only for
> > the  '000000000a4d37b5' channel cmdq_mbox_send_data is ever called.
> > Unless you selectively printk only for that channel, your driver has
> > some even fundamental problems.  Maybe trace without your patch and
> > with pm_runtime_xxx commented out (to avoid stack dump).
>
> I've confirmed that autosuspend didn't work without these API patches.
>
You mean _with_ the api patches. right? Because I had suggested "Over
your patchset, apply the following diff ..."

cheers.

