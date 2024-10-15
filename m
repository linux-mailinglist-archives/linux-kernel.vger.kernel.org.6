Return-Path: <linux-kernel+bounces-365789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA099E9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35D71C2105F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8520899D;
	Tue, 15 Oct 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFaLvdqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D61D9A5F;
	Tue, 15 Oct 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995953; cv=none; b=g3vI5RvDoUMuAZjdjP7JmihWL6hC5eZNYzIFHOxDvn7wb7v/shENaCTfhuoJmeUV6EjaOrG7sSYVowlKvJJyk4GfPBg0NVC5WKpQzw+GS4TRjwnkR7zCiujFZ2wdJvKyQEpxTsHHiCYk1Xe1Pz1HDwkICEOCSH80/VwV828T2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995953; c=relaxed/simple;
	bh=QTtYFAEPIf5I0d3qekBOMwiJidbWoVXnP2kMc1zPBC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AllgddHkVZlAf6XQqEo1JLjuFi71LLtTC4pc5MWx7/l5leTiPPx2QqT5jZ4VJGO9HFSFpe19fAorQWZk92ffftPCFBjoQGnKrOAUh1PiWfO+uwdI413SglQnxdbiIfnznaCrof/pfHHYu0RBtIyoelpDastzWulAIGC/Sq7i4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFaLvdqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC26C4CEC6;
	Tue, 15 Oct 2024 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728995953;
	bh=QTtYFAEPIf5I0d3qekBOMwiJidbWoVXnP2kMc1zPBC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFaLvdqKM641PB4NIUtGmSOACidFNEUEyl+fFoA7ibrfvakrbRNHx0FZkTYazGoRP
	 LQmguEsQeLXaCIQVo4SsQhcGgSSEUHo3fzsNExRixt49Yr23coWF3IRKUI/iQbz1Zo
	 UPYpLeiIh3cwQG7fcrm14bCWcNfxhmhuDOHaM0WTyEaF8wmmX0sGjhzjcqhhpFS7/D
	 1yjQFJ2IWOmpyzEcdtIwU7f0eP2cbkVkb5gGV1mBP/zre+gGu12BqqJ89HojVSxWN8
	 +a5WN7I14ca4PyC/TUbdIE67eqowNyjDDgjaLJwncR4EGPGenvA5hMhtNYYaqpjZuW
	 MArpXchwiyaYQ==
Date: Tue, 15 Oct 2024 13:39:07 +0100
From: Simon Horman <horms@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix memory corruption
 during fq dma init
Message-ID: <20241015123907.GG569285@kernel.org>
References: <20241015081755.31060-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015081755.31060-1-nbd@nbd.name>

On Tue, Oct 15, 2024 at 10:17:55AM +0200, Felix Fietkau wrote:
> The loop responsible for allocating up to MTK_FQ_DMA_LENGTH buffers must
> only touch as many descriptors, otherwise it ends up corrupting unrelated
> memory. Fix the loop iteration count accordingly.
> 
> Fixes: c57e55819443 ("net: ethernet: mtk_eth_soc: handle dma buffer size soc specific")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Simon Horman <horms@kernel.org>

