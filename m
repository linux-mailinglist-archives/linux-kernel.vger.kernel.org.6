Return-Path: <linux-kernel+bounces-311046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F1968446
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5265A1F23DED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44E14A4E0;
	Mon,  2 Sep 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1AHRAf9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20C13D246
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271884; cv=none; b=HjjskbOKC+3Q45YvDXVGVg8cnioJFTDdLy52zfJm4mGsuNm+K2CNXWhQmsd07CQB/WFvcRGNfp3VHJZCsvvxNSi4AsSp9XHDCtzcwoNe7mrB61LV2/xk9YfIJIGHF5RbX3fdEqNcUgcYj/bBnDtgtSW3NH0+2Ur8XTkiYpWgjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271884; c=relaxed/simple;
	bh=M84JCj8zi4vAwrfv/QxwmGeuGvN/FJUcIdnUA3ySq9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czgQCk4/ncpRIrkz/iwaWS87ODt1G0oRQltomvTwZAeCcBTqnjEf2c5efcORaIm84h95csAT3qriZJajyrCFmCVz5Ny75NstCluD0qiLylLQovS2p2dqg+XAW9MoNYlUjQUMSDeBKawpnWkUF22AdS0dZGJZ1zzoHwGwYtUNj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1AHRAf9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso41772891fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725271881; x=1725876681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/zxheEr8tXCJo2ol7/yP9UU5fTbigSFGPPbubaxB0I=;
        b=R1AHRAf99li1k/3H0idvGXZ2eIja175pCC42QkYwrtopF0tbb8ezhDAWki1VHB99+A
         cg7RT5Hidc+hsooz/BnCKKghIYdepzNyenHJbndHrF6Y5V7CIJloB6tVsLpqL4UMDXtK
         pCFZ4rJILbsichuWmn1uvWKB0QfSZ53wEhj22fEl4wu6OzJuih0u0XOhuqo8Fy54nFIP
         mekF567G+SS1zgCXiWWZLz/hwNnl0qh7g1sM0L/BtI3HHN9cVfhhdoZ4m1YO+m7j0/3S
         edSTEJTBkLQJM1XpJ7uTzXItD4fv0E+7yF6ukmKvePhmtvwlUKfp+JIAxX/tNIUM4kwB
         MKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271881; x=1725876681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/zxheEr8tXCJo2ol7/yP9UU5fTbigSFGPPbubaxB0I=;
        b=cB8Smou7hkB5rMXdgBOL5hMvasmrd3u4euDO6YVurCi+kftJ2McmejGXgRimq5Mpb+
         QU77soCgdNXPALOSGcXTk3OJZCzfCnHNMi6lJS0602u+Oy2TARd0k5FIrM+kK6mw1/eP
         7tIs7NwVz8OmpO2g6E2H3hbEZTTuqD+GPKhbsUsikPVz0m1RmsP4w0u0OSt+KbBA+TQS
         vzC3WlUnkU1iDY6KwlFmkoVcjJG5yNkdL32goHi9aNzOl1OHK7Sw+0Z9Z+CEJfiQsEzl
         DqvuhlCC/6ymbAZVW3OxvPjnftSuchOb7qY+BRaoqCgF4tUhwDYCH9apTlPK6NmoAwTf
         D8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUG9NHKEFqJxek9j55hCiTYUDGjjgcpV1hXBAgYkprTKxE5JqmP71ljcoJsxHReRzxrIZTzvllG/6YNYu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1P5xsIRS4hzf3V4ZlKDQoubsew1fHYP7gdK9ssxl4L+tK6Yrj
	Cfj/fhk86692VqCoGYZnFFrjWTactMGvjTqth6kgVXevQGdlZg9g9gLB+rd7YxEE/6IcEQmF0HB
	so3QidlnpsXncLwCbnXYI/NSwY1P7tk1w
X-Google-Smtp-Source: AGHT+IFze8CbY8gx83jy17jXWEvyL20s9FvJkSPqoyoYoDrfwVqYzplljyNs1jUihr8AX7aEhLjF+h0hKxEtNskM3Nk=
X-Received: by 2002:a2e:80a:0:b0:2ef:21b3:cdef with SMTP id
 38308e7fff4ca-2f61e0594a2mr50992541fa.25.1725271880299; Mon, 02 Sep 2024
 03:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730132015.8920-1-ubizjak@gmail.com> <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
In-Reply-To: <51c33ede-b379-41ab-88b0-71615e214853@linaro.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 2 Sep 2024 12:11:08 +0200
Message-ID: <CAFULd4Y83ciewbJe36jsuTVXL705_DoS_QpjKayniSCdqkpsEw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/jcore: Use request_percpu_irq()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000091377b0621202905"

--00000000000091377b0621202905
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:17=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/07/2024 15:20, Uros Bizjak wrote:
> > Use request_percpu_irq() instead of request_irq() to solve
> > the following sparse warning:
> >
> > jcore-pit.c:173:40: warning: incorrect type in argument 5 (different ad=
dress spaces)
> > jcore-pit.c:173:40:    expected void *dev
> > jcore-pit.c:173:40:    got struct jcore_pit [noderef] __percpu *static =
[assigned] [toplevel] jcore_pit_percpu
> >
> > Compile tested only.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
>
> Added Rich Felker in Cc
>
> Applied, thanks

I think we also need the following patch, since we changed request_irq
to request_percpu_irq:

Uros.

--00000000000091377b0621202905
Content-Type: text/plain; charset="US-ASCII"; name="p.txt"
Content-Disposition: attachment; filename="p.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m0kubc8a0>
X-Attachment-Id: f_m0kubc8a0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvamNvcmUtcGl0LmMgYi9kcml2ZXJzL2Ns
b2Nrc291cmNlL2pjb3JlLXBpdC5jCmluZGV4IGE0YTk5MTEwMWZhMy4uODQwZDA5YWZiOTQ3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2pjb3JlLXBpdC5jCisrKyBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvamNvcmUtcGl0LmMKQEAgLTEyMCw3ICsxMjAsNyBAQCBzdGF0aWMgaW50IGpj
b3JlX3BpdF9sb2NhbF9pbml0KHVuc2lnbmVkIGNwdSkKIAogc3RhdGljIGlycXJldHVybl90IGpj
b3JlX3RpbWVyX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCiB7Ci0Jc3RydWN0IGpj
b3JlX3BpdCAqcGl0ID0gdGhpc19jcHVfcHRyKGRldl9pZCk7CisJc3RydWN0IGpjb3JlX3BpdCAq
cGl0ID0gZGV2X2lkOwogCiAJaWYgKGNsb2NrZXZlbnRfc3RhdGVfb25lc2hvdCgmcGl0LT5jZWQp
KQogCQlqY29yZV9waXRfZGlzYWJsZShwaXQpOwo=
--00000000000091377b0621202905--

