Return-Path: <linux-kernel+bounces-240667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425D9270AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40C2B215A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BF143871;
	Thu,  4 Jul 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH6QzOcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60421A3BDA;
	Thu,  4 Jul 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078266; cv=none; b=tcExBVdVzs6EqFBCDLh5bH5M4vKELTvsNVQTZ+TWFM4ufBI5wnYoiEmiY0lLDVhaVyhZWkIJi8a4rEBpn9oNsJlIbagj3UmdS8gnOKdqpcjOcPwzMtshO5Qf/wBQ1aaCJSU8ErrvZItLlnT5E3ee/CG4N9iB2AQKS/MmrA51u9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078266; c=relaxed/simple;
	bh=Z2P7DtgbM0ivOJu25MqclAlXcQyxvD7E1vvfHykoLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv0IVMOZuOmH7g1d1fL6LUEa51c9i0LAHe4VdG6OhrRc19aMLM2z9I8L3X+h81EopLqad3V4aUjkTBTE/IW2MuV/j9jT64U6BAPtWM1R1Qiih2+Vs3JR7OSudoxfyA1euT83L+4Ni7nLOa+IzkOJLmC2aPYs7sDAL1VV5AROEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH6QzOcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E9C32781;
	Thu,  4 Jul 2024 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078265;
	bh=Z2P7DtgbM0ivOJu25MqclAlXcQyxvD7E1vvfHykoLEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH6QzOcsUl1NbzOkYiU0TaFcTsRN61gVR8XF5hLPwGoT5wpXafRoUVXHGMTcpAqWw
	 1IGMgi0fiFBrbSdqO8zFOuN6YsyLws47fzOx3Sh6f4I8U534QFsihHrnJMgJHVUqpj
	 1MxOoyVJPm3+rYfigk0AOWqo4WBDfB3ScEATfI24mXQdFHxv5lSXStQIiaQGABgk8H
	 8ZDFGPqVJluLIzBqZPfLnfTjnxtRZxRT5DHd5UYA5Y9g9V4LCH2FqYoZfQJ0qjrBzE
	 aI3g2NBjaCBtznZLkYjnmazYAdR5TKuiqjLjyu0S0Usi+EkoDgl2SYUw/q5LbsePwf
	 FwqYsEJbhxwFQ==
Date: Thu, 4 Jul 2024 08:30:59 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, yinjun.zhang@corigine.com,
	johannes.berg@intel.com, ryno.swart@corigine.com,
	ziyang.chen@corigine.com, linma@zju.edu.cn,
	niklas.soderlund@corigine.com, oss-drivers@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
Message-ID: <20240704073059.GV598357@kernel.org>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703025625.1695052-1-nichen@iscas.ac.cn>

On Wed, Jul 03, 2024 at 10:56:25AM +0800, Chen Ni wrote:
> The size argument to kcalloc should be the size of desired structure,
> not the pointer to it.
> 
> Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

nit: s/ntp/nfp/ in the subject

...

