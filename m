Return-Path: <linux-kernel+bounces-318837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F596F406
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71A41C24442
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB851CC163;
	Fri,  6 Sep 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="o43K4T4E"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066891CC150;
	Fri,  6 Sep 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624525; cv=none; b=nu6TU3vwzpcTrYDq7j9vUrMpCy5QltiCtNxggUDrHmoGlZvObyQWMQ0mZDJuL9z9Ur8KfIv/mNuKW2RXx4ph1l+2HMiuW0WgkGuqRzgbbaAOUTnvqNwwI8nVjQfHAqNKWDbOdUPRap7m55ydWguVw1+8y2jaw5BfKrTXHwqGYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624525; c=relaxed/simple;
	bh=XthwQVOWr2ip0l4CSOQfAjQmHCl1Ylg9z/C8SFjr/gk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EToCaYREsqK+KAnqRL8lhmm1y37tBn2MKpdSENXpTihgJxRywvZ9DpM2Sj02y7WMtICnJF2wg5Vpp2VjoSemD8oShHT3gdvbRUZbj5BopSMPCLax0pBcTaryUWxlLihc7qWIxou8wySIrErKIJNr9b1obDuWNEw28YB+Y12TROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=o43K4T4E; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e9c:0:640:b3f4:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id B476761DF6;
	Fri,  6 Sep 2024 15:08:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id U8dbVMXOneA0-dvV8s3HL;
	Fri, 06 Sep 2024 15:08:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1725624511; bh=XthwQVOWr2ip0l4CSOQfAjQmHCl1Ylg9z/C8SFjr/gk=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=o43K4T4EoPrqI+42jemgKmXH1aXC3VadPYhar7dTHsIT6jGeSvP6joDiC5YE+N4GK
	 /4AGx/NzNmTiezH/8Q4DhWV+PAhsKfruEVmu6Dt3ImzTK8OaVtpBD4DddcTWA6tWgk
	 k6kPGuw1hvM67CPrNKv2nX1hP831LyetFi1TrH6Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <02d50cb52a0b73fb937fa2121bac6812592826d9.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date: Fri, 06 Sep 2024 15:08:31 +0300
In-Reply-To: <887d5cfabeccf5dae0538a9c59ba74e4.sboyd@kernel.org>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
	 <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
	 <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org>
	 <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me>
	 <79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org>
	 <cf18eef44460da71db7e125d91da22f0a78c0375.camel@maquefel.me>
	 <887d5cfabeccf5dae0538a9c59ba74e4.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 13:50 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin (2024-09-02 06:31:59)
> > On Fri, 2024-08-30 at 15:27 -0700, Stephen Boyd wrote:
> > > Quoting Nikita Shubin (2024-08-30 02:23:12)
> > > >=20
> > > > Indeed REGMAP is selected by COMMON_CLK, MFD_SYSCON not
> > > > required,
> > > > but
> > > > it needs AUXILIARY_BUS.
> > >=20
> > > I don't see REGMAP selected by COMMON_CLK. Did I miss something?
> >=20
> > Indeed REGMAP is selected by COMMON_CLK_MESON_REGMAP not COMMON_CLK
> > on
> > make tinyconfig + COMPILE_TEST.
>=20
> The meson driver isn't used here?

This is purely from ARCH=3Darm make tinyconfig - i use it only with
COMPILE_TEST for testing.

>=20
> >=20
> > Then we require REGMAP because we are using regmap_read() in clk
> > driver.
>=20
> I think you're supposed to select REGMAP_<BUS> config option, not the
> toplevel REGMAP option. For example, if you're using mmio, then
> select
> REGMAP_MMIO.

Yes this makes sense, REGMAP_MMIO it is.


