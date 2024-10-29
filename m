Return-Path: <linux-kernel+bounces-387287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59D9B4F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D851F2473D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3304198A1A;
	Tue, 29 Oct 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNJ97eIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64A192D68
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218522; cv=none; b=vFmexVi58JPIn4Vz53SRnjuBumW4Q7yz6ReOhUD2gt/Ep6ikXWR7AdHxmuStazX8vV4ELpRN4xgVAF8UB3/w4x80SX6zVJLjhHZ3fNUi23m8FCUGxat5q2iqFjAOlS8DIEq58vf9ix5BqmQuii2RpLPoZgO1YCE0zk/oSDQzWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218522; c=relaxed/simple;
	bh=YptWnvqJ0yTWJb6UsizDcng82GAKFuaTQk2qXPmbjwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0edBqKVbH/apikGgTSsPg7HL0r8zrdEO5sfNWBnaXQ451V+vJ5jNZJNDDS+NV/2cKoU9sn5huOIYILqfr1bHpiO6hxWVZa/NuoYbnPDcBSMYY5SR0OC6FIYvJq/EEU2HCmFdD33jWLKjvPMzTrjJRWyFiL7GIDUtvtjFtIn0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNJ97eIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E56C4CECD;
	Tue, 29 Oct 2024 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218521;
	bh=YptWnvqJ0yTWJb6UsizDcng82GAKFuaTQk2qXPmbjwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNJ97eIZ6jVRcS6EPWqL06OPQKQXmtE8ivR6KGn8z7ZalZCCPx/xgfJeBsEnAWV6k
	 8TuLm7pwqJ5W5TMlpvRDEaOy7xuBY8WsnPjTz8FGid6G7qgTqcxgKVBq+xbJM2VY45
	 KmMnkFTDOTz9qV3ausgCYLHr0X2yNiOQ6gG7YcydjO65dkVSUA1sH0G91wrca2MCMO
	 AaQN+Y0RHEOMA0dXv39AbisX6F96Kekg/EcmA/S18stM2ymqIGisMpJmj2Irkr77Ug
	 LrluKJmnyTSKVQxC+xKYLR3N/SKxqe/cJAXktYjW/+a+F4q/i9g7H9qs/0jhLQhX8z
	 wvu6vN0t71JeQ==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/dwc_pcie: Enable DesignWare PCIe PMU on Ampere SoCs
Date: Tue, 29 Oct 2024 16:15:11 +0000
Message-Id: <173020687559.2330125.6919585782024497615.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 23:18:21 +0000, Ilkka Koskinen wrote:
> Enable DesignWare PCIe PMU driver on Ampere SoC. In addition, load the
> driver automatically, if the system has a PCI bridge by Ampere
> 
> Ilkka Koskinen (3):
>   perf/dwc_pcie: Add support for Ampere SoCs
>   perf/dwc_pcie: Load DesignWare PCIe PMU driver automatically on Ampere
>     SoCs
>   perf/dwc_pcie: Fix typos in event names
> 
> [...]

Applied 1 and 3 to will (for-next/perf), thanks!

[1/3] perf/dwc_pcie: Add support for Ampere SoCs
      https://git.kernel.org/will/c/83d511c3ca0c

[3/3] perf/dwc_pcie: Fix typos in event names
      https://git.kernel.org/will/c/94b3ad10c2e1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

