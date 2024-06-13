Return-Path: <linux-kernel+bounces-213896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82436907C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C111F244CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA314D71E;
	Thu, 13 Jun 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XtGa5DO3"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872F14D2A0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306233; cv=none; b=EOMV8eLZeX/6abpBrfq6tqJ0mQ0t+6xp9X0Y9zbopTvzNWBYbJS20S9vlVX2HFbSUwZOC0JEZACnwkb0qPZ07V4JmR76Rq1nMGntJWt+6BNNiWb3wd9zTmQamWV+skwWEhx+i7O9YBBFBh5BW4LpYw0jvHZR3Ym5pQpk386PNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306233; c=relaxed/simple;
	bh=CrA2LbZw2fj1oZQlxW6cbBwREuI1pwVFNKXdbbVw6aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TAb+E+QL5Oi+iZQ4m6RVhX4NDQrKzfBLa3AX+s4JoyO6Zy9bROwZ4JM+W09IKEZP35woOpzVf229Y9IQr76ZmGhz3elU7d4f9FtLmcvPsHoFEr4qCcNWV4a433lPzoh1l3N9yLbHrxljFTGif3qeX2vK+pPj+f1rXoGDyOaNBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XtGa5DO3; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b06b78e716so9257796d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306230; x=1718911030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=XtGa5DO39owFRgz7eiFLh0BKcx+ZaoAoM0nazFe9979KkIrj2TS33fQOBeBFWkt3Us
         Q4yHnPiKUmHx4iVAolspZgZwAlJ3KyZcy2HN6ng8IRO9ORy3IKXllSZST8ROGxwtywBk
         dIgcjokRQ0mzaajlLTvC/0kBhAhv8r4+zwp1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306230; x=1718911030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=M5dz7r+ukO580FIbfKQ5A3lS80I+IuGOjA2FYpPvw8zhfLL2hQuFM2bfZ1+76D1i4T
         /H2Y11Kmnh+WKzQTUXR+lGqa4PHEUJwskIeNygeoLMLvVyC/vvVpG5APc1nvQKW9OSrH
         HQA5H9ZLO0NMCEkz07PP1+p048IRtPZacbDwBUg0A8tyzl+fTZbPy8mSX6c/wGqdnJ0o
         AuY+PTbtnAF3NIPeprLJVha3yGp/uRTt2W3qJLLbamch+KabiXfWKTrlAQulZhK8w8NW
         PQKJzTTj8V2zF2+M8dHGhjq0NfmLFC5Rw8fKm/2qe8hVlkGUUK5t+p2cGXuMOO/Xz6xA
         K5Zw==
X-Gm-Message-State: AOJu0Yyfuwb0vPvLOLWsBqVrUX3Secvaa0/Va7MIqtW3BwUXHQdm/85Z
	L8WuHcLE/RaGPJs5MN2v3ktPjyTkbii0Sf9m09rRZiTA2FP/pHOPoyb6hnkb/tyJxpm0Sr3PY/Q
	ggtMFikPtCLEG0nrxWaaY+aqtmZcMvSpQPSFuEfFW1M0pmfetuA+Fq+hH489u/bBRn/hWbkrEOM
	lpfsrHKtge1thXfeCFlse/kEKtSb6aKkruR52fDBN77pI94xr7a9Sq
X-Google-Smtp-Source: AGHT+IFjEHPK4k0l7eyVsilK8yUQTNHgIqYDnv7SJ1An/1VqFCPEcRK7LH9vCsjmYZUTW3mQYOd55w==
X-Received: by 2002:a0c:f882:0:b0:6b0:839e:ba6b with SMTP id 6a1803df08f44-6b2afd5f040mr5356876d6.43.1718306229909;
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v11 0/8] VMware hypercalls enhancements
Date: Thu, 13 Jun 2024 12:16:42 -0700
Message-Id: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMware hypercalls invocations were all spread out across the kernel
implementing same ABI as in-place asm-inline. With encrypted memory
and confidential computing it became harder to maintain every changes
in these hypercall implementations.

Intention of this patchset is to introduce arch independent VMware
hypercall API layer other subsystems such as device drivers can call
to, while hiding architecture specific implementation behind.

First patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there. And the last
patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

v10->v11 changes:
- Redesign VMware hypercall asm inline. Move slow path to a separate function
  keeping asm inline alternative small a simple. Suggested by Borislav Petkov.
- Use existing _ASM_BP instead of introduction of VMW_BP_REG as was suggested
  by Uros Bizjak.
- Patch 6: add "Fixes" tag as was suggested by Markus Elfring. 

v9->v10 changes:
- Restructure the patchset as was suggested by Borislav Petkov to
  introduce vmware_hypercalls API first, then move callers to use this
  API, and then remove the old mechanism.  
- Reduce alternative portion of VMWARE_HYPERCALL by moving common code
  outside of alternative block. Suggested by Borislav Petkov.
- Use u32 instead of uint32_t in vmware_hypercall API and across vmware.c
  as was suggested by Simon Horman.
- Remove previous Reviewed-by and Acked-by.
- Fix typos in comments and commit descriptions.
- No major changes in patches 2,3,4,8 compare to v9.

v8->v9 change:
First patch "x86/vmware: Move common macros to vmware.h" was split on 2 pieces:
  "x86/vmware: Move common macros to vmware.h" - just code movement, and
  "x86/vmware: Correct macro names" - macro renaming.

v7->v8 no functional changes. Updated authors and reviewers emails to
@broadcom.com

v6->v7 changes (only in patch 7):
- Addressed comments from H. Peter Anvin:
  1. Removed vmware_tdx_hypercall_args(), moved args handling inside
     vmware_tdx_hypercall().
  2. Added pr_warn_once() for !hypervisor_is_type(X86_HYPER_VMWARE) case.
- Added ack by Dave Hansen.

v5->v6 change:
- Added ack by Kirill A. Shutemov in patch 7. 

v4->v5 changes:
  [patch 2]:
- Fixed the problem reported by Simon Horman where build fails after
  patch 2 application. Do not undefine VMWARE_HYPERCALL for now, and
  update vmwgfx, vmmouse and ptp_vmw code for new VMWARE_HYPERCALL macro.
- Introduce new patch 6 to undefine VMWARE_HYPERCALL, which is safe to do
  after patches 3 to 5.
- [patch 7 (former patch 6)]: Add missing r15 (CPL) initialization.

v3->v4 changes: (no functional changes in patches 1-5)
  [patch 2]:
- Added the comment with VMware hypercall ABI description.
  [patch 6]:
- vmware_tdx_hypercall_args remove in6/out6 arguments as excessive.
- vmware_tdx_hypercall return ULONG_MAX on error to mimic bad hypercall
  command error from the hypervisor.
- Replaced pr_warn by pr_warn_once as pointed by Kirill Shutemov.
- Fixed the warning reported by Intel's kernel test robot.
- Added the comment describing VMware TDX hypercall ABI.

v2->v3 changes: (no functional changes in patches 1-5)
- Improved commit message in patches 1, 2 and 5 as was suggested by
  Borislav Petkov.
- To address Dave Hansen's concern, patch 6 was reorganized to avoid
  exporting bare __tdx_hypercall and to make exported vmware_tdx_hypercall
  VMWare guest specific.

v1->v2 changes (no functional changes):
- Improved commit message in patches 2 and 5.
- Added Reviewed-by for all patches.
- Added Ack from Dmitry Torokhov in patch 4. No fixes regarding reported
  by Simon Horman gcc error in this patch.

Alexey Makhalov (8):
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Use VMware hypercall API
  x86/vmware: Correct macro names
  x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 336 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 212 ++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 196 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 654 insertions(+), 536 deletions(-)

-- 
2.39.4


