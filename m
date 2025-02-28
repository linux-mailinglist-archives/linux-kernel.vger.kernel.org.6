Return-Path: <linux-kernel+bounces-539115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5EAA4A111
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103901899263
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD526B2C8;
	Fri, 28 Feb 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5hQzT4w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C817A5BE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765893; cv=none; b=Wo+Ggd8YhAnnXJvU0XB1M+0ehL/LFitDn6L1HihEYa5LVRxdM2u8oBvyJkeU3CSv9GbuBMao4lRqZQvFCrB2qaYatxwdef0096q/y8kw5wHOI0T3r4/K7DsecvaYynRGl/2lK0TEn8W5k1CxTAjlOwxP+WvcGeWT0baFyJXac7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765893; c=relaxed/simple;
	bh=+C63huvz9dQGQOI5cfX7d5RKsbMfZLU6xOliYCIP/Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOHfuCEfzaUSjF45N/sujWVrgW4LlZrLX6NHWTeyNtYLQtWykrOr9WB9DmdbYzsS0fFQGryjDJV758mlmVICnS28bwCbNT4xMFwPKQF15XJAtWlQVUOIomshPVzvz6Wza6T5bhP6EmXzWstB/gtZnFmumKwWrIB0ya+DHVtuaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5hQzT4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZDqWqvX3KIhyPrkQxnZsW82KV75OnrWdYAqDLbYagk=;
	b=X5hQzT4wRxLodgJNul5Susxz3M59aar5h/FOqlMYq9qY3GxigMBNMFCEFhT5GRzkOUNimG
	0e/HNVtcxbCasSdIuMVk3l2/fotyqxbdUGTsbA/uGhVyQ6PiyTNzJ7rwt8HAFI8zuTcl3d
	Z5qtLjHYP4bvyAL3yOMvB49nzjMVft8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-SBg2XPuAPH-Y5_LnYFyC7A-1; Fri, 28 Feb 2025 13:04:49 -0500
X-MC-Unique: SBg2XPuAPH-Y5_LnYFyC7A-1
X-Mimecast-MFC-AGG-ID: SBg2XPuAPH-Y5_LnYFyC7A_1740765889
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e66249f058so79012196d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765889; x=1741370689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZDqWqvX3KIhyPrkQxnZsW82KV75OnrWdYAqDLbYagk=;
        b=uO7TxDSFh1ku+eDi80tcNviGRbhKHNckHUGld5CSnUSfft0HWt/QMQrUIt5vImPHd/
         83iKDBTO/8Zx4DZx2Fz8Iu8b5CXmAes1bQzSUnAmbWldf0esbiCmY70EQKRr+tbg1k8z
         brW1zdrbMXwqUYCbuBJRVnR5+ng1OuyjzxVU6LiIhhAAQCt1IjB49nPHNfnw+5NzutOk
         btwoSvvD5bIoAPul5DlneAGh2JnVNVVJ40TdSGCSmD3MymWzlYZ+Z1YK8xJGjLYftyhq
         rTN/w74JSbDK6D+SkxsKVBfDXKqLb2oaJf8bym9LpT+sB1cDrti41zij6EbTFifH8xyV
         DPmg==
X-Gm-Message-State: AOJu0Yx/5Wy9A3bO0yuyXfgbe/ARWN+aMVEb6EOsFOMxsDOt4O4u0bzf
	Q1jXTn9ao2ckanuIb87RAsawr6lczYeII1dPB76Khps0x9XvnrwfnPJHCfC7sEt/js2jUSV45iV
	c5CQnmhMPVcy59m/qSrvpDHTujmjrc8z7kEJL9IPwmTN06awGvAem3eGMXytlUg==
X-Gm-Gg: ASbGncvs/h3IGaSVdHbLvOHGCoTWbc0QQjHR2BZf/x4j2/oT2up3TAZdlgVBvJO3NYe
	RZgvEqtttVWGRa6gxRqS9lArNB1122chAofW1aGI9P6E5cAWt2070t5RaIUq3UI75txY7XrUOAG
	NpYjh17C7YzyYzZmBMlMJFye2uQQ+Vd0+oadcAS2j+1vMHbjTlxOtMg/R9nHQvx0IUMaV4JGO2J
	WTozdn+4fXx2ZDDW92n2E4TyO/hw82DYItVJPQd5biLjffs8ZCNAkK7IakoFqknkg+r/NenLeV3
	Ld9bxDyDoU3YG0SQ68EdlLYYYai/Xv9UyMdXBvppnt3bB5mXPmrzBHFjmB4B639h0/U0xUKWYD4
	=
X-Received: by 2002:a05:6214:2629:b0:6d8:9124:8795 with SMTP id 6a1803df08f44-6e8a0c80eb4mr60662496d6.1.1740765889062;
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsDW8INo1WX4MuZoVASIHZSK4OnKzK+xAJb2//PBTVZip9R1uvasXM9h9/bkMhmLPBRWhf0g==
X-Received: by 2002:a05:6214:2629:b0:6d8:9124:8795 with SMTP id 6a1803df08f44-6e8a0c80eb4mr60662096d6.1.1740765888584;
        Fri, 28 Feb 2025 10:04:48 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:47 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 0/2] nvmem-reboot-mode: support small reboot mode magic
Date: Fri, 28 Feb 2025 13:03:24 -0500
Message-ID: <20250228180326.256058-1-jberring@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

These patches allow nvmem-reboot-mode to handle devices with a
reboot-mode cell smaller than 4 bytes, such as Qualcomm SA8775P. Without
this change, nvmem_reboot_mode_write() tries to write 4 bytes to a
1-byte nvmem cell and fails with the message "update reboot mode bits
failed" on affected devices.

This issue previously resulted in an out-of-bounds heap write but, after
one of my patches from v3 of this series was accepted, it results in
that error message instead.

[1]
https://lore.kernel.org/all/20241104152312.3813601-2-jberring@redhat.com/

v4:
- Excluded one patch which was accepted from v3 [1]:
	"nvmem: core: improve range check for nvmem_cell_write()"
- Handle truncation of the reboot mode magic in nvmem-reboot-mode
  instead of in nvmem core.
- Introduced nvmem_cell_size().

v3:
- Accepted suggestion for changing nvmem_cell_write bounds check

v2:
- Added missing function definition for CONFIG_NVMEM=n

Jennifer Berringer (2):
  nvmem: core: add nvmem_cell_size()
  power: reset: nvmem-reboot-mode: support smaller magic

 drivers/nvmem/core.c                    | 18 ++++++++++++++++++
 drivers/power/reset/nvmem-reboot-mode.c |  9 ++++++++-
 include/linux/nvmem-consumer.h          |  6 ++++++
 3 files changed, 32 insertions(+), 1 deletion(-)


base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.47.1


