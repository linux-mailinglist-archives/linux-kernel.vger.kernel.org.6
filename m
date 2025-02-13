Return-Path: <linux-kernel+bounces-513681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764BA34D61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C7F3A1DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B9245AF2;
	Thu, 13 Feb 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRb/038q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E237245AE8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470627; cv=none; b=NbJowjTMo/geTKJ2xXZYHSBbW85h1fzFABQ7DPSv+zh7IxZo2bQhDYuR5BbbRBh54zm/DCrA1XPgmJ63iMKFon4tFlO74Yy7d+GdQP3tZedwJRq3SgGvzTXzzhSLMQKlxZxesHZWS5GZC/xkfy7ZhevzkoBurm2rcvtwMEgIIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470627; c=relaxed/simple;
	bh=xyiEG1qVnqJ0dR2fvj2d0MpnQnkVPFFoDUNGG3CsxIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C+Qwu+H6VHdS4pfzoekLBWZUMiNcvQpI2VpCZns9U/vk1RC36+gBcoOOjpHCNuXn9XVVfZuf5pCvBwiVwA/59wNkIAnTRdQ093Mdhsa6DMpYl6p8mjaE1n/bXQNMVOJq3qhgxpj9GtpGhek/5yqNMlZ5uQXSbt3URW/CgSel5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRb/038q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E57DC4CEE7;
	Thu, 13 Feb 2025 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470627;
	bh=xyiEG1qVnqJ0dR2fvj2d0MpnQnkVPFFoDUNGG3CsxIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jRb/038q9zceA3lpyR3cBILkOtsy6JXEI7w8/AC9SGenuJbL0Iqahi7XlIYiHhWDK
	 9+617DqLSS7AUF09QfXno2ZFt55Vsv0ykmss5eX+B+jNGVrb2kiXY0R7FNyxx9LRpC
	 PH55vKZWNbQ71FphZ6jSD/hjzOttsdUIeakbJuNUCqhY8wukBZYSz1gMLvACwnb6Hf
	 nVNfI2zUukWooSHArKj842JvE9Mh2hiqHVYzeIxrxhzuMLRCj+wcUHxJMx6cdq/1pX
	 9do1RwE9jlv6ZEbWeXxI6N25f0ua1JPRhDNmytB051Yoahyh4MhtnILZtQrt3EYCa3
	 FxGtEWWbsec7g==
From: Vinod Koul <vkoul@kernel.org>
To: aford173@gmail.com, kishon@kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <tencent_9087BCE04E38E6AA5C4B2252B82FA99C2009@qq.com>
References: <tencent_9087BCE04E38E6AA5C4B2252B82FA99C2009@qq.com>
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: Use helper function
 devm_clk_get_enabled()
Message-Id: <173947062491.294083.16177229110785904684.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 23:47:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 08 Feb 2025 11:44:01 +0800, xiaopeitux@foxmail.com wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables the clocks for the
> whole lifetime of the device. Moreover, it is no longer necessary to
> unprepare and disable the clocks explicitly.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: fsl-samsung-hdmi: Use helper function devm_clk_get_enabled()
      commit: 279950205dde78bc0e3ca73a8dfee6842f0e1edc

Best regards,
-- 
~Vinod



