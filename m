Return-Path: <linux-kernel+bounces-561750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C72A615B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388237A4411
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E920299A;
	Fri, 14 Mar 2025 16:05:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1B1FE450
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968325; cv=none; b=D1C7sNiDLE5ZPRiSKojfFLyEWiGKasgyYn+vbDmZXRZtTYm0/7psCON74m+bvkN15dB13QkZ9mxo6m9GrjFd+LEbWSu6x9EVTyydlb+qVrQG12l54I/8Dym2AqDYVgBr03MrllHoHcJscaV0tSQP+wtzRExEha5jVoBAvDs2dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968325; c=relaxed/simple;
	bh=AlL/eilY7a6LvH7AFh4F/7NNvc/61nWc2Cn3lPejut0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eL1O9k5ZD3yPhS7lbCDct4TY0kNqGszKloBGOBSqKAwl5tvXZ8DMxHmxw81DB+crgmOd7xkj4m+k4cqQWN1dnkikpyIZ3PZjliXe298lgIAGuXdVmdglwE1yWm5YQnAibZS7jFZYylRu+Jwjv7yR9yRB2NrXOQjHQxnufQg1Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tt7X3-0003ae-7S; Fri, 14 Mar 2025 17:05:09 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tt7X2-005jEa-2G;
	Fri, 14 Mar 2025 17:05:08 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tt7X2-0009KL-21;
	Fri, 14 Mar 2025 17:05:08 +0100
Message-ID: <9bd42362c798cc3339ab9b34b32a9eb7eb4d1ba7.camel@pengutronix.de>
Subject: Re: [PATCH] reset: imx: fix incorrect module device table
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
	Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pengutronix Kernel Team
	 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2025 17:05:08 +0100
In-Reply-To: <20250314153541.3555813-1-arnd@kernel.org>
References: <20250314153541.3555813-1-arnd@kernel.org>
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

On Fr, 2025-03-14 at 16:35 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The ID table is for of_device_id, not platform_device_id:
>=20
> ERROR: modpost: drivers/reset/reset-imx-scu: type mismatch between imx_sc=
u_reset_ids[] and MODULE_DEVICE_TABLE(platform, ...)
>=20
> Fixes: 6b64fde5c183 ("reset: imx: Add SCU reset driver for i.MX8QXP and i=
.MX8QM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to reset/next, thanks!

[1/1] reset: imx: fix incorrect module device table
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dc361baf67200

regards
Philipp

