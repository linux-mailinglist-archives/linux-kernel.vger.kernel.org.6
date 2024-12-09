Return-Path: <linux-kernel+bounces-437111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F39E8F40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668BA1886B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB8217727;
	Mon,  9 Dec 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHgxnPPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AF217707;
	Mon,  9 Dec 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737856; cv=none; b=W8LxHxdHzoo5afCuV+QmszC1TBd0Eot8y+bVSeT8Rulwaku/J0xTfQ7mzmHQOuYcRAiHNeM4QiqBXDV9q+wVA7JsVw+A31E+lLQq0DI5M3NpDW2J8r4mSoe0GspdkGZUgNT7tpXRopj2PxuPWx45rezPZJjAH/ZrCkBTSOVU/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737856; c=relaxed/simple;
	bh=zlE6YzHqonNnZTzFpaPhYq8EhMnagDX5FxmFg80dswc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt0afJ7YLZuuF6NwW0U3aUR2HOaIwxk7r8ZFU3Qp/hnZdlSB/cuV+dHWBMcaB5YD166FYClkmIPXxuKcRB8Z8Fiq4RtzEbvPL4KzyGiSGusQSsi8JFITglX4949ODoZLXYAaXfv60qie/M++cI1VQuDh+ek/DhqEHYI2xDfvIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHgxnPPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D0C4CEE0;
	Mon,  9 Dec 2024 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737855;
	bh=zlE6YzHqonNnZTzFpaPhYq8EhMnagDX5FxmFg80dswc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHgxnPPtMCg+g/wB3jTZ2IQptQs7eux5/16ywS+TCnDJNg06oPKJ2WOIq8DCypeLB
	 TAYTmtMHn6VIbxA3/Pv0BFgA9Kuxjy59Yj3sP9W5ARjklVZnyIEF5fYHBdsO15X+z4
	 AjGc4L0XwTCWB4kYDGsLPhUP9ZrjA8xxt3XJNNRJCuxIorH1wi0w4k2ay1IwPhwDFt
	 gz/V8EbGoRGYKr6bav96DPbhXfm+eunbHeBkDONHY4P/Gop8HpnTGCrdeGhIBvzBjZ
	 50IMSxgEf1WngQScqBYXkw6Ep5z1er4CIAPO76NIDJd5ReQcvV67YmsK8eiit4SkBF
	 +5MLF16AKRYkw==
Date: Mon, 9 Dec 2024 10:50:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DSP
 properties
Message-ID: <264jrfp646x4clus6yanbldqkfz6eao3wdveyokxkcbpqufopo@gpr4qacexemp>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-3-0e955c78c29e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241205-genio700-audio-output-v1-3-0e955c78c29e@collabora.com>

On Thu, Dec 05, 2024 at 09:13:56AM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> Add the mediatek,adsp and mediatek,dai-link properties to allow
> describing the DSP configuration in the sound card node, as is already
> the case for other MediaTek SoCs.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml      | 10 ++++=
++++++
>  1 file changed, 10 insertions(+)
>=20

This looks like conflicting (or applied) work.

Best regards,
Krzysztof


