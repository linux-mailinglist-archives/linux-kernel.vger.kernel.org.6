Return-Path: <linux-kernel+bounces-307730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4176B965235
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE62B23F57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A78E1BA863;
	Thu, 29 Aug 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfsC/wlx"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B31B9B51
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967844; cv=none; b=Y+CchsPKfZnJMgXNGfQf/OCSbatoS9pF7objPMttkuFC7oxemtygyTeYS0qJQmxAkHSmErMwqEKpkZU2Cb6yUmLRdfnSXVy1UaVe1+ZNbGWL7sIAY+tPp4SxuaKkgP8OBOFQsrJ2k81J2CROzYbkWKISbNpFtyzfb1kbBPW3wUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967844; c=relaxed/simple;
	bh=eHI+f1Eqovx5OQwndHYsw55wZ2XeQdOu0E/2/hhAMrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJDShN3zFyea1czfhk8XPvdGgqeH6Jm9hXxL+qOMtbCERyEEeEr3vz1H2tnfFSiAWujST7sCD/qok7My5+kaTmzWoc5RLQNZu4qJnOye8WkDdUubGRAO0BQIMqGTKszSVQQXjGnpVxu8BW6DU4vE3oB2VGHhSxNNMcbH4uOm63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gfsC/wlx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3d382de43so184527a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967842; x=1725572642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK5nX6Fz7aZSj3TONXgJWUNXXUeXSM9VDMyRB+JVgZA=;
        b=gfsC/wlxKr5iTDLhfzCIHcbSHCHv195llFGSCvkAkx1aNgUZcAGC/O/kw8dtMJW6iJ
         VSGADQrtFQYtgD7Ybt3oRSCsPuPxtZ0rRHAyRSVb5Nhjz6aCNfgpc+bMfYP9BWuk4Azz
         IYPiBTfDf+7Awn7m2u11n51DE3l7SEeYWyXhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967842; x=1725572642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK5nX6Fz7aZSj3TONXgJWUNXXUeXSM9VDMyRB+JVgZA=;
        b=LME5tIttl+IzlaK4/7fRqWIx/+k3z7LyV0v467l+K4IxWYMbJHT12X0B7BdZJen1QT
         yUjVTwdsHXDmvtZT4VpjPsyKGnSz9RwLqivbr2dqGbjnxlvdHKCIL5tDXC7g/MNB71o9
         NA/lrjCUbXZX3MG6b0rCUcmskXRblBtZMEvsYd2NsODm9VA5R4FmHTe0cVwc2zpIyBWl
         jNZXBbKW/L3+Cu2rL1trS7/B2wRg15ZfwoYSbAvtZevjGnpyOTkDwu5y6wwfQBIDllXQ
         Kbu8b6aGoeI2p3BhreePHHchqcb2FBJAe5JZmeKR74cg+VYBZxdGdwwcoayBW69h+ZyM
         3jDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgnMTgTpGrj8YW/XaVXSHg0OffliVDZmzUMGrTh0No6TyDXAh54iVfrwwj3QF2jvei2LaigKDXYfGaO4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzddi4TYMP1hZYsrvN7SOGLek+sFnXwWNNcYgfWXn/HoBZVAecm
	Ed+MhLZmHLDFgc16qna/HyJeX3igQv0QnIDAQIoHUWSQojgM/TUtRLojewQU5Q==
X-Google-Smtp-Source: AGHT+IGFvjpKVKwU+AAy50ZE59B8TjM2zpkvqC2OVhuQeRtuultPa+ORe7Ydhsh/c2eWukZ+bzk+sg==
X-Received: by 2002:a05:6a20:6a27:b0:1c4:dba6:9eff with SMTP id adf61e73a8af0-1ccee3a8b83mr193225637.1.1724967842061;
        Thu, 29 Aug 2024 14:44:02 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e55a94casm1592892b3a.70.2024.08.29.14.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:01 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/4] Increase mseal test coverage
Date: Thu, 29 Aug 2024 21:43:48 +0000
Message-ID: <20240829214352.963001-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This series increase the test coverage of mseal_test by:

Add check for vma_size, prot, and error code for existing tests.
Add more testcases for madvise, munmap, mmap and mremap to cover
sealing in different scenarios.

The increase test coverage hopefully help to prevent future regression.
It doesn't change any existing mm api's semantics, i.e. it will pass on
linux main and 6.10 branch.

Note: in order to pass this test in mm-unstable, mm-unstable must have
Liam's fix on mmap [1]

[1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t

History:
V2:
- remove the mmap fix (Liam R. Howlett will fix it separately)
- Add cover letter (Lorenzo Stoakes)
- split the testcase for ease of review (Mark Brown)

V1:
- https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/

Jeff Xu (4):
  selftests/mm: mseal_test, add vma size check
  selftests/mm: mseal_test add sealed madvise type
  selftests/mm: mseal_test add more tests for mmap
  selftests/mm: mseal_test add more tests for mremap

 tools/testing/selftests/mm/mseal_test.c | 829 ++++++++++++++++++++++--
 1 file changed, 762 insertions(+), 67 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


