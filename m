Return-Path: <linux-kernel+bounces-232866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3493C91AF42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53B51F2430D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B519ADA3;
	Thu, 27 Jun 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N2cmRGw0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C06A3D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513937; cv=none; b=b0GMObeQrv3uT9MXY55qqm6hwaBXSp6o1GbapU0KzGWlrNrQyx3R2vozVbhdC06DGhEd4Ijeai/6a2jhAW+2V0EgtYuFw+lh30L1a24B9xDaAnfDZ3HWsVKK3rLpQj2f+efXH/XLO/8hroUElk27w2XTuEtC4b8fdDD4DwtNhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513937; c=relaxed/simple;
	bh=oEPYyDVVZeuBIrcIU+ilnfBU5w04qUvEoG7Gy3mWVlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz6x5z6M1Rs+ANU84G26y3JW1Y8ukk5+9RZvBL1+l1VqqAaffvL7qGccOo/aPoHiYtnYW6l7nYHdyKdTdiKT2GoHyf8f5rwxPvR2x7nOxyLph2fUJv7yn3E1lUN8Hc1HBxmsENmhb4Hq9+ahIq+ywz+cCm6rrvCREWoOUIXugPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N2cmRGw0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0769C3F5B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719513927;
	bh=fz3g0QJvE015EWXtIsvfY7o2jPqWQQCreHPesEg4Ank=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=N2cmRGw019lo5lb9Q4z35KvUnRk/lJIUZlzWq7g7SJmLJUX2NUKcOF2oxGzVNGX36
	 SDqLKxnCFQNKegKya9R+9kfDIBGke6SffgmBK0dhJ/IOdEEPjgFwdQc7/jgbQlrsfg
	 2H0GprG05zGQT3sAfykpxCbdRb80IbpAqFfU0Z6UvQXUy1O8vP2kNJ0j2rHd/KsYaY
	 HNaj5c+tZHS4AmGlW7uBrVOjmwWIgq9a0bveThzEyCus4IDYv6YLvlviiEHn84+8Gn
	 zfz6Muf/g1QWNDuYfwNZE6RKpjk3u8IbO9BDl+WrAYIuT9I4c/yD8hjNvq6W7TKxmM
	 cUtf5bLkxEGJQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a725eed1cfeso281558266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513926; x=1720118726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz3g0QJvE015EWXtIsvfY7o2jPqWQQCreHPesEg4Ank=;
        b=iSyiz+KCwYn4VTFdDgvFz9MK4YX00P1ooXgDam+oFFYWAHAlNnpfHdsAZKVVor/Zd9
         FPmNdW7CUO0NoM5x+bjU2m9MYwHg05QgqqBAgcWnyMk8F9AXu0Wy69AjuxULAtjojfnZ
         o6EJmeTpM1RmlUI13rCnyGO1GHmTv4fIRbyk+GMh1NMfF+AksHAVOdZGmc5CONB+68Dt
         z0GFMT6Qzvo5ZHZWjjPDz5j50frpjIakgQQus5qarWEaqPBymhfTpp+dTAKMSK3CfcXS
         NXxdXoPWWyRHfL03+CXGVXgIYmItRkPnqhTec7VT2IQuyMbk42Il89QyMXkmEzmtGyF5
         B6eA==
X-Gm-Message-State: AOJu0Yxg4xXEN96kPaTgcn+ekgj+r0bBHUFRaOxTNt+3BISmX3OWp08W
	DDUbgySoqacqWv9bgXJWzTUtAwdZIr//RfwdxvWCkVzag0kw5PMGjlQOgseNYHA/MGYtk3XGcfC
	8xqDiWSI2XTVVUkbNFaLdJGKJHr2bK9ShNHuW6ZXREZeqIIwF+/0/kpn3Wj5vi74BKniAUT3TQu
	JKfw==
X-Received: by 2002:a17:906:74e:b0:a5a:6bde:c3fb with SMTP id a640c23a62f3a-a715f94a85fmr949934266b.28.1719513926347;
        Thu, 27 Jun 2024 11:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5XJEHHe6BuRJu6L7ThbXvT7rniN6erpBORbyGoGWk1lS1KpYASGCBGtGDOE8c4UsfL60SQ==
X-Received: by 2002:a17:906:74e:b0:a5a:6bde:c3fb with SMTP id a640c23a62f3a-a715f94a85fmr949932866b.28.1719513925719;
        Thu, 27 Jun 2024 11:45:25 -0700 (PDT)
Received: from gpd.homenet.telecomitalia.it (host-79-55-123-4.retail.telecomitalia.it. [79.55.123.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aafba04asm1887666b.97.2024.06.27.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:45:25 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] sched_ext: add CONFIG_DEBUG_INFO_BTF dependency
Date: Thu, 27 Jun 2024 20:45:22 +0200
Message-ID: <20240627184522.1257114-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without BTF, attempting to load any sched_ext scheduler will result in
an error like the following:

  libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?

This makes sched_ext pretty much unusable, so explicitly depend on
CONFIG_DEBUG_INFO_BTF to prevent these issues.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/Kconfig.preempt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index f035c87d02f1..f3d140c3acc1 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -135,7 +135,7 @@ config SCHED_CORE
 
 config SCHED_CLASS_EXT
 	bool "Extensible Scheduling Class"
-	depends on BPF_SYSCALL && BPF_JIT
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
 	help
 	  This option enables a new scheduler class sched_ext (SCX), which
 	  allows scheduling policies to be implemented as BPF programs to
-- 
2.43.0


