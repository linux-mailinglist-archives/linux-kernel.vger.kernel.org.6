Return-Path: <linux-kernel+bounces-191020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B968D059F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D06290126
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34C16079B;
	Mon, 27 May 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FzN2KyoQ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CF15FD19
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821707; cv=none; b=cBe6A2Y6KAU1EufaF5l4seIyevEw/QnyEVAYZnTObwtkWWz3+3CsVCSuFgvCsSeYhvhKi21VUunb8aNSb0NbykamjHAluoUgaDvl9cEbbZy8Gz3zR4IoFb0QWAc/jRhg5TqgL40BZ/GpU3COu2lPQxfR2BUY/hI3eYTN+jq+K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821707; c=relaxed/simple;
	bh=5TD6+fP9zGBVCkWnjvWQY4Ucu0QI2ucP5yTRATx+ATE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn2Kedne2RoyqY5ULQI4jtTydlGmVODLbloKe4fDjy6qyOPo0bjpsD/r/TSgo38jDEZ0lbSCRc5ZDMKp/4jCAQAOGFLBkff2sp79AAdEJIkgfri6L9x8MfKNYobHm6Z4xBKjjmlZFgVNOVExyXXyIlkwuA/5FDGJ9yj8ht2v+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FzN2KyoQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e968e77515so27487821fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716821704; x=1717426504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TD6+fP9zGBVCkWnjvWQY4Ucu0QI2ucP5yTRATx+ATE=;
        b=FzN2KyoQRXGJ5PiqXT8HuzkptLZdyml+tDdNuAwiBFtsZJXifQR1IaF+h2pDadjYgj
         HA98Q25DbUir1P8Em96kIycOto1xILQeTE3R1RgjwABHQ8RlI0qEU2q2XPTfky8u8blx
         q1yoijWX42uapWS/sybfs7AzOSM6ve+HCAywljseJbFSOgNtNljerpatjDxYXkRPxz10
         T6/WLRRpysk/DKjktBXzFaiDxidKp/hatQkXupKH63AmNBm9RsmomL0L4YF3/QoGQN/O
         xPgTCo4YEhReoMb9EF5secNWEoNxOnVb2gs6G1tbi4l6YJxAreGuBfPavlKFk2K+QYOZ
         72lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821704; x=1717426504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TD6+fP9zGBVCkWnjvWQY4Ucu0QI2ucP5yTRATx+ATE=;
        b=nyykIMP9+TKXJzhPNQtBZTON8ktT5FEiU+asnlt6cFk76ozBVfypCLJS+yx5anurQd
         OrufbbbpFVBWPsGS1Cn0puHtF7cFh88HVRBK6DDkUhNrMtHvXhekBMC7uVDxCakENwVx
         BXhWF3LhrVuBL08r/VLB8K3tubSgnB3FIaiuYkzzMWiUxIC3LcFWEcbks5VMjPtZ3CRC
         GZf36D/Hgncr+5jNMqunilbmBgX/Y29YqAfqVJzZNk/WesBq3VLHax0XXpcbRRfrXV71
         37wCm69k9uHpHo7uoW1wfYLLTKpm5a25mktzaDShi5l263oI7VFFC8QQXqM9RaL8Xjjg
         sdcw==
X-Forwarded-Encrypted: i=1; AJvYcCVEnWKh/2N2Y0IJiStTrTryrhqUE+qiVDGYYrZXrbarM7wB+GgtXyIm2HZnlK2qiTSx1t/9N2qngjnc7Jm6fZLFihEMMDlOMii9LFX3
X-Gm-Message-State: AOJu0YytUc6YVBXqmyR3uczOlDof2MFgmFs5avt1DkE1CDd+3sX9ItpJ
	VPWfFJBnyEZZwOpfvwCElE0hcy9Oe9DbnrdtZ0zAB4x9O7kKerzS7NQi8XfVGCq8wVGNSoQqTaK
	2Y8ALk/ai5vr3XLc+vBLNjqVsIQ8lpQKUJa01sg==
X-Google-Smtp-Source: AGHT+IEWEP0lfG2yK4OCOQAmDalN2VIZFxrErH+r4nSQ8/qZSUVrTMLkXMTAMXvfbr6eAaU2P2kpvtmtsnGulk2HYyo=
X-Received: by 2002:a2e:a0cb:0:b0:2e9:4c17:9c8e with SMTP id
 38308e7fff4ca-2e95b2d04a2mr63410011fa.44.1716821703725; Mon, 27 May 2024
 07:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514041223.800811-1-foxhoundsk.tw@gmail.com>
In-Reply-To: <20240514041223.800811-1-foxhoundsk.tw@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 May 2024 16:54:52 +0200
Message-ID: <CAMRc=MeuHpu4_QbgW-6Kc-TGzhcBim7Eb-TZhPax6G2SZHR5iw@mail.gmail.com>
Subject: Re: [PATCH] docs: gpio: prefer pread(2) for interrupt reading
To: Huichun Feng <foxhoundsk.tw@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:12=E2=80=AFAM Huichun Feng <foxhoundsk.tw@gmail.c=
om> wrote:
>
> In legacy sysfs GPIO, when using poll(2) on the sysfs GPIO value for
> state change awaiting, a subsequent read(2) is required for consuming
> the event, which the doc recommends the use of lseek(2) or
> close-and-reopen to reset the file offset afterwards.
>
> The recommendations however, require at least 2 syscalls to consume
> the event. Gladly, use of pread(2) require only 1 syscall for the
> consumption. Let's advertise this usage by prioritizing its placement.
>
> Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
> ---

This doesn't apply on top of gpio/for-next, please rebase and resend.

Bart

