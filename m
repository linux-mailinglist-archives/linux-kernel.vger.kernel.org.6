Return-Path: <linux-kernel+bounces-299391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09D95D3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D855B254BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440518E022;
	Fri, 23 Aug 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaUltmNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4518C34C;
	Fri, 23 Aug 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432547; cv=none; b=ErEv1+b7aqL7KofGqIvcY/K4Zzkiim8yYqsflDDB3BZQQL0OIJfGEjDlUbWlaI87AZBeJSBU9QXbVcByW0xUvdOtEHRNLMDO/5rz2C3fRexbB4Jezfj5zBJxOOZL2xY5F29Pfu4Mfs2FzXHQpAImipoKOKFex0HMsGKWgBCemaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432547; c=relaxed/simple;
	bh=9A8wOi/pi4Ety14/8M1Zn6IPWDoyWzhzH6O4HjRfe1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi/mS4ZAtzColkZ6FkdeX+ehgrvf9Urk0haIbebq2MnMF2IH2Qp29mW4unzoGWMr8XsW3LqZ9MjrnXR4Ow8XtSoTGi6g8UQaCMHkeqa/zCFgSU6znmdghQnG95VZW0J2Butn4vAPZFHXgi9UBZRageLvg58yRZpek4vGzNzTSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaUltmNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12380C4AF09;
	Fri, 23 Aug 2024 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432547;
	bh=9A8wOi/pi4Ety14/8M1Zn6IPWDoyWzhzH6O4HjRfe1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaUltmNy3yG/SEp8QEXhyLKHJQG9ShdVwphXIHn+RWckWcu4Br/m+BFEn0S2ZP14z
	 95xYyeZdJZOqIUhDbTXbkNf4rV+Rq4+FC84cb2qzKc+k90mCVSyFzZIiwTX1nmV0ng
	 UK6dAfDYEiWUIfCPUISmx0c9wblg6sBewZ53ygxPcJQC1vgUFw06uIuCdAmy0Sb+bc
	 0a/avHfG2mYL+jzrNPT0F41g/IIp5tTfI4dIyHCeBNAYrBSzYl2dz5DrxzUG/cRZaI
	 uBnXAJGFveKMn5nwzNKP+0nvpZs6D/MPKJ6Sk8Ci98UuMendbk/5pHCFB6VydYoTw6
	 Vgq42RhanTSrg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Yangyu Chen <cyy@cyyself.name>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/perf: apple_m1: add known PMU events
Date: Fri, 23 Aug 2024 18:02:09 +0100
Message-Id: <172442476935.2790637.13488582005156730508.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <tencent_C5DA658E64B8D13125210C8D707CD8823F08@qq.com>
References: <tencent_C5DA658E64B8D13125210C8D707CD8823F08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 Aug 2024 11:35:18 +0900, Yangyu Chen wrote:
> This patch adds known PMU events that can be found on /usr/share/kpep in
> macOS. The m1_pmu_events and m1_pmu_event_affinity are generated from
> the script [1], which consumes the plist file from Apple. And then added
> these events to m1_pmu_perf_map and m1_pmu_event_attrs with Apple's
> documentation [2].
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: apple_m1: add known PMU events
      https://git.kernel.org/will/c/3cce331ee2a4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

