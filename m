Return-Path: <linux-kernel+bounces-400738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26C9C119C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF601C223F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232A218D64;
	Thu,  7 Nov 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfSfu71W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37C218306
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018112; cv=none; b=knK0UG/0yZoQN745IEzDflXnxTUcJMCFP8dlKZtBcUlIOeBh3zn1gnhcaI1eiC74fVcxG43fB2puQ4/niyRxmNZb7aWzeH8saw/yLIP4p9Lgi9eQZiPQXoiEWB/2Q4F2+V+wrojT3IJ31R1mr/aBDax0PkG8cmrpVf0KweC+S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018112; c=relaxed/simple;
	bh=fDTgro9oP/lONPCsJJGdzxon02c/j2df07lWHv9xarA=;
	h=Message-ID:From:To:Cc:Subject:Date; b=fF6wKG4DaCW7iU5VI+XkaBXm2C1t1ZPaQeLlzG+0Pd2Rqwct6l0f+N4upd7s0QVe8HNNeCMadct7SV0pTwaZcPvxHvC9nOZDIIb56e3Mw5/03efvNRPak/bvfvXh75nKq++kTDivfdtD7M1vrqHVR40tO1MgcaFb3ZnU+edWsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfSfu71W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272EC4CECC;
	Thu,  7 Nov 2024 22:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731018111;
	bh=fDTgro9oP/lONPCsJJGdzxon02c/j2df07lWHv9xarA=;
	h=From:To:Cc:Subject:Date:From;
	b=UfSfu71WibR9paEkgdgJbd2G8mVMjNOWh4zkVpOYmiWdCpRzgd1VObv0zLAPixbJS
	 0Em48ScAttDnsFUCcaZsgLxiUu70ieqjf52HHt3UiCu/zM1UJo40xZBx9tMU+9CL8o
	 636cNjYIjsTLbK91crzwLzppybtxJZ9CSuH5imbeVirP+dQNFRDGtLT+SCu3SQIfVe
	 nvslHe1kbouI8Kd0FOxpib/qptvQvC+NYsJWunCLDXqkKhEtUF+eUs2MP9iVeSofPT
	 JufZN+v5Nsj+6z5lhqiFN5waQsgY9iUCra+GwRDTT9XcQ49AI/9AVRISUZyrdqoMnb
	 ZPNsXvVmbTCmA==
Message-ID: <940f0c26c3b12338363be9f68d1a444d.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.12-rc6
Date: Thu, 07 Nov 2024 22:21:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.12-rc6

for you to fetch changes up to 5e53e4a66bc7430dd2d11c18a86410e3a38d2940:

  regulator: rk808: Add apply_bit for BUCK3 on RK809 (2024-11-01 14:47:08 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.12

A couple of small fixes for drivers, nothing particularly remarkable.

----------------------------------------------------------------
ChiYuan Huang (1):
      regulator: rtq2208: Fix uninitialized use of regulator_config

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

 drivers/regulator/rk808-regulator.c   | 2 ++
 drivers/regulator/rtq2208-regulator.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

