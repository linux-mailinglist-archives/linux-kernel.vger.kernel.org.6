Return-Path: <linux-kernel+bounces-244788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092392A98E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CF71C21328
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD214C582;
	Mon,  8 Jul 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0V6jff8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1814B952;
	Mon,  8 Jul 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465549; cv=none; b=cLPuU3FKwo6ta5n9mt+ANDMq5Gdt20T5byanyd/9bDGTbng5X8rNICieSQRf0TLjLh0AAWJClN3kn0EB5Tf50AxrdaVUPK/dPLlnaA2Ysfd0xSLMtRBfAdwvWMowXfMrSyaqh/+tcLr5Cf7J+jEmpxdnP1iKiLTKjVMhwAsFBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465549; c=relaxed/simple;
	bh=mZ0UcWrET9TN2UFV+2vHkASsXRUgEGjwDnmMrlrBnSQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Joy70k2D/fbx99UM32Rx6Svrqo6p/N//hIXWwrkMYrts+WBCR4u1QzkPjDF5GGN9OzNQzZYr7cusE9TxvgyNI4Oi0uLGxNsiyq9jU7opFqM5HU+cxP4cObWfcNJmzCcG1asQTRBoGypyiaqdd26WVuC3OpfQmvJYR/ifonmsSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0V6jff8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105A7C116B1;
	Mon,  8 Jul 2024 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720465549;
	bh=mZ0UcWrET9TN2UFV+2vHkASsXRUgEGjwDnmMrlrBnSQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U0V6jff8dEHzKrQ+nlQSGnWEnWk3mQuDwXWt8hIBbx22u3fuQvKIp7dThZkLEVsLq
	 ErjHD1yF+JtPoc+o6UQHRu6v+nZWHhg+JhvEGpuKeCVs0pXjE8onTsglqSHFbSEKRR
	 9BhtrAr9dbd0oH9Lxz9KU8t9XsZjB1eK1LvtzGY7FnUmZ9GrO38pKhhSArcgdk06TX
	 baIQLTT/mwcufERMOCNpC4J/vtuvUhrcN+GVI/jMvFGT9qWyDt8YWHz7datmuhb56U
	 BcI+WVADgq7ZegBhMXWZZbsWu7GJNutTspywHWx4RT42b4d3jndOVK8GerI7XI2ENi
	 y1nE64c3RRjQw==
Message-ID: <9b455698a33ec5d01c12424ea67c8e88.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240612201211.91683-1-alpernebiyasak@gmail.com>
References: <20240612201211.91683-1-alpernebiyasak@gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] clk: mediatek: mt8173-infracfg: Handle unallocated infracfg when module
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org, Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org
Date: Mon, 08 Jul 2024 12:05:46 -0700
User-Agent: alot/0.10

Quoting Alper Nebi Yasak (2024-06-12 13:11:00)
> The MT8173 infracfg clock driver does initialization in two steps, via a
> CLK_OF_DECLARE_DRIVER declaration. However its early init function
> doesn't get to run when it's built as a module, presumably since it's
> not loaded by the time it would have been called by of_clk_init(). This
> causes its second-step probe() to return -ENOMEM when trying to register
> clocks, as the necessary clock_data struct isn't initialized by the
> first step.
>=20
> MT2701 and MT6797 clock drivers also use this mechanism, but they try to
> allocate the necessary clock_data structure if missing in the second
> step. Mimic that for the MT8173 infracfg clock as well to make it work
> as a module.
>=20
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---

Applied to clk-next

