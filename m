Return-Path: <linux-kernel+bounces-380507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B079AEFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D32B1F21F54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4D1FBF5E;
	Thu, 24 Oct 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYRu9NwF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF016DC3C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794996; cv=none; b=mH4a+C12V/s2oiIf3LAPH+AOkeN12MCufy6+VTdJGMrHP8YWru/w5Busg1IgC6Kj0luULZ8ytjIJY0m6d0aR5gFIGEW32HPdg6IQp4AP+vZr0sIRWGF2s11KVihOZa+qSYgaRJrAj8VUC+mY+WqW4ukjYYy/Ia2Ya+WyzRwb8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794996; c=relaxed/simple;
	bh=a5eFzVRaDwCy32PaixClVsyZzasvzfUDiBm2rlZY9tw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uDaOo4ERZ0Hl24m0+NLsSWCMRKuro/DPyLzYsUHqtLanNjoaTR+Chw6d/Sc08QwM0/sL4NpkJFN2ZILIOAJ3G1ZKpX+4DSewHmvY8jui4y4hU2fpcOftAh8/jX0meJhwjqQaOX8rIp6RgDwTAxix5KR+9k4QC0K4sAjK5t/A/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYRu9NwF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2cc47ce63so1155550a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729794994; x=1730399794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o+OpoGYpuu+VOiTDcB6qyCJjcJCoQyq1uUPcEb5ntjk=;
        b=KYRu9NwF2Nyi7yi5Aqq86u6erhL05d8iwENrYHau0158PgwJJ1n2XhVNacWnNChdsS
         AU+GGH8eAkY1tqXIqf+oHTTBV0vShuuxg4qCvEEjO6E9qnYBPuWD9cnALGIDbMa57OpE
         B0vQuukSmUVPCLQh4rUhBL0FyHV2G5R7BM+OBerxZ5EoOTn2yZ+rz1SsSs89H1VqjKWb
         mNgUFrfL7bTjb5JjgFdfbEsSFhBuppBDplz3XqhfJuxft69hQ6s7up8YnhRloS5SK5P/
         35gROrfqLRs2YQYED7Skz4n1IGUbXm7eFm9KfM77YphUEJ5pivx+pCODExlC/qBYAvgR
         UM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794994; x=1730399794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+OpoGYpuu+VOiTDcB6qyCJjcJCoQyq1uUPcEb5ntjk=;
        b=UfLMQnyCmpMKVg7w0/AV0RWPSIDMsoWkc+FwzEHO7k6egzxiGsHrLocuyebSrGseC6
         uCL6ETKtMTzFybk/4KUQocMzs7vNPxDdAyKLjXJ9cgAQ5/UkNyFEeaWLQNDGTZUr2RmU
         Pa255ErDnJHPTiclt6gSJq2xgLHJQhWTJ6ozdhCCNFvW3YkL2Q6ITIExieFXLpjMXBoa
         fWMgBOmOoXQ0jvr+0budKstVd4oovHpc9oiEWSibKzmtnMkVE4xhR0C0oSG8pSR5yjIf
         eDQapMiY58Laj9OVdiwbG5TTbm8r3STBbHlYWdt+RrHrNTKN33PqCjflLxu+rFytirHu
         /rDQ==
X-Gm-Message-State: AOJu0YxKfJHlgoKeoPV9dNH/oIe9KkNo6IhJYDWdyQhIrt3B0BbVCuNN
	1FX4sybLe0mS/iHVlTjUFp+ayZeDrbgZfmyl9T64mNBld3sQsXSPOQuLDAvC5EwoKbsxD5T2EP8
	O2ku0m113mg==
X-Google-Smtp-Source: AGHT+IFwxRFPy+Cxzb4S0e6PlxzN4oZZaweN8IRPOrkf+8Oq5Iqe7SNEQTfG/6ErxN8ulpbn9r+s0IYP+HtuvA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:d815:b0:2e2:d5ef:1d91 with SMTP
 id 98e67ed59e1d1-2e77f4cd20fmr3714a91.3.1729794994074; Thu, 24 Oct 2024
 11:36:34 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:36:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024183631.643450-1-cmllamas@google.com>
Subject: [PATCH v3 0/3] lockdep: minor config and documentation fixes
From: Carlos Llamas <cmllamas@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Huang Ying <ying.huang@intel.com>, 
	"J. R. Okajima" <hooanon05g@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

These are some minor follow-up patches that came up during conversation
at: https://lore.kernel.org/all/30795.1620913191@jrobl/

This v3 is based on master as commit e0ba72e3a442 ("lockdep: upper limit
LOCKDEP_CHAINS_BITS") has now landed.

Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

v3: rebased on master and collected tags
v2: https://lore.kernel.org/all/20240807143922.919604-1-cmllamas@google.com/
v1: https://lore.kernel.org/all/20240806010128.402852-1-cmllamas@google.com/

Carlos Llamas (3):
  lockdep: fix upper limit for LOCKDEP_*_BITS configs
  lockdep: clarify size for LOCKDEP_*_BITS configs
  lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation

 kernel/locking/lockdep_internals.h |  3 ++-
 lib/Kconfig.debug                  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


