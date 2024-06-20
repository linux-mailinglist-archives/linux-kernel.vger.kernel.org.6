Return-Path: <linux-kernel+bounces-222814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4691080F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7B1F22123
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33131AD9ED;
	Thu, 20 Jun 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT+9c9O0"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832344F211
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893385; cv=none; b=Yi72RRZ5E5nApLD0L9iHjzptWhIigTeKpO0TIXNB5/bXiS6t5/XvQG42Xh1x8dA7kcvQKxzFNRMIel0pws4mdLPL7S6KygGITpxZj9o/e3eWbycbC/HoZjdducCI4/Nlzgs9YWjkehKZsOX/EE+uBO8c/BCs1RlS6aMwify/dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893385; c=relaxed/simple;
	bh=lH1VlXkhH97SqCNQ9Vi/TBDONgc7YCqdIXzLlk/Vjo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKLIgm4jjvft+SqtIvdu2S6jff610xUdvR8qE2Q7YE6uvElvGt1/5qJwPz0e2OkWxTBBmJXl6thIuPEIVA04uCfiJI67vAu6d3oOHngY+1U1J7AeFvtf5LUND84pgawB5TYMBM0+u9B+k4LpWvhoQe2vVhasHO2waczhI9adL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT+9c9O0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f1c4800easo101734866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893382; x=1719498182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0CBy4FKqWho9UEUVxmMefKmw1lL8tFVQrf3tj2spcY=;
        b=aT+9c9O0ahCv5MiN4MW5D4G5vFhAjvluZ3uZcW1vkxY9gEx5VjICx5DFF4FgZ7v7NR
         /96PVWKgEspKSVUSzfs5chAuMWTUzWHxg0I191+iwXkUTKVC8ruUsWJYLtHFyrYIQQHy
         XJXSRwbjfvxBQuy06P9FSwnjfEyG+6L/1KANn/QSXy00YIa1Yc4OnZwtSVhZKA97l8WS
         ibGAyciUkbWJpsVe/VoWxmF/Ni6AWMwlnRq3EQ3vVRo9Q6hfLSL9rmRubABnkltKUTG6
         6M44swkQfMXJmpTdKRQ2Z/Geddq73ISVLrpqeinUxaPBQ45Fhw4dAR9oIQev7QaC+N/Z
         Zx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893382; x=1719498182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0CBy4FKqWho9UEUVxmMefKmw1lL8tFVQrf3tj2spcY=;
        b=OaBskdpukVeq2tCECcAhfuTUAUJSEu9Yw0l/IPVR7ysskU5pbzpxXLnW1ceoKICQKc
         pu2KYIKqP8dQ8UZN4aUuJF8fWHixwhTTOISmKfN+ZdhP3TttXrzwMePh/KTeeSMKcI0i
         lBMjDwMTQsm9/hAcXFLo8Zmc9PTbFZU4qMGxwTMUu4FfPTgqxOQt0RzNi8r+3Ncvi1Lu
         oF1c4kF3ejIwrYY2EOvNYNNJ/CZktC19v3r1aqM+ZZOwq4S9Da56Fd2DBMAkjV2KM3Qt
         IxkRiuJTkBtfGcSBSzzZFsgzlA5fTqu/3DRU/ygl19HkIgUy3oqEj3z6DUpcr5ZbU7wE
         eO/g==
X-Forwarded-Encrypted: i=1; AJvYcCX2dvdfzfV+tlvVezfbJi7yKH9alwtERXlg8CmpZHCVTDhgrcV/7oLmhD1dKsl7+kUYDDOzQMDvUUg3XznlxuUEewsWzPQpnjldDTO0
X-Gm-Message-State: AOJu0Ywpkw9giLsAx0zNttbDRgjIEKdHOzmW0j03Wo9LlXYjwi4vQlpM
	blP+kM6X3k2Q8gFZ/DqDcVB7tAKZvgM6AemY5AaeP+m3NLIPCP9BtttKiQFSzlPCTPiI2B0Pmwn
	FgpnG9WoYdNDx9J7N5l+KGoMQrirpgaTNTnw=
X-Google-Smtp-Source: AGHT+IH9AgOYuujmCOL147Fr+nuBv1kxRRk+RX4FEgjd3RcfDME3sX8YBjtbwz4yxAV/0QZpQzJ3dRGAAx/ZTP5aMSI=
X-Received: by 2002:a17:907:8906:b0:a6f:c24a:7224 with SMTP id
 a640c23a62f3a-a6fc24a7411mr115165366b.17.1718893381614; Thu, 20 Jun 2024
 07:23:01 -0700 (PDT)
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
In-Reply-To: <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 20 Jun 2024 09:39:28 -0500
Message-ID: <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:33=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Wed, 2024-06-19 at 10:38 -0500, Jassi Brar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Wed, Jun 19, 2024 at 3:18=E2=80=AFAM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > Il 18/06/24 17:59, Jassi Brar ha scritto:
> > .....
> >
> > > For example, when static content is displayed on screen, the CMDQ
> > mailbox never
> > > gets shut down, but no communication happens for a relatively long
> > time; the
> > > overhead of actually shutting down the mailbox and setting it back
> > up would be
> > > increasing latency in an unacceptable manner.
> > >
> > Hmm...  in your driver,  startup() is _empty_   and  shutdown() is
> > all
> > under a spin-lock with irqs disabled, so that too shouldn't be
> > expensive. Right?
> > Then what causes unacceptable latencies?
> >
>
> I found that the BUG report only occurred when opening the camera APP.
> Maybe something in imgsys_cmdq_sendtask() is too expensive or somewhere
> else in imgsys driver.
>
If you move anything from submit() into startup(), which is once per
lifetime of a channel, it will only make imgsys_cmdq_sendtask()
cheaper.
Btw, the imgsys code is not public, I don't know how it looks.


> I'm wondering why this BUG report is not occurred in display use case
> which is more frequent than imgsys use case.
> Does this mean sleep() is not always called in pm_runtime_get_sync()
> and if we can guarantee this sleep() won't be called, then using
> pm_runtime_get_sync() in atomic context is OK?
>
Instead of hacking around, maybe try using startup() and shutdown()
which is for such uses? Maybe request/release channel as part of RPM
in your client driver if you are worried about the noise?


> > > This is why I opted for autosuspend - it's only bringing down
> > certain clocks for
> > > the CMDQ HW, adding up a bit of power saving to the mix which, for
> > some use cases
> > > such as mobile devices with relatively small batteries, is
> > definitely important.
> > >
> > > I'll also briefly (and only briefly) mention that 120Hz displays
> > are already a
> > > common thing and in this case the gap between TX and ACK is ~8.33ms
> > instead, let
> > > alone that displays with a framerate of more than 120Hz also do
> > exist even though
> > > they're less common.
> > >
> > I don't know how even busier channels help your point.
> >
> > > All of the above describes a few of the reasons why autosuspend is
> > a good choice
> > > here, instead of a shutdown->startup flow.
> > > And again - I can place some bets that PM would also be applicable
> > to SoCs from
> > > other vendors as well, with most probably different benefits (but
> > still with some
> > > power related benefits!) compared to MediaTek.
>
> I agree with Angelo's point!
>
Ok, but you or Angelo still don't explain "unacceptable latencies"
when your startup() and shutdown() are empty. You just want api
changed, which we can but at least do you part and tell me where the
bottleneck (unexpected latency) comes from.

Thanks

