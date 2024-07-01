Return-Path: <linux-kernel+bounces-236576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4791E43E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802DA1F238B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274C16CD30;
	Mon,  1 Jul 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDsgpuAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6E28F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848150; cv=none; b=L+8IVVbfy2UksO3ZuYo192Oi4HDbg3TBH4KsjKjFX6nwaDVPJspUxEfT9mp3HckpKcNMCNPBN6pAhyRh4yX8iwhTM+YYbIzab6BJE3Yqpk2BDU6vfBLMhi/IXM1CWDnH52PLjq0Kq/Re77HwuaUWqC9LDZTGYeWbvGGfrelTOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848150; c=relaxed/simple;
	bh=fo5ZZhgaal61SnMn7wEKP+Sjpf3+qXtFCB39J2KT88U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJVNZ3YMGfZKyc8n9IVsCVsU/emN9S6eTiSnEEqHutzXfTzlsrgbX3VtPiBfFmvLyC0tw/s7KROfD92hSQM3tyBEypBmMnOb1XLb/bvtonehHwSHOJPk0YHN/CYxGnoQAswN4xMMeA4O6NzMiFKxnq+uB1HhbV1bli9+XWmB+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDsgpuAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259BC2BD10;
	Mon,  1 Jul 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848150;
	bh=fo5ZZhgaal61SnMn7wEKP+Sjpf3+qXtFCB39J2KT88U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDsgpuAdef8jYQybVzt2GCDWickE7x4cq160Nj3BT6POPFuGolydHL+9GaiGFhW/U
	 NCyondw9kVIIF5emYfo/Egv0hsn+7cm7R/X0X1ls0lE/5jl01fvak6B/sa3LjEJqz/
	 j/EokTxgV4rku39cD2gz1GiEc0vQO2TPvzrkzcdSdbF/FXqY2xbzgVFB//vjfGSyG7
	 nidmcmG+1yDpgir9e23ahHqm375YcUnem9ODk0krJZa/MPRrLb5EBnNJsmYYDXPIIW
	 VBj/2tZETSXqPjm7KkLUyTk7S+iAcyr8YcTrIJIKBRy7FPqA758uvfiU7z5n8CKEvc
	 19BVaowmvCynA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v4 0/2] Mesh PMU: Add tertiary match group support
Date: Mon,  1 Jul 2024 16:35:42 +0100
Message-Id: <171984210889.916169.4034955157375868268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
References: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 17:50:54 -0700, Ilkka Koskinen wrote:
> v4:	* No changes, only rebased on top of v6.10-rc4
> 
> v3:
> 	* Replaced wp_cfg in arm_cmn_hw_event with wp_idx that keeps
> 	  track, whether the event uses 0 or 1 index for the given direction
> 	* Cleaned and simplified allocation/claiming of wp config
> 	* arm_cmn_val_add_event() can't and won't fail anymore
> 	* Separated wp_combine from wp[] in event validation phase
> 	* use memset()/sizeof() when clearing an event
> 	* Still kept wp config allocator in separate functions - at least
> 	  for now
> 	* https://lore.kernel.org/all/20240329013215.169345-1-ilkka@os.amperecomputing.com/
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf/arm-cmn: Decouple wp_config registers from filter group number
      https://git.kernel.org/will/c/4a112585ebe8
[2/2] perf/arm-cmn: Enable support for tertiary match group
      https://git.kernel.org/will/c/f9a7a91f6406

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

