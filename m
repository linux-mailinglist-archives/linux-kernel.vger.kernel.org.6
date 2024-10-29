Return-Path: <linux-kernel+bounces-387490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B649B51EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC7A2847AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389A200CA5;
	Tue, 29 Oct 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDlY3Y3I"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09A2040BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227161; cv=none; b=CyrnLga2/KLmuNvv0CnuwXROtslzOLeqkNFtLvPG3UQc9gjEh8MiBBgCz4fu6sh3BjqOuPFZPWNoHUS6xqWw29IyYexCE8/lE6TsAdhBLpcX5bwjGNHQBuC+DAohmfhTFhR3N2vLuGJYb94bcFqGmlwWKfAybxi47stfdCCTylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227161; c=relaxed/simple;
	bh=B1eRshHM1rwTy5MtX9UYj0MQr+Nj9Lxid+K5EOAcq3Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UA7zj9tNs00VllqMiDr3DgZ1ahpm8iOBMtG8tV1f4DtsKweq2a3mSwxbF1MxZWWiuw48GXzVvyaG1iXt8TlbaAE1O/9HIynPUyTXTBohZIRHffsi9Fn+Vj9hdyJ/LZxV9Mf0fD1y9SN+CoPR4v36rKahmxTFutl0sYWgxXsOTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDlY3Y3I; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so9581088276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730227158; x=1730831958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYpdVgCcc5LVh/vYMCOxrh59bs8RywD+zKhurK0MMTc=;
        b=EDlY3Y3IXL+3a8MDXBiZ73F154ZJTnYf0ewL6zN5y0PM+IgQCUDHlg3ai7I8sMEblk
         Etq4FvY05qrmJi8NOzJyap0cpPpukgIvZ26gdtdLQUxNMDw1s5nS4TLOd7iZoURhdVxS
         9nMTohS0a+UIcC9bxYqQAzu+Gbeii9v3CXGXawZW1XD2vPXLHuczBXk5OL9laFrnjkfN
         25w4522+AYO/7YS48VJZgkKBUr703jHDL8TNbxsuDoPBsB73kkI3JyW7Fe2UO/bgKdLC
         M+IoILcXYCDNULSlQFeqjFWX0rrh5dShjG+nG81QHmywPdLCWTIzVVcT6JpcEQVKoheb
         VvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227158; x=1730831958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYpdVgCcc5LVh/vYMCOxrh59bs8RywD+zKhurK0MMTc=;
        b=qPZ0pr4MFg+1Q9ThvMz0SmqNHYGBb/7hITTonM8cLSx3BoHU6Gdv9NI1OMv/+VplZd
         ZwNeXtcsnXveAf8m41tVDSGqk5tRRp+B5DCgKQzqCYmA1uRwLgtHXqJhXet2k1dYcsIr
         cMnjlnUAaEAQ7YcC9V4nr7CIhMK9dNSE31mhFbbyNG4KSzwJoKZuJlqr/DxqqzwJ05o6
         cgeCLTa89CFzvGsfcS/HhjAG9fj/O2et3C8PHp+ewxUwI7aVNWhtUCHdZNN+hngCtzi1
         ykKcwLU8aj1j0iy1kplyiEdfri/7HD7SoqgHnBrkjWBI/1bB2dvxT3MlAAmnOE3rNdVe
         0aQg==
X-Gm-Message-State: AOJu0YyH/bi6ynjg541OcN6WbWYaLX3Swta+cljmz2nAEt5L6N3RlrQN
	WdwgE7eCHujpX1KVh0iU6INWcccd4lK+kPVX+/+2oRctcQ/gV64yk52gRUoex/ZDvdjqIi4JgXm
	kPNte7hQZ01YnGORh/uPaVZohutkwDTgIzCBKWknIJD2cw/53Kmb2SkrOjjpQejbZ+IWbn72eVt
	sFrYBaJ34hLIr+E3AwCw0yALac709UVdpgZ8SDmx+xp+iy6qo7VrQIxEz1nWTcu23S7nU=
X-Google-Smtp-Source: AGHT+IHsh5UtRJde/JwWoZ8P3vzpEExNbLLhx3eP3GGjR5TqkhTmG8x2b8UsSemypmV/XpInRp1Mjk9pNJTC6Z0wMw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6902:4c8:b0:e29:142:86b6 with SMTP
 id 3f1490d57ef6-e30cf4f05d4mr352276.10.1730227157344; Tue, 29 Oct 2024
 11:39:17 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:39:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029183907.3536683-1-dionnaglaze@google.com>
Subject: [PATCH 0/4] Support SEV firmware hotloading
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
 drivers/base/firmware_loader/sysfs_upload.c |  28 +-
 drivers/crypto/ccp/Kconfig                  |   2 +
 drivers/crypto/ccp/sev-dev.c                | 398 +++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h                |  14 +
 include/linux/psp-sev.h                     |  28 ++
 include/uapi/linux/psp-sev.h                |   5 +
 7 files changed, 464 insertions(+), 21 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


