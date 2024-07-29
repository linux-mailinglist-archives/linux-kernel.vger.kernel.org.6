Return-Path: <linux-kernel+bounces-265709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D025893F4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364E5B20E19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14476146586;
	Mon, 29 Jul 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIk9IW3s"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E08145FF4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254244; cv=none; b=Cf9mfQiNQI25k9vL5R3SMqbg+2PmVaYaih/IdBdO6SENMVG23f7b7W0JqfFZ6On/fNPoMY05lsp+f5jMznDvO42+T0jEIfKZ+x0q/xReOOW7ay98Rb2+RsA2a56Avjeh4Qm+hYum0mzooNIEfOgC5Lzoe+5L8+0nlGUWu0Y13ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254244; c=relaxed/simple;
	bh=x3XhPLsCtjDy70nhvPuPtYCSM145dpQSHE7ynV+IkpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl1MZlfkSPkUnjnyjNyvXThH1b5e8bNQ9yLg6E3GUWJ5Iu6Yj7sjVhlf9MBJCuusUKfIWQLzhyA8FRwFZx93zEbARHe1dhf6vZxSu/UaOK6q7twMFyHLIOc/zcRIOsOKoxR6HeQeQMaq5575K6+ZmYKJllPkliq5iLmyJGYvrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIk9IW3s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso11490a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722254241; x=1722859041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+A9yn1Vu3zA/NqT+R60GqDVDjMj6eEkOom2C/kDD3s=;
        b=LIk9IW3sCQqxWE5eyzh0zMAn7KTdiSv6YkWmautxeHEcFcv/TSjGr5uOjNC42KXsEE
         wspM+abvXGlbN1OvIV9p6+UR9mJVqNG9vThdc27v0wxA4rWOkfghtzVKBnpH8WC0VymM
         MuBerAap7drwXeRnz5WuiZCGhevgxjosWeWogNV5yDSdk1jk7GpH+qstJitePys7oaoF
         uVcyaO7zsOe/I6O+ZnuiYhIrTcj5yVWG9UEI9siV8Jru2B2lPP/8N4Ksd+uqPLYH3Yke
         GxNC/ZPoxXB4NhPTP1eqCMsn92I3if11zACEm3TYX/6dFEZTQs336zU10ETZDI3WOUZ3
         XncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254241; x=1722859041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+A9yn1Vu3zA/NqT+R60GqDVDjMj6eEkOom2C/kDD3s=;
        b=uE4vYAv20JpfTgwRznsOz62h2b0B+hA84i6O+ZGrFRc7F9CIqKopQt1gE2pIOMXq2U
         abNlPU0vqPDCq2d67JkwLqvo+9G0XRcdSQ83pXR1FUHePsuEELi3/6FGqsYehVwIsAqa
         iCe8hwOJpGLXpk5cAjVCRCo2m21zfaCEOKUGffF8cIY4UQ0ZYEoC4sJJna4uVVPrrMAz
         /jsPbUmY/fBPis1qkpsu+KAkB6loIDkZzDQv68iEEITdDjTng9O1Mh+bEyy0dawKfdLQ
         AbX6qk/t/aR6TLRKABMq7DKpsxTMNeCQXNuowFFDV8eKVi1qmJqK/M0rINs9wKwg3zR+
         /Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCUdlsrnqzMyESWEmnDYjQmuqQSKqlUJiuSvxhICPnif0Acb6M8ZqcwzXa925z412iAV78d38+3XmBO0fLNRvnq3w9CxOmFalFlR6P1z
X-Gm-Message-State: AOJu0YwqJ5EoAEWz0KZMD6n18gGGq5JK4WuReyVzxA+KNVE4EFMZ4/uY
	teK+L8KW66o2QaO3PSR9tTR/khJb6Hv8qILVQ/bUqDT0OFr6H1XIvrBsZ8sdorn/B9VrLUZtVUc
	L6wk9+nF3uZ9+kCaIMIgFtzxkrS57BMLpVpmN
X-Google-Smtp-Source: AGHT+IFGfho3sbTHKT0xwhEjvTYuUpNnNy70RSsdxIvCATXOU/6B+Ko3DwMfC7CFyPef0u/zrB+lS4UagH+FLbCyDvg=
X-Received: by 2002:a05:6402:3585:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5affc67d570mr338128a12.2.1722254240674; Mon, 29 Jul 2024
 04:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725175714.1769080-1-patrykd@google.com> <ZqcQ3rjY6Wu4lU6t@google.com>
In-Reply-To: <ZqcQ3rjY6Wu4lU6t@google.com>
From: Patryk Duda <patrykd@google.com>
Date: Mon, 29 Jul 2024 13:57:09 +0200
Message-ID: <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when updating
 MKBP version
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:47=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Thu, Jul 25, 2024 at 05:57:13PM +0000, Patryk Duda wrote:
> > The cros_ec_get_host_command_version_mask() function requires that the
> > caller must have ec_dev->lock mutex before calling it. This requirement
> > was not met and as a result it was possible that two commands were sent
> > to the device at the same time.
>
> To clarify:
> - What would happen if multiple cros_ec_get_host_command_version_mask() c=
alls
>   at the same time?
In the best case, MCU will receive both commands glued together and
will ignore them.
It will result in a timeout in the kernel. In the worst case, request
and/or response buffers will be
corrupted.

> - What are the callees?  I'm trying to understand the source of paralleli=
sm.
This is a race between interrupt handling and ioctl call from userspace

Handling interrupt path
cros_ec_irq_thread()
cros_ec_handle_event()
cros_ec_get_next_event() - Queries host command version without taking
ec_dev->lock mutex first
cros_ec_get_host_command_version_mask()
cros_ec_send_command()
cros_ec_xfer_command()
cros_ec_uart_pkt_xfer()

Command from userspace
cros_ec_chardev_ioctl()
cros_ec_chardev_ioctl_xcmd()
cros_ec_cmd_xfer() - Locks ec_dev->lock mutex before sending command
cros_ec_send_command()
cros_ec_xfer_command()
cros_ec_uart_pkt_xfer()

>
> Also, the patch also needs an unlock at [1].
>
> [1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platform/chrom=
e/cros_ec_proto.c#L819

Yeah. I'll fix it in v2

>
> > The problem was observed while using UART backend which doesn't use any
> > additional locks, unlike SPI backend which locks the controller until
> > response is received.
>
> Is it a general issue if multiple commands send to EC at a time?  If yes,=
 it
> should serialize that in the UART transportation.

Host Commands only support one command at a time. It's enforced by 'lock' m=
utex
from cros_ec_device structure. We just need to use it properly.

