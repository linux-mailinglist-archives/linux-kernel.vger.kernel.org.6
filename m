Return-Path: <linux-kernel+bounces-514639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E21A359A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09B03AD78A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D122A4C3;
	Fri, 14 Feb 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PysVsZ7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A49211497
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524023; cv=none; b=DQHchBVFqhDlw8dxC9up4dBCNYcmrpieXvNu0Dg8vVVzfzuPtXcKWOcWbkecVhmrYc/A+aHWkT7t8fTR9a2nlfYg5GHYmivB2vL603xYY4j79RhA0CpP/BnWnqBMRIg3lVuBZXIWPuN4u49EP11OIO6LyM6VDbDaFnJkCI+p9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524023; c=relaxed/simple;
	bh=E2vDahFc9gmEXv67G1ApHZCwpC4OoKZqSbjlqr99C18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rwe/hA4SiXWttX/mdLoINBVEc3LmKx+I+OKjFwubhss4He4kWhcDEY/iOk3UBkSO5/B/j7dGKMnFV1MVz5A9fLFy1GO2E7219APlElnPMTjcgDxzvRHCWfesSVoJNijeakjoAh/li/UURT4K5VcRdklFI5Lx8xuuvTQiWQZyCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PysVsZ7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BCDC4CED1;
	Fri, 14 Feb 2025 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524022;
	bh=E2vDahFc9gmEXv67G1ApHZCwpC4OoKZqSbjlqr99C18=;
	h=From:To:Cc:Subject:Date:From;
	b=PysVsZ7qY61sOWX13NixqHz5dkiOWNFOBvRtbkv6CUF2PQ38kwBpb7NjCkUOs/qGJ
	 yhGuEOd2407ICA7WdLK3FZvz5HkfSwNXaKU4B8NoqHa0Om3G0wa/DfdsO1GFv8um9f
	 mpR4dFrhF9AXIiq1bYWg/MIUv2ZyPT5B7BQgsmletFCrEi3RLzCrQxCnfgT5GSLUTj
	 pOARaCTHIPEMzYcLeHNW9JiIuHoSZMpp8gwryUU5TLTt80Rad75rq9uCdQZVNsWfBw
	 6gsBgR8eC8LWwQd+CpzNVTHdnkV9O6KtvV49U9X7NT+EfX//kb1d6EpbzbK8BNP0dC
	 /mwY5E7wuvwtw==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [RESEND PATCH v2 0/4] x86/boot: a few cleanups
Date: Fri, 14 Feb 2025 11:06:47 +0200
Message-ID: <20250214090651.3331663-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches cleanup x86::setup_arch() and e820.c.
No functional changes intended.

This is a resend of v2 rebased on v6.14-rc2

v2: update comments as suggested by Ingo
v1: https://lore.kernel.org/all/20241203112525.591496-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  x86/boot: move setting of memblock parameters to e820__memblock_setup()
  x86/boot: split kernel resources setup into a helper function
  x86/boot: split parsing of boot_params into a helper function
  x86/e820: drop E820_TYPE_RESERVED_KERN and related code

 arch/x86/include/asm/e820/api.h   |   1 -
 arch/x86/include/asm/e820/types.h |   9 --
 arch/x86/kernel/e820.c            |  95 ++++++++-------------
 arch/x86/kernel/setup.c           | 134 ++++++++++++++----------------
 arch/x86/kernel/tboot.c           |   3 +-
 arch/x86/mm/init_64.c             |   8 --
 6 files changed, 97 insertions(+), 153 deletions(-)


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.47.2


