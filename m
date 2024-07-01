Return-Path: <linux-kernel+bounces-236067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A391DD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A611F20C36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3B13AD22;
	Mon,  1 Jul 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L67FPgFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1612C52E;
	Mon,  1 Jul 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831015; cv=none; b=HSFlSRe4HF2SXs5UnbJ6A0UbGUCh8hH/E5+TT6TSZ8pj2yK+TtneCWZnLvPyfNWG9iNjhd4arAdlfPZjkErc9cd4Hj+LvADknVXDrIZb+RiewUzp4Ge0qG6o9LgJDHqN2/Qfl0/835vCE7X6IEjxwGzUgSO/nEDbFLumntNPrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831015; c=relaxed/simple;
	bh=r11q5UKmcQttq70+jPKtkcf561PQM64tfvcFlcUuUrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc+4e7M9U4XCBfbYm2y71XG1nv23jl7VNMAqN2SurnhOaErw9/vq5/SnRySmVrlb7eRLc1E3O5L+wQXLaPd6LTaehOmYcMSPeVBzNwzPl96zaR3B8n7yQ1SGBFRgW6x6v1IdJRmePVkkAxD4N6VIolMMjyQsFfG+5kxPNP5m3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L67FPgFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119EDC116B1;
	Mon,  1 Jul 2024 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831015;
	bh=r11q5UKmcQttq70+jPKtkcf561PQM64tfvcFlcUuUrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L67FPgFhFTG3iv6N2Z4SZtm/TK0RWH8Kgkt6Vio0aT2XyGhlzdjYasq+OYhW0qkjn
	 Cl3QBb/ZYlfbnBJHCtYKo4GjMm2rewohyd/K8ga4bt48U4g8ZtJNAnQ0O7GZoKJMVx
	 /i0ds3to/bKv+Lr2D3p5oymWWNf+v+LrytpC2Uw8ZHQGJYkecIrsRYS3sU4wRx9OqZ
	 Z/fohD0KccaxgDosVy740AzQu2mcjcocvPYg2PRhUWjuuLXdldfl2y5YP/mXYhKaML
	 Yjbu/VyT4zm1CTHArRbK3xL9eXNI13K+RvZpO+nKBbePwruHZsrmd6+JQJfxFQqBau
	 H/YR4v4MnrP7Q==
Date: Mon, 1 Jul 2024 11:50:10 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 03/10] octeontx2-pf: Create representor netdev
Message-ID: <20240701105010.GR17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-4-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:10PM +0530, Geetha sowjanya wrote:
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


