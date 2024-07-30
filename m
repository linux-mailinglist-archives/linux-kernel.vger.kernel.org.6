Return-Path: <linux-kernel+bounces-266983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEC940AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FD71F21772
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12B1188CA8;
	Tue, 30 Jul 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgAav3HO"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33421187322
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326731; cv=none; b=HPKZIp50ESpHgLCAEgelCsC5iMVVkqdnaHh7XQBXmBKKjgX+F3UKtmtxCFY0QjIkXx5ib2kadK3CMmQRUm2ijfCiuIo7TwkdHZX53/OwDZ4RWBlUEFvcVQ/vBQJtG3WG14/xwVkSAQzzzrAmyafIczNcHVXTqHAT/+MuwY/xXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326731; c=relaxed/simple;
	bh=1kgJNlcr544NRiqfnkainU7wonGN3sn2IGXLuZEd/cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMDrKy4JTcm2ZdZZgf8q2uHfpfBHrcsbcO2YvRgsYt2EzqGgRY/2wP29a0h8PCdxdTlC+5AwwnQGUXnMCCHp5tibCSnj6ohDNSdefC+RvoQ0eDrvinLe02bFjZ0EGZQJoF51jRI+Rb6Vepb3fvuLDVN6pfQLMjk8lbdJUOnAOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgAav3HO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso11053a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722326728; x=1722931528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL66OPAEodYZLaAx2rvp3BoLNoLRh7gj8/rCrIUPhtw=;
        b=mgAav3HO1q9fAAOweWTuDgk0rdPF/JTO+puqpxFrASGmJM8k+RaQ8gX9ZfMH6n0nyH
         1HZOuRMdkP3KhpE5z7K3iflJTCpiPEjOHQp5xSClt8rcYEBZLVT6V7kL6N2LA6Vb5pHg
         lutEgpRvuIHzU+QkMbf5CIj8OSDCt8CH51lHsztfpteAMEaSFsuHsQxm4KQdVgpHctQc
         Ve59g8pjOlWaeLX8YaZ7Fi9IMutsgZOYEe+DKpQwlvX/uuatwwTar4dPNQ2OTs65IrRt
         p5RagbMYKIeT6UZPqxdknHatebjcTrdsYR1Y+4o5ZBlpDT7CCPtMYAjiRYkD3zFJpMCL
         q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326728; x=1722931528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL66OPAEodYZLaAx2rvp3BoLNoLRh7gj8/rCrIUPhtw=;
        b=C8lvRjKyv7gR4wNWiNXu3yEGIPtzPWO/hZp6swiqFZx7plBBXeiOYTs0PNXOqclO3f
         hoRDTKBqaz5bs3rSPoNKcEbgXjEnbLMdk7UGHtG0B52kp5b0z1w1Mtp07mgaZlQyYACw
         aJqct/Uwt6dCOZZnEJbqTOIRKGoDCA+IfLRqx35qmAOQ72FMnP8q9sx51dRRTv+Y5XB5
         uMvixduq5eiAZV9Yg7NHCUtgVzwObvfqCarAq0R6fovvdsa06B145aycEDBTpY/3HIfj
         LZ16xAOaKv9zkgEwsoUCvbr8UVolQzXXiTLq8Z7FQrLR6fFIJIm3DFTzkSh79UaG3X+h
         jsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO32X4E6d9KZbSxoIR+hexu8Yj0k9nvex3aSBrK3JOiv4K0lAa4AhxENOl7hCmwyf5CANqlBk/qlBvNae+qtCmXtYcEbwyPx42S5qn
X-Gm-Message-State: AOJu0YwL15dvF1ffjSObNE8yic2wkMt0xUwnsA/vfpmrfIcA2wIIwshZ
	AiCCrOrdhGR+nP1zRz7SqcsFvthd69+6uWLDgMJzGKqr4tbgKCNrbh3J+s7+2Igei0GX69pDT0d
	b0Vzt1KSHTdPJKwL1JT4+skSTDEKoMf87ElR3
X-Google-Smtp-Source: AGHT+IGop8VSaJ6PSWINp5QsqfO5ghSjMV8XwkY1oD8ULCtzsln+29ty0YUQe56COfn/EIp7v7smumri/6tOHvcfrM8=
X-Received: by 2002:a05:6402:27c9:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b461375635mr91380a12.6.1722326727971; Tue, 30 Jul 2024
 01:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725175714.1769080-1-patrykd@google.com> <ZqcQ3rjY6Wu4lU6t@google.com>
 <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com> <ZqiCV_EXnJONOdyV@google.com>
In-Reply-To: <ZqiCV_EXnJONOdyV@google.com>
From: Patryk Duda <patrykd@google.com>
Date: Tue, 30 Jul 2024 10:05:16 +0200
Message-ID: <CAMxeMi3VFN91FpGb3dgobz9aXt+Ok8rEqGkidwrGxNNk43O=6g@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when updating
 MKBP version
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:04=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jul 29, 2024 at 01:57:09PM +0200, Patryk Duda wrote:
> > On Mon, Jul 29, 2024 at 5:47=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.o=
rg> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 05:57:13PM +0000, Patryk Duda wrote:
> > > > The cros_ec_get_host_command_version_mask() function requires that =
the
> > > > caller must have ec_dev->lock mutex before calling it. This require=
ment
> > > > was not met and as a result it was possible that two commands were =
sent
> > > > to the device at the same time.
> > >
> > > To clarify:
> > > - What would happen if multiple cros_ec_get_host_command_version_mask=
() calls
> > >   at the same time?
> > In the best case, MCU will receive both commands glued together and
> > will ignore them.
> > It will result in a timeout in the kernel. In the worst case, request
> > and/or response buffers will be
> > corrupted.
> >
> > > - What are the callees?  I'm trying to understand the source of paral=
lelism.
> > This is a race between interrupt handling and ioctl call from userspace
> >
> > Handling interrupt path
> > cros_ec_irq_thread()
> > cros_ec_handle_event()
> > cros_ec_get_next_event() - Queries host command version without taking
> > ec_dev->lock mutex first
> > cros_ec_get_host_command_version_mask()
> > cros_ec_send_command()
> > cros_ec_xfer_command()
> > cros_ec_uart_pkt_xfer()
> >
> > Command from userspace
> > cros_ec_chardev_ioctl()
> > cros_ec_chardev_ioctl_xcmd()
> > cros_ec_cmd_xfer() - Locks ec_dev->lock mutex before sending command
> > cros_ec_send_command()
> > cros_ec_xfer_command()
> > cros_ec_uart_pkt_xfer()
> >
> > >
> > > Also, the patch also needs an unlock at [1].
> > >
> > > [1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platform/c=
hrome/cros_ec_proto.c#L819
> >
> > Yeah. I'll fix it in v2
>
> I'm wondering if it's simpler to just lock and unlock around calling
> cros_ec_get_host_command_version_mask().  What do you think?
>
Initially, I thought it would be good to keep ec_dev->mkbp_event_supported
update under the mutex (similar to cros_ec_query_all() which is called with
locked mutex), but mkbp_event_supported is also used without locked mutex.

I don't see any obvious risks with updating the MKBP version outside mutex.
Do you want me to change it?

> > > > The problem was observed while using UART backend which doesn't use=
 any
> > > > additional locks, unlike SPI backend which locks the controller unt=
il
> > > > response is received.
> > >
> > > Is it a general issue if multiple commands send to EC at a time?  If =
yes, it
> > > should serialize that in the UART transportation.
> >
> > Host Commands only support one command at a time. It's enforced by 'loc=
k' mutex
> > from cros_ec_device structure. We just need to use it properly.
>
> I see.  Please use the fixes tag if you'd have chance to send next versio=
n:
> Fixes: f74c7557ed0d ("platform/chrome: cros_ec_proto: Update version on G=
ET_NEXT_EVENT failure")

