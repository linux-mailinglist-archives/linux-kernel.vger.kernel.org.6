Return-Path: <linux-kernel+bounces-346264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA498C208
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17811F265D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BA1C9EDC;
	Tue,  1 Oct 2024 15:51:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C31C3F01
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797878; cv=none; b=XZzehvg5dTqm+AzS+MK/GLnUfsdi+oamI+KYOXfT/T6j3z41EE53Y0yWs4LJnR//LNaXJctheue4CLCUaiEc0RHgfP/9i5ehEyBy8aNXaYZJ7JrwanilvQfz48tgSBGJKUcHmyDABg7BtLTZZPgUz0ZIA7BEoeJ82EdBcXN+WJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797878; c=relaxed/simple;
	bh=05WVPGiDbB4JdAt3sJE01nHanmqyzysXC06ortam0iU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTuXIj1w4QIzsdDCMDPslwnjHntQl/T5lITOpd9RQ0E+duAkr5GiJIhL/8cPjk/cDXl4nbwod+fzptc0ys29F0B2bJbMSmBESHThQ4Y7XtTceJkXAlSdqLiR+2IKSTHGjdxa26BuMWuOiDAJY3S2Y+1kj0rEa7u1ERChGc821dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svf9R-0004JJ-Ch; Tue, 01 Oct 2024 17:51:01 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svf9P-002uLD-As; Tue, 01 Oct 2024 17:50:59 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svf9P-000BSD-0r;
	Tue, 01 Oct 2024 17:50:59 +0200
Message-ID: <c5d318947728e9e5b66d11542023b79452705ca3.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] reset: Requesting pre-deasserted,
 auto-reasserting reset controls via devres
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,  Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  kernel@pengutronix.de
Date: Tue, 01 Oct 2024 17:50:59 +0200
In-Reply-To: <vvthbvqhcvaau2bfvlg7yajpeybrvlvqdmbqzgygk6wyjcf7di@lfwuqmpk2u3z>
References: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
	 <vvthbvqhcvaau2bfvlg7yajpeybrvlvqdmbqzgygk6wyjcf7di@lfwuqmpk2u3z>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Uwe,

On Do, 2024-09-26 at 07:57 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> On Wed, Sep 25, 2024 at 06:40:08PM +0200, Philipp Zabel wrote:
> > There is a recurring pattern of drivers requesting a reset control and
> > deasserting the reset during probe, followed by registering a reset
> > assertion via devm_add_action_or_reset().
> >=20
> > We can simplify this by providing devm_reset_control_get_*_deasserted()
> > helpers that return an already deasserted reset control, similarly to
> > devm_clk_get_enabled().
> >=20
> > This doesn't remove a lot of boilerplate at each instance, but there ar=
e
> > quite a few of them now.
>=20
> I really like it, thanks for respinning!
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Two small notes: I think __devm_reset_control_get() could be a bit
> simplified if it used devm_add_action_or_reset() instead of
> devres_alloc() + devres_add(). I also would have prefered an if block
> (or a function pointer) in the release function instead of a ?:
> construct to select the right release function like e.g.
> __devm_clk_get() does it. But that's both subjective I think and
> orthogonal to this patch set.

Thank you. Not sure about using devm_add_action_or_reset(), but I'll
look into using a single release function.

Applied to reset/next.

[1/3] reset: replace boolean parameters with flags parameter
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Ddad35f7d2fc1
[2/3] reset: Add devres helpers to request pre-deasserted reset controls
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Ddad35f7d2fc1
[3/3] reset: uniphier-glue: Use devm_reset_control_bulk_get_shared_deassert=
ed()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dc0260e2b0ed8

regards
Philipp

