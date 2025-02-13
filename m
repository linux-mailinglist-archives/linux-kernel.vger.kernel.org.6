Return-Path: <linux-kernel+bounces-513763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A61A34E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8FC7A2EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E2245B15;
	Thu, 13 Feb 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jSL+kzgS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E0245AFB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474627; cv=none; b=mI1Wh+NiOEx3Ch2ANxAti+uoJYW5DQoHz+sBix7vCOJA8s9BvLzvP5ccD1TqHCLhalYRgQxdu/3Mgem6onAFbEn171xfOXKVI2cZ3C8+nCbhwsr58VTPs/MkShJ5CwaixVkpL3DdW3Kx+KbTDJO+wj0QdeIabvdpGcEgxNFrSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474627; c=relaxed/simple;
	bh=XZ4t7YDMmyW0H360rGPfx8xzyUYDQrQcvLa+/Cqmb6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aG9QraeIjwtqg0dp8WCsGlB3kvlw4sX7LIKBi5DCuzfTtHx9MeK/ZYFLyL4rHJPhRvtxJ2k9W7AsoHG6XxSwOhp5PFXr8kPCRIGo0t7lxQ0gnB8bsMBC+tLYO7yK2qQdHo7Vnxbef65KarvmhPp1/xIw+Pe9pDTUSgrSaWR0qqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jSL+kzgS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f48ebaadfso25661045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739474625; x=1740079425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22cbL28e3jVMFqgCD7R/zEeJKyuK240PgoQMhNu0RSQ=;
        b=jSL+kzgSGImIbKW1Vw4RKrJmCRqCSl0ELOeHfXR19CFr5AL7BkwMk30QprGFZBtkU/
         q1xnvJcenIVjXgod182tf+8GHYe1oOHJu7vxA8J6B3tRzH16ri6EWc545AIyj2/3Xbb4
         8MOTsGlZ5Ynm+CpphssgM0BLYsDOtzBMzvWus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474625; x=1740079425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22cbL28e3jVMFqgCD7R/zEeJKyuK240PgoQMhNu0RSQ=;
        b=miN26Ic/BgCaa5XtxnGVwVgUjfY95CWWo4LlPZ4+yEi71AHgkrM9jGwWAllH3bg1nB
         7fj53rsrawOALUpVqjSzIm39sjXZ/O827B3sSQWNdGdle6MBQ54Rcl4kFqRBhNGosLFp
         MS1o2TU2mQk+iHPKAqfszn2AuoMFP8FjCCuxjRVgtk+zaIes7UIm4kExrZYr4P1ez39/
         xAWgCni8HMvj3/3c4jp3xsJm16zFwMQHzC4R8X43pqyS4CKKk2PtIog/wm1/iiMhICX5
         n+AAfdENf5nRt6hcluKVpY/wkglA8NwuzMyJ950Gakh9ahcyPijWxaLGCn8s0Zo/WaUq
         RHrg==
X-Forwarded-Encrypted: i=1; AJvYcCWHW3sQHEFowiLDNqqgeihwYl9pLVVgbgnx6nddYzOPfLOXMPo8HK4Wq8egHGasEfxWSAhw6QyNBzLYm84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfguBRc/kGAcxfRqeeP5F2EZCUuS8d/PXIXSsVop6g46/mK+Ya
	l6xwppSm/OJ5R+jMb1jelKr/ea1HG9zgtumClgQ5mgg4sKPXguJj6yK/YQV9TtQ=
X-Gm-Gg: ASbGncuOfBw2DBkBWIRuJSv4bo66OilmGCY2POHVSJyM+MMUrrhuzZ3J6Q2l9ZXgZTh
	Wj8gY8lMuBtcTxUVosOgtSG2X1SKFZvkmqAuyu9pBZ9f8C5YN3giT2InjYlfY2hPpzeFTJ9bZMn
	M/YrplMLMW2CZ9W5xjGaacCGxyaXXolnh1J+7XoyAI8Qn6KAELQoZ0xbFNzct/XSxgAIUKK5qUd
	osnA57AZEGUdA66mpRI0aiXtGco9Jd3IJMFmL/C0XxMSilFfqy6gY33YOH5REH+2Pm+hY2fWcS0
	aJuaTEBk3yLq/ixyoYM0IsA=
X-Google-Smtp-Source: AGHT+IHZc5SoZ0BXLgoQWzTdXYHR4ogeNdyuZae400riaRaLv+OdINiEzNPB3ieePSR8Lo6QiUZ+TA==
X-Received: by 2002:a05:6a21:394a:b0:1ee:69db:b0c5 with SMTP id adf61e73a8af0-1ee69dbb21amr11057124637.31.1739474624762;
        Thu, 13 Feb 2025 11:23:44 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568a9esm1633458b3a.45.2025.02.13.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:23:44 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next RESEND v7 0/3] netdev-genl: Add an xsk attribute to queues
Date: Thu, 13 Feb 2025 19:23:10 +0000
Message-ID: <20250213192336.42156-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

[Note: RESEND because apparently my gmail oauth2 client is breaking
patches I send]

Welcome to v7. Added CONFIG_XDP_SOCKETS to the selftests/driver/net
kernel config in patch 3. Updated the xdp_helper.c to return -1 on
AF_XDP non-existence, and updated queues.py to skip the test if AF_XDP
does not exist (but fail in other failure cases). Tested on kernels with
and without CONFIG_XDP_SOCKETS enabled.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v7:
  - Added CONFIG_XDP_SOCKETS to selftests/driver/net/config as suggested
    by Stanislav.
  - Updated xdp_helper.c to return -1 for AF_XDP non-existence, but 1
    for other failures.
  - Updated queues.py to mark test as skipped if AF_XDP does not exist.

v6: https://lore.kernel.org/bpf/20250210193903.16235-1-jdamato@fastly.com/
  - Added ifdefs for CONFIG_XDP_SOCKETS in patch 2 as Stanislav
    suggested.

v5: https://lore.kernel.org/bpf/20250208041248.111118-1-jdamato@fastly.com/
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/


Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 +++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/config    |  1 +
 tools/testing/selftests/drivers/net/queues.py | 42 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 98 +++++++++++++++++++
 10 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 4079918ae720e842ed7dff65fedeb9980b374995
-- 
2.43.0


