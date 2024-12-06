Return-Path: <linux-kernel+bounces-434095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA29E6194
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E52D168403
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700D81E;
	Fri,  6 Dec 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2I1aQnU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27EA23
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443458; cv=none; b=Nwwa73eu0rzuP03xxnoJZj2n0JqZxkJtSknzS0iOxE4giKpKSuGIRzSDwPDV5re+5R5S0F+qD+dtDcs4vsmtHMUHhglrYzo8ZBlufDc5fxoQG5s5nd81mqhTJKA0gLxPVuCrT0AsI1Buy1YNZ98Q0xeZkyvCA/m+oC92cKXkadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443458; c=relaxed/simple;
	bh=cem6YOoyp7AZDcfsQKGmNgPJ/G6o5juYqAiM9Lb2GhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7x/lJ+QkCuMhBqD/pkpXpBAfTtUBPJ6gaMwTD4D6fEznLOPfL9geac2i9Ynoj8FJ0jZQkLDhzAOFfw11K0IaXm1AKun+yXEsJUTpXI+r4fRT8osPbmUwjx150Wl6zLlcJGs8foJ6t84ZIRwN4/aBXIZ8BIRaKJihVO/8wtw1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2I1aQnU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so1808700e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443455; x=1734048255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwj/agv7HQLTwHjDmPbArm4lVXi5bkqm0hUb9PKPpxk=;
        b=t2I1aQnUI87eUU2ZCbyFKnkIWrCJ34k7BlxsgU8fOSRY1pE8mD3pmN1TW50zdPoP2m
         oEQFL2SF3iqwYUahqh4UxFCM51G/XRFWkcFHrOlkoaiIpS//x49/Q0+55Kb5PmwnYHIg
         cuEE+GvJYrTkP/NrXIlAkfaYWPw9SvQ4EcCDn3U82iqeAvSc7kZZWVEBD1B7oXjXMi5y
         +5znvAM2CBzwUJLEMijJa0hd7H86lMpoPKVFBDtAnLp3uTNuM3y1sdXamLfxnpmJS2Yk
         QvmjdQw60wncqthBlszvuPpoIDz0/lkcvkZi9eGEVQkDzT5bW6I/veqB5zkLAQaCQq8x
         6bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443455; x=1734048255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwj/agv7HQLTwHjDmPbArm4lVXi5bkqm0hUb9PKPpxk=;
        b=Kecdrp8WNWHSOOFsPAS1ASCtv9wQQ0PjD+eghRevtSulx8o0OpvCu2EzWf1aqlEJjV
         q2bzkY/8VS6iy8G9DPZYL+xl/XdH/OefW4S36zNXMlVMadmmVmgRdtQO5bqWeoUDYbng
         jI+NSkyOMFAwgdmVXOO+weUvpB2GWlQNh3R5eBV9DIOqS0as2rmZREPLOw8XwTnm+pwR
         tyNLEQAXEwrxIiipyxbbD13xC3TpCPqAjyiLuvIbUQGF374zZg2XWXLPTLYiBOqeo5cn
         miqJnmdvcGy1nZhDIs8xG6GX0dbD0bw96ZPDgco0PcSgIfEw212RKc2S2HqAnhRoE8Uj
         z9NA==
X-Gm-Message-State: AOJu0YzNVeAiA7xuDi94LTtaBIV54g9p6lmh3Td/NnyY8EkkoIhUzmQq
	KqFzIRk70FHFuCjJDBGFd+k6u27NL4OmD+C88cxTy3Cw3qVpOVRTAk5NroxmRheU1RO+CCTg30H
	u8P2NMGAftjcYSHYQnbmd2Gn8LHhlkF74CnTc
X-Gm-Gg: ASbGncsJ5ndDX6agDQVaV+MUUz1ylj/R2uAxsk3ceu1EeUpLAySvRgQM0JArhDzbcSp
	eV7bIUtW4k/4wtaeR6lyE4aCmbW8uNw==
X-Google-Smtp-Source: AGHT+IGl2G+ZtrZsi0Il70DwFniDP6/Jpy6f/54NvatI53Q8jXo3yQ6cXcDsZ/Inpw7JimLVPKqN2Ay8N4V3sAFXdcc=
X-Received: by 2002:a05:6512:2316:b0:53e:1c46:e08d with SMTP id
 2adb3069b0e04-53e2c2b1a75mr166757e87.2.1733443455261; Thu, 05 Dec 2024
 16:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204222006.2249186-1-sashal@kernel.org> <20241204222006.2249186-2-sashal@kernel.org>
In-Reply-To: <20241204222006.2249186-2-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:03:38 -0800
Message-ID: <CAGETcx-a-+ktU8rzVwP_GN2pM8-_vaWd7OiqFJCwiNpyQMETpg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 2/3] phy: tegra: xusb: Set fwnode for xusb
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
> index 17211b31e1ed4..943dfff49592d 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -519,7 +519,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

