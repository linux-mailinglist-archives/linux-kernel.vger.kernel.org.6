Return-Path: <linux-kernel+bounces-395740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4D9BC246
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FB5282807
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41496179BD;
	Tue,  5 Nov 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdY48/gW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743EB65C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768773; cv=none; b=dv/b+OF00YONBVmmCm/xP+TlFIppeqFAMtb7AiWHYYxmVgraL637SSqOZRAkHIkSxtaFLS4SI4/k54S26QbofocfNpNrsapaamtbnxLguUpWahqR1a5f1usGSI8Tk9fvipovcBiAtpGad8LEgqap8XTdJ0tHSObywa/ldizl7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768773; c=relaxed/simple;
	bh=fFY/aMr29idY8liczq6D69o9RB1tTz0jsGGFgwfFP2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQ4iPIwBBrTlOsxoKRQMuldpXLWawbxjT5FWJRUD8rNAVQKcDf4dUPemZ8eDrJ1plNnFzH/ad08mo9W2poRbvOyM+uFjyJ6VTjnlp6ghaLfyMrlccJC78XDehk7d7XSQe3FMSXafb7L/lO2RlZlxvmLHIv5c3C/gJmLSow4dCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdY48/gW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so93558787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730768771; x=1731373571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rchq2VcNLG3Lq85wTwbHMPK9ra4cT/z/iAEej7V/re4=;
        b=rdY48/gWIzyqIZ6siuph7ZA8ii0ucAx9+QUIb6SVCO3XpuyAWDc33Yyu9IGTmgGdP4
         LqnSH1sdHlvnXnIBpuatJqdJ/e4rF8VZL4BFFGTu5Kz1uh1IA5cVZNvI8I6XlsPd+wo6
         Em66P3ZMwnbf5dxjVypZiX4UVVvryyZnRTAyojsVo93G7PYel8PZWwA56nXEXHSlTS8P
         7egjvsGExbTrRVndsrsRaA34oC0SdWSLRX2OiY6XTsjVxRpxyTyCcHEDu3GEoXPE9GuS
         gomDQqe5655cSiDl95lxzX8Z4p56VMIEbutF7Pn+VMpnRArJeuvQYMZ7pN8fETCjh330
         50Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768771; x=1731373571;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rchq2VcNLG3Lq85wTwbHMPK9ra4cT/z/iAEej7V/re4=;
        b=ml6nnaQ30NFAh/UWbCQK8HPYtZMU+AeoabaPDQWJT2NLkC9euO6vBsN60EghDRSrAk
         o0fXzQ7mmkTA2RhctSJMJnVtGTGWwhKkfp4IreSsk9ggF9E3jjPUowxTmW4gG73jQ+XQ
         Pp3oaqb4pcnFZQd0wwy/ZFoy0mXIXujoF+75QXJRx1IqNngcJ6Vws+XjXGFfcj4NMKEf
         CSd8To1t3P0O7q1q2RdKR6GsgLOGTNa85lrWVMaum/oiCDQst2DxpM0R3rii3z9Mkjom
         9Qb+7g3DxJPWZEbK1E26uWUIhnFBpSrUZ8rtLmrQCNTS3DCQvoNguiNBVP2tbz+mLyji
         M1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUIOApIzq9fWvnY8jgR0yY8BhRIJFuK9S3dZnbpAhMBTESXu9IRPDw0qcVU7OQRLokKuT17mp1G0RNqQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iujjnSDTyDh07uphuklMcthh1wg5Ur0PmYy1SXqi27YiFZ78
	E5OkO67tlAxMyJpwZ9SIADeg7g6L/3kZkHw8pU1DiEmiA2gGnyK8R9xUysWkM1m/0lQ5t1QSH10
	7h87aMyzQ4M/mF7WzRlv7eg==
X-Google-Smtp-Source: AGHT+IE55leW11JTUmZRMGJnRLHkdfDXVL2IoTyzPGJ9KBCJpTaaQz3fL4fxrds3ylxyY4qiMW4wEr/jNpYd9BHTsg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:690c:6a03:b0:6e3:1023:3645 with
 SMTP id 00721157ae682-6e9d8c3651fmr9023937b3.8.1730768771006; Mon, 04 Nov
 2024 17:06:11 -0800 (PST)
Date: Tue,  5 Nov 2024 01:05:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105010558.1266699-1-dionnaglaze@google.com>
Subject: [PATCH v4 0/6] Support SEV firmware hotloading
From: Dionna Glaze <dionnaglaze@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Dionna Glaze <dionnaglaze@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Michael Roth <michael.roth@amd.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

The SEV-SNP API specifies a command for hotloading the SEV firmware.
when no SEV or SEV-ES guests are running. The firmware hotloading
support is dependent on the firmware_upload API for better ease-of-use,
and to not necessarily require SEV firmware hotloading support when
building the ccp driver.

For safety, there are steps the kernel should take before allowing a
firmware to be committed:

1. Writeback invalidate all.
2. Data fabric flush.
3. All GCTX pages must be updated successfully with SNP_GUEST_STATUS

The snp_context_create function had the possibility to leak GCTX pages,
so the first patch fixes that bug in KVM.

The ccp driver must continue to be unloadable, so the second patch in
this series fixes a cyclic refcount bug in firmware_loader.

The third patch tracks GCTX pages created and bound to ASIDs at the end
of __sev_do_cmd_locked. These pages are necessary to know at firmware
update time since any running VM must have their context pages updated
before the firmware can be committed.

The fourth patch adds SEV_CMD_DOWNLOAD_FIRMWARE_EX support with its
required cache invalidation steps, but without a means of calling it
from user space.

The fifth patch uses the added command from an instantiation of the
firmware_upload API. When the firmware successfully updates, the GCTX
pages are all refreshed. If any single page's update fails, the driver
treats itself as if the firmware were in a bad state and needs an
immediate restore. All commands that are not DOWNLOAD_FIRMWARE_EX will
fail with RESTORE_REQUIRED, similar to SEV FW on older PSP bootloaders.

The sixth patch avoids platform initialization for KVM VM guests when
vm_type is not legacy SEV/SEV-ES.

The KVM_EXIT for requesting certificates on extended guest request is
not part of this patch series. Any such support must be designed with
races between SNP_COMMIT and servicing extended guest requests such that
the REPORTED_TCB in an attestation_report always correctly corresponds
to the certificates returned by the extended guest request handler.

Changes from v3:
  - Removed added init_args field since it was duplicative of probe.
  - Split ccp change into three changes.
Changes from v2:
  - Fix download_firmware_ex struct definition to be the proper size,
    and clear to 0 before using. Thanks to Alexey Kardashevskiy.
Changes from v1:
  - Fix double-free with incorrect goto label on error.
  - checkpatch cleanup.
  - firmware_loader comment cleanup and one-use local variable inlining.

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>

Dionna Glaze (6):
  kvm: svm: Fix gctx page leak on invalid inputs
  firmware_loader: Move module refcounts to allow unloading
  crypto: ccp: Track GCTX through sev commands
  crypto: ccp: Add DOWNLOAD_FIRMWARE_EX support
  crypto: ccp: Use firmware_upload API for SNP firmware
  KVM: SVM: Delay legacy platform initialization on SNP

 arch/x86/kvm/svm/sev.c                      |  10 +-
 drivers/base/firmware_loader/sysfs_upload.c |  16 +-
 drivers/crypto/ccp/Kconfig                  |   2 +
 drivers/crypto/ccp/Makefile                 |   1 +
 drivers/crypto/ccp/sev-dev.c                |  83 ++++-
 drivers/crypto/ccp/sev-dev.h                |  31 ++
 drivers/crypto/ccp/sev-fw.c                 | 330 ++++++++++++++++++++
 include/linux/psp-sev.h                     |  26 ++
 include/uapi/linux/psp-sev.h                |   5 +
 9 files changed, 480 insertions(+), 24 deletions(-)
 create mode 100644 drivers/crypto/ccp/sev-fw.c

-- 
2.47.0.199.ga7371fff76-goog


