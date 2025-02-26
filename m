Return-Path: <linux-kernel+bounces-533299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1454A45803
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C03AA4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228A226CE9;
	Wed, 26 Feb 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxsG1Gal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15256224252;
	Wed, 26 Feb 2025 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558153; cv=none; b=K5hY5jUVaszjmhqVmk80gMUVETOPUSCwNhYYcVOwPhtm0PdCDk+ekXIVSs+GCgGIcBOlJz/pnsvvxnDWVEZRc1BBV9UDLBaoviX6Pae7RQGa5dcPOwTWNSMf4t/vJ1qKzNdyp86gsGxp7aaXrD2m2plMQb6tqovkUrBTyBr03sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558153; c=relaxed/simple;
	bh=IXeKLcSbvMcqBKVSn5skB9BHbi03YvYAsNDK395OQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKhu/tBL570DMJP9G0+SM8+GeghSs0qKqAJfl/Fesp96DNaoWYJKzaJogt0M393ZDoJVw+jzDsGCl0nDOYwtXhrR5Hqpgr3ByML3nuWBtH5F0pdD+fbl5tICOK6Gn5UcpEZSTT74PGS60QhLDWGH+tO0HoALvovAw4YCo3lYT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxsG1Gal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139FC4CEE2;
	Wed, 26 Feb 2025 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558152;
	bh=IXeKLcSbvMcqBKVSn5skB9BHbi03YvYAsNDK395OQeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxsG1GalGapRIo6NCASGUf8kylYzD0wwQr0usYQ94FO6Mer+N72etp5FxXFhrHc/u
	 oOtAiN+gwcPkGrmvwDb7MrwMnru4CAdpFxwnNZVvDcv/qY+kCoOUUQIPfUB1rTl7DT
	 ieCtXXtGP9V4G19Cppkox0qKZf3F4BiNGfeQhfauGUfR4R4eHVEMIs63jLf++/j++A
	 +xjRXrTb6koJPIOd2ApJnenewnAuzIErygRes7ND5H2C3/7M/4CbQf97neRrLgh5/n
	 g1+5GhWgasjDuIMUxqpOqfdAOQWJdbTHdsW3SjZH4YHSpW4/2nobxuXO7sy0CX7b1V
	 o0uvDJI74WH3g==
Date: Wed, 26 Feb 2025 09:22:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Trevor Wu <trevor.wu@mediatek.com>, kernel@collabora.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/8] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 DMIC backend to dai-link
Message-ID: <20250226-ludicrous-seagull-of-music-a40daf@krzk-bin>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>

On Tue, Feb 25, 2025 at 11:33:53AM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> MT8188 platforms also have DMIC DAIs, which were previously undescribed.
> Add DMIC_BE as a possible backend for the dai-link property.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt63=
59.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.ya=
ml
> index 362e729b51b43ec16716aee70ad736420def81f3..8c77e7f68ad7b6f5b88b53ced=
ccb291139a2eeea 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -62,6 +62,7 @@ patternProperties:
>              - PCM1_BE
>              - DL_SRC_BE
>              - UL_SRC_BE
> +            - DMIC_BE

Any reason why you keep adding to the end of the lists but not
alphabetically sorted? It's enum, so it's expected to be sorted which
reduces conflicts between edits. Last commit already broke sorting :/

Best regards,
Krzysztof


