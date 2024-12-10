Return-Path: <linux-kernel+bounces-438617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711519EA38C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5316B165829
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D73D3B8;
	Tue, 10 Dec 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6UtlgPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588E8BEE;
	Tue, 10 Dec 2024 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789873; cv=none; b=I3rNTto1sgD+D794C+DKnXsrmDOkt9EQfUbo9Ed+DB2dVdFf3DvMpfPf42Op9kDbF7Wv0wt0+NNbyuR/lib82yMZF7qj8KBldhzk4nRmEwGUuepE9UOlcs6OCAvVERI0MB+MLHfZhNiPjEfd+vyo4tO0uDTGwFOSD0C0vDj8o5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789873; c=relaxed/simple;
	bh=lHNoDuFE4BbrRmLOpkIFrKSiLXZ6f2Hc2Ut7zyg9UtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX+X/fKKXecCHGls4jNu1e+SKUCEekl/PoibB0ptkceIOE0k8MpCxVeubUtuTVWGnPSrSu6Ugh4LMGKgypq39vkMn3SeyL21B7cfaZEjXJshTgiF6JjxNG6v9Sv2CTium24x+EvWh9/uMvfax9Q36NjOGAIG6YzoBj5f5syLey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6UtlgPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453F9C4CEE0;
	Tue, 10 Dec 2024 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789873;
	bh=lHNoDuFE4BbrRmLOpkIFrKSiLXZ6f2Hc2Ut7zyg9UtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6UtlgPIxaWo/ZGTtJPcceN+J/l43TW5cZzV9b30cGzrC/rjk2NWg1Kd0u2BpF+Jn
	 Z7CnVT+uKwbIdPeDNKEQf9YedUvQMf7bcT+36axwlROwWqIcYmBMF/Cv/wUWpbG1Np
	 796e49XyclpypUFpHIAvKkMlKyuE5x1wZnBgSpYpZRJqTtpFrg3zaRZd0XDY3DnWIp
	 3cq1JJ7PgJfbbLAVczN6d2wEu41P5ec5xBx0le/lVjpz5XIaCYg0Qx7F47RF9d0abO
	 /nHaibAPFP4dIqMIEM0k6Bmda++dDaQdpDv30rqyEQtDboRjJGSXv7eraOSob7M3x8
	 pUggVbXUPvrvw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 0/2] Fix missing case for concatenation
Date: Tue, 10 Dec 2024 00:17:32 +0000
Message-Id: <173378764988.2164600.15198070609246396646.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241202140604.422235-1-smostafa@google.com>
References: <20241202140604.422235-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 14:06:02 +0000, Mostafa Saleh wrote:
> First patch fixes a missing case for 16K granule and 40 bits SMMUs
> where concatenation is mandatory but ignored.
> 
> Second patch, imporves coverage of OAS in selftests to make it
> possible to test all concatenation cases.
> 
> Cc: Daniel Mentz <danielmentz@google.com>
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K
      https://git.kernel.org/will/c/4dcac8407fe1
[2/2] iommu/io-pgtable-arm: Add coverage for different OAS in selftest
      https://git.kernel.org/will/c/376ce8b35ed1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

