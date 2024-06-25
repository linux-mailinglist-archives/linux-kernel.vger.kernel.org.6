Return-Path: <linux-kernel+bounces-228575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2909161D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F85285488
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C84148FFB;
	Tue, 25 Jun 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QxHJUVO0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77D12B8B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306110; cv=none; b=WWZSmKlZaY0O9mzd3lGI4IAUfYJMvfEWcFpHw8upWGegbWbQDrv+uN1IQrrzKqqCW1mW6mm33kfPXTZsHMLP5M+XSzrChV3ISMl4Q/mBClpi6CNw6zBUrg9sZLIGDQJhsPO9q8DmR0s+0j/15xI8ZP2jG+J1SzBFLQcu6wLIcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306110; c=relaxed/simple;
	bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXBQ2rhmJdEEPPWRy8jJE9AQAzQX1fO7S7u38WFS3hz+ENvSZOUx2nFiK2GxhEJXh+WcjjQ4me8rNnw1BdPs54MJqrKBZYvqYPSCvhgyLoKM67u/GeXIhheN2W4bqTYygocpy6rTCMM4NrM0+Dy0bBgDutZYgVWCPt/9AmPw03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QxHJUVO0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70665289275so1594808b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719306108; x=1719910908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
        b=QxHJUVO05Rp4KfN6enVjFUvBUuZhLpbQnvVN/RDyUUOnX+FOtstfPGheWey8bBdfbe
         UJixcz8yzuVDw3MInBZcOT3EaJwwEvz+j6/dCd269L6b7lMzbjvv4gl8+w7ThW7czaE9
         vmgrVwjEcMMxpgvGSaEbIhtiPZChvZoVG392z0x2mmQTPLqdpHwWbHSJVT4sLlrt+a22
         BkcD+3PCKPfnas/VWpV1WLVUpNRitjZbsEvdI0KYzTW0lA/eGuscWdVfH1sZ3lxpjS7T
         HiWqSUIX/nVbiF95yKlFolBYxKNZR9pZvVbyqRZ32Ma/yMrO7H9nStxh7sbCi+FmdHfS
         y8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306108; x=1719910908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
        b=Vm8pmc/+cUtppC3eSvA2GgsQNE//HpGryhlMrKiKLrU8grHC1Y1jocei6Pb3Nimtn9
         uRu5v08pcNoE7ATZik94uMM7sA7pW2eJQvv/LFAkrUdQ9A4LZsf/FY/NnOOLhshHq7Ev
         5bnyUbaHfP/xpp/TjO+hmy232ViFtH6dseDbpjZfNbXKnTEfLVNWk/D/blZthuQemJmV
         /v+3ZRUT9XYoFXsGKeq/ycktyIj2DNFJnTHw0Hga3IjLj5btHrhDwyVf56TBE6Mse3iT
         w7R4PnQA0pJsPEQXeoeTmj/zn8m02LbhXTMQdgbe3JGJoZb6XOCVDLVHqvENl3/jvxXg
         EWjg==
X-Forwarded-Encrypted: i=1; AJvYcCVdj7f7PObjFzThpiFF33vjrEXFWsfsAgV2nUV/7QHaTDV29oJBXBtfVJoPzIouMR1tNU2zYJ5av2izh2kjey2FmjPII0R4/EhYv1ap
X-Gm-Message-State: AOJu0YyhTSH6WuZzWk0efM4xjLHT3WJECvIx+XiUOHZF3//Y5pU38obA
	Odki33kuZxbPiXS0PZ8LZqFvBAieoNwsSaHn43taPiuDHbZgTPHkjFSVIHccxdFk42g0BrzSNBA
	0/sF9BTNB8M9OMFIN5e87bnp8sJWrvPollOIkIA==
X-Google-Smtp-Source: AGHT+IEP9B/Z9+JvkO1/DnsGnPU+HGSZqKx6Hgv7uYQKDRxIo0sEfdAX3hNxOanmoH2qS5YoQRI9BgP9Kw9oXe47Pkw=
X-Received: by 2002:a17:90a:a40a:b0:2c2:e0f1:bb1 with SMTP id
 98e67ed59e1d1-2c8a23bf665mr4224583a91.22.1719306108171; Tue, 25 Jun 2024
 02:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
 <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
 <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com> <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 11:01:34 +0200
Message-ID: <CAMRc=MdAek=vLqMzdYb1yk+BtbBW=Vd=s-Fw1mxPF+sMwzZ_kA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:55=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 25 Jun 2024 at 11:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > > >
> > > > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > >
> > > > > > Neither of these has clocks that need to be driven by linux. Th=
e only
> > > > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't e=
xist
> > > > > > before so no commitment was ever made.
> > > > >
> > > > > This might make some laptop users unhappy.
> > > >
> > > > Like I said: without upstreamed DT bindings, we have never made any
> > > > commitment about the device properties. I doubt anyone will complai=
n
> > > > though, I haven't seen any DT with QCA6390 with clock properties ye=
t.
> > > > I wouldn't stress it for now.
> > >
> > > I was thinking about x86 laptops / M.2 cards. I'll see if I can locat=
e one.
> > >
> >
> > I don't get it, how could they ever get the clocks property without it
> > being defined in firmware?
>
> The clock and bt_en are optional.
>

But you're worrying that the lack of this optional clock for QCA6390
will break it on some M.2 card? That cannot happen, can it? If it's on
an M.2 card then it would never be described in ACPI.
clk_get_optional() will always return NULL.

Bart

