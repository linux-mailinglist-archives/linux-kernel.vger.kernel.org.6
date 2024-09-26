Return-Path: <linux-kernel+bounces-339841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5C986B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3492834CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D017625C;
	Thu, 26 Sep 2024 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS7ETdvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9351E86F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320993; cv=none; b=qbn2AXkD+e1EjC52SFIcFcvFD5y3j8JgLoDVLMwCyZivVNEoOG3wGKKc963v2M0NLE/6Y6XsTOfj2fyrmg38WNlWUUXtO6osfS4XvpM1x6tJ8uRb++FH42EiZqMDdmywrl8r+hzlSjdFdn3/U7bc2tjuKzyjy8UUvqkHVPLf9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320993; c=relaxed/simple;
	bh=aS+E/GhEnI/jNLkdS8HmnQFwD2dvp31zgXghAu3a8hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThKaOBhsx6HffZ1Qv5Y4o1shcDY9ULaIoJuJb/2qPzMOsWytx6JobmpyUuSlVFt+7FilyV8SlgbMExTnxce6q9r3sTys4jI52B7oB0hfMtqaXSN5bVdJO3KU9rSJMMPruFfGzOd5mJZPO+9szZExeUOKuGduB2Wwa+vH05lO/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS7ETdvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727320991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9f4byrjiwH6wxJoG0csJWGAC6yAuVUSWGNgTr0uQkg=;
	b=HS7ETdvXjqjnfe/Zm5EqhkA7giIXyf2JYd1yKRJXHFSBKr69Jm9q8Z3GymVuGhv6srIjD+
	LDFp9Hx4/EpCQpDQQ1pHZ7eaWjEj0jZEl/fbD/1KRI9D0/DGU4oFf/PEVGw5GCzOAdtQH1
	9uwGX3pvipnJpZMjVPDA2JcNg7PzOfQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-zbadzE0GN4uVCShacfgS2g-1; Wed,
 25 Sep 2024 23:23:08 -0400
X-MC-Unique: zbadzE0GN4uVCShacfgS2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8EBF1933EB5;
	Thu, 26 Sep 2024 03:23:05 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (unknown [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA91219560A3;
	Thu, 26 Sep 2024 03:23:00 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH v1 0/2] Allow the RAS feature bit in ID_AA64PFR0_EL1 writable from userspace
Date: Wed, 25 Sep 2024 23:22:38 -0400
Message-Id: <20240926032244.3666579-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently the RAS feature bit is not writable in ID_AA64PFR0EL1, this makes
migration fail when migration from the machine which RAS is 1 to another machine
which RAS is 2.

Allow RAS writable from userspace would make the migration possible between two
machines which RAS is different.

Shaoqin Huang (2):
  KVM: arm64: Use kvm_has_feat() to check if FEAT_RAS is advertised to
    the guest
  KVM: arm64: Allow the RAS feature bit in ID_AA64PFR0_EL1 writable from
    userspace

 arch/arm64/kvm/guest.c                            | 4 ++--
 arch/arm64/kvm/handle_exit.c                      | 2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h           | 2 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h        | 7 +++++--
 arch/arm64/kvm/sys_regs.c                         | 3 +--
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 1 +
 6 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.40.1


