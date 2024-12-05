Return-Path: <linux-kernel+bounces-433979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467889E5FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1669A16C398
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB61BD038;
	Thu,  5 Dec 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WkW6HP0K"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23D1BBBF7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431851; cv=none; b=R3VlBrwyqOxE0DG4nNb0zMExwTROQXIt+EIrt9Xzd0yd4gKgledfr8JnjMCrOLtQmRfRM4tKYfbBqfL7/Xi7rkImbvqNPI24qUedzybfQErjgl0+ovwGDV0002fDpt6qlre6ggcWU8MZfPegATjMq6WxOJgUvHNGW82+B2ux4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431851; c=relaxed/simple;
	bh=C6L8KTwkVTanAfa3t+XNQhZyzlTi2eR3uQ+W2T3tYjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pRsMwAP6lkezIQ2ZuuKbJrV0bdhjVcfgbAsT8l0dqJBP2LgZq2xttW+w/MJwBundgom/m7ZmHpPtpHE1s4ARbcbg1BAN4jVyu63wGHy04aCGuW3uknR5aFJI9c6tWXQkGUP8Q9S/ZFpXKPRpNMAYcCijgtdNDCqfO6JOaC+Ua5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WkW6HP0K; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862a921123so136063f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 12:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733431847; x=1734036647; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGNnkD18H6zbPymHJQHQ8MscNTVqaFaPdkJtuvUkNEg=;
        b=WkW6HP0Ka9B5jRVkRPrp79IfzENstl2XH34i4h5REaOnWw8EILZv5/dAkGUEN75Weu
         xCPZVJOqROh2sbO8f3JRRmYUVv2FkcCujZEt7yV/8EcLAMtc9ctijDnRXyl10aXC7nTb
         dD3sI58iQqxMZvCvLKVB4nxOPT/QPoZMHjZAjzJ6UMe6JNJMpHhgOMlh3imikilzFPUF
         M1bda34DXTcRKIgMYKuZBq+D7jcrqFpMOokjbx2N3hGx3Dfe7giDyoyVKr8jNxOkWAi6
         2DcWbi16scJ4M76N3485qOlQitZmQjIDucSJruPwxRKd7vRIpDquj7BUOwSGQrwdtVx2
         Y78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733431847; x=1734036647;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGNnkD18H6zbPymHJQHQ8MscNTVqaFaPdkJtuvUkNEg=;
        b=d+kGe9Ivo/VLaLD5lXvBxVfSc345VHS2Oo3p5eeF0qWSGJoPotEthe0DGPoJy1WlG9
         eIEcSQR8mJZBOMQx4/8X8QAkDrEOmfwWS7tadhoCqB22J8KKpadXgKkU8jwmFsR/KYqZ
         3ekJrjoirR+Mc7QluMj0FPX4MVsbscKHAoPh6Qfn0Ur98osnsU7C3zoY5FugBVGLlnH8
         nCtAnO1QGZBdKZo+Hx3jmv42tycDHjgE2FF92HR8ITW0ArtRiO1O7t3gjp3ILNG64Xee
         Q0qRWHFlbnerISnm2xShZi0iwWzgOA123a0W9IxwKDO4AuMomMkZU15BWrlVmhH+L/uO
         ttIA==
X-Gm-Message-State: AOJu0YxUtLFYw8//ojlFsVqG6kdh2S9OaTAQduRad71pv2TFP5lj/2co
	oxEj9pyqZn5HhmtmZY8WhLf40KKDPWdkxNkcIzGaoQY++IFym9LsFT0FwjtEqWE=
X-Gm-Gg: ASbGncuW8cDps6xbfJ8WmWYfCvb96pt2iJJC5pwSfRP9f5HEGShosGup47Wnm9fCH2l
	Rm8RCYZePzEPlJF7HHWru6psFnPKSyQMwHebijuh1tyK2IawoefZpvz2nPrAYQ/nmcr6MZKMMIs
	L+9MfJVNNp1qf1GB8/srHYVr1zxjIoSKtVFRiBVK/qvJA0it8APPl4jd0SKU5pY9AMxaknsnErH
	lKVcN183hNv5fJPSRhxx20XH0i2oTntPFXq+A==
X-Google-Smtp-Source: AGHT+IGAI2M8reTnJPGo8oDd6BFeDE49KMq4tlHFLnW3sE4HjRV7Om9XNIWCxQNTjCUlRJIx8cpXGA==
X-Received: by 2002:a5d:64ab:0:b0:385:e30a:394e with SMTP id ffacd0b85a97d-3862b3454e6mr360169f8f.3.1733431847287;
        Thu, 05 Dec 2024 12:50:47 -0800 (PST)
Received: from localhost ([152.250.153.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09151sm16545315ad.175.2024.12.05.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 12:50:46 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Thu, 05 Dec 2024 17:50:35 -0300
Subject: [PATCH v2] ktest: Check kernelrelease return in get_version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ktest_kver_fallback-v2-1-869dae4c7777@suse.com>
X-B4-Tracking: v=1; b=H4sIABoSUmcC/32NWwrCMBBFt1Lm20gytJr65T6klD4mNrQ2kolBK
 dm7sQvw8xy4527A5C0xXIoNPEXL1q0Z8FDAMHXrnYQdMwNKLBXKSsyBOLRzJN+abln6bpjFWCK
 d0PR61Bry8unJ2PdevTWZJ8vB+c9+EtXP/u9FJZTQEuu+Vrqu8HzlF9NxcA9oUkpftZy6QLUAA
 AA=
X-Change-ID: 20241205-ktest_kver_fallback-d42e62fb8d88
To: Steven Rostedt <rostedt@goodmis.org>, 
 John Hawley <warthog9@eaglescrag.net>
Cc: linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=rbm@suse.com;
 h=from:subject:message-id; bh=C6L8KTwkVTanAfa3t+XNQhZyzlTi2eR3uQ+W2T3tYjQ=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnUhIjLr9+g73g7VpihF1Ng7E/YFsxOYkfwfyGM
 PcMh4rBtIiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1ISIwAKCRDJC4p8Y4ZY
 phH8EACADwBEqGvIQG7RlJkYbIgZvDrei4aNJh8hma7YXWvxrxqG/iIoJ2HCrTdlGh0Udi/eI0C
 g5YC15uVDi88WfkFBmznr+Ipdcv6+rThrLjinK3TgJlVUGz97RcOd7RocezrgcBT08c60WWrqwh
 vOdXKJy404THBVcgv75FyqXvzGj5n9zWLOm/9ou5tz34Kgsi8jvAlKHwEEYqeaiFXKAU3Ip2kv0
 5Nak9uG8thZ+G07NwAFczzPkf8FBomkVb1JqpYvYAnUnOJuGIbrrBHCR0SJFei4xgb4k5ZtSK/A
 ppHVvAW7LpwM7fWtQ3izKv8XiC8+JvkUD0LUEjX+W9DnprRv+D2giUsQPGQ7HtfX8rkx90cK7e7
 Y/gXliQ1EJ7eUNV+n0ASAj5L95/fmsPWSaCEy0NMfCLloFmIzGxskGRn1JEJo7igTyzg626qf0z
 136Y+qRf2N2iAuBsw4EOTYORrEw1RssQms0+9ZBz+BxwR8uYSrzi9MpqgktoF2UvmiIOpMq+Flm
 3a205DAlOPl1lE95K3SmFYppK14uXwsPaQz+j0a9hCQ19tGRoTxw3JG5xP6plQcXcM/igLDHTf9
 A1/dBiXUp/1llgHOp39jRuV1UTH6NoiSFTBXPYI1sjSO696Pl85rMtkgIoapJIxpFkXlkP/YKAb
 syETv/o/0Qb11yw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

In the case of a test that uses the special option ${KERNEL_VERSION} in one
of its settings but has no configuration available in ${OUTPUT_DIR}, for
example if it's a new empty directory, then the `make kernelrelease` call
will fail and the subroutine will chomp an empty string, silently. Fix that
by adding an empty configuration and retrying.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v2:
- Fixed the if statement to use length()
- Link to v1: https://lore.kernel.org/r/20241205-ktest_kver_fallback-v1-1-8029b9189527@suse.com
---
 tools/testing/ktest/ktest.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be42a86f9680fcb50b65d1f3a78afb5..171262915636b6287e6639e95be5420b5bc8e0df 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2419,6 +2419,11 @@ sub get_version {
     return if ($have_version);
     doprint "$make kernelrelease ... ";
     $version = `$make -s kernelrelease | tail -1`;
+    if (!length($version)) {
+	run_command "$make allnoconfig" or return 0;
+	doprint "$make kernelrelease ... ";
+	$version = `$make -s kernelrelease | tail -1`;
+    }
     chomp($version);
     doprint "$version\n";
     $have_version = 1;

---
base-commit: 9d6a414ad31e8eb296cd6f2c1834b2c6994960a0
change-id: 20241205-ktest_kver_fallback-d42e62fb8d88

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


