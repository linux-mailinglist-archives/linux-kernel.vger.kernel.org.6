Return-Path: <linux-kernel+bounces-319545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95396FE4B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA811C213A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4115B10C;
	Fri,  6 Sep 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHUoICWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5D1B85DC;
	Fri,  6 Sep 2024 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663731; cv=none; b=TOM5cdnJ2a4ZfnBkWArIB1Bez92yXVoNVQoMjt/lDuMtD5NijhXsnauPFAxtT91mzza4Oj3loVpx8M6nieolLTqxfD/JmruswZceq9Yl0Ak7+i6/DpX80IsGy34LxYIgTD0+BxY0uu3DTlmRBOcgW93wEj4QNHftgahzu2KS2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663731; c=relaxed/simple;
	bh=ldflI04Ts9BSmUuRhFXFjpTFI7d5OrKXMZDtQeiJu+k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=qi734IPygjejboKA9NJyWtyvY30XjK7iyYp5JYuLflGnkRzRzygLzoF+PotmwO46VgB3a5MuyhlQ8895SAhXIKdGb5FyfYEjWGhcXc4bUYDW6J5W2ivfAK503a63RCdPYFwNlewMONVc50/GD2hs/S/fhwIzr/wpUOv3hUGjHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHUoICWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F0C4CEC5;
	Fri,  6 Sep 2024 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725663730;
	bh=ldflI04Ts9BSmUuRhFXFjpTFI7d5OrKXMZDtQeiJu+k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oHUoICWtCtwGqLgYdGmyD7Ju3yflh55yITURS00j6N3pfj4WeVnawdt9gwXlExhRb
	 nQVWElBJa+7LSNjsiIAQD4ZefcamFbwjfAwhOWd9Jj8i87bsfTsOYqpen2scJEpV+x
	 it6MlCsWeQT6Fdq4SDovdESx8h7eHxHHcen8GNoMYES1fVfMFgU6zxbWD0t67j2/hk
	 vkPNaf75x/KQpJtrSvwO7mwaaVc+rxjqjVpB5d7TtmI3DHjq8DqlVJgXoduUptF9FJ
	 GNA8D5JDHOZVD0T4j6sJZAuCX8DqzuFLCShteQN2d7ouZcg4oHOYAvk79vgi8GHDkh
	 65bUcAV0YtX4A==
Message-ID: <91eca16a2453514123e8ffd5346297eb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5168975.haC6HkEk0m@diego>
References: <20240828101503.1478491-1-heiko@sntech.de> <20240828101503.1478491-5-heiko@sntech.de> <9b92b5f03632e8793253ba75fc00f6e3.sboyd@kernel.org> <5168975.haC6HkEk0m@diego>
Subject: Re: [PATCH v3 4/5] clk: clk-gpio: add driver for gated-fixed-clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>, mturquette@baylibre.com
Date: Fri, 06 Sep 2024 16:02:08 -0700
User-Agent: alot/0.10

Quoting Heiko St=C3=BCbner (2024-09-05 15:48:35)
> Am Mittwoch, 28. August 2024, 20:30:51 CEST schrieb Stephen Boyd:
> > Quoting Heiko Stuebner (2024-08-28 03:15:02)
>=20
> [leaving out all the "will fix" parts :-) ]
>=20
> > > +static struct platform_driver gated_fixed_clk_driver =3D {
> > > +       .probe          =3D clk_gated_fixed_probe,
> > > +       .driver         =3D {
> > > +               .name   =3D "gated-fixed-clk",
> > > +               .of_match_table =3D gated_fixed_clk_match_table,
> > > +       },
> > > +};
> > > +builtin_platform_driver(gated_fixed_clk_driver);
> >=20
> > The comment above builtin_platform_driver says "Each driver may only use
> > this macro once". Seems that we need to expand the macro.
>=20
> each _driver_, not each file is the important point I think.

Ok!

