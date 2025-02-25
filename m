Return-Path: <linux-kernel+bounces-532191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D2A449FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4374717CE90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555C1A08AB;
	Tue, 25 Feb 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uWFfmlxL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B618DF80
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507305; cv=none; b=cOHic7N9yHNvj9zqtV5tl0VbsLzPBDhZJSkk/m3amjJlMMYV2DzS+LQmDfsRd0wgHiFGRo+xm/7/6+EQEQGoPtCgjIOfeqEon9viGPRb33WmWtSaGn8usAzZgzyBp4KPhzMBu6FMtXxhWlnr4AN/rtMJ1v22WnXVmJImoD2b80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507305; c=relaxed/simple;
	bh=YvdPm7vuUDrTxozOZ2XSpjgPIGCpumydcNBSnKjQLGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S39paaaq8okBlVrmpPjd4I/yqJaIxm53i3ucoUYMr8r8Pld0GHaVq5xrW5HnpXqXcnXyyJ3+trqCHGalqXKw3b5GGYV2sZ1VZqy3JwNJtjvujn4zIzRK7A24lFjtuw2AWPTHYm+aRqHs3Mkue9ZUPysompJBqdVSMOgoNusYjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uWFfmlxL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f048c038so113688515ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740507303; x=1741112103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eD4lJxu0UTZTdJ0UdYe5FZrfntCk4zu0rxUqF0TWic=;
        b=uWFfmlxL/P2/9d33o/QhRSrAUH9CQbxvEVBPLs7TAieSIERisiFpeCvgYxQ86Ox41X
         +c2Pd/Ci/nc01naiB/FXvXVoP5AumsBVsZk0Gavt6iPa8prEowYmiZ8+yTlrO5az0lQD
         9MLpoyJTSNUzBun/Xtus9+v5fM/Ikmbu6SJvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507303; x=1741112103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eD4lJxu0UTZTdJ0UdYe5FZrfntCk4zu0rxUqF0TWic=;
        b=nLKDx13zjQpfESBLqBiddU4P8SHhsVS8sucA+NVgqUmSHffbKYg0yUWo833vzjMi+z
         hrGcJqcyFk4m7txVFpPzc59eUmP7hYrMEChxzHGhwmWSV+Lt7EwSZ/o/EcANVEd7PQaE
         6yij+btGe+D34HV3Ls+GTZmy9r2mvKo2L4piYobTXzP7l9wEmC7eGrvTqRRJ/0nINXRP
         ReHy+3hLPUkfhd3RtGE01O+xIAiHb03phXBkRWvt6nNkvgREelhrkkzbCkYxuttQpLq0
         /HQZHO3EfgyOdeNgw2dEUfcADYjksWZzk9FEdhvmRvP17BEXyutClQi7AIAYBXt1FBvD
         IfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAxJ9GRt4tHiErv76S1Ub/WS6mxBhMT74JlrQdWWjieoxzBK5Vnt6wcZVc93uuI/6+XWR+oZZFH40GDDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7b3M8T1BEcJMwIHyhYMJwjt76cF1BFzkLNrQi5W3yqpH9qRAG
	VpQFzKf74BXs4fXk9Zp5KZdQbwXIEvyMA6GhipEA3BhDAgTV8SYp4BILPtu/G5Y=
X-Gm-Gg: ASbGncsAR2i5AX9tsDJ+WJCqx/s63hCRly2+NeGtb+i8X5zORFDeCgyTJDrqvG8GZps
	xOSX+cYg9/r5ysk3p2IaP5A+oUAwPAMIdg/5bzsVydo7gnRa6041ilNb891Z6x41l06sHeygXuK
	Q2KdwiOCw5wZ/1bWEXrhn5wu6yU1uOu0tJJE2Ct/xtLZ/3lxSafFFN3LyG76r7yFboVRQvWf8dV
	UPFqdopPWEhpOtdPDTFPYmvuBynFJT+av9CwfYfxcNV97h15x9bUlnvxY2a5WSy4uEvxXdeJiDG
	WZQB2x6VrniYxRogmtXk/T9CDA5nMum30w==
X-Google-Smtp-Source: AGHT+IHbdHzM51PF3kPVqKty+t5U0xSAB/6wSbzhQ4o196SMvHU4bg4PiG4X3iXqYNIp9TLrFTleGA==
X-Received: by 2002:a05:6a00:4f84:b0:732:5696:51db with SMTP id d2e1a72fcca58-734791bb213mr8234240b3a.24.1740507302769;
        Tue, 25 Feb 2025 10:15:02 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a72f732sm1821716b3a.84.2025.02.25.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:15:01 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: dw@davidwei.uk,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] selftests: drv-net: Check if combined-count exists
Date: Tue, 25 Feb 2025 18:14:54 +0000
Message-ID: <20250225181455.224309-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers, like tg3, do not set combined-count:

$ ethtool -l enp4s0f1
Channel parameters for enp4s0f1:
Pre-set maximums:
RX:		4
TX:		4
Other:		n/a
Combined:	n/a
Current hardware settings:
RX:		4
TX:		1
Other:		n/a
Combined:	n/a

In the case where combined-count is not set, the ethtool netlink code
in the kernel elides the value and the code in the test:

  netnl.channels_get(...)

With a tg3 device, the returned dictionary looks like:

{'header': {'dev-index': 3, 'dev-name': 'enp4s0f1'},
 'rx-max': 4,
 'rx-count': 4,
 'tx-max': 4,
 'tx-count': 1}

Note that the key 'combined-count' is missing. As a result of this
missing key the test raises an exception:

 # Exception|     if channels['combined-count'] == 0:
 # Exception|        ~~~~~~~~^^^^^^^^^^^^^^^^^^
 # Exception| KeyError: 'combined-count'

Change the test to check if 'combined-count' is a key in the dictionary
first and if not assume that this means the driver has separate RX and
TX queues.

With this change, the test now passes successfully on tg3 and mlx5
(which does have a 'combined-count').

Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/queues.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..baa8845d9f64 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
 
     netnl = EthtoolFamily()
     channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
-    if channels['combined-count'] == 0:
-        rx_type = 'rx'
+    if 'combined-count' in channels:
+        if channels['combined-count'] == 0:
+            rx_type = 'rx'
+        else:
+            rx_type = 'combined'
     else:
-        rx_type = 'combined'
+        rx_type = 'rx'
 
     expected = curr_queues - 1
     cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)

base-commit: bc50682128bde778a1ddc457a02d92a637c20c6f
-- 
2.43.0


