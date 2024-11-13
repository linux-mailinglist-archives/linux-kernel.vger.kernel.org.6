Return-Path: <linux-kernel+bounces-408210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F99C7C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A3EB29BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847B1FF7BD;
	Wed, 13 Nov 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+DSQ1l9"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13F176251
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525370; cv=none; b=FXPWeVLMoLHyqH6aPwlbWQoKmaaXS4bV2ErxigjRL7VVSnC+vnyh7JReVN75iM0M0L5iNfeAEJoxmtDV16k3lEfpMO/aXPSRK+WA1QSxqujgEm3BoBLYl8tqB5IEKWtnPwf6WT9cl/mGXALg3oHJ76bZoXKnEYrz+aU9nbuF9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525370; c=relaxed/simple;
	bh=YVhuCJBy/RTajvaqUqjmHV6sGbVXjJ01Js/Rc0hhCGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJ+DIfJ6KvXTYjzpE3rl5vmSE4BAa4/hjuKRJcseDN8zOVuuZszvEe2AOsdA/u4DwjYcj3rCnpkC47OE33j7+m8/pR9SXc3ZboRhRHXSFVPLsTJhsiqTCX9k47Gdg6Qq2qc+JMcGr8Od/tByGl7JqXDNQVupEGPiF096lDuMNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D+DSQ1l9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5417f8d4so128141b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731525368; x=1732130168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ1xBx06y8ZAnA3UnsQH/PtPZjuuHaBD+33LmtepObE=;
        b=D+DSQ1l9bmOWQirbOUFsdqcv68sqAhCEsprYyIqB9Lx7fBPwQh4urSwFR82w0cCLuD
         JgAUWr4OLhX4HpfIN0uKIQXbYqPqb6ky49dN8SIWqwas4XsZ6SFnJ17tDeJrb/UA7W5F
         SFpEGAU1kzagyVKWWvTRaqZKBvAqeKnTkzWtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525368; x=1732130168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ1xBx06y8ZAnA3UnsQH/PtPZjuuHaBD+33LmtepObE=;
        b=OD7NBB2G06gq5TAK57KgRxIrGMmPG75te1sG4zAuB2oM3i53nOEOPNb/XCkSXmy359
         l2jH3e5TBX2rjEZ/TdjLE88Y8Rugmur0bROif5jUVn5uqm+K9n6iFZ+r8SGCj2msqpnj
         FVRmz5A4WPmo4mVIlcv7VvpLeDftXK7gX9kBDd0mISxZKpxGyNiR+t2mEpip9gX+I+IZ
         oIl1vaTZKonb+u2g48flaP+09zauwZO5pTwQuL2lT8pEPsFeypeMLJC5BEDGHeAGtw7r
         mBLZQqewCRrfeHTs3f6u0QZwKuuRyDtGCXssr/umszO6Gr/Bu2cCT+khXS8JOOIpUWFP
         St1Q==
X-Gm-Message-State: AOJu0Yxw2x23B0xkJQHBykvjoD/2RMfS8eVCdd2TgY4yds6+5x6VBft2
	wg5ZMqJ5ePCgJvevGgiRPQuXMYSqqRyWBGzg66vevuHmlrBSRTcnZ7nzkgm5Hg==
X-Google-Smtp-Source: AGHT+IE57qKtu5zFu6AlasoUgUPGht35UyGvr0mAKtZBxlpo0wcpjfLve2+qn74cQ7eZo0jnCIbaSg==
X-Received: by 2002:a05:6a00:b56:b0:71e:770d:2c00 with SMTP id d2e1a72fcca58-7241334b1c4mr11122411b3a.4.1731525367948;
        Wed, 13 Nov 2024 11:16:07 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724078cd2bcsm13635731b3a.84.2024.11.13.11.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:16:07 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 0/1] seal system mappings
Date: Wed, 13 Nov 2024 19:16:01 +0000
Message-ID: <20241113191602.3541870-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing or unmapped during the life time of the process.
For complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization, and are
sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [1]. It is sealed from creation.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

History:
V3:
  Revert uprobe to v1 logic (Oleg Nesterov)
  use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
  Move kernel cmd line from fs/exec.c to mm/mseal.c and misc. refactor (Liam R. Howlett)

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
  Seal uprobe always (Oleg Nesterov)
  Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
  Rebase to linux_main

V1:
https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

Jeff Xu (1):
  exec: seal system mappings

 .../admin-guide/kernel-parameters.txt         | 10 +++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
 include/linux/mm.h                            | 12 ++++++
 mm/mmap.c                                     | 10 +++++
 mm/mseal.c                                    | 39 +++++++++++++++++++
 security/Kconfig                              | 11 ++++++
 6 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


