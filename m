Return-Path: <linux-kernel+bounces-385632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CC9B39AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7DF283E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBA1DFE10;
	Mon, 28 Oct 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrtKYXjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC471DFDAF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141551; cv=none; b=Xl+dGyHRoD6UCcDk3zZ7/uBc9Gsi+FZWifuInQ2PmUCnJCcJ/zkInIdZ7ttxT/kENO1AosJZA6QIwQ63/btPvYYDaX4DtDG/q9eDNphUqHP1ao5bserzTIuJiIZxrOFfOyKQErawIw3/rnwjqLpheMF9SfhO6IeFn2At4a05rmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141551; c=relaxed/simple;
	bh=aOaHr4oONyfJNeV8zxUGMQ48BDUo4kPUaMe9VE1kEIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaMTm9mAQ5SY8h39s2LcuT8sNZOaUSyS6SXCoxB4Gb3YZADo6C6Y3ilJSLbMrbE+eHdeTUydXbdCNlx3oA9hgBB3rj3UvrBpRVtOM883hUXv6MGsxgTlLUn2zqik65EyzaG/620Y2vLL5pNCEF9VuA2AjuOCYNsL+HRIC5mASn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrtKYXjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29D2C4CEE4;
	Mon, 28 Oct 2024 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141550;
	bh=aOaHr4oONyfJNeV8zxUGMQ48BDUo4kPUaMe9VE1kEIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrtKYXjIPHN7+hSKciIP782In5nosaMgoCPNmoVqEZHzYbFxBseBaL+5hXfJQuxFd
	 ldUPyXec5fhWIXRTQukN2dtAOmH0aiFDAX8BHNnFzDpzwPPi6wTBQVvWySQo0jX6VT
	 Id8JZmhWAvZxfuQs4TR9GBHi6qEhIjaOiSpZrEzDZvsPlbMrsIvpVQJTSIYRB3wzqF
	 0dXTRk+9EDN8LfmjhByTkT9VvFlASLCw+yhuuFgkovmrVbUNY8raiuFiNBCzEjOMlo
	 XDXdXgVJ8b4LUzcfZGVExzJ/BpSF6s5ADhH00aLr7rFzvMFBcDXhhxJOJZ+ekyBeH9
	 2I2cu4Ijn/plw==
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
Date: Mon, 28 Oct 2024 18:52:21 +0000
Message-Id: <173013643645.2908148.3061264044552373982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241002184326.1105499-1-robh@kernel.org>
References: <20241002184326.1105499-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 13:43:24 -0500, Rob Herring (Arm) wrote:
> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
> access is enabled with the UEN bit in PMUSERENR_EL1 register. Individual
> counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
> set, the CR/ER bits control EL0 write access and must be set to disable
> write access.
> 
> With the access controls, the clearing of unused counters can be
> skipped.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
      https://git.kernel.org/will/c/0bbff9ed8165

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

