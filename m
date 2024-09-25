Return-Path: <linux-kernel+bounces-338392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFC98573E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C21C211DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181C15FA7E;
	Wed, 25 Sep 2024 10:37:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E56139563
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260627; cv=none; b=kEk0uZ8/unui5RafdKMPURdw9e34iD2XuKqd88ZHbhMg+dk9MzOmmyrtRwiFbDrvjhcmmB7uAx5HaVrzhPZr2g4ka28ia0j2CvfaXDWwjhh4+oREYLhx9gl35iHMNmOf9qTPVL8KeFqY5qV/zFYBBTB4vLvJaBW+rPt3fAq+0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260627; c=relaxed/simple;
	bh=pi5PX55Zl2cJ5n0aAuiWj0UVtvPwaZqU3uToF0RQfno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUK1KEWcn+Q5bCGGWNCyZXNVMWnSNqxqha7ys7Nzb41ulNBFcIP2DJkHOgS5I9+BFZU3oTMEMYULpGAGvXAW+GO+u6hIlpCRBKVQNelxHPPElKtmT6UyugM2tqoapse84wvJ25qrIOqosFOgK5yq1TI049E7w1vxUbMpbbkzuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stPO5-0008UY-A5; Wed, 25 Sep 2024 12:36:49 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stPO4-001QZj-28; Wed, 25 Sep 2024 12:36:48 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stPO4-0007Bn-01;
	Wed, 25 Sep 2024 12:36:48 +0200
Message-ID: <dcdab2a4e6a5eda99ff5e9523ccb9c6edcfbf732.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: starfive: jh71x0: Fix accessing the empty
 member on JH7110 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Emil Renner
	Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
Date: Wed, 25 Sep 2024 12:36:47 +0200
In-Reply-To: <20240925095929.1729726-1-changhuang.liang@starfivetech.com>
References: <20240925095929.1729726-1-changhuang.liang@starfivetech.com>
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

On Mi, 2024-09-25 at 02:59 -0700, Changhuang Liang wrote:
> data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
> ("reset: starfive: Add StarFive JH7110 reset driver") was added. Add
> the judgment condition to avoid errors when calling reset_control_status
> on JH7110 SoC.

Please add a Fixes: line to make sure this is backported to all kernels
that contain commit 82327b127d41:

Fixes: 82327b127d41 ("reset: starfive: Add StarFive JH7110 reset driver")

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Acked-by: Hal Feng <hal.feng@starfivetech.com>

With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

