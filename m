Return-Path: <linux-kernel+bounces-188959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C468CE8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8972A1F213E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FA12F376;
	Fri, 24 May 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4zlo4ui"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACB28DC1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570146; cv=none; b=ezR6jaA/0Znr+bmZLVeBAK2FtBpdJbDayaSbWZDjjX6C9GefONHTzYSk8CNSpIKaT4oT0DnkKZkusD6CbzeoRsKUBtLjcfT10rPe6vdNq/e+omn5jGK4LGdb4NCqA5LeZ99n3T/Sd6Z+LQa5og6WTKIUV7houvnwo7OMhIj541g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570146; c=relaxed/simple;
	bh=wqOOh/1pKHk21Rs8PmFaDPTbCwsmNAhdP7Z6CT4+k80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VedxpkBUiWqCa+VsyVnH9hNTZO16SdZnFLkGoHfpMkF3ALlqe/CH3gGaJv5sx0xGJ/C6ZpKa+Qswgp73XMu+6D59g0rPq+T4Rc+hNQDTF/yIUJknBaIHkdietCu9X5h+MagHSlJVPRYhtoKI+jiQD2wmelJMzcDNAwc/vR09VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4zlo4ui; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5785173dfb6so1468794a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716570143; x=1717174943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9kMv49pJMKnl/VPl7t2oqoLc0rJiWrPx5Kz6TyTRjM=;
        b=K4zlo4uiPZxN9+YaT/WGiMUwQaaiqRY2o8/sYdAQaMdkRZcB677nEJXAca2mtN9zaV
         FoVZDnHTNZI+fYxjzjbYNEn6B14MPbYZJNwiRxBP3ol74TfoGKDwdPm+pNIDT1gSiZi3
         9gzVEn3Yj+IhYY5mTe9S0DqwJ1nPL8tzTXFUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570143; x=1717174943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9kMv49pJMKnl/VPl7t2oqoLc0rJiWrPx5Kz6TyTRjM=;
        b=fqz5MRiGrAa4oSTbnKEeCCXNa+dAJZNdIFBMtOsfN7gTLw16Yie6EaCnDmzvT/92w/
         YCqgZ4Y8mfmfKArVEaa7NDTM/gx30b9ZxmagUMvPTYIaGON/Y4u4XZpvSowhQctzfvM3
         JUFJ9EzuRqTP23kavPFDvLK80Mx48r7RuSxJn+Xetq7+ZOfnfpgbRn+Z5ki5CgQtzC2J
         g8Y6/BdM3qfQ4+psUtWA5b3R1Yn4kS9Jta1zImrBfxqK+pNG6hOBnG+l1cpf3lI7cNfK
         klSKEbaQhMeltIX41Kot6T0FbMeKJGnfM/YyA85su5hzRSb5EsVZnrK2DKKuM9GL76AX
         jhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC2BSkHFd2OIS+NdEkFyYTscUpvv6OTfCkPAN8YFyDTNjZHeeFUgVP+j8ATb+KIiTLoHBAj2eGdgaP0uVlM3FTr+IpiGSEhHIbduap
X-Gm-Message-State: AOJu0YzLcMXvjFSNkkbcoPwClKh5BxWFGsK9Ubm5RGL9ip0vE3h6Fu5I
	HiNnwWADhTxSJIoAwKCcLZKAhyOriTjyH6ZLh7QbeuA3L60z9b7e0DndgHSNAb9KQGdunPO/KN1
	JLw==
X-Google-Smtp-Source: AGHT+IGTfiIKRJb0LS0So75dwGUZzJ8pG8v1Du4V4NwezAaeKG7dx7GooBmZl5fybTLQd3bqMEDfGA==
X-Received: by 2002:a17:906:3111:b0:a5c:d694:bb33 with SMTP id a640c23a62f3a-a62649d3f0fmr192513666b.45.1716570143024;
        Fri, 24 May 2024 10:02:23 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93872esm158118766b.86.2024.05.24.10.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 10:02:22 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6267639e86so134324866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:02:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9Ao2WvAK+uUL3Bk0/RJU2jx4PtfD/UMG/7y6uasBQ91KM/jk5an3ji1Belu4KxEAivfaoDKu2osQnkZodtKCQNxiYis9tTjQ0GOJx
X-Received: by 2002:a17:907:9386:b0:a62:1b4f:6018 with SMTP id
 a640c23a62f3a-a6265148c51mr161965166b.54.1716570141375; Fri, 24 May 2024
 10:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 24 May 2024 10:02:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
Message-ID: <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 2:46=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Brian Norris <briannorris@chromium.org>
> >
> > On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> > > +static int
> > > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > > +                           struct net_device *dev, const u8 *peer,
> > > +                           u64 *cookie) {
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +
> >
> > > +             mwifiex_cfg80211_ops.probe_client =3D
> > > +                     mwifiex_cfg80211_probe_client;
> >
> > For the record, I feel like this question was not adequately handled fr=
om v8.
> > That thread is:
> >
> > https://lore.kern/
> > el.org%2Fall%2FCA%2BASDXM1PEMRyxRpBryJ7G6e7yzG8Ku%2Bg2_qpHN3g5d
> > jFpAWkw%40mail.gmail.com%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%
> > 7C0b65f7e4a5fc46c8bdbc08dc7ac2c9ff%7C686ea1d3bc2b4c6fa92cd99c5c301
> > 635%7C0%7C0%7C638520224227876720%7CUnknown%7CTWFpbGZsb3d8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C0%7C%7C%7C&sdata=3DMpqW1U4yTgDcM0g20DRSAxEnHkNNkd2hwsZrVAxg8p
> > w%3D&reserved=3D0
> > Re: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mo=
de
>
> The difference with and without hooking probe_client() is that "poll_comm=
and_supported" of hostapd will be set or not.
> If "poll_command_supported" is not set (won't hook probe_client), it will=
 let hostapd to set "use_monitor" and client can't
> connect to AP.

Yes, I already said that in the above reply.

If you read my v8 reply, my suggestion was that you need to fix
hostapd, rather than advertise lies in the kernel. You don't support
probe_client, so you shouldn't advertise it.

I think you should dig into the reasoning from this commit to figure
out what to do:
https://w1.fi/cgit/hostap/commit/?id=3Da11241fa114923b47892ad3279966839e9c2=
741d

Personally, I'm not sure what hostapd is doing with
NL80211_CMD_PROBE_CLIENT ... but you're the one submitting the code,
not me.

> Maybe I can put following comments:
>
> Hook probe_client to avoid hostapd to set "poll_command_supported" as 0 a=
nd set "use_monitor" to 1.

If we really can't fix hostapd, I'd avoid using such literal
descriptions of implementation details like variable names. Maybe
better:

"hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise, it
requires monitor-mode support (which mwifiex doesn't support). Provide
fake probe_client support to work around this."

But again, please actually explore the reason hostapd is doing this
first, and see if you can fix it.

Brian

