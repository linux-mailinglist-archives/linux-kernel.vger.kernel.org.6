Return-Path: <linux-kernel+bounces-273241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7449946643
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4531F22643
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646A13B2A8;
	Fri,  2 Aug 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTX/xk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38D1ABEB5;
	Fri,  2 Aug 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642786; cv=none; b=r7E3MKKTuvEe/EIJ28l/3awNkCZL4PcWZOzdqdZI4T0grayYAC/Im0TZNPP/zOF4WrfPiEyg922NEfFBnTkKOOIE7WgFGDTtfZZAYKbDLeJ2b89WxKyM6na2ALF4QfzDryI8NJm27kqpE1d3JsmX7WGUWH6fMYgPLDk7paDoL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642786; c=relaxed/simple;
	bh=GBB9y4D/0MRMc1n5C8QY9TepetSxTr0tYqdNh/0XGwc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rdI1iLIp0IX998O15D5V9M/K08chzH4nefD299SW7obusY/qWe1QJ/piMctb+3vu1+l/FG0Sd9Kz0pwNhisw9X8Xi6FKhbAVuYtXAb5FNs9Tuq4fZLux2GKQPIFRiF1kWCKSuvzywKfID8/I6JTwTl/AlMUNzyYoNPDtk+LkOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTX/xk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B261DC32782;
	Fri,  2 Aug 2024 23:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722642785;
	bh=GBB9y4D/0MRMc1n5C8QY9TepetSxTr0tYqdNh/0XGwc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EmTX/xk4Eis4CGus8Y08U11rZJFRss1A/XbAjLw0635bAPfmsCnYhPtnHGf3lN+bd
	 6knQEvpdEitZW1zSBpWnypZJ0+/w100BqugaJAiUeoNehMjC3RZhdVaNmsK4NxQMy6
	 dXZXD9zVoX8xVzreDQIF85nLvfMRVP//6Ix2UtEwhGxMnqC2HA318v6Px6PbHaSb8T
	 WK/JU4TpAF+3EqlG60zpgrc9nuHMu/OLs3vrEtZZor7T4vOot95UApV5+ueSNYFB6M
	 vXygI3hHB26QEAHyGrWuELfg9AA/dCBIQUeqBdYqPrFdjT/ieXsR1sRfjXBmJqfqIY
	 z5PDHS2ROPy0Q==
Message-ID: <0657256308696091de8e5c5d33d8f7da.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240731201407.1838385-7-robh@kernel.org>
References: <20240731201407.1838385-7-robh@kernel.org>
Subject: Re: [PATCH] clk: at91: Use of_property_count_u32_elems() to get property length
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Michael Turquette <mturquette@baylibre.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 02 Aug 2024 16:53:03 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-07-31 13:14:02)
> Replace of_get_property() with the type specific
> of_property_count_u32_elems() to get the property length.
>=20
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT property data
> pointer which is a problem for dynamically allocated nodes which may
> be freed.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

