Return-Path: <linux-kernel+bounces-522041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72CA3C529
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BF3AA51B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEA1FECBF;
	Wed, 19 Feb 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lm4KA4AU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75D1FCFDA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983011; cv=none; b=hK5ADNkJNh0cQQ9Jch3AtfdnMKwcSyiDs2vo9ywlmlsjN7cf0POeWl3cBGOjc0OcqbVZGW2IBYrxty6cSdtY45o9kVf2lO3aA92xKCsqjRF3YLRlqz5wfIls6Tboo95W+p85Xxh0aEZ3u6RznhtESsoOZpXJptghfg5qkqqR7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983011; c=relaxed/simple;
	bh=kjEg41n/qf+q4Ogxyc7CkG2/29kZ90F65p6j2vWak+E=;
	h=Message-ID:Date:From:To:Cc:Subject; b=TFsNBDsx5bLJQ2w94bHv1rZzfxhoog7Vt8ZH9TdVKOdjroT0/OkEAdDyCJ7i479Ahq+q/9KCdM4EG2jbAf81ECdvw7Bbg6Z4t2JI9miaNHJREizsjx8Jrj+8Md1NeKadcMQRZnirps7kEi/VUmifJfVdFj+TLhGxa9UkMCCPA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lm4KA4AU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=o9731rJKJQJZIRBku4Bh937RYFWQOOIJUERN4JK0nFk=; b=lm4KA4AU05oZ/FovwXFFBe/+sn
	wJFuFtbq0Ffd1TqQYx+Lkcj6J3viw/CxRLERz2NoX+eE4hqyBJzLyKMa7da5jkZS1sCxNgNYIY+Ka
	5TYGd5era8xnbW7/FTr8Yf/gXr/mjjaQDlYS0udeuHfcoSlZfUkwui/MwvOLKX1Ik3BB8ig0l6NEd
	6zNAkdo6RoAvoNVu7JKdBIaIRvrllPG/f+WKQd0NJXF1NUklq4x7IMlFNiALeCn+JmwoWOBwpAYp8
	XZUy0V83P4EffUn6VEXtlh/G65o/CI1HatdGAsxCgb55TAtDuICn+fb1xZxrXXxrGxLjGgVky+85K
	ZCWo48FQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000002HAG-0FpN;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E66DC300783; Wed, 19 Feb 2025 17:36:42 +0100 (CET)
Message-ID: <20250219162107.880673196@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 00/10] x86/ibt: FineIBT-BHI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all!

Having landed much of the previous series in tip/x86/core, I was hoping for an
easy time landing the final two patches.. alas.

This whole FineIBT SYSCALL pivot thing showed up, which got me to develop the
paranoid FineIBT variant. And because testing I added a cfi=warn knob, and then
I migrated bhi to an option etc..

Then just as I was to post this stuff, Scott out-nerds me with a whole new
instruction sequence. Which got me to rework the entire pile once again, and
it is now another 10 patches again :/

Anyway, be warned, Scott loves overlapping instructions.

This is tested with:

  cfi=fineibt,warn
  cfi=fineibt,warn,paranoid
  cfi=fineibt,warn,bhi
  cfi=fineibt,warn,paranoid,bhi
  cfi=fineibt,paranoid,bhi

Also note that LKDTM's CFI_FORWARD_PROTO test will do a double splat for
paranoid in warn/permissive mode, since both the caller and callee hash check
will fail.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt-bhi2

Previous version at:

  https://lkml.kernel.org/r/20250207121529.222723073@infradead.org

Paranoid discussion at:

  https://lkml.kernel.org/r/20250215210729.GA25168@noisy.programming.kicks-ass.net

---
 Makefile                      |   3 +
 arch/x86/Kconfig              |   8 +
 arch/x86/include/asm/bug.h    |   3 +
 arch/x86/include/asm/cfi.h    |  19 ++-
 arch/x86/include/asm/ibt.h    |   4 +
 arch/x86/kernel/alternative.c | 363 +++++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cfi.c         |  18 ++-
 arch/x86/kernel/traps.c       |  46 +++++-
 arch/x86/lib/Makefile         |   3 +-
 arch/x86/lib/bhi.S            | 146 +++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   |  30 ++--
 11 files changed, 579 insertions(+), 64 deletions(-)



