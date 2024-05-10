Return-Path: <linux-kernel+bounces-175273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CC8C1D60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14551F22DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6114A095;
	Fri, 10 May 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NYfEIs1i"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D367148852
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314630; cv=none; b=V+F79nX1tV+lheBV3puKwjlzDIdiCbe5cPoFLpDVQBJE6e9rBFig2lgRB1myVOHHRmyP7c8fw/OgyeGCHCOgv+wIFrZ0vny8L/TSGKk20EaleMKtt8QxQvKfJehGVPqxJhpk91r5zbS5KH+w3fMIImhg7AR6HM+kJ2exTBjacTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314630; c=relaxed/simple;
	bh=EibtQAHnFtRUSOtAKaCqEgiTG0C9qMUS/y81xVi4+lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ct5wkayJwydmTHxo0fZvbiFtBOc841jv0hPyEZHr6lG+HH0bwCQUwYc5CEThfLZJBbAmkP/2cqnnvxljBPSjPkjKdzniWFqi9Poq0zB+5MfBoMiM5THAsXP8Liqn8BrrhPEZzf9+1cu/wZjq/VvU3dANmT3FQGz8uyK42t7996g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NYfEIs1i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so9805635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715314628; x=1715919428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXDgqThLEf+1MK7OUIb5eDMEm4b6Ug9ZOeqtANDTTtc=;
        b=NYfEIs1ibIewnfTafxYtIvDeKitVs7s0OiBdS33/3vCpvH7dbUrKA6zhjjqdDDZM1a
         cEZIsSHtulVdRaIU5BK4Lzou3OgJ/XpQV24phdhKqJrDBnQL/29Sx9mGbVIMV4ap1Wha
         vqK0Y6Wpa0RBLyUgtVJw05h7gaFvwm0EegYu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715314628; x=1715919428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXDgqThLEf+1MK7OUIb5eDMEm4b6Ug9ZOeqtANDTTtc=;
        b=ONhXDoTMPxgZGCzKM+KMWg9zYb3m9Ufw9jamaXSHyxA3VdM3LTxNp+w0rNYs02jz3t
         XFuRyNIvQyNHFEE6u6qd7U/8k10b6wpvg2jFNdCHNSYFnSuk8WlO86yRFDp9c+IRhl1k
         f91KKTfwkIBx9gn5D56ff6/fbMR8BXFh+MEJktSBpKDT5+KIooloZL7M/p9x7BTVScc3
         gKULd3K4LpUXOkgQN61BiVqxuEQYjjBTKzVtN4ZzDdXVAfcL8j9IKJe40D+OT4fyytNN
         pVM/uWsOMLMm/48FnU2gY76VlYeBPTcDp7DMwBfmz6+Avs8WttEkiqrAZfHJkqRj2bV2
         ctlQ==
X-Gm-Message-State: AOJu0Yx/hseuJrP2uhiuMCJc6lW1ynMUQhudxzATfSrrHzGtNhJSwaeT
	gtDqfQ+pgNzly+2UCU4s7Z9kw3o8+qesP6K+thlgm/9kQSlaXYeEu48BRL9F3z297cw6n2yKVSk
	VYKel6ZuVbT9N9fw0TOZgGFaQtXyk56AXF8sZ2MQXjZj0R1DUi9YEEWsfVwrtj3OvtuDYp8FBEF
	Xz8/BnjdzxPC1OYZl8caX37ukJnX7A58HUOHTDcwhhg9Q=
X-Google-Smtp-Source: AGHT+IHIqH6sntsrOu84pPR11fW41JGaUw9sHLI7Wb0p61OYBDRv0bkJGtmOfmevfxtCMjN1PyGxdw==
X-Received: by 2002:a17:902:d2cf:b0:1ec:25d3:7335 with SMTP id d9443c01a7336-1ef4318d713mr22562215ad.26.1715314628252;
        Thu, 09 May 2024 21:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad634asm22617485ad.87.2024.05.09.21.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 21:17:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v2 0/1] mlx5: Add netdev-genl queue stats
Date: Fri, 10 May 2024 04:17:03 +0000
Message-Id: <20240510041705.96453-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

I know that this is only 1 patch, so a cover letter isn't necessary, but
worth mentioning a few things.

This change adds support for the per queue netdev-genl API to mlx5,
which seems to output stats:

/cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
         --dump qstats-get --json '{"scope": "queue"}'

..snip
 {'ifindex': 7,
  'queue-id': 28,
  'queue-type': 'tx',
  'tx-bytes': 399462,
  'tx-packets': 3311},
..snip

I've used the suggested tooling to verify the per queue stats match
rtnl by doing this:

  NETIF=eth0 tools/testing/selftests/drivers/net/stats.py

I've tested the following scenarios:
  - The machine at boot (default queue configuration)
  - Adjusting the queue configuration to various amounts via ethtool
  - Add mqprio TCs
  - Removing the mqprio TCs

and in each scenario the stats script above reports that the stats match
rtnl. Hopefully, I got all the test cases right.

Worth noting that Tariq suggested I also export HTB/QOS stats in
mlx5e_get_base_stats.

I am open to doing this, but I think if I were to do that, HTB/QOS queue
stats should also be exported by rtnl so that the script above will
continue to show that the output is correct.

I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
code together at the same time, but a later time, separate from this
change. Would that be OK?

Special thanks to Jakub, Tariq, Zhu and everyone else who chimed on the
extremely long thread for the v1 trying to help me get this figured out.

Hopefully, this v2 got it right and there won't need to be a v3 :)

Thanks,
Joe

Joe Damato (1):
  net/mlx5e: Add per queue netdev-genl stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

-- 
2.25.1


