Return-Path: <linux-kernel+bounces-376689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487039AB4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347AEB22AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0451BD01D;
	Tue, 22 Oct 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lYMHoZpt"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D941BC091
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617727; cv=none; b=Ub/RPaeCpOsTEDSNUwBxe5m5hJsPf+2eVkF8qrIlvjHgJw2MIwTgeoQZ9ueoTxcPir09zh68xUs/Kb6ckAxwe78ZM6vXQF1nmfnD9drrZvp6p4vhJ03IC6M7LQmnFdEIOrmCNnTrDR4E85uiMXZsklob1wJaV0LaB2B4+JDCxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617727; c=relaxed/simple;
	bh=OiDDIHpT2Xdh0k+qmCrDwsd569OKflkV8nkSlrYvHiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2RwFl+4IiiRNjau8oR1bSAAwtXru7mXfwXqAuViYDtwAaEuhSNqtgw0jfTZiksjTVbaFFTCMOtA76ZBLRlcaNz3hOFWRB6lEV/fKETIdjTJVw87mHVJ8sC3G2H/QSNNDeYx39tSaXETTrM1KKpZ/yDRrR/nr7YpLFqHvFqM7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lYMHoZpt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3773281a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729617725; x=1730222525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/yu90JKxIvYVAES8/y9aMQqFtx/G5adkU7FKzvOKDI=;
        b=lYMHoZptjaSB93GcW6nskzz/RcHPxSfVtN2rmUuQepcr3C3B5nJyZYkc3Nm5Jb7+H7
         tqC6ikRs8pWGP54jJki/c0bFA5G8y06JM1hID4RsgBnDAL7+unDJjea6BBcU/3sEBvVg
         uJDVHLjRVP3kHm4+j19KE/NUrifcBWpCMnp8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617725; x=1730222525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/yu90JKxIvYVAES8/y9aMQqFtx/G5adkU7FKzvOKDI=;
        b=Uyk1QEB7zjt+8JOTJxUz1QYsTxgoWCYHNE7AD70Eccq0bJxL2/B25Hy+xaAvkWF+YO
         bNRnYxnC8BrV9yATh25oO3HQ0WA4VT9hg+qbMf9Yav1XZ8i/UzZD6KJpkHCH3j96NqXF
         RzHP6py+zFYFtg8tezG4+cefYBPaRJ7qBiTP2M8YXpUVYDr0xyWiAGD9cg8ewB0yh3Hb
         wCN1GEzKGjKfNggn8EH0cFyO1FWg8QeR+HeSmY0EI+YFdD8ALV00vTyGSUZWTPr7MZqt
         3u5DyJR24eLMXkicxPQ68+oWfVKWYPtq40bZOypbT+mXDxZoa20KZcE5Rcaa69OEIKXt
         D3vw==
X-Forwarded-Encrypted: i=1; AJvYcCWudwc+1jwCzdG1n84xp68D5DYy1siteyVTYDqobu2sIeR00lWp3aKKr4q6eigCmaHMRpxXyhprTJwNtes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vpo3DbdhD7KJ89ppx2kxlrKit/nSFJzNtHBa+ml4GE+355zb
	MLj18FSpssVYlzHZd8dsBYFGJq2G1zKiWnYh+b3JyoN34TVDGxxw8Ow4yr5g/wmDd/d7tOGKsvS
	y
X-Google-Smtp-Source: AGHT+IFoscgRZXyWJoFNIakBUIwR0JZ7fFN+IsSWlUCwVl6IWGkO6L9ICGQVPDsONQX1Dqx4Xkvvlw==
X-Received: by 2002:a05:6a20:e687:b0:1d9:1d2b:f1e with SMTP id adf61e73a8af0-1d9775d0a49mr343690637.14.1729617724690;
        Tue, 22 Oct 2024 10:22:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13128c2sm5017974b3a.33.2024.10.22.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:22:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: dmantipov@yandex.ru,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC iwl-net] e1000: Hold RTNL when e1000_down can be called
Date: Tue, 22 Oct 2024 17:21:53 +0000
Message-Id: <20241022172153.217890-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.

There are a few paths for e1000_down to be called in e1000 where RTNL is
not currently being held:
  - e1000_shutdown (pci shutdown)
  - e1000_suspend (power management)
  - e1000_reinit_locked (via e1000_reset_task delayed work)

Hold RTNL in two places to fix this issue:
  - e1000_reset_task
  - __e1000_shutdown (which is called from both e1000_shutdown and
    e1000_suspend).

The other paths which call e1000_down seemingly hold RTNL and are OK:
  - e1000_close (ndo_stop)
  - e1000_change_mtu (ndo_change_mtu)

I'm submitting this is as an RFC because:
  - the e1000_reinit_locked issue appears very similar to commit
    21f857f0321d ("e1000e: add rtnl_lock() to e1000_reset_task"), which
    fixes a similar issue in e1000e

however

  - adding rtnl to e1000_reinit_locked seemingly conflicts with an
    earlier e1000 commit b2f963bfaeba ("e1000: fix lockdep warning in
    e1000_reset_task").

Hopefully Intel can weigh in and shed some light on the correct way to
go.

Fixes: 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..9ed99c75d59e 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3509,7 +3509,9 @@ static void e1000_reset_task(struct work_struct *work)
 		container_of(work, struct e1000_adapter, reset_task);
 
 	e_err(drv, "Reset adapter\n");
+	rtnl_lock();
 	e1000_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
@@ -5074,7 +5076,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 			usleep_range(10000, 20000);
 
 		WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+		rtnl_lock();
 		e1000_down(adapter);
+		rtnl_unlock();
 	}
 
 	status = er32(STATUS);

base-commit: d811ac148f0afd2f3f7e1cd7f54de8da973ec5e3
-- 
2.25.1


