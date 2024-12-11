Return-Path: <linux-kernel+bounces-442271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAC9EDA11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7215B16749D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0381206267;
	Wed, 11 Dec 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFPfpZPn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CC20626E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956372; cv=none; b=fyV3EfeoDxxBoFJ64si0oEQArI+586scozIA3ANZ8xoso+SiIUyC749Cc8J7D/H8yBYKnX2z3du9H9ySWC8+WUHd6hvGwbX8HKXzwYzA1ubHQl5aaFFfFE/EX/scUlpC4nwTqZMMpGfwCrn/M0v3vBe8V21/sHMsAzZ9Z9heNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956372; c=relaxed/simple;
	bh=OFUDKl/zfGVkDxLHgqMZHOS0MzDnMONqvySriFeHPp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lskq0sY1o9quejfzHuUPhsJ84M+x35bA6V0XxwrUvLwvJXk6AJ7d44X21leX54yj0ylsgQ6g3IJaCu3Zrj19j3nxt0sJS0oaHZbcuXPtLs/AuLlqCd6gkwMRHjObzzayobgJNYNo0NAEDietDA9gpda2FRgH8+fPJ19FntFBDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFPfpZPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FF0C4CED2;
	Wed, 11 Dec 2024 22:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956371;
	bh=OFUDKl/zfGVkDxLHgqMZHOS0MzDnMONqvySriFeHPp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFPfpZPnfMb8GpVKtoWEoUUOzp46P1OPdg2x3WnquEHa70Gm3KUoK3prDBBttmgri
	 POJnlOPmjIPs0A0b7GMzlLSc9xoozFz/4bRTqKL7Be87NYzNneldg3Pbv67rfRs0iE
	 eD/CKd61Gho2+txPMmKMXVX4DcU97PYobMKMFMmwueAoLCN4dFZ+cBDVBJqGoRcbs9
	 zgQyRWgbrTkVEweHThpu4P1212B4wj7dXE1X0MrYPUakdt0wkUB6Caepi+n1DawbpY
	 n/9S7iLtZh2j+OfsVyFSH2V9OpgagDSWavgZNy2SqJ0+5JRApbdkWDavyJxQTC0Nyy
	 rm93Me0cAP7lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDA380A965;
	Wed, 11 Dec 2024 22:33:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] mm: Move set_pxd_safe() helpers from generic to
 platform
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638752.1729195.1601200589696534900.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:07 +0000
References: <20241003044842.246016-1-anshuman.khandual@arm.com>
In-Reply-To: <20241003044842.246016-1-anshuman.khandual@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, paul.walmsley@sifive.com,
 dave.hansen@linux.intel.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, ryan.roberts@arm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu,  3 Oct 2024 10:18:42 +0530 you wrote:
> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
> platforms, do not need to be in the common memory code. Otherwise they just
> unnecessarily make the common API more complicated. This moves the helpers
> from common code to platform instead.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] mm: Move set_pxd_safe() helpers from generic to platform
    https://git.kernel.org/riscv/c/d7d65b103901

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



