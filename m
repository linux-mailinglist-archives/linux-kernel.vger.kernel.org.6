Return-Path: <linux-kernel+bounces-553746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B043CA58E66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C6188C4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBC224243;
	Mon, 10 Mar 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXN3W0bz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB97224221;
	Mon, 10 Mar 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596072; cv=none; b=mlDcsq/ydgnJbE87RDEY8lEia7jkU9H5IxkPIhZBDWIsxAYvzFxEGTl14UWSnA6sRoX0nh2QRqx9SKU0d2SLv7y9lHDmdt3jUfhKmMPfisBYArXEl3/DsxTkUFzJHBNWBy/gac/KcL7EQVDjFgGyA9E7aYZ7KNRSRk8xTjICRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596072; c=relaxed/simple;
	bh=s2845B6wBu6/avwRKOTzAyYDmt1SsVA3vmARrLcsd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjyY6n9T78Zyn1JYxWVJj4xz5iNc36/r4Qbj+BGPzSh6GwQx4xxiqiUc35auHFzEWaIMXQuQZAvVZfMVJBpMRc9viTGzM00O9VCPljcKQJGbk6ge8sFBYq2SMU6fbALwDRLgGWadEdz994GCkI6N7pi3zEOGJoMYM2eadm83nYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXN3W0bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD5C4CEE5;
	Mon, 10 Mar 2025 08:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741596071;
	bh=s2845B6wBu6/avwRKOTzAyYDmt1SsVA3vmARrLcsd9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXN3W0bzAEdpt4jtShYQuPFHsvTbgSv9eEJflODVqenXo7R8HPyEm5btQ3jnSYg8a
	 SbibdONkFMc+MD4wuigDp/6J9b+saV0/umAv/FmzOkwmVYh/JMkWXR/L7D/j2sk6NR
	 P9uOd4/9m3EcNIHDtSV3LQ1ixTPcaPlDyklSulDte1e4JQjlatnVwWC4J3omA3TiQK
	 dxjuPiKxfC0tgc/rHjCFK2HO9kNXBTvgrmuBJDZ4Wdg0EmXAgSqfWz/0QPjhppRNVD
	 AfFa6ja0dXH3zs0blpBcLXmMbPZEzYYFkMm04oA1Uw4Nxx1AhMAIBIHGge7/ClH809
	 +jNxyZ9dOD+KQ==
Date: Mon, 10 Mar 2025 09:41:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 2/9] dt-bindings: clock: brcm,kona-ccu: Drop
 CLOCK_COUNT defines from DT headers
Message-ID: <20250310-analytic-peridot-whippet-246a75@krzk-bin>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-2-d6fb5bfc3b67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-kona-bus-clock-v3-2-d6fb5bfc3b67@gmail.com>

On Sat, Mar 08, 2025 at 08:50:40AM +0100, Artur Weber wrote:
> The CLOCK_COUNT defines are not used by device trees, only by the clock
> driver. Keeping them in the DT binding header is frowned upon.
> 
> Since they're being moved to the clock driver directly, drop these defines
> from the dt-bindings header and only keep clock IDs.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v3:
> - Add this commit

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


