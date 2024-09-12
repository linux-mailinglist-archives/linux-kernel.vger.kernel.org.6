Return-Path: <linux-kernel+bounces-326160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC717976414
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D2D1C209CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA219005A;
	Thu, 12 Sep 2024 08:11:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0236C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128698; cv=none; b=iZ8mxxxAZBDEZjyEyb3l70uJtoJXlzVomn3l0HvOLagbJk8LdUPcMPEl04KwEODb4opzk5gMqRnqcpLB9WZYrmOuCZSWocopY+PQQv9igemJXOS35Ve6AWDNfffJoAe710LA5QNLu7U+qWUQ3mh8I93/upuRmY4VpxzJg0WmSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128698; c=relaxed/simple;
	bh=uyN5q2Z9kiKtNZW64JTbvLZ6TpvQNmRMZD8tW5a2L/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZHVcNkSGj+9d+7gm8rZhRFJIVyjy5m5pyk06gkUd2MRo39aeCprYj6OtaR8MTUrMnMaqPKmIAQU1rffGbHPnRy/ov97UQkUTPRAWqCRZQ4ZY2RtfgJGMicfdsyn7suB5xHwiYo1J6e7IKJHi2aC1ipy6wwp/LVZ4C0n4i9kfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soevI-0006ZC-94; Thu, 12 Sep 2024 10:11:28 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soevH-007Kvs-5D; Thu, 12 Sep 2024 10:11:27 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1soevH-0002Eh-0I;
	Thu, 12 Sep 2024 10:11:27 +0200
Message-ID: <9a4377fe27d8eb940399e452b68fb5a6d678929f.camel@pengutronix.de>
Subject: Re: [PATCH v5 0/9] reset: amlogic: move audio reset drivers out of
 CCF
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 10:11:27 +0200
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
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

On Di, 2024-09-10 at 18:32 +0200, Jerome Brunet wrote:
> This patchset follows the discussion about having reset driver in the
> clock tree [1]. Ideally those should reside in the reset part of tree.
>=20
> Also the code of the amlogic reset driver is very similar between the 2
> trees and could use the same driver code.
>=20
> This patcheset alignes the reset drivers present in the reset and clock
> then adds support for the reset driver of audio clock controller found in
> the g12 and sm1 SoC family to the reset tree, using the auxiliary bus.
>=20
> The infrastructure put in place is meant to be generic enough so we may
> eventually also move the reset drivers in the meson8b and aoclk clock
> controllers.
>=20
> This was tested on sm1 vim3l and gxl aml-s905x-cc.
>=20
> Changes since v4 [6]:
>  * Fix Kconfig depends and select as reported by Philipp and
>    and 0-day robot.
>=20
> Changes since v3 [5]:
>  * Drop pltf/platform as suggested
>=20
> Changes since v2 [4]:
>  * Fix undefined read access of the reset register
>  * Fix Kconfig symbol description
>=20
> Changes since v1 [3]:
>  * Fixes formatting errors reported by Stephen.
>  * Changed parameters type to unsigned
>  * Fix usage of ops passed as parameters, previously ignored.
>  * Return 0 instead of an error if reset support is absent
>    to properly decouple from the clock and have a weak
>    dependency
>  * Split the platform and auxiliary modules in 2 distinct modules
>    to fix the COMPILE_TEST error reported by ktest robot.
>=20
> Change since RFC [2]:
>  * Move the aux registration helper out of clock too.

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

