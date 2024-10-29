Return-Path: <linux-kernel+bounces-387288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78899B4F10
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC2283A26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8B199E80;
	Tue, 29 Oct 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbmcWUgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFCF1993B5;
	Tue, 29 Oct 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218525; cv=none; b=adgyyxUk1eEG+t3JIsmYeIg4MIrov8fxgtg7TZirEwWPwNPQ1DDHccyoF3anefFGLvUwT7xhWQV39AvYh8yFU8jN4vhZCKPpFqY/UuPtB/LvfyAgC8p8SbBiQY6+K+GMMhCwByIfk3Yf3ax/nN/wjCRricLgFEDDsiACwogWfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218525; c=relaxed/simple;
	bh=zEPDtk5TnMn87cqOQA+7VFLwOc6B9MRUG+kIZzLuyKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI2wcuT98aAgA8ulRpiFUaLNkDJOjTouy7xgQBFfTPGw+GGwGMy2OxCoORgZDDFEucO6e5ug5iVZZJGD+ACIcscU1CjkRZrlfPhSljenRFNLeDIcxLADMT23E2HrQsRu7sYYqil+XjhwMBW2cpoxtl22WSajRLW/7sOJ7cHGXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbmcWUgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4A0C4CEE5;
	Tue, 29 Oct 2024 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218524;
	bh=zEPDtk5TnMn87cqOQA+7VFLwOc6B9MRUG+kIZzLuyKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbmcWUgrknm0c514v50ZvjGrH4ut/pbtRj42Na6lROTN0QW662wkdQhF5yllsmfin
	 /PMvYnv3psjJVXDFey0547QZp3zU/YthaLkDvqeRTXopuYK9y2P9MN7/XXtgIhZ9SG
	 5NPUZix1hpVFUZKlfmvwj0QoQRysPGcngyKzojspn2/bOg8oZSJte/jyz+GNxHIJQD
	 56BOx0x/6uakdcUciMRBk+5ZzEwtXAAHXBlIrA7XdO9HTdr/XDkibH3OeHFyUO/FVn
	 jWSZnRvVUqJFPCO6sTSTDFKxwgVbPp4Zqdetv2PW+v4F/T6mpXGxVBVukEd6Wqz+/2
	 qsQ+VnuO7q8dA==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markuss Broks <markuss.broks@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Maksym Holovach <nergzd@nergzd723.xyz>
Subject: Re: [PATCH 0/2] arm_pmuv3: Add support for Samsung Mongoose PMU
Date: Tue, 29 Oct 2024 16:15:12 +0000
Message-Id: <173020820622.2331895.8950833346976223210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
References: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 23:28:07 +0300, Markuss Broks wrote:
> This series adds support to performance monitoring unit of
> the Samsung Mongoose CPU cores. They were released between
> 2016 and 2020, and they were used in Samsung Exynos SoCs,
> such as Exynos 8890, 8895, 9810, 9820 and 990 (9830).
> They implement ARMv8.2-A ISA and they are used as a fast
> cluster (big in the big.little scheme).
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] dt-bindings: arm: pmu: Add Samsung Mongoose core compatible
      https://git.kernel.org/will/c/3930c88ad0a5
[2/2] perf: arm_pmuv3: Add support for Samsung Mongoose PMU
      https://git.kernel.org/will/c/9643aaa19473

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

