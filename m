Return-Path: <linux-kernel+bounces-187912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6938CDA94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6EB2197A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2583CB2;
	Thu, 23 May 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QXXVze6l"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A9839FF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491712; cv=none; b=VCO84ao6Sgs87gQef847u+YC6CSVJtlOBhZlJbG2hhTAFx1qj7akMDXPwkdRf4fFisVJ8oTy6xQNwfXC63qGYY4v4WSLXXZ0AXpEoPlSsfe4F7VT7G5aZ95WHNmPJgryA6jIa5pEAgyu8dh9grFjrHuO1z4FXkqREUenqQspszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491712; c=relaxed/simple;
	bh=1TBF/VNkoH1JflS/P6I+j9LKBPOuIDfXCd97BmtR6mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqHnMMlQc1lBP0zMkYJ7bfTYX2hnEfPgBwDxXZa0PCZy8817/A3tPY4gweZJSZt808jU0g4Czru+gcRTgzSup00UDc0/Bysx3DpbCSTnHEz4vsCn6JqaGm4gUmqyP1jquQ5RSSNdqs+/xevrfZIm75FjT98UtCxu4+AdpyyfQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QXXVze6l; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9cc681ee0so3392750b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491709; x=1717096509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neX9Rj9kbD2Mta30BndIslB9399YLTZUQPcD/TShwW8=;
        b=QXXVze6lB9TbU1uiLWq9i4nTMn0HhGKcOkb+7kkwwuJQK16gm6txEmLVMv6Kej2USW
         pZ0yImMB/Nsq454T7Ku6nF4uoKGffcwRnhWvyXh+pNQZuagw/eGPPmwx6ec3p5SzN/ah
         K7y3ojzrVrF83XQvu3k0yfVymLNTWJZ3oox0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491709; x=1717096509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neX9Rj9kbD2Mta30BndIslB9399YLTZUQPcD/TShwW8=;
        b=w8uFlSm31JRNNOQR9fv9B6sBpDzmdHGO00tphk43urk6Q9bsY2sqwJILRMPaeHVuYm
         QID9h0RbcyA6hPfre8UDZZrdCX0OJLG9EEHI0QWhWyvm48WzRs3SP6uM7duZqsSusL9n
         kmEYdBbQzsCAt5TZd4nEeMr5F964neSfkV7BbAVIMqMneWtZWaZHW5EFq4qMp9OeGBw0
         FL0CJipUKQga/TFe8kdyEBxSifOiNxY0VI29ldW8clZu8QM/mWtuLmUfRp9wQivW7khJ
         AHc4pZ7N+GGbZNHQYuRqJY8Yb7ofO5MvHI21syp2Sn0UJADkSn0oqN9r5kAr2+TWbs4C
         +YwA==
X-Gm-Message-State: AOJu0YycngPQznIL1+LNSAOEjATL5+FOg6BJ2zAvNH48arUOAsEjRXr5
	0cJlxljqn9wOE1N2f3baRRKsbSWu4RnZjhvdSy6JzFp+YyAG78l051496JIsxJOYklNm5m3k/Gm
	HkmP60mwwuVOm1YOqQkYdlj2uBoM46XWnIs+AT/t+lwfP864N2XYoUPBO9s1u+55TyUNysgoyR7
	HZR/jNvpwfSKsWhIDsAouRnZT28tq1CxA680bEOJea2eukBb0aTiC9
X-Google-Smtp-Source: AGHT+IH/Ysnno2TkFzRL2UNNhoEarRPKJ9VjuR8XSFIlVnpcZKrEaxTEc2+rptviFCowPSempZ9ABw==
X-Received: by 2002:a05:6808:10d4:b0:3c7:366b:980a with SMTP id 5614622812f47-3d1a54835c7mr396574b6e.5.1716491704120;
        Thu, 23 May 2024 12:15:04 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:03 -0700 (PDT)
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
Subject: [PATCH v10 0/8] VMware hypercalls enhancements
Date: Thu, 23 May 2024 12:14:38 -0700
Message-Id: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
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

 arch/x86/include/asm/vmware.h             | 333 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 165 ++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 196 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 602 insertions(+), 538 deletions(-)

-- 
2.39.0


