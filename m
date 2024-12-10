Return-Path: <linux-kernel+bounces-440140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB79EB966
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B52E28271D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783B199951;
	Tue, 10 Dec 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlGhKCUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502E214207
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855699; cv=none; b=Gwf7b8dNL5W7rP66l9+Lpm5JV/TeDgWlZ8hgS408hCJ1KYOHuQcGJ8el9BWbPWsNEuIItMNV6vhmpjQJbDjzUgKWU/N3Zx4QjNwqBotHsPM48NuArRClahzhsSfb+x+Go+TPNhP/wsek5Hsjv1d09Wwy4lt3SSIjH1bnge0MsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855699; c=relaxed/simple;
	bh=zYJk1YUuU4g7BvRhCqPEyANMPM9cSeVoWwQIsesbzCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FARASU6nYOLC4txdWZoh+0gMzvlHsEFTQVdgyiruIZuKNCmKaYlMSg0wy20j1a6c22fvVIuvFFRI9nlWCxWlRXJbJV8ZMryQ5Zn8VGrjRtYzqCJWG6YWDZzWNPGtdjOQ9NsXEeeGRHscidgTQuBKoKZ44lUSCn2IYp4K4IYFnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlGhKCUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C74C4CEDD;
	Tue, 10 Dec 2024 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855698;
	bh=zYJk1YUuU4g7BvRhCqPEyANMPM9cSeVoWwQIsesbzCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlGhKCUK7ki8Y7e9xyHsYrMOgnAWdxv21KW5DbSwbPMDZqA5oY8aGRBn+ema35uIP
	 szN8wWPgQW5+L0lADzS+gIWn3CsLxRRfJwjXoCZOgErPWeWY9PoLAa1+t20FDlYbuf
	 /mstAiR/E3e/O7wWFO+fMDnQN0NwtMgR7yuGFXjDG0Kj9BXZpUA3C/fi8Or8pUol58
	 dss2jiagI00yTOyjb+wgnfoXQa7IcZz4wgalxZqO1WnokFTXD/w12MU74zCZKvyYv2
	 Pe+hyPVdV2x5UJHFvEma0hW1emjGrWqZD0xpyQINLepm/Vwdr4Rr6A1/4mjsBtQsDk
	 gk0GZ/DIgnRjg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Replace open encodings with PXD_TABLE_BIT
Date: Tue, 10 Dec 2024 18:34:44 +0000
Message-Id: <173383037764.3807705.806887970785893565.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241202083850.73207-1-anshuman.khandual@arm.com>
References: <20241202083850.73207-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 14:08:50 +0530, Anshuman Khandual wrote:
> [pgd|p4d]_bad() helpers have open encodings for their respective table bits
> which can be replaced with corresponding macros. This makes things clearer,
> thus improving their readability as well.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Replace open encodings with PXD_TABLE_BIT
      https://git.kernel.org/arm64/c/a0e33f528e09

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

