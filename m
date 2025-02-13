Return-Path: <linux-kernel+bounces-512651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A861CA33C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081A41885DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BE212FB4;
	Thu, 13 Feb 2025 10:08:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3120D4F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441313; cv=none; b=Rz6rrkh+2N3p/nz63lFLt5LwMG2d4PVvSOQMshNBZbtaIXZD0oJjh1H63h0tE2V3ele3G2Rp9AEt0EuMWf5OXt5Q+pYhpHlc/Hz38cfo/rTYnBECC5Jmm8dyMK9+gYy2rCPyWvFnFljJ7JKCNMx367rjsWECOP56VHf2bgOSa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441313; c=relaxed/simple;
	bh=4nPHH3gdjjhCp0D3T2e0TjZRVtYJvjDIu2hfsqY/WcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqV1mDPDd3k/nN8lply17w8dz1Le3XrGY3NgxJYpE2T3zOgGYGjItg983z20Ch8DUgTUq2+nK4kiazVEcZQ21hQOzWbipQxbODK9wqf3G78XGtCJJDkqTMkPfXFojufivMWTjI05noup4UhUlUHzfKF/RSUdWVuaYtYqK4fZ5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW8c-00071Z-Dt; Thu, 13 Feb 2025 11:08:06 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW8Z-000jXZ-2a;
	Thu, 13 Feb 2025 11:08:03 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW8Z-0002vt-2N;
	Thu, 13 Feb 2025 11:08:03 +0100
Message-ID: <42e8f0e0f065b10fa8731d26acc856e5776fe2de.camel@pengutronix.de>
Subject: Re: [PATCH 0/4] reset: introduct generic bit reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan
	 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Date: Thu, 13 Feb 2025 11:08:03 +0100
In-Reply-To: <20250213020900.745551-1-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
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

On Do, 2025-02-13 at 10:08 +0800, Inochi Amaoto wrote:
> Many SoC have a simple reset controller with toggling bit to perform
> assert/deassert. It is annoyed to add compatiable for each device when
> coming a new SoC. It is necessary to introduct a generic device to
> simplify these things.

You'll still have to add a compatible to reset-simple.yaml for each new
SoC, see patch 3.

regards
Philipp

