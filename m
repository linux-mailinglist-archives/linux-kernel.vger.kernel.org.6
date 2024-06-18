Return-Path: <linux-kernel+bounces-218684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE390C3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB80281461
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635E16CDB1;
	Tue, 18 Jun 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMjZa6Wk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274CD4D9E9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692706; cv=none; b=eq4hjOJClkEH9spo7Mj0Nne73EuYgOr/sp0umDa6iz3kRXwcg7gCszhN7084pdgalkxPDKP2zWLkAAagLfYc8uGdCD6lttpBw4hgxnptzhc7HjNqYnTvf9/t3LNEGyNM18t7BT6sO5sC7ivCXV9JVdYoT7hYUMGGPWtkiKoI8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692706; c=relaxed/simple;
	bh=XH8nnA+L/XaE9OKZI4l4T6Wu7V9Tc6Kd2ydK5BwKzr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XizY7qzy4vBxTgWKMBcWejHU+DqyoKJjDxz9vkRisZWCkJWk2VzpB+YWb92bPrOToPRYULsmgk6RPggRVyzY3QCTKWOpECdHj/lP0t9YoUPP7wHrT+iKFV8c46Jejrme8mRINsGWj5lgobSSVbfzHjCluNg/AnLpNHvBJB3een0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMjZa6Wk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718692703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IfLvXm2V5JOTZZDkXFJiskwnoCllrw9pJu6yeA9YaNw=;
	b=QMjZa6WkaiQT5W1gOaC2saFRNkteG1hbBZym+RVy6gOYYO93HVq0gSD9lt+BAGL/SGc6EH
	q2CnM4gi0ZNwjYLV91eGizUkuuq7hcf8b8utNc35IJI4um5/FD4N2uo3/ClhIXH+dh55Bo
	bplj3M4xHJrb5JXSt5VJuoS7U7CkoAg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-Yf6jUZeuPLCpVYUnFZO6Tg-1; Tue,
 18 Jun 2024 02:38:18 -0400
X-MC-Unique: Yf6jUZeuPLCpVYUnFZO6Tg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F50019560B9;
	Tue, 18 Jun 2024 06:38:14 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C9F41956052;
	Tue, 18 Jun 2024 06:38:10 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 0/2] Allow userspace to change ID_AA64PFR1_EL1
Date: Tue, 18 Jun 2024 02:38:05 -0400
Message-Id: <20240618063808.1040085-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow userspace to change the guest-visible value of the register with
some severe limitation:

  - No changes to features not virtualized by KVM (MPAM_frac, RAS_frac)

Also add the selftest for it.

Changelog:
----------
v1 -> v2:
  * Tackling the full register instead of single field.
  * Changing the patch title and commit message.

RFCv1 -> v1:
  * Fix the compilation error.
  * Delete the machine specific information and make the description more
    generable.

RFCv1: https://lore.kernel.org/all/20240612023553.127813-1-shahuang@redhat.com/
v1: https://lore.kernel.org/all/20240617075131.1006173-1-shahuang@redhat.com/

Shaoqin Huang (2):
  KVM: arm64: Allow userspace to change ID_AA64PFR1_EL1
  KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1

 arch/arm64/kvm/sys_regs.c                         | 3 ++-
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.40.1


