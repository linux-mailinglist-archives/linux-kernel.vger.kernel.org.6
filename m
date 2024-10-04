Return-Path: <linux-kernel+bounces-350780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D99909A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870EA1C21248
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2BF1C879F;
	Fri,  4 Oct 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9P4w2WV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136971E3789;
	Fri,  4 Oct 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060349; cv=none; b=V23PYd24jw7B/iqNBg5O1QVIS50XHQjaiLpkxWGrX3A8AblM0CG66LrTncpMAIXaT1aXc7mEElhDcUIuiy7DFeHUFeclwfX6b2+v7UEpJA+RulS1BsNcj9Ylriu09QQGjdVul1NERYX3lFRYTHLnzIjrA2Gpvl7Exmxo/IAexbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060349; c=relaxed/simple;
	bh=o2hFNAT1FRUwAXpqAp6jv5zEwdXxNZGDEAiFVabBLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2/1MsV9zFrrdrfFhQWDHhvT8YpJm8tdj8YeSpiE/lI+TT/ezhuzLRhEOab1p+sHTiRL2EaGXyxZdsHfGBBbvDGkJkcPuPgrLBHwXQKiZHByEoGELA8MaR05InMDrSBURBbHJbBqFspyamxGLZPbN8I1M4yellmf3iZ7ovCMteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9P4w2WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE874C4CEC6;
	Fri,  4 Oct 2024 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060348;
	bh=o2hFNAT1FRUwAXpqAp6jv5zEwdXxNZGDEAiFVabBLu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9P4w2WVPPiZxukJ5L02l7dYP0pdRDKtObgOE0bzmkV6HdHM5AiSrrHfoQ2R9rmPU
	 2iRSwSC8RJWCoVK+mPVxjroIuBaTCfx5Oxll2/22TVYaFJcoqCg5aW9xi8CpwOiX3M
	 fpxNTO1kWnJ+r9Xmc2RT7VyJBnsOm0qB1o0n6Z8TNFWtR+rU2uo3vgsV7jIF4VPdhR
	 00m08VlDbypiYxfMcMgcSxkk4In5Odu+qrxwSo5AHjf7tpfzt2DPUAD3lCE/qhKoce
	 +gFBN5+784h5LS2b7PlFIX2yknmQv9sapV+eV8xnZA/YRnwK2g5s1vaH5Ao7HScW4h
	 wDMMIKJWA26VA==
Date: Fri, 4 Oct 2024 09:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
 gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
 razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <20241004094547.44ba5dc2@kernel.org>
In-Reply-To: <20241001073225.807419-9-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
	<20241001073225.807419-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 15:32:21 +0800 Menglong Dong wrote:
> +	/** @SKB_DROP_REASON_TUNNEL_TXINFO: tx info for tunnel is missed */

Doc is not great, how about:

[...]: packet without necessary metatdata reached a device is in
"eternal" mode

?

