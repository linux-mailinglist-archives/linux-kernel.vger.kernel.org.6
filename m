Return-Path: <linux-kernel+bounces-177704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4D8C436B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0E71F222DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F4210D;
	Mon, 13 May 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjNtxRg7"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818B17F0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611451; cv=none; b=CzXhjDfBtQWsgIP/MYcXMOuNiZ68sLBOryI/OokKINejAeWMiBMxWlQPd0bRWj7X1kryYXLVWXfhlgxDwCUV4u99zQPUkpm6pt5FmKWJ+qRGBid3OspOIFzZ3drRiR1pgciye03rejoKgFwmH1TzvAQP/oz8eyoCqzs0kCEtNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611451; c=relaxed/simple;
	bh=vqC3nufKybZg0EJC3umC+jC8RfCqyKOEVd5EqSlUbJQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DC/zmBEB38ENmvJbDBPAccN9igGErsasYzhIgX8Ym46Q2IDh4+lMVKJipakjxul2/WMe9vFebyb7GXjltxHbHTgCLE6EVCNHHoiPa7Tr2jG5vbC+vK2ERQYnbBsJMJI/YyzsbX8lI+xUMXp7wHekPcKiyv84/0oj1eNWjZyfLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjNtxRg7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e538a264e0so44623331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715611448; x=1716216248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kH8VxieNuK/mWqjjJORakpkGgPM6QeSfE7ojbqY1Xnc=;
        b=RjNtxRg7YPc9FurnXjMSso5dwHH5d9aFcDN5VrQdx0lcIy6kyTcgQjyEkzMLo5bdAs
         WZr0KZD2DIXvK7jEFw8ItgMiNg44+9eOQSnVfl06f6ua3kI3Z9H/2tOlVtpkObgwTQij
         t4eDkKefcphDLO9XjDdDY+HCM/H1nkEuYz9C7pZqpGlXRn+/FI+GbjWsyMYHhUV+GsW5
         +h0/PzqEnfUDvVOxHvasR5orr3cZG2/HhFESNQL82tWTyWgEevvtMbtDqPrD7JRc/HBp
         +oBYAMsGvrPpd8Sh+wyf0FVP4zTykC4+VXrxLHmQeMZO/tGB6dlFERBRoZEy0JalUeGq
         xXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611448; x=1716216248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH8VxieNuK/mWqjjJORakpkGgPM6QeSfE7ojbqY1Xnc=;
        b=R88t/0VBVr5bBZQFdSrSB7CZcOIMUdeVliGrzDqfMlxT4sj+NVfGo0CqIvAUuk0g07
         T1qtLnhoLOkDZcooYzCsDrYjmcHBS1av61j/zvvxVQkOq4S+p9qGmZ9bj/VWDZ13lgv2
         aXhxB1ACMYns5Pfj9fd28Vh6e5ufT/4CCW3glOxWd3lgXo1hfuH8LLaUB3bcc+u1aT2l
         vLToRZmq78gqN8CMe1SrCzSvlaeNW0S/GvX+1QM8CoJ2iRzKSOHLir26y8Q3lz+Mdf7A
         +zrrzLilgaCewmSnYLOAL7JKNwetQTQ/Sx/LXCXJPU5nhDN9CxyhVK/VZ8G3g8Z4zA0f
         4EVw==
X-Gm-Message-State: AOJu0YwAOpazkVXyfkjkaJDziTMjeZZ0Exl++wuSNx5c+zF+XPTLp207
	kSJIJSS46QXzFpqLyS9I7c8/kGEb2Dnrbtfmgcc1/X0TWaAOX2hwyoH4KbGN4QKX/DpboqgdGdi
	xguSXagA+QALu+g3vqvQ3XB5Dw+A=
X-Google-Smtp-Source: AGHT+IF+hGrtRcLqfr9KCi+YywjYZuEGbL4W5cLMXa6M2iet0itdztB6x6sAx+mPs/kQGylU1CDPvfzoXlGZugf8A0k=
X-Received: by 2002:a2e:859:0:b0:2e5:4171:1808 with SMTP id
 38308e7fff4ca-2e541711898mr69328121fa.51.1715611448280; Mon, 13 May 2024
 07:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 15:43:57 +0100
Message-ID: <CAHx5RXBCLPEZcrnUNx9GrQhQKtA-c4WSN6+vbAaqk6P4WSvrKA@mail.gmail.com>
Subject: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: andrew@lunn.ch, f.fainelli@gmain.com, olteanv@gmain.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there.

I have come across an issue in the Linux kernel (6.8.7 and others) and
wondered whether I am doing something wrong?

In trying to test the dsa_loop module, I have found that the
dsa_loop_bdinfo module is not built when the following combination of
configuration items is set:

CONFIG_NET_DSA=3Dy
CONFIG_NET_DSA_LOOP=3Dm
CONFIG_FIXED_PHY=3Dy

This combination can easily be obtained using make menuconfig.

It seems that driver/net/Makefile=E2=80=99s inclusion of the dsa directory =
as
an obj-m precludes the building of dsa_loop_bdinfo.c (which is an
obj-y):

driver/net/Makefile:
=E2=80=A6
obj-$(CONFIG_NET_DSA) +=3D dsa/
=E2=80=A6

driver/net/dsa/Makefile:
=E2=80=A6
ifdef CONFIG_NET_DSA_LOOP
obj-$(CONFIG_FIXED_PHY)         +=3D dsa_loop_bdinfo.o
endif
=E2=80=A6

