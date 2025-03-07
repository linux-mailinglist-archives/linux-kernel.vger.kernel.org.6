Return-Path: <linux-kernel+bounces-550654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830ADA5627C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC53AFB50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93F28E8;
	Fri,  7 Mar 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzQlrVaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197D1A5B86;
	Fri,  7 Mar 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335568; cv=none; b=In436CgXODwJOhCbWXRlug0wvLo5cDNuaVR5yFQCDSH1yUuKrjjFHBhhk/cmHIBi//60qMFxcqdYKAs5NZe8czheoH/RAhFtm2iLRhM83OgbwroVQi8fbh06aZy/VQpkpXxWOEYLK1znHo8jFTi07ngkoc30ThkVXgDR2kC6pUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335568; c=relaxed/simple;
	bh=O5yS4mHGI/dch51w5HPDfMdgFq2Kpq0OWX4IjLSKzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvjds9k4rWeBU+G62jc0yW7GnS2tHh02nnCRG0tgnT6A6WKPEDpI2+4tYaXfMaTX3PRyMRFVD9rwUjJMC3M+3vkL7QAYXwPCSx6WsFVBc7vS7lIvlOQ5R/qQKWFrNQVlD7qci0lFRpKIZseoYJ1IlAI2Y/lfCkAxtzLl5H5WTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzQlrVaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020ADC4CED1;
	Fri,  7 Mar 2025 08:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741335568;
	bh=O5yS4mHGI/dch51w5HPDfMdgFq2Kpq0OWX4IjLSKzZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzQlrVaa4RjdBeyCkD5UADcrV34MMvcjAG+N4ruhxpeXAek8mAx+n60Qv1CrN+Bwr
	 PhWmkhIayjQaQmS7RQNXMXRqEGK+eP9qbASGxqudKiDYDF6fuuk6FSdBtymVr0IJ1T
	 QOZnJUrZRWrq2OtUNDZ3nbXVTKuPymX3bXhuFQlcWUFL2XO7aFvYn4iEVdU9Xc6vvX
	 +9B512qSBQgaBnMJa8/UVIl4qpKT9j8puDdxJ0IwXlCE2W+A7ZngsOgokFhULgGm7R
	 doV4kG7xQ56qRQ49w488TLbwTbwMd0O7uwXygXGb0Ctb7+BPn3bFhfmYFJAUEpMTss
	 x5g9DM4k7He2g==
Date: Fri, 7 Mar 2025 09:19:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>, 
	Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: spacemit: Add spacemit,k1-pll
Message-ID: <20250307-magnificent-piculet-of-culture-4fe5dd@krzk-bin>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-4-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-4-heylenay@4d2.org>

On Thu, Mar 06, 2025 at 05:57:48PM +0000, Haylen Chu wrote:
> Add definition for the PLL found on Spacemit K1 SoC, which takes the
> external 24MHz oscillator as input and generates clocks in various
> frequencies for the system.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


