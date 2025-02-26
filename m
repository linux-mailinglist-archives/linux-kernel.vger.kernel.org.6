Return-Path: <linux-kernel+bounces-535021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AC0A46DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953D016CE79
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC725C6F6;
	Wed, 26 Feb 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAwtOBrq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E553238178
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606541; cv=none; b=CixlfhZRCSGsuRZFq8jsoIu8B0vykoufi7FI2A3MENOiWN6A0+GIqKAspxad2V9sQ0cFiIMqljEs2Zv4ASYvYT80ZJydqegwnZfMv2HBFImj1jUcms9/owLArqbgrNzgQJEDwVoN/MFVkORw2LPQR8RULokGH6gaemjO3eFsEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606541; c=relaxed/simple;
	bh=Jn/WvMX/Yq1lt2R6na6j/1FxGL5KuA+L1lqiLVHmSu8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IAYI95qIyFv2lBv9m1sndAfFr98F92JCMGRplsdBr2CQ7O4XF2DEjtbjghU62nOJfFP/h/S87PlYRqIo1BIX4rt7cO2FG88Ozw0K7t3kDd3QkZkVtKalayJKHLW9uQPRwdy/Yz8+fN48yHzxoWlqYwkuoCbq+cONuO4O8cX7ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAwtOBrq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so1806085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740606538; x=1741211338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N3L7AviT9xfQLqg1ssfgAz/hdS2zhgqxmqkg15ECEOI=;
        b=kAwtOBrqBtm+BqnNYdGcItrcdXoxVfnqfhk25UqiwBqnJAxS3lkPLHpHxS/IqaKSWL
         IioteIQ5Ps4Fd4HDzqgFCaCpfrwbpx9HOT/xXiW0oxbVXcuI4yOwPRiqk1rl2KFaciLw
         SkS+EohXtOQyiSZiXmAwxUaLZKZkJxQMSCQ+/HzjYzfW+edmWo7Z5C8mUGqb0kzlB5Cz
         rYkGIaPUljGyFGNW+hijwXxay0tvzMyhb8GmAByfOG+VOYOawmDUGHVeD/q+7vEi/lif
         8Fcm9W7+ybBoePB2E5RSBOPvbwdyrI4m7qCJ2mcIkejVx1tJzroNqBlnX0GGauBzOELi
         woCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606538; x=1741211338;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3L7AviT9xfQLqg1ssfgAz/hdS2zhgqxmqkg15ECEOI=;
        b=kfbCjwa3HTV0Q+7RLNCTaVIIJgAzwvYXdIr680j5dtTgoETdZk3+m1cXsxL0DvDFrE
         w/NajfHWcEbKqasPCkf8fG/hMVQSe74rRhaF0VhKY/CDasE7KhtGq4Jz6iB9frbYuogT
         qKB/zBnUnkr0juWhn8MaKLiBzMT5NnJVjLNXIu+7t8sb+HoS6eCyCPOd0lyyFQHlhYPb
         r2ehuJq8VlyK+9nUI/bmI7eiwxmOtcJ4TJnhj3+4oWOMRPSsQcdIUaGHmagrc9Pdm01y
         KHga0bAYUI0huy7u9wZHvZwcPLCKIRGeJPUhbvo0HhHVYNNei2gWITPusJ8WwQlMWdm1
         8jxg==
X-Forwarded-Encrypted: i=1; AJvYcCUzDt1Q/ipFgtpRTeq/Nj3CXUP9bmYQvgKcwGDeI3AzGjWgx7xxxPlpKmNLE7mcET25BzcZOCReFD0tsKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnckcKXk3Z7dBqQI1lFnhtRQx54mJnLGytq5GV7sdXxHnKDMg
	coxbeYusd0iVXquXhlCDL3oyEE9Hb5FNuo/pAX1LHJwBB1XO6Y9ZOQiTqMKi1EBT+6TVjmEalVm
	/jBrZRZCpWPBfd1Ny2aZxgQ8Zpw==
X-Google-Smtp-Source: AGHT+IEA6UUUAJ9uECoMio1DestFhpWyyz+Ts8rNvs4mLLNlC2cQcJ944oVmRih7EryswtDmHignbakfjjpmw8U0FII=
X-Received: from wmgg7.prod.google.com ([2002:a05:600d:7:b0:439:67c6:5642])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5489:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-439aebb5558mr165297465e9.22.1740606537893;
 Wed, 26 Feb 2025 13:48:57 -0800 (PST)
Date: Wed, 26 Feb 2025 21:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226214853.3267057-1-sebastianene@google.com>
Subject: [PATCH 0/3] KVM: arm64: Separate the hyp FF-A buffers init from the host
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
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

Thanks,

Sebastian Ene (3):
  KVM: arm64: Use the static initializer for the vesion lock
  KVM: arm64: Map the hypervisor FF-A buffers on ffa init
  KVM: arm64: Release the ownership of the hyp rx buffer to Trustzone

 arch/arm64/kvm/hyp/nvhe/ffa.c     | 56 +++++++++++++------------------
 drivers/firmware/arm_ffa/driver.c | 24 -------------
 include/linux/arm_ffa.h           | 24 +++++++++++++
 3 files changed, 47 insertions(+), 57 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


