Return-Path: <linux-kernel+bounces-344486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2C98AA51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5C81F20EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F67194C79;
	Mon, 30 Sep 2024 16:52:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D47DA79
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715141; cv=none; b=pQNaTpxwL4yEH7yMdAZy34ovGii9I6CH2JCEwy05KBkFyMfmcrpIx3iwlEawLcmWoiifkm5Go90Dp2lD0075oig4CmS3+xHEJixaA+Hl0urzl1HWaRlsjs50W4Jnke56AqcqJonhJNX9FE1fJbsK4gJBWYNHKlYWw5Ur5g2U4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715141; c=relaxed/simple;
	bh=nM/DP38Al/jyTpmzMXYEJKmf9YddH2hcNxQHKVikd8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BG5ObXL964jpDnPX/vV8u2fXuk9I1+l7Wtgo+0XH/bwPMiMe4LW2C53waAukNSvZ3BoaEn0e9+02gCn2r+vzaYMOCULwxk9ecqBPWIW4sH+EWjTuCopxOq4yYDFi6cVzIqVGJTtVz4clfgvqrf6GFgw3umiYE/7V3mqKSO7F5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJYC-0005vH-RS; Mon, 30 Sep 2024 18:47:08 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJY9-002fu2-HV; Mon, 30 Sep 2024 18:47:05 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJY9-000FA1-1X;
	Mon, 30 Sep 2024 18:47:05 +0200
Message-ID: <eee4634290636c873ee38c3f8dfb4a49a2095ce1.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: starfive: jh71x0: Fix accessing the empty
 member on JH7110 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Emil Renner
	Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
Date: Mon, 30 Sep 2024 18:47:05 +0200
In-Reply-To: <20240925112442.1732416-1-changhuang.liang@starfivetech.com>
References: <20240925112442.1732416-1-changhuang.liang@starfivetech.com>
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

On Mi, 2024-09-25 at 04:24 -0700, Changhuang Liang wrote:
> data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
> ("reset: starfive: Add StarFive JH7110 reset driver") was added. Add
> the judgment condition to avoid errors when calling reset_control_status
> on JH7110 SoC.
>=20
> Fixes: 82327b127d41 ("reset: starfive: Add StarFive JH7110 reset driver")
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Acked-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to reset/fixes, thanks!

[1/1] reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D2cf596636607

regards
Philipp


