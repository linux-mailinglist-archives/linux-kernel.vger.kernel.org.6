Return-Path: <linux-kernel+bounces-315520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E096C3A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308D41C21E96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141C1E0B8E;
	Wed,  4 Sep 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtBM1+Ig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE21E0093
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466365; cv=none; b=q5gjXVfewnB3krSww2RcOCdBvkobwi0q7Et271yc0d2dMzEuP4fYEQ7hPRI0xZF/eyc8l1lpftLfqvz66pkSKTUzD3BRDCzIHRKxJE19wDBX5NOsTH/NyP0Q3n+/2PDqu/3CVY/otcqk9wR0E3AWM9NRCk4AeMBLw6uDgwXPj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466365; c=relaxed/simple;
	bh=K4U+xMtG/VY13753nyjNEpQ3nf4xDvHuJilpY9TZuHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9KPhe3JJyIJsKeYJ9TtlNbLgFL9Rl5D+oMxWvwV3beHWUMFb8P8BFPMN0Xmi323TGHR1xhhn7nOIDAHLvTNq+9FStzwh86/Fin5OLIXBYikGSo3q34MarFrwFuFC7TZURfxb2nNG6ZEGYOqG+TU4B8x3ZthyvZHfa+2lKCd1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtBM1+Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25480C4CECB;
	Wed,  4 Sep 2024 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466365;
	bh=K4U+xMtG/VY13753nyjNEpQ3nf4xDvHuJilpY9TZuHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtBM1+IgP+ckSnm58EtsxViPVFtlIB9kB2UZUEw0puF6MFfN8mew2UcBFgVBRVVDI
	 kV49WFeZ1VWV958r5YtAAR032ZIN6pdzBfbAd6tI8mIdXxvFAQViX0hQeLUG/tHeKZ
	 zWZ3qsfAofa4UjDgMFn9IY822GPlPnHobIiupkc12akzenM6cG4oL70r95beIihCx6
	 M85B2Dtwgjn2nWVoydxraUuXhpwOgvdo9B9W4g0nHzL7lQ6iKGEwZl4zqA258LYuzr
	 HgvNa24zGK8yUf3uZOm8ettTAaWlt16nYsNT9wNCUbbzsyPwHZfXvKRdILyqxAD9Ym
	 5R3iXvsY/t3vA==
From: Will Deacon <will@kernel.org>
To: Fares Mehanna <faresx@amazon.de>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	nh-open-source@amazon.com,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()
Date: Wed,  4 Sep 2024 17:12:33 +0100
Message-Id: <172546382382.2661386.11693595426476594538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240902163309.97113-1-faresx@amazon.de>
References: <20240902163309.97113-1-faresx@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Sep 2024 16:33:08 +0000, Fares Mehanna wrote:
> The reasons for PTEs in the kernel direct map to be marked invalid are not
> limited to kfence / debug pagealloc machinery. In particular,
> memfd_secret() also steals pages with set_direct_map_invalid_noflush().
> 
> When building the transitional page tables for kexec from the current
> kernel's page tables, those pages need to become regular writable pages,
> otherwise, if the relocation places kexec segments over such pages, a fault
> will occur during kexec, leading to host going dark during kexec.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()
      https://git.kernel.org/arm64/c/7eced90b202d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

