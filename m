Return-Path: <linux-kernel+bounces-438208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845859E9E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ED2166339
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC9192D66;
	Mon,  9 Dec 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1rhfG23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7307190685
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769792; cv=none; b=PG0Wf55LxdoJMlQ+pXMUt5cSrE8kTUQ9+bg0uKZvCG7J547jYdJzymbXE09HIZ2TFRQEzo0UFXyCT/8jd26k0pgdzLTUJLRS2c/Uc4v99n0w+CTsSFBabsNBfap6Yr1IbAvSN2X1tsoB8YW4EayEO9sZ5sL/erXnCVsO02FTTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769792; c=relaxed/simple;
	bh=LC1SJgB4T+PNAWsHATcRZDo1/LyTAyEATO2d1JySzuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C10JGrGa2KIyzhi1e5olxOYclmvgBBlD1OaZ0jAay4rGFpzlvqJBnZKRvU3sCku8bfegVm9f+src40jRXDursN216ui6oRF6nNb90wkDRmZE7R5VzHCfgkkE8mGH+9whvwfstCugRbmWS7WhLRCoJ/JHG5CkuRdHGRPD7wtwCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1rhfG23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ED7C4CED1;
	Mon,  9 Dec 2024 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733769792;
	bh=LC1SJgB4T+PNAWsHATcRZDo1/LyTAyEATO2d1JySzuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1rhfG23vpajMNXOrKBYnnv1IiN2DU3WYNZAZcNibospSmEVoOzqa1ZpXEzmTeTRK
	 IW5Uh+PtXUh+Za/oXb3z4sOe8mQ2VeXvuQjfWJRqkTXiPgzsS5KlHLsnpmzIoEKP9x
	 ABXBXbOwe8NR1IWlK0U9wYpMbSxbpj38ZCOIsRMwGKpyWB6kW9nPMjiy05QyfihCJi
	 1YxdWU1wGRHpgykMhPNTpkTouVAf/9G2PnAGR7dyQ2TWq8VmgL0PjbFUjKrbm1s6Ys
	 vQGG430LQ9jEhlnJngWEiYv4JQyBSd8wrwn259BiXFhqBb1j1GMvO4yMIRyqzYKVA6
	 xmnn4qPpAgu5g==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	bbhushan2@marvell.com,
	gcherian@marvell.com,
	sgoutham@marvell.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v10 0/5] Marvell Odyssey uncore performance monitor support
Date: Mon,  9 Dec 2024 18:43:02 +0000
Message-Id: <173375975929.1126639.3014797293095005520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108040619.753343-1-gthiagarajan@marvell.com>
References: <20241108040619.753343-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 09:36:14 +0530, Gowthami Thiagarajan wrote:
> Odyssey is a 64 bit ARM based SoC with multiple performance monitor
> units for various blocks.
> 
> This series of patches introduces support for uncore performance monitor
> units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
> series include the DDR PMU and LLC-TAD PMU.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/5] perf/marvell: Refactor to extract platform data - no functional change
      https://git.kernel.org/will/c/349f77e10952
[2/5] perf/marvell: Refactor to extract PMU operations
      https://git.kernel.org/will/c/0045de7e8713
[3/5] perf/marvell: Odyssey DDR Performance monitor support
      https://git.kernel.org/will/c/d950c381dce1
[4/5] perf/marvell : Refactor to extract platform data - no functional change
      https://git.kernel.org/will/c/59731e231c6f
[5/5] perf/marvell : Odyssey LLC-TAD performance monitor support
      https://git.kernel.org/will/c/5fcccba11833

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

