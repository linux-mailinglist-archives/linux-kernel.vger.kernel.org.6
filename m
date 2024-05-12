Return-Path: <linux-kernel+bounces-176953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E28C37CA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD971C20910
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EB4D131;
	Sun, 12 May 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maKwvppI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F025634
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715535189; cv=none; b=q4TeRZ+XZL7nmsxVhXwnV4qVasKK5mxxATVdNaYSTzMMuK4CyWtUXNXvJMO83L9jRRNpGrRmXl/ZEv9GusrcsPAClsqHcB3ah2WKNnsgIoT2y9CkIctePcd6ZCpkGRdyMTuC3FmnqKpqFWH1n0eehIwQag+UiP/4jXeA67dTets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715535189; c=relaxed/simple;
	bh=ttF1rtgT590tJUdomS3tSkw0x6qe5M+vjYWjqrkv3M8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ArkSd+ceBeDXIXxiK9bsoG5nA6nNFNAqCPSi3oHUHk50ZHXGFIjbGN0vTpzzNWl1ufoEdnZHvuwfkFTWQs569V5ZoQcltLPVe7c8aN6AEhwqRVhdCMat4DFANnOlbkJ3RhcMz+j1gEOUVrX3v2mhFuumcb8QtuVtWquTU9XB7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maKwvppI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EA5C116B1;
	Sun, 12 May 2024 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715535188;
	bh=ttF1rtgT590tJUdomS3tSkw0x6qe5M+vjYWjqrkv3M8=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=maKwvppIQ4gcdMO1RUIRMQbZrA2lCm2xKc83sTqkJW1TPPo3EfLK0IRp+gNMxGuDF
	 8FDyx1wSpcwXUxS4J04qOaCF21Z2aVLdXiM452kugSamFLZp0dQGlvCqd2qb+Fc1hv
	 glVgi37qIVxnTVfrL2ZPwJ/wf6S80AbyzSZ/sP7RXMi6Qf7TKKQXvp5Ot/eqwV4BIB
	 Ie6tcXbnNkXIixoyzPwEI9H6V/SXZQAUSjFiFiOzc2EW0CKoEW6vj6iWevByMOZylM
	 iBgmzPH9gPEBljb98wa9Ey08MZV9cFquXLqVOgnphTtZ3dXeXVMVCFL6D7JFLJRDTG
	 8n9lv/zzaqSYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4BA5CCE105C; Sun, 12 May 2024 10:33:08 -0700 (PDT)
Date: Sun, 12 May 2024 10:33:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel-team@meta.com, elver@google.com,
	penguin-kernel@i-love.sakura.ne.jp
Subject: [GIT PULL] KCSAN changes for v6.10
Message-ID: <ccdfb04f-9d2c-4033-a29c-bb9677fcbea5@paulmck-laptop>
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

Once the v6.4 merge window opens, please pull the latest KCSAN git
commit from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.05.10a

  # HEAD: 31f605a308e627f06e4e6ab77254473f1c90f0bf: kcsan, compiler_types: Introduce __data_racy type qualifier (2024-05-07 11:39:50 -0700)

----------------------------------------------------------------
kcsan: Introduce __data_racy type qualifier

This commit adds a __data_racy type qualifier that enables kernel
developers to inform KCSAN that a given variable is a shared variable
without needing to mark each and every access.  This allows pre-KCSAN
code to be correctly (if approximately) instrumented withh very little
effort, and also provides people reading the code a clear indication that
the variable is in fact shared.  In addition, it permits incremental
transition to per-access KCSAN marking, so that (for example) a given
subsystem can be transitioned one variable at a time, while avoiding
large numbers of KCSAN warnings during this transition.

----------------------------------------------------------------
Marco Elver (1):
      kcsan, compiler_types: Introduce __data_racy type qualifier

 Documentation/dev-tools/kcsan.rst | 10 ++++++++++
 include/linux/compiler_types.h    |  7 +++++++
 kernel/kcsan/kcsan_test.c         | 17 +++++++++++++++++
 3 files changed, 34 insertions(+)

