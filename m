Return-Path: <linux-kernel+bounces-566533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F120A67972
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35B73AB43D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1620F07B;
	Tue, 18 Mar 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVXBAlVj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE41BCA0E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315133; cv=none; b=WbW6lcI5I/GNQDP4O+DGHNoJNWJYzJYkZ1xQflGuO7clXnmqRiQEpo+SG5MIihflyYyEpc7DOwsPy9O/AXGDPgr/04skbe4wYJUF+Zu/bF5RTR8uRDWYG+qTTqZS/gSGMfH7GWJHeqk9DysTNGuZxsIIUQY9yit3b30U2PsUISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315133; c=relaxed/simple;
	bh=jA9/pAbxqptglOxtKo0sDE1a1PEPVIV4GYrCMWoNmhE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oak0J91j1ls1fAQV6z7fpNQAzFs0Epz8MKIQPcEo0zsJGVaGX4EmIBP0Gm/J0IiGbZNPw1G4PNnFfEoWCN25NSf8Z4X9LYK6E8cUBa/Oy/p+8QCEFBFrkhEzyYbDKSEZEtdTPeipTs0acy4Vy6JPJsMd2L2Xg4pcGUnTBpUhc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVXBAlVj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so19596885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315130; x=1742919930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nkv4hTOrWEP1mAK28D1kEzJd6tzvvXvQPHgbpNeN9YY=;
        b=LVXBAlVjHJugIKCWrOycnQEz+eAva9bUjJsfpBdbrG0vvC2434WCGS6tJnuoBzV1q+
         923sfwYNen0Pm2Zp3P5kJHO61b4l1nD2Y8SbxruYqHvQts6PuGjE3eLSf8M1V5uuBuiZ
         rTOH30UBloANCJbC4bnNzkqr//+gJ6XGDMNNYJ//89gWpXcYoZRKq8odWl76ygRGXROe
         HmIl0utzvwuroTLn79ez9ftGRPLF05hCAJB1XfPWVY4QPcpTBpmXdt300UjZlP4DqjuL
         Og07IdYNN+zOq88AaC7vBjqFl1ulk0w5uIh/FIfamrZYUJ7rGa15hHWSUI1YdBHlio6r
         U9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315130; x=1742919930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkv4hTOrWEP1mAK28D1kEzJd6tzvvXvQPHgbpNeN9YY=;
        b=epvqncaGkETVwbmj3m5G9vwqKBmbNxb2MWhCRe1iGofABMjHqtk3NJSiadtEX6VTb8
         7j4kJmYYXj/vAVuI8QjfvvG1R2BV/+6fKfUUGVCFnrFdkhrvR+b3cgtza8yJLyzQNjGp
         NcYfwcNKtCMG53kiLGnyi/AbkOZnSo8BUhOahjzSsEcqx9tpXysRE+9Bn+XtSDGuLfbl
         QtsuVJQOH7440vt8bd3krJThr0B5Lz/1O01yquf1aydfLHnhhSHL7RCMSV5FVK/ZR3XI
         Xmbe5ktA77Qe/QoY9/J7GLudzZDACgYKolodwdaeOIEFcutzVjlQ10ch/Pusi6CPR4vR
         M8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVmtLqLFLN3mh0uLfBFf4JWb6TTESZPRAj19TRk7gII/m7zCm47ZjXmYADPzlq+p988pWkNXqfoMhMCKeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemMnQIZLuUg++PHi9uMpnDhYX5RgIQLH29uryYxsk19wpmzU6
	fk3YsmcuBeymXdCsP0tEjjQyjEI1sfkFAQt5ze9gjXoBpn+R72lnjyBR89+sFD666QBDzafq57X
	Lvt1EhbjLOoc8THSVvD8NHz4ARg==
X-Google-Smtp-Source: AGHT+IENQSIN9p8sk8M/fR1ObxL5U7dDuJO08/B2zEw9mK4FB92c5Di/ycqjo4nkJ+gmvyvHR+E0wirYkTH4pVs9RFQ=
X-Received: from wmbbe15.prod.google.com ([2002:a05:600c:1e8f:b0:43d:1d5:26e6])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca0:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43d3b94ff9fmr30314205e9.5.1742315129825;
 Tue, 18 Mar 2025 09:25:29 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318162510.3280359-1-sebastianene@google.com>
Subject: [PATCH v3 0/3] KVM: arm64: Separate the hyp FF-A buffers init from
 the host
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

*** Changelog ***

v2 -> this version:

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
 drivers/firmware/arm_ffa/driver.c | 24 ------------------------
 include/linux/arm_ffa.h           | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 29 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


