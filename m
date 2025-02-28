Return-Path: <linux-kernel+bounces-537645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A37FA48EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDAF188C318
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9A7081F;
	Fri, 28 Feb 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dExi75r6"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D4276D38
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709867; cv=none; b=Z7+u6AM3ywY2Vf5EDjlFHzL4FAeRwGM2cLRGUjgOxMefyp/LZPONcHZhhaJxNFynCLGQhvhy9i+/HrwWBxNzhOtEJiC1tjv4VBOouSP7rQybipeLpl72ues8qnAzVKH2YjOsGxgmbQnitSNhcrcXqHN9yIXKGkTOD/g7AoWFa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709867; c=relaxed/simple;
	bh=CajDnPXnEEJRA735qE5+L7uuscbI+D22NlEy0SQnEig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AP0kWzMQtPOJVsrUCc9v5hYELsDjzVCOW32Hp/+zKdqqVZt0JGtLT4Zx13y2Qugm5+EBifaOaGbYmenVoWRTeVXSjXgrD3YuKQkNruylWokri9AoexITAgqz9zILxdFh1JwOfAaBQkrrPTwwxq3LzZYx0nA9nZOqgPRjhzxf45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dExi75r6; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1740709859;
	bh=CajDnPXnEEJRA735qE5+L7uuscbI+D22NlEy0SQnEig=;
	h=From:To:Cc:Subject:Date:From;
	b=dExi75r6e3SIJcmQwT6cH1M7/LM5Rk/+nekjzXVqAF+0oZp86Ss6M5JEslTFYUjDg
	 PPsoOl7XezYERI0QBlEH6y0ZU/TP3930DIafs3IV0IgnasZR++1IHm0XTRNazLjWiT
	 iTHdmI+nB+Lvd+//atNAzwhIzGeVK0thUQshni5uAd6oUa+Gh8CRgA5rEo3qyVS+VW
	 NgOBImEMgtlIOZofw0Gq9fTmPtyeNf68oZlbVZGmeuwYDFyDxpBob9DnqH3TSkHlnJ
	 7FYh04ofXk4RjIHwNpB9WHCmOfRoP5/AuDhxFwWTL/GQdPaLZFLORLpmw3hXQ/SH5O
	 2f3V4cT5/9epw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z3sdb426hz10GY;
	Thu, 27 Feb 2025 21:30:59 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Date: Thu, 27 Feb 2025 21:30:41 -0500
Message-Id: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces SKSM, a new page deduplication ABI,
aiming to fix the limitations inherent to the KSM ABI.

The implementation is simple enough: SKSM is implemented in about 100
LOC compared to 2.5k LOC for KSM (on top of the common KSM helpers).

This is sent as a proof of concept. It applies on top of v6.13.

Feedback is welcome!

Mathieu

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: linux-mm@kvack.org

Mathieu Desnoyers (2):
  mm: Introduce SKSM: Synchronous Kernel Samepage Merging
  selftests/kskm: Introduce SKSM basic test

 include/linux/ksm.h                       |   4 +
 include/linux/mm_types.h                  |   7 +
 include/linux/page-flags.h                |  42 ++++
 include/linux/sksm.h                      |  27 +++
 include/uapi/asm-generic/mman-common.h    |   2 +
 mm/Kconfig                                |   5 +
 mm/Makefile                               |   1 +
 mm/ksm-common.h                           | 228 ++++++++++++++++++++++
 mm/ksm.c                                  | 219 +--------------------
 mm/madvise.c                              |   6 +
 mm/memory.c                               |   2 +
 mm/page_alloc.c                           |   3 +
 mm/sksm.c                                 | 190 ++++++++++++++++++
 tools/testing/selftests/sksm/.gitignore   |   2 +
 tools/testing/selftests/sksm/Makefile     |  14 ++
 tools/testing/selftests/sksm/basic_test.c | 217 ++++++++++++++++++++
 16 files changed, 751 insertions(+), 218 deletions(-)
 create mode 100644 include/linux/sksm.h
 create mode 100644 mm/ksm-common.h
 create mode 100644 mm/sksm.c
 create mode 100644 tools/testing/selftests/sksm/.gitignore
 create mode 100644 tools/testing/selftests/sksm/Makefile
 create mode 100644 tools/testing/selftests/sksm/basic_test.c

-- 
2.39.5

