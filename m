Return-Path: <linux-kernel+bounces-361538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F276599A980
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B92827B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989D1A08C6;
	Fri, 11 Oct 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nk1j2uq9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130F1A00DF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666547; cv=none; b=jyVCEX4KEdU78jRhs7gtAS8DdL9wF1AhrdDjUsf5I1CteaWQRmB5wl+wHkzwBLcIpiUfQo5P/lClJ3NvKFAAbfz9IGREtGrwxvCfIBvakhafi8bm2vmJelpJg4bZNXXvdTx4GnkzwiYhXlvYIHqIfezQs4hRnkJ19TUzenzTn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666547; c=relaxed/simple;
	bh=WdW0H/xkNo4OXqWwtiG+9yuctWMezfpXNh+DbKjHzYk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R1P2ujWBlUhhF23NdQsJPx0C3tukqVZpsfnN7vxtDsMpoQQalWqY2bVmtPr3xDGxYVBIUEJYEXe7ELJacI1jJlJjKShohTCrgqfToFvPJTk9iFcP3Dp9sbIwWZx5XL/Ua6jGX1sM/DBAjLNdBiALMV4i//jpLy0zTWDRPsUvLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nk1j2uq9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so39923767b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666544; x=1729271344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9z1hvvdUAobVv4WjCQwWo86syz2IIrtsIUrBscrDwg=;
        b=Nk1j2uq9N9N4fUhu/PSniXU4HJQo5S3OHzxwEvFHn38Pn6bt/5lUckBRoFOwXRfP+E
         hrZ0hKzARS6p5S3UflNioBc97QCThyvWvBphEpN8fH/rbuFqss9s79luRZk6sSENUiAN
         0CdwvaBmprk23PvhmlWxsnX72xdbNEKvOoIMnKSNxJI+p1mdgD5wJPiB55RyajUqV/15
         e8Mpt8I+cn0/qiXQYX3VSb5T/hJBksQIy81S0IJut/qQWpTPdV5KDmLNb8QRCVxBDMyN
         w8cVShBA5EzanXSJnFclLE3iFbs5b2Q6lkb7S+nZ1ih6/sKzRCv63c4gFuPmjk9fk/ZI
         w4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666544; x=1729271344;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9z1hvvdUAobVv4WjCQwWo86syz2IIrtsIUrBscrDwg=;
        b=gJEcaaVNCTqrwqUg00+1yikVzp7rontZmbIt6cVsXSX9LuyJr8WaF36pu4+rT4iMZ9
         CqbJK2LSIhG0uZaGY5vlQzJbaP2XrVNNfFbQ9I3rPMo4/jIws99wjFT9RrgVlVJ5iMMJ
         lTWBUbz3jddZ070XXpZQf5pma0U4t46QIGxCmWBG1eCa34c02+90jxAywxDxjdSohj6k
         uw4eZoIKBrGWwsovu20gHgDwzXSxhF4YoO0cLNKBSKyjUaM3ofD60QLxAONWvFh/Rzpt
         OuS5qN2ypJqJoRBC4+u3hHj3HXrbBSc3a3apQwvQdmviOeGBfVGpOip8uFW8qE9iyMse
         U/gw==
X-Gm-Message-State: AOJu0Yysq2hsq1WIXtnmIJCpiypLhG6/mBEWBfr2+d0JtuCLarzw7kyI
	EtKGpuuSf/qJmPW9aGHr1ClmkgNevBjhUdA+BmS3nYt7vzVbeExSodgIpd64gcUhIr2lo6OidSw
	QcVM4hLOGGiJj4Z5T2/o4/YH4WnB2u/hdxaPriMpZemPhD41Xzi457kgBRZ5zmaDKYslTESpDqE
	18NwWkEp8ZfdhdlER+FB4BHh5DHBvF9A==
X-Google-Smtp-Source: AGHT+IFRxjOg1Z+Hw1i2OFyn/oUo9aBkCHaC4sUwZS7ofzyFJFGJOUCJFP6N9yslnShqPpJu2azrQL+8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:504:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e2919de7e0bmr14137276.5.1728666544035; Fri, 11 Oct 2024 10:09:04
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=ardb@kernel.org;
 h=from:subject; bh=Q9oH1OOrEVEgRLR+ckXrU6IQwTgLEXl5029WwVYvjXI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zesGD9yrxjKphR73ZkjYwXTZ78ETvgFWk47Ln0qeNZ
 muwL3jcUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayYAkjw+MuO70vp3bOdZk0
 wfHeqmOJlaW2uxh6d9h6i7M/zTkW/Irhf3ip4a0pQUZzmfZ18P178nyzyaMIy587Tium/U6ObxD 8zgAA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-10-ardb+git@google.com>
Subject: [PATCH v3 0/8] Improve objtool jump table handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Jump table handling has faded into the background a little due to the
fact that jump tables are [currently] disabled when enabling retpoline
mitigations and/or IBT on x86.

However, this is likely to come back and bite us later, so it still
needs to be addressed. Given the difficulty in identifying jump tables
from .rodata references and indirect jump instructions that often have
no obvious correlation, it would be better to do this in the compiler.

This series implements [on the objtool side] the suggestion made at GNU
Cauldron this year to annotate the indirect jump with a R_X86_64_NONE
relocation that refers to the jump table, and ensure that it is covered
by a STT_OBJECT symbol whose size accurately reflects the size of the
jump table.

This can be wired up in objtool with minimal effort. The only
complication is that indirect jumps may be direct jumps in disguise, if
they target retpoline thunks. This will result in more than one
relocation attached to the same instruction, which needs careful
handling in objtool.

Other than that, changes are rather straight-forward.

Patches #6 - #8 update the CRC32C driver, which has a jump table
implemented in assembler, to
a) use a relative jump table, for compatibility with linking in PIE mode
b) add the jump table annotation
c) make the jump table more difficult to identify by objtool's existing
   heuristics, so that it will fail to identify it without the
   annotation.

Changes since v2:
- drastic refactoring of the annotation handling so that generic users
  (non-x86) get it as well, with the x86 heuristics moved to a x86
  specific source file
- use generic reloc type identifiers where appropriate
- update insn->no_reloc where appropriate

Changes since v1:
- tweak logic in patch #1 to ensure that all jump table entries are
  covered by the same type of relocation
- use the corrected addend when validating IBT targets
- add patches #2 - #5

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Kees Cook <kees@kernel.org>

Ard Biesheuvel (8):
  objtool: Deal with relative jump tables correctly
  objtool: Allow arch code to discover jump table size
  objtool: Make some helper functions globally accessible
  objtool: Move jump table heuristics to a x86 specific source file
  objtool: Add generic support for jump table annotations
  crypto: x86/crc32c - Use idiomatic relative jump table
  crypto: x86/crc32c - Add jump table annotation
  crypto: x86/crc32c-intel - Tweaks to make objtool's life harder

 arch/x86/crypto/crc32c-pcl-intel-asm_64.S |  50 +++--
 tools/objtool/arch/loongarch/special.c    |   6 -
 tools/objtool/arch/powerpc/special.c      |   6 -
 tools/objtool/arch/x86/special.c          | 160 ++++++++++++----
 tools/objtool/check.c                     | 199 ++++++++++----------
 tools/objtool/include/objtool/check.h     |  25 ++-
 tools/objtool/include/objtool/elf.h       |   6 +
 tools/objtool/include/objtool/special.h   |   8 +-
 8 files changed, 287 insertions(+), 173 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


