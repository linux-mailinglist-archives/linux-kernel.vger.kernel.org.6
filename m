Return-Path: <linux-kernel+bounces-329235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76E978F02
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA581F2368C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551213DBB6;
	Sat, 14 Sep 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmaslCxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EFE38B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301439; cv=none; b=bOubj8OarFlF9hlM0R+Zqo2S7rdL9Rf3dq3p4H9CAEGs4czZejmY/GMWZ699Lg+V5XqBqe/zad/bxWe04CqL4gSgIvM8LdgT5AR1c1zXZeW++Yt2JLcKBSdNAIhJW+VBMnyiBHESzQ+fYCaYsqqSETMzELCAlnzEKsq3sf4oHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301439; c=relaxed/simple;
	bh=3cqbnEns8FhaXZ7RhQ1y60Ts0u+WhQ3C0RUXeUkit8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tIJTyWL36rL57aQ6F+Uz5gkuW1m5hRBJ1UyJhe44UqGeZt6MSX16kVCBQDvQrcRxssEQD0Lhir+s/l8v8KbRvepSv7RnvLEv9VoNXWhki9b1wqEM4TVcftfv+N7UJpQSsLTndS285AXXovf6u7txPZO2nFkjZgqUDNVcLnRN2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmaslCxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E10C4CEC0;
	Sat, 14 Sep 2024 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726301439;
	bh=3cqbnEns8FhaXZ7RhQ1y60Ts0u+WhQ3C0RUXeUkit8Q=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=NmaslCxbhs6UHT1W3KHFVLVz9fjwtPLW7u9nPH2GBm17HjNggUrSnogh8rxaEP+k0
	 SlPOMRqkqBGcylgBV4ZaGDldRUn3FevmezMxV4IZ+4CLvq8iDFRCdXuSkRTFtW5+Ha
	 /lTVXrOulrYm9V5Eyah5r4LQ69AygZpMO+AS5oFOFYi6FxmVTaxoWUAvxLMwkijIhi
	 0cl5Rm4LZyQEE25QzYlR2S+Qe3frtbU1KdrYn9xpXh8gztI5AGIGksY4FtvLyjLB4c
	 YMWnowMXQCP6cg7Wqjgv4yZb2F0ABBHbNoj96rD84c6CR98HVfngKKH+tlaCBsqN4G
	 5l1xUIUGMtjeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56AA9CE0E7A; Sat, 14 Sep 2024 01:10:36 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:10:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel-team@meta.com, elver@google.com, thorsten.blum@toblux.com
Subject: [GIT PULL] KCSAN changes for v6.12
Message-ID: <65bb8a3e-9d52-4f2a-9123-a4e310c88d10@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the merge window opens, please pull the latest KCSAN git commit from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.09.14a
  # HEAD: 43d631bf06ec961bbe4c824b931fe03be44c419c: kcsan: Use min() to fix Coccinelle warning (2024-08-01 16:40:44 -0700)

----------------------------------------------------------------
kcsan: Use min() to fix Coccinelle warning.

Courtesy of Thorsten Blum.

----------------------------------------------------------------
Thorsten Blum (1):
      kcsan: Use min() to fix Coccinelle warning

 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

