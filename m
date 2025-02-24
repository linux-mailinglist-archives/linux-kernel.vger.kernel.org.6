Return-Path: <linux-kernel+bounces-529078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7335A41F96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF51682AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86D23BCE3;
	Mon, 24 Feb 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMrMjsWy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B3157A48
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401162; cv=none; b=q2Uy7ABgZHSo1vP8FQ67NzatFkRzRBsYNnBXsykyPZllwXIgA1vFEHi+Zpd5F+7/GR8/2kzD4wEv4017idyBoo6VX8xDF7BUhn06PJ/aycDB70hxVuyzIdHmVNjlBIE9px/xsZ6b9p0XO4K8u4uM9QlFr00IYWE0C7PhaSWb5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401162; c=relaxed/simple;
	bh=LWgjnBIOINMhQJXWw3x8O3MsK1mQrgsIKVZtKVBGhlo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=umWb7ngAHOCaA/pyucvQkdP3EzzXFrWDO7hspUqtAiWW4Oa3pKFL7QXmvQpWf7QBFNwXIbc5LsnyWTCPAlMFc+n83FnmyEivG2iKKI19SikjGKf2SgxpJH3mHaMN5EbwG1ECQ68FWYdUlxt7f616Gfv9VtTW0cyp/2LJyRhKATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TMrMjsWy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dC2WaUYnTgoh/IYAcXyoaIxlJCuUEBZuHGzOW5oKu2E=; b=TMrMjsWyrg2omGwIPV27SroBS4
	kVguUe+2Gq9eZKBLvaqNR3/fqN+Zp7xPAkEA+NnEk0fqL4VquFvP5RbNznPLKmPVq/v0jeuj4wvnA
	zDn2vWMdXpLj5FbWA9Lu/0ErH9jOYOBYMZ8gn494S5DeEb5Ms8i0Ke4Sm+9wsPRL4t1lqOnuB1llZ
	m9g0b33WZw8Af19JFkeoc8Cvx9n3kL8MhsgQjbw/vaa3vGB5BbcZhSdbxeXKvgSw3ZHe9+vf8Hj9Q
	uGg6ROeeGd85IZQ5R0A8x4x+u1/lNWY1gsOga9u1wRDyRm9XHRoTKUXkVCP28vuab1uyG9c8BrkO3
	NLcmLt2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqM-00000003C2O-2AMS;
	Mon, 24 Feb 2025 12:45:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1264730010A; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224123703.843199044@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:03 +0100
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
Subject: [PATCH v4 00/10] x86/ibt: FineIBT-BHI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all!

Hopefully final version of these here patches.

As reported, these patches include the cfi=paranoid flag for dealing with the
FineIBT SYSCALL pivot and cfi=bhi for further hardering FineIBT.

Biggest difference since last time is the reworking (vastly simplifying) of
cfi=warn, and getting rid of the ud_type propagation in favour of using
is_cfi_trap().

As reported earlier, available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt-bhi2

Previous version at:

  https://lkml.kernel.org/r/20250219162107.880673196@infradead.org


---
 Makefile                      |   3 +
 arch/x86/Kconfig              |   8 +
 arch/x86/include/asm/bug.h    |   3 +
 arch/x86/include/asm/cfi.h    |  10 ++
 arch/x86/include/asm/ibt.h    |   4 +
 arch/x86/kernel/alternative.c | 370 +++++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/cfi.c         |   8 +-
 arch/x86/kernel/traps.c       |  54 +++++-
 arch/x86/lib/Makefile         |   3 +-
 arch/x86/lib/bhi.S            | 146 +++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   |  30 ++--
 include/linux/cfi.h           |   2 +
 kernel/cfi.c                  |   4 +-
 13 files changed, 585 insertions(+), 60 deletions(-)


