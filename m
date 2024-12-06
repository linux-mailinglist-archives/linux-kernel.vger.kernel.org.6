Return-Path: <linux-kernel+bounces-434105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DA9E61B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB29282F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6215D1;
	Fri,  6 Dec 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lb/I9MEc"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB681E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443590; cv=none; b=DsfTBb1TyT1YM8qHQ4OPg2gOB8fljO1Dnw227+WLKvKF/Y4xeqOXzJiWF/Ag2QiIlQ3aGNiA8gHDv2S4AAtIXxexd0YXvivuyAgUIhXXPMGiCGNPY1oAT9VOWM5yuhfepMgE5N9nhmeuGGdbV6yYSz45o37BDShHLdAjkHX8ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443590; c=relaxed/simple;
	bh=VhLlXBiezqna92814Wec6SiZX9+6s9NKhyd+wzaZ6D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw4mfH92ZF7gMYcl6X2ch0OCsGZIYzxTmovyjEUB3E4J+ef8/ELeB/x4e6Vuodn+Livg8n2iXrAlUeCIS+na75EMBHTzPSeUW2hJKUZlreHnOLkCrz/VPNNE2FHdROzXNxobKIjgwUqupBckdPUaPVTBHUBvL38gxPFOVDpbRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lb/I9MEc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so1810076e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443587; x=1734048387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UvGh6EOnV+tEG2ZRwFyVPJh9DPbnKKWL/LvEAvRqYI=;
        b=Lb/I9MEcLIkKIYRgOGfwd8nhCquDRbPrJqh3+tMk2OGujGeFeQEBiFeKKT7maMFU2Y
         n1jipi4s3QTWiuizAHuSfeGsiXHovZMoqmuzvgLHRYjBWTHIKMGRGymkWV8SYzFeDEa8
         ZRWC+FaismYkaAgK3KtGKta8eUgx2Ke7XsGcd3sqTEtX6bozhwJEpMs8ixur3p99Lbj0
         9SrlKWBQRcxFcY4cXDRLReXfbYRj++dFOxupD9Z+eIbkNuyc8Ksi1L0EaWMhlH9fvi9u
         Jppf1lUjbYRHlwIwAGGi3RO9eYVaPJuM831Ac+5QkTfe/4lfObxC2ynI0pV/Sj+Ne2s0
         xPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443587; x=1734048387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UvGh6EOnV+tEG2ZRwFyVPJh9DPbnKKWL/LvEAvRqYI=;
        b=iq7oc7IYFlzyrV+1y0nquz+/nQnC0TsafI4fN4eIg1kP2CFD7vN7Ddqbls8gZPM8Oe
         V14F9sjB3XcbV+wv1lCiP3/T6CpW7W0YTvIMSmmASomscue3LPVJJ6tO/g6AYS4ZRTss
         YZ9oWl0i9+msN7eGQhC3QEov9xSBPsPR02qJTuQGtMEl3iDb4EFnRLU89FBvdO3+BNJ5
         sGaR/pj7pzjc0fY+WZqZYwpGIBW8ShMd30/9suU9OCFhPX+OloBtJoIW1spszGhk75/M
         ehZCyLnnb48hBgFqh9Y7Y+FFm9KMTfM9n8DDWScpgZfQsWMgQePt2TrloyIZYcipC/gm
         FFMw==
X-Gm-Message-State: AOJu0YxeJM8sZg48KGeodEZcog5IX2KddvuLDklVpgSDZeAjABuymQzJ
	kR6cMY+8vU1wvHNuNX4qSofbZoubD6oSTR/8VpHuxxVtGCfdh81QnmxwfHf6bSx4FFPxe+krTnE
	f0q6a+7lHV/vUokzHE6W9jAUUf8ZlCqQBiZXT
X-Gm-Gg: ASbGncv0/DZEmQKpzA5LDgIulpX6IURS5NqZpO36fVh8CU41W3Bhpnd3aWKDJkfXBR8
	zRF+sfqqv6eNAcTternKDl1BWClQBdQ==
X-Google-Smtp-Source: AGHT+IHX5x8YT8vafN6ekk1TbVsmb+8aDHy7nFhJeilXsENAEenxd424hEKN6feA90avQyEUsRnxLsZ3M/AV3xsrUVg=
X-Received: by 2002:a05:6512:3c8a:b0:53d:dd4c:aeaa with SMTP id
 2adb3069b0e04-53e2c2b1ad9mr224016e87.9.1733443586479; Thu, 05 Dec 2024
 16:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221726.2247988-1-sashal@kernel.org> <20241204221726.2247988-9-sashal@kernel.org>
In-Reply-To: <20241204221726.2247988-9-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:05:49 -0800
Message-ID: <CAGETcx9V_pWmgpX+HXC7tEQm4L1Fm6yghaXjJba4S-Y00um_=w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 09/15] phy: tegra: xusb: Set fwnode for xusb
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

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index cfdb54b6070a4..0a2096085971c 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -543,7 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

