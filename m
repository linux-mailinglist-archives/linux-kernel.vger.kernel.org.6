Return-Path: <linux-kernel+bounces-358063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E19979D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F37E1F23457
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9B2AE9F;
	Thu, 10 Oct 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ8S3BE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3C2629D;
	Thu, 10 Oct 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521475; cv=none; b=K2Q3V0rK3zcz/h/KIiFU2yxHomJYY38f2qdBwOt2nbBLpfO5Ci9YHhRU9cpyIqVrvnk1Q1mnUzBdenhJ1MY7jOL0jUccQgLiSBSwut29jhVhNzEVJZ0KVjTz1ub0AwitW3gNZt/Q5gz4/AFHOPcCuYTw8PIe4vVa51GA0R+BeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521475; c=relaxed/simple;
	bh=kfep0MapJuZXXEvFi9LDpNuX7DV9XX0GSk28ZL5GrIY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=sZztV850lrTS+xhyYRBx/W14yCgWpS5I4lAbh5Q+OhyptuJ2aFYQIGvcqm8dWTBDk8Hvp2iEv64NjqA0q7JTtV837Grq63cOx/cSKqVqaxXNZiXatMLKZS4omoETG2BwzKUhMi02LZUMDgNntot0A6PyEttDxhywigwA87Ad9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ8S3BE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA08C4CEC3;
	Thu, 10 Oct 2024 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521475;
	bh=kfep0MapJuZXXEvFi9LDpNuX7DV9XX0GSk28ZL5GrIY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VQ8S3BE6icCvKrBdtqyckmBs06YTuNIvTzbzACDKKElL0r0UIKYnyX73SyfzoS9V/
	 nrQ2f4qco8moN07kAw/QhPCndZPh1bXRqMftRQquuw4bBULIH0s470Q6RpkCpj9h3r
	 fEEeJYnQVgJcZlYR9HVpLfPwITcbqFM0d4KfEfqBURPitSPremuRPWMs1Sv8evjBgD
	 Zjuq3JDi11PxazvMw1xe/hRWyQFqXBxfuDc6oCbx/7xSK66nDu3JZnDJWg66U3FCZ0
	 SbMZ7xLvMk0LbxEeEWUzZ8aP1zbbknLlwCbWcZOp0AgKDqCRAYtJkPZ4LE1rMYgYcb
	 8wPIezlAVsGaA==
Message-ID: <2d1f6b9011cde9b93fc6443f3c341abb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-3-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-3-hpausten@protonmail.com>
Subject: Re: [PATCH v2 2/6] clk: clocking-wizard: use newer clk_hw API
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 17:51:13 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:20)
> Utilise clock provider API with struct clk_hw instances instead of the
> consumer-side struct clk.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Applied to clk-next

