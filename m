Return-Path: <linux-kernel+bounces-255056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0232933B19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5272283485
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649517E901;
	Wed, 17 Jul 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGkj8G5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C53AD59;
	Wed, 17 Jul 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211814; cv=none; b=C3pOEeTdsUnd67keoVn3QhCX6wr83CWP9oJQva2ISa9MDPuYck58dUKr+TN9UR38mTwTetop+2P8vXq9RPRtbSvWZ3Q8A1SPyNpnf1Fv7xd+3H/O3YrhQjTB8I4o36r97/U3E5VVo2nj9TkuAh70TU+KQCjQigJUbz4ungSFr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211814; c=relaxed/simple;
	bh=mRvQ3pQsoYmuaxOlPG3sknOwnFxs9aF8h3bPGlnT00o=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=b49Fs4JfPoHIssAbWUAaAwnShW/O14gKhRqjRuioSNg7WN8wPT3gOftUz7+NajVELwL5ZIZFS7RyzAdsSpPy1iPltw5XES6dsGXQebU9jtESGlfBp71HBSo4Hp6g2CGuf4YLd3BWzzopMCMwb3ZrGD1SPsT9r1m0rmTtVFGzzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGkj8G5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D5C32782;
	Wed, 17 Jul 2024 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721211813;
	bh=mRvQ3pQsoYmuaxOlPG3sknOwnFxs9aF8h3bPGlnT00o=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=JGkj8G5JyCpJVk0+fSuf1xMjj16USoNnbOq6bBXrPyiQCuAN4Qe0O8uiqsle7s9el
	 abtiNi02Q+uf0RIRvSotna/xZw5YeQkPEm/UfEQ/3s0Kqa2aI6KsxKFksa21nAUPkI
	 Jw2EAz3K+MtKCfYviIOMyYE0MGsnIn0UPDXegtWjiuqaK5cbi6Je+IcaZ/JTaVunBY
	 K6NnX26f4kAR0n4hOWTinnS2q06kwJLtaYqwaBY/mrwlXiYrC8/LGV78+yidJrAani
	 y83dvtmEGh1ljLpJxRGNG5X9hpus2qt0ocgdvdMMCVTvZXw/PAHRUWhEE4OLC7Tjfd
	 2RHMsW1A64mcg==
Message-ID: <27e6911108d780abc6a7cb688b3229d7@kernel.org>
Date: Wed, 17 Jul 2024 10:23:30 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Conor Dooley" <conor@kernel.org>
Subject: Re: [PATCH v1 0/3] Fix incorrect bh2228fv compatible
In-Reply-To: <20240717-impotence-zippy-254b86593069@spud>
References: <20240717-impotence-zippy-254b86593069@spud>
Cc: conor@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, "Conor
 Dooley" <conor+dt@kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>, "Fabio
 Estevam" <festevam@gmail.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Mark
 Brown" <broonie@kernel.org>, "Maxime Ripard" <mripard@kernel.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Rob Herring" <robh@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Shawn Guo" <shawnguo@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 17 Jul 2024 10:59:47 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Maxime made a typo when adding this device to the kernel all the way
> back in 2012, fix the spelling mistake.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

