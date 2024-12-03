Return-Path: <linux-kernel+bounces-428572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B79E10BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DF8281CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6C2C697;
	Tue,  3 Dec 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEQjX+2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286D10F2;
	Tue,  3 Dec 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188900; cv=none; b=brkRWQRVkuk7VgUvoxqhn+ZemRmn8sZzzI8QHfMp3C7GU9zne4RRlClCMh/ks8fdE+Ks00DhhmGTWRSPEx8Q5BvAL7JXs7cw+FMlaG0bHav08W+amYpyEmAICT7/S/1U789Su2DU9MH6cHy2Iba4N91Yydd8vPqxJ/w7q/opHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188900; c=relaxed/simple;
	bh=1FtcmpRoCr5SeSvMzJ5tPuM2IMPDeMBkNlHhN+GJq3E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Nch0Bj9bueUz7XNq0+4tIGqGLZ9dLYGQ3uYwOh/Ak8/z79OfTb4bZkGbZgkpyJ2FWX8CjWm0t9kU6KD/+S/cr0IaM3ccIETnsmPlcYDh9Hx3281dz9ZAMBlZcLOc9h7YvL3aCibgc+InbyW51HWgLGNuK2GdiUWF3CWXpiozDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEQjX+2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3314C4CED1;
	Tue,  3 Dec 2024 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733188900;
	bh=1FtcmpRoCr5SeSvMzJ5tPuM2IMPDeMBkNlHhN+GJq3E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uEQjX+2RiKj7QLe7Eb5g69v4+Q62pK9d3XnjgEl6erIsn9RLMy1T0NS3Kzc4Cw+Wy
	 +mXW5JtWKdRQtL+ZNvtybvLi6D8tYePKaE5uIncjeFShWvQJ+VRa9HbttSXJO1nSAZ
	 GxObU5VYYadbP4e4lCfqWt0KB19/5zKOmr4bmDBtz40qUrQnEfeG4zMuwcUYcSOlxl
	 pSNfWQy3wGmjTLv6sF6Pu4dFOsAIwC/C1IIq/aeE+zKjuUimKWP+Xzre9V/YfRtyi0
	 OtoNwSO0zywo63vKJ4/TYcJ7DkYvF0cqkrDWnp8+KxN6oUb+EeYRasm2UineJCFNhs
	 4hhmeJFT8kTQA==
Message-ID: <ff51b468ac71f9206d4ca8c6f345f38f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241128-clk-audio-fix-rst-missing-v2-1-cf437d1a73da@baylibre.com>
References: <20241128-clk-audio-fix-rst-missing-v2-1-cf437d1a73da@baylibre.com>
Subject: Re: [PATCH v2] clk: amlogic: axg-audio: revert reset implementation
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 02 Dec 2024 17:21:38 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2024-11-28 09:30:42)
> The audio subsystem of axg based platform is not probing anymore.
> This is due to the introduction of RESET_MESON_AUX and the config
> not being enabled with the default arm64 defconfig.
>=20
> This brought another discussion around proper decoupling between
> the clock and reset part. While this discussion gets sorted out,
> revert back to the initial implementation.
>=20
> This reverts
>  * commit 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency =
on RESET_MESON_AUX")
>  * commit 664988eb47dd ("clk: amlogic: axg-audio: use the auxiliary reset=
 driver")
>=20
> Both are reverted with single change to avoid creating more compilation
> problems.
>=20
> Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency on =
RESET_MESON_AUX")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-fixes

