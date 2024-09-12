Return-Path: <linux-kernel+bounces-326544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BB9769C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037E7B2522B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAE1AAE0A;
	Thu, 12 Sep 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9fH4SmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1651A76AE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145835; cv=none; b=KX/kXUY/7ALr+M/s6yOrlUtxo42WJ2F2JAGFvsLbTOkUHGIOvK8wr46NGPk6FYA67YGZJA9J6eViuyzgFYYBoGT3HzH7xxw2afC75ec9z4RM3LANBXfgTPERR8rHzoHsE23Ka5+fGlL8k9Vn5YmRu/STYmt3mL9oeMgKuTpb9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145835; c=relaxed/simple;
	bh=avGWA2O9kXOrFmKKVVyhXbciHslv8AE0WYrUS4wqn2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COyEwa8KXh+kXY8Re1pI+KXxcytotP5X0jI1ex0QnFA/QH3saUlJK5pjoc2qK2hii+9NllYroEAywKGN0hTwc2PhNHpzDtdCWFzzkodN92u5XSFL/M2nyYegft2Km/s4DVMr20h0n0yEtJEpvMrQitzC2FQ3B8LYz9b3gC9R5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9fH4SmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BA9C4CED2;
	Thu, 12 Sep 2024 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145835;
	bh=avGWA2O9kXOrFmKKVVyhXbciHslv8AE0WYrUS4wqn2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9fH4SmLRMnsvH/5ZFOU+xO6keGY6ZyZox8BJXnivTWvCl2eAgvdreuS/KxRP37aD
	 190A6Uq+aUYs1ZZf4+iny9YBNzKUx1fGZPXCg913QTv5Ef59JHwa9EuvKx+uUgRBG/
	 qR4kCZuGNK8HDOuuU4o+9/upeB2MIW5grPOzPysgUUeF365JpANgWjCdCFAXdi4/oQ
	 pJ/IYGja4vGrbs/UZ3zYNdsClvnJ38TGzLhbHR70u18kpfifkkCzc6XoEv9ZCgS+7a
	 v7OnIOYPMEa94XCPlevxDalUW7wvnEf8NlWpCZnkKoCfBPpeB1586sTRs0Fe76WtGp
	 4YqqUSCV5UYMw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Min-Hua Chen <minhuadotchen@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hibernate: Fix warning for cast from restricted gfp_t
Date: Thu, 12 Sep 2024 13:57:07 +0100
Message-Id: <172614173906.4012598.8637645731591720864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240910232507.313555-1-minhuadotchen@gmail.com>
References: <20240910232507.313555-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 07:25:05 +0800, Min-Hua Chen wrote:
> This patch fixes the following warning by adding __force
> to the cast:
> arch/arm64/kernel/hibernate.c:410:44: sparse: warning: cast from restricted gfp_t
> 
> No functional change intended.
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: hibernate: Fix warning for cast from restricted gfp_t
      https://git.kernel.org/arm64/c/ecdd16df4564

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

