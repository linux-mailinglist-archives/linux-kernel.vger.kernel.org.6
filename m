Return-Path: <linux-kernel+bounces-178371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCF8C4CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4928230D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7C125A9;
	Tue, 14 May 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUqmRHK8"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778710949;
	Tue, 14 May 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671345; cv=none; b=IzR77fu3sj2s0rWF173dSV3K1mz9/DEg7rWNBaOGB02PeBEE+xG3830CYVLOSiRz+6VEPaFQ+zc78oI5QsJY1wevtFqDhvIbSe5UEVOfP1tru8+dwKgb3JW7J5dG9tm8MQ21a8KVKAdn0OUnhOiONX+uLywCrVUHAo82DqJtJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671345; c=relaxed/simple;
	bh=JzVYEOFYJs0vaOsSEbpguUeyRllA43s34MwtB1FYfVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC6AQp4O+sKyIO77LehQZUGxXFM4t39zfs30fYgYxZY34RXhvxhN58d/UI7zFBToAaidxeem7PgIXjeZLo5BQsgD+H1/xwUYa2AcAFRc+AJVRyYq+cglDzsxCVr+mvd5+ZQYowVQDcdSoakleqazS2eEKGq6wp37NHWmJdFqXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUqmRHK8; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c80f9c86bso25177375ab.0;
        Tue, 14 May 2024 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715671344; x=1716276144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WNa+3eLjaxowCpV/iLa2mMgq8zXzxRscxKrC3IUfjs=;
        b=mUqmRHK8n8W6fAKPFBygxVO3CtLivR/mkbwcJ+5jsFeZLHl1j5lY/ImTBbIhav5owZ
         JVEX+Jeen5jnwFtXP38VO06QZt4I8XGL4LoZNVc+m5OquPaRn8oa9Durwga9l72xFjB5
         wP6gj6QwmWJBpR+BZHV04pEmtVn2sDR2yQizKBNFhuaFCOdPzRXRCNsNAPkI8Razi4zQ
         g86DzP4c7TE3pLCqLuaqbHRVTxkCStq2EaIfHSnGrA1NQ25sdrEJlTzMjbxAnhudHYHS
         AOhssVAUEeFFSi6YKu0OILxwiuwJhETWEPt9KY59huh1TsmnMZkODV6Qnk2AcQQtjMID
         RxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671344; x=1716276144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WNa+3eLjaxowCpV/iLa2mMgq8zXzxRscxKrC3IUfjs=;
        b=Vp4OAHhqr3zO0ZAE2zAXnSisEZ49GZYja9UatRPKe6QgOikIz6Obw7u8RIZBpLK+Tn
         JmKWOTvZEb4d0xp4ad7yQszEZdOd+9PEDyEHX4kUX9Q1TPIWGUjxCiuUb4KqYQYsRKVu
         Q1rcOtFE+cfFyg+9J+BY/JbME7//yrMwiuV53JMa7K4QKifLFUunKBLqY7kggcZCKpMF
         n83Bhp4fyaYLkxKzF1phHNzf4Oqs4N5av4UvsXm97FJQX2eQGVPckJYJ6/nVCCKWd9DX
         LgbkhJ0Pv5u2uTYY+J2Ppmmu3zTmtT/oZ0RV1aSXJI2Rg5Y6OFBb4xPth3d6SzAnWQG6
         tR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo3W85dheKzzg41LynFF3wKTr6FBNX9lHkz7y2L/RGF3Kl6Imj4NQtZoBSpsYef2PTxQiHPUqHLcU+QHw5o/uA1ZzE6kRcpWRYBLFHV7icvbYgNI5qwcDbFdKDft7AS2vDBCCYgM3Haun0aeIv/dY5Gi3edzN2qE8e2x2Vazc9u5EjBw==
X-Gm-Message-State: AOJu0YyTPfgYFhteclpQJUgD1vozj5jtaGoqnvHPQZ2FmhcjcJkQ4URS
	LOsbAwPrpME6zN6N74OeoYwHQB12nkrh9VOCBuznOGnAKdYSUM8jVrZZBqyBqvttBvhUczynSph
	1tokWkiyDYJhhqrVi3MX9YJ2iQaE=
X-Google-Smtp-Source: AGHT+IHz7rxMKPw4QcPFf9e3+rPk6L5/ivfWPbNHVCV7og1/nXbe/V3wGrxTTVUvZ2OU/ikTt9tJestH0UovLmH6h3c=
X-Received: by 2002:a05:6e02:17ca:b0:36b:85e:7d69 with SMTP id
 e9e14a558f8ab-36cc144b718mr211747815ab.10.1715671343660; Tue, 14 May 2024
 00:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
 <1715219038-32453-3-git-send-email-shengjiu.wang@nxp.com> <0d10a689504be61c50b186d89ddbf9d1.sboyd@kernel.org>
 <CAA+D8AP9uS1ePxSeSUPGCGe42U5sNguZYQS3d-9T305d2iVbhQ@mail.gmail.com>
In-Reply-To: <CAA+D8AP9uS1ePxSeSUPGCGe42U5sNguZYQS3d-9T305d2iVbhQ@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 14 May 2024 15:22:12 +0800
Message-ID: <CAA+D8ANZYB2ec8qEzub8++Rz76zwn10Bt9c7cZ3tSTUbbQfwGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: imx: clk-audiomix: Add reset controller
To: Stephen Boyd <sboyd@kernel.org>, p.zabel@pengutronix.de
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, conor+dt@kernel.org, 
	festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, 
	krzk+dt@kernel.org, marex@denx.de, mturquette@baylibre.com, peng.fan@nxp.com, 
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:02=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail=
com> wrote:
>
> On Fri, May 10, 2024 at 6:04=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Shengjiu Wang (2024-05-08 18:43:56)
> > > Audiomix block control can be a reset controller for
> > > Enhanced Audio Return Channel (EARC), which is one of
> > > modules in this audiomix subsystem.
> > >
> > > The EARC PHY software reset and EARC controller software
> > > reset need to be supported.
> >
> > Can you move this to drivers/reset and use auxiliary device APIs to do
> > that? The idea would be to have reset maintainers review reset code.
>
> Thanks for your comments.
>
> This is a minor reset control only for XCVR devices, two reset bits
> are accessed.
>
> If we move to an auxiliary device,  we need to define a new header file
> and a new driver, which will bring more code size and complexity.
>
> So is it necessary to separate it to another auxiliary driver/device?
>
> And add Philipp Zabel in loop for review.
>

I will use syscon and simple-mfd to separate the reset function to
a new driver,  which will be a child node of the audiomix device.

Best regards
Shengjiu Wang

