Return-Path: <linux-kernel+bounces-367664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEAF9A0518
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6E51F27027
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B9205149;
	Wed, 16 Oct 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPHgEiEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AF205145;
	Wed, 16 Oct 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069760; cv=none; b=hrhTtdvD7RLk2gAHuAvfL54V4mkfmNuMf/33erwLr095VcGxGwSCz1JGdW2FUwM+dIMlqfPLwyzg6MRoU1BwOuKQEAge5zvw5u3JGP1AZ1tCTR+lfsXcASXvAH1ySJvWwT4fyaW+5cfexrak7V/NDSr/B2fHSE4vudnCDOCBt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069760; c=relaxed/simple;
	bh=7DzNV7QP3nWVmo7K11DRLidSXthLRhUjeL1SNtVCM34=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=L5iF3//JMB9WrreMxuhz31qfTWYPieYvalWrJ9w/9AZoPhprgUasDykohiufPkysOgqiDd8VHiLo6Up/I2eMVsM9eCxTzUd4vvAKXnH6QUqMEdsonUtWpPmXoPt6C37kh7CruadVdKu41uyg772lekHq3YZr7H0mupB/ii2bXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPHgEiEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE00C4CED0;
	Wed, 16 Oct 2024 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069759;
	bh=7DzNV7QP3nWVmo7K11DRLidSXthLRhUjeL1SNtVCM34=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=cPHgEiEVFqQdpkFej5Xru1/et730qp2vJvsT8dGma7dm+wIJzBeHo434Vi5VrpXt6
	 b6S2VthzIN0Twu6841YugsHqqaAdEPPZDfp6NpkeBQRSwhDloxib5BoTXPxpAf3Lo8
	 qMZmtWFHNzt35J11vXz9bqt98lSSpgCyoifilK0M1K86Pt9OkC8oXABYM04vTWVpdh
	 5wH4EfApeQIjMhlr2eg6KJf3A2OkCEtY7kLe0uJukF0PQyElFnB/5nYwuOaPJlBoko
	 9QOMFFZTU1ik0ddEWr1P6jDrvMUdiRpYzyjbZeF4m8mCVNFKQ26J5DT6KiYiSYsX5Q
	 51JLCn1trj/Ew==
Message-ID: <bc0e039a48be39f825aa583fe20deb63@kernel.org>
Date: Wed, 16 Oct 2024 09:09:16 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jinjie Ruan" <ruanjinjie@huawei.com>
Subject: Re: [PATCH] clk: test: Fix some memory leaks
In-Reply-To: <20241016022658.2131826-1-ruanjinjie@huawei.com>
References: <20241016022658.2131826-1-ruanjinjie@huawei.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mripard@kernel.org, mturquette@baylibre.com, ruanjinjie@huawei.com, sboyd@kernel.org, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 16 Oct 2024 10:26:58 +0800, Jinjie Ruan wrote:
> CONFIG_CLK_KUNIT_TEST=y, CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the following memory leak occurs.
> 
> If the KUNIT_ASSERT_*() fails, the latter (exit() or testcases)
> clk_put() or clk_hw_unregister() will fail to release the clk resource
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

