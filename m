Return-Path: <linux-kernel+bounces-254242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814989330A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377251F2264F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D911A01A7;
	Tue, 16 Jul 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qm7qPBQS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B91A01A1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155696; cv=none; b=rueAQdqKE3hC+BXFRyjhsdFn85J0GWN1a4bAuLmYonhxp8GgCr1HdBi5aTpv/6lfTh+BwtWY3shIXoRVjSsOmHcf6lA/vqMskfUl3PSpU3Iutk0CmFFImMkecAFy/kYHB3uXYEWvEgVG0KVBoH7z83mELKRsST2PYFl0HYF14X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155696; c=relaxed/simple;
	bh=X11kgaTdDhmi0C3IZxYTC5o1Z7yzGXY7w5xx+39RX4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+6pfEuuEPzvXDX2DwEPESlWv4+g8YQMbRTRa6aghoteoy9MP5nDqdtQDE9e9ocHKfOxKxBA3jEJXwjoyMLIC+dferuaiBVRqJF35iQh1M60MgDsn65TA1cV3j8+r8PKHbeUHDjOTuwoz82u4XVGc78oitAYThhk+/OZugHJaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qm7qPBQS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so42211101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721155693; x=1721760493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOIRFFMAy+ymDlCZCc5cJzSJew0SEJjSB81xICfFquk=;
        b=Qm7qPBQSEL0rx77QBB9BB6GChZETOq/el9D3wCJTV9C6M2xFi8w1UkSkiNZTNR8PR6
         pExm1PCWrU7/dfHIq63U4Bqv7al77QDTc/m/XXnL0e2S9jV/Y63S2lzJChC6hHuoqayY
         8u16WcxuPYZsx3hJYcUCajlVNdhequKTShnom4V9nFB5ngNdeZJUVf54mvuqGqgYcPOl
         r0vtuzBeamgvg00QNff4DGwP3AvBq2qCqYbAEIRvE+q+jUf4CzDh9S7KsA51BEuq6vsq
         U+SDQeDXzno/8j04T/XMAyzA4Sg24CXmQwdAf5z8o3YMY11wCsQZGAfeq6d2GhjbfrFo
         FlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155693; x=1721760493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOIRFFMAy+ymDlCZCc5cJzSJew0SEJjSB81xICfFquk=;
        b=VclSfoBVF2PqSKa8QodiMaclDGGw241pm5DMYSML6/Oaebs61c1YrQjbZfHj/PZU2Y
         Yn8w6Z7GeeXC7+qBixHpL/lHfKdKBndPqtPjAGDccyHLKuNChTi0fcUO5TAAZgIeXlHG
         k1T8Nmzl1rJXxCT0yJW1BenF02s4Ayf2CX5vIdErCFj4pGuseUyjoeg+flQBztfLZNYC
         DomjTl4eIAauVy1uuh9UKJUzMJgI4kinnNuz0tTA7s2y2d1GIGxbA0Nw2Op5XOsNGKDF
         ar21CrPzpdJxf4V2JO9NAIXrxTSzun+38W2BphSRCyVgF3ka6VQJfX2CHqBDkT3EZo5d
         q+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZAlfc2WkaQBcbjCfez/mRPjrNl/rnvpeeFR5GQIz9lkuLDbiuG9pxSM8qNMKqY6QgbQaARAhluPrTOlvj1UAAst3BG/iwlrqsri9k
X-Gm-Message-State: AOJu0YyNGCM3dU1M2iTNe+S3sm3rr3fhiaTmWhIgIpWznZWuhY05hGjc
	yGrHOgGPfRYTbZ0RJw5ZjL+qupbovvV0w7eM2+d926ucQzsBtcz0R+OqNdL5T+2+wfyN79zXrTF
	Et6NODuePDdobMADVO70JJop7MUnGJt68nrWt3u7y1CN0mZ9Pcgc=
X-Google-Smtp-Source: AGHT+IEXAQSYmHQAGA83zyqUP4xjyj7ChqZ7HFkW8OFzsMU7WEeq6kHwuFzNS/cTYjdZuODkqgutB6HO1xnuMMd2Y80=
X-Received: by 2002:a2e:9094:0:b0:2ec:63f:fe91 with SMTP id
 38308e7fff4ca-2eef41cc7admr23824741fa.38.1721155692809; Tue, 16 Jul 2024
 11:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
In-Reply-To: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 20:48:01 +0200
Message-ID: <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 08:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > Let's remove the public menuconfig entry for PCI pwrctl and instead
> > default the relevant symbol to 'm' only for the architectures that
> > actually need it.
>
> This feels like you should just use "select" instead.
>
> IOW, don't make PCI_PWRCTL_PWRSEQ a question at all. Instead, have the
> drivers that need it just select it automatically.
>

But this patch does it. PCI_PWRCTL_PWRSEQ becomes a hidden symbol and
the entire submenu for PCI_PWRCTL disappears. There's no question in
Kconfig anymore.

On the other hand there isn't really any driver that would require
this. It's a specific platform that needs additional handling of
resources before the PCI devices can be detected. This is why we do:

    default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)

If we selected it from the ATH1[12]K entry then we'd be building it
for many platforms that don't need it.

Bartosz

