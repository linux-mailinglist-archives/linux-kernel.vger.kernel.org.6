Return-Path: <linux-kernel+bounces-175248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E28C1D01
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C6B23097
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31664149C43;
	Fri, 10 May 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvTXeUL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A1142E66;
	Fri, 10 May 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311690; cv=none; b=HBvIg9H20PKcN9i3h+o+RcK4lL5AaSRSRMMPTp/oo0SpQzcjOTwuenNu9Y3mORskPfV17X1WcQZBZ0+/D3TI6CSphMnDtQ16GHb4wRMuw3Ng/55ZmB0CJ6MUSHqwfRIvhBnNm5ODa1blP/8itNcKD77WTGhLZ7KMH7VmRbWRunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311690; c=relaxed/simple;
	bh=zv7wDs/nnXwMvb+49prRA6w+/tTmLN/Hqx57aSJhUj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnFL7baVLaM1IW3Fagcc3Z/S2rb46A0ejPNzHZ2+Um8wUKFzSHAIrmZwVH4W6k6uVZmiuwwtjatp21/PMmLOWrgH98TO6UEAOr/Ai8kPCaCQ9dbSCOGand9ekQvNuBqfepjt6Y2n45GXxNktDB7ASQNyuhUwJpuo5NmegVwDt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvTXeUL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE0C116B1;
	Fri, 10 May 2024 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715311690;
	bh=zv7wDs/nnXwMvb+49prRA6w+/tTmLN/Hqx57aSJhUj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvTXeUL0wgteyS/oezeQSAB5lrWBL5ObWRn9+YeeQwKOUMKmBFFJVQO3N1lLph73X
	 N6+t5hIPjlOYzOEIC9GKBLRRxhNpzOAZENK0u9TCnRcG+2BiggiOGo0hSE/Vy1ZA27
	 fOCX0XjMs7KNRYGPblMQv96dCKGZXKDhtCHKQ6T17kjSZM3l3kz+MhSWdD4JMAq2oy
	 Mkf05h9516GLZJsvn4yQRimb7NjonFWsHHVMWJ8d4vhJ2CXHJUdvjNa6y7DuWrnspj
	 AlG2OBs7hWStHI2b9VcCauQGnKQP9IIgrbk2JBPa744RRqguy8cFq/e9f0/JRefMjR
	 VsoJkPUbItZBw==
Date: Thu, 9 May 2024 20:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 03/10] octeontx2-pf: Create representor
 netdev
Message-ID: <20240509202808.26e960a7@kernel.org>
In-Reply-To: <20240507163921.29683-4-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 22:09:14 +0530 Geetha sowjanya wrote:
> +	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev *),
> +				  GFP_KERNEL);
> +	if (!priv->reps)
> +		return -ENOMEM;

using devm_ here is pointless, the objects are not tied to the lifetime
of the device (there can be created multiple times) and you have to
unregister the netdevs manually, anyway.

