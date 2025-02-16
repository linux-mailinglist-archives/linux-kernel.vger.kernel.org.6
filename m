Return-Path: <linux-kernel+bounces-516845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A649A3781A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9FE3A929D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A301A3A95;
	Sun, 16 Feb 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="be0TvN1E"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0B19DF9A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746740; cv=none; b=AgODR+7d7Hq7gs3l/6MiS1hjsOjd0WwUZTIQjuusKaSUOxrpt3Lg0wp7jm9UtUQ6Wj+eXRbxDJYhAc0yqk4jYe8PHatHMoBYz+nwFUUU7TqVItX7Gu+6XldtRyHsWOavrq+QnbbOaL3IhB9o10J/71GAr7yoZ/Nq+opz/fq8BL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746740; c=relaxed/simple;
	bh=igPFcIAqETZ+TgmghW+VIvY/P4E+wul801/Cgld7s3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcjuQo3+Qpm4zDfBT7wKFk4Yx0i58N09arQ/3Hc15YThZV9436Qp+7+1eeMEuw1U9D6f33GLkwklmPJwmEsH98yqSs5OvEqp6YQiV6ftQEyvZMkvEgfQ64sDsP23shkYD3GMB5JpCa0DzLUo1QhLBhW17FYFfy1CKNJANgA1J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=be0TvN1E; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 16 Feb 2025 17:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739746726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/FXzmX2dHrZoHi4o+NcVuNP8PcXZi9MiUagI2/vqQU=;
	b=be0TvN1EmVBtW2YkSgKuZ/yiYLovqVqiUaVEoJkZ4fTO9CKWzFGE0YqEkTYDZ4xSYHTepl
	NK1JSjLwP8PDAA1H86rV49gfeX6n7n0IT6XDuz4G1Qwg0CYpsE7iufk1GnIpfdz2aVFIOz
	48q3d9NBuP9c4tUI5f2OL7pdWVTXLYUIlgucQfGW9OEf8mTKsgC2cp3A++8r1akcPGz7eA
	/xJ6/yCljddO7Q2Yhy0hGaAtgAKAPsrnNs47Tth94hZA/N57VgjrrH9bKr3jtnlYazbQnN
	Aof6kaFHS+mo7NrHlwQXUVjnau7WyRyT12EFf9qgniLRQ9iN+qtj5fWCZ/J8tw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH 03/27] ASoC: tas2764: Extend driver to SN012776
Message-ID: <Z7JtoIOECq-BjT9V@blossom>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-3-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215-apple-codec-changes-v1-3-723569b21b19@gmail.com>
X-Migadu-Flow: FLOW_OUT

>  config SND_SOC_TAS2764
>  	tristate "Texas Instruments TAS2764 Mono Audio amplifier"
>  	depends on I2C
> +	depends on OF

Do we want to drop support for !OF configurations? The alternative would
be extra #ifdef soup. I don't know if this is a useful build configuration but we should be deliberate about adding the depends.

