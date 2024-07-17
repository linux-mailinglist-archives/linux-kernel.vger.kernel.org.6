Return-Path: <linux-kernel+bounces-255395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D593404D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CBA1F239CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3989C180A88;
	Wed, 17 Jul 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACd9/v7N"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1021D52B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233093; cv=none; b=Z78WcjxqEhPiOtHIHxbqgr5al6rxsiRqy0QBOSYt2NWW0J3lDzby7cED8xVwdPfysn+xMWQjQovrvVgQWf7IHMyVjVXd7pckX2Olu49TDCd/yGUNp2KU3pPoWkX/o30oDqKtHiRaOH/wSPCyrzarrBijVv/jB9k4vEYe2etC7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233093; c=relaxed/simple;
	bh=o3SfsEhlDfgeXfryj97AInH0kl6BNfWOqxSvyst0GnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fchgzdISpZRKS35o0Fy9C4ieD6I2WlnIjmuItpeH+irxg6BdtMPwjOlIUmgKW8PktQHsDf/RCp2/Ydvu9790PX8Uo5aLKgiAbGgstMeS579bULFHmSvvBfqrMNWTu1gAOT0J8Uo1DGE9+6lpFwhqIamOKwyED0PWM2ST8/5U/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACd9/v7N; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ed741fe46so4516945e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233090; x=1721837890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN1bLNl0BTZ9iy1K7Yp0WmZCTwJNvK8fshp2FGJokkQ=;
        b=ACd9/v7NsLAtj4MTRPwV2cJBMPlG+9FmkEVJf1Bcx66Y7ftHhti/j/6Ei2X3j9AMYh
         X6U5iShNVweVFKPlhHT7IISU6G2xMN8MzRIE1gXDsIrocjUfuXT5tDDVifO6ESey5Wao
         iG7RjQetc9IlvUAzP+Mo7kWecGcOCrA9oehihJyKQVcwlEDd8jn8v1vlNxL8X4SMgd43
         2B7Jw7rLsMIAAtWMI4zZYGr2q9iE0Bz4yp4amY84qaedBYJ0+QiJL6hhOANMwJCp4s0A
         6J0WY4keK65l3IKbL6ZeDa+xkQJQaDONMzE5I6baGFM2mZODRgkbEJcF+aH9mtPA1lz3
         /uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233090; x=1721837890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN1bLNl0BTZ9iy1K7Yp0WmZCTwJNvK8fshp2FGJokkQ=;
        b=aB7GvcqrgLzB3Tu2jF7WHJVndbQjoA4l5XYC5IqV8RZ4A+vRhynsJTowjCw5WSfEWD
         q3yKgDa1MSOA0iCTV/dwlyNm4EWAGlSL5MVs8jFcGFtwGX+XwGOijTO49bhd0dlloanG
         Yb4PD6j6z+nqwVVKb9hOMKITKMNje9j4NMnG3nTk2CvUPE7QyPG26xR78T1B6P9nTyC4
         XPZnirNd/njk4UvOdy8UHZdv38aiayHTs7EowBfD9oAu/2Diy2UlCmUddDw6X0RViYfh
         ON/uTy90ZwmeeTye5Z7JRif7UAsWvPLnwqxbLZvkmaNpKIk34nR7PhRlLSxouMp4itUJ
         ifNQ==
X-Gm-Message-State: AOJu0Yy0iTnfYLSLk8SIz6kn9A0e51Tux4MkeNmaPQDehCWaSzsf5ieR
	3cjOmQONit5km7ZtQaXzIgpba5cn+ajdJZ9VZgKgOmGYyn72i7MNgEIjpKSRmt/5CQKAOYrhyI6
	dXBCI5TzrzrxMKJlc2zK68rcJfyg=
X-Google-Smtp-Source: AGHT+IHJKGB3isMbpiavmiRNgPprCHd6xCU2Zj9jAPGFncmg1lt1S1zutRUqS9ElJc7/eqF9zLYRwRvV9Y5PxGXjTlk=
X-Received: by 2002:a05:6512:3d0c:b0:52e:be1f:bf7f with SMTP id
 2adb3069b0e04-52ee53da928mr1592447e87.27.1721233089843; Wed, 17 Jul 2024
 09:18:09 -0700 (PDT)
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
 <CABb+yY2zBY_3nEYajdhRNfwb+bPMpFOvbXrqY+jM9rB6qbjJNQ@mail.gmail.com>
 <e860d67f578f1963d785dcc0423936fe5de20547.camel@mediatek.com>
 <CABb+yY0mYrUyfpNLVKZt2aDdzZPf+VjawcwVSpMG8H_=pwKLbw@mail.gmail.com>
 <c8081a0bbfa2f60fc3d594bd0fadacf9354507b7.camel@mediatek.com> <74e15fceff5ef48ca18a6f3e8dac15ae9cff09b7.camel@mediatek.com>
In-Reply-To: <74e15fceff5ef48ca18a6f3e8dac15ae9cff09b7.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 17 Jul 2024 11:17:58 -0500
Message-ID: <CABb+yY04wHaq3pU8tVOK51PeUHAMnUtPC+zi5gFkmykK05C+Vw@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 4:45=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> Hi Jassi,
>
> > > You mean _with_ the api patches. right? Because I had suggested
> > > "Over
> > > your patchset, apply the following diff ..."
> >
> > No matter __with__ or __without__ the api patches, autosuspend didn't
> > work...
> >
> > We have to find out the reason __without__ the api patches, then see
> > if
> > we still need the api patches to fix "calling sleep in atomic
> > context"
> > problem.
> >
>
> I found that the reason autosuspend didn't work was that I added the
> devece_add_link() locally between the drm device and the mbox device.
>
> After removing that change, the mailbox device of display can
> autosuspend as expected. So the current autosuspend function is fine.
>
> And the mailbox device of display has the same BUG report like imgsys.
>
>
> Here is the log after removing the local change of device link and
> without the PM api patches:
>
....
That is the log of your some w.i.p code... it does not trace
mbox_send_message() which is where users call the api.  You trace
cmdq_mbox_send_data() , i.e, the api calls the driver.

Even here, the minimum send_diff (time between two cmdq_mbox_send_data
calls) is 32ms. The minimum resume_diff is 540ms, which means you
suspend for at least 540ms.  Also you don't expect these times to
change even with the changed api, do you?

At these timescales, you could very well release-acquire the channel
resource because that cost is ~0ms for your driver. That will not only
be the right thing to do but also avoid opening another can of worms
by adding some ad-hoc api that works only on your platform.

Thanks
Jassi

