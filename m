Return-Path: <linux-kernel+bounces-438379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889A9EA067
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063EE1882215
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95F199239;
	Mon,  9 Dec 2024 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItGglAB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E01990AE;
	Mon,  9 Dec 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776711; cv=none; b=BBYcItkR5/fkQ9XECxBFytFFmoqi1sVBBjzDa148zaW/Kfg67nN0IBAFddjIH5unWyVyv8DiRUexk61qk5PqI3uVjGqYaPK3TCF4NWJOUZ/IgKjTAa/tu8vSO/1SzcpWlVV66Tr2rXKDeR3Tlx84Sll6g4Mg8rA5AjqvgbnCDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776711; c=relaxed/simple;
	bh=fXS//WI1VAjyk8vDSAPq97xcEndiyZAPcauC8VmyTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwbiX3z5ggwYc2eU2xbb5GL9j1CPtqNIeSDwWqKfhDQ7rvdkWfsXpUxmSSGyi2qSuKuYCWBzkc+ur5D+kNHTl5h1Y1LAqjSrMSnruQG61AijfIqFcM9ViW3RFVaCW7y35LsRdZhpyXkk6cRfSQ3KGyqO1LtYVnn6Pq/mUDSf+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItGglAB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5DBC4CED1;
	Mon,  9 Dec 2024 20:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776711;
	bh=fXS//WI1VAjyk8vDSAPq97xcEndiyZAPcauC8VmyTV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItGglAB7A16grjPnyjlQHj05aaM75DuEMm0BC/WtD6JRRF86Aqxr4BO5In5FJYlH6
	 7Ys5TSUIZXvsiXZtgA3fDbxhG7d94TzxHfXcNg/4hU7H9MIMDv3u0AeidAUvFEUaD5
	 sRW6Ig5YEbidwG9zxebOkL4qyday83vGjn/4Wh6TxSRLU5JWkcGD7/DiXBJ+PSKjeu
	 O2wRprl0AangRz/Rm+p2ZahbNVPOnDdCuRtZoBTc5qmrowgwASEoS+htTf4vGANb5+
	 /5k2az+mXPTgM+0be4xsT/y7NUD7p188dp3W8kB0NsVV/A9mTDWySBmJH0RjWa+ynb
	 5rZekqR4MvWbA==
Date: Mon, 9 Dec 2024 14:38:29 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 10/10] of: Simplify API of_find_node_with_property()
 implementation
Message-ID: <20241209203829.GC925532-robh@kernel.org>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-10-dc28ed56bec3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-of_core_fix-v1-10-dc28ed56bec3@quicinc.com>

On Fri, Dec 06, 2024 at 08:52:36AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify of_find_node_with_property() implementation
> by __of_find_property().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Applied, thanks.

Rob


