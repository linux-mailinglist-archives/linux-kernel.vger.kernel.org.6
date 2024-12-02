Return-Path: <linux-kernel+bounces-427113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D119DFCD9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71905B216BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2191F9F63;
	Mon,  2 Dec 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HSZoBAS"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1022868B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130975; cv=none; b=MXBAtwcvVzGo3ZU5M2xISt6FxE0fmpU7DwgZN5myi2j2/aJcYkqpKfn7XQTiKatWyIVDcU197PAxR3/m3JQ2OClY3EATddL1ki+ib0vcm9C1TO5sqInSi8BvUoPboaDXFjSXN0s+zLNOt7Eyk8RKyyYRTcEISDAMMT0pBGGLAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130975; c=relaxed/simple;
	bh=5WrUnJEqQiuUuTJ+OJiQnCJ7THQ+A+DF5medutrEQfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpIiqZxaIT7cw+q4cgYi9Ab89vf0T0+gxikX7S/leXVLO5CUoNE/MkN+tGMMsa+01dU2RJVKa7GPOCYo24L5UtO9L44qHBdpB3LsTeRtjdz/L9RpjTgDvk5IzcXqXRen4Z55NPIrybYgbtod01rDUy573QIs4knqupyWJP5NTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HSZoBAS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eeca49d8baso30835497b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733130972; x=1733735772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eG6H9xL8sk/1S7A6iBU9/Voo1x3apTymTAnplNQbuo=;
        b=2HSZoBAS5Lw9igNyEdTyrFLT3+/HLiaIW9tRZKeeazj0q2JfgX766vMDxm3SIKIay+
         6yolem1ZZOxuKc7n7SkQOmR5MnHQi4jTH7V6zgUcXtS9Jneo6ByFVjEubHc/trAvb2g6
         0y5twhZRW2N3T7DvHWmvIE+DutZ3sB2otdmCYdRxoAcDGd2P5m4yslJ8kvxIduBRy32g
         gKOejEl/CcqoHvi252VuxJyqx4IOShmDu3FXxDig2WewJlXCo9yU9W0IjyWHTNZDTXyx
         0oAdXsi5l8wI5ytCL2yrXA21JrQGaz6HY34EpaQQ1Yv4QyRW3+6dqO7iGtGEYP7iWotK
         BYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733130972; x=1733735772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eG6H9xL8sk/1S7A6iBU9/Voo1x3apTymTAnplNQbuo=;
        b=tNBVlX3rYcytANPFF6yxNM/qsuWmky7zKVO8IKmGJbrX+961AuiOYLo4gxbKNU2VvG
         7kqkD3ffTbXTAtOOIQLly/tcAdFJ4RDYOOt5s0gnND0yiCy6CnIROq4TOyeFudzfTJ8t
         B4RyxPWXsKdB3HTf48lCDeOheqnrqe0Hg8YZF8VpTh2DHNqfheeY2L708HfYzauZLkT3
         AJ7xsf48hmP7hFtwr4Uek/E9XYsD2czDvIWCGtoNyBh6yCgnRbzb/7aH834jC9tbFIbA
         fqnoWIhcs8rYIshkOoQBiPJeXK4sdY4yNPsZDif2lXrdfPPgrouCWSCSBkwTuNUBZQY2
         U1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy+zujDI3BcugV+BiXlfYmG5gjJLuiFwoVLswZhCvxlbK0T0viGtKeAeWxpMCcSZZfGOrBk03c60ssQY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsczsdFyl9QuisCyTA6xIW5ua9jwQEgUhiNbv2A5FnmZOIyTT
	Oo8C/JS1kSpScZEXb1MNDJs//VilQS5CMBnbeXeGrHR20mGLo/xWi8dFNx++qyBahRxPZBzVBDT
	bJH0WJQXA/6f6TSJSu4uoIb/yRE5zJSITrryn
X-Gm-Gg: ASbGncsSroZzjfli6zp+P/nVsnhmsVS+olc7wJ8xETYujSJBiDK0jhLj3g/GK+J3rnN
	4bK1lfW8GlNCjljq1wni/SMHmM0UDXQ==
X-Google-Smtp-Source: AGHT+IGLfK90CGrw+U7d4tyOPXLmg+EKv1CY3vyA/Q00bc/KKdGdeAKIVU8n+M6Hhwa6n30VmDCqUxFawN0x4JzUV9Q=
X-Received: by 2002:a05:690c:3505:b0:6db:e1e0:bf6a with SMTP id
 00721157ae682-6ef4a0dfcb2mr152707887b3.7.1733130972344; Mon, 02 Dec 2024
 01:16:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125184446.1040187-1-dawidn@google.com> <Z0fxrDTuCIeCDTiV@google.com>
In-Reply-To: <Z0fxrDTuCIeCDTiV@google.com>
From: =?UTF-8?Q?Dawid_Nied=C5=BAwiecki?= <dawidn@google.com>
Date: Mon, 2 Dec 2024 10:16:01 +0100
Message-ID: <CAJ_BA_BvGPfAghiQo8uQSAhdqG3NiWXbO7c-Q_x6cvUUukrzsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec: jump to RW before probing
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:29=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Nov 25, 2024 at 06:44:45PM +0000, Dawid Niedzwiecki wrote:
> > To avoid such problems, send the RWSIG continue command first, which
> > skips waiting for the jump to RW. Send the command more times, to make
> > sure EC is ready in RW before the start of the actual probing process. =
If
> > a EC device doesn't support the RWSIG, it will respond with invalid
> > command error code and probing will continue as usual.
>
> I'm wondering should it only send RWSIG_ACTION_CONTINUE if EC_CMD_GET_VER=
SION
> shows the FW is still in RO.

In theory yes, but in practice it is not necessary. If FW is in RW, it
will return
EC_RES_INVALID_COMMAND (the same case as RWSIG is not supported), so
the job is done.
EC_CMD_GET_VERSION + potentially RWSIG_ACTION_CONTINUE sequence is longer.
Additionally, EC_CMD_GET_VERSION requires bigger buffers to store
versions strings.

>
> Curious about: who (in which use case) is responsible for sending
> RWSIG_ACTION_ABORT if it wants the EC stays in RO?

Currently, it is done by flashrom
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/01195dd492ea=
196cdc60e467a896369e30e90c5b:src/third_party/flashrom/cros_ec.c;l=3D480

>
> > diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrom=
e/cros_ec.c
> [...]
> > @@ -204,6 +204,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev=
)
> >       mutex_init(&ec_dev->lock);
> >       lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
> >
> > +     /* Send RWSIG continue to jump to RW for devices using RWSIG. */
> > +     err =3D cros_ec_rwsig_continue(ec_dev);
> > +     if (err)
> > +             dev_warn(dev, "Failed to continue RWSIG: %d\n", err);
>
> Too verbose, use dev_info() instead.

I will change that.

>
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform=
/chrome/cros_ec_proto.c
> [...]
> > +int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev)
> > +{
> [...]
> > +     for (int i =3D 0; i < RWSIG_CONTINUE_RETRIES; i++) {
> > +             ret =3D cros_ec_send_command(ec_dev, msg);
> > +
> > +             if (ret < 0)
> > +                     error_count++;
>
> Should it just return the error if the transmission fails?

The transmission failure is kind of expected here. It is possible that
FPMCU is not ready, when AP
starts sending commands. That's why the retry (which is removed in
PATCH 2/2) was added in the
cros_ec_get_proto_info function.

>
> > +             else if (msg->result =3D=3D EC_RES_INVALID_COMMAND)
> > +                     /*
> > +                      * If EC_RES_INVALID_COMMAND is retured, it means=
 RWSIG
> > +                      * is not supported or EC is already in RW, so th=
ere is
> > +                      * nothing left to do.
> > +                      */
> > +                     break;
> > +             else if (msg->result !=3D EC_RES_SUCCESS)
> > +                     /* Unexpected command error. */
> > +                     error_count++;
>
> Same as `ret < 0`, should it just return if any unexpected errors?

It should return here. It is unexpected that the command itself
returns error, we should return
in this case. I will change that.

>
> > +             else
> > +                     /*
> > +                      * The EC_CMD_RWSIG_ACTION succeed. Send the comm=
and
> > +                      * more times, to make sure EC is in RW. A follow=
ing
> > +                      * command can timeout, because EC may need some =
time to
> > +                      * initialize after jump to RW.
> > +                      */
> > +                     error_count =3D 0;
> > +
> > +             if (error_count >=3D RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
> > +                     break;
>
> It could return 0 if `error_count >=3D RWSIG_CONTINUE_MAX_ERRORS_IN_ROW`.

True. I will fix that.

>
> > +
> > +             if (ret !=3D -ETIMEDOUT)
> > +                     usleep_range(90000, 100000);
> > +     }
> > +
> > +     kfree(msg);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(cros_ec_rwsig_continue);

