Return-Path: <linux-kernel+bounces-192195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D233D8D19D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCC628BE80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5416C85F;
	Tue, 28 May 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKBOir1Z"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6E16D4EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896293; cv=none; b=tbKmquQspYqFq5ILAgZe+t2ygUjx6p4PtdCAE4XEiOtmabB+SRXX83PcjpgAwTQFccXzo96IQTgN+7Jc2SN7zDMQEGsXwT0MUZN5QGb1l+FLw3juVns6OE6Xi/Ptp3+Cds47OYAw5oecXu0TE3mX2OekubHcv+2w8cl13JhB9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896293; c=relaxed/simple;
	bh=MzKOsHfMqcEbAgbro03BEkIexxY7ioREoSPx82+mCkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzuA5DWEHJj+xIYGxTLBmq8sAyZAbnT6/L1h2BgUMtgLxYT05gAxpwGVfXHWET7eGRQi2Gs17QnKYnccO0l8q4V23xCiaVXpR9jhQYJA3EkDu2CnL5e7l6TvEQ64IenMVvi3fzcvnVDMQ1GuW7rqAZCX2EPMiLiLlXF1/N7ESc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKBOir1Z; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627dfbcf42aso7026937b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896290; x=1717501090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzKOsHfMqcEbAgbro03BEkIexxY7ioREoSPx82+mCkI=;
        b=gKBOir1Zie8eqOyMucZIlB80d/TU2BbtXB1S56vAhaZvADzkvSZt8MkAiZc4M3bbiN
         gpAzbo/4JQEeN2K7imve4y02j6jceLfp81qPyfvxFEleiMG+oEnSXBSUrvbnwedT0aFM
         FwaDdti6twq5ZWDFUkwniMFvLugZnYMQ7aZizQSCiuOZ8TWMYC+k87ACQhg6vX532xB+
         R/It1vqx1lkQySLV3RxmrYmMddSs2NVOUEy0RwK++OjXVrpcBhwl+UkXALk289a3Be0/
         OnszAkbh+Hpzp6mGy1AEMW7Yutc9kt7Wq4JVtHzmb4HZ5EzXVJcfHNHb5uYLwORk5Yzb
         QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896290; x=1717501090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzKOsHfMqcEbAgbro03BEkIexxY7ioREoSPx82+mCkI=;
        b=qAV9xOOZjo0mHXXUEW6Ft1Rb/9P4S44i8aCLNRtCKuOQAZSMbJXqlirr3KcJS5hms7
         C6Z7HiMsUGxzNB+eczSqn20Six747wK6zF/h/cotyw5hY5KN8FmApUH3BMaYMr2plGg3
         mg/YoKjfwwUCftgBEoriXpEdL8Rej6EEdBqOsrzv6ZgbQcb/03it7R+A8i+ywlhkl2hH
         +rHDPluPdg1ZMAI+ZJ6u6+8t5sJsLU/1RxQ6XwNf/rXVWV5OKz2Kf+Ruw+pYijR79Koi
         xQWowvGFLcu0UPBhyTgCg+GAdFWaCOGsJJ6CfAOQkm5CKMuS2USkgbt5ZMw+p4AeQC5r
         lQBw==
X-Gm-Message-State: AOJu0Yw5zRHWaK/QlpfiQRJ0X+Gb3Q8hDOS67l0JBpoMY6hk9ROfbQLz
	B/M0APoa6bRHovXYOWfGEFFOHh4IKmEZQK+DXI4iOXSQs2jKPt6xPy05TxKxdhNYQcbTh5hnPO5
	P7Wn9B7HTHSUFE1s9lQC0iHgYVZv8caehD+lPhg==
X-Google-Smtp-Source: AGHT+IFdWOfI1NoIMu23ncdyzrqayVvCIbtSBXzmT1072SkezYLbTQ/Wy7WEifX1vSkdblVpJ0/GFf7VJPh29VPnHM4=
X-Received: by 2002:a25:b101:0:b0:de6:197b:ff89 with SMTP id
 3f1490d57ef6-df772269eb6mr9776298276.64.1716896290645; Tue, 28 May 2024
 04:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0109018f85002ae1-6fb831b2-74c2-4559-98f1-a3ef25e72558-000000@ap-south-1.amazonses.com>
In-Reply-To: <0109018f85002ae1-6fb831b2-74c2-4559-98f1-a3ef25e72558-000000@ap-south-1.amazonses.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:37:59 +0200
Message-ID: <CACRpkdb6kKrO=-a84NVwmQ=DdSE9KmaO5SdWaHRYi4EDxAEv9A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-tps6594: make tps65224_muxval_remap and
 tps6594_muxval_remap as static to fix sparse warning
To: Nirmala devi Mal Nadar <m.nirmaladevi@ltts.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, lee@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 7:22=E2=80=AFAM Nirmala devi Mal Nadar
<m.nirmaladevi@ltts.com> wrote:

> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>
> pinctrl: tps6594: Fix sparse warning.
>
> warning: symbol 'tps65224_muxval_remap' was not declared. Should it be st=
atic?
> warning: symbol 'tps6594_muxval_remap' was not declared. Should it be sta=
tic?
>
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405111523.9yt759uX-lkp@i=
ntel.com/

Patch applied!

Yours,
Linus Walleij

