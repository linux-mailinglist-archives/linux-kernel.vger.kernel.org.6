Return-Path: <linux-kernel+bounces-448517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7899F4131
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A1188A475
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D213AD26;
	Tue, 17 Dec 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0nRZ1YK"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901412BCF5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734405649; cv=none; b=FiTLK7N4CMTPARGpJjHFPIlWOM979K1ZSojam/nmgGAsyKx8bl9wgwu1FNIlKA7UxupjaQ/ZTdIXk4nA68NCCPhTKKrkmBnoNupQ91/cRs7NDjQemacxpujokfIry3p0OII7VjBUyUpIhQKXKlzv//edDNkp4LeZ4fpXCQXrysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734405649; c=relaxed/simple;
	bh=t4r7S9UxnOILTHMpfm5vhgGgMiXH7CFWGwg5lMOtJcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uD5t+mm4PF98v+/vtakfg00hR56GdkJcnkcklywqFuNQuOkzWvkNRQAAlsrftt62jXT0/xPnECa0f2cx0p3X1J/wtXf+uAS4yLGJDASLwFHlcSXI2Yvwbe5NZ0bIcsa/KU6DxlsIGcxmOmIEuoxdDqsG95mahJFF23QrwoNg6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0nRZ1YK; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51623968932so2542985e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734405646; x=1735010446; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhLiVegGByTRtcesCH218mLcU4d68P1LDKmOj7M+yj4=;
        b=k0nRZ1YKnOnGKZgddXkwxzLlOycdMPnq5E0l9L3IU7Hodsq7ma5UPKJ0o2YkNFODUm
         +Iz7VuPU1numvM68HrwIA66M7aEW/myCXc3F7mgkQ2XUw7ehACKN3DkRqbpowAVvBitA
         nPV5prBWpharBomGD0DBwd4auvmhuBdRn1eydqIkxK/mE6u7VjSFEpaKDzJxueZm0mp6
         rs7XNFe2CGQPMZ1PwbnLDs/oRYoGuowgwvpHiD6WtjKBBoR8yAFBjd79iHYh+ukGkFJR
         GnkJCqWS76+678pDGo/5C8hBHzGb5WYcT4axpx7q/1rCB1dJpOUU2Pmw8jaZ/Oxn6Xv3
         XAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734405646; x=1735010446;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhLiVegGByTRtcesCH218mLcU4d68P1LDKmOj7M+yj4=;
        b=SoNRaYfvmcreBxFQ+WJ74+n2jowpXqiW+BHU3alQcE+WwDtvVLz5P6XghcYUpYXtrA
         dTkIoRZL9Imsn9ehmGd6s7WVQ7zDVzlIgGubcRmeImbkckVfgbTHYLDvnZGuv23p4cXG
         ZhlyJPzOlXN/S1CavWuYIo/BaM8JIM40YJzvT92XIrS658W2odvxOMjqMuk67JPBPpfo
         NJBiyCkqxWL9vzjAB2nTXPNiyyL/5kq+1d1USAKnyEUX71XGX3rLx4u5SSa9bpBfLi2y
         uzWog277jz+6tUKaAbqMp7X1xgdUG4dzGs1DbUqWL+Kj7MNHgJq7e+q1WzMeRLsnlAr/
         sKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqf9GZnMJb4p2/4mkCxtZf8YnKGnvbkWlA4+hUTtCrFWKWXFmwMU8yTGtbNDWxc60wKpEJgFsEQWCdkzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5If7IsTkdEDRHLpRTHnhgzSYtW8OCpAEAOlJvf0cd5Bw4j/RB
	u7BXDmkIZhp+j6L1yZYbrrQvs7t9LrU+J/oQXdmG6dIv+9H6ctm6
X-Gm-Gg: ASbGncuMoQH2hwRTnOwsN2xn0MqG+3rECmXNspnm1IEdwXhtVZQSu+9ifLKfI7TS79O
	S59wiIEWLJuxlZK1jX4aec97h/+5y374WCL1apE1TN0xhPrjsYSS7hZORn9QOBEmiHdmJvWe31X
	/Fhst3O5JSvcosFvKgf+Gay+Bty11FZpUAKdYU+KdAWPwi0se9peWDFpTd4nV9N4cMRpoEhuT7F
	KWDqWoYQZKuxCF8IwqUwE7YJQu42WyId+WP+88h4Hy6MSmL6YpyXz3t/jPd3rxxfecQ0xysA3jA
	J5gd0u0tqMZ+zc86aLBbo3aAP8Qd0dMXEiPZyhTVMw==
X-Google-Smtp-Source: AGHT+IFWexl+zzxuDgk5sv/VaYo1ZTrU+54q4u7wQxi6nqewbZtT2ZFlqFxf9I5ZbaxWWqczIqkxfA==
X-Received: by 2002:a05:6122:908:b0:518:8e53:818b with SMTP id 71dfb90a1353d-518ca231a36mr12679248e0c.0.1734405646241;
        Mon, 16 Dec 2024 19:20:46 -0800 (PST)
Received: from granite.localdomain (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-519eb72a06csm831938e0c.44.2024.12.16.19.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 19:20:45 -0800 (PST)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Date: Mon, 16 Dec 2024 22:20:30 -0500
Subject: [PATCH] macintosh: declare ctl_table as const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-constify_sysctl_mac_hid-v1-1-f60c0871dc03@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP3tYGcC/x3MQQqDMBBA0avIrA2YwQTbqxQJMpnUgTaWjIgi3
 t3Q5Vv8f4JyEVZ4NicU3kRlyRW2bYDmKb/ZSKwG7LC3aL2hJesq6Qh6KK2f8J0ozBKNc8Pg3QM
 JOw+1/hVOsv/Pr/G6bgEhL4RpAAAA
X-Change-ID: 20241216-constify_sysctl_mac_hid-55886592c206
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734405644; l=1568;
 i=luis.hernandez093@gmail.com; s=20241216; h=from:subject:message-id;
 bh=t4r7S9UxnOILTHMpfm5vhgGgMiXH7CFWGwg5lMOtJcQ=;
 b=y11xfWENIaBtjTQm2f4ZOzsSILA/g0WLwVrPB06RmXZE2+gi57jZtmcNlbonzbgW2LHIMioc8
 30UtlmHIrIvB0ZfBARLYWzx3CiJX6g1i4GFk6FN7k74D3EdcP+ODTIe
X-Developer-Key: i=luis.hernandez093@gmail.com; a=ed25519;
 pk=E4Sj8ywxKbE+P0rYLQl7e84XZJfcVOiqNallR7p5IO4=

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows struct ctl_table variables
to be placed into read-only memory.

mac_hid_files is registered as a sysctl table and should be treated as
read-only. By declaring the mac_hid_files structure as const, we ensure
that it cannot be accidentally modified at runtime. This change improves
safety and aligns with the recommendation from commit 7abc9b53bd51
("sysctl: allow registration of const struct ctl_table").

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Ricardo B. Marliere <rbm@suse.com>
---
 drivers/macintosh/mac_hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index b461b1bed25b2df106ecf612b82efaedf69f62b0..369d72f59b3c10869bc914f31e7dcb73e029ef7f 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -215,7 +215,7 @@ static int mac_hid_toggle_emumouse(const struct ctl_table *table, int write,
 }
 
 /* file(s) in /proc/sys/dev/mac_hid */
-static struct ctl_table mac_hid_files[] = {
+static const struct ctl_table mac_hid_files[] = {
 	{
 		.procname	= "mouse_button_emulation",
 		.data		= &mouse_emulate_buttons,

---
base-commit: e25c8d66f6786300b680866c0e0139981273feba
change-id: 20241216-constify_sysctl_mac_hid-55886592c206

Best regards,
-- 
Luis Felipe Hernandez <luis.hernandez093@gmail.com>


