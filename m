Return-Path: <linux-kernel+bounces-526596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5024A400BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585483B77C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5282253B5D;
	Fri, 21 Feb 2025 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsLfve8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DD253358;
	Fri, 21 Feb 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169478; cv=none; b=uvdhm895TjRyZ6uE9mLj8y1F6SXpUOFwg9UkvWWWKs5tl5Z3iNhusWV5lFVCo2XD1LcpdY8pI2jhsjS4q45khLbb1MFbjBbAOYlxJE7OyhSzKUsTt34oNJGOLzLX1XgOSxD1KvY/5V8bpFaQ6dMiK4tM5++LiGzY6TbvY2ZV6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169478; c=relaxed/simple;
	bh=mBxOob9mR9l0oBnEHnalaehXgK5zljRRPtdejwjytTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA41tvExsfnBegD0CrWg9qEhuGM7hXhZFq+0KhqYD6HtE3k7M+byUbjNGyLNzYq/623Dwl20AmVnRqlp2ytqTY68LZv6VlaRI91jwtsxXBQHkqtk9nTvWwHsqLCFk1G9oC7mMT0vND7V/mUF9g2+g+jI/tams/r6B0ayuiO0tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsLfve8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD3C4CED6;
	Fri, 21 Feb 2025 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169477;
	bh=mBxOob9mR9l0oBnEHnalaehXgK5zljRRPtdejwjytTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsLfve8UhiJdIdS7O/I4w2L9xjbFX0/6hNAk1uZEDS6mMBTEKyC+W/vroPDxIYwWL
	 ZFdMgFV3HA6gwJDD0ZrR1Wbedb0dMXIVGivmiHKYgVIj8J683EEkeUB+jUnLXuFCMw
	 DwUqYeTbi7DfUdo1TErzfzy2qffpXB/YNeVrdMtvaRlsTOdupQ74A/FLpV1uC7Z08j
	 ZXj5GqRSlWgoZK3j+n77/CznraznV4auFXe88siGFwGqo7WWyLndWJubrT7nRUChhk
	 /8b2ueOCmfIOvyWeO6vDKRsjjTTUmgi2c1/JYP80cHEI6ULW6Mf9FC0o8yclGEuBqY
	 Q4EjSXPgJuWSA==
Date: Fri, 21 Feb 2025 14:24:35 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
	linux-hwmon@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Baojun Xu <baojun.xu@ti.com>, Mark Brown <broonie@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shi Fu <shifu0704@thundersoft.com>, Kevin Lu <kevin-lu@ti.com>,
	Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 04/29] ASoC: dt-bindings: tas2770: add compatible for
 TAS5770L
Message-ID: <174016947515.19125.7118711540459460393.robh@kernel.org>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-4-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-4-932760fd7e07@gmail.com>


On Tue, 18 Feb 2025 18:35:38 +1000, James Calligeros wrote:
> A variant of TAS2770 known as TAS5770L is found in Apple Silicon Macs.
> 
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  .../bindings/sound/ti,tas2770.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


