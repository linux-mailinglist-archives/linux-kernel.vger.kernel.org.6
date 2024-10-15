Return-Path: <linux-kernel+bounces-365790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D399E9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE281F22C94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA822739F;
	Tue, 15 Oct 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwV3hPt4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A981D9A5F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995957; cv=none; b=koOKZFvG6fJmxhcKs34xpG+mKQ8iZ93A38HaZ0Yt2BFqUkt8BLyyS6IM6PMnqJPjOioYT9Hz1b+E/rdzUpC1LVJk4f0bcq0aNRychc7cqXVFvnhPMRMN+lldVH7GxZAnIah04x5X1MPSXsZmeRcVvxCP8enO/ewd3bc38hdYlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995957; c=relaxed/simple;
	bh=e2QA9KcgtrJ8qw+0ksp2Ed9LkFKZ/Fnpb0ZXoxI/s5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVgQgm1uJTOaDehYhfAfWd431ScI1lfYparu9U4OUc0kMHVgiG1FjJMrMGJka50u2unPecjj7E5TEnO+3XhGERlqUzxo0rBpiZxiPkhvOPtdTDQoD5dVDmhY0fXbU5cTFO8GlsRRoJfL6A34as8JaB3Ke+Xn3Lpju7cvWJyKZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwV3hPt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683A1C4CEC6;
	Tue, 15 Oct 2024 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728995956;
	bh=e2QA9KcgtrJ8qw+0ksp2Ed9LkFKZ/Fnpb0ZXoxI/s5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwV3hPt4bT0YLluSmDGMDvgSXiESq+zgVIOoOZX3xVf7YsVH3vTzXP4F4MlCXiCvQ
	 qdXu089G/hxdFXNpdUNNgPIc+KXWQCCMSx20wDee1i33zURVk5pUluYLPxdRK7uXBw
	 TxAqBVkQfQXCWFQbqw75TA9yNfaV7fYJit//mIhmZ2TKF3Pg5rM1g3UAfB+FT2g5t3
	 RESvNVZnplAc1Gzu1zGkK+eE+95/VGEywpH/PR+UbKKJ2IIzgmnUU24Cv53mqKIl8D
	 U/MndD9Q7Uzf/9ZYAI/Knw2ckXmfeDnnEcJHOV5kN4ZbZ+vyHiNnRZ9p6SmYKncllX
	 pU90uIFI8olmA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
Date: Tue, 15 Oct 2024 13:39:08 +0100
Message-Id: <172898869113.658437.16326042568646594201.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241014161100.18034-1-will@kernel.org>
References: <20241014161100.18034-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Oct 2024 17:11:00 +0100, Will Deacon wrote:
> Syzbot reports a KASAN failure early during boot on arm64 when building
> with GCC 12.2.0 and using the Software Tag-Based KASAN mode:
> 
>   | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>   | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>   | Write of size 4 at addr 03ff800086867e00 by task swapper/0
>   | Pointer tag: [03], memory tag: [fe]
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] kasan: Disable Software Tag-Based KASAN with GCC
      https://git.kernel.org/arm64/c/7aed6a2c51ff

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

