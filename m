Return-Path: <linux-kernel+bounces-244997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A0392ACCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2482827F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3A150996;
	Mon,  8 Jul 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muMOU5eM"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828703A27B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483096; cv=none; b=TnpCcgzY8f+iksy1i6DApkVC7j8vpSbmaxpQgqOrlq3eoaVEcerG/o9vrGKDua/0BXkVu3paYWOsfNcq4mSuQbsAhqohyOLL/PE/v3WRLxkMycXjeNIjLTUECd6WNWAVUE+au/uO3cMHAbAB83NYAMQhA+dSA4Z7PHkEut8oJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483096; c=relaxed/simple;
	bh=7EN+YIsVbTIxzF1Z9SvdOZ/EM3QwsvXIiX7ZgAcuanQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoggaMqf2VsasuLMBSEV1HMt/DO33+exxv8XRzxQR1dodg2JQN87yO55LmMPej+7iDAeaNWgAgIE8XmS7DQXx34/Y4cGJSQBH33Sd0MS8lKRSPMhOjHieeeSZ3upRvikZM/ojEVKU8s7rOafD6gnYb+3EcLvHElG4/iAPBQGVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=muMOU5eM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-446883be273so24444021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720483093; x=1721087893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swlwf183naPwNtrfd1IMk+Z2jSuxIkqYhMm0lDWZmQc=;
        b=muMOU5eMOmi4c8QMQXVi1wGbnoOwQ/oM36riQc+wRKquHPDpp92r7F7hAIYbLb4XCd
         NCxnjEkqG2GM6PkyzFGzqHd7hlhHI/3m6R6tjgNT0S14hqvKs+GEIgAQ0QHBrslZJn8v
         MfZZsUiFMFW3RCpmaV2yC5ybXFgeTkVYvp4rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483093; x=1721087893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swlwf183naPwNtrfd1IMk+Z2jSuxIkqYhMm0lDWZmQc=;
        b=AFJjEzenu04+L8e22qr5QGntpDHdv3NyMGXqDD7chvaWIbJ+KaYJ0+8ZllkkA/OgQ7
         mkcESpihdGF8jTN/bKkmZunh0rH58b1k88PzCILkEF0YDEt1y+Vnn8B0hob+Eo1e1tpI
         /rEmtkUKo9Kgw2qJ+/8n1QIY4e24C9CKvxr0Gu8rWcwzwXP8kxigIkR/wJTzwm8Z7fhi
         hVG7Ia6HwrisBhsSDnXQxUVjlsxZq/5kj/KqmsGmKM4a4LLSyASKcodWswEnj5ztFtzF
         rvuBd5y1i3IAg8g0Tk6utq1/k2Ox+WAQnh0qbDpQIz9r2zpP487oeEeJZJfYLrGjJg/L
         z0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUJFDZ3HWom7FKSjHWf/9vQ2Hu2SC1JHonBfYTYALJ4AS4TkXlCqwGl9rLU1xjO+mpFjKQ6pFJ5mY5p1Cx35cJIGC6HNBzlXTRewG/Q
X-Gm-Message-State: AOJu0YxdSdt9p+1RhegGXY9z1ihzI6XZGPzrpK3DonwBTixsaqbwwD3V
	pRDZB7mZ9PJpT9PkoYhWnJ9ZT4K3+nytitZWigNvjl0OhnniHS3C8gI+VEtsgnWS9eY/OcWo0Kz
	08uL0
X-Google-Smtp-Source: AGHT+IFz4NrG94sP+Sbl9D5yobj31C2PFCdd1q++UbnUniGhR+lqNnRfUvYaMAEvlLtpNEFPeg93pw==
X-Received: by 2002:a05:622a:55:b0:440:279c:fa0a with SMTP id d75a77b69052e-447faab3725mr9358151cf.53.1720483093068;
        Mon, 08 Jul 2024 16:58:13 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b5120asm4473951cf.44.2024.07.08.16.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 16:58:12 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44664ad946eso55221cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 16:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcnVltOZw042hkY+BTW4t1vaQOJF2PEvI9J2VCWbIZIPyq9toms+xuq42yKbQqZfOvPciMSFU9b/13Bq9aPad9Fcy8ffzZtilIta32
X-Received: by 2002:ac8:7f4e:0:b0:447:d78b:fdf6 with SMTP id
 d75a77b69052e-447fb1ff3abmr1790991cf.10.1720483091723; Mon, 08 Jul 2024
 16:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704101805.30612-1-johan+linaro@kernel.org> <2024070445-stunner-scrawny-1b03@gregkh>
In-Reply-To: <2024070445-stunner-scrawny-1b03@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 16:57:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0Sk0Xkz7Mcna6BNhGpxZQY5KArY=LqMPEwbocvmojQA@mail.gmail.com>
Message-ID: <CAD=FV=X0Sk0Xkz7Mcna6BNhGpxZQY5KArY=LqMPEwbocvmojQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] serial: qcom-geni: fix lockups
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johan,

On Thu, Jul 4, 2024 at 3:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2024 at 12:18:02PM +0200, Johan Hovold wrote:
> > Since 6.10-rc1, Qualcomm machines with a serial port can easily lock up
> > hard, for example, when stopping a getty on reboot.
> >
> > This was triggered by the kfifo conversion, which turned an existing bu=
g
> > that caused the driver to print discarded characters after a buffer
> > flush into a hard lockup.
> >
> > This series fixes the regression and a related soft lockup issue that
> > can be triggered on software flow control and on suspend.
> >
> > Doug has posted an alternative series of fixes here that depends on
> > reworking the driver a fair bit here:
> >
> >       https://lore.kernel.org/lkml/20240610222515.3023730-1-dianders@ch=
romium.org/
> >
> > This rework has a significant impact on performance on some platforms,
> > but fortunately it seems such a rework can be avoided.
> >
> > There are further bugs in the console code (e.g. that can lead to lost
> > characters) that this series does not address, but those can be fixed
> > separately (and I've started working on that).
>
> I'll take these now, thanks!

Are you going to continue to work on the driver? There are still some
pretty bad bugs including ones that are affecting Collabora's test
labs. Unless you want to try to tackle it some other way, I'm going to
keep pushing for something like my original series to land. I can
re-post them atop your patches since they've landed. This will regress
your performance but correctness trumps performance.

-Doug

