Return-Path: <linux-kernel+bounces-372436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF19A4870
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AD81F211CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBF18DF61;
	Fri, 18 Oct 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hss/a/DJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA28186616
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284559; cv=none; b=jFBzEbKEHpkHyUGdp4VKPEZw21ZYw3Cd5A0lx0FHs0m6UB+WqhHDuvoQip4nw6gMT/oK66aQ9K08ODBges/A3rwU6H05JzTPn1O5HEc8PYmXmF+w1gdV/NrEbX3JiLA6BYTWFBB3Qhoj8NIHEXAoFS6BDYdT1cPZsfCL719GycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284559; c=relaxed/simple;
	bh=sq2lBEx/oPK3mFck2yfdIPZDDYu11WVFdH4z5opWiaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB9mWNTPsE7f2qzxz2Viu/RtKJgwLm+QkiYVyAOgMSC1uAQMGR3HmiFJ/GxplKRAXufFCV+7UcAfyg+vJX/OY42W85FJUXQvq/T5u7evWZoXewYZ+xLsqPbDLSpB0e/WQHMC8El4JFs1/3GKP06miMrm3qbGwREHarvJWDr5Keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hss/a/DJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a007743e7so3231593e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729284552; x=1729889352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM/k2Z4ZPVx9AnrPUOX6+i0klklaqbDryXRJgrrJdkw=;
        b=Hss/a/DJ5Nb2+8tInkvIJbaLgJJh1RD7vbWaSnNXp2cq1xAvJQYrpyIZ9/g8Py8pvH
         +WTGD0V63yvstX/5452TXTqqMTgfnzloPI+Xy1NyF8RWqYMdKSTCn3VsJjqCPUzpRj2w
         kP4SXFR3HfE78NhpS51UW3OOSRh0zgjehQ/J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729284552; x=1729889352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SM/k2Z4ZPVx9AnrPUOX6+i0klklaqbDryXRJgrrJdkw=;
        b=ofN+BiewVC5AtBqDpjuA1pv1SVMe7IDGdNckQBoYF9aivhKnyoGcDn0I7f91utGg5o
         5fcvapWOpdiUQwYy0VCqQ56OILtNSKBrIT7odcYUB9D4tXFebJSHtsMduzHCHkuUlj2a
         cScTBo+GU13cwPCvWGi5HZos37f5bFwTes0tnFkYDW5so/sfNnZaPRoC+4YgB4j/Lmvk
         yjwfhkpPV0oNdoL4OBMWcqCz8Mre35sFDsa5Y5bKhU9YFb4rr/LPdSQzS250Cyv1bIma
         yZF5ve3klmDDPrVIvS+Mg4QnUir/6AxhJyF4wDM2vZGQzAOcfXRWPg6DIF72+mOTsTEV
         TQtg==
X-Forwarded-Encrypted: i=1; AJvYcCWMxOAsPI/eLBEakXbBa/d8yZ2VaCs7S4CATuS421kDnT++e3Wvn0pxSGqbDZk94jE4xhhdI4EPkrpjusw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztscHugEhAZ7Bpby6qNMuW7dUUEKaHbaNtZGfqxu+x3uzPm70q
	K6RLDT0U/kIhhjYoqzvo4orn5HWNAwxeEi+MEeLqEcyxTxcFRVDZf/yd6XNCNLdZEtRgOZtNZ5n
	48SK3
X-Google-Smtp-Source: AGHT+IFee8wFLWURN70q+If0Ufw2JJ16PSpNfgauZXsKawmfEp9ZIGHBthcwVp5wFhep6H6Ugzy4iw==
X-Received: by 2002:a05:6512:ac2:b0:539:fb30:1f75 with SMTP id 2adb3069b0e04-53a15499c96mr2189533e87.24.1729284552237;
        Fri, 18 Oct 2024 13:49:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b039bsm328138e87.58.2024.10.18.13.49.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:49:11 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53a007743e7so3231528e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:49:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjjnM87C2BrIAmCtD03tAz4zZgLqBmpNd+49cRgxNvcMul8tULx9mhGP1YjPZoMBHktzFdos+e+6zp1jU=@vger.kernel.org
X-Received: by 2002:a05:6512:3985:b0:539:f23b:59c3 with SMTP id
 2adb3069b0e04-53a154b3094mr2178158e87.34.1729284550257; Fri, 18 Oct 2024
 13:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020815.3098263-2-charles.goodix@gmail.com>
In-Reply-To: <20241018020815.3098263-2-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Oct 2024 13:48:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFrk4QCxWzV9zUZnjhwiFf22Fji5KH83svdwba2mPVBA@mail.gmail.com>
Message-ID: <CAD=FV=UFrk4QCxWzV9zUZnjhwiFf22Fji5KH83svdwba2mPVBA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: krzk@kernel.org, dmitry.torokhov@gmail.com, hbarnor@chromium.org, 
	conor.dooley@microchip.com, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 17, 2024 at 7:09=E2=80=AFPM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> The Goodix GT7986U touch controller report touch data according to the
> HID protocol through the SPI bus. However, it is incompatible with
> Microsoft's HID-over-SPI protocol.
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
>  .../bindings/input/goodix,gt7375p.yaml        | 68 ++++++++++++++++---
>  1 file changed, 58 insertions(+), 10 deletions(-)

I'm happy to let device tree folks make the call here, but IMO it
would be much cleaner to just consider the I2C-connected GT7986U and
the SPI-connected GT7986U to be different things and just use a
different compatible string for them. So essentially go back to your
v7 patch from before [1] but change the compatible to
"goodix,gt7986u-spi". If, for instance, this device also had a USB
interface then I don't think we'd try to cram it into the same
bindings even though the same physical chip was present...

-Doug

