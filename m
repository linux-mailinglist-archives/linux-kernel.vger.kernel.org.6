Return-Path: <linux-kernel+bounces-331720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED397B074
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D0EB2A797
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F0817C9A7;
	Tue, 17 Sep 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edSpS4QJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270617BECC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578045; cv=none; b=kHmA2rZ2OYtWvh0IKBgPidQFgXe6lZkByfxiaBo8owSpAGzWhTfr2FX4jqGmtsIQwWwzn6sjVhPlJwbqG43oYz1jOxsITLftRLQ9lj7yZAcHxT+94C2U7+JcDjqUH3tKWsKXKvte+6ZcFnWWeBMfYK0ZqU2TtqNmM9v9WxDmI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578045; c=relaxed/simple;
	bh=n8Buve7v1KrmZohbeNemU9LWq7WmgDsBpw1Q2CjmTxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q7WwCWaiHSrP19Yh1BOV88+qVJpQDHAQDS7Gwer8io/GR41vAvmSWc77mNx+tUCIxEhDfxDZUF5i+tFbf9LZkols1v26HaDilyUMCa61UrDTcXalxVmpokwJWxoZL66xxQZzwlHpfGejrsslDp0Xew75mQDczmcxqyh3frTYArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edSpS4QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470EFC4CECD;
	Tue, 17 Sep 2024 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578045;
	bh=n8Buve7v1KrmZohbeNemU9LWq7WmgDsBpw1Q2CjmTxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=edSpS4QJohj07aHxjoSzDggdPKjWjAkU9VnAuFujcrXntQkIVw8rJVGHGOyez3U7T
	 cnmmzB4KTwAUBOdUxNbcDcmlXQSjdFZz+cneoGYWBc93Ym1TdCqEQzWCFIhwTkk08E
	 JuBtMLnQLvrfeYUemoF1B80F9VXEIQ8ZJJJMHyITAEgxbL9n9N9N6jHGMiJHWRlLnU
	 TEF5dTLI8qwzg6g4PeNwa1fA0FqjPLgS+lWjX31p9sBDpUFZomwtgHmIVtKMgb4+Rk
	 jyuXM49n8Q9l+uDcHmmoAkqD4G+wFVULbRh4caj9yzvVBKRBKGxIFv+wX8HnQ2461F
	 pvWoJrXWi7M/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B563809A80;
	Tue, 17 Sep 2024 13:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804700.126252.3532222769922306946.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:47 +0000
References: <20240611040947.3024710-1-changbin.du@huawei.com>
In-Reply-To: <20240611040947.3024710-1-changbin.du@huawei.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 11 Jun 2024 12:09:47 +0800 you wrote:
> The vdso.so.dbg is a debug version of vdso and could be used for debugging
> purpose. For example, perf-annotate requires debugging info to show source
> lines. So let's keep its debugging info.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: vdso: do not strip debugging info for vdso.so.dbg
    https://git.kernel.org/riscv/c/7587a3602bf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



