Return-Path: <linux-kernel+bounces-208491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350C9025B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD41B2810FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560F13D8A7;
	Mon, 10 Jun 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bGdcck0n"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FE757EE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033519; cv=none; b=UwAXWY/EJjHIvMoEJmJrSf3C+0ywIFnRmGuxAAdzySQ2DBfqT78VLGcKlW5a4qIbvrNCu114PSHW+v/sBUl3+eZy3LwQExyZypvFAKy4vY7KpOP33Z4qFAerTYf31yLPm0Heg4MjsP3DmPy8TVdl1LGqYh6Aq7l5LGJFgfQ85c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033519; c=relaxed/simple;
	bh=LH7CkPUe4TLzm+MhcEbpCny1djMnHoviw+ltVt8clu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0PZKmaSyKdlj2D3YM+Mp39/2eyutYC9jppGbd4Ua3zD/xytEBcJGgqRlLtRWjr/iSh+jB4KCxAAku1fIU/ztjS2q94x+fR1tnsNYxd0pLtafKbJre0BGWC6oaDJB6GMifRdU+7JAgh1XiAPPwamaCzQBIgfLvgu9mkduHtEq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bGdcck0n; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e72224c395so387761fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718033516; x=1718638316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH7CkPUe4TLzm+MhcEbpCny1djMnHoviw+ltVt8clu8=;
        b=bGdcck0nAt6IY26I8MRj1EkT2CnWtAg7Gn2bvgK6O84/rJoCQHzGcyouH3RNKs2MPZ
         9EmB5ETO6wUYggZTGZ/gQQJMIJdsPpf0127mntGRBmbQtvXbCl4hqUOiWSN0TpNBrzVt
         zv0aRYZm+ef18a4Ri5Xu+juyiLIYC4oaoFsQV7dYgNvixFCsMpmItBwaQV3g3Ewf/+lS
         MESwLOpXgsNUVzaW/u7LwI9+0GyUpQrUwIhxuRGPiViZ8XEw8yy1ZlnvNWb0xrnPL9EA
         KLGOHyQdKRtDWMBTwW7Awjnj29IWAH1zYes3gELpvfALc4+X0FPvjx7wOJHAURxeMVIC
         KFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033516; x=1718638316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH7CkPUe4TLzm+MhcEbpCny1djMnHoviw+ltVt8clu8=;
        b=lbx7FIVkMsZmQFr1Gs6qbO2kkcr/vyrYa39FJ2vFgyhobmefDk1xnKGffbyrlgP5iS
         uxiTdB3rJV1S+ZTmcarL1VUZduO8oOCybaTRU8NtEEX4jRyTkwjaFcROFPoDHTygXFor
         t5Zzl/AyhlBSFndOGFJHnL80Z+33cFZsxACoKP6y2Hm+nz9vjzr5hzxYgb98MN+dy8Zp
         C3rNmKHRc4WErW3GPi8MsdyPx46dgLbhU9dqoLU27kroCGIcqN3cCUXz6xgCAluccGE7
         Ax5GftodA/k2f8cLBaR5qfGYgfA3cwt2s/Js/LWfYIVQbYWQpKbmCcqseDz5ZNLbaHGW
         P/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXWR3JpnGJQSTOgPymY++ORhqsIA8buR29vBdoZT9zm7vnkhLQ2P7APPbiGbCEgIEApbOUp6jCYOskBVubAeUbYgjCe1yl0i08efksp
X-Gm-Message-State: AOJu0Yzm3EIuFzZhXpliamNCKytYT8OBsx/x0xPXMjmBwDlYMGQmQ4+8
	WDm/2RGKElqEvKo7LZ6oMeobf7hsLySpBkK6glMTNTWVhFHdNRphgJ8M1TS4X4QvDjEGGCX1Vlb
	VKedPVBx9O3GMXmBeB++h3GHScFnYcqC0HTpsGQ==
X-Google-Smtp-Source: AGHT+IHt56foHYbztiRQh26pF9sjT2Cdgbl29gsKoWGNRwhvCdGzRV/upJZIYfjgtzdkT1n5RncPmsnKstFG+L6O74g=
X-Received: by 2002:a2e:98d9:0:b0:2eb:e8ab:7d40 with SMTP id
 38308e7fff4ca-2ebe8ab7d96mr15522031fa.44.1718033515892; Mon, 10 Jun 2024
 08:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610140548.35358-1-brgl@bgdev.pl> <20240610140548.35358-4-brgl@bgdev.pl>
 <CAHp75VczROHVKwAi8j4fxR=L3oKJ_5om6rEAriDNFxh1dMRxRw@mail.gmail.com>
In-Reply-To: <CAHp75VczROHVKwAi8j4fxR=L3oKJ_5om6rEAriDNFxh1dMRxRw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Jun 2024 17:31:44 +0200
Message-ID: <CAMRc=Mc593Zgt-jkx7T_D4s2gAFeccA9SdguM4vtFc9H701bUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: sim: use devm_mutex_init()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Jun 2024 at 17:24, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Mon, Jun 10, 2024 at 5:05=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Drop the hand-coded devres action callback for destroying the mutex in
> > favor of devm_mutex_init().
>
> All three LGTM,

Can you leave your tags under the cover letter in such cases? This
will make b4 pick it up for all patches automatically.

Thanks,
Bart

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks!
>

