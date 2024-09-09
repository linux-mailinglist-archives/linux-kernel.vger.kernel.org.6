Return-Path: <linux-kernel+bounces-321753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706E971EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93171B22895
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1895148841;
	Mon,  9 Sep 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edQtmdIL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A413DDA3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898565; cv=none; b=gMA8IKa64/bE1TyWLB63hZv8inHeoauJ4dal8RUcB9DFrBfclCsnw0DwdLmOPXO+Q4y+8+tmMtVtKUqJCNq8hv6DjvjSNEuvM8nA0rEVq4EvAZLO0308XL+jNz0BAg1Yy5DeDdudJZI6zZj92SC8VWjbIdwiFDY5o/FoP19r+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898565; c=relaxed/simple;
	bh=meu7haalnve314o2vBN3hToN6hjtT5v/tdytDzKYBEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQFJzc3T+TmQ6KPfrvj89/0SiNrQ8QDWp88MbJ2X+KshxlLMd99KWMqJYBq3SZJhUeDhAqD08A7k3ULL5YQhXjomC7Js1pvoABZTlY3yawWSOvez4Pf5KpFXgHp0uA6QqzlkG6BdfJA9pqqIftDzW9eSJaX6OgV1Mva5Inepe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edQtmdIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3837CC4CECE;
	Mon,  9 Sep 2024 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898564;
	bh=meu7haalnve314o2vBN3hToN6hjtT5v/tdytDzKYBEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edQtmdILdozE8NKyE39+MJMrGzG5CnsUa1AyNUG6jbVNWBnngyTN5RLo5OPloE8Gn
	 SndcDDbQlY6k5wu/rHS9iLyUf7XC+i2NM4I3aT4VmMOJJg835v96qx7aBBy3pteM1/
	 ltAdZQbEeOz736/+L4NryNIfBXqu3H/0kDAND6GOUr1GzSzhGrQYwT25wMg9rLbDKT
	 BldglAdi4pa9FiZIsCjWzKXg/wC7YQXMRv/45vlTmCBauLgl70r5gYRvZm5lCxicOU
	 cN/tpdyHz32QTLahPelYOEz9ZZXJzIAgqtkvu+CqSedDNsiG0uOJp540jU7zgur9ds
	 Tca3KPuFq/qZg==
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if enabled
Date: Mon,  9 Sep 2024 17:15:45 +0100
Message-Id: <172589208379.2624830.5787093091293049008.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240906191539.4847-1-ilkka@os.amperecomputing.com>
References: <20240906191539.4847-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 06 Sep 2024 12:15:39 -0700, Ilkka Koskinen wrote:
> The PMU driver attempts to use PC_WRITE_RETIRED for the HW branch event,
> if enabled. However, PC_WRITE_RETIRED counts only taken branches,
> whereas BR_RETIRED counts also non-taken ones.
> 
> Furthermore, perf uses HW branch event to calculate branch misses ratio,
> implying BR_RETIRED is the correct event to count.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if enabled
      https://git.kernel.org/will/c/5967a19f1c2f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

