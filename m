Return-Path: <linux-kernel+bounces-253012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC77931B36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E657B2275D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6863139D19;
	Mon, 15 Jul 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+StPIgC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6027F510;
	Mon, 15 Jul 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072854; cv=none; b=Kng+t5bOngnjuKjtmUeLGmLvEipnrhZTrZ4JHPAAtNlXkYFrwDiVL4bckBhK1XfhbdEW3ZSKptRLc7Ixp8WOzAKEDElN9cd56iF8elANWZNoyBpjBDVKtyKhN4+yjw4kAMhAt6abC4fMP2CAQm2s/eN+OyBBS6vqy0rh1hj8SRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072854; c=relaxed/simple;
	bh=6KgtSuAwHwr/G8Y0+1/UxRw/duCsRV2s2N6czUBX2HM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lJDqz8gUvYqxvv+dVbomdoXgZFTe/sakneEnPrk0y6sOiiT/BmMC/lMUZ6noGHgDE74eRcPL2LJYzwAs+t2EFUm9OzU4DfyasnL9f74H1VFpv2XI5pfT3J4cBVPtZOQ9Su55fnhcKc67D8V0uBtq2Vu0/RELRDCeKYbE8+dfbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+StPIgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDBC32782;
	Mon, 15 Jul 2024 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721072853;
	bh=6KgtSuAwHwr/G8Y0+1/UxRw/duCsRV2s2N6czUBX2HM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=T+StPIgCd6S8L4r5V0gjG/GcnnJh09mwRh8f9OMTLfMEly2YdLEKIylCWTKP2lnXM
	 NMBBy8woNYdwT6h5FLdb1eWxM4m1WZeEySgeWtcgMwnXDItYpLQRnOqZpdcZ4gNeAA
	 Ayvq7tgH8BoieNMPztQC1rzKI4b5hIFyM1AVf7JrbkfyaHMXgndzyDOrT7lt7Cey5B
	 ZSOyKcecaJI3nX8klQDxO5BGcJ320dVT2kqUe/GTVwkSX6cZvwP5YooZcN26HPgPrF
	 A1RyqKMJ1PkLf7HdNs5gWRW3yYg055pqwmvmqFYIGq3LmejRUKxGV80qECp8nm8n1Q
	 csFRVm6LlhOYg==
Message-ID: <2a56789d4f1eaa97ec91392f93741f19.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240714141315.19480-1-claudiu.beznea@tuxon.dev>
References: <20240714141315.19480-1-claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, alexandre.belloni@bootlin.com, mturquette@baylibre.com, nicolas.ferre@microchip.com
Date: Mon, 15 Jul 2024 12:47:31 -0700
User-Agent: alot/0.10

Quoting Claudiu Beznea (2024-07-14 07:13:15)
> The maximum number of PLL components on SAMA7G5 is 3 (one fractional
> part and 2 dividers). Allocate the needed amount of memory for
> sama7g5_plls 2d array. Previous code used to allocate 7 array entries for
> each PLL. While at it, replace 3 with PLL_COMPID_MAX in the loop which
> parses the sama7g5_plls 2d array.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---

Might as well add a Fixes tag so we know when it was less efficient and
to help anyone trying to backport this driver.

Acked-by: Stephen Boyd <sboyd@kernel.org>

