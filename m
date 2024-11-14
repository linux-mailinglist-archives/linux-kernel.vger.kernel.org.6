Return-Path: <linux-kernel+bounces-409999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7779C953F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B8283293
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F91B3937;
	Thu, 14 Nov 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhsaKCC7"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406B170A1B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623850; cv=none; b=Rj8D7N0sTAJzsfbn/xQW0thDXLqNgJikuCqFjv8/rEmr00wmC11l1OmiCUYAr5Bhcr0u9ZZLVZUUglsQKH+7uElTm8AeDtrpNw1ng7N/SLHN+1slBcIAYJ77T8SxC7hGmNbIh7PIsu3ApDNRypH+AvdasMh3ydXFcLj9C1I51lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623850; c=relaxed/simple;
	bh=wcwB8H31/Y1Daym2S10HotSqx/5KUs2/bNntNKGXxx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEuHeKmcz4aM6SF7lu7/ZurYqW68AcnnT0vLdGQV3b8+YCoKkU4cHTjA8WmEkcV0m6uwEW+xDHyJc96IrmmZKdcSVG/A8VKVw2tptWtzDKtdc8lplC6oyIR3fnM10eoA+OCvT6td2nX2U+9UdC1MPi4sz2H4y0zaFV8dCowznOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jhsaKCC7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so12474291fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731623844; x=1732228644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzfTf4nLHjn2xQf4QA2C8+y3a5abfetAHXsvMWTvNs=;
        b=jhsaKCC7M6SVoDXZC9wwPJjce/w220ra2lQ8DSiud9edKW+vEWLARWzTX5K2TOSliW
         YpVPSzk1+vRZ/4FOSnBAj2EXaCUfOD5GDPjAjwKLPmltEwxGMfWQoa8B12we+ll56Bay
         UYwleW+CPOkP9v24BhDnh8O1kChPtZueMyjJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731623844; x=1732228644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzzfTf4nLHjn2xQf4QA2C8+y3a5abfetAHXsvMWTvNs=;
        b=vd2U7AnfeUybVia0bs4yxqLDfC+YL4ozAg9kItQZ3Xt9n/0D2lABIiyVY0DpxB/Q10
         6hfTUhNeMLXmdTXOdQXC5KP254/BfPsrhzDya7T5/nx24AE8Xzzz7ZvUuIwlPNCtACHv
         LTN1XRWhbifGhE8eNpFjHxkJPE+hcZHULv5Cmh57Twq5onXY9EorSUnIFFfEyvLT3D7c
         ZP4cWlshvQoOGv2cGRuyGJ4iCkthIRymexKoyDpiPp3M9MKkm1hABQg3xi2M1y5PpdNF
         EMCex/bSgrKI1gcNEjnsmAVeHGEH4tNJO52MlWu//woEZCx1Rp2rJC7Nfpiub39eyRyk
         ON4w==
X-Forwarded-Encrypted: i=1; AJvYcCULWAnYLb2zJ24aezqv2rw8MgvnXtL8R/kwKv3ijTyhueGFfBQZO+fz3D36sHlqel8szSAnOaIg/ktQfaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjWiUshoZZuBqF7hA3pH5GLIeTr4pYEWVj9l9I9F2Mg4zRxwX
	sQV4Xu6GYEpJ664zVom/7I1rNNyR8zxSFaR/usi7F3j9qq0YonCQHcEiIo2agSq28dffksu12la
	oEw==
X-Google-Smtp-Source: AGHT+IGJY2XKjKbsd6Qn9mlW7P/0E9Rxitt58rCZyfuJOzIbSM+YhR5VIdLnD5XHbEKWnELXluTLMg==
X-Received: by 2002:a05:651c:54f:b0:2fb:70a0:91e7 with SMTP id 38308e7fff4ca-2ff60916f3cmr2825771fa.10.1731623844110;
        Thu, 14 Nov 2024 14:37:24 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a077dsm3223151fa.54.2024.11.14.14.37.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:37:23 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1328666e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaOYN8d03jtlNJYZuRpXefTARu7SvBa4rjYuiWPtABgKHdplPT3WM2gIL7cVTW0HAZL3dcfRvlWNR8C/U=@vger.kernel.org
X-Received: by 2002:ac2:568b:0:b0:53d:a273:7da6 with SMTP id
 2adb3069b0e04-53dab3bc148mr167790e87.57.1731623842435; Thu, 14 Nov 2024
 14:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024111322-kindly-finalist-d247@gregkh>
In-Reply-To: <2024111322-kindly-finalist-d247@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Nov 2024 14:37:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XGBfkLQ2N3dr3smhMDb+ze-XpbHjd7EChAByGNwJOnOw@mail.gmail.com>
Message-ID: <CAD=FV=XGBfkLQ2N3dr3smhMDb+ze-XpbHjd7EChAByGNwJOnOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] USB: make single lock for all usb dynamic id lists
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Grant Grundler <grundler@chromium.org>, Oliver Neukum <oneukum@suse.com>, 
	Yajun Deng <yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 12, 2024 at 10:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are a number of places where we accidentally pass in a constant
> structure to later cast it off to a dynamic one, and then attempt to
> grab a lock on it, which is not a good idea.  To help resolve this, move
> the dynamic id lock out of the dynamic id structure for the driver and
> into one single lock for all USB dynamic ids.  As this lock should never
> have any real contention (it's only every accessed when a device is

nit: s/every/ever/


> added or removed, which is always serialized) there should not be any
> difference except for some memory savings.
>
> Note, this just converts the existing use of the dynamic id lock to the
> new static lock, there is one place that is accessing the dynamic id
> list without grabbing the lock, that will be fixed up in a follow-on
> change.
>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Yajun Deng <yajun.deng@linux.dev>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: - change to a mutex
>     - strip out of larger series
>
>  drivers/usb/common/common.c     |  3 +++
>  drivers/usb/core/driver.c       | 15 +++++----------
>  drivers/usb/serial/bus.c        |  4 +---
>  drivers/usb/serial/usb-serial.c |  4 +---
>  include/linux/usb.h             |  2 +-
>  5 files changed, 11 insertions(+), 17 deletions(-)

I'm not familiar enough with the code to confirm with 100% certainty
your assertions that there won't be any contention problems with this
lock. However, your argument sounds reasonable to me and, since you
are much more familiar with the subsystem, I'll believe you. :-)

I would have a slight concern that you are changing a "spin_lock" to a
"mutex", which doesn't seem to be talked about in the patch
description. This is likely to be fine given that all of the users are
"spin_lock" and not "spin_lock_irq" or "spin_lock_irqsave", but it
still makes me worried that there's some random bit of code somewhere
that calls one of these functions while sleeping is disabled. I guess
that's not likely.

In any case, this seems OK to me assuming it tests well.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

