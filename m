Return-Path: <linux-kernel+bounces-434100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044949E61A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D43188541D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F710E6;
	Fri,  6 Dec 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FR8GrlTK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED13FE4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443509; cv=none; b=cKzKWnGms/to9b+wlqnRI4AxRZM2rRzjWMdR21I398iWnxXLTaov0FGzjpyYh6bO/vLje+fK7109hMLwkBjqB8s1fRICvq7fLcX2fd2pOMsHzTxIFOI8Yd0IYNAQ0LqTgomlcf9QQsHYCR3N5FSMb+NgPqdKe3lDfNcGPYoKq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443509; c=relaxed/simple;
	bh=BwcwkBmpq9qoP9KdrIaMsk9b+cc/VqljtaRzLZNq7Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwV7VWZjMsq7Vs37ErK3CQ8WK5cy0wWIVF2q9m47bMBDGjSJYxa384xESCQth+hWVKDoRnLDkcdDuKKEXbuINN7MmrdwXHMtEBdLS4qR4D//voQ0V1JCPOgFL3b6I5Z/fPXhcyByNh4EraPsidcyGCCJBmYbY53d2HsDz3so1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FR8GrlTK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de79c2be4so1624233e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443506; x=1734048306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mffP7SIqpVqHwqmdEnMFI8Mhd4D6LAYDdX9afu8rwI=;
        b=FR8GrlTKu6Ridt8xIB0szGVtwvS5bYx1wG48fVYFMsI5R28opspFztAyyOkq6rM0Au
         2acEnLqbuT+SIbK15earmzPoShhHOSw3/bM+hWS2a1/zs6js430MM/On5ebsVpwSRozP
         +PU3uOpjK4BWfcMvI1daLUktuGLpgAvLFCh6xDOko/wQFom4bvFUAzKJCPF+Vtt+RErm
         QCkOp8h6mBmPGBfZIDSjcRpIjX1AvZqNiQrULo9GQlb+/HrwtUy1WyrpOcwmWoWlKVRJ
         HhONafIuMLkLcAHitTAhwzA+E03ZB+O17jYI98NPbgMrQ6BRHmFeIGTdYmHYTRpy9Oo1
         02Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443506; x=1734048306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mffP7SIqpVqHwqmdEnMFI8Mhd4D6LAYDdX9afu8rwI=;
        b=veFwP7mIg7KN8OPDHXm0gCgNI1vCeBrbVEzMyTv6CXGTEJJJhyhN9iGcMDA+QDcLGX
         i/spMT8ksgQX9rZuzRy5oZ9pszgB1aZGSJgYRJRTfZSK3PIZosI/WcYffGfa117i0Tgj
         XQsUomiAbxqXYeakaJogjR6FlqR/nviFBQ1Iws89C8f8BNUEHb5DvNXGdKd+Ur/1xJRn
         /oVSp9KehYyhHBMBa4rwPEw1U3k2oaXZFQBuNbcIrnjX3vrxYunKEdSbwmm8GlxcB19E
         NiciAqtFJGkyjg3n7nZTA7nhawO4aRUP4thRz6ciLopy3uk8oMZLnAaIjkIgfKm9XlEq
         tjiQ==
X-Gm-Message-State: AOJu0YzSKhsqaDWSH52eUlsejf8IUJy8GlekvsvxvNcxGiB+oiUkxFff
	KCLy3L6MdzB3UdEfWfmUm5oaAjLPOWYl244VeHjVf3MjSFcuv4YClg0gzozd9skV76Cx0vS1QG6
	8JYHca87l6S2bs33u2xNifgPXVXdIQLyZIFqb
X-Gm-Gg: ASbGncsSp+6O2QAhYrYeGXYnKWNps60TzX4kdqPjldrP1pZbaPwDvdclLC9aQ+8sRv7
	6au9lPIocfm8NxT0jwc6jrSENwd0DtA==
X-Google-Smtp-Source: AGHT+IEphwAKG+akjlfTDJM0cFC6ySOTXKmmpvLObu98Xq16kqT8AeY48zqrBxP7D7gn8VnXD7qHI6i/RHkPxXyECew=
X-Received: by 2002:a05:6512:1cb:b0:53e:3103:b967 with SMTP id
 2adb3069b0e04-53e3103ba29mr28490e87.35.1733443505497; Thu, 05 Dec 2024
 16:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221925.2248843-1-sashal@kernel.org> <20241204221925.2248843-3-sashal@kernel.org>
In-Reply-To: <20241204221925.2248843-3-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:29 -0800
Message-ID: <CAGETcx82VRmbU-UJ3iQxipCWncJPB_N9rO702K5AoVitpLNo9g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 3/5] phy: tegra: xusb: Set fwnode for xusb
 port devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jon Hunter <jonathanh@nvidia.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Thierry Reding <treding@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jckuo@nvidia.com, 
	vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:30=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit 74ffe43bad3af3e2a786ca017c205555ba87ebad ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) wi=
th 1-0008
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvid=
ia.com/
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Suggested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-3-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/phy/tegra/xusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index bf7706bf101a6..9a204f78f55db 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -537,7 +537,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>
>         device_initialize(&port->dev);
>         port->dev.type =3D &tegra_xusb_port_type;
> -       port->dev.of_node =3D of_node_get(np);
> +       device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
>         port->dev.parent =3D padctl->dev;
>
>         err =3D dev_set_name(&port->dev, "%s-%u", name, index);
> --
> 2.43.0
>

