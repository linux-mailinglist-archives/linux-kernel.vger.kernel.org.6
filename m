Return-Path: <linux-kernel+bounces-332800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2097BEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410651C20F62
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7A1C9857;
	Wed, 18 Sep 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUPaBZlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555771BC062;
	Wed, 18 Sep 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675636; cv=none; b=aV/ODvapfJ/rXj/QA1SpoyGMPr6r1g9K6OHlJ+1WUzDlFx3SrcoEywYC8IH3fENrnUlVBtC6R8uuwHkTm2h7y96N9eN1ytgkbGKvXdzJdX5TxR/Tx4DwpLrMf8GMPcPgdiu8EPn6bm7Kr7PalxuqjJFf2RJyvIB22RS1QDMlD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675636; c=relaxed/simple;
	bh=f4GGnRdF68L6ryhZKCljE5mNtRsT0dHV0PkgUPjTeKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSMtHNjHdIWzVwuW9JEZ4ikh+bJjo2VVzl35p4NSntRSlrmbctRsVeoh2SPt2k/U7JFbdAgkMbhqaloTPcGnLBCLRmN08MAlkj8iwa9Qm0Z89+1qXmkaW1VgH7sotTBcX7+JNhH/6rAB0znxKhIy1eQt/e4h3tDVTIfagUBZjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUPaBZlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D3EC4CEC2;
	Wed, 18 Sep 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726675635;
	bh=f4GGnRdF68L6ryhZKCljE5mNtRsT0dHV0PkgUPjTeKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUPaBZlYelVyq062EpMOR/O+y5WvAqc4z3lBeIzk++rw2Zl+IHBKFCRgMr2ZM0sTc
	 N41H1jXm9TiNGkwx28MXN2Zcmcxx5a3XqDrbEdRtWLfcUnBnAHeo3G1NXq5WiAsk3x
	 kUzgWF1yDXcU17Pe5tG5TykRtLxpLKZl9Ctcnij1gcwE0Ego9RlPJwPqFlYOGzo/Dw
	 a68AU2N8Ijyqgb569P1H7uQby9WSHP/+EQurUqVtZ3SrpW/urjkEQ0uEqVERnDuuk9
	 gLqXWFhHB7K0SgeWz+YR+uDutsw6IC/Hws+5VYzC/tQTzaUuFvkDW7PxEBPBDzdYHJ
	 lKIenJK1NpZLg==
Date: Wed, 18 Sep 2024 11:07:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: add Amlogic A5 SCMI clock
 controller support
Message-ID: <172667563318.1699620.6883728767588499798.robh@kernel.org>
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-2-5ee2c4f1b08c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914-a5-clk-v1-2-5ee2c4f1b08c@amlogic.com>


On Sat, 14 Sep 2024 13:25:24 +0800, Xianwei Zhao wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> Add the SCMI clock controller dt-bindings for Amlogic A5 SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  include/dt-bindings/clock/amlogic,a5-scmi-clkc.h | 37 ++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


