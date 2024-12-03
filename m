Return-Path: <linux-kernel+bounces-428856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD109E1443
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C7A285734
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AF1DC074;
	Tue,  3 Dec 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Sual1XW9"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0D1DB37B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211076; cv=none; b=ogjbcMm4PmKdMXVGfpaI4ZpfsprOA0PBIK3aZhTM3aA9E0ooosUNzfTo6iZgv97AiFsBUrS/XqqhlCH9w4a4i2nBIONPIYtcwhm/C2LqaG2agjmoQBXabTUmdLNriIhPF2Pg7BfjlOdEMwXWFV9SFQrCtqM70tLhwWMwXlCD8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211076; c=relaxed/simple;
	bh=Hk5ke9nzypkJaxk8bCoKEHSofdwMIA0X2l10CVp/tS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQlc6xIBsexCrZVKzkAP5bcNWPCBX01WNL+u/V6IL0Q2ShS5NsXOE5ulsXCNw4awzT4GAtzxZcVVfbU/KhmQeqFS5B0Ls9ICrE2XMcabDut8i4O8IBJcqXGOFiG67+SwgGNGBW5F7+xp78Uv2ipCtut7iuKZWp56Ac+SanoBMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Sual1XW9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D34240C4B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211072;
	bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Sual1XW9VZaDPoADr+Z59NUqD4MCuqrdgobTZKXtFq+pRw34V1JGkKTa+cOrSWEzH
	 3yp81bDvCrYb0d8mRXBsAPzF+ZXsqRBlc/m54xOsgTQrSrYIuUCeZ1ew9eyQGtOlR1
	 f7ro3cRfW79HrkK3uD0KyvX+bZonYMvUqRd+ia6wjfNAaWUC8JBwSwteudwXFGHJYO
	 7OwxxHxmdRd5nUGHpHzuJw/G8Xim+N/61l9OP4cSjLpg7adrt7XilXNq33AP8pQIEk
	 2/lfwOK/ZAwhhl6cD993XEV0h9WMNRhnt2QrbAusc53bMMY8awze1z77i1l8E4iN/f
	 4u8WFP6i1l+Qg==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-724f5009c7dso5129664b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211070; x=1733815870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
        b=mt0GbCpEOhFB8i89rZyBb47P4ptWXrXzGHb4oDFtF/6UDGa6JlsNZMExRHUoEoXpHM
         f/lNrcWz2jMIWgKneg5JmhoIXx+qSoLh4FBQ5beNZG9BUDytU5wB/bN8maYRP8LgBOX4
         j8G+y6K+nS7rgUuk895xGLpia8/JfkqmUy0NPV4R0EgDjfdm9JE6CYURBEIxQ2UzOgtT
         egcmcanV7mUkOOphD6kIf5Ak97wlDn81oKyUU2K0ASsH1PzEh9kbBjtGFlcUflG0Rtzo
         tw8R4MSCKY/lVeg9bOB2qMA75YES90Pt2vsgRxgakPispK9oyreSCd9nJFHdULDtnEti
         y+hA==
X-Forwarded-Encrypted: i=1; AJvYcCXvfYgVLiT85DayOcJt11UYh6cctp8af9Kz9YRjFbegrLiSVZrRNmHTLyOWefSk2a3iLd0P1OX21Ake6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiL7QwLU/iNXyWL4+avwDHMqYn++3LZjkzP5Q0oKnvs1MKZmG3
	wRUjXp/PdU5bAupNlYZj+G7ldEkqWb6MkthOjSf95LJJAvq1g4WM59HvufoMmdpYWhW/ahQ9/O2
	7cEMIGdIkrtm93kHmRB15OVt/xmNHsV5RcNzca+QNWp/9EuIYwGIr/6iJRWTkTuodprY/OVMATn
	KUSg==
X-Gm-Gg: ASbGncvRb3Av3y9I1dY3QhyrOkHvSV0esg2s/xm4OuMoD6yfO0yt3qONZx/9z3jfszD
	eYSJPdsHoJAXt/GUgGO3zwVno23Yq7AEphRZRSc8lUmi7zE2ND2dp7T/HEp+bcbyZ19DwU8Nscx
	kOTKcz/cAkVrK9m/DdphTHkj4Hmqi19FBp5t5UwVoEokcqBDDhB+Pw0PxKhRebTNWk76aPzKfk7
	DV1g4KsklDwYfC54ig8PhESmenxYCsAS2YG8be3MHEtTXcn1hhA8v+9FFlJ71ubUQoG
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393835ad.15.1733211070590;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEND0UzhbAQRYul9CwlhlE8NsG8OZop+RaB8RyNyzhSiQjfU17kWK9qXqZeOdr2+snjte5ZcQ==
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393625ad.15.1733211070289;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 5/5] virtio_net: add missing netdev_tx_reset_queue to virtnet_sq_bind_xsk_pool()
Date: Tue,  3 Dec 2024 16:30:25 +0900
Message-ID: <20241203073025.67065-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d5240a03b7d6..27d58fb47b07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5749,6 +5749,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
 	}
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	sq->xsk_pool = pool;
 
-- 
2.43.0


