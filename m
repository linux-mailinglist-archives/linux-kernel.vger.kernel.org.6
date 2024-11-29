Return-Path: <linux-kernel+bounces-421591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE229D8D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E257CB2866A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43AD1C1F20;
	Mon, 25 Nov 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecVGFPYH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9A1B87EF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566032; cv=none; b=G1KS5IE3KwZlFwGRNDsG7y+dMOe0nwqV9UZFP9NahrBphJr9ncDV4I1B8J1szSsAuW8YpFBgr0nFGZWPewKY9OseEeG3noeXRHtzdL640Uasu1wI7r93loOKD8Q9TQwTYlD/7aFigLy/64b3S7B5rbpb+AjiPEcDiHyT5jQ2l54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566032; c=relaxed/simple;
	bh=Oo4v+HG1zO3N6WM7Pgry7iY5cnE/SrT42LHsUZJbp1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0KkMSZh10MZuCLcmRHl3c/jCqjhwqag5FBhFIESYrk40EIiExhpTy38zwD9G+YouyCgkRIFh/fQFzQuhfusHR0Wlccg1HwhHH+X9BXrety32dTl5g0FTnnRXX5kfQcy2/RaJ9VieczauJy3GVjPUOjHgHhtn22N73lyCbok6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecVGFPYH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2121858db03so5485965ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732566029; x=1733170829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bPBR8Yw5Dhs7C/hFxnb3GEJDbYT54V2RImcN0+GcoI=;
        b=ecVGFPYHfsCtk2HBuJEwT8Ju56GksTbtCHQR+JeO3Xy5BEJ0roffJns7yLp4HkZKWl
         2LX6Z8+CR2wQunGYR8dhSFm4pTZpiKFyoQoYBvquIQZ9Db/gxsghl6nJ54TCW64eJlGO
         ImcFMU4sq4vu1xH6NmPwHMQ8aLPi+2BV2hwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566029; x=1733170829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bPBR8Yw5Dhs7C/hFxnb3GEJDbYT54V2RImcN0+GcoI=;
        b=WFhzdh9WgGIHgst0o+/S/ky9DK6qifPAdvabeqgrI4q+QkqvHYYGpCfmp6lUBWGtSN
         smUdJSrGkmhPikEEg+Rep6Jx57rwY9j7rLWVSy+wZwRz2DSFpgnXagMnVEjHjBbk4xhx
         NnO2EyLeKPcwzNA8h02JH0KYwxRxTF9w8GvLS6p+Eeahio1e58CdFcVwWFMvDLyibBwb
         JakPZjtrEStUnZSAFPCZclWTvQmJ1U6rka3xt+0/sRbF+Hk/A4sEGBrnZgURNX0D8UZX
         VopZKI2x4JO+yaLw+2VEFNURZoszalnhxlBf+Yhi65OcnLCBt9/U620sTaLxZXKnIjhz
         nhuw==
X-Gm-Message-State: AOJu0YyjLDY7O4puDTdLSTS2M/Py+vEZeWmYSrFt8s8Kaz88yW/0hp8q
	tPVYEGvGd3anXTzfDywEA6YQW43tPmdyE/0oCqD+giv9aeTW5kLsN2TAkoqhcw==
X-Gm-Gg: ASbGncvdz3j4AOX0RjxQq0+YtDdd/qhSyvLQOR23GRkgEmpDpcF0rc2yAlFAcp4Ge2b
	AIlAuSP0tcUpTbmgUeEoz9hIcy+SdiuDtA+dG/PX6mKiIN/0LZfEyAB9+UoN2unKMdzpf1fTU6W
	nULYaXww5xo7f6Yc5QCBEHr3NtiCu2RvalgLB7Bwy/J+IaoPBtnTJeJzQA9fcQKLfXqtnRWDXcx
	DB7q0aq2vPxfCeTzznG4clhjjH3osUTcVNg3//CMh7DBbBAmG4KVupoaHmtsc/E5IHz+N9mU6uW
	u/91RhBTZZs=
X-Google-Smtp-Source: AGHT+IHp2QrrU3RI0OmIU17fgwey6/8O6ZVj8X1aM9FXZJNL58pk/JZ4qsmgGuHB2EK2wRDkI9lhEw==
X-Received: by 2002:a17:903:2291:b0:211:ff32:93 with SMTP id d9443c01a7336-214e4416006mr8613105ad.4.1732566027670;
        Mon, 25 Nov 2024 12:20:27 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2129dba5d4bsm69486135ad.80.2024.11.25.12.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:20:27 -0800 (PST)
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
	mpe@ellerman.id.au,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 0/1] Seal system mappings
Date: Mon, 25 Nov 2024 20:20:20 +0000
Message-ID: <20241125202021.3684919-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
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
as the process's lifetime [2]. It is sealed from creation.

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
across all systems.

Currently, memory sealing is only functional in a 64-bit kernel
configuration.

To enable this feature, the architecture needs to be tested to
confirm that it doesn't unmap/remap system mappings during the
the life time of the process. After the architecture enables
ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
Alternatively, kernel command line (exec.seal_system_mappings)
enables this feature also.

This feature is tested using ChromeOS and Android on X86_64 and ARM64,
therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
Other architectures can enable this after testing. No specific hardware
features from the CPU are needed.

This feature's security enhancements will benefit ChromeOS, Android,
and other secure-by-default systems.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

History:
V4:
  ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
  test info (Lorenzo Stoakes)
  Update  mseal.rst (Liam R. Howlett)
  Update test_mremap_vdso.c (Liam R. Howlett)
  Misc. style, comments, doc update (Liam R. Howlett)

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
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

 .../admin-guide/kernel-parameters.txt         | 11 ++++++
 Documentation/userspace-api/mseal.rst         |  4 ++
 arch/arm64/Kconfig                            |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
 include/linux/mm.h                            | 12 ++++++
 init/Kconfig                                  | 25 ++++++++++++
 mm/mmap.c                                     | 10 +++++
 mm/mseal.c                                    | 39 +++++++++++++++++++
 security/Kconfig                              | 24 ++++++++++++
 10 files changed, 133 insertions(+), 2 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


