Return-Path: <linux-kernel+bounces-259875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537F939E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61181F22BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84214EC40;
	Tue, 23 Jul 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6nuuylg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FA14E2F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729535; cv=none; b=FyBJw+IQzjOHHUsXxxOEzFGWK1OO9O2hMJk/+CWG6vyACTmO5c9HXHvucUXpXnEfC8Ix0nywUAsVpjf8AynWpKR0DypDqRCDtHwp4xu1j2DIwE6BTkbO8ya//P2meO/giNEh1yYqWf5goOm+ayNs5nrTgwjbg3+L7Fw0KVpx1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729535; c=relaxed/simple;
	bh=tIH8+pIIMMdAuQFVddSnwAJv1MQB2deGmxLg6GqUWmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvRmEUkLDIsmXX/zq8qnJYCt/twEjLdBeP2+LdCjdhAwEoWFwPVLn+9DMHW++zR9W9rsppbYF9qmxgRJoaFqMelPcOIsEaceSm3XHPDHbscpRtUlzdJflcWcBycc6jDCLnLvrgvh/b6SerCqF6J3RYAd1I5ITYJSISMUg3Kkh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6nuuylg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8cUp6hq8Rf9yICEw+ij+wA/0ySScqHZkH2/Mn4b/iJI=;
	b=d6nuuylguXgOw1g7vPn2meI3vPAWm+SbxzePObXMapYawc6pQRC8Qdfe3xLbYy9yP6SOtX
	K8Lks03AAHzV7qjWiLCsCi69XKkHPymmu5N7jjZkR3l9wU4dFxM2ew7IRXeNOUGXiVpL0b
	M4gZ9uEIYAJ4lUyIWCc/EZDF5eKeoAg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-fExBWAg_PoaH-k49CrosMA-1; Tue, 23 Jul 2024 06:12:10 -0400
X-MC-Unique: fExBWAg_PoaH-k49CrosMA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79f04b04fa7so792046985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729530; x=1722334330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cUp6hq8Rf9yICEw+ij+wA/0ySScqHZkH2/Mn4b/iJI=;
        b=uBQF6oxtIAZZZKE+0cmPegdHeFaR7mD+dB/SKsSFB9DdNV7Dp3TFugky4se7+yGZG0
         NHKl/uoR3+OovQdmAecaMGUg2LbUGbVKbxYVTPjs9Rv2R7Z7Ok/O3BZrv2DvCKU1vM6u
         LI7f/CVotkYF2R+gjS+HHemlsWZaFXlH0acGAf21pJGJ7Rowyn7cawNLnpWtm65NmuCq
         fLND+3MtzbCD9+NnT3nFiQ0hazkP1h1SydDwvL1aNoS3C9K/E7CdSRwfpvcGG24r2aGw
         J2gi1YcMAupYG9V1Rs2wN1340HWezBeixGXornRPtnQlKpzxPRjbeMUbzT9KtIGlEl3n
         DgEw==
X-Forwarded-Encrypted: i=1; AJvYcCWYiBxrbnmvs/GbRKjPuBxPVvFs/jLvpxWu2Lwug201ubsz7WGcyQfiWnP0B8Lk+Cz1ivjumCgwLFUdVX5nTe6Q69Q7yG3I0gwY+4/T
X-Gm-Message-State: AOJu0YyJkYCvlLGbfBU1OcHYURtdRw+5j5bfYdGbw43Jk/HWhDQs24pH
	t7PUwxNwZXRXVlKa1TTpLPLlOttU+fE33zoDkfyc0RtSdYR3p+nx3+tMRGsWTz63jvY1CubUWZ8
	h6LlGr6LPI1E+GrXUyB98hG6oZ9tTtxj/GyDzhA0KQUAuCvNcHbV9fZ5d6JLalQ==
X-Received: by 2002:a05:620a:29d5:b0:79e:ff47:3307 with SMTP id af79cd13be357-7a1a130a702mr1465270585a.8.1721729530135;
        Tue, 23 Jul 2024 03:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyt0QS1IKTLLjiIiYvN5IywSbQLXxQfkNLU8SejKutptyLr0Xnp/x8tl4jKx3X5B48LdDkqQ==
X-Received: by 2002:a05:620a:29d5:b0:79e:ff47:3307 with SMTP id af79cd13be357-7a1a130a702mr1465268685a.8.1721729529791;
        Tue, 23 Jul 2024 03:12:09 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990063f2sm463780085a.64.2024.07.23.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:12:09 -0700 (PDT)
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
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/3] KVM: arm64: fix warnings in W=1 build
Date: Tue, 23 Jul 2024 12:12:01 +0200
Message-ID: <20240723101204.7356-1-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building arch/arm64/kvm/ with W=1 spills out a lot of warnings. When
changing stuff I try to use as much tooling as possible to make sure
that I don't screw up - having a clean baseline imho helps with that.

With the first 2 patches applied make W=1 arch/arm64/kvm/ runs without
warnings for me (fedora userspace, upstream linux after kvm merge).
Patch 3 gets rid of sparse lock warnings in arch/arm64/kvm/vgic/.

Patch 1 now just adds -Wno-override-init to the cflags of the affected
files. Alternatives would be to add this to the whole subdir or
reintroduce the flag for higher warn levels..

Sebastian Ott (3):
  KVM: arm64: fix override-init warnings in W=1 builds
  KVM: arm64: fix kdoc warnings in W=1 builds
  KVM: arm64: vgic: fix unexpected unlock sparse warnings

 arch/arm64/kvm/Makefile          |  3 +++
 arch/arm64/kvm/arm.c             |  1 +
 arch/arm64/kvm/hyp/nvhe/Makefile |  2 ++
 arch/arm64/kvm/hyp/vhe/Makefile  |  2 ++
 arch/arm64/kvm/vgic/vgic-irqfd.c |  7 ++++---
 arch/arm64/kvm/vgic/vgic-its.c   | 18 +++++++++++-------
 arch/arm64/kvm/vgic/vgic-v3.c    |  2 +-
 arch/arm64/kvm/vgic/vgic.c       |  2 +-
 arch/arm64/kvm/vgic/vgic.h       |  2 +-
 9 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.42.0


