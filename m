Return-Path: <linux-kernel+bounces-535214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A2A47037
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C9A7A343F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098344C70;
	Thu, 27 Feb 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xt3v+jl5"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A64A07
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616395; cv=none; b=maIcm4DNaV2eRYCnPJFS+4MKoLf3Kwn7y5egr/JbXQr+syJfhUz3kAtpBGIUpbL/9K2dwyxtJvzF+4mTkciZ4osS1NfvFmpCRRZfPc0Nm/XBvrB4QJvz6w/r7JVtVpO2ryXSPfqxkLOPs3BiIB5nzrYENGnutdqQm6HlvTOYg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616395; c=relaxed/simple;
	bh=be/ZUGnpm8e7dztLvliWBuYLZBElJlzpV2+69nHUWIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c1RdcONbCSGfDnBikG5Ppm4qtxHh0tWk/CMJERz4nCazfWqHa30Y8O42zV+ZW54QI2opQ+lG3AzFHwKGjFzxCFkAU4eEXdn9hlwxZD/WpoSjkhQ6jNl1mOLftz83xJYJ76qbqCVxoOpJFB1R3y/kuPtHoWcFRjkoxHcAQB1JiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xt3v+jl5; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so327576a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616392; x=1741221192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wMaRPzN9DtDhFSXMETT7W68/dj5OM7TC62vNvIpIxu0=;
        b=xt3v+jl5JGgjn/US0FDXPYMcFvz+ZcThvbUW9zL3d6T6RpBFHxGWPXA5bGgkcjS2aP
         870TMrRaNuI5+s6Z489dix375UpSt/Hw/l6sTP4otSTLnIj4Nq22astRoYJ14ZJSoacE
         Nlg8mX+lZibdIxYTE2HoiES4EYcIUYaGJt+lrwNAYebGTArqPoJaIVSt2iki0K37bouX
         6b0x5R7tjDQgp1Tx5RIXFZaEz8ocLPBFmEWdA9IVmS9dQvKPrT23SBgrgbDmeP60Y8Ti
         78OrYMAfGWNRX4CpEndMuucBrGzcPrr/dJSurcH5Me45r5Umq30ZSi1HlG1E4vMPYI2Z
         P2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616392; x=1741221192;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMaRPzN9DtDhFSXMETT7W68/dj5OM7TC62vNvIpIxu0=;
        b=cfmp0p+yofsUWGBECVLXIRcQjdpeo67cd7pYNdeWjXBY+65kWzu9zgkCQ7dC1MVyIL
         NZcWC8KyYXJBpDqYI0z04tGoeg470QjpUXW+KFAqHWfh8qmRO5HMKm2i5CQ/g/aQJjUX
         YRmjUKL8QHOD6HAOWTMWpvZZEIEbvwd6T4q8alk45Oq8ceUx/9Jfhb5aF88Cf8F7R4Zb
         2S7FXW+19oinZ6XAyTGIytO5WTvkhOBgovX38uoQHeGYMT00BBg/gjmNTc4jnrOgaNcT
         tdWAtALSj9zql/Z9+XJAvOYdYAuj03TCeVvGQfwDbYD8X/jOFG3ib43Cs5qOsQghFIr8
         Jhww==
X-Forwarded-Encrypted: i=1; AJvYcCUVJdjTWyX2m6ug9rVadZ3y66AJxoOwSRk0ZvjJxgA3zabQAyavGQYHvm7f6OQljhFMl+obwMhkEOXMTWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbbgEJbzif8B3WlQeyCNLi52mKzHSxmhIxhMUDNwKC+P09eO8
	1joEVSh51RAzZ9z0JwCMfNGyuFCdqhd1NlA+bRn6K+nfWZfxWOdnBvdAIKizqdFGxHSvw5IOukk
	ZSuc2Ag==
X-Google-Smtp-Source: AGHT+IGS4fdHxE39pl3VbWkoYw/QY5aHCxMCm+ank2eEa2pcJSljLByRM9MEI79KT3OUTeH5ozYKhW5tXaC8
X-Received: from edbev24.prod.google.com ([2002:a05:6402:5418:b0:5e4:b657:188e])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:50ca:b0:5e0:9269:f54e
 with SMTP id 4fb4d7f45d1cf-5e4a0d72136mr7684875a12.14.1740616392345; Wed, 26
 Feb 2025 16:33:12 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-1-qperret@google.com>
Subject: [PATCH 0/6] Move pKVM ownership state to hyp_vmemmap
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series moves the hypervisor's ownership state to the hyp_vmemmap,
as discussed in [1]. The two main benefits are:

 1. much cheaper hyp state lookups, since we can avoid the hyp stage-1
    page-table walk;

 2. de-correlates the hyp state from the presence of a mapping in the
    linear map range of the hypervisor; which enables a bunch of
    clean-ups in the existing code and will simplify the introduction of
    other features in the future (hyp tracing, ...)

Patch 01 is a self-sufficient cleanup that I found thanks to patch 05.
Patches 02-04 implement the aforementioned migration of the hyp state
to the vmemmap. Patches 05 and 06 are cleanups enabled by that
migration.

Patches based on 6.14-rc4, tested on Qemu.

Thanks!
Quentin

[1] https://lore.kernel.org/kvmarm/Z79ZJVOHtNu6YsVt@google.com/

Fuad Tabba (1):
  KVM: arm64: Track SVE state in the hypervisor vcpu structure

Quentin Perret (5):
  KVM: arm64: Use 0b11 for encoding PKVM_NOPAGE
  KVM: arm64: Introduce {get,set}_host_state() helpers
  KVM: arm64: Move hyp state to hyp_vmemmap
  KVM: arm64: Defer EL2 stage-1 mapping on share
  KVM: arm64: Unconditionally cross check hyp state

 arch/arm64/include/asm/kvm_host.h        |  12 +--
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  35 ++++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c       |   4 -
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 106 ++++++++++++-----------
 arch/arm64/kvm/hyp/nvhe/pkvm.c           |  54 ++++++++++--
 arch/arm64/kvm/hyp/nvhe/setup.c          |  10 ++-
 6 files changed, 147 insertions(+), 74 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


