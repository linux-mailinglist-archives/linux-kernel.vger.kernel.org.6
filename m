Return-Path: <linux-kernel+bounces-311010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE19683E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BA3B24E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A541D31BD;
	Mon,  2 Sep 2024 09:58:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAA187FE6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271110; cv=none; b=gPKD6+r0okvlWk3WVyRpE4YwqOtak06n6HUcRgebbupeepnJCSwXN418WgMsCd251/Xbmojg9GkJCW/p6omtGST9v9WauaHzkQIgsuMy9pDUfo4U0PimgCq93kQ2osSQ4nHdgGi2u5AowZtTQVIn7qRZDZRFg8O6iDMNE6GMKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271110; c=relaxed/simple;
	bh=sP1R8pSpw6iTUMghE4/295HNgzu3jBMlCzVrAHkpBqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIh2cyWTft+SSDvi5LFx2Il1ueZJueZmJLXujszj2iD8KKYLGZ6WvWcySRy7I5sYX5RoTkQfY/AukwEBLL+ohtAjxih7o9+o6N9MDSqT+dX/HgAF1A90McZWwyI944KGOQlOkKykKf2nR4NnYHer7rDPoCzURboTqbvsH2jNLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3pG-0005c2-GS; Mon, 02 Sep 2024 11:58:22 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3pG-004s9t-1Q; Mon, 02 Sep 2024 11:58:22 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3pF-000gBo-37;
	Mon, 02 Sep 2024 11:58:21 +0200
Message-ID: <33e85db3d74cdd01ee789f64d7ce6409adfa52a1.camel@pengutronix.de>
Subject: Re: [PATCH 0/5] reset: cleanup and simplify with devm and scoped
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Antoine Tenart
 <atenart@kernel.org>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Damien Le Moal <dlemoal@kernel.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 02 Sep 2024 11:58:21 +0200
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
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

On So, 2024-08-25 at 16:14 +0200, Krzysztof Kozlowski wrote:
> Hi,
>=20
> Two simple fixes, which do not cover real scenario (memory allocation
> failure during probe), thus not marking CC-stable. Rest of patchset is
> simplifying of code.

Thank you, applied to reset/next with Damien's suggested change.

regards
Philipp

