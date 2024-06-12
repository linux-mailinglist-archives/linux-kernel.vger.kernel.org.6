Return-Path: <linux-kernel+bounces-212191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AC905C87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493901C20E50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77084D0E;
	Wed, 12 Jun 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hePXFIG/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2784A24
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222971; cv=none; b=SEoR3KpURu9pKcy1CldDm8tKb//dwsrnydTF5OMqlawYglyFXgEMg8a5PqX2ItvHYiI2j5sW50CipmQXSz6ikcKRxtizgEAAd/OkE5DU3A8SOywsaTm/iUoheZL44mJ74pmgrWxKR9WLDYuE0InfLtCkE0pb5r/zAbDlMNXHYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222971; c=relaxed/simple;
	bh=pjCXodUhtxmWb41Etgjz51Do82AcSjr+8z7OY1hLmqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VX8DTqq1LOgB/CWdzTj/gFUuhc9XK+uiuljetIB/YjsrWr9TOzSbMsLDCDKnhy8Id3RXZj0w1ABxt5qNaDruOGHM+KorAfac3dHR0qEm3VL1gfXwzlMZU+8M3M0c8M0fgbomdtx+2TFvIwAsgQHxV6c7TjrLfxku2yDKVzUBwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hePXFIG/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a0050b9aso2723845ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718222967; x=1718827767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFCSUEuOc7PYLEVztBtSCQ7FgudHj211hYNWDBeSXM0=;
        b=hePXFIG/c7zp06V5M0pvnh1Wv3OdomYhgaKxb4Jub61Ursp+olwJEEZ94NEvUnaTHE
         obprdw52Vwfe1/X8l45NcSMhubsVtSdaVZvG9ZfQf6GTgApCtZgh1kZcB8RaBUFjwxHk
         VW7G2neCVhLUpvI9jkqtXpmuxpFg2oIUSQq/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718222967; x=1718827767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFCSUEuOc7PYLEVztBtSCQ7FgudHj211hYNWDBeSXM0=;
        b=aCOmsKh3znIBNQ76oQe7zaB/rlfsdotiVFsMwh1CzyC3daerKBx1arW6fUYYo2gfsx
         49E23QyYglrEwI3UQ1rEe0Khj1mPueOW5w9ordLU8RXNbAUBfMNPEP2tk7l8ZW6XBtTd
         qcwdw9MZzNqdbaasAw9yOyg1U5kLMcU+22smgnhHydZcgU7Ks7Azm3d+5pEFcxJ5OsaL
         pT4q6lB6GVQJZqhg0/l45Y/XiKVgvdrVg8S9lIFes5LIL3hVyOQOoBgcENHSSfHOBWsG
         Tc6I7dlxc+zIvyh3rVjSsLmixoqcPNjIhcC2N+OGhTi3c2XLRzawZurSA7w5sOZKuQdb
         /WpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2+If7XqLkO4+k5enJaS2+JqCS7kurlxKSiDMQUu5a34HlZA7LxgEjwLWUHdBPhQX6SRRSdo2N4ChP4gf+fmgDJiiaJE8eKA7g7XhD
X-Gm-Message-State: AOJu0Yz7I2eGV7rouzzlq/cSA8Nq7Kl6hifw6/jIA7XoDre53fPJu7/K
	Ch1xUXTRn1Nq1NA9NLRAzoZfgz0kYsoBW/x2WwYe7B30XjEJ+A6VB8oFyT+v9SQ=
X-Google-Smtp-Source: AGHT+IFllsrfnFbcHGbdPHlC3Ckjq18XG3+qik6ili0ccxfs28FRyFDY3w/qmLQJMuVEFPHcWrk54g==
X-Received: by 2002:a17:902:b683:b0:1f7:1ba3:b93e with SMTP id d9443c01a7336-1f83b569cdfmr26988015ad.21.1718222967431;
        Wed, 12 Jun 2024 13:09:27 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee3d5a17sm91506805ad.146.2024.06.12.13.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:09:26 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net-next v5 0/2] mlx5: Add netdev-genl queue stats
Date: Wed, 12 Jun 2024 20:08:55 +0000
Message-Id: <20240612200900.246492-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5.

Switched from RFC to just a v5, because I think this is pretty close.
Minor changes from v4 summarized below in the changelog.

Note that my NIC does not seem to support PTP and I couldn't get the
mlnx-tools mlnx_qos script to work, so I was only able to test the
following cases:

- device up at boot
- adjusting queue counts
- device down (e.g. ip link set dev eth4 down)

Please see the commit message of patch 2/2 for more details on output
and test cases.

rfcv4 thread:
  https://lore.kernel.org/linux-kernel/20240604004629.299699-1-jdamato@fastly.com/T/

Thanks,
Joe

rfcv4 -> v5:
 - Patch 1/2: change variable name 'mlx5e_qid' to 'txq_ix'.
 - Patch 2/2:
    - remove logic in mlx5e_get_queue_stats_rx for PTP. PTP RX are
      always reported in base.
    - report PTP TX in mlx5e_get_base_stats only if:
      - PTP has ever been opened, and
      - either PTP is NULL (closed) or the MLX5E_PTP_STATE_TX bit in its
        state is not set

    Otherwise, PTP TX will be reported when the txq_ix is passed into
    mlx5e_get_queue_stats_tx

rfcv3 -> rfcv4:
 - Patch 1/2 now creates a mapping (priv->txq2sq_stats) which maps txq
   indices to sq_stats structures so stats can be accessed directly.
   This mapping is kept up to date along side txq2sq.

 - Patch 2/2:
   - All mutex_lock/unlock on state_lock has been dropped.
   - mlx5e_get_queue_stats_rx now uses ASSERT_RTNL() and has a special
     case for PTP. If PTP was ever opened, is currently opened, and the
     channel index matches, stats for PTP RX are output.
   - mlx5e_get_queue_stats_tx rewritten to use priv->txq2sq_stats. No
     corner cases are needed here because any txq idx (passed in as i)
     will have an up to date mapping in priv->txq2sq_stats.
   - mlx5e_get_base_stats:
     - in the RX case:
       - iterates from [params.num_channels, stats_nch) collecting
         stats.
       - if ptp was ever opened but is currently closed, add the PTP
         stats.
     - in the TX case:
       - handle 2 cases:
         - the channel is available, so sum only the unavailable TCs
           [mlx5e_get_dcb_num_tc, max_opened_tc).
         - the channel is unavailable, so sum all TCs [0, max_opened_tc).
       - if ptp was ever opened but is currently closed, add the PTP
         sq stats.

v2 -> rfcv3:
 - Added patch 1/2 which creates some helpers for computing the txq_ix
   and ch_ix/tc_ix.

 - Patch 2/2 modified in several ways:
   - Fixed variable declarations in mlx5e_get_queue_stats_rx to be at
     the start of the function.
   - mlx5e_get_queue_stats_tx rewritten to access sq stats directly by
     using the helpers added in the previous patch.
   - mlx5e_get_base_stats modified in several ways:
     - Took the state_lock when accessing priv->channels.
     - For the base RX stats, code was simplified to call
       mlx5e_get_queue_stats_rx instead of repeating the same code.
     - For the base TX stats, I attempted to implement what I think
       Tariq suggested in the previous thread:
         - for available channels, only unavailable TC stats are summed
	 - for unavailable channels, all stats for TCs up to
	   max_opened_tc are summed.

v1 - > v2:
  - Essentially a full rewrite after comments from Jakub, Tariq, and
    Zhu.

Joe Damato (2):
  net/mlx5e: Add txq to sq stats mapping
  net/mlx5e: Add per queue netdev-genl stats

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 143 +++++++++++++++++-
 3 files changed, 155 insertions(+), 3 deletions(-)

-- 
2.25.1


