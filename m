Return-Path: <linux-kernel+bounces-177415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117208C3E40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E891C212CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614B1487F3;
	Mon, 13 May 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1drktTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E427715
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593128; cv=none; b=jDW3UOGFpAmHKqAXq7YBSldlGzlrASgrmCOsNTtHo6R7/2lESe2Doiz8CMztRccu6FnkHQ7iLI0Bla/SKKKWtgIA3mXQjr9ltVvpab+X7SjEqdtyjnXQXV+KfVxNvDEGlBXJ8hPdLS4UHfkTYWjd48CTZU2qMfyYQMODbnR+s3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593128; c=relaxed/simple;
	bh=snL8LRKCa/STZ2qoV5pQbfZV8+1HIZenfoWjL1W0GcU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=V1Cj5kvx82oH9ojix2dvhBolsH0zajY1gOGZlMJDfZw6mMwRScv3+TCbGsZDgs5PMI4RLTblV1el0RGmtvZYMf9TAs/YZqLnFdu2h3u75n7M/B+mDt2ME3PDkrtl58YFg6YUFz7rQJuMgXEmjl9FKS1PIWVHBxUinyedlGyUbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1drktTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D16C113CC;
	Mon, 13 May 2024 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715593128;
	bh=snL8LRKCa/STZ2qoV5pQbfZV8+1HIZenfoWjL1W0GcU=;
	h=From:To:Cc:Subject:Date:From;
	b=u1drktTsymkAHTuGPaJ1KDkK1wZOkUWXETaBLvzruyxOjeQJm8Xw97/mNtV5y4IxL
	 ich1BtOEvKPXLQHOEwyoar95DHiPVNYfqU0T+OZR2jLcOE4caGNQ2mOgu1p+gkIf44
	 ue22+PA0ml/8cAza/dEraA+PEG051+SBxaGXXbOTI0vDlkTvjK6jOr6p/qWSmCtKqA
	 KXpJpWC3IxONyrtWPKeLvDEqql6HH8sDScdEZ1A2h0MBH6QFA5LkIaR6S3tWH/emiL
	 bSrsqzwjkMzIs3v+muGdY5kHbEsTqrJNAD8C5qxwVmth0SacDsGoWj81juET1Mhpbp
	 GrK4hSjzLK6xA==
Message-ID: <be1cf843f7131a702c3eebab6abaa82d.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.10
Date: Mon, 13 May 2024 10:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 70ee853eec5693fefd8348a2b049d9cb83362e58:

  regmap: Add regmap_read_bypassed() (2024-04-08 14:09:58 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.10

for you to fetch changes up to 9b1fe0510494c989ab6a131ce8b97cdd02a1c869:

  regmap: Reorder fields in 'struct regmap_config' to save some memory (2024-05-07 10:31:42 +0900)

----------------------------------------------------------------
regmap: Updates for v6.10

Other than a few cleanups the changes here are all in the KUnit tests,
Richard Fitzgerald sent some bug fixes during the v6.9 cycle and while
adding test coverage for the issues fixed did some fairly substantial
improvements, both cleaning up the framework and building out the
coverage.

----------------------------------------------------------------
Andy Shevchenko (2):
      regmap: Drop capitalisation in MODULE_DESCRIPTION()
      regmap: spi: Add missing MODULE_DESCRIPTION()

Christophe JAILLET (1):
      regmap: Reorder fields in 'struct regmap_config' to save some memory

Colin Ian King (1):
      regmap: maple: Remove second semicolon

Dan Carpenter (1):
      regmap: kunit: Fix an NULL vs IS_ERR() check

Mark Brown (1):
      regmap: kunit: Add some test cases and a few small

Richard Fitzgerald (11):
      regmap: kunit: Fix warnings of implicit casts to __le16 and __be16
      regmap: kunit: Create a struct device for the regmap
      regmap: kunit: Introduce struct for test case parameters
      regmap: kunit: Run sparse cache tests at non-zero register addresses
      regmap: kunit: Run non-sparse cache tests at non-zero register addresses
      regmap: kunit: Add more cache-drop tests
      regmap: kunit: Add more cache-sync tests
      regmap: kunit: Use a KUnit action to call regmap_exit()
      regmap: kunit: Replace a kmalloc/kfree() pair with KUnit-managed alloc
      regmap: kunit: Add cache-drop test with multiple cache blocks
      regmap: kunit: Add test cases for regmap_read_bypassed()

 drivers/base/regmap/internal.h       |  14 +-
 drivers/base/regmap/regcache-maple.c |   2 +-
 drivers/base/regmap/regmap-i3c.c     |   2 +-
 drivers/base/regmap/regmap-kunit.c   | 990 ++++++++++++++++++++++++++---------
 drivers/base/regmap/regmap-mdio.c    |   2 +-
 drivers/base/regmap/regmap-ram.c     |   5 +-
 drivers/base/regmap/regmap-raw-ram.c |   5 +-
 drivers/base/regmap/regmap-sdw-mbq.c |   2 +-
 drivers/base/regmap/regmap-sdw.c     |   2 +-
 drivers/base/regmap/regmap-spi.c     |   1 +
 include/linux/regmap.h               |  62 +--
 11 files changed, 800 insertions(+), 287 deletions(-)

