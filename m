Return-Path: <linux-kernel+bounces-526594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC08DA400BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6933B9978
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA11253B55;
	Fri, 21 Feb 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B18uDJU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E225333B;
	Fri, 21 Feb 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169465; cv=none; b=conMmm1wMrpQdU0nZssZ5TuwDV15ESEoRm6rSU05A811ezGTjXTOUXuozmr8qAJ7RyHizZqVF7qBbxUvhesmMWvKIKGdnY9d3Xbt2DIuwS2bTHMUbP5L4h1GtoLj1EfgpA7mQBpIDAhpgKnclN+enV13Id/K8FizL63UqUfEdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169465; c=relaxed/simple;
	bh=BA/9a3AUaurPTfHWK9D4oMHkVThzECRSNECXYl7rXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCx/3tgnw51EKAnavueQ/d5J6bHqmyKWkj3YjSkwjppCi7srtF+Ohid3qQtYyWskUvVRRTxK7aNr88fbpe7c9AtXHr7M8wZLBNEULrnzPeTRto8y7j9azihmDGjoMlNXSu2lQMAagWQ5qW7DR8Dy7l61dA9n6nx6GUR4xFPl8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B18uDJU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B51C4CED6;
	Fri, 21 Feb 2025 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169464;
	bh=BA/9a3AUaurPTfHWK9D4oMHkVThzECRSNECXYl7rXsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B18uDJU9zEEEgtr9YKx+ZwX0JSEnq/X3dGGbLR+xCXFrI0BtfYoc02IaDUmBjdHkd
	 kuDJb/hkfcHcUaKwBGpDcUqntPtqeOiTKaKvFV1YcFeWTqUAqoTK3x+I1OrMaTSWXf
	 BtA0IHaoHJ753jo65VmOgQ9eMPPlfZh8kiyjIVKaY0EgDeM6j1JTA+ySthTRTrG9Gr
	 XPRd6BnX7De7k4jrwBPX2hUoSSAWkedQm8lzF5KsQ9qusfN1ecAlshNJ2PlShlU9z0
	 CQurln8aNdF1jbeZ5MnnCB0SJFyIAOzsJGs/Dkc0Zz2hLDgW6BRS86ANoIEteB5Ttq
	 9JQ2o+DNgA2wA==
Date: Fri, 21 Feb 2025 14:24:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Dan Murphy <dmurphy@ti.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Hector Martin <marcan@marcan.st>, linux-hwmon@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shi Fu <shifu0704@thundersoft.com>, Kevin Lu <kevin-lu@ti.com>,
	devicetree@vger.kernel.org, Baojun Xu <baojun.xu@ti.com>
Subject: Re: [PATCH v2 03/29] ASoC: dt-bindings: tas27xx: add compatible for
 SN012776
Message-ID: <174016946225.18751.4498850006869111777.robh@kernel.org>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-3-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-3-932760fd7e07@gmail.com>


On Tue, 18 Feb 2025 18:35:37 +1000, James Calligeros wrote:
> The TI SN012776 is a variant of TAS2764 found in Apple Silicon Macs.
> It continues Apple's long-standing policy of getting vendors to
> spin out subtly incompatible and Apple-exclusive variants of their
> publicly available parts.
> 
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  .../bindings/sound/ti,tas27xx.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


