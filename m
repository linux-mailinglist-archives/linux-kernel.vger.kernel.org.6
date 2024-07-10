Return-Path: <linux-kernel+bounces-248200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C1F92D9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF7E281565
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962319645C;
	Wed, 10 Jul 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN+HfXmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37224F1E2;
	Wed, 10 Jul 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642220; cv=none; b=ow64soHv9le3VoTk+zwyeP8dIKVGzG64vZ0dtjO1BYtuvw+Lm1MjUAOCNRUSMD/W8tg+X0p8V+xPWXbnueHQHD6bfpYjxHIXjMbxB0iQFlysOSeshqRxJVGZyhVhi9DeczdXKXcEJfPWjBwSCdcGxt/nDYDvdD38qFMlF7rpz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642220; c=relaxed/simple;
	bh=NuLz00tkf3SjENprZs+z8snoT9qZ0lvFffA3GNVNCmw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Cu7uhHrJMVrHE/QkemAqbhhQ8SGpqcbxTZLqbP/N3pV0z86UEVjiS1sNlQvw0nGcczS79r85fmue5lpwcuSuL8NShfV6HR382VCJpIC5y+dEPxZLO3zrp0d4QyNsMQiT89YOxOXfPC6DyJ3ZD2NSc1iiPjCQPD9zalRddOk//C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN+HfXmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B1C32781;
	Wed, 10 Jul 2024 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720642220;
	bh=NuLz00tkf3SjENprZs+z8snoT9qZ0lvFffA3GNVNCmw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fN+HfXmSNrBUBuCj8nDVdJIEIj5HsmzBSyU9aRutuxDBEtjozhjrUGUQ4SXUW4Mz6
	 ze3ozIP0JjzSdHUwoEb0+26O0HsogkXPksYRYwyKB/QsPvv3Rg/0h8Dhu7LHpmRE3S
	 kYXQB6JXxoMV63Vhw3Yr+J7K8EkrCuM+IBk0WAML7RQQ6Cxr/6gVis/q4VaBjZ7H40
	 4e76SP/v4jbMcfWl+KPgBda9RdVNhXIsSKS5JQsgbJFsVZ7Mn/uJb3JSC4ZTizPDFq
	 ZxBR0Lslm0dLrxnJBZtOeKyOMWXG8YzwQtBkr6/RbIZHuFR3f5FMG6Op8xjWPaz3F2
	 kBQ2+0XW47tVg==
Message-ID: <91481f2aecc639ef7ddecf5afe3458b1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710143309.706135-2-thorsten.blum@toblux.com>
References: <20240710143309.706135-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH] clk: mxs: Use clamp() in clk_ref_round_rate() and clk_ref_set_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, festevam@gmail.com, kernel@pengutronix.de, mturquette@baylibre.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date: Wed, 10 Jul 2024 13:10:17 -0700
User-Agent: alot/0.10

Quoting Thorsten Blum (2024-07-10 07:33:10)
> Use clamp() instead of duplicating its implementation.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

Applied to clk-next

