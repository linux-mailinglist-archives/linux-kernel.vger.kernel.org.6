Return-Path: <linux-kernel+bounces-185431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D898CB4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ED41F22DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154D1494C5;
	Tue, 21 May 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzYYGIFO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1DD51E;
	Tue, 21 May 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324415; cv=none; b=rRIM+ONINqvkN/QNVQSK39nldnYfxvc152Oa3ksupPghLEbgzxMwPAlmoAJ0xzjVrBHiGohVv5RoGLOThyhSa+HvppeJbVT/M3IxrhoHnGmFaziw7U0gRCK3uMqBSkDUtjonsHSzjjwi1x8qoHVkAuNQdOM67tw2YwzhTbpbrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324415; c=relaxed/simple;
	bh=RwCS/BKSDM1f7z64QrAXpA4rfh3F6s6yn7di6QgXgHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoywmstoGkXFNky7ttAGyJnoHlV7sWDhVnsw0uujOfEu+5f+RCCLX+Ih+2Q/s4F57bS2DUEZKdSyER9Ch6ye/y9PuUn5eHqGTGEqqdRvod35T2MinO1a7ZPQc1BTLGszpLXyl/HWAQzhz8Rbnpp3XI0bxJKZ9Pw8KULfLconxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzYYGIFO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so26401285e9.1;
        Tue, 21 May 2024 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324412; x=1716929212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwCS/BKSDM1f7z64QrAXpA4rfh3F6s6yn7di6QgXgHU=;
        b=AzYYGIFOfIYAdWflhdP3WFQQvZ6kfM1c+3bnsZWrq4ctQ58568thTSjjhyErKGFlYq
         U+W0N9Wg456aeUUJtiOZGGQdnC3ip7xnpiBHkm0kFuJPSf9U0ex/w9qEULKpTUle1IOI
         47xc3FIlhCkWxdCdJSe3WEJqiCf5DkTPkqN09Mz7U/dXPtJy9BA1qlcGRmkJbaoZdcvT
         svoZvmw+TCa2U0lXxSk9M2RmVR4hijnn3e5+BHEDHA1Y1JRGipUtQS0zKboqFUMD45Rn
         zRO0rP5e0ydoxuj6eYmejr/QeyxhHmRrDw6ZPNdJYfDbhwzVo3C/Wyp/E1auBx+bezwN
         cwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324412; x=1716929212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwCS/BKSDM1f7z64QrAXpA4rfh3F6s6yn7di6QgXgHU=;
        b=D1cnBOorONL0sYJbE7/hD/B6qVoc0vCSG+QGIVRCensIvU8Lb4zGli5fJQNOSAcUAf
         K1UAkJ4uIwJUisRntLv/84XEp6mWLVxZEll1fHNj1rhu8NsQFM8O/6XJ7ayqpT+a1d0M
         qiO489QzEZ3gd8g8DVn3l7Brl1/35dqZIFN24Y2Gt7MNF4Ri+OwCT+iYYnWwe7aDckMD
         OwNpNfJLQfM013FwvNfdakL2iekLukfQqAodiigp4kgg4nMumZDfDmRbhM1cCdhL4aVE
         /YYSZ8T+mrQAayqpX+j0pyo4rtV4uLPAdJO8UyXki3guDRFu8qPZ5YI6XrtrZ/Asilf5
         5/dA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrivzw2bCR/W+xI+vK021QcnIlBdOhJ/9EJpgCW5JyEZBXAlXe1Exru8STedSGh+2BJ7YKLcdSA/RFlpus6QTVqJb4qKuMst79H9Gt1Q1549UjMz0XnY1U+b6eeG4GjGtMwbwF9Pe
X-Gm-Message-State: AOJu0Yz/qCZJuvQELUmMkTflmyo7NBRIPxRZLWtLpV51Zm/JQ3bTfTPq
	NyZzeIAOkHVHw2STc1tFAOCLlw5jA11iM6yjJLKUegkd6rhyehtMAZpiwMIvbYKl8TlViMRPIOX
	6luJGd+MAfid4wtg6zIXaVfBmu8Q=
X-Google-Smtp-Source: AGHT+IGcLrfBXeHBA92XbgnHbiKtGAUgfZhqxUuqLn9hCITg0wXgeu05E4oKOYBsbBo34+QofYiTzipnKVFp8jKBeXY=
X-Received: by 2002:a7b:c30b:0:b0:41f:bcd7:303f with SMTP id
 5b1f17b1804b1-420fd30e480mr156395e9.16.1716324411817; Tue, 21 May 2024
 13:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520205856.162910-1-andrey.konovalov@linux.dev> <CACT4Y+bO03Efd48XW7V6F2D9FMUoWytV8L9BL8OK2DR8scJgmQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bO03Efd48XW7V6F2D9FMUoWytV8L9BL8OK2DR8scJgmQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 May 2024 22:46:40 +0200
Message-ID: <CA+fCnZcd2nJ6XLmJcPfwVJf9wUcHqWjYnafDdV8pmm3HpjY7Wg@mail.gmail.com>
Subject: Re: [PATCH] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
To: Dmitry Vyukov <dvyukov@google.com>
Cc: andrey.konovalov@linux.dev, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Tejun Heo <tj@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:35=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Mon, 20 May 2024 at 22:59, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > After commit 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH
> > workqueue"), usb_giveback_urb_bh() runs in the BH workqueue with
> > interrupts enabled.
> >
> > Thus, the remote coverage collection section in usb_giveback_urb_bh()->
> > __usb_hcd_giveback_urb() might be interrupted, and the interrupt handle=
r
> > might invoke __usb_hcd_giveback_urb() again.
> >
> > This breaks KCOV, as it does not support nested remote coverage collect=
ion
> > sections within the same context (neither in task nor in softirq).
> >
> > Update kcov_remote_start/stop_usb_softirq() to disable interrupts for t=
he
> > duration of the coverage collection section to avoid nested sections in
> > the softirq context (in addition to such in the task context, which are
> > already handled).
>
> Besides the issue pointed by the test robot:
>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
>
> Thanks for fixing this.

Thanks for the ack!

> This section of code does not rely on reentrancy, right? E.g. one
> callback won't wait for completion of another callback?

I think all should be good. Before the BH workqueue change, the code
ran with interrupts disabled.

> At some point we started seeing lots of "remote cover enable write
> trace failed (errno 17)" errors while running syzkaller. Can these
> errors be caused by this issue?

This looks like a different issue. I also noticed this when I tried
running a log with a bunch of USB programs via syz-execprog. Not sure
why this happens, but I still see it with this patch applied.

Thanks!

