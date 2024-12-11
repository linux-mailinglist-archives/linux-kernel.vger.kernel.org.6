Return-Path: <linux-kernel+bounces-442268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9A9EDA09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F22280C46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BC204C30;
	Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXv2yfYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B810203D6F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956365; cv=none; b=hVLvNQZIf+2430qRyYUDwrF8pN7F7rmZIYNAcuO0aZ3aim3ilt8WTPPaa+VzDGh7aONHt3+i1kxSCfrWYt07JXijdtqoawrAOOx7VneiQuZ75injL2sPa+LYSEX/mHqD2nbjUOhSDyodgYDyeSr6m0ynOdXTBbPNIudBk4jqLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956365; c=relaxed/simple;
	bh=iRwxC1s0tO/FMsHuvL9jXdyPxujIqKEggAX45W0Slqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TglqRPgeU+2BJc0mLpsXnWcGpYe8pHZ7nM94dZRBdfBADs4BKpJXrTr+gwAk/Wg8s+zFCqdcgz3v56s+3RoQlqNL30sIaQiencscEh7wDWn/Iwc3P536d/LVrfJ45YckN8BPNYQrv9ksmUGgRb3jphd6/JUc2Ba9kEE9PG5U8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXv2yfYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D83C4CED3;
	Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956364;
	bh=iRwxC1s0tO/FMsHuvL9jXdyPxujIqKEggAX45W0Slqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gXv2yfYI3u6DpqV1QgWdlFHngfCsoqTqn8qFlW9vmxnxqkmi2e0lXapKqCP1xq6Sq
	 m27jAoArETLE59h3MnbPfeV3Du7pXd51diP7+E1kuOCkhI7BhHN3DecsGyqg69HYCz
	 4dtnfhgmCNmsRYRIPBaEYy8l1+tEE1pvCJwTuJ6jZQE2vL5C5Y4TlG7IFgF7jCU0ML
	 EPY3X047UtqYUWAN70PGlmC02VnScPkoy5P16UdK6QQNkRg9BsWNI2Pw7GnLtv9JBW
	 l0EMIp8cQD51ifM8V58DpUd37Lm02CBpfUmo+wcLANw+3geztRTyBkXlx98+9U2bsW
	 EaiC7JsiZtyNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAA4380A965;
	Wed, 11 Dec 2024 22:33:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH fixes] riscv: mm: Do not call pmd dtor on vmemmap page table
 teardown
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638049.1729195.5190256802330820237.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:00 +0000
References: <20241120131203.1859787-1-bjorn@kernel.org>
In-Reply-To: <20241120131203.1859787-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 aou@eecs.berkeley.edu, david@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, osalvador@suse.de, bjorn@rivosinc.com,
 abrestic@rivosinc.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Nov 2024 14:12:02 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The vmemmap's, which is used for RV64 with SPARSEMEM_VMEMMAP, page
> tables are populated using pmd (page middle directory) hugetables.
> However, the pmd allocation is not using the generic mechanism used by
> the VMA code (e.g. pmd_alloc()), or the RISC-V specific
> create_pgd_mapping()/alloc_pmd_late(). Instead, the vmemmap page table
> code allocates a page, and calls vmemmap_set_pmd(). This results in
> that the pmd ctor is *not* called, nor would it make sense to do so.
> 
> [...]

Here is the summary with links:
  - [fixes] riscv: mm: Do not call pmd dtor on vmemmap page table teardown
    https://git.kernel.org/riscv/c/21f1b85c8912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



