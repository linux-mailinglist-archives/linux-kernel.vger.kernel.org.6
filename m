Return-Path: <linux-kernel+bounces-363405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495799C1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A432D1C25086
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381CB14D452;
	Mon, 14 Oct 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qZ7ryWOU"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8A14A4C7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892041; cv=none; b=LlFzrsD2VOUVCBzJrPLyuSHyF3WagIGrWW2SxQXSjR80xOmdG+k1u2zvnEFbL26ZgltCL5+9Py4MotunweO0r0S99scCboldozXKvkwBsr6frsG2qS0a3rhJKQkq35lvpnk1iNuz4QI1xmm64oJ33zQv7X8xy/1d1Tv8EpsO+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892041; c=relaxed/simple;
	bh=VDbioSblN4ynIyyeC2CQ7pTSB+0ZijqmjxUKWHCQVmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWO1yZelSUmhuhH5sac0UE/52FG8JoEuEvE8JZJLL/35EKoRVc/wUENkxjE5caIWiv3HHA6L5hR0Q/VXvYtSOR1OP1rxZ5ibl4CwKiAyYmR4AVFAbwaMNvQ/Qi7+HVUqXCx2A3vqHj92AM5A6N9TKZeHyZqttWlgYG4UeCHwv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qZ7ryWOU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so1445946e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728892038; x=1729496838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ci47FCr0BLO+ZRL8BVD1xolaCRrNCxsdR56n7wJp8=;
        b=qZ7ryWOUijVauNI3i1/+4TgDIp0bzXnBY5/bxZFL/V8XCPnLAplpVk2WUQhONP+v9l
         3MeuczSE99zAiWV11mQ9nziufkZQhPK4hU+J0GEH5npsuvG40JnGntLrKmMgFOSbIz8G
         yYlQkBu8+Sxr7jYygw8HFK5cNc69tvMxMyKuZ5thSVBP4qTuM6e+k9DvxWcxmvDI7RvJ
         KgEePycKEgC/eLXhXueHo4H3+vauDQ3j3CVEtXEcCBWgddaDrUtn468jw6ueHtuIm5pW
         PyHt94Hz7rFI2pnzABp48gPuGzk+q3HKTD9Jcbj9sHbm52Z0UAgXJ0jW4jONxnm9g3ZK
         V4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892038; x=1729496838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9ci47FCr0BLO+ZRL8BVD1xolaCRrNCxsdR56n7wJp8=;
        b=HlvI3UdHyZlJEXkyzLsbb+Ppz/s2QVqxxdnUY4bFcpubanZ7O8e3TBh2XrG8x+tyw6
         sDdXEVwoMPM4s1lAc85xXAPfnQl6Q+dTb6+7UyhubRdl8tUfPglxFdeJ6eQepZKWeCiJ
         TORk+6Wf9N4ZqsChQLkjCeRu9uTJkQN63g2ONbYdNITj6Oz/tDky7UsWBlNX4jCN1L/a
         eg8X096lT7b9ei7L4VOslGRdZW8u5Tg6dfas9a5a6FTcDimnE/u3nfXxh7tbYl/qIAh1
         pEklR7F6XFzOMUkxU56k4ekwnVBuU16ygm5BIMFQcO2ccBHEwuH0PVGeVnIjKwDXsUFr
         M3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV834C+HyPSD5P4IDuqC+I3T9+4py8sP2AZ6bJOPih/hr7ixyAR4OKCV//jAztd+vQZM3VYHz0yi17QQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnkwubzP4pJ/czJABPIp19UC6H5Q7OosmObO4zmmoZc6LSsuC
	2CrQxfgzglkFkbeN37x+VDoNTvR1n2daax5m1BMSQrrKfkje3K9n8JQaxI+RT5fe3HT3GF2ZJgD
	CzkUJIGUPuELzLs9bThlMOcjVYFL2FDyrbxWVPA==
X-Google-Smtp-Source: AGHT+IEkRozy4jIjpUob6cNSZHTMubXFT9Daw8+QW0FoIfza52gyz/CNfBtHZuqE590O0dqUhAqstfNA0rJ4y1h4/qM=
X-Received: by 2002:a05:6512:ba4:b0:539:e214:20e5 with SMTP id
 2adb3069b0e04-539e572fc59mr2561884e87.59.1728892038117; Mon, 14 Oct 2024
 00:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
 <20241010-gpio-notify-in-kernel-events-v2-4-b560411f7c59@linaro.org> <20241014020915.GB20620@rigel>
In-Reply-To: <20241014020915.GB20620@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:47:07 +0200
Message-ID: <CAMRc=Me2Mqj40PLw_q-PgEbyTqsFVNX69iQ73Pz4REG+a8XD4A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] gpio: cdev: put emitting the line state events on
 a workqueue
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:09=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> > +
> > +     scoped_guard(srcu, &ctx->gdev->srcu) {
> > +             gc =3D srcu_dereference(ctx->gdev->chip, &ctx->gdev->srcu=
);
> > +             if (!gc)
> > +                     return;
> > +
> > +             /*
> > +              * We're doing this late because it's a sleeping function=
. Pin
> > +              * functions are in general much more static and while it=
's not
> > +              * 100% bullet-proof, it's good enough for most cases.
> > +              */
> > +             if (!pinctrl_gpio_can_use_line(gc, ctx->chg.info.offset))
> > +                     ctx->chg.info.flags |=3D GPIO_V2_LINE_FLAG_USED;
> > +     }
> > +
>
> This block should be conditional on GPIO_V2_LINE_FLAG_USED not already
> being set - most of the time it will be and then this is pointless work.
>

Good point, thanks!

Bart

