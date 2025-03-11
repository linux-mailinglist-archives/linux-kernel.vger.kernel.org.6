Return-Path: <linux-kernel+bounces-555945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F9A5BE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AAE1898D83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A5231CB0;
	Tue, 11 Mar 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx7W61u3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B8254847
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691632; cv=none; b=iGPpIXAmnlWndlUQmCJRb0IUZNIg/GcYMqrKnf9hbOK1TRGMiQBVhsjnHygbn1Htl2XZdfSwiCWBUBxYXJeZbNrjpg7ll3IGNKmkL5vN6t9/Q99ZLQkkaV7TIQrJ7r8m7HQEZ+6NaPZ6GePyGKrodVksedoVnf0ktJB2nmrzpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691632; c=relaxed/simple;
	bh=qbtvWIP1+nIeEYbvoZdR0xecYHAOBTcof1Joj/nAUfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYKlMrhW1Q0radsVWlIMcl+YexvPs5DNgFhdl5Kn0W0fq77nVCG11E6d0vQspka4bPz0l1lCzwqEYaMWQ8v96P8CLd+pjrWcV6b4pw9NWVmi15QlNKKYFRIBvPaO7sH4X+vixWYw5UfSs6uwJtU634Ic0ViDiYCkhnAu2h7njAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx7W61u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF06CC4CEEB;
	Tue, 11 Mar 2025 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691632;
	bh=qbtvWIP1+nIeEYbvoZdR0xecYHAOBTcof1Joj/nAUfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hx7W61u36GJWwC4o/LYS+nsWiIqB+uVKZflDZ/STvcQba1rMkyR0sMb/WTvCvXG0k
	 PV/ssav8qlAYZPM21ROnyngQYSaNUJ7H5Enm94EUDQObkEgpD1QmFt0uCXgQaYt2w9
	 cybLrZX1cJ+FWa8pRrmSZ0gJwAtiDSpNAH34LLtrG6Rcn//BZEwUsbUe2A2joCpFiV
	 sBwWyQZzyAM2m3sTppC6u8swt6Ga9oCcCd8Hy97X0K1xm8TmjjwMOb+UWQ3DdC3JZ/
	 sLPzU2R0grhsh812qwGJgnLLMEYK/afQ9ARJUamqfV88xNc9f6aOruBxCldJJM/J39
	 wKXmeeuquRz4Q==
Date: Tue, 11 Mar 2025 12:13:46 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, kishon@kernel.org, sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com, dmitry.baryshkov@linaro.org,
	frank.wang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: Re: [PATCH] phy: rockchip: usbdp: Check these parameters only
 when the corresponding set flags are set
Message-ID: <Z9Aa6v1/1KRdZDKE@vaman>
References: <20250306065952.485809-1-andyshrk@163.com>
 <Z86UOmPg/UDSBajZ@vaman>
 <1379400c.90c.19582b05f74.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379400c.90c.19582b05f74.Coremail.andyshrk@163.com>

On 11-03-25, 08:52, Andy Yan wrote:

> Do you mean we should do it like this:
> 
> static int rk_udphy_dp_phy_configure(struct phy *phy,
>                                      union phy_configure_opts *opts)
> {
>         struct rk_udphy *udphy = phy_get_drvdata(phy);
>         struct phy_configure_opts_dp *dp = &opts->dp;
>         u32 i, val, lane;
>         int ret;
> 
>        .............
>       if (dp->set_rate)
>            	ret = rk_udphy_dp_phy_verify_link_rate(dp->link_rate);
>      if (dp->set_lanes)
>                 ret = rk_udphy_dp_phy_verify_link_lanes(dp->lanes);
>      if (dp->set_voltates)
>                ret = rk_udphy_dp_phy_verify_link_voltate(dp->voltate);
> 
> 
> Add helper for each of them ?

That would look better for sure

-- 
~Vinod

