Return-Path: <linux-kernel+bounces-199174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108528D836E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343311C240F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B35A788;
	Mon,  3 Jun 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObCrqA9A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FE12BE81
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419918; cv=none; b=fTmvFtH/6/Yshn8Z3rc4lgp318A3umj6bx7r8An4TOxJuYCY8jnSjZPaGACf8LrQehUyl6lst/lZ67OKLP88+Qn22dU/jkfOuu8/7QMKcQULU6UF3syaG434ZqtKXA3Oo3524FzbuOe8BwldFYgej+zR+wH9dS5gZrw8WHxza7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419918; c=relaxed/simple;
	bh=ZmgshMwK/h8YuHfgrohZ07iPt7cMhx0SOYi8UE3BetI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9ysbtTrErrrBxxW7PsFAZwNtHzQ//CuwOCg32ms3QMVpXL6p9sSGAK6Wtn9gY8HaI62FH9PXKGhUawdwSh27+a99TJH2yfcFO+Gs7cJcTFMfKS2jNT6jGrTNXc54Sc7c+HvBsAtUR9nIeX4gouc/aahO8RpBNV0dw5/QI/2ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObCrqA9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuAz2osHy9RXhO+JIQRbzgjz7RRp47pq6Qz525G205E=;
	b=ObCrqA9AsWejVDBHVyDcHFGH1FRHe/yAKlLAnYWNWiPB1tHSUvbLE/avNlsD5FgBZBI32n
	acHQWAegOzM91hrG5yRygY2nPLHAVRXbWb5uPaDCrLyhQQNl4VivXbi8tmf+AREf/KFVC0
	TBfrreFhbnHTYs5liH9IWwluHZHw/hs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-VgeSge6BP3m5xX7zqEu1rg-1; Mon, 03 Jun 2024 09:05:14 -0400
X-MC-Unique: VgeSge6BP3m5xX7zqEu1rg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-794f5424490so538411285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419914; x=1718024714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuAz2osHy9RXhO+JIQRbzgjz7RRp47pq6Qz525G205E=;
        b=qALsex1qOPoQktJJnxN55aNAu7pyGYxghAyGtRNdvZO2ACauMPoASg4sB6BUcbSd8l
         45jfX6Uzgrm2OhwWu7NiMkkgg7LvGy2ecro+ziihVYX7b+Dc6YkbQbvF6Fw9Pwj3oMwh
         0usngt7rRKk897c+vuZaPyy9LnqpHmSUp7dMDwKMi8GY7B7M6KqKvdUABaqXdTcrVjCV
         ub7Ed4a/UKvrqycqKHVejxW7f6V4NwPyqGzrUpPVk2aXhusYhmGpkk/S2BsRLJsadNqp
         lPJzrBeQ2YJKfKjUvwxpgXHs95XLPtHPNL55Kwz7ac7zE+3ULzt59rC/Ev9eNWbR33Dx
         e8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJeMdGI/c3lEDmU+olEw4LkVXqceZOoTeLUDCpyktciDI3dTirJciZLv9xyUQT47/bGXK0wYe8WTCx0wJ/KZ/Z1ZGUyK5J2GfHRrw
X-Gm-Message-State: AOJu0YwFQI2nkn0V4DXtqyeUnjeP8HxaDWtRK3Z7Wt4PCqM0hD5u/X/W
	6omX2mTwKnq+THr/HdEDISAalphPHupmqM1xpUVM5fKicM5bj35G1MmOOZUs0Ax/yjfnK3kqO4i
	lsfOM5nEzLTW5IkO4D5L5R83i55MIG5DOGsItppdaiu5/c2FYz3ahI49xzM3Ylw==
X-Received: by 2002:a05:6214:4402:b0:6af:bada:7dc7 with SMTP id 6a1803df08f44-6afbada7ffamr49263936d6.19.1717419913772;
        Mon, 03 Jun 2024 06:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHENOGD7DUB04Noh/MHJb33d1NQPYihlzPMxsvVJEBOdeA1SEk/MwQVr1UO7l8+hz6gTZ3KHw==
X-Received: by 2002:a05:6214:4402:b0:6af:bada:7dc7 with SMTP id 6a1803df08f44-6afbada7ffamr49263006d6.19.1717419912865;
        Mon, 03 Jun 2024 06:05:12 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:12 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 0/6] KVM: arm64: emulation for CTR_EL0
Date: Mon,  3 Jun 2024 15:05:01 +0200
Message-ID: <20240603130507.17597-1-sebott@redhat.com>
X-Mailer: git-send-email 2.45.1
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
Changes V2 -> V3 [3]:
 * rebased to kvm-arm-next (to include Olivers idreg fixes)
 * fixed VM ops trapping for non-FWB CPUs
 * fixed writable mask for CLIDR_EL1
 * re-added manual ctr validation (using arm64_check_features() had a
   side effect with the way .reset is working for these registers)
 * added a testcase
Changes V3 -> V4:
 * incorporated feedback from Shaoqin and Eric

Thanks,
Sebastian

[0]: https://lore.kernel.org/all/20240318111636.10613-1-sebott@redhat.com/T/
[1]: https://lore.kernel.org/lkml/20240405120108.11844-1-sebott@redhat.com/T/
[2]: https://lore.kernel.org/lkml/20240426104950.7382-1-sebott@redhat.com/T/
[3]: https://lore.kernel.org/lkml/20240514072252.5657-1-sebott@redhat.com/T/

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
 arch/arm64/kvm/sys_regs.c                     | 214 ++++++++++++++----
 .../selftests/kvm/aarch64/set_id_regs.c       |  16 ++
 5 files changed, 201 insertions(+), 75 deletions(-)

-- 
2.42.0


