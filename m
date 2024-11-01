Return-Path: <linux-kernel+bounces-392696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9309B9731
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F77F1C21487
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E891CDFAC;
	Fri,  1 Nov 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ws9tGhhb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82780196D80
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484948; cv=none; b=ctqG9c+kX4ePPhcA1wUClYTLAJB3/AdOxJFSU09KVuIav2b+3kAa203pJZzksNKDNisUwu2+6YI7/2F5G4Zs8G2LILrH0c+tzQlNQjWGvwFJMul0iy1HoI5nO+XI8Jk4wnFvEbHaacKHvcs8VYod4mQnBQtw+gUyKyPp1ZaNk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484948; c=relaxed/simple;
	bh=LbnNaXexqHA5AANIwW3YK2ILGiNi92ZaUif3GJ/Lfjw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CTZLCt2AmdLrV31zOJyaCXLXEbIRYG5yUDM0hVmSqqARmNTKLLspSSLZs/zIwA2kWhRMpghNusolv6akEw9aQfa6+deCVidgBhtQOHj/YAB3kXDtUwzMGdZ1xXs2bsSrDOSeJTRRQawe7Ix9SfikKuuUnD7kRU/NNZvai0hygXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ws9tGhhb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e6241c002so2251463b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730484946; x=1731089746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wnmJTE43qRlHScj91EQqfntkDiPe46PgRBzvToUljQ=;
        b=Ws9tGhhbGlOn/qfnApU7R5TsfMKdP4ElLkH70y7K2dVYYL04EtA6PsSxFYRUYx68en
         idNlXxVtUATLITtPL1renWBBB+h//JfQW9AigE+sHErl3AJu+nTvtkk9RpzWefsp02F3
         L4vbBcw+QRus+5XmH+K/mwi3b4+fJa3b7fmcBaxlLjE+uUuliUR5frbv+2C0CLuIMIa3
         m1GHblNCj8geMOeP8AI7ozk3tGUOBnTLcnUbg1GrbecJOXeYAT3J1OkEE9HU7TaORXYA
         dhLHVK5sjxolBK9nUoskqHZ9MK/y/hNbRraGQtHQ+4cfHCCZgite7lnWnxwa+NVFSQQy
         bOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484946; x=1731089746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wnmJTE43qRlHScj91EQqfntkDiPe46PgRBzvToUljQ=;
        b=mKVQ5zx4PX1CB/I7rmH2+AjS4bqQO1ct69UEifk0AAEdB1bun90YtTT4jZ7inzQZUz
         Y2EEOWYblTgTOSNdaqtS99g5BwmSnDsyIpwkmlXXSPuuBk6/FaEKLzOZ3lJTom6elDm/
         kGwT9f0Rdbv/A2FaruA9DRuf8xG5bDOUDQUxnhTbOJ/xBWuMLPV7DcIIbEMHjdSYaL+u
         Vt2wQyqSM/VXGY65BOXUmU7oVT9BOfTdHEMtrInljjZlFwawptujtKnnjmrRuLFuKtlX
         xP+BjHpT7bMR8Pmql1BPlQILrhUKbaUnAmtdmS4kdMRGo919pZl6PjLeCnoWvUyfRuif
         s/dg==
X-Gm-Message-State: AOJu0YwwzocieYqJPdCp3GqmTZ5fhxY4DWhNIUjHRuHSkmhkgclA1BAY
	qALdxCffwZn3eVgl1DygHffGT+nalAFVF1xLwz5CT5yvjGZlvC05nCNbwz9FlPfR/RIRfGYiAKI
	gCQ7Ud9GmYMtc3yA7dN/iesIT5FAfybp8PjcwawMvUJIw51f0EOwxGqdoHvK6n8OqCxVQ8eqvjN
	5wUVBPIiAsVKvN+mSMkGtXVzQEKwe3A84euz4R5e7TVGcmgsCLlBq1ErDdjJu2ftEwYKQ=
X-Google-Smtp-Source: AGHT+IFPMRCZvFJ8T+KWS+vMPgO1DVXNh6MjTp+igLBgG5pIghaXd0oskFiGdwajqj5eRkfxovGr45zlPWHyz/wiNw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:300f:b0:71e:5e28:306a with
 SMTP id d2e1a72fcca58-720c945aa1fmr128583b3a.0.1730484944520; Fri, 01 Nov
 2024 11:15:44 -0700 (PDT)
Date: Fri,  1 Nov 2024 18:15:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101181533.1976040-1-dionnaglaze@google.com>
Subject: [PATCH v2 0/4] Support SEV firmware hotloading
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
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>
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

Dionna Glaze (4):
  kvm: svm: Fix gctx page leak on invalid inputs
  firmware_loader: Move module refcounts to allow unloading
  crypto: ccp: Add SNP firmware hotload support
  KVM: SVM: Delay legacy platform initialization on SNP

 arch/x86/kvm/svm/sev.c                      |  10 +-
 drivers/base/firmware_loader/sysfs_upload.c |  16 +-
 drivers/crypto/ccp/Kconfig                  |   2 +
 drivers/crypto/ccp/sev-dev.c                | 398 +++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h                |  14 +
 include/linux/psp-sev.h                     |  28 ++
 include/uapi/linux/psp-sev.h                |   5 +
 7 files changed, 452 insertions(+), 21 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


