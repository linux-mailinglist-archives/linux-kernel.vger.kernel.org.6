Return-Path: <linux-kernel+bounces-534661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92234A4699F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F6018876CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A72397BE;
	Wed, 26 Feb 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YF3h5NtH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F752397B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594010; cv=none; b=KXvASkbJU2tGDkhwEsP+CVKyV5Yi7CRmmeJ3wwwcpmwPwX5vnF3jWwzpCwj5nTTGOnB+MjVejepJNc88Ur8b37tHEosZVcDl0ZUFJPKePSCB97c6kUmbK96eWmn3S6ZasU/c2mjYo0sXe407ojpVTG6hPNz13yK+k7yx2X1zObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594010; c=relaxed/simple;
	bh=DENE5vGFyvr8fm4PtMAf1uR2PuyTsCbmavM5sDeKQrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1XP235pT9NbhdyYir13TUkwfqbjs2ltjgObYNuod0PQ+i+iK5yjCd6q4vkv/Rqs0XbDTVFCs/rsr4p/ehHfaXsW9SD2LmCtG8r+W8OUC5ioIgAjfJ5ow7iwA9eMRX0KjxVu5j3dBPOWhdOSXaMd5xN+BDu52+SNJAJkmNFwwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YF3h5NtH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso722795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740594008; x=1741198808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/u8Rfl3i4s63180zjFA0r/u7AlCwmzDwo9m+X1pIOk=;
        b=YF3h5NtHYzuTaYKbm5nKqLq35g3pPEeKpNLmz/TPg5Sx/pX7r0bKyRzSkQ2RL+DQMk
         87MID0B+sA9jk6+SdWX1DyqcNhIgWeQoOFJVLNqOUG7b2bv01u86SFHaPoDUZD0k53Gi
         BeRxxNeTw7IfLdnoyTDv5e8hj1zH76PgEE30g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594008; x=1741198808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/u8Rfl3i4s63180zjFA0r/u7AlCwmzDwo9m+X1pIOk=;
        b=NJRDknTLiNiAUQl4hKnrkohu7vbydQDRIzX2SregN10bI2M8vS8gRFGtVf08Z7+45J
         h7Jupc6VIy/YLKF+en1lEKd/FXVJVM4P/KuJELOOBJD5Uw2k3QuudJxKIDhw46P8mQi2
         8aRF5b/Ll8CSy9SpvCl8+3vckD3RHg12/lCM68GhGyuskItlR85aBOA3f0Q9gVvj4PJo
         QUeox5bBBWS8wastyde2TwNPdOcG6EIij3fonQ7jsjM5bLLvUo5y3yuL7b8zRd4h3kIJ
         tjdnkZh0OSTU77CTYSXoLAyxnUf7KdSppu7ts4V0SmWTXD09OtM6THPLmrOzV1Jea5TK
         KHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9bj4qmK5+xKkI+UOYTjs/KRje0W+njycV7+wX8rMfUsHpbLA3KAvRf98GeYeL3XOnmMp45kcWASDvuYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDR99/4KJE/bRiB1XGamBvZG3weXqLlZLYby6V4pFiLZqpkMf6
	5634NL/C++O+YPAkgcFbiD6UVwRLwCbyRpxxGRw1wRfhdiMg5R0p+p65dSkr6p4=
X-Gm-Gg: ASbGncst518n+anOyZu3pdZBGP06E58ZQWlKeDUSvvUQsBEr5YqvaCLSIxLM1MA5/l0
	Alc9UL9P+m2hMZFPCdpLY5qBRDysaZEiGaSMwV9VKKsmwt37c087c7GwtzuBeJ6s4RIGe8YGlQb
	cGeD9cH0glju3lngjsv7Ldrm06VQ6sGL8F/udDVPMzF3jtDN46ekVTWouqmhRpDzeDF+V5NTxLS
	vQ210e1KGh6LPz0djzKhzhC6DZ26jTESYwj80YawfM+3zPNIfcmtm99z8IyunF+HlgrtcfGVPZt
	7kwfqFg1z7PASLPIuwew5qDqlKZ8UA5i8w==
X-Google-Smtp-Source: AGHT+IGQ9P2db2MPKQ5jkTyBVTvjGT02yCN10YbMc98M7tyiK+5xNGCagd2RA27I5P3r0Yg5QTQssQ==
X-Received: by 2002:a17:902:e54f:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22307e6b74emr119351795ad.39.1740594008395;
        Wed, 26 Feb 2025 10:20:08 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a72f131sm3840749b3a.76.2025.02.26.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:20:07 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: dw@davidwei.uk,
	gerhard@engleder-embedded.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] selftests: drv-net: Check if combined-count exists
Date: Wed, 26 Feb 2025 18:19:57 +0000
Message-ID: <20250226181957.212189-1-jdamato@fastly.com>
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
 v2:
   - Simplify logic and reduce indentation as suggested by David Wei.
     Retested on both tg3 and mlx5 and test passes as expected.

 v1: https://lore.kernel.org/lkml/20250225181455.224309-1-jdamato@fastly.com/

 tools/testing/selftests/drivers/net/queues.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 38303da957ee..8a518905a9f9 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -45,10 +45,9 @@ def addremove_queues(cfg, nl) -> None:
 
     netnl = EthtoolFamily()
     channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
-    if channels['combined-count'] == 0:
-        rx_type = 'rx'
-    else:
-        rx_type = 'combined'
+    rx_type = 'rx'
+    if channels.get('combined-count', 0) > 0:
+            rx_type = 'combined'
 
     expected = curr_queues - 1
     cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)

base-commit: 8d52da23b6c68a0f6bad83959ebb61a2cf623c4e
-- 
2.43.0


