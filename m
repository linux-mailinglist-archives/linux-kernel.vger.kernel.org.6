Return-Path: <linux-kernel+bounces-316012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21596C9D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4022892C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF81849CB;
	Wed,  4 Sep 2024 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDkWiP0O"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5A1547FF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486710; cv=none; b=qbgAcWMn34x2au1hBSlXW3pAtnX0NZIlszcwWvD6nePqd7ack53WZZi2s6092IRmgqIeHPM7nbzN0Anoy6BXOdMBRZdD/hn0NI6bjRungGPwLWmHedpTgwF6nynaZDgAB+kuJiNGPFmnPTqvFE3fjaMOXVC79YblD8o4LXKVgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486710; c=relaxed/simple;
	bh=3HkNVCxJy56k3u+LITc9D7/1LsDfdZXPVJ2TlkcFnSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guJByCgNDJAFXYc6I2GNmjjL9Y5GCCiEbKf4G0gTOfdpXronNR6aBf92zOFuFig0zLky3X9Gs6YO6VVATFmfIBFbyJ2r/vo8QHEoxV9q7T6UXAYdGwjongWqRxIjy8221wW634Ci3YUy9vfWYN9NxCpRgVm0cZzGNjqpHmoIe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bDkWiP0O; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso178942276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486707; x=1726091507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUwPDHkK2WMXQHvh/6LMKlWFNebPcDI2OCZ0Tor/Kg=;
        b=bDkWiP0OWbahkdJJV862dxvCBBGEyc9Fe3I3Ne9SfD/UsmcqGlpNINc+JbC4P4S9Nd
         0LU9tf5JjE4bgzcT6uYMkBu5fNF+EcilHbicB8rNezYhzikTeMKPdVwWcAQfC/LZOoIw
         xyWENCa3H/rcw21vr3vgtYgV8EslwAraLdq/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486707; x=1726091507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yUwPDHkK2WMXQHvh/6LMKlWFNebPcDI2OCZ0Tor/Kg=;
        b=F62GA+Sl2jxgGFE3HoXkWkIc6o2wXLENxbM6a74ifzfqiS19Zhho/ka50GZYfht05G
         OYWaZcneyRyPd5+8/6fQmfK2ZSyAfXbziFGBHj5Sux97AIxBT47FTX2XLbXBmMBq75pT
         D0vk3IBgu6sGMzyE8YCruLr9d30xylhUoUqly5dWINFqBn8gef9He51jOY5Zx8PC1QVd
         3/GIuMJxPBY5yMDERtBXHrcEilVaZUrKSe5ckO+GyqXFqsaPDxEaLLpcqkdt1v7waroE
         JZlBeRVPl8sf6Yw2WbnhkouMyJS00cvCHJQm1GkKkMB6PA0xxuGVEo7/C/QiFxrlDs6m
         jBew==
X-Forwarded-Encrypted: i=1; AJvYcCXXBM9QHL1vidgK3so3HKb41uWJFBk/irURjRhXVjHHfglmoaYHUsUfLg4VasgSHEl92jliccIqo78T+Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCNWxueYCFa0IooRTFd4eTTBrMR25UilgEcRg3I3G7QUpr64l
	75hkpKnLezJ2kaSJFMzHnoTyKS4ZgMWOME1CmuQcWyEsOXmkyLi1tEZtDyCzNC4awnF0zKU2dDQ
	=
X-Google-Smtp-Source: AGHT+IEtD0VBy/NWFnkwwr5Y5YG5VNEguytnHTmzwg5Js2LTz7iAVpGxq83k2DwNp230W7YGbuy+hA==
X-Received: by 2002:a05:6902:1a44:b0:e1c:a898:af6f with SMTP id 3f1490d57ef6-e1ca898b166mr12172987276.2.1725486706903;
        Wed, 04 Sep 2024 14:51:46 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d06fc8bf1sm658864276.40.2024.09.04.14.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:46 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso147529276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIeHa+KLpjcI0vDiYFLHZ3ebh9O2RdvDEEx43yO/sd8pR4tbm5AzDnVzSmketyKPc3XPmhzu62B1Q4e60=@vger.kernel.org
X-Received: by 2002:a05:6902:1886:b0:e1b:27d7:76c4 with SMTP id
 3f1490d57ef6-e1b27d77c64mr13543115276.30.1725486703973; Wed, 04 Sep 2024
 14:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-9-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-9-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGbjWXB95Rk5Np7Fp6sN+_AySVw0WtdNXE9xURxdVU5A@mail.gmail.com>
Message-ID: <CAD=FV=WGbjWXB95Rk5Np7Fp6sN+_AySVw0WtdNXE9xURxdVU5A@mail.gmail.com>
Subject: Re: [PATCH 8/8] serial: qcom-geni: fix polled console corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The polled UART operations are used by the kernel debugger (KDB, KGDB),
> which can interrupt the kernel at any point in time. The current
> Qualcomm GENI implementation does not really work when there is on-going
> serial output as it inadvertently "hijacks" the current tx command,
> which can result in both the initial debugger output being corrupted as
> well as the corruption of any on-going serial output (up to 4k
> characters) when execution resumes:
>
> 0190: abcdefghijklmnopqrstuvwxyz0123456789 0190: abcdefghijklmnopqrstuvwx=
yz0123456789
> 0191: abcdefghijklmnop[   50.825552] sysrq: DEBUG
> qrstuvwxyz0123456789 0191: abcdefghijklmnopqrstuvwxyz0123456789
> Entering kdb (current=3D0xffff53510b4cd280, pid 640) on processor 2 due t=
o Keyboard Entry
> [2]kdb> go
> omlji3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t72r2rp
> o9n976k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawavu:t7t8s8s8r2r2q0q0p
> o9n9n8ml6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav v u:u:t9t0s4s4rq0p
> o9n9n8m8m7l7l6k6k5j5j40q0p                                              p=
 o
> o9n9n8m8m7l7l6k6k5j5j4i4i3h3h2g2g1f1f0e0ezdzdycycxbxbwawav :t8t9s4s4r4r4q=
0q0p
>
> Fix this by making sure that the polled output implementation waits for
> the tx fifo to drain before cancelling any on-going longer transfers. As
> the polled code cannot take any locks, leave the state variables as they
> are and instead make sure that the interrupt handler always starts a new
> tx command when there is data in the write buffer.
>
> Since the debugger can interrupt the interrupt handler when it is
> writing data to the tx fifo, it is currently not possible to fully
> prevent losing up to 64 bytes of tty output on resume.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

