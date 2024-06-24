Return-Path: <linux-kernel+bounces-227700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C39155A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D591F243C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC8319E83A;
	Mon, 24 Jun 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSiaM+xL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BA19B5BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251160; cv=none; b=aphmSTYeCUSwBSpt2bBiR/MAaJp2/+KV1yyYwK87NdRKM+u86YvtTI+DsAVwssf1NvVy2MAZTBR/oo23yTQvECcgzvh8spJa6XmgpZfzdJYS/g+SgDyZg+uLp5ics9+FlDjoH4QI08rkUvI9zior3VDdkbRHkx+X82mmGFqmPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251160; c=relaxed/simple;
	bh=5QZzthf4QIhoF2mbEheDkBRmFAebz/r8IKomEq+FEI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9clDxFMeHE1usH/WTdYSiw+yC6Uf4s1TdchuiOLu0tZSH/b6BSMCv2MphY7SxZa+TsDV/SJzLkREPgLdz26dLXdZ6EpEHaY9E/hzZgRAaBNIovwNE4KvTql9dtegLWCx4OZk9U/eulS98Yj84uVOxWeQEWCRS6eVETOjNeJyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSiaM+xL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7245453319so283950366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251157; x=1719855957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZYo2+ECZA8zTSTbRF5VYWEcTe4tY+q+w5/GiTenvpA=;
        b=NSiaM+xLwoR+VA+yVzkj3V8eybHCbHbg8d4+MYI9BVqv/I7eyH6ZaiL8RFU38nE4M8
         NhcRIxZvneEaQs5UlinYU7duSdW2r3/fpYclPKABe4muH9e6QNah0A3bwCCncYdr39zD
         0PIqjjydhAD0UmpBMBSKtydsPko3KwPLl0162kc8liyeV8hVjNFWnvOs7zi0/TczRmR7
         q9AKNQAYioM7JFmFnoI6VGsc7gpZ4IlE8m52ePudSkXENltyS8wOTin+WCs41swuyAsE
         9cCBjXlRt+UMHV6Hw+66Vcf7tq/G2ivaMwom4qYknlau+MYu6rUj7YDO6EquBQlFnOYB
         mTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251157; x=1719855957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZYo2+ECZA8zTSTbRF5VYWEcTe4tY+q+w5/GiTenvpA=;
        b=EdI7Htbahl37pAyv3FF/FIbBQTqrfkhYOMqIY7JIW6gUgsMNGg02zMTOXvxJchDbsM
         M6w/nZ8gAiOxiYAk8T1HYvFHDHHowgJS3tkD9bdQ2x5VHlSfE1wCyL5ibHfzmgLClnoL
         FdtRz3egeoekFF/65Ohpv6b4RDVMspYfqxTnU40dmqI4sbezVW6uQcgWCnxbyyzb93lm
         +ODvrlCbNWOmRX1xvf1pSrVcD7yKMysRevnEBiC43X5vqB0BZDt4Smy2ONzEO17dnmM4
         uSqTlQB2/4LKr2VcDQDvtKPiRD09P5GZ4RvtD7UuCWgXCYs+sOnFNqckmx0w0HeBACqE
         FqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPnTP6dKwsUTd1mnPTPDxPeBRtgG3AJzBg4jXCSut4a8zl0oOb7I28TlrMzZeUjQ1UNzCMK1fA06T9rUWJE8vluT4PnLclNnopaV++
X-Gm-Message-State: AOJu0YwOjRDWKAJ6+EgH8h9JK6VBajKw1Qd7vRHjG/IkF0o0T/7tsSxl
	BmoztbB/NYCkWRlBE7FuPXijwW7Gp7aqOWA1PyHp1MMxcvTx4lNZho/v+qFv+fAsKSvDuE8A4SW
	kqEGkyCDUkQr5io1QjCEg+xAtfeE=
X-Google-Smtp-Source: AGHT+IEK2tK6rYzn4sB+7rfr1nwSQOK4Jcvm8x3U7EK8lUjz2q4DDHHncsAyU5rn5neLiJRN/nDaFSTXyuOY9lpfqgk=
X-Received: by 2002:a17:906:abd2:b0:a6f:e2f1:537b with SMTP id
 a640c23a62f3a-a700e706f07mr511078566b.28.1719251156998; Mon, 24 Jun 2024
 10:45:56 -0700 (PDT)
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
 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com> <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com>
In-Reply-To: <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 24 Jun 2024 12:45:45 -0500
Message-ID: <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:29=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 20/06/24 16:39, Jassi Brar ha scritto:
> > On Thu, Jun 20, 2024 at 1:33=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5)
> > <Jason-JH.Lin@mediatek.com> wrote:
> >>
> >> On Wed, 2024-06-19 at 10:38 -0500, Jassi Brar wrote:
> >>>
> >>> External email : Please do not click links or open attachments until
> >>> you have verified the sender or the content.
> >>>   On Wed, Jun 19, 2024 at 3:18=E2=80=AFAM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>> Il 18/06/24 17:59, Jassi Brar ha scritto:
> >>> .....
> >>>
> >>>> For example, when static content is displayed on screen, the CMDQ
> >>> mailbox never
> >>>> gets shut down, but no communication happens for a relatively long
> >>> time; the
> >>>> overhead of actually shutting down the mailbox and setting it back
> >>> up would be
> >>>> increasing latency in an unacceptable manner.
> >>>>
> >>> Hmm...  in your driver,  startup() is _empty_   and  shutdown() is
> >>> all
> >>> under a spin-lock with irqs disabled, so that too shouldn't be
> >>> expensive. Right?
> >>> Then what causes unacceptable latencies?
> >>>
> >>
> >> I found that the BUG report only occurred when opening the camera APP.
> >> Maybe something in imgsys_cmdq_sendtask() is too expensive or somewher=
e
> >> else in imgsys driver.
> >>
> > If you move anything from submit() into startup(), which is once per
> > lifetime of a channel, it will only make imgsys_cmdq_sendtask()
> > cheaper.
> > Btw, the imgsys code is not public, I don't know how it looks.
> >
> >
> >> I'm wondering why this BUG report is not occurred in display use case
> >> which is more frequent than imgsys use case.
> >> Does this mean sleep() is not always called in pm_runtime_get_sync()
> >> and if we can guarantee this sleep() won't be called, then using
> >> pm_runtime_get_sync() in atomic context is OK?
> >>
> > Instead of hacking around, maybe try using startup() and shutdown()
> > which is for such uses? Maybe request/release channel as part of RPM
> > in your client driver if you are worried about the noise?
> >
> >
> >>>> This is why I opted for autosuspend - it's only bringing down
> >>> certain clocks for
> >>>> the CMDQ HW, adding up a bit of power saving to the mix which, for
> >>> some use cases
> >>>> such as mobile devices with relatively small batteries, is
> >>> definitely important.
> >>>>
> >>>> I'll also briefly (and only briefly) mention that 120Hz displays
> >>> are already a
> >>>> common thing and in this case the gap between TX and ACK is ~8.33ms
> >>> instead, let
> >>>> alone that displays with a framerate of more than 120Hz also do
> >>> exist even though
> >>>> they're less common.
> >>>>
> >>> I don't know how even busier channels help your point.
> >>>
> >>>> All of the above describes a few of the reasons why autosuspend is
> >>> a good choice
> >>>> here, instead of a shutdown->startup flow.
> >>>> And again - I can place some bets that PM would also be applicable
> >>> to SoCs from
> >>>> other vendors as well, with most probably different benefits (but
> >>> still with some
> >>>> power related benefits!) compared to MediaTek.
> >>
> >> I agree with Angelo's point!
> >>
> > Ok, but you or Angelo still don't explain "unacceptable latencies"
> > when your startup() and shutdown() are empty. You just want api
> > changed, which we can but at least do you part and tell me where the
> > bottleneck (unexpected latency) comes from.
> >
>
> "I want numbers" is a sensible request, honestly I would do the same so I=
 totally
> understand that.
>
> Jason, can you please perform latency measurements on 60Hz and *especiall=
y* ISP/cam
> cases while "continuously" calling startup() and shutdown() for every pow=
er saving
> operation?
>
To be clear, do with the mailbox channel that you do with the clocks
now, because your startup() is literally and shutdown() is practically
empty.
Call shutdown() when no request has come in for a while, so you know
the client has quiesced likely. So try putting request/release in
higher level RPM with autosuspend.

thanks

