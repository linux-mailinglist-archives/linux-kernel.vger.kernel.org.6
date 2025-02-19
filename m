Return-Path: <linux-kernel+bounces-521640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B2A3C04E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE78A1750C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808E1E832E;
	Wed, 19 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CZD+BjSF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2281AA1DC;
	Wed, 19 Feb 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972454; cv=none; b=CVxrMW4Roix82cz4k15s+c3plO3hBwBmpv7PgA6rgClGOlGIpTojuZL9/N1C504HvIIsAeo9KAKbFKdGhNSZNeL9NUc/nRRUHI6cyc6Bmb0VgBPOTKGnopJGGwTPD6iIgxkjsx3PAz5+sCDoOCKVQoMnn0fiVl0QfR4CvBTV4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972454; c=relaxed/simple;
	bh=q8VAsnW/0ra4NwqP0nteF98m2Puu+tEfH8h+6E5FYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7bRAIAqSQDfMl8NculbGTTU8NEPdwxbVyTIKVVQN7EVpgOjimm9IjZZUP/fkBRMmaoxZWzIBKnToQYFBAn0QnexHvzbqMxa1MqVgwfAG6mLFPVzim9HtnIcSUNWU7xLZl1308Ze8YIKEyDmO4spdBjSefEtEuurbNVQA0oyFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CZD+BjSF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739972450;
	bh=q8VAsnW/0ra4NwqP0nteF98m2Puu+tEfH8h+6E5FYtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZD+BjSFARhosTN4Cz8MuhSpkYh6oZ90S89HvHqutF0aBde7dPYDykfCOrpOj9ihe
	 Red0CwOmQ80E+S5lPsRSo60cEId8Q3yOUaqVf/7EI7hAfMBzNA+fGIbQazw0N3nyEk
	 6s0hNHvozsAdEnLI57habzG4730BFxgvTUM0MOxEVSNWm020w0wkFQPOT/EDobNXbM
	 np8x7ms0FdX7BvzpdkuA3KI0hjAnnw37A6ha8NnLSJy15YC+L/RZBuLpvg5XTgIPzN
	 eV+YUHLJx3rTRsaWOQVsMMMMHE1djKhz8dG8ZJvJNfkCu1R3iBZAX68jVtmDAIkGe+
	 zNb9MKkGZNbMA==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2EBB417E14D5;
	Wed, 19 Feb 2025 14:40:45 +0100 (CET)
Date: Wed, 19 Feb 2025 10:40:43 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	parkeryang <Parker.Yang@mediatek.com>
Subject: Re: [PATCH 4/6] ASoC: mediatek: mt8188: Support DMIC in AFE
Message-ID: <51ac7a72-9113-46c6-98d8-2924a9572966@notapiano>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-4-6bc653da60f7@collabora.com>
 <6cd2be03-a3e8-4bdc-b91e-51b3e1029782@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cd2be03-a3e8-4bdc-b91e-51b3e1029782@collabora.com>

On Wed, Feb 19, 2025 at 12:29:13PM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> > From: parkeryang <Parker.Yang@mediatek.com>
> > 
> > Add the AFE routes that connect the DMIC (I004-I011) to the UL9 frontend
> > (O002-O009) and register the mt8188-dmic DAI driver during probe.
> > 
> > Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   sound/soc/mediatek/mt8188/Makefile            |  1 +
> >   sound/soc/mediatek/mt8188/mt8188-afe-common.h |  1 +
> >   sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 24 ++++++++++++++++++++++++
> >   3 files changed, 26 insertions(+)
> > 
> > diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
> > index 1178bce45c50ba252672a32b3877732a5a76c610..b9f3e4ad7b07ba9e21c846706371c53269f894db 100644
> > --- a/sound/soc/mediatek/mt8188/Makefile
> > +++ b/sound/soc/mediatek/mt8188/Makefile
> > @@ -6,6 +6,7 @@ snd-soc-mt8188-afe-y := \
> >   	mt8188-afe-pcm.o \
> >   	mt8188-audsys-clk.o \
> >   	mt8188-dai-adda.o \
> > +	mt8188-dai-dmic.o \
> >   	mt8188-dai-etdm.o \
> >   	mt8188-dai-pcm.o
> 
> The Makefile addition doesn't belong to this commit. Please fix.

I was divided between adding it here or in the previous commit that adds the
dmic driver. Only in this commit is the mt8188_dai_dmic_register() added, so
this is the first commit in which any of the code from the dmic driver is
actually used, hence why I added it here. But adding the makefile entry together
with the driver code, even if it's not used, makes sense too, so I'll move it
there.

Thanks,
Nícolas

