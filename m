Return-Path: <linux-kernel+bounces-539438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9635A4A426
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB1B7A8C05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479F202992;
	Fri, 28 Feb 2025 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo4RKDdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494223F36E;
	Fri, 28 Feb 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774163; cv=none; b=heE/BcM3LZ2nx+iz1yyl2VjrtDtJiZbCKqxurKdikH2KL5O0jSgGCztjLYDo6tsnkqJsxUb0+gs0aJ4fOSCQlYipl8RfNotK6CrenznoXaWircf3Fq5yxVdLVL1kURQcyO0JqYtpI72Pv9NnIghYTFFVDVuiO3lNZQrhZtLueJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774163; c=relaxed/simple;
	bh=wfzANROPsaWWkrbci7qA/4XmAh6NIwZYuO5mE+y69ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6LU2P9DxuLeqgWyApXEPn43YrQJZ4i6/7ULshZv2vbOH9+BSv+l1ksN8J3J5F20ngmJmevR5O/rv6YUF62qj/J3r0tQ8zFtz11ZVmi829/iNsfYBjhLf5ChHcWnaxAjZjWsKPHVGy3zc42b0cFtJicPX/w64xfol4E9TtyBnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo4RKDdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9943C4CED6;
	Fri, 28 Feb 2025 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740774162;
	bh=wfzANROPsaWWkrbci7qA/4XmAh6NIwZYuO5mE+y69ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fo4RKDdZT8HC+g+RwI0lGMwqaLJlwh8rxhiTYyqw9KgjrDktXJYU1nwEPPAWC/fB8
	 oePssIAPkDjkYUD+o9575KTvwaKVNbnFqHjBbKJNkkDIYgfI4n+alfz5W3nibHQTnH
	 gbtElWOEjFGyby6xJyOgVzw4ljdvaq1UcSlqcFhoy9OHeb4XaBYl/Sde1hc+ffWwJK
	 7Fa2AVXhEUhHg/sZbfESY1XLHMRGZyShZsFbmeB2epNmBODWRQ8EA6LWYM/HBIWNKA
	 i8Wp4kbIjCSIUm8f2tcX7UfHklguDYUP+8Z1qVVA4UIBO8qotz6XfUys0PVVJKzaMR
	 VY4b/UwQxI8Pw==
Date: Fri, 28 Feb 2025 14:22:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Baojun Xu <baojun.xu@ti.com>, Takashi Iwai <tiwai@suse.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shi Fu <shifu0704@thundersoft.com>, linux-hwmon@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Kevin Lu <kevin-lu@ti.com>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org,
	Hector Martin <marcan@marcan.st>, Jaroslav Kysela <perex@perex.cz>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v3 08/20] ASoC: dt-bindings: tas27xx: document
 ti,sdout-force-zero-mask property
Message-ID: <174077415940.3647975.15902049404570656565.robh@kernel.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-8-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-apple-codec-changes-v3-8-cbb130030acf@gmail.com>


On Thu, 27 Feb 2025 22:07:35 +1000, James Calligeros wrote:
> TAS2764 can be programmed to zero-fill/ignore certain TDM slots on a
> shared I2S bus. Since this is a per-chip setting that is a consequence
> of how it is implemented on a specific board, express this as a Devicetree
> property.
> 
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  .../bindings/sound/ti,tas27xx.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


