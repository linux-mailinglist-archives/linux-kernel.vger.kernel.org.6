Return-Path: <linux-kernel+bounces-545498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF8A4EDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A75188FF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB025F78A;
	Tue,  4 Mar 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIkd9Ij2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B982201110;
	Tue,  4 Mar 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117838; cv=none; b=PH1FVjcjwPRX3tqBKTYIQpGwWTjBLvAYf4L1tQU5juWw6xZejTIXT/BzxIEVvui7TspGz1u3NUqroFzFw7kcezTPnvYYO9Y1OaJ6/aMa9JCqCpGaZMbzBKnCmyn/gAb7rIup7wPmQr1e7bYN0ibfWYX42HEifOrAAMLGIyY5FDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117838; c=relaxed/simple;
	bh=fwSFelqnv16O3Z5CfuJeHvjUeDPCoeSC6mIkfvyX/co=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pd9uJyG/99g2mhH9+WtcGUOgShb9rhBk2JO3aWom+b+9jSkxPAHQ4GW8izzsgtE/oQB8rigjsOh8mc+9CXZ/5TpsGxvpV+P/PiuER7czQ5EpTo5Awr+oNuxZDvfbnXDK1RoJlXSQKeBjnN5Gu1g+qPVcD7NscNpd3fsD2aE74Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIkd9Ij2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEEDC4CEE5;
	Tue,  4 Mar 2025 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741117837;
	bh=fwSFelqnv16O3Z5CfuJeHvjUeDPCoeSC6mIkfvyX/co=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HIkd9Ij2H85qYKpF0MGi3HY94MySHtt+hjxDsSYKSNYnV+0uG1M8K0JtFT34w91f8
	 ZFlFXdeybOfg2N1SYlxOjz11OAUt5MIQllkzSmR/Qu9F6uq72JMkouYukJpLbB/K06
	 KGU1xzb0hHmjiLAYATZTbeIVuZEBPR+hBpS7YpZkx5+u/UHgZtrcV81FAW4/3YjKug
	 vSIs0f70ziIk/CBnoc8OprIJaVCrAC1v31vrOE3Iaef7wWNVfAGzWZSS53EFfeWjjF
	 Q3hUZ8iFAu+Ya9G+w1TrqASpOCbcfpVJket5PMDdGiGoV/6Y3LlTi4Pf4sgyRQykP5
	 D1fudmyYA+Oyw==
Message-ID: <2e9b95d5ac648daf07101cc0da77d20a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250124111711.1051436-1-dario.binacchi@amarulasolutions.com>
References: <20250124111711.1051436-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] clk: stm32f4: fix an uninitialized variable
From: Stephen Boyd <sboyd@kernel.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Dan Carpenter <dan.carpenter@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2025 11:50:35 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dario Binacchi (2025-01-24 03:16:54)
> The variable s, used by pr_debug() to print the mnemonic of the modulation
> depth in use, was not initialized. Fix the output by addressing the corre=
ct
> mnemonic.
>=20
> Fixes: 65b3516dbe50 ("clk: stm32f4: support spread spectrum clock generat=
ion")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20
> ---

Applied to clk-next

