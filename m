Return-Path: <linux-kernel+bounces-386165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A99B3FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A01B21CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DE5FB95;
	Tue, 29 Oct 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFesjoki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DF79F6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166997; cv=none; b=r7hhtNFMW8LnsS7VL01cTstmTvjb6yg2fGebBDQMAleTdJMrLEuXhZHUH097LfDOWIdDtyofz4mw8CaSInFdI3elHfE3UGPnX8/dYDDB+emP6iv62LodsNp3alr/OYPZDc3um3WMWdjOQAblO791S4OVOBLMD4XeGgIBCYI7jUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166997; c=relaxed/simple;
	bh=41qgNbkuNB++x016Enkhu+Sr9GqznlHTZ+ppdrv2jKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOq0G7UzcOvLmzvabRZOzOdbPtKmF08xcLW/Yu/q0pb0NPgtiZiOiDs8RFLmiIFY6YvQvcH2qgI4x7mn3O/GUOkmvsEdaePYNqKy4TA5bacxj3SAVlAyhcphoi/GhjgXLZ7orEj2wPkIgbXe6lxyFRqrf8S44H6AB7FWBiD0kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFesjoki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DEC4CEC3;
	Tue, 29 Oct 2024 01:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730166997;
	bh=41qgNbkuNB++x016Enkhu+Sr9GqznlHTZ+ppdrv2jKE=;
	h=From:To:Cc:Subject:Date:From;
	b=vFesjokirzD3CSXnjSe11UM1tanp4jC3NfrJDQESb30+0izAuFGUrILJbWRKKSZDt
	 mdV7FgWd0cgom4o3SzOMSnthSO26pvVkq+x8yjqvT9wVgSL620mM7FZcfJu3daPqq5
	 reaz1ybMB07J7L0YCrKyU9nWc4xpAtTvCLeqfcues/SUSPh4YiBaTA81Sd11hDeoZr
	 DR/hPaGuSKL6mL3ju3Zhh7gfaooa7RrRXqvX6e9cCNWpUsbuz3aHCLE/psI2yENi9R
	 ekz/O30HFcBWuLsLR2Q8Nbekio25IhD38oL3yWHQfXk5foy2LaE627ehKUw35i2gqX
	 3+AXxFqIepeTA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 0/6] x86/uaccess: avoid barrier_nospec()
Date: Mon, 28 Oct 2024 18:56:13 -0700
Message-ID: <cover.1730166635.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:

- rebase on Linus' patch (v6.12-rc5)

- remove putuser(), copy_to_user(), clear_user() changes: as Linus
  points out, they don't produce a value that could be used in a
  dependent load to leak anything.

- convert 32-bit versions of copy_from_user(), get_user() and
  __get_user() and converge code.


Josh Poimboeuf (6):
  x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()
  x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
  x86/uaccess: Avoid barrier_nospec() in 32-bit copy_from_user()
  x86/uaccess: Convert 32-bit get_user() to unconditional pointer
    masking
  x86/uaccess: Avoid barrier_nospec() in 32-bit __get_user()
  x86/uaccess: Converge [__]get_user() implementations

 arch/powerpc/include/asm/uaccess.h |  2 +
 arch/x86/include/asm/uaccess.h     | 34 ++++++++++++
 arch/x86/include/asm/uaccess_32.h  |  1 +
 arch/x86/include/asm/uaccess_64.h  | 30 +----------
 arch/x86/lib/getuser.S             | 85 ++++++++----------------------
 include/linux/uaccess.h            |  6 ---
 6 files changed, 61 insertions(+), 97 deletions(-)

-- 
2.47.0


