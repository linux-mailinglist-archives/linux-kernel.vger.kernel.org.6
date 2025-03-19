Return-Path: <linux-kernel+bounces-567481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF48A686A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9995616C8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C02512CE;
	Wed, 19 Mar 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLmL4vXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F924E4C6;
	Wed, 19 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372537; cv=none; b=UDrDSndfFgyNxX/J77gJmM4zqly7kKyoeNxgURQKherE8CPnVVGnMSLdxu7khjWGrkprhym0T9fUJCmGFXyR+Qj754yjXoZvZxy4FsbBh6AdKsqxSPD4wm8pheJ7XXg7PnnKCInPzowHsZyJUOWmNY2PvLtXvWfqlOdTs/pEqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372537; c=relaxed/simple;
	bh=qHottCH/UKxNQxJoU8i1IYC7DAOUxp3drrxyBkl7KQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhEsynGyscb6Sg5KCRjZdqe7vUhiQLn4PC5MgCeoQxP6OUG36MLHDfj3OkQeLuW8kbZ150IOiblm1CneFpXDhjd2mqlxuslucJxu7TAEgpYfJZwti4wqUXOOiQ9/h+VR35sV9AFmm6Lb+5g1mXqsNFmszkNeIN+0DeOb2tCnSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLmL4vXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3E5C4CEE9;
	Wed, 19 Mar 2025 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372537;
	bh=qHottCH/UKxNQxJoU8i1IYC7DAOUxp3drrxyBkl7KQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLmL4vXNYRImbsRHdoXOTASyKXTCLYTmZU1XVmzyNSJ/5wXrqRTeLkUHdN0h8FOwb
	 wseediqt69jln1jyt6z2irAxoQHTRp9haUAPDfdqmRXzKrOe7vB2hR+eJevPfpLKfM
	 My0Ch6CFLjFbQ9TjfqAvhegyUVtzNytaZUXKN9MF5PrQoV35Y4yMBSYAsmzEpLIaHe
	 PKyKTYWfgjGbt7fUJCMZpP/4DeK8zH2HYZeEk3zGb/0E37UoisK09++33ln2+rqyPF
	 10ZDQTzFz5K9uA6YVd/leQFkyaOnrvDdL1kVR8/nv1do1eJV7U39mRfZSe7RTdGWDW
	 AukSgF2M/fLxg==
Date: Wed, 19 Mar 2025 09:22:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, jian.xu@amlogic.com, 
	shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v4 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
Message-ID: <20250319-daffy-classy-kangaroo-023e1f@krzk-bin>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-2-686867fad719@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-audio_drvier-v4-2-686867fad719@amlogic.com>

On Wed, Mar 19, 2025 at 03:04:45PM +0800, jiebing chen wrote:
> Add clock IDs for the mclk pads found on s4 SoCs
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++

This belongs to the binding patch, usually.

Anyway - do not ask us to do the work twice.

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


