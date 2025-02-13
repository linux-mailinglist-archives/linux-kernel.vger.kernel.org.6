Return-Path: <linux-kernel+bounces-513060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91026A34135
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677C91890B88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E323A9AB;
	Thu, 13 Feb 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLNnxG+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EA2222DB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455151; cv=none; b=axd64rE/wjIl5I02bqPZEH1c+ofzp7IikWk6oyu6S9nSuZUJk35zLH9RMMxTEpv1AV95eWso5Gpxy5xfno7vNn5708G5NWQljU0wKkdphtC6YUDsJDbSW7xV4d2vJog8+NYqzGfxAQqc10eqjhnfx2vi2W0k8NN9AjkzlsxdMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455151; c=relaxed/simple;
	bh=0VaVSZ3UJsiKIWWiUS2W95oJuWLkTjylWVmIEpR7Qzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJZ9W5XBAVnbeWV0FRjr29FtZl/NFUZoG5z2HDE1Sc2qCEsF+rHRT4sKJNvw/pgfJHENuc1Nt1cOYxyFPtl7knnOugKzgP4v6voy1svQU26qBl1hpebWvWeftyt6WRlsT/ZhU+Vv/nsnEH0H/8gYKsnO0YhDNeQRF57Bs5HJFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLNnxG+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F22FC4CEE2;
	Thu, 13 Feb 2025 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739455151;
	bh=0VaVSZ3UJsiKIWWiUS2W95oJuWLkTjylWVmIEpR7Qzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLNnxG+kJLjxC9frWJNXBoDNBmDPIi+MFrypungWEHk0c10WPWpiOzi5tvjkA2OyT
	 XVNhAHhqE1y3OoOI3m4QtuX631nDsbWm8MLNwjT4/wsCCEC8+t/Dt3IJSfq5KKPj+4
	 /g1Dxab5wRtugDfxmGIKcKtONMwQAmSA17RBfhvv7c2npNpxU3g5WaaNmNTEsvc022
	 1xcBEdGRAeI7dBcJyzgTNj5lQScPKD/AZQBw6k+W0yKt13/FiAC6o6Ln0iQvd93BVc
	 G09NGJFDPyl2fJ0YZLnDLiyKpjvZhrFGNDrsLJVEMgUZ1DeOvvbb//7zMsieUJDqad
	 8dVzjqQCLX+Hw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Add missing registrations of hwcaps
Date: Thu, 13 Feb 2025 13:59:02 +0000
Message-Id: <173944518997.2607340.9811586493482464841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250212-arm64-fix-2024-dpisa-v2-1-67a1c11d6001@kernel.org>
References: <20250212-arm64-fix-2024-dpisa-v2-1-67a1c11d6001@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 00:30:42 +0000, Mark Brown wrote:
> Commit 819935464cb2 ("arm64/hwcap: Describe 2024 dpISA extensions to
> userspace") added definitions for HWCAP_FPRCVT, HWCAP_F8MM8 and
> HWCAP_F8MM4 but did not include the crucial registration in
> arm64_elf_hwcaps.  Add it.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Add missing registrations of hwcaps
      https://git.kernel.org/arm64/c/a4cc8494f1d8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

