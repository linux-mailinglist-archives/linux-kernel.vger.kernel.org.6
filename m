Return-Path: <linux-kernel+bounces-259327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4E939442
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5A4282295
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D0171646;
	Mon, 22 Jul 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4Xqa2l/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C216EBE8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676673; cv=none; b=fNSBHQHOvP88eotahZN7dJ5cEBkyb4+VVDpbdOe4sSzMODL4sUSDN+/fr9mLtQWRZT93RCSUNZhpk5POKUpjsBrRCtTMfHE3jNYMa9TzXdJRtjOCRc6SjYVI5ErOxitcVF3hOhNZ77SmE0wZahgdHdcPSqWUykz3cyWD5Sh1ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676673; c=relaxed/simple;
	bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUm1s/CEDhOLnL6SznR7OgTvGFGmcU1AYBdMvfosUoi6qX+rO9BGqlNN2Tuaf4/OawpFrosbeytDAy0qGy0bRWfbzNbHdse1AOGP9o+RknmLNGGuOldMmKu1zIQJJJKqjSWG8HDwqP81WH4yAL7MIheK8BZ6MGWgvlJq/ZhN6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b4Xqa2l/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso3886169a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721676670; x=1722281470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
        b=b4Xqa2l/zPH3cedO2+D3tY3R/vRW6UpRiv+8EfQyGXclFNbxtKNMFKhkGOPIbRLiwD
         mqdnMT5GaoVXfhCMybyh29FZkyfejdxtn9WLKQroJjq2z6JVO+Rfaqd0bE6B8wbhADyG
         XA7Tzs0o/lRidJqGvBQKF/XQnVO9NdmakaQfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676670; x=1722281470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
        b=sOf2BgnK8NgswGwxuMq1d79J5Uv2s1Oz0EH1JN7lFGIJPOmvZyIhrIVw+QpUgObgpJ
         BouB5FMy/skXDRhit5RiY0IPcVTZqdnWQHWcEP6Y3WJMN+9CTu7v9MWQAPz2XixqQL1I
         xsOQf0MVXEhfHjF+SEcb4IKaLQPgsP8U1Zd4NJm8Wy6bRZUVgoN1SGgmtW1RVmadMwhj
         9fGV5baPiXNbpx8tHDessWn+veE4eoSeSxi9dfW4LZbMYodluQ1rawrLQjmGEyahXP73
         WdPWm20zMOyAU5Vvw4c6bpbFQot65UijuoTJ2xy9h47+qzLaqeRWVCoK9guhSKWFk8Ve
         nN9g==
X-Forwarded-Encrypted: i=1; AJvYcCVatYpffb/GPX3GpevNDKA6taNLoJEKrBbLlIsbJ0J1iq+PpVLJ+Vdq44w5kjc2LkzsXHFVmNKxLf/6cJm1J8gGJEoyol+6ZeKoMJsa
X-Gm-Message-State: AOJu0YyVk27F9waJqRvZhA0Gft6et6vxI0bf7fJPnjI62BKSB5MqRL9N
	D6vyboYYYRWr2J2HlBwFGhob8tFvprjC2RIJkWZtIffmbFvnbqvd7EXPDYeui7lY/U51U7ybWJg
	=
X-Google-Smtp-Source: AGHT+IH/xal3n/v3jVoNIxAtqnW/q5qcrXP0KQd4K7a/PP1kFRCxpnzGneTSl/fpcGbgil65XdDutA==
X-Received: by 2002:a05:6402:528c:b0:57d:3df:f882 with SMTP id 4fb4d7f45d1cf-5a47987a170mr4624409a12.7.1721676669481;
        Mon, 22 Jul 2024 12:31:09 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c9c3a1asm6469281a12.94.2024.07.22.12.31.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 12:31:08 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso449998166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:31:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7Wu3BhlxCobxN2Vh9Se/EmvtLPrLYAbIG8OvLH4nemduiznSqCxMDyZR4cTexBmQKfQ6Lu//E65JKb5yi8/PDtllAI6IxxTJvE9w2
X-Received: by 2002:a17:907:968e:b0:a75:360a:6cb0 with SMTP id
 a640c23a62f3a-a7a4c010857mr549203766b.29.1721676668187; Mon, 22 Jul 2024
 12:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com> <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com> <Zp4O68Y6oss_pwMm@pengutronix.de> <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 22 Jul 2024 12:30:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
Message-ID: <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Sascha,

On Mon, Jul 22, 2024 at 1:46=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Sascha Hauer <s.hauer@pengutronix.de>

> > Thinking about this again we really do need to use '|=3D' and not '=3D'
> > to make the result independent of the ordering of the AKM suites array =
entries.
> >
>
> Yes, for our private driver. It uses '|=3D" and can work for firmware of =
IW416 and IW61x.
> For nxpwifi, it will follow mwifiex first and will be updated to use "|=
=3D" later.

Thanks for the reply, David. Treating this as a bitfield sounds good
to me, then.

> > > That would make sense to me, but I think that's in conflict with what
> > > David Lin said here:
...
> > > "Firmware can only support one of WLAN_AKM_SUITE_8021X,
> > > WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."
> >
> > I don't really know how this sentence was meant. It clearly works when =
both
> > WLAN_AKM_SUITE_PSK and WLAN_AKM_SUITE_SAE are advertised. Of course
> > in the only one of both is selected by the station.

Yeah, I was a little confused too. I don't have many AP systems to
test though -- all my use cases are STA.

> Mwifiex supports a lot of legacy devices, I don't know if modifications o=
f the coding
> for the data of TLV_TYPE_UAP_AKMP will affect existed devices or not. May=
be you
> can follow the patch for host mlme to add a flag like ''host_mlme_enabled=
'' to enable
> this kind of change for specific device.

I don't love adding new flags for small changes just out of extreme
caution. If we find a good reason to, that's an option, but in this
case, it feels like the behavior is poorly defined and possibly
inconsistent or broken with the current code. Specifically, if anyone
was specifying PSK+EAP from user space, we didn't really guarantee
behavior. If users were really using that previously and are broken by
such a change ... well, we can figure out a way forward by introducing
such a flag.

Brian

