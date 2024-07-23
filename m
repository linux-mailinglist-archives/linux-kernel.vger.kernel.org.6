Return-Path: <linux-kernel+bounces-260461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310393A99C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546F3283FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBB1494DE;
	Tue, 23 Jul 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXI5sp8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281825760;
	Tue, 23 Jul 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776066; cv=none; b=kLGMAY/c/SpL+x9XqoeNNYFvj7NaQ+hpR/d1rCVVWbtoUzIKOuYPybMtt14fMJPPzj2+lOb9S4ll8ZNMLwjoQOpsly9eZZ3DAqXcXyt949kTSIsm+3IVBVU/RQIAW4Gm/FcK3k7g9mqtTFbuXGwt4F5kDcr2CGdrdeMATbZb4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776066; c=relaxed/simple;
	bh=6M6lq895qViNTaq2hr+hE7JvW7KylM/aNiwI4bdXPmk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nkgs7cpCIqPFvfJhfFahur/mCOpy24xxgRLd2CXZpVaJRwQk7dCOxS8rv6QXy/LU+eIqoOVAZmTkicE1E3qUrMYBWKDsHtbE7ti2olQx1KEW8+XwG883zfEPs0E61c3/hWvmFkM/+MJ+dZ0Ax7jD+hbZ6fZ+Nr5z9rsyqxbnN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXI5sp8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D65C4AF0A;
	Tue, 23 Jul 2024 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721776066;
	bh=6M6lq895qViNTaq2hr+hE7JvW7KylM/aNiwI4bdXPmk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FXI5sp8yD2uoaoCiBt1y/lhRL3BwcFJiofYdXLMdybyVQCV5TPtVVlwhvAukbssvW
	 U+URViJ2RNAjWXL66bZq/7+BgKwAIQuSmGv8kTnCuaqqAMQbJcUW8jqWIGMuMN1x2N
	 D++ZcFZ/dojR7PDPqXhInYU5tCw5fstcXrZuU/znHphcwi+FdsWLt1EKRHBvY9Gq08
	 UIL23MxMKXH+bEwqUzT/iL45CrfzU0pETNZMCDlVWebeanSFQzFVmcSs8JbCck2su0
	 xYPsRVDxG7NwLZXb7xgSm4+j1d5Pa8EWIXMVO/aS0CF1mfv9gME8FxS4aeeiqHwuig
	 ceZQ412yq2w5Q==
Message-ID: <0f2f98af8fc66ad24180a362ce99c6fc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240720120048.36758-2-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com> <20240720120048.36758-2-hpausten@protonmail.com>
Subject: Re: [PATCH 1/7] clk: clocking-wizard: simplify probe/remove with devres helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Tue, 23 Jul 2024 16:07:43 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-07-20 05:01:29)
> Remove need to do various operations in remove callback and error paths
> by utilising device managed versions of clock and notifier APIs.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

