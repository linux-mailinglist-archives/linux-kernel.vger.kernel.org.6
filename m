Return-Path: <linux-kernel+bounces-423153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F919DA38A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC08166432
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D721741D2;
	Wed, 27 Nov 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2QVLjQE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC1F9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694802; cv=none; b=G7rUgGFrQwf25no62yco+nsTm0WQ7Ts73k/MP6yYyANeSrd89ywL+G7+R5LJxspA+MPMEU5hFgpbOdPaW15r2PosZfs8fW2rP+fofqCr/AwYisSMwQdR6P86j8pttyhMfcYud8WLk//pavAh8552DbempKT6lssl6NgliAq3HUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694802; c=relaxed/simple;
	bh=Ek8vEifdbPNiBw6MTbJKFC4ICxvojIvzuAXXimTkbeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DkNGcB9AJGPAz+WVH35s/oEMkjX4qmO5CEs4phq9G2KX7kZOx38TDdRC4BDb1EuV5FGkhudEZHn7ctfWLZzzJbfZAV0rQJ2vZBIUXsNJuS+UB1LThNlYH1zL0R1lrIKJhHZJic5F/o9olct8OTtgTsLXriV+VC09AyPDheIT65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2QVLjQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3912C4CECC;
	Wed, 27 Nov 2024 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732694801;
	bh=Ek8vEifdbPNiBw6MTbJKFC4ICxvojIvzuAXXimTkbeM=;
	h=Date:From:To:Cc:Subject:From;
	b=F2QVLjQEiWX2JpRM9gXVfUxg++SdfsSB1sxvDBRATmzPQ5ryaiy8OQtL4h6qFbQUD
	 7l/vix7zquVTGkmhnkMGWNjYnRMn+4qkQrrl7aqbdFxdbjOsjC2z2GhA7iFaieQzEP
	 UhRIsH6omZnGS59jyAqAAEfAgexgsdZkgRW0qTqPPyF/PcVLf1n6yIBTXulvstV/1L
	 mpnhpYSRMRDiG2ZFrwLeKC+U/EP7rtvKG0dwVwKL502GlJIi9mvFLbLJd4scVOiHLD
	 mugmSz4pokk7U0IoaKLsSqjqWHUj29fKdCH2+VyKXWzdc/DKVzBMmJkt31L6R6BfXA
	 H9lOOh/z5CHcQ==
Date: Wed, 27 Nov 2024 10:06:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hua Su <suhua.tanke@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock updates for 6.13-rc1
Message-ID: <Z0bTBc6aoyOpuhU1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.13-rc1

for you to fetch changes up to 98b7beba1ee6fb4ee755812e6c06cfc9084e7430:

  memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE (2024-10-28 12:16:06 +0200)

----------------------------------------------------------------
memblock: updates for 6.13-rc1

* replace hardcoded strings with str_on_off() in report_meminit()
* initialize reserved pages to MIGRATE_MOVABLE when deferred struct page
  initialization is enabled so that if the reserved pages are freed they
  are put on movable free lists like it is done now when deferred struct
  page initialization is disabled

----------------------------------------------------------------
Hua Su (1):
      memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE

Thorsten Blum (1):
      mm: Use str_on_off() helper function in report_meminit()

 mm/mm_init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.

