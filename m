Return-Path: <linux-kernel+bounces-547590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CAA50B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800A16757B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA86193073;
	Wed,  5 Mar 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CazWhOYv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF625290E;
	Wed,  5 Mar 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202429; cv=none; b=W9hS9cx35csVoz3WACRHAn2l83dhBU0eczAXid24RIpely5mKbNlqouIkRaCgg4FaJ36BK9Qn7TfoPRjIh9IN4M0gnxfxI9VJGoq1Pzo6x26+K5EqwCqk5jl6vU1ZPyl93NgJR5Ewqaavk2R/ioSJ72LPeqEoSBsONRkDepAs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202429; c=relaxed/simple;
	bh=XOUlA2EIonuEnAi4OeuApJmrYbcpD0KJp5zdbmXvXnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8TI25h2VrE4TQhn+Ob6FIJjbmbf4AtGspVYlQE/rNFaYWvhGCYljnjpwcC0vTeYCYcpGurqAOJ4RG/kxHnro8RaQb5j+1P8JQ5D9LvRqhk8MtriFLNXW8E7C7T9Y4M6EvtFfEGato4O8y/xpVc06cQGoqY2mbBt20wRwWima9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CazWhOYv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741202425;
	bh=XOUlA2EIonuEnAi4OeuApJmrYbcpD0KJp5zdbmXvXnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CazWhOYvrHhnEtvF1PwYHRvH+OY8yDWzLiTcrqpBdSnKQy2p5DHPT8pTjSrNC7UhF
	 0i4KNQXoPBxsbW7yLzBokGm4JkX9UAjdcdQs0qJDBDnqQIQHF0aGuTAN9zKbnnJDUh
	 kcVDSi5SFoXsouHrHrO1/jc8q0IMFn/bE69yxBVwB/gxEqPB6THYrTlEhT+VoTKlYs
	 lHJJtaWGexREvQ9v47Ve68rqxapcnt9jtYAm2LdXO/HXOho7ezLYYqWfYWtdqA1MmX
	 HkS/QdCinOdDRqNFk/RWZraHcoRAKYq4oWXZcCdFi1MIvaUo25p/PanWrUL6ch98Nr
	 G0L3QTDMgXxqg==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C4D5E17E0649;
	Wed,  5 Mar 2025 20:20:21 +0100 (CET)
Date: Wed, 5 Mar 2025 16:20:19 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zoran Zhan <zoran.zhan@mediatek.com>
Subject: Re: [PATCH v2 3/3] ASoC: mediatek: mt8188-mt6359: Add accdet headset
 jack detect support
Message-ID: <f3666689-42e3-4fb6-b113-68efbbea450f@notapiano>
References: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
 <20250304-mt8188-accdet-v2-3-27f496c4aede@collabora.com>
 <59d0d382-1d15-46c4-b9e4-b66c32c188d3@collabora.com>
 <7661b71a-9d5a-46c4-9639-0fba1b118b52@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7661b71a-9d5a-46c4-9639-0fba1b118b52@sirena.org.uk>

On Wed, Mar 05, 2025 at 05:23:29PM +0000, Mark Brown wrote:
> On Wed, Mar 05, 2025 at 06:18:41PM +0100, AngeloGioacchino Del Regno wrote:
> 
> > Get to that mt6359-accdet.h header and:
> 
> > #if IS_ENABLED(CONFIG_SND_SOC_MT6359_ACCDET)
> 
> > function signatures
> 
> > #else
> 
> > static .... { return -EINVAL; (or whatever else) }
> 
> > #endif
> > 
> 
> It should probably be return 0 for the registration/unregistration
> functions so the caller doesn't fail if it checks the return code when
> the accessory detection is configured out.

Actually, given this function will only be called on platforms where the
accessory detection is present, I agree with Angelo that we should return an
error (and print the error message), so the user can easily figure out that the
accdet initialization failed due to the missing config.

Thanks,
Nícolas

