Return-Path: <linux-kernel+bounces-558357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDFA5E4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1309117B565
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E405258CCB;
	Wed, 12 Mar 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XKBh4GFt"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF21E8823
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809120; cv=none; b=VCw0kIDjxx91xL5Mw6rvokkxEr7gTu8JyBHn9fH+vn2LqzrSa1iiyNg7u3CgzQ1ZjnREzFRLieH28COl2o1B1A/XMuxQsT+ifGwdBtvxbO58/buDgp83HdNwUeBWP4PpiO6rSwWQIn5qOTIfZVpQKULhvHZpXPSaWvckLU0r2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809120; c=relaxed/simple;
	bh=Q2k9GPayWeUHQsXcs/86RclA5d1uasfKBhsFAaw3N6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L8PSV2dDzArl1226gs4E0anFNyDosEJ3z7B28dPe5MS2GL+j7q2su0wOvsXWDXznfnhe4W4flLZyUSc/Jgz9WB3xbmGYuJSwOfLoILi88lHXlPtgw4MrGWjOFMtaLmG0os6m0j+snPoMesrHlbfSlbnTTTE/3D2NHit6Zkh9LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XKBh4GFt; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2254e0b4b79so6064275ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809118; x=1742413918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=XKBh4GFtQCYph1TcPaoHMx/aS0kPOPGy2bz3gEQfe7/Am5jsZSqu2HIx3lm3sN8Qbt
         BYRTRqeMBEPJhg7bbdHL2mmOfojYsV05s56KcpqY3N/MvjMKvVs4DxzALnDYb3wPOZiF
         /hO3Bpn0YmPt0Svnob5N9iwjmB23DFfA8Sqf0AkOhvS6weuCK8DyRDm4PG/5cPs0loMu
         CExrPDjVbwwbtJ+jAF1FDm5aMzQQRpGvIKNv1jMji6zdVC7eqXQbDdCjBlKT9fgVWrng
         tIiNshqy5NTKtRLmcb9WpqyryGmzqhFBMmu1CYgdyUkiZmSP6K6YaPVUSPy49ewEfoln
         NYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809118; x=1742413918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=s1tPxHuF/d4G3aA9C999zYUKAmqKmdhXSMOJ0SSU5wN9rwLmQXK2RZs6pCGMlKFMOR
         xPUF/YewL2UUIO5zqwfi/IHs0JnNM/BLoKn7byTieUx0hnyJmX8aR9Zh3IBtRPjQjmiG
         jQKOsQne5nyRc+Ja/fi5SknXuI0ckp9uoRs3RL2fUIshHKI1yhmAG17k8s+HvKiYLA4p
         uogDBdEicgkVW8iTuGcj7c04SK1S/PAuID9cPS47PQ2b+wb1n/q7Zn3weURDiVwKK+Cv
         5PSKCvS3290BJo9Y0fotvhExjOC53qoMZlinD1RZ0YQTeOne6XPz2EwugOhRNhsW4dK3
         9nTA==
X-Forwarded-Encrypted: i=1; AJvYcCX01qkx+kG6vTzDa29LRqJqyw/lW6XWKWvKHWNJRoLCjZkAr9ZCLbxiuXrgqMvp839OQp/x+ifuNtDjvBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfboRTH+Wahs/88a/RlKkuJStqvuIzdnKNWdaD9zqiz57dIQkq
	XA1JHMQ7YP2TBkaJHoBApgmBRGCW5JYrMpm0G/jiFEwrfCTKVMty3MzYos1yTsBpeFpVxfAlnQM
	kZ3DzuU1M+MVhlyx9wjlQn/hNXXq0IdqSMzOxBXo7ypGtYlA+
X-Gm-Gg: ASbGnctGA34aqL3lb9dYnt+crqvNcUe+LxWUwOSRvJPO71PGBPjWUKpbstv9opB6Iyx
	NNLuhBYYagz99j+tc/XVMULRu1y/YUl/GZo3Kh5m8yEddR4j7LAeMp42Rb3PdmNVGT+ZExz2m73
	z90DTXp/sW7byiZhy+zvCohvo1q9n8Vh3Ml6kQ3TMkJmASekR6L9kixKk65gKlqwA7qv7l85R7U
	Ykq0JuZbYvhaFgV9SVvSvOHRXX/EeeL4iWm73+T5ketLLVQ7GqRBIiVCh0AwxVcgh9+RdPVrJJJ
	UZ5nM1ks99j+mAs8FFELq8wbCSbwOwXxlek=
X-Google-Smtp-Source: AGHT+IFzTFpDmJydmC2PtlCdpNTNUDU0mgSO+UfsIg00y4eEivOM8oFExNu431q+A3hE23lAesqPTs6l6uBP
X-Received: by 2002:a17:903:283:b0:224:194c:6942 with SMTP id d9443c01a7336-22428bded4amr373642295ad.34.1741809118152;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-736c8d701absm632789b3a.12.2025.03.12.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3CF97340328;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2C718E4044C; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH net-next v6 0/2] netconsole: allow selection of egress
 interface via MAC address
Date: Wed, 12 Mar 2025 13:51:45 -0600
Message-Id: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHl0WcC/23NTQ6CMBAF4KuYrq3plP6oK+9hXJQy1SZKSYtEY
 7i7IyuILF/evG8+rGCOWNhx82EZh1hiaimY7Yb5m2uvyGNDmUkhtZBC8RZ7n9qS7siVNyBQhr0
 Fz2jQZQzxNWFnRnd0++rZhZpbLH3K7+nLIKd+DRwkF1xj0FjrYIQ2p+6Z8Td1V9z59JiwoZoDe
 gFUBEAlXQUBLBwO64CaAWAXgCJAeLMHj8ESsg7oGSDFAtAEKIcuOAsN1uEfGMfxCzHJLj93AQA
 A
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Simon Horman <horms@verge.net.au>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v6:
- No changes, just rebase on net-next/main and repost for patchwork
  automation
- Link to v5: https://lore.kernel.org/r/20250220-netconsole-v5-0-4aeafa71debf@purestorage.com

Changes in v5:
- Drop Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr from this
  set since it has landed on net-next (Jakub Kicinski)
- Link to v4: https://lore.kernel.org/r/20250217-netconsole-v4-0-0c681cef71f1@purestorage.com

Changes in v4:
- Incorporate Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr and
  use it (Jakub Kicinski)
- Use MAC_ADDR_STR_LEN in ieee80211_sta_debugfs_add as well (Michal
  Swiatkowski)
- Link to v3: https://lore.kernel.org/r/20250205-netconsole-v3-0-132a31f17199@purestorage.com

Changes in v3:
- Rename MAC_ADDR_LEN to MAC_ADDR_STR_LEN (Johannes Berg)
- Link to v2: https://lore.kernel.org/r/20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com

---
Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  7 +++--
 9 files changed, 61 insertions(+), 22 deletions(-)
---
base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


