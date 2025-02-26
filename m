Return-Path: <linux-kernel+bounces-533969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD16A460EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A1A7A8D70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736A2206A4;
	Wed, 26 Feb 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B24RGItM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463E15E5AE;
	Wed, 26 Feb 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576613; cv=none; b=a3NtrU2OVVz20hKphXP+DnwdTgE+0NhHbNg9kmDChqqIYnHcXrK0md6gT6umzVzDTvUzIFCHLqGMwGOR/mtJ2FSgGdAgnoUGQF2HHp+RooSy+4s3ZZIFaOG2m0oUFPdR813eS9mXg2FraRJyiiCeax5csvcOG0aNd/Chbb23fyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576613; c=relaxed/simple;
	bh=sCJ6jojoxc5SezhVGVdeO6sZxq4gq9c05ziXwDfmpkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcZQ4oSsGL0wV9ohLSBER+TclzxlNd+r82gyctd/gNg6S6Md8mykJCtM5Tq6g3UdKVGajtyS2Ae6hHouoB/3Q/zIucG6bsu6jLTV1GGX0StKtQo/6rcmHfIqqU54amByBlqu+eAdgSXSx4kU8BdzPmzsZswLtWfBPLJRay5YXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B24RGItM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740576609;
	bh=sCJ6jojoxc5SezhVGVdeO6sZxq4gq9c05ziXwDfmpkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B24RGItMUUWDCFWd7lymvY6aJ7jX/Le5eCguhwra3Hjc/FnVrPoKrsceMDm0N5tw7
	 tsvF10smahGg4io7pJeXc6UcfoWhp78IA+OAJbzE0pzHhwG7bMDKWkm1Dm22+szeyi
	 cnGxha5uPB4hLJSHPJiS4C1tJPx43dkfsP9n0cLCBUhtP71P68LUf88l3998f8TFPe
	 Lxdgeq/lwoRc4L4q/JtOrnY655lYdR+xIky/IJ5KN10q/QjPjGT7F1NCGL2IacQCce
	 vUgtIR+LpTT9PjS/SDrAMIxstCaiG1Pah6P2LaD9g/XAIA3MoXHo9gUORhFNw4Hdjf
	 qO8qW0rZmaBIQ==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A072317E05C1;
	Wed, 26 Feb 2025 14:30:05 +0100 (CET)
Date: Wed, 26 Feb 2025 10:30:03 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Trevor Wu <trevor.wu@mediatek.com>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/8] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 DMIC backend to dai-link
Message-ID: <9240905b-29af-4ea7-8ff9-a0cb2233da72@notapiano>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>
 <20250226-ludicrous-seagull-of-music-a40daf@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226-ludicrous-seagull-of-music-a40daf@krzk-bin>

On Wed, Feb 26, 2025 at 09:22:29AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 11:33:53AM -0300, Nícolas F. R. A. Prado wrote:
> > MT8188 platforms also have DMIC DAIs, which were previously undescribed.
> > Add DMIC_BE as a possible backend for the dai-link property.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> > index 362e729b51b43ec16716aee70ad736420def81f3..8c77e7f68ad7b6f5b88b53cedccb291139a2eeea 100644
> > --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> > @@ -62,6 +62,7 @@ patternProperties:
> >              - PCM1_BE
> >              - DL_SRC_BE
> >              - UL_SRC_BE
> > +            - DMIC_BE
> 
> Any reason why you keep adding to the end of the lists but not
> alphabetically sorted? It's enum, so it's expected to be sorted which
> reduces conflicts between edits. Last commit already broke sorting :/

Well, I wasn't aware enums were supposed to be sorted. That doesn't seem to be
documented anywhere. In fact, in example-schema.yaml the enum is not sorted [1].
So it'd be great to update that example to follow that rule as well as
explicitly document it. Maybe even a dt-binding check that checks for this?
That'll make it much easier to learn about and follow this rule :).

I don't think it'd be worth it to send another patch just to fix sorting in
this case as it's already been merged, but I'll keep this in mind whenever I
send future dt-binding patches.

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/example-schema.yaml#n52

