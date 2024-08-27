Return-Path: <linux-kernel+bounces-303976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8149617D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C65C2845AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005161D2796;
	Tue, 27 Aug 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvoac/7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06B1D2F6A;
	Tue, 27 Aug 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785920; cv=none; b=OK53wNOiuSIF+6sh77ZlBcDXsdT52m/D0PZ3lw8l5qdhVtXZ8x/1nPIdYeRmQ8yrU4TO57DjdZxghuK3dkCa6fiYHFkmJLp8NOG3o2+1xXRLb3QVHqhc0dYH28S0xzlKwzZUK3+Uzui+ywt0FjpOOKHCmSySaR8jMzakArM0tI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785920; c=relaxed/simple;
	bh=Gd4PQjjdZLiFuRj4/aa/Rk20+vM/4Yx2uCwANEq7Uco=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dyiOnk6iHKUIrukJA/+wVfypTuaKVxbznAzv6OjOh8zGe8AWVoG9XoWkg4U3O1nwVBbb/HBS9/6G5SgccfawlYxQ26lnqko+OHv7HQf6buWmEkKJgDTTbP/kleDHEQGFyUfrXdoW1GUi4osNeOniItxpLVGsHJAO0sBqQa0aReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvoac/7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADAC4AF54;
	Tue, 27 Aug 2024 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785919;
	bh=Gd4PQjjdZLiFuRj4/aa/Rk20+vM/4Yx2uCwANEq7Uco=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lvoac/7EzDXRdcRwaoDg8pXOB6bLbo+cpOjMNJMIaRkHxAxB/DbsA8gXuA/ZVQ5Cu
	 zV7dhvq36LM9k/dm0dHa4HawSAUNjHFnQqTJlkWdA4HY2bYfGOUUa0Z6NbM+v3FwzS
	 DIk31KzgM1LbS7lCzaVlzpxVK3qfg/R6datIRRvF7aUqgkBiufKCYgS1XjiffW/+QO
	 F08BCnwIdgxAwlhb+FGMGboKGoJSH+DLFIHhtapTZvOjs1Tv20gwMj9d3m8B9ztPe6
	 Dqa+9cG49ammqCQuuouzMTQJySJ2mNPtR2ojW6R1bN4AMKayUOpeFc86hKMRhPElvE
	 wPKG5Vug7iiZg==
Message-ID: <e45b7cef58f910e05a77d3309b9230d3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
References: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V3] clk: scmi: add is_prepared hook
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, d-gole@ti.com, Peng Fan <peng.fan@nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>, cristian.marussi@arm.com, linux-clk@vger.kernel.org, mturquette@baylibre.com, sudeep.holla@arm.com
Date: Tue, 27 Aug 2024 12:11:57 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-08-06 07:56:01)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Some clocks maybe default enabled by hardware. For clocks that don't
> have users, that will be left in hardware default state, because prepare
> count and enable count is zero,if there is no is_prepared hook to get
> the hardware state. So add is_prepared hook to detect the hardware
> state. Then when disabling the unused clocks, they can be simply
> turned OFF to save power during kernel boot.
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

