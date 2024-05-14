Return-Path: <linux-kernel+bounces-178376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B628C4CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4921C20F45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45717573;
	Tue, 14 May 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRhaniAq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC111711
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671397; cv=none; b=qg2Rk15n26dPGYB21PctGBVMaKkobn7vZvsEjL5qZzp6SayvG3ba6Wrg4takfHjaTLRf7WmCSpM7+05QiZIY9pINc/dXw3siTt/eLRX8Ho2QbVCQUboRSNgU/5ufSPwLTvZ7kVHqj1oB+Wql/mH/Qnd0w+wXimSf/arOFkFmJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671397; c=relaxed/simple;
	bh=9MRXPzUlRAYo5pzAwRVOa5w1gi7ImIRMKYnxTgHh0GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tH5CMxOCUb8pscdBmdVvweveEOQU2jnCAeJGBffoUiGmYYm9QpyyGVthpkTOEC+BrXNrobZEWqi9LBYJ0JwnHm+LURimbbzTRN/ngzSx4xzhb7B3GISUTVzG5/33UrZH1bGedAcREHKxGloYZabU5ea4ubbORZhdLDTy8G5pk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRhaniAq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3QF2HJKGNlPys8wAxT2FA9PPh0N4R/xH1MiJB7dYGCs=;
	b=jRhaniAqYUr8uaxUMamyibX43f84/RZCOpPZk2Lgos5V9hwK4SA6KFaUjiuklrmkg/+CFA
	55m1OkMRo6H2nFkfHCcK6fIgIhLnoK/GfdyiFxSTYkp5qoBy/lS3cHN/FzLQtKLfSNchrM
	DNkFc7A60XDwlx6w8ysgbEZYxofDX3s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-Izvgee6_MGWnkexurWtlOA-1; Tue, 14 May 2024 03:22:58 -0400
X-MC-Unique: Izvgee6_MGWnkexurWtlOA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a113df8f57so67315216d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671378; x=1716276178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QF2HJKGNlPys8wAxT2FA9PPh0N4R/xH1MiJB7dYGCs=;
        b=VVceTUyOBEAbVko/YgAtqlFrUYCZ1PYhpYyslTS4PKf15KC1cWDvMZcf613XUMr37n
         DqMccAgu/GbUGjdK2MK1qgxRxn4FgFHnP4Wtx5Y3eVj5/2edQUImY8fOSlmyt3fb5ymA
         eoQmynuJdCoW4RaQGk0AZlNglt/fVs9cTWYw3JZ6BXFChoQPzBsiSWsiRMvADAHABXkx
         XT0yKyMtuWXCIT0NhBn6HhRg4Bshyr1xAsNx2B7gGxebxEfNB7yK6APeVQNLlLCiMbwN
         tnz7zj3z7gYAw7IO9hiEFdgnQmMTf2cWg4EB9aPPNZY5wsGOfmTuYzswf+Qr9YUhoNTx
         Dcow==
X-Forwarded-Encrypted: i=1; AJvYcCWZjP8ltxSeHpwLLtf7SgqPQ3961RVPyLsoInRiKk3xtinDUaUxgRx7AG+sfOFuAK8aYJ3JADFfHPPTJ1o47LwwGswsTZN3uIEMO9Ro
X-Gm-Message-State: AOJu0YxktUL5ba0UBKlKbR3Q5XHDLZ4+vRVT7cZnOb8m7iLgwk/4yVf2
	/3zNx2N5HFi4+JoLKP7zEhqwzSeQgxZrEklYtOzAIea6wkevjuVGbf/nroTK324eknL2v6SUW/o
	GQSZh0dZXdAlqbqZNFhXUiXTv/1m7ebU6sfI4143wgKC6SEbNcpYUlBQcE8LEvg==
X-Received: by 2002:a05:6214:5909:b0:6a0:5a42:9626 with SMTP id 6a1803df08f44-6a1681a15e5mr141243556d6.31.1715671377734;
        Tue, 14 May 2024 00:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaEUQGOEUQFnDZDXr+zdvWksst8k/8OEPh2kWOkvqabpndfzr6LB5yQPavrrmvQuSu19lXtg==
X-Received: by 2002:a05:6214:5909:b0:6a0:5a42:9626 with SMTP id 6a1803df08f44-6a1681a15e5mr141243316d6.31.1715671377176;
        Tue, 14 May 2024 00:22:57 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:22:56 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/6] KVM: arm64: emulation for CTR_EL0
Date: Tue, 14 May 2024 09:22:46 +0200
Message-ID: <20240514072252.5657-1-sebott@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hej folks,

I'm looking into supporting migration between 2 Ampere Altra (Max)
machines (using Neoverse-N1). They are almost identical regarding
their feature id register state except for CTR_EL0.DIC which is set
on one machine but not the other.

CTR_EL0 is currently marked as invariant and migrating a VM between
those 2 machines using qemu fails.

Changes RFC [0] -> V1 [1]:
 * store the emulated value per VM and not per VCPU
 * allow to change more values than just the DIC bit
 * only trap guest access to that reg when needed
 * make sure to not present the guest with an inconsistent register set
Changes V1 -> V2 [2]:
 * implemented Marc's suggestion for keeping registers consistent while
   not breaking userspace ABI / expectations (I hope correctly this time)
 * keep the shadowed value valid at all time
 * unify the code to setup traps
Changes V2 -> V3:
 * rebased to kvm-arm-next (to include Olivers idreg fixes)
 * fixed VM ops trapping for non-FWB CPUs
 * fixed writable mask for CLIDR_EL1
 * re-added manual ctr validation (using arm64_check_features() had a
   side effect with the way .reset is working for these registers)
 * added a testcase

Thanks,
Sebastian

[0]: https://lore.kernel.org/all/20240318111636.10613-1-sebott@redhat.com/T/
[1]: https://lore.kernel.org/lkml/20240405120108.11844-1-sebott@redhat.com/T/
[2]: https://lore.kernel.org/lkml/20240426104950.7382-1-sebott@redhat.com/T/

Sebastian Ott (6):
  KVM: arm64: unify code to prepare traps
  KVM: arm64: maintain per VM value for CTR_EL0
  KVM: arm64: add emulation for CTR_EL0 register
  KVM: arm64: show writable masks for feature registers
  KVM: arm64: rename functions for invariant sys regs
  KVM: selftests: arm64: Test writes to CTR_EL0

 arch/arm64/include/asm/kvm_emulate.h          |  40 +---
 arch/arm64/include/asm/kvm_host.h             |   4 +-
 arch/arm64/kvm/arm.c                          |   2 +-
 arch/arm64/kvm/sys_regs.c                     | 210 ++++++++++++++----
 .../selftests/kvm/aarch64/set_id_regs.c       |  16 ++
 5 files changed, 197 insertions(+), 75 deletions(-)

-- 
2.42.0


