Return-Path: <linux-kernel+bounces-230105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC49917870
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606871F22102
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C83145FE0;
	Wed, 26 Jun 2024 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHga3As2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F838D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381733; cv=none; b=eG4ZOR09CS4dHUyKgGAo8OPrJnmPb56XCnbfQPvfR9rOLcyLixAQTvKlI2PfVkuKAfOqUB4NAARp+tShSLbQCPhgL2OmdQmsUMvPPZ4XjdtxQdrPA5LJw7SeS2IbNKJhbvAy8gnARZ0ReYcGH6pEjqmcEJbKqqEkrDzo+47P2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381733; c=relaxed/simple;
	bh=a6GfZmF1KnDmWYgy/fH17YtrPbanz4VScd8BD42i5Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/u9lXq+KjzF6NSziHmDZPjNPBCJn/j9iQROsoM9S/LEuc32CowYKEGVZ0C3zMNJXD8RjrGOzQrQ/Mt0XAdOCZ/GomFKFNYr9pTSc26XWqAWD5Uf0juwpwHifbLW/6Rm7I509y0ca2a04YyT8Fv5d8lhM0L4OEOZIzIhJhV44qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHga3As2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497FDC2BD10;
	Wed, 26 Jun 2024 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719381733;
	bh=a6GfZmF1KnDmWYgy/fH17YtrPbanz4VScd8BD42i5Xk=;
	h=From:To:Cc:Subject:Date:From;
	b=WHga3As2wcaSYGvCZk54XggkorZ3XBGpr76hDSrn3f9qQgx1dBMytOsnu7bC+TfEM
	 pLSoGFSx+dnMmJi72FhSf1HIIeceoW1gWjEC28mtXjTqkAKTVtdGFDyhrdym4lax3Y
	 gW+W81/cJCBX959wHV6bOqhf+p2wdaLctcqDKMkwFZH/rKEg3DellWZkZvmaWfqq0f
	 Qw67GrqBcXqp5ZKbszQS6vrvBK3Q8H5foGEieQ6zjMkLLEsanUiLnxjOkm176hH6sd
	 J0h5mCk7x+9OAM7bUvP8FqIM5QxFsDh57/uFmK5dIrKNHzA0ZoYToxsajKQAQJFCZp
	 g/MHNe/kmgTjw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v6 0/3] x86/bugs: BHI updates
Date: Tue, 25 Jun 2024 23:01:59 -0700
Message-ID: <cover.1719381528.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear x86 maintainers, can you take these for -next?

v6:
- added Tested-bys / Reviewed-bys
- fixed documentation oops


Josh Poimboeuf (3):
  x86/syscall: Mark exit[_group] syscall handlers __noreturn
  x86/bugs: Remove duplicate Spectre cmdline option descriptions
  x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

 Documentation/admin-guide/hw-vuln/spectre.rst | 86 +++----------------
 .../admin-guide/kernel-parameters.txt         | 12 ++-
 arch/x86/entry/syscall_32.c                   | 10 ++-
 arch/x86/entry/syscall_64.c                   |  9 +-
 arch/x86/entry/syscall_x32.c                  |  7 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |  6 +-
 arch/x86/entry/syscalls/syscall_64.tbl        |  6 +-
 arch/x86/kernel/cpu/bugs.c                    | 16 ++--
 arch/x86/um/sys_call_table_32.c               | 10 ++-
 arch/x86/um/sys_call_table_64.c               | 11 ++-
 scripts/syscalltbl.sh                         | 18 +++-
 tools/objtool/noreturns.h                     |  4 +
 12 files changed, 86 insertions(+), 109 deletions(-)

-- 
2.45.1


