Return-Path: <linux-kernel+bounces-434098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BE9E619C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C51885467
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB47464;
	Fri,  6 Dec 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq2JbUK6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD08831
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443476; cv=none; b=WUAW3UoKv5Qv7nQgi9ity2H8xCmkv7rav7l9H+4mCIYrx6OAxEtuI2U25cfR8hux5Nnv2vpiWi1h8E9b3rss1ZIQE/ml/DaQ0ZO09M6yzoiOsn4MqT4y7pNy0tErV2Cak810lVeP0HMLWDa06G5pfGUXxzgb/juK85VLd7OjC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443476; c=relaxed/simple;
	bh=tKUQOmQH04h1CVVIwdOHMWNVzndOvzHeIu10/JBL9VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz4gtFkyD1/JwusoPQ5AoLKSx+4rLjouZQhhFkYUC7BrfEqfjGe7VAcR0GRqLeq9M1fK7T2Ed0LZ4LN3gZEYDpbpaqJKQZHmemESmoWi1csdItSaIHfAanDdXLPS5Fz2jTIFxn6xVZ//XifjotIWRwaBXIOKffQcyVWWJGloE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pq2JbUK6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3001d009633so13744231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443471; x=1734048271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty80O3zcP5sqKHxyN7Pa4PvEryupRsClSqgrQkC4hu4=;
        b=Pq2JbUK63RS4AUxEkCGO5zUjJz+/kwEmLVbWM3vBAGFHSaf7n5jzS5Oyw5HR6dOIop
         YfAb1b8VuSQXdjpAMIXos3ubmaACbfIYk+qT1JyCD3ugnI1ttYgKUBu215if3FJ0nrYr
         DL2CkdAhzp35KbSc8h9BZWasa2pivj4m4guV2S9odDh4XXzt7RRGvIgkiNVojXICoGyg
         w4Bsc5hxT/r4WxfRKLS9lyEZzTvKpU2m4/63NqqGZMOYz6etEr8gikwLD7SC+08lt6OZ
         CrknbJ4N7LNpWr4LRufSUhgkIfVVBZC3OEGrbn4PlkXkk4Yle5VckdQH2LFRAsGUCmoc
         P0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443471; x=1734048271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty80O3zcP5sqKHxyN7Pa4PvEryupRsClSqgrQkC4hu4=;
        b=ca4KbxROdYI+5DC+XRgmJmEQIR3xLaCZUJVBz1XVKtC0qy+6SQT4cTe2Jx66O+zV6U
         JduEK8rq+uqJdv22YL7dz9iobnnQCvIuBYDVYX57I86sWGPkwk2MenU9D8xok9s8VCR4
         C4W0rn/xFn1RJqdn7+fVfe5hJQ1LHvciaPQNtatD6sPnRRyTYVzHXivkny6zKaLFlXk6
         Dhr6T8DTC7ZFdO1OIWYW2sZyqV1f+08ioU0YFE+bQnR5NDZG0wCAksWcBD1fHmzixI3r
         w4HiKdl0iL19/cquRMviCkC/Wm3o3RgK5rrYyevWfO6hTR+jct1kkW/ftguXCXiRt0bX
         wD3g==
X-Gm-Message-State: AOJu0Ywtr+ba+Z0ejdL17MkPnAq8iAY0xGpzMZWa4p+wXHAy1luHAtco
	EZEb8hGP0tH1k6OZITMiW//SObYjlxJJekdsFS3zqaLn2GmIdRWuqGgTwBTwQkZycHu629NodKJ
	lNVWyC0rd7Zvvg26Ti53RHgOKdKXlT+H+tn2+
X-Gm-Gg: ASbGncux2CHte69XsCCzicPBgzMnUwXBOKFy8KqZni99eLiZnTaYthD0Ixb05KMqY49
	jsGg8Xhoq67o64bOgfQ3IioTER/OBAQ==
X-Google-Smtp-Source: AGHT+IGWlM9OGtzjiB62Nm+XCJYbKxMdPKE02xF2kQ3bH+accJLYiyUrOBBi3t31hrUdhGH+VBOyjbTNxtoBv97yijw=
X-Received: by 2002:a2e:a10e:0:b0:2ff:cb09:ccbb with SMTP id
 38308e7fff4ca-3002f8c3e24mr2056461fa.10.1733443471249; Thu, 05 Dec 2024
 16:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221956.2249103-1-sashal@kernel.org> <20241204221956.2249103-2-sashal@kernel.org>
In-Reply-To: <20241204221956.2249103-2-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:03:54 -0800
Message-ID: <CAGETcx-qHfLBCfoPX4sbysbMnObvLK_b4rNeJuPySfc8Gb8GEw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 2/3] phy: tegra: xusb: Set fwnode for xusb
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

On Wed, Dec 4, 2024 at 3:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index efe7abf459fda..7cf2698791a0f 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -521,7 +521,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

