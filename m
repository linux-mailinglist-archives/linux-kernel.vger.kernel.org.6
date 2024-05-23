Return-Path: <linux-kernel+bounces-187416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6548CD181
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFECB1F221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3B13BC0A;
	Thu, 23 May 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pykEbYQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD813BAEF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464899; cv=none; b=Z6jpI+u2bNYrnvQDw6oEhJ14c48WiDxDOgqcvw8pVTASw52U4IKjk5NhOmtOewf3cW1IgiNXwo4sLVghJCxvsbb+aS3XBC55rw5Kts+/UutOUy/RlLxT8piaxZ0FUX5v7yxvKkaKmLp8rupy5dO4R0UCQ4topbdfHw78duN/yuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464899; c=relaxed/simple;
	bh=GdEfHQwd9UthVQYdbuGOINTzIHonWFAafApvVNK+jJQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=YYiPlquI64hds21XTGMzH+f3qSSMuBb3wI9s0EPoneAyNimZ09VjzGWS8VTsjs9efAb1ni9aXxUPJYF5E/WDXxcGOc0YF8tv/othP4Lazhc5hw6kn/IxxSP23dk5j5Pidv8yNBSXojxHOvQu/LG7qzude/jD3CXCMagkaoT4X4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pykEbYQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C13C4AF07;
	Thu, 23 May 2024 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716464898;
	bh=GdEfHQwd9UthVQYdbuGOINTzIHonWFAafApvVNK+jJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pykEbYQNcZBaA9bC2vflH5VRpMklFtL4krDfUASsn45ovi8BUXgqSGofgKcl05XLZ
	 S1vh0eRI3Ui9jcMyiaPqY911bHxpqDZLwgHwzB1hnD4fVZAXafOmRE6EOlCtXCv2mb
	 swp9OWBJbAr6VgrqPF+azl9eerFAaal2xY+I30GJyVqXOdt9yNSo7UP68eGx1+SnQb
	 17WAH3Sd11/nMYB9XRCeWJonebZHJi9B3WIKMMO78uQOso9smZp3vnffAFHyONSAzW
	 46IXpzgOr5SKmyyZcGceo7keccmNkg4wgsC6vG1XvcR2RG4V9A/ZCbsRXelWS0+97V
	 0p4ExBvEI1lFA==
Message-ID: <e6cfc0e5425a26caf92012a9021e6a47.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.10-merge-window
Date: Thu, 23 May 2024 12:47:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 9b1fe0510494c989ab6a131ce8b97cdd02a1c869:

  regmap: Reorder fields in 'struct regmap_config' to save some memory (2024-05-07 10:31:42 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-merge-window

for you to fetch changes up to 7ba822189e6060a8a2833b721d430f833bf0db43:

  regmap: kunit: Fix array overflow in stride() test (2024-05-17 18:23:12 +0100)

----------------------------------------------------------------
regmap: Fix for v6.10

Guenter ran with memory sanitisers and found an issue in the new KUnit
tests that Richard added where an assumption in older test code was
exposed, this was fixed quickly by Richard.

----------------------------------------------------------------
Richard Fitzgerald (1):
      regmap: kunit: Fix array overflow in stride() test

 drivers/base/regmap/regmap-kunit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

