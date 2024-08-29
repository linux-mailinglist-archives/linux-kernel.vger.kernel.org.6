Return-Path: <linux-kernel+bounces-307248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064B964AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36341C23D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15041B3F26;
	Thu, 29 Aug 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wSpyoNFd"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CC4643B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947074; cv=none; b=f1GC2mA9v2VCdq3m8utt7sLOzR8hzyFANI+/SEiVoslBbNGJfbUfEkVE5MkCOOjjrxzIyDPTmb9Ntam/g53/0haJA3iCMv14NR7p0GCVi/0+7VZosI54bywfcPD1/CGQY9/qWfHw5/YIzIOraSX0w8FFZR+P2Ghem64S1fAtdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947074; c=relaxed/simple;
	bh=BjQzomJdfelQle+FoyKCfNVMJnt/w3H756pm8LAAsZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DExQC6MycKJ4mW5b7HDX3Gx3BRzM383hiAbydbfVAdktPHdQ2VqJyki83loEv8mclNn+IQVAZUyyaxN17adWGdd38oXEHJ6xykfLXkiHElekrCLo0u/GnMdAFqvo4QJRV9QyRYzPwIelHQ+/XTwikrz7HgxZSd1magw8DGV5cJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wSpyoNFd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7b8884631c4so325287a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724947071; x=1725551871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/41oDsZHfxhcl1cqUKA01PWjnJrjTcYi52+9QxRI62A=;
        b=wSpyoNFdEh10hAqmGC56DeP0G5vUzxzxB3mY5K4cg0WB1ONH9vvaczzDZLlITE2N6n
         GYDqf7y2rbYjeuQDmj6GAG/JIveq7pcHL2CWWqcpVuKYb1gfNI+wWvVlqNWwDgEF80dL
         TwljAMLA92vo/opYyrZbUcT5Jsy7DREYwpO1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724947071; x=1725551871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/41oDsZHfxhcl1cqUKA01PWjnJrjTcYi52+9QxRI62A=;
        b=DS4IRUJiE2MTP4uApqrnXvHdtmj0X0Bk1vlO1nWVN3MMXFL7E647/MP7BzLjsLrpof
         homjVXX3Xhjfve2U0cMpOAnlMzbofLHuctSNj4YjWqTo4I+C6VP7jsk2gF5iE3vK65Rc
         VR1yoQcZQAnBnnMDWDuuCw/lB4wRgPxHgcDt5Ahw+1ZlxIynQdm7Qx207+H2iKNTCkMN
         HLJ+U8+PqpaxNFwFGswikNJ8mnGfeJX8izoucNxCYP31cmRw3uPaBnGp50oRlRpDglAQ
         eC3H3DpRwu/P0H9EeLNZ318ANA6rL9xwsn2oEIqwzsFWhe4QjcdK6lEJhb6otgxSvHPq
         OrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCRIjRLriyn+xaQdEJYOvwNY7zPrFSvQtTz9jubQE6az1oecvfe4ZkTYij08yFgaFH9076bzwAlqE/ZYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAybs9c17j3Fp/HHM07szAAUKu25t/Tih/RGroohb/UefqFq1H
	luW3Ias9ieam1s8Ivzw3nSi1N8/r4H6AE3jIOI5NqQUdlMyE53zOu6Bo3HjgdNM=
X-Google-Smtp-Source: AGHT+IEN/5x5JumXpn1GxODDJHBpZA1fqwxshkNBrm3W4Pi55CCH9podw+EpN5OXTvwZkSm6rfsQDg==
X-Received: by 2002:a05:6a20:d8b:b0:1c6:b45a:df51 with SMTP id adf61e73a8af0-1cce1022303mr2371314637.30.1724947070902;
        Thu, 29 Aug 2024 08:57:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569dccesm1294592b3a.136.2024.08.29.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:57:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	edumazet@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] Documentation: Add missing fields to net_cachelines
Date: Thu, 29 Aug 2024 15:57:42 +0000
Message-Id: <20240829155742.366584-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fields, page_pools and *irq_moder, were added to struct net_device
in commit 083772c9f972 ("net: page_pool: record pools per netdev") and
commit f750dfe825b9 ("ethtool: provide customized dim profile
management"), respectively.

Add both to the net_cachelines documentation, as well.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 70c4fb9d4e5c..a0e0fab8161a 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -176,3 +176,5 @@ netdevice_tracker                   dev_registered_tracker
 struct_rtnl_hw_stats64*             offload_xstats_l3                                               
 struct_devlink_port*                devlink_port                                                    
 struct_dpll_pin*                    dpll_pin                                                        
+struct hlist_head                   page_pools
+struct dim_irq_moder*               irq_moder
-- 
2.25.1


