Return-Path: <linux-kernel+bounces-357988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FAC9978CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649CEB2107F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3077190063;
	Wed,  9 Oct 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9j1wj/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31928F5;
	Wed,  9 Oct 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514954; cv=none; b=QImBci37CDwpjHRww7Adqx2qynSLsyTCcFsBvaDZwGLl0CWpp1idfK5Z6y7nlxy5u9H1KU0QliGw8eYEvacTh98/3OZydB+Ltt47JTl0p3qezV6AuiCCXWg31Tigj1q5VuFb8RKHcVr8Zh3MgUwZb0Qu25Fxdi6pMHm8wsBf3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514954; c=relaxed/simple;
	bh=7BhRtVer07YSmf3uJk8dkE+ru60nI1c5gbZWmRKLx4U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hnnJ1sIAv3vkB+Q4fCOEm7Be/iztDC7YRce3bMKd0t8cXwk96jWZiEgCRpwEbBNzoemO1nqPQdIr3I6ZlZzWMkjY1LmJqObS+67SQzJK9hGhxazPWFV4g+R3Ztikxzlbd3fwZN4w76WqXXJ1AaXIRUXQgrVplSzoo27b5jf0K1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9j1wj/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4211C4CECE;
	Wed,  9 Oct 2024 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514953;
	bh=7BhRtVer07YSmf3uJk8dkE+ru60nI1c5gbZWmRKLx4U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=E9j1wj/IK8+zWVsw3GDXc32fzQBV56e6s919r8ISQ7Gxx8Zi29WFJOzG+XEIlfNje
	 gYQbj1E0ZSi3Nk+UOCSGiIdJ2NEwGzL9gfq4p57K9Df1xEPhIHwCLOopfFIVahkuBX
	 9BNTMujE04hylORPvpd8l18Ska1agjNl0mGPYMHy/E8lySPIXjH3inWgLRD/uBNAe5
	 jsH+ZOVPrR7v2vAGPyibHz7BRiN5OKV2yevpdkQickYBoPRKShj1pj+X5eMveFfOFj
	 2+kPOjYJ+Zc/mH9K50VV/mAgr3OZei6nZj1QkaJ0bogpzj4atf3UCtIcgE8skqIxrI
	 FJclfe/LR2xVA==
Message-ID: <6421c16edc9f5f7e7a2d24a17309a69d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5815159.DvuYhMxLoT@diego>
References: <20240912133204.29089-2-ziyao@disroot.org> <5815159.DvuYhMxLoT@diego>
Subject: Re: [PATCH] clk: rockchip: fix finding of maximum clock ID
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
To: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Yao Zi <ziyao@disroot.org>
Date: Wed, 09 Oct 2024 16:02:30 -0700
User-Agent: alot/0.10

Quoting Heiko St=C3=BCbner (2024-09-14 02:57:35)
> Am Donnerstag, 12. September 2024, 15:32:05 CEST schrieb Yao Zi:
> > If an ID of a branch's child is greater than current maximum, we should
> > set new maximum to the child's ID, instead of its parent's.
> >=20
> > Fixes: 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> @Stephen: can you put that on top of the other Rockchip changes for 6.12
> please?
>=20

Sorry I missed this one. I'll put it on clk-fixes.

