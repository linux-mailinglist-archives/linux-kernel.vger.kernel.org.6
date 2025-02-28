Return-Path: <linux-kernel+bounces-539516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41DA4A56A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA403B39F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864B81DE2BD;
	Fri, 28 Feb 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk7Tj5YH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DB1D9A50;
	Fri, 28 Feb 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779595; cv=none; b=Gdu39eJm7MNDCc6AlPJQ2247tc+Tx8QdQKD5ScF3TndHOMO+7eycaKD75vhJcUl1yZYxiVFnudPtSnPoN+eojS06PjY3F3rYj2k8XEq9htEVIhdvzmiTqIV6qIHBIjYsTNDDgJJ4YKo48tO52Ket5bEa5RbZh0BmQASaDV2Bwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779595; c=relaxed/simple;
	bh=vYi1mGiS+7/01/+oN5mP+NkIR8gD/X3Dati9GNTQoD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orEXKOvy7dfQA+DuoQi2iLei5u3i7WH6rdEQVXG3ESGHcnzztwP2qSbmTbDoabVbwYbwnliwKSthgD/r2WgQwIqA7zHG5JkbUeeAGOPitBpGXyvYe76r/Gu1zoK/3ndCitaTTA9FB9vvh/BKeuUrjMADz2K8oDEeQj0MZzfpFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk7Tj5YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B09C4CED6;
	Fri, 28 Feb 2025 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740779594;
	bh=vYi1mGiS+7/01/+oN5mP+NkIR8gD/X3Dati9GNTQoD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kk7Tj5YHRqU292yTupv6Yb4e0vYzpQ6QXvvbuAFptKjGEmtQmVgMXr4NXPH9ZOgvk
	 xaRQPaKPUjidd2+KbC1kFymDR90knzNoSxlwzZqgbHbNMKQeZIE8MIYQaSlbZlpyBh
	 GDhu1YpLU/INurNIqvDGiernot51ozXh4WsUqdGNFwQI9BMedpXVnlo51QXeSVR1lr
	 h6o2BH4tfYuOUPy/X/zZYLEMKn5mRG8W1elJxgyrl3fCxDukNQE5aH3buGxe0+Wtr/
	 oJsbgjvQDZqHW4YaAgYHWsaiYKXBazgOYZ7eS0LmF3jOa4f02KgHZB6Z6njIZ6BtQ9
	 S907/hx+MssFw==
Date: Fri, 28 Feb 2025 15:53:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: jian.xu@amlogic.com, Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
	linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	shuai.li@amlogic.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	zhe.wang@amlogic.com
Subject: Re: [PATCH v3 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
Message-ID: <174077959192.3759834.11760233362510893380.robh@kernel.org>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
 <20250228-audio_drvier-v3-2-dbfd30507e4c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-audio_drvier-v3-2-dbfd30507e4c@amlogic.com>


On Fri, 28 Feb 2025 16:04:10 +0800, jiebing chen wrote:
> Add clock IDs for the mclk pads found on s4 SoCs
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


