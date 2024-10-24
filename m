Return-Path: <linux-kernel+bounces-380439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA389AEE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6D28102A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435E1FBF78;
	Thu, 24 Oct 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt0no7hu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F361FAC42;
	Thu, 24 Oct 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792230; cv=none; b=aOJRScn/DquHWV/BvqKthAMWZtdOV87f4D3g+RUhvP1dpF/aYEnodHBQ50gfhbDOmgFOwNNHhLZfgpZfVl5l0YJ+cT5Tv7Vy0vrgeCtp1J6Mx4p/cUdEz+BoWFBH98sCp4Nbu7qQz1eGuxdCgWb5/fpiryoS1uWCI7JzQX66tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792230; c=relaxed/simple;
	bh=+pour6+YaY4SzcGtmHKUEsoWqxLHnGev4U90Wz9GqWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDMvbfQT8y5ER+N6RSzddq1mXTcXxIG0IDVJoSglmcyQP0qMOy2xo0YMwoANyrEdhnzTzLUc/Rkzzyy73qxVaLzeBLOaxRTSG9ODHCfHOpMlptSIxa/DtVut2K283P96yurwABp9UxpXGxRQQZRVhiyTZWn3EJYo7ahLUGKOu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt0no7hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CE8C4CEC7;
	Thu, 24 Oct 2024 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792230;
	bh=+pour6+YaY4SzcGtmHKUEsoWqxLHnGev4U90Wz9GqWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jt0no7hu3EJee0+p6oplwAw0WkGxRbl2JJTr4Ew8EqfROaafkBkgNThAn/EyJotU+
	 9fl7RnmrM8Gcd3sBHHUjjKMU4wFtXhVAv6TnyMVnaMxjVus9h3rAIRyXcAPuV6kGHz
	 3bo1dRPwQ8bS4c7WyKL8h/zkh+5nC3qReYjgJ0jYJcrw2rUEpZ3+29xes5x3hXxSuJ
	 fgSwqyOcq2ig3NkhpNxbF4r9usyGUii3CO3mZGT4yQH/fGXj5j2iRNhegvuKgLjX0K
	 /VTZv1UEq04pt2Lg4slJgGb4AID7RX/sKRzEONnWq/4segO/p5k8t7AvLj8VGrJj+d
	 8L3bbTcPTHp1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F8A380DBDC;
	Thu, 24 Oct 2024 17:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/6] RISC-V: Detect and report speed of unaligned vector
 accesses
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979223702.2327357.3480935063596875410.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 17:50:37 +0000
References: <20240820152424.1973078-1-jesse@rivosinc.com>
In-Reply-To: <20240820152424.1973078-1-jesse@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, cleger@rivosinc.com, evan@rivosinc.com,
 ajones@ventanamicro.com, charlie@rivosinc.com, xiao.w.wang@intel.com,
 andy.chiu@sifive.com, ebiggers@google.com, greentime.hu@sifive.com,
 bjorn@rivosinc.com, heiko@sntech.de, costa.shul@redhat.com,
 akpm@linux-foundation.org, bhe@redhat.com, apatel@ventanamicro.com,
 zong.li@sifive.com, samitolvanen@google.com, ben.dooks@codethink.co.uk,
 alexghiti@rivosinc.com, gustavoars@kernel.org, erick.archer@gmx.com,
 j.granados@samsung.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 20 Aug 2024 11:24:18 -0400 you wrote:
> Adds support for detecting and reporting the speed of unaligned vector
> accesses on RISC-V CPUs. Adds vec_misaligned_speed key to the hwprobe
> adds Zicclsm to cpufeature and fixes the check for scalar unaligned
> emulated all CPUs. The vec_misaligned_speed key keeps the same format
> as the scalar unaligned access speed key.
> 
> This set does not emulate unaligned vector accesses on CPUs that do not
> support them. Only reports if userspace can run them and speed of
> unaligned vector accesses if supported.
> 
> [...]

Here is the summary with links:
  - [v9,1/6] RISC-V: Check scalar unaligned access on all CPUs
    https://git.kernel.org/riscv/c/8d20a739f17a
  - [v9,2/6] RISC-V: Scalar unaligned access emulated on hotplug CPUs
    https://git.kernel.org/riscv/c/9c528b5f7927
  - [v9,3/6] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
    https://git.kernel.org/riscv/c/c05a62c92516
  - [v9,4/6] RISC-V: Detect unaligned vector accesses supported
    (no matching commit)
  - [v9,5/6] RISC-V: Report vector unaligned access speed hwprobe
    https://git.kernel.org/riscv/c/e7c9d66e313b
  - [v9,6/6] RISC-V: hwprobe: Document unaligned vector perf key
    https://git.kernel.org/riscv/c/40e09ebd791f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



