Return-Path: <linux-kernel+bounces-218126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C089D90B990
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF63A1C23CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7F15FA6E;
	Mon, 17 Jun 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGE7FoPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47816EB52
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648356; cv=none; b=kcnMY/DDOHXLbcr3T8gzDtjWpLTahVtGxX/Zdpe1w+62lQvSipPDPTwMoEM5g2N/rV5dsDDA+CPquKKIrAC5Lq2LYs+p5zTaoQTubZrk+yR7rUTvX4/xwTTCuW+JLUcsxYsXveI7+bcuNA1J9SQDyGke5jNTa2I6AGOHPUYMo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648356; c=relaxed/simple;
	bh=zOFUQLQ6Q+zOaqxQ9V9xEthWbpAwxXXC+dJHf+yC+bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCY7CQShC7Ij+QEsqhqTqTqQnc5VfwU/Gptncn4RzX+mWXGqvE/u52xhym32b5W1MHavZOuvOv5FlW0LvJnHNvg0stB4wji5qyt4E8DfB3DJJwX7XeGNUzC1NMJoBGQVrsC3QoKsnrtl7f0T2oK52tjuKA8Tutz3pR7wyrX0h5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGE7FoPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF97C2BD10;
	Mon, 17 Jun 2024 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648356;
	bh=zOFUQLQ6Q+zOaqxQ9V9xEthWbpAwxXXC+dJHf+yC+bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGE7FoPQiGs/GhhjX0unIbzXGdmRTRnw3g0+1rx5K+MY/z6zCRUmBcu32iakLjitT
	 gtrdXyZRRao6jT2+3WV40g2l4PE4q6ZEkl0x3Z+ZYKuhk2NG/w52zdiNgEeqxt8p7z
	 v+Ry7LmW8qDtJMTaX/t8+CQ1jUGwmZ2Gk9anMzxiCSmPrwycdd0t8qZsQs73AYIYPV
	 Z8YLb7y6+h4TkyPEUuy+AmviUutN4kuWF+0j8AbKtLCBWcIwqlM53aIWMEmQ1JWmTj
	 h9EYvfcOe4JB+c8Tv7IwEqRBfFaRpJzke2wxFWPeTkofZg6bgqXBUsFHIkC3R2uyXa
	 OU8njm+3Qtnog==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	paulmck@kernel.org
Subject: Re: [PATCH v2] lkdtm/bugs: add test for hung smp_call_function_single()
Date: Mon, 17 Jun 2024 11:19:00 -0700
Message-Id: <171864833734.3344563.14327987606116557799.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515120828.375585-1-mark.rutland@arm.com>
References: <20240515120828.375585-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 May 2024 13:08:28 +0100, Mark Rutland wrote:
> The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> smp_call_function*() calls (e.g. when the target CPU gets stuck within
> the callback function). Testing this option requires triggering such
> hangs.
> 
> This patch adds an lkdtm test with a hung smp_call_function_single()
> callback, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> of the hung target CPU).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] lkdtm/bugs: add test for hung smp_call_function_single()
      https://git.kernel.org/kees/c/51005a59bcbe

Take care,

-- 
Kees Cook


