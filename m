Return-Path: <linux-kernel+bounces-408606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B49C8100
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3852FB25E29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BB31E493F;
	Thu, 14 Nov 2024 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmj28HLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FB6AAD;
	Thu, 14 Nov 2024 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552457; cv=none; b=cThrSj/akN3N0QgUgfQoD6YfywZ35bRTOQukCOfMo12rqUQl8bY8915TI815UXsSqI5/5duAt4MZlieXztigakVlJE8BN88oYI7cZkI1Nvc2hNtTRiE4QdT3vO9Kwc6G1PZf3pjw+Zx6uVnhFFtvoBPH2D2vKkTJY/LAbP4u/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552457; c=relaxed/simple;
	bh=ckLeLN0G88iRttmSUjcB3Pw3BO4IJmRq3+6rgv4qs5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZkjsPd8hvIyo0IMk1/uD4kGnq2Ts/+PLM+jou2WanvcvHGL76SUQ5RCNWZ5zX83rsKfz+xmOku4CsrOuw9rlcFZf9uqgPUSxJRw6KCd115CVQt7AQVLoUdSWknhWsu4bIhE6d1s7nuTtItpKZjsZjh6e+6cxI1La8qSU/6lKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmj28HLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BCC4CEC3;
	Thu, 14 Nov 2024 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552457;
	bh=ckLeLN0G88iRttmSUjcB3Pw3BO4IJmRq3+6rgv4qs5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmj28HLf2QpcYxrxbQA7zRQk5binGaFoBuytF5qnLreolqhpO4yyyAPnrrL3zGmWz
	 xCfYXGE+wHNrYYmMFy6jnDGYd07TgqHOXf9ghcBpRiZmYizXb5JK7i+XquC/1IN6Ju
	 o46HbzbRKtgfTjDH5vcOjLKwz2XTTqKJ5K9RTpy0SUoaLYXjgM+5SEAhAh3UfXDNoh
	 HrzYEIdiLZDbe/5+w8+EQ/eiLt0guV8N8tXOcgZEtEIi1Ef7EK6AEypUt3c4EdJTrA
	 86UJgAVcFo2nAsKTzGQS+0kUO9V/NJlSStPD3s+VebOvMmi3xMWQqEk88FceEVeUjv
	 5Q6Tin2UnuHzg==
Date: Wed, 13 Nov 2024 18:47:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org (open list), Mina Almasry
 <almasrymina@google.com>, Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <20241113184735.28416e41@kernel.org>
In-Reply-To: <20241113021755.11125-1-jdamato@fastly.com>
References: <20241113021755.11125-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
> base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5

which is a net-next commit.. please rebase on net

