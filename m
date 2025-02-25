Return-Path: <linux-kernel+bounces-530378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC51A432AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332E9167FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1883A14;
	Tue, 25 Feb 2025 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZu4Rdq4"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE778F45
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448413; cv=none; b=Xnag3iC/JnE8X8lpe1MhGf6E4C2sWsvgC24+QHataqdrS+oqm5RL2uMK7O4tgsm3w3NbP412gVYYWRrvGiiBDkUcRQBcDb4le5fxKaEnaBN9zcv3q17evdxZZS7I8VioLgSCz4jGyL9tPlEfYSvREfmmMaYlx6IWICQNY3v8fWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448413; c=relaxed/simple;
	bh=lDnDEm+dSfaeSLN9szJPpAcWhldP+uIqITh9ILIqPuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xtk1Nfe3JXWhvAZSTkc7iQc7dc/1JXuElLh/maxtcrub6iRoULH/GYZauU1fGagX65CudnwGqkioD/dUJXPaq45jz5d6Z/n0O+qfs7qqGIewP8JEJCFi/OBQFwTxMDdVjJWVO+vBDb5pQUL7rzaSRTaBsiUShYtAYY8pd9b795Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZu4Rdq4; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dece867fe2so5021973a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740448409; x=1741053209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AH9Y+qk/plKTRCQ8rdCbOXUmRPqvAGtJ+mP7kh2bkjA=;
        b=lZu4Rdq40eBXReVsy27/ntL36x/ZMqyICKSS6Gj/FvJvlfCciFuCnVf1llQ+ym++DV
         HYMaHctIYnqs7+aKnXJdKoFRih9w4YpBekYo4UPKDq13YLm19W4bXEQ/iK3LnQ1Dvct1
         0XDFJJ5Fa5CQdURGPkAdH+mK/OKMQQKgYAH5s5ZR6l1WLwXKKrpD/B3x/VJgsTY20g2F
         jUFZ0DpmylVtsqW5LorQ6+lDJwyjDl/0eLZvT6hNdxV694xRwd0MH67xuaFrEHoIfv3V
         XXEGbq/G5EPEPXL58H0/pUkGurPmA/dNZJN+x+B/BrTDBn7iKBt7xT4ce6mE3SoFZgrq
         320A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448409; x=1741053209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH9Y+qk/plKTRCQ8rdCbOXUmRPqvAGtJ+mP7kh2bkjA=;
        b=Ya+HWgLt5RgDtX2e/XZBx5k7uxivbqP0UfvsYuFcnMG5go2HDSENEXbzyonlkZ6eX1
         sMLHN97zvNuM6FddR5+DuSdXzSJ6JUde1QPoDwGEHx39n8l/5IpiBt/q5+LUuM+ClER0
         32WN/8ueb35QteQre3U4Z2FyuQjnMY0WkwohLdWmhLCLcN+hr3pkaL97b5cH6KT1uCoC
         cW0z+tnBx8ky/2ctN7OMKzKb3Xon7e0uFdPt+HRXeSO5BsV/2DU6SKFPErqEYqqbdA70
         rrQJIPSEbUC1vaiR1Yyp84CQl2nKyn4bljGcuuBHJNPhGsUMfNbw8qgp+Mllh/dDt91o
         gkvA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDXKqU9guZAX7TmCxn0d7mBfPzn8Pyga4A/oHb2Ejr91gB3fZtbDz2moRBRs0ym2a/fGbZDUjlsQSmtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyomONwqGYTZGyT3QT1KYgAeWPqo8E6iga5ALZZ5kQDKYDnlqAe
	qtB/2zU0uLv4iwz/VnHHgiDzQY07+Nw0rnrSRQN9sh7hHPUjuceenJviAj8TCaxhVjZtZnG+NsV
	DxiMrqA==
X-Google-Smtp-Source: AGHT+IHJKOHeegcslTQv6gGnIpceJABRkLrMUljBH8OEUmqvgitKR+e8++1jZBdKvqfUQIxfPe64opEc23yp
X-Received: from edbig12.prod.google.com ([2002:a05:6402:458c:b0:5de:bbcb:2c3])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2113:b0:5e0:8ab6:65fa
 with SMTP id 4fb4d7f45d1cf-5e4469daaa1mr1165847a12.19.1740448409709; Mon, 24
 Feb 2025 17:53:29 -0800 (PST)
Date: Tue, 25 Feb 2025 01:53:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225015327.3708420-1-qperret@google.com>
Subject: [PATCH v2 0/4] Selftest for pKVM ownership transitions
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is the v2 of the pKVM selftest originally posted here [1].

Changes since v1:
 - added support for testing NP guest transitions;
 - added .data section in pKVM to allow using non-zero globals (needed
   for previous point);
 - dropped superfluous WARN() from __pkvm_host_share_guest() which is a
   pain for testing;
 - updated assertions for hyp/host transitions according to the
   discussion on v1.

Patches based on v6.14-rc4, tested on Qemu.

[1] https://lore.kernel.org/kvmarm/20241129125800.992468-1-qperret@google.com/

David Brazdil (1):
  KVM: arm64: Add .hyp.data section

Quentin Perret (3):
  KVM: arm64: Don't WARN from __pkvm_host_share_guest()
  KVM: arm64: Selftest for pKVM transitions
  KVM: arm64: Extend pKVM selftest for np-guests

 arch/arm64/include/asm/kvm_pkvm.h             |   6 +
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/kernel/image-vars.h                |   2 +
 arch/arm64/kernel/vmlinux.lds.S               |  18 +-
 arch/arm64/kvm/Kconfig                        |  10 +
 arch/arm64/kvm/arm.c                          |   7 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   6 +
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   2 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 198 +++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  12 ++
 arch/arm64/kvm/pkvm.c                         |   2 +
 11 files changed, 260 insertions(+), 4 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


