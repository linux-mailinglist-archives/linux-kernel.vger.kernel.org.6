Return-Path: <linux-kernel+bounces-228562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A999161A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE521C21A18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49334148850;
	Tue, 25 Jun 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jy+gPuMe"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F350A63
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305417; cv=none; b=niK6siNlnIfXyK/jhmWEk8oCA83KNN0/C5EGCN7LqOwRSpTuu6hH9XnMy+91CD/LrHxSo8ExSAA2gbNFrDHs6AdMblvXOWwmWhEgi3RWWxAHUZAmtbBUaSIllA7QN7R7HgiMg8aNHgoaW9IY+FZ0FUVoIi33s3xbZhScLEohqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305417; c=relaxed/simple;
	bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHWGeaCALywMNqVjAkrshe9OAodRr8TAL64eEPUw+HILbXeHG88JYohkCiBbV0VsPEcEQNgvNGN4175s2a4k8xrzbXxpKtfBWP4UoviP0AvIo7iimXgQoWI+3BbBUBX8TZF/NUDWmeD+koPZ3tXppxzQN6nPXpL9TRotMhdeb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jy+gPuMe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3905921a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719305415; x=1719910215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
        b=jy+gPuMerNtFCZewrxSBcGOXmWUKDlR6erzPh8blFqFrtzjoDs8Gaa/Eb+2zzBdUjx
         NV1q2yYl4keF+hCFb4NfNUPC2shwOhXstDXwUiuabC1sanVmg/eScCrc5crivgpfO3DD
         6q9QtxsA2A0Qpz56ZPA80dA3nbhEk9kiQGmqQIKkK36Qr6I8BM0ovK7s7DZRohli9i7J
         nTaM+oNRlUYKX00dnEt9iNNFBfeNMFOBbfc1iZQ6mQzDlW1pCMl3RuvJZmLMq6D6CO7c
         ncMqdrY+yH0UFNIV5FGdJShPg7u0RhdObSZCiWVH8hG7Tg0w3Hb7XwN0u+vI6AvN4EOi
         YuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305415; x=1719910215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K928MGnZ+PjaLzHLPDP9/9l4mTcymRGUKsFIfW80nj0=;
        b=Fp5OsxfYGyVlXUpwGhXEOho+xVsiuS6Ibivqvg0m4PUjFkZnP9JwwbcoQf8D3B23Fz
         +PCtD1GbUFZhtK3SMGUsOkV34Tw69k+HVn5ETJN55yiyNTtrbNE99UR44v6C5PQrpYCB
         7UUTspJ9yJ404k3PMAkDYvMDukNBS3sRQQ4lk1qNbMkTH5QZIZ+g4HOH692IlQiF/vTV
         bo3hw50C6tNhHn2iJIlTJERjAk/jhPun6q1/H09/vRwUQT1hG79g4JksqVanUH4naeeM
         I81D6PCGHW5PTtT+XI7yzqxqKqTQYO3Wm6vRwnPpmaKDcCgAqg9bRl0w9x1Fiwd0eYym
         TsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHInaAEJU9C2ibjLc4eov3y8zSRUMjJw6LSU41m0V2KHlT2A456WZXrgAXJa6BNODo0H0GcM7aCXUas1l8EziIOA+O8TeaLeVzSAm
X-Gm-Message-State: AOJu0YwlnzzU6SC4OZcOGXXqQz1L6A05VgghM0ZV/5NiNx/DRjlEy+V/
	WOwVxYn79gMEx6HXjhTkGOmqSMkz3PkzUid9rGxEo01qOw3rNQVSB3G2glOfeOWaZEyM4uYvGxx
	h48Sh0/YZ9JSX5Yoc6SQItje9pb88h2UzrrGqzQ==
X-Google-Smtp-Source: AGHT+IGxy8QyMvcw1+/Aoy8XRE8HcZMjuOCDtdp7FQmo+RVPhWwYnuL8Yg1nPrRC+yDhUbYdwhD3QkFV54cdkTtZHzU=
X-Received: by 2002:a05:6a20:8422:b0:1b5:8552:3922 with SMTP id
 adf61e73a8af0-1bcf7e32860mr7662957637.3.1719305415296; Tue, 25 Jun 2024
 01:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com> <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
In-Reply-To: <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 10:50:01 +0200
Message-ID: <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > >
> > > > Neither of these has clocks that need to be driven by linux. The on=
ly
> > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> > > > before so no commitment was ever made.
> > >
> > > This might make some laptop users unhappy.
> >
> > Like I said: without upstreamed DT bindings, we have never made any
> > commitment about the device properties. I doubt anyone will complain
> > though, I haven't seen any DT with QCA6390 with clock properties yet.
> > I wouldn't stress it for now.
>
> I was thinking about x86 laptops / M.2 cards. I'll see if I can locate on=
e.
>

I don't get it, how could they ever get the clocks property without it
being defined in firmware?

Bart

