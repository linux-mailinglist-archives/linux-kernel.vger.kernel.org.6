Return-Path: <linux-kernel+bounces-219806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CC90D7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752CD1F21F11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284F546450;
	Tue, 18 Jun 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFAMGTRO"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EA4596F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726354; cv=none; b=pVpdEpFL279Pa6gluu14t3S666ScmbCQvc1otkDx6hPvpvMmVuic8hocTY5wfsY3tyc9ylz4kSL1dxGjtZwF86hILhze6Fs+svdFZUfwReErKIY2ZURqjmwyfq7Ww4j7refzFunMLNR/OtuBn+TNZCOE3/F72fhoPX3mADAbdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726354; c=relaxed/simple;
	bh=5oZ0AwGMLAJJHw2epqD7XqOCUyUz3rxpE12RQUU/9/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOOeLB7sQjToNSeFH7f0COTS6scqeAIpG+aXY1M32wF9pCQg0HgU5ZjTwcOLo4BxnVhMmAx6mrXVGIuIrUKPZtLeT14qltJyTZp5bWfSXTT8I5a15IqO00FVIrhRgPx8M6SVXFr/o0Rk3XAxBGXdrYwTFw315b5dMXYdJjGxXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFAMGTRO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so3385119a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718726351; x=1719331151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oZ0AwGMLAJJHw2epqD7XqOCUyUz3rxpE12RQUU/9/E=;
        b=MFAMGTRORtdSqqljESlIysmIC46wgBQLikDzaPHls1k0ypXqwgFUeK0N+lIv4NCdhJ
         aPNPNWggQtKWlEEfe+NQCQfppYdKiglVfWvJUxb+2k3wDmzD4pft/iQb8TifmqCizUNo
         dVarf9ZN/gSm03JRvQct3orWTBQXKpjebinus9MHQu9k0ff75kAQMr4iwQEnJ09HWFAr
         f5MWVQc+fD4jrs9Reaza50Xh5QPLkdTMzt+G1ImVXxdYL8TQcSGFDByPRV8rGvjzFddu
         rwAFqd97kmWvjf1uxwm1QMTdbXXXVQ3WCBN1MO4p2D6VNdH4tEV9XbeCUSZHD47KhnZW
         FENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718726351; x=1719331151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oZ0AwGMLAJJHw2epqD7XqOCUyUz3rxpE12RQUU/9/E=;
        b=vl1VdBSugkQqWAphsmjZ4vFc8e+fdLKcNvb7VWFeXxdr90JjR3+rfxZs/23YiDyj6X
         ghd0JZxoq0Em0uA+fgb8ZgU0KIXzS67cdXufVIHAzdpbSjaQTmkHM4wZeKuTqKnNN28O
         WdX4q5JDTLBcJyIhOxX+BCj5x7osV0l+9dh1BxxW3X+fal4uoszSZotNLJHakbrPa/0b
         YCXGs3E9oFZYuQsrfful4pcKps6D85mPDQFwTDk5Ctu3hyS0Xu7VvbmfMu1HnLnBbDKL
         Ce1OH9xEUWNbo5LWaJPNLTMQa84z0XrgCZwH3vcRyiYTLhc69p9yQZdAH5WcuVlPev4H
         NP3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyzaZh8C8JRkUMbGEO3tgpEwDoPh43/avJyYH4yAFQ04p8W8BfPZ9hMM/d8Tbcb00pOv4TS/xWjK2rxpeFPn97F2rSCwm35AhcuQWG
X-Gm-Message-State: AOJu0YztqJ3UJx6li3yVaZCoe70imUHr8njFTbw9080o36W7PETo+jhz
	DPyGkPOfWZJOUBxX57vViKkbJdCdLVTeSzzNYAQ5Kg10bufEkYb5a77gkLapdhzSSd5/Ev6p/7b
	KiETilIq5tu1E8ltVjy/5n1QhDPM=
X-Google-Smtp-Source: AGHT+IElkkUK4RJSU4a9gzsjtuQ74Vg1wXqUlx1l+0cTTgPHxK8Efp3nkLznkDcUlOZBRHI0bNvpIXCY4+r/yIj+rLw=
X-Received: by 2002:a17:907:d312:b0:a6f:668b:3434 with SMTP id
 a640c23a62f3a-a6f668b35f7mr1009094466b.31.1718726350815; Tue, 18 Jun 2024
 08:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com> <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
In-Reply-To: <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 18 Jun 2024 10:59:44 -0500
Message-ID: <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:42=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Mon, 2024-06-17 at 13:18 -0500, Jassi Brar wrote:
> >
......

> > As in, how often and long are the "channel idle" periods? And when
> > active, how many transfers/sec ?
> Is there any debug logs in mailbox can measure this?
>
> This mailbox channel is use to configure display hardware in every
> VSYNC, so the channel idle periods may be less than 16.66ms.
>
> It should call rx_callback() before VACTIVE, but sometimes it will be
> dropped by mbox_flush() if the new message is coming.
>
> > I see every TX is acked by one RX packet. How long is the typical gap
> > between a TX and its ack?
>
> Typical gap between a TX and its ack is less than 16.66ms.
>
So basically the usecase is driving some display at 60Hz. And I
believe the display is driven
continuously for at least some minutes ?
If so, RPM between xfers is not really in effect because the
autosuspend delay is 100ms while you
get() it every 16.66ms. So all that is happening is some variables
changed under a spinlock.
I think you should consider get/put RPM in cmdq_mbox_startup() and
cmdq_mbox_shutdown().

Thanks

