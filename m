Return-Path: <linux-kernel+bounces-290380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4395531C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11640281FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E761448C3;
	Fri, 16 Aug 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdaM6iTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9113D882;
	Fri, 16 Aug 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846048; cv=none; b=eRxHKxAnS7jqRNt+0LPk8xL5q3kQtibdAA0Z1b3RrJQdNSFxBz13qFDqBbAkA0Z+elWTbWjmldbdnaZTdWh7G5PQacKnoiSdtfiBf/3SWKFXHtP09p6tiyiWogknVY03R6EaD1hV513FBcmvtbev/e3V5iH2c9BUC72OuXM1NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846048; c=relaxed/simple;
	bh=f8fjLnGTGBqPPgooN2EIpaoA54+U7+toJakdpH5RR7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSJx623sz0cWZBjtVEVpJHKXQKhGu/aCkqlThveDY+mNNao4KKGEM3Qq+NGLlsrmMOh/TQ2HEyER2Esp8jVGTKyNthudjzrMmZcyiBwx43jiOPTuxyiiaDkY+iK10J1FJZQBXcnaY2xEX/wRF07MO9c+UR8O6TY1wXHPYnGcdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdaM6iTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FEFC32782;
	Fri, 16 Aug 2024 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723846047;
	bh=f8fjLnGTGBqPPgooN2EIpaoA54+U7+toJakdpH5RR7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=YdaM6iTRM0UWx26aKOuRzrdBMNQpx8V4ooM8suMQNn1Q8/HnduFLqyZWLYHCYWS6z
	 rBQ5tAPpxeh2eZWWLyjcS6xORvvUMoDY2E/Nf6fCKK9DrX3e8XYTcMwfuq3tWUADBm
	 mev7W74I1zmiQPKfYpvGQO6tnMc8625OIRhxA4v9z+CdRm9+7bGl3lL9jxKxFBd4YH
	 xuHRAze3n4xdxvlUJJbduN+jHDERh0TsbxnKDGm14XtyfHLLATc1D6zZAvqT/M9+eT
	 hNX33nYLZ5QKXAPpkujfPQrZHVJzccxxxyWla2bZFe97IK7xlzFXu/gCYinKnVEqTT
	 A2dj4L2Cs5k3Q==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.11-rc3
Date: Fri, 16 Aug 2024 15:07:25 -0700
Message-ID: <20240816220726.3580212-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 39a3396558fb97e6e7d4c1eb04c2166da31904a9:

  clk: thead: fix dependency on clk_ignore_unused (2024-07-31 14:51:47 -0700)

----------------------------------------------------------------
One fix for the new T-Head TH1520 clk driver that marks a bus clk
critical so that it isn't turned off during late init which breaks
emmc-sdio.

----------------------------------------------------------------
Drew Fustini (1):
      clk: thead: fix dependency on clk_ignore_unused

 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

