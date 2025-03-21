Return-Path: <linux-kernel+bounces-571448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFAA6BD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDB1767F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1862154426;
	Fri, 21 Mar 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUbHDr3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CA23BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567945; cv=none; b=eW7t2rxXw8CJyxHkTd452FB7xsFgtpChpOCec3XYXQBgxfIWiz8A+xCNT1FPH1gCZiVSqnB8Od3H/rbfD9QgO+RIE4ziDiqJPkJBJT5h9rCaKsg1vNZ6Y5nklhFrQM3aG/meV0uR7MU/KElkFn8AbcceT5G+j6dHrEvSKN/Cnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567945; c=relaxed/simple;
	bh=NCV1cJxcOeiaI+H+5yG6DqUsHaKoC9Jey0ChdsKpI9k=;
	h=Message-ID:From:To:Cc:Subject:Date; b=r+3zUq5xrtkI8J3fliFWyp0uYjIiEXCNdNXngw8E1cg/JY6kvqNKOBP/rDkMWoQvJ5dE6L3SdjZiuQRDx8+wSNaYX+U3E1cgSDEXK1dGBdJn6HkIRh7+JwWoxvavg7Hkix76AA5Rs9NLWgVhqYcH4uHVb2aMI5xPqwoKSaAtNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUbHDr3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32630C4CEE3;
	Fri, 21 Mar 2025 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742567944;
	bh=NCV1cJxcOeiaI+H+5yG6DqUsHaKoC9Jey0ChdsKpI9k=;
	h=From:To:Cc:Subject:Date:From;
	b=RUbHDr3Dujfg4IxQZii3RbgaATvIqvTBUCmLg55V30LI+5Kxpi0fFQ9zZsghWZorl
	 vBlZ2OjVVRPDEFNuRRKuDenaYxkLqoV11hub/yNY2nUWJvC3cR7UVnaqe1e763cnp+
	 TUGOheqqOZCZ6dS7dm/HFxKLS94Ni63bgxHGEBL0UJGL2RjIdVxmctMJe9Z5rP1WGh
	 Y8ZkGAFvYPe9Jx4CoLxy2mrwOVjnusVV0zHeQBNmBQBafyXci/M8Ex/KqElCV+V/FF
	 yGhh9YX5WOnYGJI4WquW54uNiJV9J0J5Kjj8vInTH1MiW7oOFjRo4bfENzDk7c3PpP
	 xbmcFJh4Tabjg==
Message-ID: <50c80a2096aa0f389fffb34dfffc82ba.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.14-rc7
Date: Fri, 21 Mar 2025 14:38:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc7

for you to fetch changes up to b65439d9015024c37c6b8a17c0569ec44675a979:

  regulator: rtq2208: Fix the LDO DVS capability (2025-03-17 12:45:37 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.14

More fixes than I'd like at this point, some of which is due to me
cooking things in -next for a bit and resetting that cooking time as
more fixes came in.

 - Christian Eggers fixed some race conditions with the dummy regulator
   not being available very early in boot due to the use of asynchronous
   probing, both the provider side (ensuring that it's availalbe) and
   consumer side (handling things if that goes wrong) are fixed.
 - Ludvig Pärsson fixed some lockdep issues with the debugfs
   registration for regulators holding more locks than it really needs
   causing issues later when looking at the resulting debugfs.boot
 - Some device specific fixes for incorrect descriptions of the RTQ2208
   from ChiYuan Huang.

----------------------------------------------------------------
ChiYuan Huang (2):
      regulator: rtq2208: Fix incorrect buck converter phase mapping
      regulator: rtq2208: Fix the LDO DVS capability

Christian Eggers (2):
      regulator: dummy: force synchronous probing
      regulator: check that dummy regulator has been probed before using it

Ludvig Pärsson (1):
      regulator: core: Fix deadlock in create_regulator()

 drivers/regulator/core.c              |  88 ++++++++------
 drivers/regulator/dummy.c             |   2 +-
 drivers/regulator/rtq2208-regulator.c | 216 +++++++++++++++++++---------------
 3 files changed, 178 insertions(+), 128 deletions(-)

