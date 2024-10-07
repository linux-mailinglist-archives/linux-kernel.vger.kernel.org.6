Return-Path: <linux-kernel+bounces-353934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521EF9934B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1803C281D24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C621DD54A;
	Mon,  7 Oct 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PcpK827L"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619481DB546;
	Mon,  7 Oct 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321512; cv=none; b=IQ9Lcd7jO+QJ4Wc5qGLERSck0ClZwoKPL0OLAaPIegkI/Um784GTgVtjzPufF7hCnhORst3XmfPdkV1FNjsbQCOhCRT9Lktk38WnOihEkW2nWBUIFNZ1sN9fm/FVKWqoF00HO1ft7STtyrKFKNfwIOz4rxOB/tY7aSrqee005Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321512; c=relaxed/simple;
	bh=3LTfuYu4ptTly0D1CFUPRibsKkUxyUcKs8NYOTFP0rI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWN7EDpnTWyZuT939Kf2mVvhCUZnIYLXpqrRRMp6x/KUaJxF87NwQZnOqqdNbAo3ydUiQruRWKy+v5WoeRTdzA0HuaRwKT2fr6+3LxKMDhOXowy95/wKeaPUlCAudBLo8L2Q9TQ3TIahst7pyhYsvfAhT1nZ4tOMnebqge0o14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PcpK827L; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7CD7A42B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321510; bh=hTbYvMb5tsOMwHIvNP75oAkkBAxDjbl5tpz5FI0uoao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PcpK827LXbljCvRrtxo/YFpiG2+smBE9A0zL0H5alTUYXd793HZuZclsmUraUExtn
	 YJ1Rscr0agWY8voEngovTM8f3bmUUziMfBZCp+ZQytTcDBUsO64i30I2Lc7EapRGbx
	 h5BXMzomm5cvwHlJSBIC0ExUNQfJD2REkTR02JgJvDCJ6YLLZLsi6jU+Xk30kUTFbl
	 CW9u3Dlj5uF1Gxy8OdNHB5KHrYI+uIVwoVVeBlkhylEdulmhgpMAqAAQ10f2TSdqz0
	 kHSS74EeZUITZRkjF0invso2Bn0UOgS4cQ0LGOwp+8UAOiI3z4Vd4UO+VUpkGgF1pA
	 MAWS5i9nLCi6Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7CD7A42B38;
	Mon,  7 Oct 2024 17:18:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org,
 linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linus Walleij
 <linus.walleij@linaro.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Will Deacon <will@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Conor Dooley <conor@kernel.org>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Documentation/process: maintainer-soc: clarify
 submitting patches
In-Reply-To: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
References: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 07 Oct 2024 11:18:29 -0600
Message-ID: <87wmijj0gq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Patches for SoCs are expected to be picked up by SoC submaintainers.
> The main SoC maintainers should be addressed only in few cases.
>
> Rewrite the section about maintainer handling to document above
> expectation.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Heiko St=C3=BCbner <heiko@sntech.de>
>
> ---
>
> During our LPC ad-hoc BoF, we discussed improving Maintainer SoC docs
> and I think I volunteered to write something.  The trouble is that
> whatever I won't write in my notes, escapes my memory.
>
> I believe this is what we discussed.  Was there anything more to
> write/document?
>
> Changes in v2:
> 1. Fix missing closing ) (Conor).
> 2. Style changes (in point 3.).
> 3. Soften note that soc@kernel is not for discussing ("is usually not").
> ---
>  Documentation/process/maintainer-soc.rst | 42 +++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 5 deletions(-)

Applied, thanks.

jon

