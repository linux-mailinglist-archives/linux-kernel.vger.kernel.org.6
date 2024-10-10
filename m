Return-Path: <linux-kernel+bounces-358066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E69979DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A8C1F23C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688E4F881;
	Thu, 10 Oct 2024 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqa0M/gj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03790FC08;
	Thu, 10 Oct 2024 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521492; cv=none; b=VL2+cBSoUOnBqRSGQpb+tUV18pfIIFjilrAEaKQUk1MGU2vyTsuq63u+owumaYk+BYYV01D8fRVrf4Xd5CBAvOT8c+x3jZ7ZkvBHexojmmxXPCqH+2Vf9RABl+tGF06UdfZw6RbAgDFQlcxV804myMj7iCdSJHJfmFSvbqIHsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521492; c=relaxed/simple;
	bh=+af/uYbgC6VyE0W6rdQWqYXhuWrLabs217v55BqYMIg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YsSSaEMgME0DEMkQYrQ50kiwQ53nyjTWex+6T0rDgLH9dJbUg3TpzMH56LSV+YIaaJjlQbIxSEe0aqO/xn1FRuG534bW2HlaxszIVn1OWt+TnKx56XNU/p3F3Y3CSroWQQjWr60VJIkPTFElTCr1jnAh4lRns+nSGlN1RQITUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqa0M/gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6305AC4CEC3;
	Thu, 10 Oct 2024 00:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521491;
	bh=+af/uYbgC6VyE0W6rdQWqYXhuWrLabs217v55BqYMIg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Yqa0M/gjdyMN7+SzKOL2O+owsvq0qGfKjZoINeRFuLO7iBuLdWRfwveGkvzNXEgRQ
	 z4yd/eUKmlvC3HhPVjq/9+HbDTpR2ypBdMQtu4dtgm5r5jPzFMHVn5vl01DMwNGyDG
	 2xaGy8Z+kuFe/pKX4N5ERha51wA1rijrzwJn6Mzh2xGl7Mv90FiJXG8HaMkovT/tj7
	 Gmf10Zrl9Vkt8ys2CFrGqbNk18t6ZQ/5otfIbuDSwPNyHPjH+D6KD2763WvlmNnMV0
	 QjVrU+kExzFX3EOrY78VyduzURWJudyEk26ElvjmG2veoa5y/8kHD0oUUvFT7OjkiH
	 K+/ary22WYcqw==
Message-ID: <9847eb08599f45659d41134ff4eef62d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-5-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-5-hpausten@protonmail.com>
Subject: Re: [PATCH v2 4/6] clk: clocking-wizard: move clock registration to separate function
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 17:51:29 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:32)
> Provide clear separation of dynamic reconfiguration logic, by moving its
> setup procedure to its own dedicated function.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Applied to clk-next

