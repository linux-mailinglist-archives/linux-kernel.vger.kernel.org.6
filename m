Return-Path: <linux-kernel+bounces-393049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CB9B9B61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A3A1C2114A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D31C01;
	Sat,  2 Nov 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keBEPT3X"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45F749C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506112; cv=none; b=lUtsNtV9CETsArBh+4XKQc2wunHlwCFtiP5vF2u2obmLWswBufF1IT6UD22rvBOyR+lJ5QRcYqOSefCOl+VOUNCc20mtd1CTM2Dz1XxFoJdsg6TB6HryIgThVPUrVswbulYq98ty1szAHs3ASWH3dz23HEwBEFu4mvIc64y/0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506112; c=relaxed/simple;
	bh=K1VAQPVUjHp05FqtkiMkE/py7WN/uSlSMBrH41D1a6c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HPTgl08put3oOtXM1C7U1Vt9TKD2oDzu0pOOBaMqBW57lP0M85H7cnr6dd7bivgGDUs0GzJryVX9XRxo6hNvqYOR+ry2R6SWsImWiTtIJVPHyPLebUsSynys/4g9/ybKlxiOUj4TJxpw9A4SypR5lysjZRQspBxJTsPijGNyicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keBEPT3X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e5efb04da7so2477728a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730506110; x=1731110910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=InJ/HRG3JZjFlXztSL9n1ISL7FHhXYKx7rtmr+D9bWY=;
        b=keBEPT3XhV1Y+pA4Ud7sUrX+7Yfv5XAADKCzieFROXW0pSAB9yuEyz/Ue6MOIyTtGO
         fNFP2wWnaw/KBKfmkPYiSPvC8EGsCGWHkKCWzkkMG0hV796wzXWCrGZmhkD4uNaSXiuZ
         6w8v9CKyhTr007F4T+JUHYe6emiJFiawvMDx4EMCPn/RUdAlVd6PXER08SH9Bv8C1MYU
         gPnKwm/+381HzRm7pdE0qc5j84BoMf1Mv72/vT6Nr1Q19HFfzqXTUNQUJkXNvcjgTSlO
         5+lpUHrP6AhFQ/SX6X+90UmWPy+iXHOYNX4rsNU90rOxre+/jiGDPKNcJi6zl0KnCL+k
         fFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506110; x=1731110910;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InJ/HRG3JZjFlXztSL9n1ISL7FHhXYKx7rtmr+D9bWY=;
        b=T/hjZndDbven/m2mj7CJfGwr0NfBBnY/bRBLLNhCnFXtgqsmgoUbxVEflIJIL7PprF
         IHZzd0s55TkYJkNcbdJCSO9SkMfEnqtQKYXVkmYSCZiUqOL1HgaP4Z1fmHAOZuydwH9f
         WkQ3suupeZzteBpCDaAeBoU3ktBsIFPwHgkA5avK9VhRHxGur2DN6pTSx2dDTH6g5Fgs
         10rtSNddfo/mHgKhp/X9Bos6+i3vkGfSZnRJMRNk72oL80TBeu1siPzjMHuU6RFo6x1E
         MVbKOZni0sH3COfTMfD2DGVat05poVWxf7CvnuKv2crIJ+1Yg6smgTcB3VAfv0MSiD4o
         EE2A==
X-Gm-Message-State: AOJu0YzjFB5rMKJfosSIsC4iSVohlgiVSIiNMDU1vetVoe+idHaYB70C
	8T7g0BrFjCL5iSsUUovRqGj95wr5p0WYBBUmIngokePgjOAkHNqBcsW0+PeFjYokUuoI3pJ86Qr
	zEukbMk0GRfjO1yyKgPZW0ddiKGqkDSUBBgJu4TvrTWOLFsGfTGGJyXhO07dAFd/Mf0LXlNUqLJ
	NV6WwjLtPl3ljpUo7yLSyr0MVEQH3G58E3P93m2/qkGI5JuCng+YtOW5cYIkONdQ4kXm0=
X-Google-Smtp-Source: AGHT+IGRYxENLwLvq9b7oKrvhOSz1wzeXWo1ih0uS1qsmrAg4+Tmjt8/3GDxsy3voAv8ttVBOjE0Q5CFjnrHRHQkAg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90a:2c4a:b0:2e2:d3dc:d3ca with
 SMTP id 98e67ed59e1d1-2e8f0d4bd47mr41845a91.0.1730506108201; Fri, 01 Nov 2024
 17:08:28 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:08:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102000818.2512612-1-dionnaglaze@google.com>
Subject: [PATCH v3 0/4] Support SEV firmware hotloading
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
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

The third patch adds SEV_CMD_DOWNLOAD_FIRMWARE_EX support with the
required safety conditions and adds a new argument to the platform
initialization arguments to delay legacy platform initialization.
The command allows for firmware to be committed at the time of download,
but due to the safety requirements, its better to leave that to a follow-up
SNP_COMMIT command.

The fourth patch uses the new platform initialization argument when the
vm_type is not legacy SEV/SEV-ES.

The bulk of this series is in the changes to ccp in the third patch.

The KVM_EXIT for requesting certificates on extended guest request is
not part of this patch series. Any such support must be designed with
races between SNP_COMMIT and servicing extended guest requests such that
the REPORTED_TCB in an attestation_report always correctly corresponds
to the certificates returned by the extended guest request handler.

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

Dionna Glaze (4):
  kvm: svm: Fix gctx page leak on invalid inputs
  firmware_loader: Move module refcounts to allow unloading
  crypto: ccp: Add SNP firmware hotload support
  KVM: SVM: Delay legacy platform initialization on SNP

 arch/x86/kvm/svm/sev.c                      |  10 +-
 drivers/base/firmware_loader/sysfs_upload.c |  16 +-
 drivers/crypto/ccp/Kconfig                  |   2 +
 drivers/crypto/ccp/sev-dev.c                | 399 +++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h                |  14 +
 include/linux/psp-sev.h                     |  29 ++
 include/uapi/linux/psp-sev.h                |   5 +
 7 files changed, 454 insertions(+), 21 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


