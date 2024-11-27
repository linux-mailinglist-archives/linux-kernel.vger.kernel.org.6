Return-Path: <linux-kernel+bounces-423028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3B9DA18E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC312824C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20313C677;
	Wed, 27 Nov 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Mzcn3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0C320E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682866; cv=none; b=bUWr6vxS7NH4MnqsV8fXWpPGeutOTYrWz+nwFOZEtjpfh1ncMaMm2xjdtRPqoZYIa81QaCya96tQR2dEhHyo4R/j6kD5WFDzBPdwciQ0G556JN8FQAbWZCr4KtemVXwDbAqOEPmNLeuR83GaLWEJQim5Yf2R/8K0Mt4YnvRLtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682866; c=relaxed/simple;
	bh=lE6lG6LbPgOzdb286dF+kUKjWnXPkNkNTcDjRX7A1tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI+U4i7hsPgkdy319O+lEMXLyVXiyFx/c5Avkd2H5HKGVNHppKwXh75Ln/6LBYjdOZ0oIU6MiimsiW2usk+kMTbG4pLi5peBRQYCL/qUSxSKzJ2vTUPmboqZ23+HcIydPjjMNUgmIVJfq4nsjJZihs0hligoEEsJjpTL+i5J0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Mzcn3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9571C4CECC;
	Wed, 27 Nov 2024 04:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732682866;
	bh=lE6lG6LbPgOzdb286dF+kUKjWnXPkNkNTcDjRX7A1tA=;
	h=From:To:Cc:Subject:Date:From;
	b=I0Mzcn3qh89AmdzEWWHcigW+S2cwxbK9NbAsjPABv7SnTqYuQFDOdx9iIReRcPB1p
	 bpUBGMHAQ8jI9Aa+i2Ur/lGqXXf5oA/jUGcLX3H2TmnUOdX9BGVGXQZ/ocgx03Eo0f
	 4+tH1ZLQRAd+vPjxrj17H2cOLJ+W6BczeFNGnxY3lJ+tXHSWUoc0rViw0kqPEeEJ08
	 cLhhFA1DjozeU7ssirkI0Vel5iD/TAX8hJAwplRDw9I54RQFUHGZiikAaInFWXbWuz
	 zCl5yZBt44Tvxo6gWmAhLreCN6xTmP6G5NjTWQVYkiPsuTGcQh6oO9hxSV+P1tJmMf
	 fHbnrN4vYMRqA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/3] objtool: noinstr validation for static branches/calls
Date: Tue, 26 Nov 2024 20:47:39 -0800
Message-ID: <cover.1732682344.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Add some fixes reported by kbuild.


FWIW, this reports the following static keys:

  - sched_clock_running
  - __sched_clock_stable
  - mds_idle_clear
  - vmx_l1d_flush_cond
  - stack_erasing_bypass

and the following static calls:

  - pv_sched_clock
  - x86_idle

(not necessarily an exhaustive list, just the ones I've seen)


Josh Poimboeuf (3):
  jump_label: Add annotations for validating noinstr usage
  static_call: Add read-only-after-init static calls
  objtool: Add noinstr validation for static branches/calls

 include/linux/jump_label.h              | 30 ++++++--
 include/linux/objtool.h                 |  7 ++
 include/linux/static_call.h             | 19 +++++
 tools/objtool/Documentation/objtool.txt | 34 +++++++++
 tools/objtool/check.c                   | 92 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/special.h |  1 +
 tools/objtool/special.c                 | 18 ++++-
 9 files changed, 187 insertions(+), 16 deletions(-)

-- 
2.47.0


