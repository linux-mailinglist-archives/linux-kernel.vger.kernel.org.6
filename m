Return-Path: <linux-kernel+bounces-564137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2ECA64E49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0177A7190
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06DC23770B;
	Mon, 17 Mar 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ND4sN0Kv"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FE238154
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213331; cv=none; b=oMqNyWizTRaAEReHS792w3ye4ZKeUaPKSXTJWYgyR3XmyIAjLXqTtn4YDKN3fbdqu6BqoZL9NRd6L6XXzyaIqeQeFLegzhsEoJQmFD+DZJPm+pwbTWEgTHKr5DYV4fHxMfp1Ll+yl8c5snngoys666ihrft8bFMyg3HoOoQ/Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213331; c=relaxed/simple;
	bh=9iXfixuSBDIc78RgUMbLHrK4yHUAjQR8XzDPw1h7zFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMH7O74OKkM2eRjNPklJ17IbomNtXtQVqhFXM5VbreMmKu5cxZpeLx3+i5qpqirb2Z8ERFXFyZ4V3DJbgyZQZLGtohgKSO81UbJgAK3O7U3JK3LAHZlBMwaZlAKxgiDzKnazrNUECUzrlcHd7YyLjDU5IQrCQ/K5AdVaZb8FvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ND4sN0Kv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54957f0c657so4485109e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742213327; x=1742818127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ODjBc7H+F36djhBChv/kX744H5zY7HbwroUiftCms=;
        b=ND4sN0KvKt2NO7Udv7yulD0U9AgN6fTlKE6En/a7iQaif0YTVlApTxTTzsI4K5SALc
         sz1xkLrhqh6F9TOhqXD5as5m3h0A7m42G2bqVY5vuMU9FltSJzCrpL/dLx/DYg9Ls1W4
         QCgkduJoH9RnmEZJKiDl6AfMiv6cKMr8D6/nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213327; x=1742818127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/ODjBc7H+F36djhBChv/kX744H5zY7HbwroUiftCms=;
        b=sUhHZ3YBZVK1H+HtVE7cf3yYiKBAHDOwYNrHyXYL+CID2WhKitdlirfeRxJz2ecD9/
         hzUksgpf3GQbbsFGenITHZincQw8+nFjQnwD6QiKCKPfE5zmDY06gTnH99vDg8qsKZbb
         Y3oMGqlBXIJQ0ixaUZwiTLMCpgpizwBp1tVhoAVzgrq5GKkkALyuLvmRd8SI7zoy34az
         x26i1S3QGe9VvZNFlnkciIcaLnb0bBXqWenZAPNUn+HhgqeYRIFA62ja56nvaLunERjw
         +AO75OsjKT7hBYG6y7uarsG5rz6S+Tj1+BfTUfNeFCZmTw+3/QlWo/CMrybSiv5ldtya
         H00g==
X-Forwarded-Encrypted: i=1; AJvYcCXC40ZZnBj87Zh3fGMHN5+zU60ZN11hnYV/fuEcKa+xGU4arGZ4GTsM7W5w6enWkpbatkzILQo+cwzuDxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJzSFwb0MPMsZBk4D+FHc+/YBmaQF86yd5N9db5wTJOpjaIxc
	3A7MBMGYBRiEjdVTP1gDdvHpErLbAQdvpTHie/C078OJTP8HClcUF/mbtvicNnWzrkdnssY1oDQ
	=
X-Gm-Gg: ASbGncvOW86iEuIYhgse/Ozag+2BUBB8IX3akxlx9np2PfN0a7c5FO+jpukz05nClFz
	vM9teZElq/pEKiRCy3tUNcwk/+kZXbK9cyaNyxPCQ4Qbqv6VsKxQw3eJZX11d0BEC8dWkkC5zYa
	corsFh2fIzsyVBIJ3PKsd3+sBLyIhNuxkxCyeQVEVvAUMo4poCOfZ4zQE9w+OFfu+1owh4fEL55
	QeE4jO5sbr5KzyP4Aq04Hb8AOkn80VzdYPlW/X4mVxuvi6vX/rOb86emaEugPIzkwRq3UbTqjsT
	cAgHUDlfe0xlLUjyzCnUP5voQXlu0ayJWC0IEk/H/DHCMzlJgKUvrWIK3yzp3yWL3FB+AcRz3LK
	R3tEKxH+LkZPLFvxClGrC8w==
X-Google-Smtp-Source: AGHT+IEkRCkvihwVwM9OOGzq4w18s0KCWhc+AWAqz3MmVu5NKJa8UIsYD0Z7DT+kw8yDv/r36NaFJg==
X-Received: by 2002:a05:6512:3c8a:b0:549:929c:e896 with SMTP id 2adb3069b0e04-549ba3ee5cdmr8391917e87.11.1742213326844;
        Mon, 17 Mar 2025 05:08:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bef04sm1306366e87.57.2025.03.17.05.08.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:08:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bee278c2aso56733151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6xrYZySgYybs/oW+i76XUwfNq2yodToF+1aTjULFwMqPeGG4TomFA/XjDXZmXBMeaFRrx03SScMJgPk4=@vger.kernel.org
X-Received: by 2002:a05:6512:6ca:b0:549:74a7:12ce with SMTP id
 2adb3069b0e04-549ba3ef133mr7614324e87.14.1742213325707; Mon, 17 Mar 2025
 05:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314213859.3543936-1-arnd@kernel.org>
In-Reply-To: <20250314213859.3543936-1-arnd@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 17 Mar 2025 13:08:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCuqdy2UrhZ8_erFO4kjXwt_bvQgmrqmPZmrw4xaRwJBrA@mail.gmail.com>
X-Gm-Features: AQ5f1JoUk-w0vqc9PkqG9r76DrJtcTvoYlEAHfsnxS0XUCOOMftIXJoRmJY_6vM
Message-ID: <CANiDSCuqdy2UrhZ8_erFO4kjXwt_bvQgmrqmPZmrw4xaRwJBrA@mail.gmail.com>
Subject: Re: [PATCH] media: vivid: fix FB dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Slawomir Rosek <srosek@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the patch!

Just out of curiosity, how did you found this? make randconfig?

Best regards!

On Fri, 14 Mar 2025 at 22:39, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> It's not enough to have a dependency on CONFIG_FB, as that can be in
> a loadable module when vivid itself is builtin:
>
> drivers/media/test-drivers/vivid/vivid-osd.o: in function `vivid_fb_init':
> vivid-osd.c:(.text+0xdc0): undefined reference to `fb_alloc_cmap'
> vivid-osd.c:(.text+0xe26): undefined reference to `register_framebuffer'
>
> Change the dependency to only allow configurations that can be built,
> but change the FB to FB_CORE so this is also possible when using
> DRM with FB compatibility rather than full fbdev.
>
> Fixes: 20889ddede38 ("media: vivid: Introduce VIDEO_VIVID_OSD")
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/test-drivers/vivid/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/test-drivers/vivid/Kconfig b/drivers/media/test-drivers/vivid/Kconfig
> index e95edc0f22bf..cc470070a7a5 100644
> --- a/drivers/media/test-drivers/vivid/Kconfig
> +++ b/drivers/media/test-drivers/vivid/Kconfig
> @@ -32,7 +32,8 @@ config VIDEO_VIVID_CEC
>
>  config VIDEO_VIVID_OSD
>         bool "Enable Framebuffer for testing Output Overlay"
> -       depends on VIDEO_VIVID && FB
> +       depends on VIDEO_VIVID && FB_CORE
> +       depends on VIDEO_VIVID=m || FB_CORE=y
>         default y
>         select FB_IOMEM_HELPERS
>         help
> --
> 2.39.5
>


-- 
Ricardo Ribalda

