Return-Path: <linux-kernel+bounces-287373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904B952719
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C1BB219D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5A8F6D;
	Thu, 15 Aug 2024 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeVmL6NQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3079EA;
	Thu, 15 Aug 2024 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682267; cv=none; b=pF1RxIQgty6Lo8fjzsk9kKwASuzDEyfcwlhAwGb6eTo6cAf807jTLQJGsTaoTxmJ2Iu9+orwAagvnEOWQ2ZJk7xBL/skVbUV8x9BEArxs8dYaGD2I9hhuIbRj7BT1+LIMlDdZ4lxqADl/ldZxBR5aw+h5aFod3R9F7v/jHF//9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682267; c=relaxed/simple;
	bh=FbEpakbgWICNk3nlJqbA6FXCmf5YNZkwBBFvrfU3gjU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=r2Y1Q0fn5NfbTX5RL1C7FXBTes3ZTCoT0Q/i1bvvn3Kl+68MVAtXrR0exf51/GUxcaL6qsx59NWhBAGpc3zEfQopbmG0jx/04xf6uXpOMzuLCw91c9Ic/1ylMaI53ls8qdKxnQTR1mLCBUMAU+7h8/aZSXRPqPnCSKgajbBR8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeVmL6NQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76875C116B1;
	Thu, 15 Aug 2024 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723682266;
	bh=FbEpakbgWICNk3nlJqbA6FXCmf5YNZkwBBFvrfU3gjU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IeVmL6NQ1sbHO8eUyQJo4WzDCEhfuFIWxiW11fX6YltzXfSwGqeLs1GLHHZLhGPWu
	 s9h75ru1anHWRQcsnFj/y7BSKed+CJ4ZQ/wtfQ2hK76/ElMV8dwpdhmNLtUsgeEb0v
	 wSbWn+PXETN43G2iOa5KqNK3LdARHGoU1wOE1FEG2gXSRZByRD11mezG52pVwpGIoD
	 GMcWmQErDisc60b5jvEGxOZG6RUfHt4g0abHorCSG3KJyDz+fyqLtKAiCoGSU4rQ/9
	 RNh5xyLBNs6EQuORo8hkBeq7Mueng205b7r8LZvl2g0DJXhEU34ol9tlS5kb0KA+VX
	 V3h01VNnsSKbg==
Message-ID: <5b8ba4227b22fbefc433569378b2ae21.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240814125513.2637955-3-andriy.shevchenko@linux.intel.com>
References: <20240814125513.2637955-1-andriy.shevchenko@linux.intel.com> <20240814125513.2637955-3-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] clk: visconti: Switch to use kmemdup_array()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Aug 2024 17:37:44 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-14 05:54:08)
> Let the kmemdup_array() take care about multiplication and possible
> overflows.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next

