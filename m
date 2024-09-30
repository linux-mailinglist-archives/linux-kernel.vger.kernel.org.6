Return-Path: <linux-kernel+bounces-344330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3098A860
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C777D1C229CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055881922CC;
	Mon, 30 Sep 2024 15:22:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D320B0F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709759; cv=none; b=jSUFCYdXhBEahs61sQqgGsKfy2y8FOFHps+lHRvIWe1ODMNhj11hYltfmYzwNoZkAECjs6+wciqd01a75l/SzeeMgXwafBu8Er4tcOFfDgFGi/IYto1AEmd74KEJYmBktVIlAJFvCoJiX91fLJuVJeqdwjR3fQ9/5oNmhucvGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709759; c=relaxed/simple;
	bh=gdKdPQVR+zErnF1sINtww0CbgMypAMuhdx7dBmMRb74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWsxu8QPVEYsSY5LE4U5lzzF1WlPxZSgm+IwqHdl00uWkrfyvOmFSaOKpVVS+ZcstcpvcTPi5nbS9YaRgxZsgNcLhUevONjatdIkK2lTlOJ4M5g9wDYMcH+dLCLmD+r8SKqHZ0VJb7Gyj1EJlSuEojbkqn1Ba7x9gCjYMYKcZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svIEE-00080z-3Q; Mon, 30 Sep 2024 17:22:26 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svIED-002f6a-AE; Mon, 30 Sep 2024 17:22:25 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svIED-000DI0-0o;
	Mon, 30 Sep 2024 17:22:25 +0200
Message-ID: <b4d9fb99dbd2e2a6a6ce39744e2e640d35ea97c7.camel@pengutronix.de>
Subject: Re: [heads-up] Re: [PATCH] reset: Further simplify locking with
 guard()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Date: Mon, 30 Sep 2024 17:22:25 +0200
In-Reply-To: <97b2b218-b46e-41a8-9379-09b76569f3f1@linaro.org>
References: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
	 <20240928222702.GX3550746@ZenIV>
	 <97b2b218-b46e-41a8-9379-09b76569f3f1@linaro.org>
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

On So, 2024-09-29 at 20:48 +0200, Krzysztof Kozlowski wrote:
> On 29/09/2024 00:27, Al Viro wrote:
> > On Fri, Sep 27, 2024 at 04:02:32PM +0200, Philipp Zabel wrote:
> > > Use guard(mutex) to automatically unlock mutexes when going out of
> > > scope. Simplify error paths by removing a goto and manual mutex
> > > unlocking in multiple places.
> >=20
> > And that, folks, is a live example of the reasons why guard() is an
> > attractive nuisance.  We really need a very loud warning on
> > cleanup.h stuff - otherwise such patches from well-meaning folks
> > will keep coming.

Thank you for the analysis. It think I'll drop this entirely.

[...]
> >=20
> > Guess what happens if you take goto out_put prior to the entire thing,
> > in
> >                 ret =3D __reset_add_reset_gpio_device(&args);
> > 		if (ret) {
> > 			rstc =3D ERR_PTR(ret);
> > 			goto out_put;
> > 		}
> > That patch adds implicit mutex_unlock() at the points where we leave
> > the scope.  Which extends to the end of function.  In other words, ther=
e is
> > one downstream of out_put, turning any goto out_put upstream of guard()=
 into
> > a bug.
> >=20
>=20
> cleanup.h also mentions that one should do not mix cleanup with existing
> goto, because of possibility of above issue.

Yes, d5934e76316e ("cleanup: Add usage and style documentation"), last
paragraph.

> But except careful review, this patch should have been simply compile
> tested which would point to the issue above. Any guard/scope works must
> be checked with clang W=3D1, which reports jumps over init.

Thank you, I was missing a CC=3Dclang W=3D1 build in my pre-flight checks.
That's fixed now.

regards
Philipp

