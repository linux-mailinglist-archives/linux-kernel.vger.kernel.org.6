Return-Path: <linux-kernel+bounces-291228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3EA955F58
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4F2811C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309272208E;
	Sun, 18 Aug 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2X9MW6n"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E90153573;
	Sun, 18 Aug 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016778; cv=none; b=jozHfAYRFb9UPJUqAOgag57UCWUDUiSfZOjfHyIJAnwAJg7vHDEA2AAj0bdNvTVii4SN/DaRwMN8RvOmVOBUpweQojuEaNwBO03V0c67hGgvbosyEu2zi9t2hpJwmut3BRymwAGoA8m2Izt2KwTVZRwEbhSIQ9Nv1/EN/ZEyzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016778; c=relaxed/simple;
	bh=+p3VKe9iTag8inzp/6FGohRgqxj9rctXxfCkz3gi0KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+MLTtaFWfGOJifDd7fyJav80TNGYh6RfED/nxrBfD3tmz+CnMHmbJBWmBQt7C/1VV0/RwXXGazWz1B0PcGVFLkKXHoZDBqVB8ObnMbbqn2cNmaDtGXUm1IwZpzgzQUWrzxSXXQrGJI9SHkbIihn14NXXl/KA84AUpJ1HjEPN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2X9MW6n; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db51133978so2476746b6e.3;
        Sun, 18 Aug 2024 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724016776; x=1724621576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gkcmIIMnoTGboEDvnnK12RAaIwabyHY1LBCxMjsCOQ=;
        b=c2X9MW6nMmg+UdQdh+LnlCC9KYWbV6CapDdeclqVNPYdW4KPL78VIc2yWPNJgqsBnb
         giZLyjI6GZ/izCeuTDADOll0x1ekelc2PGhsceETLKAvD/q7x9k82DDRRM4zwGrSEq+E
         qPifGYyWQ7LvbH9XG1JVrzl1GAxg+7wXIOBeacgl9QaBOUYo4V50hbKdfwQ5WSk1SPV0
         ZeaOKj/mA4fsRTilxnF4J3rTFAc8LXwsUwbeKFRvCM+mHPWMVT30Q7hvfD6sno1HFZfm
         wlg38giYK9DDspaVJxe0bL3k32DNVMAIEgO9Ha05LUV8NO6w7Ropra1RnQ/HnkjL/1jI
         JzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724016776; x=1724621576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gkcmIIMnoTGboEDvnnK12RAaIwabyHY1LBCxMjsCOQ=;
        b=isrFSrzkjDxDxSybzcj/SoK4IXxLABtLd1/J+H1gFXC37Lt3uQ80fTO63eNvIcVskD
         /OJ7JqCYgVLGjw9dSfF2mtH8+s1Yqes+V6OaCjc70oMJV1U5fs6sq7jK0kQN4qecb7Fa
         EAcN7UEqduJBX+zzEqm/Plr9+eBBjSAL7xS/mkYfXDUg2hvxPkgf2QG6pEL8gDdtA5OA
         2ZC4hpGUA7YqQDPKVovkPGUOrXa2LIhH8YWTSn2Hr2ZYAY0IFDIy7JYCgUZysKiaWLRE
         9FkgGaCOeIZ8kqrOTiBNS4bD0mM72YyNBj9iRc3aPrdAdQMArKpOsBxUbKwx1ZnHmeyQ
         VfDg==
X-Forwarded-Encrypted: i=1; AJvYcCXq9s3meB6lHinJ1/pSPNfJTqQX0Fs9DtyEkMmSkpoASt4H7Rpa7PDluQ2GkPQABSpDtkKr2f64HIJU4ePPlnkfj3ZIJ2HMR/Biu/9w
X-Gm-Message-State: AOJu0Yxb2vII7DwMH/uQGNC6MUJ10ziDVnqPX+5cTPSt+k/l2fKkEdU4
	dkqXmMBcxTloonrmv+OD9ivjSDg6LOz6omqKRnHBSg4WLWqkwcAljEwpNaJXI6/yparwu1OVEzb
	u1LNyeGdD6AzT15WIbrXbE0WsXydccDu5
X-Google-Smtp-Source: AGHT+IHXDov//kyQ0zuShYvCYCRCy38iMkJmmUducVC0zFKVgf4GKpueR/jJ8d6PYoPybkVeSUwTdpXGDxjcmcrt0YA=
X-Received: by 2002:a05:6870:7026:b0:25e:de4:9621 with SMTP id
 586e51a60fabf-2701c3e4751mr11227618fac.24.1724016776088; Sun, 18 Aug 2024
 14:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731125615.3368813-1-neal@gompa.dev>
In-Reply-To: <20240731125615.3368813-1-neal@gompa.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:32:44 +0200
Message-ID: <CANiq72mSa4_=DSFUMkq129ByQFkPk_5Y0BdY6J0Skj7Npj99-w@mail.gmail.com>
Subject: Re: [PATCH v2] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Neal Gompa <neal@gompa.dev>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:57=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrote:
>
> When enabling Rust in the kernel, we only need to block on the
> RANDSTRUCT feature and GCC plugin. The rest of the GCC plugins
> are reasonably safe to enable.
>
> Signed-off-by: Neal Gompa <neal@gompa.dev>

Applied to `rust-next` -- thanks!

    [ Originally (years ago) we only had this restriction, but we ended up
      restricting also the rest of the GCC plugins 1) to be on the safe sid=
e,
      2) since compiler plugin support could be going away in the kernel an=
d
      3) since mixed builds are best effort so far; so I asked Neal about
      his experience enabling the other plugins -- Neal says:

        When I originally wrote this patch two years ago to get things
        working, Fedora used all the GCC plugins, so I was trying to get GC=
C +
        Rust to work while minimizing the delta on build differences. This =
was
        the combination that worked. We've been carrying this patch in the
        Asahi tree for a year now. And while Fedora does not currently have
        GCC plugins enabled because it caused issues with some third-party
        modules (I think it was the NVIDIA driver, but I'm not sure), it wa=
s
        around long enough for me to know with some confidence that it was
        fine this way.

      - Miguel ]

Cheers,
Migul

