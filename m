Return-Path: <linux-kernel+bounces-385631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BEE9B39A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DDDB225C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44831DF738;
	Mon, 28 Oct 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlQxEFz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBA3A268
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141549; cv=none; b=sjAqZYqOsCpThbKP8yCmR2dB/1K0EQJpn3+i94e4AMRB8We2ZF+2T1fqAqYxJK+/VDqdj73Pld2SNarvvBk4YNyVL2gWt0xHf97/WEXecz1ELcieQU0+RWzehU4EoDd7NB/mlJbzdzxPZsBvFLB9QkF5DaIVGLtuG3vBsKmF1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141549; c=relaxed/simple;
	bh=ZASCXqyqeKEqmkgLJmRKVYVAx20KxDN1lRlbt5A3fTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgkkVKorZaH9/co/KxIybw3orj+HKs4ItSzYut2QBRicF7+jQME9AgwNyzPBkLo8UYE8nRi6cCED7TCXHU/uSHHKcmTgdE0yGj2ZShPjyIrXYcL7QQjDLSJPHfOpyTMAawg3i58r1eq8B88yQ//6YnC8wHjQvNpsfoaKc91cztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlQxEFz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99849C4CEC3;
	Mon, 28 Oct 2024 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141548;
	bh=ZASCXqyqeKEqmkgLJmRKVYVAx20KxDN1lRlbt5A3fTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlQxEFz7DrVnEJOW/sRypc1wm8pKWjk41lSbDk/n+rQhpZNMZFot5MSStmb4ve8yH
	 InAB8xVutdi6YWWNziUzp30uaVK8/+ZitVLZqjC9KEfOedZLuy0bl2RBxWC+Wq3UNH
	 x92KgaXo4aFxvocDOSLMBaQwfm+kql1I8QnDdNefQjtOeT4ZJdQjnnByne1vTN6lJ8
	 y5omnyXk4p+PkvfQ6WJVJ+NyLsW9jRiOer6zkJkiy1qdFcAysWXpoiaqBFMV8fjjhX
	 4HMsJzJt0kKRf7h6drgVAgmnLqTKNnZINv/ErENgCcRKlM1ejM/i2JLsCV0qBXRPdF
	 SFGnTk131IbMA==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	gcherian@marvell.com,
	sgoutham@marvell.com,
	lcherian@marvell.com
Subject: Re: [PATCH v10] perf/marvell: Marvell PEM performance monitor support
Date: Mon, 28 Oct 2024 18:52:20 +0000
Message-Id: <173013693587.4157891.11060695677574129414.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241028055309.17893-1-gthiagarajan@marvell.com>
References: <20241028055309.17893-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 11:23:09 +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters
> to monitor the data that is transmitted over the PCIe link. The
> counters track various inbound and outbound transactions which
> includes separate counters for posted/non-posted/completion TLPs.
> Also, inbound and outbound memory read requests along with their
> latencies can also be monitored. Address Translation Services(ATS)events
> such as ATS Translation, ATS Page Request, ATS Invalidation along with
> their corresponding latencies are also supported.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell: Marvell PEM performance monitor support
      https://git.kernel.org/will/c/e1dce56443a4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

