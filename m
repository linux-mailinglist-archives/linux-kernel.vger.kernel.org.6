Return-Path: <linux-kernel+bounces-519866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81099A3A2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8193A3334
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5D243387;
	Tue, 18 Feb 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDxCxqZi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E214A4E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896491; cv=none; b=bSztSoPB+PvUEmfo68ZQFRdcG5ARu5E+s8Gxm2KnaII6Z5r1hTNtP3JYwxNWr6JtI+++9I3vLrWENaKugcda0zEMwomWYrl45K20pZCB11GT7Q2VRmeDymaEDKD50Wf9TCK4vk3PuicAdRrAe5VyDPU9gIZ2B2nYESs8Hv9Nouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896491; c=relaxed/simple;
	bh=T/ly0o90dhVgf9HUX5LFvqfOCtsTYYBB0fxJeY45Kyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6HSS+xX30b8OnkWLRPX6ioH60aTf9ITQxj9Rcwh2jHDccNpxvbB3BRcPqRHKeqXCIAWTTIXpXV7WYv3u02VZNMWkqi9Hi2EMntp1qwXCxMPAACxLgOuv+HPaNfB09pb38f1XQcVENQQ/K0vBcTI8GmH9QaDknavrPrvuXUPJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDxCxqZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6IEI5vquogVwrhJmkiNA7kkUfSBC2YjenMZuFUbeAk=;
	b=KDxCxqZicddzKcyzB7a1Tr4+l2Gbhhh4BrPHDakPV+ojsUZW/mz87l7mIA+6eK0pd86lKd
	gYVQK7OCXD1oR3GqXzUCUMwnzsZcv+Zk7g3wB5uYY0xYJbFrzwMNtTE0kVLusAsChcl/aA
	N8v5m56PJfhwRY8nXgaFBaF4ios/VUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-YnduTcQCMR2D5z0svjY9Cw-1; Tue, 18 Feb 2025 11:34:46 -0500
X-MC-Unique: YnduTcQCMR2D5z0svjY9Cw-1
X-Mimecast-MFC-AGG-ID: YnduTcQCMR2D5z0svjY9Cw_1739896485
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43942e82719so49554835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896485; x=1740501285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6IEI5vquogVwrhJmkiNA7kkUfSBC2YjenMZuFUbeAk=;
        b=e52EP0uaLRhPsiv7Pt902wsrDgOjigr48a5zCIeDVa6VcGHVlcqzxx0VDFN1uBtJB1
         p6t+LlOjJx19b4InW7UQxbw5ntxdepvKCTOO4xqN7XxTuL0BMaF9dVvpie2ICOT8vZtz
         6XBRqM9EqxKQNS8LQU2EnXKKOyMDM5wAQW9vYk8NX2zWIUaQT0IpEARe6eSXfeqPh0kz
         Oyd3W2KzWeA7OEiFFKIM/VP9heXhB4mGGoNyr3rlkKR+vK9hKtKRqJ1kh1wRhfVG0N1u
         T5GAaPXqQVj1DwOSy9mhtEBocPCXx2Z3U4Y3eAJ+LQhWX1NKdanvFJe5b50AHRfWpMe8
         SbIA==
X-Forwarded-Encrypted: i=1; AJvYcCXERuH8TjaeLFu6ob7Yuyf8+ucuhOxX/nhR7iVscTR9rddQnIBIyBkz0ub0U8YemfZjrWykyqMy20Ov0Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaR5bkMj+MzL74tl5XQK/jdhGRyZcGqvBq7a/+blu5sfTfcA7C
	hyOek7+Df8zJ6hUO5UkPdTD/8zEOjFQ1orgMqYt7SkviIAZQ0kRCH96AfbP2IQLFGMwm6ybe5Hx
	3ia2PxUlrTxsMAntrj93dJkdFRqdLz5/bVyM0SN0dy6ysIUGkV4bc/YeYEHcD1g==
X-Gm-Gg: ASbGncuVRVCUcB9MM0d+05hPy0pBJwgpLq/9DAlrKXVp53Zp3880roHm39VnDj/6yuN
	FWSA1BwjCN8xe/bwx6AEyAUXUPZ/sFMpkshqAMBTcvfztQYcQYHbC3YuDV9Rii8oL1FUQ/H9YP6
	ivyfeL7wqWgknUGD0XA6IBRFek8ymOGSs+QME16rFfZARyA7tieS/x12vs7Q3uZds4ftHVqE9LU
	z9eJzOHNzIth219iF7gFpEjWxdz41ALfymiXGLPN2zu8Wy1BNR91qeW5cbCh7xXkDhWNhSUqF9e
	T+hDIEEG1SZqw8oiRsUzW5sc8K5PEeKZbAH9QdXZDOGUfF1Ug1u0JWbzijNMwJzkJg25
X-Received: by 2002:a05:600c:3b9c:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43999d8f506mr3283375e9.8.1739896485382;
        Tue, 18 Feb 2025 08:34:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2rMqgMj306LdPnffqreiahb80iBIENo1q+8mjRXF/AC5FQTrmlj/WNJxrORGdnqPcYDinew==
X-Received: by 2002:a05:600c:3b9c:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43999d8f506mr3283035e9.8.1739896484985;
        Tue, 18 Feb 2025 08:34:44 -0800 (PST)
Received: from rh.redhat.com (p200300f6af0e4d00dda53016e366575f.dip0.t-ipconnect.de. [2003:f6:af0e:4d00:dda5:3016:e366:575f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm85091845e9.0.2025.02.18.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:34:44 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] KVM: arm64: writable MIDR/REVIDR
Date: Tue, 18 Feb 2025 17:34:39 +0100
Message-ID: <20250218163443.32836-1-sebott@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on prior discussion [1] this series allows VMMs to change
MIDR/REVIDR to enable migration between machines that differ in
these registers. Since these are used for errata handling the
errata management series [2] is a prerequisite for this one.

changes for V3:
* handle VPIDR_EL2 as part of vcpu ctxt - thanks Oliver!

changes for V2:
* let the guest actually observe the changed MIDR_EL1 value
* extra .set_user function
* added selftest

[1] https://lore.kernel.org/kvmarm/20250124151732.6072-1-shameerali.kolothum.thodi@huawei.com/T/#mb855bc51714095a164a7b26bb8bead1606e4b753
[2] https://lore.kernel.org/kvmarm/20250205132222.55816-1-shameerali.kolothum.thodi@huawei.com/T/

Sebastian Ott (4):
  KVM: arm64: Allow userspace to change MIDR_EL1
  KVM: arm64: Allow userspace to change REVIDR_EL1
  KVM: arm64: Allow userspace to change AIDR_EL1
  KVM: selftests: arm64: Test writes to MIDR,REVIDR,AIDR

 arch/arm64/include/asm/kvm_host.h             |   9 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |   5 +-
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c           |  10 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c            |  28 ++--
 arch/arm64/kvm/sys_regs.c                     | 137 +++++++-----------
 .../testing/selftests/kvm/arm64/set_id_regs.c |  32 +++-
 6 files changed, 108 insertions(+), 113 deletions(-)

-- 
2.42.0


