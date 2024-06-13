Return-Path: <linux-kernel+bounces-212495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B519061C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087401C215AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD776839EA;
	Thu, 13 Jun 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f37yKs3d"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916B5C5F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245687; cv=none; b=S2I0NIGV9GiW9+wFI338TptGwInBWXVs0tGWkg+SR3PsEiKJs/og5HYsYRweMVJZE8iQFjYYYSFpwY4iET8ykiSE0RvT5bnEDClToL1kKc9INvaSINrCJRU/vHE4XLB6m0Evrah1YogOBEr2jfocQwVFLjXniRj/CIbJgJ3BpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245687; c=relaxed/simple;
	bh=wQjkzUNkQvO1QQTmzJdFmOhe3eLsPajk6NuewFDYhho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me1TYDwfsBByGN8KYr3HLNV77qINsrmYuuBMl5NAON7r7l/wJco1A+KoxJxe7UNsiGlj3P+kqABIsC+Q+KR/J4QvVH+R7FUITBV3EEQPMkfQfMehEqZUIsINKlvPRkWcVjDqOObm/h3IG7XjsMS7VcEtF0/st9apdMgcJzXZWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f37yKs3d; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295eb47b48so642268e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718245682; x=1718850482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqJHo/nm4dwxUT1vSJWjZGt/TMqLX57toHgV/NshWrQ=;
        b=f37yKs3dt4fnBxljKLCDr4a0BTa5Ia63EuIZlmUwoxsvUYhjYICzT11NIXBEBigtJY
         8h5m5vcYBnpIq4pk9rSB296kWwOpcjwLhIPViqZV+o1oy39dJKeDF48vH9Hwnm41yXZj
         xlhoNxqMToaQHYi9Tf8vvRby/xhWKbGQ6L6BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245682; x=1718850482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqJHo/nm4dwxUT1vSJWjZGt/TMqLX57toHgV/NshWrQ=;
        b=MP9Sk4iqZJt1oLWmvqgsEXGVMole244O7g/8BDExLcjE2h6g7d9q15vQvhOR0IcFNt
         oS1W55ZCPa5ImOuPKzjazjAq5N4PD+c/Ywa3RFO8hCPIXGpa/cs0LouVT2QmANUYDCnP
         oyoqPCpPlHYiU6Q6faaZiyH9bxRaS+hC8YDOQ0niCo5G+oI2YuE93cWcXUX4grYno+R2
         9CYMehelnSOpQxizHHzqgoYZ4lb+5taNOLpbgzDyXEghGqD3Y72+y9cqqxmtNUBYgvsT
         c4Sy5rW2OZHTtVX1ys/DLg18KtUbXz8XHv+dsblMHj75RMZfoTw6OBdvqPO0clOU9Oo7
         BeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwYEgXJgAhsKOwTZX/SKkhHipY1VVwjZA+5ae/v3km+upGUL+JQPiIa/jH+D82s6A47HcqgDeLceXmIGSrQ5S60WSgHWfnbqV1t9li
X-Gm-Message-State: AOJu0YyrKch/aCk/B7vRZlStTELNqyCUHaFXTrF+PjIjHrcC0C+H4l7F
	rpULZi4pwc2A4RC5YJy1AHtYrk0s4i0/WAx9w6o1ySXH0wFtiMdi4jeQluPsb0JPQzfLlCazC3O
	9gg==
X-Google-Smtp-Source: AGHT+IFNRa91iNEAc2f1+QThEawvGl68lPBpqn/LGT4v1PE5LhZN5DGmgNj9wplttRuqSUxRXNU+Hg==
X-Received: by 2002:a05:6512:2fa:b0:52b:c339:44f4 with SMTP id 2adb3069b0e04-52c9a3c7419mr1982643e87.21.1718245682403;
        Wed, 12 Jun 2024 19:28:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28720acsm51070e87.146.2024.06.12.19.28.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:28:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso720683e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:28:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTr64v9K6JaxTGoUYY5bq2ui7DXIxHnUl1izIYV6KJ3b/+aploNoE2XpFqwkffFADJhnrTrVCOIaF5aKoxFFP4HCh+Sbcyx/3RXQCB
X-Received: by 2002:ac2:418a:0:b0:52b:c147:ea38 with SMTP id
 2adb3069b0e04-52c9a405960mr1780155e87.68.1718245681292; Wed, 12 Jun 2024
 19:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-md-drivers-media-common-videobuf2-v1-1-4625ab172fd9@quicinc.com>
In-Reply-To: <20240612-md-drivers-media-common-videobuf2-v1-1-4625ab172fd9@quicinc.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 13 Jun 2024 11:27:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bdh6Lsje-71_HDK9T141jMNeNh1v400ukUVn1L5WO-kA@mail.gmail.com>
Message-ID: <CAAFQd5Bdh6Lsje-71_HDK9T141jMNeNh1v400ukUVn1L5WO-kA@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, Jun 12, 2024 at 11:46=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
> With ARCH=3Dx86, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/common/vi=
deobuf2/videobuf2-dvb.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> While doing these cleanups, in most cases I've taken the descriptions
> directly from code comments, Kconfig descriptions, or git logs, but in
> this case I didn't see a nice concise description so I invented this
> one. Please suggest a replacement if this isn't an appropriate
> description.
> ---
>  drivers/media/common/videobuf2/videobuf2-dvb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dvb.c b/drivers/med=
ia/common/videobuf2/videobuf2-dvb.c
> index 8c15bcd07eef..6f6650183184 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dvb.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dvb.c
> @@ -19,6 +19,7 @@
>  /* ------------------------------------------------------------------ */
>
>  MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
> +MODULE_DESCRIPTION("Simple DVB helper framework for videobuf2");

Thanks for the patch!

Looking at the header at the top of the file:

 * some helper function for simple DVB cards which simply DMA the
 * complete transport stream and let the computer sort everything else
 * (i.e. we are using the software demux, ...).  Also uses vb2
 * to manage DMA buffers.

I think I'd call it "Videobuf2 helpers library for simple DVB cards".
But maybe we could have some DVB expert comment on this. :)

Regardless of whether the description stays or changes, feel free to add

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

