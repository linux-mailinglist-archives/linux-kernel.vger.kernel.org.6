Return-Path: <linux-kernel+bounces-376932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B509AB7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C9B2229D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B51CC88A;
	Tue, 22 Oct 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLX+9nUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D91CC148
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629654; cv=none; b=reaLrr5TxXld6Bd4XlY+CHrIQ7c1FNZOK5ckmUGqjWL8Km6FwSaZ4gi9gSonsmYFO/sHufzB+f0BcRpiNVRrhAyzY/57+Wg5WUIFVfd4BwNJ/jRg212b5qwWrsJZYMX65d6eFB5c/NuH33BtKotqICv8pQnGMpuQdSOZTiHKCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629654; c=relaxed/simple;
	bh=lXfZsaSB2xRVbxd4v1nskgbEFpfrQa1r2nFPl3y322M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kWuqHLJjgxl6TBNwXerUftvuxpBuPMQ90Dxp5u3/qNVg+iAyhK2cUii3UklWXcDL5Y8dB6CrJ8OMbm64ooEBxPLP3SOton1aNIDN/mYnPLuDJQItQAYa2JNAgNDl6j+DpMdFAZHIhxerKotrmRR2osQHVCZcD9yTtC+d+DEbJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLX+9nUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F773C4CECD;
	Tue, 22 Oct 2024 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729629654;
	bh=lXfZsaSB2xRVbxd4v1nskgbEFpfrQa1r2nFPl3y322M=;
	h=Date:From:To:Cc:Subject:From;
	b=BLX+9nUkZ1S1zja5Z8dBbiXWv41iUZd3WDACJDncbFTIGEkO0wsTC2czzWKfkTGqg
	 LXSKN5U+Zx19ejqT3nfjZa4hWHilRsYc6/45zklFOGSxrn2oaCtF0Ik4kZcS+GnQdu
	 90N78XZXHa6OqTfSU8AI5rU0fyuvyTeyEIxwUMIjc+9UNUzWXOnjCenoEGBXCk2QV6
	 8/B2fc0G3Hjwh8f1ybi4p8DdhwYCYD2PmXB05+yYtPa9T1Ina3H2obM28WMWjIurcH
	 b60Mpj+BtGgxuM7QG41nDT7qh1I4TOnFAi1svNVSKxsCKwXKWBsZgXN7yGEgRc9cyU
	 BxlSkjTblLk+g==
Date: Tue, 22 Oct 2024 17:40:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync kvm headers with the kernel
 sources
Message-ID: <ZxgN0O02YrAJ2qIC@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick the changes in:

  aa8d1f48d353b046 ("KVM: x86/mmu: Introduce a quirk to control memslot zap behavior")

That don't change functionality in tools/perf, as no new ioctl is added
for the 'perf trace' scripts to harvest.

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index bf57a824f7228121..a8debbf2f7028059 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -439,6 +439,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT	(1 << 4)
 #define KVM_X86_QUIRK_FIX_HYPERCALL_INSN	(1 << 5)
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
+#define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
-- 
2.47.0


