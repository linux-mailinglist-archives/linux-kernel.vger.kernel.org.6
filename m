Return-Path: <linux-kernel+bounces-240073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF29268D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712EE2882CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810A188CAE;
	Wed,  3 Jul 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMh7eHXp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FD1862A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033632; cv=none; b=EB7RHMES4YZHjvVvmXqpod5gWc3sQhi2T4+yPTM1XN/RV2gITVa+X0bP5ajgQfGFAhrGpsAI+YNPKIg9h+EM8RpnfopttpyJR+Ok2P/sHW2T3gMIiEcPdNjzacwOTv39fZWQSNB26H+AWFDouKQAa7PAABoGCbcx7Nn4tz3sDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033632; c=relaxed/simple;
	bh=TEqcSO5UEcxu3Y9WGWUSnkXLMs2QJKWm2wfikBUpIzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjFtN3/M0wmPW7pa0i0ATx5ftdMKcn5NjzN38aS4Y+DtsaWlFDmcHG8pN6qrUwAmNSCNnm3MW1rWOrlljC5HcvwB+ho1Ffo1hMl5wN1FjkyXsg1G2gpoOoW8mevv2WVYlmmLqH5MK44Rwau2G/Xw2OdhuRgozX/kUn3F7/2QUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMh7eHXp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58bac81f40bso3058480a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720033629; x=1720638429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzqLcYmNlhaEa9iw+jtKoQZyVNKKD3jdk0VbO2iS/r8=;
        b=WMh7eHXpNHBerCPj0w5eFoOc3FYQTjk0GjBXiVSWPC3c0DPdDKBx5QoCatrQVjp1CU
         UiSIiBHP33lRiFAPjXsjpwv7RmoBFAhEtAC4jJpXaaOkpUSnrwepKOKySfpC2IbTTNke
         2evF0O+rumj8FJy4B14xBADTmcKQjHYsh1UJIDYHecvnFTGHn640bytNRea9TKjsrxGJ
         JRQ+8Kzke4jTuTsOK2bNq6f86ZDeKWn/VkkdQLjd8dJ5T+VJBIuCAkDz9pSBdz9h2ylf
         4Zv1PSjRetBTreBY1L4a8QVqGI8/e62qTEQwcgr6t/B6NPc63LF7fCa21edcSWQ7iCn3
         ZeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033629; x=1720638429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzqLcYmNlhaEa9iw+jtKoQZyVNKKD3jdk0VbO2iS/r8=;
        b=lxxiSwxE1TibN1Yq+NXYGxgMBFsBSEzj7E9YlxTYnAikgeLgq50ubiyQ8+1u252/A1
         tl0FzGUI9OvHmSCxlp3zOg5p19QK9gOSAzXMrQhLQODxM4iKr8xWOdOnlh72r8clfDVe
         ldraio2HKiQ/nunhRrpVTWt+E3Ka4TmcbRaAwkxen6yUu69BeSErtv8px2IawJ/jbRkH
         dOWIxDu0Afd8GBdoxddqPzRNEyOZErRriO5vJ/yRXL0+VuraYANwvx1MBDJoC1blbP/a
         bMgygAFhb/VpV9MzoSmE3NxGUlBV3d1XVV1l5p+gluLmbcYTUZWbeXqUPDXuOgk9h5E3
         Tm0A==
X-Gm-Message-State: AOJu0YzMl1h14Pv9H4SIZw8jqrC+MedSJEsuT4dYd/CBge9sEvKp0k+n
	kObA8ayeyGZjyI6ZAV+zaeF/DMVuXYJHiLR1eBwxgWkToQ4a2xKiGWTPWaKKafcJV0MOZJ7ObJH
	QNoRRLo+UrXX51cLznVRiyYcJyPE=
X-Google-Smtp-Source: AGHT+IFTvqGKg+d2P1MX6zFoO20UuDNnBH0NZJoGdJm/F+Ghp9HnoLsYjQOjQhwonC/vbbujybApLnU1klWdkMuzG50=
X-Received: by 2002:a17:906:fccc:b0:a72:548a:6f42 with SMTP id
 a640c23a62f3a-a751445451dmr802270766b.18.1720033629247; Wed, 03 Jul 2024
 12:07:09 -0700 (PDT)
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
 <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com> <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
In-Reply-To: <092d917b4cae2762317a8739c874855554ae913f.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 3 Jul 2024 14:06:57 -0500
Message-ID: <CABb+yY2-KWYORo_-ZWafyM0VJnh8-2wefvCpeDsK204qB0TchQ@mail.gmail.com>
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

On Wed, Jul 3, 2024 at 11:41=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Thu, 2024-06-27 at 22:40 -0500, Jassi Brar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Wed, Jun 26, 2024 at 4:32=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5)
> > <Jason-JH.Lin@mediatek.com> wrote:
> > > >
> > > > The idea is that
> > > > 1) If the gap between transfers on a busy channel is ~10ms or
> > > > more.  And ..
> > > > 2) The silence on the mailbox channel is multiple of 100ms. And
> > ...
> > >
> > > The mailbox channel would not be always busy and the gap is not
> > > consistent as well.
> > > For example, display driver calls mbox_send_message() every ~16ms
> > while
> > > UI is updating in 60fps.
> > > If UI dose not update, display driver won't call
> > mbox_send_message(),
> > > so user may not has the gap and the silence like this.
> > >
> > From your logs, send_diff only increases from 16ms if the UI is not
> > updating. Which makes it more prudent to release the channel.
> >
> > The user needs the channel for mbox_send_message, while actual power
> > saving comes from cmdq_runtime_suspend/resume.
> > So for your target usage pattern, trace mbox_send_message() ,
> > cmdq_runtime_resume() and cmdq_runtime_suspend() and compare the
> > timestamped logs with and without this patchset.
> >
> [snip]
>
> I realized that we have 2 cmdq drivers:
> display uses 10320000.mailbox and imgsys uses 10330000.mailbox
>
You may disable one to make it easy to capture.
Make sure your kernel prints have timestamps.
Over your patchset, apply the following diff and execute your usecase.
Then share
 $ dmesg | grep Jason

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index bafcc7b0c0b8d..90c0620c0ae63 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -284,6 +284,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mss=
g)
 {
  int t;

+ printk("Jason %s: %p\n", __func__, (void *)chan);
  if (!chan || !chan->cl)
  return -EINVAL;

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
b/drivers/mailbox/mtk-cmdq-mailbox.c
index 02cef3eee35a5..6436e1b22f353 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -317,6 +317,7 @@ static int cmdq_runtime_resume(struct device *dev)
 {
  struct cmdq *cmdq =3D dev_get_drvdata(dev);

+ printk("Jason %s: %p\n", __func__, (void *)dev);
  return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
 }

@@ -324,6 +325,7 @@ static int cmdq_runtime_suspend(struct device *dev)
 {
  struct cmdq *cmdq =3D dev_get_drvdata(dev);

+ printk("Jason %s: %p\n", __func__, (void *)dev);
  clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
  return 0;
 }

Thanks

