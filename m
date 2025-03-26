Return-Path: <linux-kernel+bounces-576914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE47A715F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B473B70B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAD1DE3DE;
	Wed, 26 Mar 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGjXBoVE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384415C15F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989148; cv=none; b=S77Eb9Rdkye6OzB/U3sibr64SndQjh1vo+g/E5CkPu/eMv3n4+s+9GUJUbYyhNlPD22gR+5TKMwfkHZ1wajBYVy+1TCPRdSGTPFFJ7mTly+0ZUG5oScumUgXDJK7cdr+nKO4gCIpb5MSxpQPzr9bgaqdJ6UPbc+i6m6L+LYftRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989148; c=relaxed/simple;
	bh=IuSEcVY+XQgcWWiKyPKuUnqqYJm+G9BasCoqCLzldog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KWtWqZgfdDCvMTMEhqg3pBRX8OP8BS7qNgbeWoCkwK1TbCkj80mbaeFjMJskqzVLcX9hisZ8cMCU1h61vP1/W6QtOtNq0SN4qWoMrivd6NK/SE2yTxAV/nD9DstkdTu4/RD+3zKJan8xwzUWSQlOWX5Zb/y0tVWDL4SUZkFkZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGjXBoVE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so52311485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742989145; x=1743593945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fAUrsz9OdOg3wQLEmYa5D4cgvz4ST0mmGNxgNjOcyeU=;
        b=pGjXBoVEsvg3PfnZJq3/Lnne5Oe6YI4NqAdHyxSnvLw8jdqMB1MAFEM8yhIBUrOFrJ
         QcTtuEDzj+pB4ldkbiZew6E0TIzzcft3hrn4C39D2nbdj6OCqawJV0byzdRK1uVgKG0F
         qIYGegswmv6tm0JY7Nw4KpZQGDW8xv7dH4lGSA80Q/eObmIJNohc4SVtt86FgdCAU7Af
         RQVvNw8AZitRIWd7SKTB7fquM4nSOAknGUt9JOcKaT0c2q5OQvgrml4/k03BVCkfBvAt
         7DcEXNaE9LxZcNTC+sjPJG2BjXYw7ulfzD/DKV9aaNi/p8AMWqtdsRoEslz9fAIoxbwA
         SYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989145; x=1743593945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAUrsz9OdOg3wQLEmYa5D4cgvz4ST0mmGNxgNjOcyeU=;
        b=MikVf6rTnnUcXUE/KBjXukwWT+4/bOpdldD38vk00SdKuk3BScKg//sl6Mj5Wrm8qM
         hjFsD0bgAvcrjvLRbM3ESzx5BNGBzJg9jKDAKCFNaRgIWYbMgHddMxsXXC+OvHLFuhJR
         gtNbC4PqFOb9CDLCjrFaXA0QOfeemgdZezVaqvc/mcC+V4uI26O9sMHiiob6CoiQPhK8
         V4/IFHQFj5RPFkiOepV9pGsh+kkPIAoGnHZmeNzb2qm0KB3/MziJOUX1lnRlWqPLiocv
         nV7vCsnlUBxoGKNPttoOqvEvbHyCzweU2zGiIsBYHXDoV4M/QmsEVMNk4hLW97uFkn52
         kvow==
X-Forwarded-Encrypted: i=1; AJvYcCVNOikZVwMzI+XfuNQrYWDqjAFlHw8uv3G4YIU/Bbn3LdhxllDpytHytTrlnb2BYT81u3Q7dSDyWT4XkY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsk4evW9fk6GGrqWF7nUFW+gAOH61XLdreGYLcRSFxX8z62aqe
	lI5ZY89642CxNh1ovZyIRz6kV6nnhKiT1QHwG+xwV92hLnqTkq1KDxMrM3Vbwxf0DWjrKhbs/HB
	JJ7a1XKEUE7+v49VZkG0qtG5Upw==
X-Google-Smtp-Source: AGHT+IGHwZHepscP8ejJ/xKjHvWMmfkRYj/uDkAFERn0R3gk+2OvGbhbfX9XWEWX38kk7ftW0gGcZ4p7ZxAAjcKTqDs=
X-Received: from wmpz15.prod.google.com ([2002:a05:600c:a0f:b0:43c:ef1f:48d8])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5021:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d509f6307mr221896365e9.18.1742989144752;
 Wed, 26 Mar 2025 04:39:04 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:38:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326113901.3308804-1-sebastianene@google.com>
Subject: [PATCH v4 0/3] KVM: arm64: Separate the hyp FF-A buffers init from
 the host
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, qperret@google.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This moves the initialization of the hypervisor FF-A buffers
away from the host FF-A map calling path. If the hypervisor
cannot map the buffers with Trustzone, it rejects any FF-A call
when it runs under protected mode. 
Other than that it moves the definitions of the ffa_to_linux_err
map from the arm_ffa driver to the ffa header so that the hyp code
can make use of it.

*** Changelog ***

v3 -> this version:

- moved the definition of PARTITION_INFO_GET_RETURN_COUNT_ONLY from
  the driver code to the arm_ffa header and dropped the definition
  from the last patch. 

v2 -> v3:

- dropped the "Map the hypervisor FF-A buffers on ffa init" patch
- added ack & reviewed-by tags
- don't release the ownership of the RX buffer if the flag from
 FFA_GET_PARTITION is (1)

v1 -> v2:

Split the patch that maps the ff-a buffers of ffa init and introduce
"Move the ffa_to_linux definition to the ffa header".

Thanks,

Sebastian Ene (3):
  KVM: arm64: Use the static initializer for the version lock
  firmware: arm_ffa: Move the ffa_to_linux definition to the ffa header
  KVM: arm64: Release the ownership of the hyp rx buffer to Trustzone

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 12 +++++++-----
 drivers/firmware/arm_ffa/driver.c | 26 --------------------------
 include/linux/arm_ffa.h           | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 31 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


