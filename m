Return-Path: <linux-kernel+bounces-182526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C768C8C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF58B21F34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883213E059;
	Fri, 17 May 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtBULKub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C7DDD2;
	Fri, 17 May 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971818; cv=none; b=XHgyItPd/+k6IMREKobzqngCUx0OfxdJvutFVt83h9Qdrz7wn7ZyjyN6LCV6CXFUa5gvTK3jBg4JGiMZ7FHjpWY/Z5prWQlkmE1PjRdy+UpQl1Mmz7xEE//mgw+M+3eidrFO1ab4+vhkyO11M3B7b7uSijawdHiFOOCePZ7M9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971818; c=relaxed/simple;
	bh=uHcuO5weT8V4nkmlWXUWUlT6ndIJJq1NC84Hk5c27CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKc//BBBZwQiwNcaIlpPYVXicgarOF4qmS8DNlaPfeB00StQ4Klo5m06DOYTvq1GN+qIa61M79c8KbtCcoQRt+bi5l2KvJU8x2qM5jA0NMtt7wvxXTBfOf3OlrX5dn1hWSkA0TPDPC1cfEtb27nCLRufU/Z4NVoq7HFSgKbYHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtBULKub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E989BC2BD10;
	Fri, 17 May 2024 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715971817;
	bh=uHcuO5weT8V4nkmlWXUWUlT6ndIJJq1NC84Hk5c27CI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AtBULKubkUOyENj+izGH+xAIwhVoTYual9ZbxlTSlR3bP9HjVV/v0y52+U7Ctg4W/
	 7mxo3vot1J8l/Gkt8SwE4693t4HggaIeDUe03mMd20bwCSPS96PlkgfIOipbojgLln
	 0/5L8hpFsOQVgWhka2fY0Lr+votWILFDx76m5Y56JsJ8dEp/YvoSGJnkk1bs2WcziB
	 h0RCzSoagbAI0WeNPabbtekDwu6T7crDTKbdgYIHgvnZHGbOusM96zNgnfZdV3KO90
	 6b1jwRo3jszC50A4bpf6LcdkI5kTLRMB2khbz2AhLrKplzISEWqnh6oHoHpx2i79MU
	 9oNhz/EBp7c1g==
Date: Fri, 17 May 2024 11:50:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4] net: ethernet: mtk_eth_soc: ppe: add
 support for multiple PPEs
Message-ID: <20240517115015.49325c2f@kernel.org>
In-Reply-To: <20240511122659.13838-1-eladwf@gmail.com>
References: <20240511122659.13838-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 15:26:53 +0300 Elad Yifee wrote:
> Add the missing pieces to allow multiple PPEs units, one for each GMAC.
> mtk_gdm_config has been modified to work on targted mac ID,
> the inner loop moved outside of the function to allow unrelated
> operations like setting the MAC's PPE index.

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


