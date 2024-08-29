Return-Path: <linux-kernel+bounces-307725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F344896522A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791881F253BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3901BB68A;
	Thu, 29 Aug 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CyDRL4IO"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA351BAEDE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967575; cv=none; b=fWOJHwkuUDdC8EapeG6V4jWhXAdrTA83LyhT7WqKwf0TmU31BHwKmdD1rZhvfBw14pCG+bJrZNhRkPbrPxVnNdbhLt8O8Qp+tiRR39JJh9XSNMtUt7rM/dMC1Ax/qwhzaQ8tXlzn2eiZgT7NPf2+KzRBOikYveAi1mS7TQKA6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967575; c=relaxed/simple;
	bh=5coYfGmlbLfcXMH6XIf4TkfjElNN3WfWw4tJsnYFe/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SHfCYhqr0bfDC/VLlKSUoTbvLofX4ymR/ivi0feh2JahKC8voIl+/yhb1WTN9gNnOGf3y5dtlNKvhGGN6ApsviwYrEy28MF6VkQADNNVtjYAccCDipZM0e/XfduJTTKnulOP3c0RcS1apyIjCBqIg5vUMxkZgMiNmC3HQyETtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CyDRL4IO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cda2695893so479714a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724967573; x=1725572373; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbqFYO4S9FnSUAynAY079AtZQYGTY3VQrABnLRjrCmE=;
        b=CyDRL4IOdgI5M8sp7OzbLvcroSiouMEVIXxWK3KnEO87WPCC4jVtQI9mAo+1j/1642
         FEEyrpBB05gQ4AGfcBOTCh71iH9QL8IwgqqnH3xpM3eKQ+xdp+yRSamQHeD3HPtX0cmU
         X73W3awGSALh5Iar0yfVl8dfanwCSqgXl4Rfef1taUoEEA9TOEOKSjXfxG7NmJ0zf0sS
         xABe0wFMvwKYH+GpmoxJX6wFknCtZuCmKi/Zrpuc8/nkWNviat1e3ZZtRrURJUSwHNuC
         uTPpOu5LizdKhn937wm2iD9aSOm7B9kmKYRV5CX9xYS2ItlV9B2QL5vKG3FneC/7VJ8V
         6xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967573; x=1725572373;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbqFYO4S9FnSUAynAY079AtZQYGTY3VQrABnLRjrCmE=;
        b=gudv02AuUFG+K2FlfzSoOfC479viODTCyaaPEKbWlMYZ2TRMkZ6sq0CMkLH4t/5DaW
         G9dUx6gK6pph+OKnMEUiqd0YuMXbKQ49Kq2+8vEhQtofIls546Ir5n2BxbTkvw54NYHN
         OZP+5zYWjDDwndLUxaaqI5jGdvqE7MeltEQvDJt6P9D8bSzJ6GRFQPSC5+DjEgf3Rk78
         bivEFu3dbN6SsH8nZjmhuQZoLRBF9dN/8+i5nlLnZddPXDm1vVXdeh0qqC6LQzccWUFd
         uDx3JHv0AdCBZbVtXVAvzlOl4EtZqEIvZhCVmxNGO8VVyWJ2FxHjWyPEhMys78mdacCh
         3vgw==
X-Forwarded-Encrypted: i=1; AJvYcCXgFqh3YmODGw9Mp1OgCLitz/p5sRTwIjxXddPtVQNNszD/KS1/M5mS490a24uw/Rxd+78yUsCAMB/U/Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZqJcX41TeiWrj0An+75wTLkD694nAX7SQGWBOqF4cauKr9iy
	4cpwTUrhlxAFO01JObpvmYdsPezU58tgWaVbMt9mLVk+iZSWBRBZh5+LjxJvl/g=
X-Google-Smtp-Source: AGHT+IHR2w4OGAv/4/hiYv8y+H+KUXzbVnmmVE1/lO3+LWfdUlvYwk6z3NOkhEuvbC5XvYuZLd7lZA==
X-Received: by 2002:a17:90a:984:b0:2d3:c5f4:4298 with SMTP id 98e67ed59e1d1-2d8561a1546mr4634297a91.13.1724967572711;
        Thu, 29 Aug 2024 14:39:32 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d84462aec5sm4705298a91.32.2024.08.29.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:39:32 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] net/mlx5: Added cond_resched() to crdump collection
Date: Thu, 29 Aug 2024 15:38:56 -0600
Message-Id: <20240829213856.77619-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829213856.77619-1-mkhalfella@purestorage.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Collecting crdump involves reading vsc registers from pci config space
of mlx device, which can take long time to complete. This might result
in starving other threads waiting to run on the cpu.

Numbers I got from testing ConnectX-5 Ex MCX516A-CDAT in the lab:

- mlx5_vsc_gw_read_block_fast() was called with length = 1310716.
- mlx5_vsc_gw_read_fast() reads 4 bytes at a time. It was not used to
  read the entire 1310716 bytes. It was called 53813 times because
  there are jumps in read_addr.
- On average mlx5_vsc_gw_read_fast() took 35284.4ns.
- In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times.
  The average time for each call was 17548.3ns. In some instances
  vsc_read() was called more than one time when the flag was not set.
  As expected the thread released the cpu after 16 iterations in
  mlx5_vsc_wait_on_flag().
- Total time to read crdump was 35284.4ns * 53813 ~= 1.898s.

It was seen in the field that crdump can take more than 5 seconds to
complete. During that time mlx5_vsc_wait_on_flag() did not release the
cpu because it did not complete 16 iterations. It is believed that pci
config reads were slow. This change adds conditional reschedule call
every 128 register read to release the cpu if needed.

Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 6b774e0c2766..bc6c38a68702 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -269,6 +269,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 {
 	unsigned int next_read_addr = 0;
 	unsigned int read_addr = 0;
+	unsigned int count = 0;
 
 	while (read_addr < length) {
 		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
@@ -276,6 +277,9 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		/* Yield the cpu every 128 register read */
+		if ((++count & 0x7f) == 0)
+			cond_resched();
 	}
 	return length;
 }
-- 
2.45.2


