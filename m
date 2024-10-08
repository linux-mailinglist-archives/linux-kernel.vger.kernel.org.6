Return-Path: <linux-kernel+bounces-355268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7003994EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C421C2572A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E71DFE27;
	Tue,  8 Oct 2024 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCgK9O5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A31DF26D;
	Tue,  8 Oct 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393720; cv=none; b=hpB8JuoZ8V2PR5eN+z/lp72lhtbi+YaE3Z01DJg740OOOXBeyUsqlossM0ZoEQlJc6tMDocqhlK4q8qET3r5n4lQD3I2rxrTTp9HRgbmLHPTjgaiKqf2q78IUc8+fkPCVe+/VGTMDCICKSOrry1Bnfiu+DlMgWtoUZdmGWid8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393720; c=relaxed/simple;
	bh=xINwuhtaPQ0eVAqqd1YMDuK6Y7GbFO6G7kgqIiU3tq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWt8MeiE7XM3Iz5ILu5WeptgwBuWXts0bRcBgdFCWKijC7RZsWyWLOASTf+uzGf/HJdnNTkNPsNFzBLOgnA0SloCsGzEEVRA17TzHGbNopNPDSm4jL/kV8eWqKNewCJTYa5zSh1nqY1mPEYwRk6BjOrJapYJq/e5s/Annd9mRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCgK9O5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B0C4CEC7;
	Tue,  8 Oct 2024 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393720;
	bh=xINwuhtaPQ0eVAqqd1YMDuK6Y7GbFO6G7kgqIiU3tq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCgK9O5F193mfHXgBs6LfHmMFQUjLvREpnUxVWh3F0b7q9H8BWjQfliZoml5DMiDP
	 6Jyr0uAWZPXt5vleMpDvYcDJFhzddBvEwIuIDLOdFe+AOLUVgUiwbHJDJmhlvkhTAz
	 CEwIJYz7pYomTqMhcnSE/mO/IQPQvcaBxQLKRNshV2jxfNgqDXLMk8k8/3svB3kQWp
	 LQzonDwTTjaNN3HMYFoSA4TvG/1CdgUYbgEtX3WIjRL2mDM/BYX5Ry5twb7T2kQTi2
	 WPVu8leSbu8gmoYcUu2/2fuGqfoGE2Q+GR09RxEVF7kLIYyEXPTeFk1szsrMUwm5X7
	 a/h6feUyPdYQg==
Date: Tue, 8 Oct 2024 14:21:56 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 5/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in otx2_dmac_flt.c
Message-ID: <20241008132156.GS32733@kernel.org>
References: <20241006164617.2134-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164617.2134-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:46:16PM +0000, Dipendra Khadka wrote:
> Add error pointer checks after calling otx2_mbox_get_rsp().
> 
> Fixes: 79d2be385e9e ("octeontx2-pf: offload DMAC filters to CGX/RPM block")
> Fixes: fa5e0ccb8f3a ("octeontx2-pf: Add support for exact match table.")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


