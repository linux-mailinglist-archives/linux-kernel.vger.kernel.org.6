Return-Path: <linux-kernel+bounces-301612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53C95F330
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFF6B21BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CC155A34;
	Mon, 26 Aug 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1XQZ2ef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03E28FF;
	Mon, 26 Aug 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679919; cv=none; b=I1D4z719OkvzfM6hTHGKanjYXRfYaJYtQKoAUJ64aJH/Yj+d90kKJtQvmPzGfG6AKPsGVQh9N7HusYWQFonUdhZSFGQim68CK/Wr6T4lcnNjBZNidgqT2Hs7guUAvlhjCaBwPhlcUiZEUVRnoPhpo9aOXfwNyEkv/spZL1S1uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679919; c=relaxed/simple;
	bh=0XG2Zbxbi9akZ2WAH9rOHGIJFqgBLO8l0c+SMpxL1Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isBTlak/NueWVW4rKyzgJhziYWLM8A5Lh48GrP/EUzrid5fDpfUFsEMn54rvQxV+hFXbJY4L0pC5zDq0UoLaGu+JLFeCn2v1kbl7Bm9mVMqjwNNuZU7SlE/tflRIUaFKSn57d9dESRX/49Pry+5KJx3OGXIYF9vGH/BrNzz5Mm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1XQZ2ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC6FC52FC2;
	Mon, 26 Aug 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724679919;
	bh=0XG2Zbxbi9akZ2WAH9rOHGIJFqgBLO8l0c+SMpxL1Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1XQZ2efWGUKHMw5D74WjqAkxXmr7ykZiLfeYVvv6q8Gm3rJW52AfBw15blZKIRl6
	 Dqa7pQBz/IEzD7spoAv6yKjlm75xL7F30es4lJ9ScM1pB53nUsxKE59Rvzh/aB73CJ
	 g3hBTvbNn9E5TVnhz8+zXZ+/VFDcPWXoJCVogdQVdbmbVh0sndpOqVFqpswwvb7LP+
	 MWi/SZ1YHGhB6pSSsfP6bB1FPvTtmRblbsJuGwss/4Qn1aVylvKZuuEMvRkNi1FFzt
	 FvwuFuKUr+lQnsgQn/PxNC8IDMkkGCI1taMSKTogDbIeafL3wPStWuki/mdS4JiNSy
	 CpDg1PrJGo7aQ==
Date: Mon, 26 Aug 2024 08:45:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: Re: [PATCH] of/irq: Refer to actual buffer size in of_irq_parse_one()
Message-ID: <172467991093.55425.937824843715730335.robh@kernel.org>
References: <817c0b9626fd30790fc488c472a3398324cfcc0c.1724156125.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817c0b9626fd30790fc488c472a3398324cfcc0c.1724156125.git.geert+renesas@glider.be>


On Tue, 20 Aug 2024 14:16:53 +0200, Geert Uytterhoeven wrote:
> Replace two open-coded calculations of the buffer size by invocations of
> sizeof() on the buffer itself, to make sure the code will always use the
> actual buffer size.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> If you think this warrants a Fixes-tag:
> 
>     Fixes: b739dffa5d570b41 ("of/irq: Prevent device address out-of-bounds read in interrupt map walk")
> ---
>  drivers/of/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


