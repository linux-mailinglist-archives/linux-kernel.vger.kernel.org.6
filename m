Return-Path: <linux-kernel+bounces-570334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C3A6AF04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE80E189DF24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439A228C99;
	Thu, 20 Mar 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6+PkvIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FAE22687A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501673; cv=none; b=NCkgNMp1nlOpRv0rsIA36Eo/9Te4Dxx00d+27+6gOPNH++ahnEO5NE+hBieqXEvEwjSKYBDvlwAkvgHV1AkXUNLxHccK3Zh3hsX+QF8eb/3YeBV95XDvJn2Pkkint7CHnbbK7IAWrThAP0FJuSvmp+MqHCLzVXOkzMGcy75knvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501673; c=relaxed/simple;
	bh=DbhyLRw+ONnvGrwiPJJZfLcA19J+b0IMN0QAC/62tIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDunGB9bl8ylpFzz8AJCJR9A4ofumG6VeMKfkrLq65xxsPXOobpisJ/EAc2rSdu78JT0T9eb7qqTglw198YZLYA9l5hsory1egJQXkitm47/SAP3iyzx0mk+NSske1QLmW7/bhc4MZiDX2D9+s3ngJkvatCm5TFVOGQD1Qk9KvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6+PkvIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A80C4CEDD;
	Thu, 20 Mar 2025 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501673;
	bh=DbhyLRw+ONnvGrwiPJJZfLcA19J+b0IMN0QAC/62tIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6+PkvIjVvoooH/vlAp518qF7Xq0+AInbvKGnsnZG7haTNblNY61Enr9/lpVfmfSK
	 FDFHIoxA02ojU3f/bZdNnvB3zcEtq553WiOTj3aW8+u4ntXY5WbJbmmlupO/YzRyeB
	 dk7OnSCG26bhfSg1znBaUjfTkUMAOErl/HfYOuQBJOWtMBqXUNYb17sp9oyqBEp8Nw
	 Mih0XPG1texZBTe5KmHH3zl5AKuH8rThSAMZJkyb6a6SNeot91WNc8bodODPbEWAPI
	 jYEGTdPKw3YFGtCUH4vqB7FF7RMgAD/Lg263T0lfJVt5pQZ/n9zBzBdoHohknhr5xi
	 YnzP/76cB4QkQ==
Date: Thu, 20 Mar 2025 14:14:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yang.tao172@zte.com.cn, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)
Message-ID: <Z9x3JsGAOIVKuHjD@kbusch-mbp.dhcp.thefacebook.com>
References: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>

On Thu, Mar 20, 2025 at 03:53:00PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Li Haoran <li.haoran7@zte.com.cn>
> 
> This patch replaces max(a, min(b, c)) by clamp(val, lo, hi) in the nvme
> driver. The clamp() macro explicitly expresses the intent of constraining
> a value within bounds, improving code readability.

Thanks, applied to nvme-6.15.

