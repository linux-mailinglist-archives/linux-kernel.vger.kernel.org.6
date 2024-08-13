Return-Path: <linux-kernel+bounces-285264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C726C950B62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8DE28209C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906A1A2C12;
	Tue, 13 Aug 2024 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTuhrTWL"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2531A08D1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569993; cv=none; b=SbmWyJ4cwfyi0yLd1zlD0art2oNyFuX2ZLyf2sSlO4A2padHdsYamzxAo2OmUHf6R5MJrh3vCQeniHWKhmEZhE+DLA6tapxFVfRbFsCaUTWXDkm0hc1K2rmBFdeiH/JK83Dx6opvz5yn3xZu2alwhHfq2A6hlFsu6JTEedm81xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569993; c=relaxed/simple;
	bh=g5luCYPRUnOaUTfxUADhYc+LBS38OEZ8tTN4hBNkyGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/EWu0KNyOxhaPnb+tjSJ5VObmSegbKUpXKI8E15hL6XvzSSwaGg/LtNr0lWoGelWCBabDQv2nk5Z4bnBe+eCJnitHvZKE3tcTUptLlCRJidrCFEE5Su4nEjZYq2KLWWZCO07Q+YO08ETzcG1kNca3r4svqneewjUhQlpqmJqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VTuhrTWL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db1e4219f8so3248206b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723569989; x=1724174789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cL1n98BYjvpNXBfsENT7L2FFIE+k6G4EwDvpPJWlOW4=;
        b=VTuhrTWL4E650nsOLQ0zA3gPpMl9ERZxKgDzD78KJvE4BCycWu85EQx7XViNID2CSR
         vQ8L6svdZcJEt8rKcHuhDQdo2njnt/7GLMMpQHe1voKHv079DDHB6SWCVmmpl4grEPPJ
         ejlyBWzvqnPPUWXBizkdWdGtVlnScAj1N9vDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569989; x=1724174789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL1n98BYjvpNXBfsENT7L2FFIE+k6G4EwDvpPJWlOW4=;
        b=Y93Id2Wyr/FZ39FGotUetPYL+z8DSzqZxemwmBEgP0xgtVLkZ4s+UvlW9nvMEacRE9
         Bnkx+YUbu2wNwxMvZc5cSHCWUyJDyEGkm6y1tK7pG3gR7OzDnry9LlcnDFOUzAhNJ/WC
         znma43DX2S+qv5z0OIuFoE8zWgF8rQEssJ5rxT/mnaBBw7/S213Cqv42B+KDcSo4Lx/Y
         9G1NsyhGI6uITAG4hgP5p5oeTgzvY2k7XI/pAWLnFrZv4/J6UsgENSqeAPqAT7F9adlk
         r/OTfhBPTxIygg6Pdb71EY9rteqTMxLs8oqVpLYl/0wW5DcV/dMA8NlKRVVLVlxFzEsv
         TocQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKK1p4HcehLRRxd1UIwv7CBSn53QqFTnnIFcq4GVjutaSF3LpQgUgaC0GX1+i40Mk10+VSIydJfzwZdqz4nxkL749V5lDyX86T93g
X-Gm-Message-State: AOJu0Yz0+RA6cdqBZhGnn4hjEVhGn1WhFchVwcW3Wv/31jfOG5e93lNf
	k17lLdn2RLhs4tKf6KmElvHPrc3t9bKc0egWnkt/CBzaztsbWtU+t5v8nlQTLwa20m8wAG87pVE
	=
X-Google-Smtp-Source: AGHT+IFCzRt82TD2rIETpVTEkK+/sLOQk84/PJV8rT50fEzBNLRRCy0mGNMmoISt9beAa8aaFTU0MQ==
X-Received: by 2002:a05:6808:1591:b0:3d9:e090:5e1e with SMTP id 5614622812f47-3dd298d6b03mr169146b6e.7.1723569989063;
        Tue, 13 Aug 2024 10:26:29 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd0606aa83sm1743002b6e.6.2024.08.13.10.26.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 10:26:28 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5cdf7edddc5so3076462eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:26:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnCNrv+blobTrcRbtb4Jdbzldz0XcXvo4eAY6U2zAVcgiKlYNsYKM5t1Vk7/qwYS1pGEejjtt1OB8sBrSxfiZ6dlkBBeun30nTKCAj
X-Received: by 2002:a05:6358:989d:b0:1b1:a8fb:4600 with SMTP id
 e5c5f4694b2df-1b1aac4890bmr14711955d.19.1723569987284; Tue, 13 Aug 2024
 10:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813133612.49095-1-charles.goodix@gmail.com> <20240813133612.49095-2-charles.goodix@gmail.com>
In-Reply-To: <20240813133612.49095-2-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 10:26:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7rqE+sSbspo6b0un=FbBcxgS24sKLUZ+NTkOdveJObg@mail.gmail.com>
Message-ID: <CAD=FV=W7rqE+sSbspo6b0un=FbBcxgS24sKLUZ+NTkOdveJObg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] HID: hid-goodix: Add Goodix HID-over-SPI driver
To: Charles Wang <charles.goodix@gmail.com>, dmitry.torokhov@gmail.com
Cc: dan.carpenter@linaro.org, conor@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	hbarnor@chromium.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 6:37=E2=80=AFAM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> This patch introduces a new driver to support the Goodix GT7986U
> touch controller. This device is not compatible with Microsoft's
> HID-over-SPI protocol and therefore needs to implement its own
> flavor. The data reported is packaged according to the HID
> protocol but uses SPI for communication to improve speed. This
> enables the device to transmit not only coordinate data but also
> corresponding raw data that can be accessed by user-space programs
> through the hidraw interface. The raw data can be utilized for
> functions like palm rejection, thereby improving the touch experience.
>
> Key features:
> - Device connection confirmation and initialization
> - IRQ-based event reporting to the input subsystem
> - Support for HIDRAW operations (GET_REPORT and SET_REPORT)
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
>  drivers/hid/Kconfig          |   6 +
>  drivers/hid/Makefile         |   1 +
>  drivers/hid/hid-goodix-spi.c | 810 +++++++++++++++++++++++++++++++++++
>  3 files changed, 817 insertions(+)
>  create mode 100644 drivers/hid/hid-goodix-spi.c

As a point of reference, in v5 Dmitry gave you his "Reviewed-by" tag
[1] despite having some nits. It's usually expected that you could fix
the nits and carry the Reviewed-by tag on the next version unless you
did something other than what was requested in review feedback.

[1] https://lore.kernel.org/all/ZoW4_hctu_cSiKA5@google.com/

