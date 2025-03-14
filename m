Return-Path: <linux-kernel+bounces-561977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E2A6199E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774A919C6A82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC2200B8C;
	Fri, 14 Mar 2025 18:37:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BA43169
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977465; cv=none; b=GE+xi/sxPmMZIFAC43iAuxAvXSKK9Ju34sJfU2P19PenX33593pDIpmpLlDCF05Pw5+pl4nXk/ruqbOJ+/JCfEdfzeLLyDDNkBePGmEeIyDTBDfXEpSu9YIKJV22tn+O4yUbx4OvGH7ZsAaQ0VWFsYPM9Bz6Tlc3jQFeQZuC0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977465; c=relaxed/simple;
	bh=p2yRpDdz5CLF+9HAM4qPs8IFakltxOYhSQ9nVT5oSK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6cGmxhvjHjvAzpPshIpcLKRyYV8B6JXhuinuhZt9P6eoPxEBt6qD1a9qBpbiatCvwFpJ0z7jYs3nk66ovZ+0rU92asEbiiJXD/Z7OPQaSg1Li4KLlHcDGl26TgK4MXekydiKajhl4KQ7VY9049cgohbL8ACQigDjynY2n0WS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0F7C4CEE3;
	Fri, 14 Mar 2025 18:37:42 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH V3] arm64/mm: Define PTDESC_ORDER
Date: Fri, 14 Mar 2025 18:37:39 +0000
Message-Id: <174197745246.735540.15365076503205188211.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311045710.550625-1-anshuman.khandual@arm.com>
References: <20250311045710.550625-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 10:27:10 +0530, Anshuman Khandual wrote:
> Address bytes shifted with a single 64 bit page table entry (any page table
> level) has been always hard coded as 3 (aka 2^3 = 8). Although intuitive it
> is not very readable or easy to reason about. Besides it is going to change
> with D128, where each 128 bit page table entry will shift address bytes by
> 4 (aka 2^4 = 16) instead.
> 
> Let's just formalise this address bytes shift value into a new macro called
> PTDESC_ORDER establishing a logical abstraction, thus improving readability
> as well. While here re-organize EARLY_LEVEL macro along with its dependents
> for better clarity. This does not cause any functional change. Also replace
> all (PAGE_SHIFT - PTDESC_ORDER) instances with PTDESC_TABLE_SHIFT.
> 
> [...]

Applied to arm64 (for-next/pgtable-cleanups), thanks!

[1/1] arm64/mm: Define PTDESC_ORDER
      https://git.kernel.org/arm64/c/51ecb29f7a65

-- 
Catalin


