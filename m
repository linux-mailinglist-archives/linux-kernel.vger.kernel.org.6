Return-Path: <linux-kernel+bounces-185166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802D8CB179
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92121C21698
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A5147C85;
	Tue, 21 May 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItcG5UDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36091144D1C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305711; cv=none; b=dl6Y4agPWDTtpdlRJqM0SfrIYbFAwRhbxCy50SI04c6AndW4WJiY1SmqLVoomvvDH3gR6wMl8tJFtsUSDhgN7yoptoP2pVFQxZ/qYqafRRDy2+UNxMCE7bgMcyXG5Ma3a9DjjUy6v2LkfTkANMajuW4ZNx/n+zW0ib1MDX0kEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305711; c=relaxed/simple;
	bh=yNK90+Fu3/Egv6BUzfR2b4UhSJudcMdn2qAYCS/ruB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEJeDT09qEdc7yLoTd2yOwwXe3aB0i/SBZFTrQaGHtOQxJFNH+HoQriP1sjJYVQuzKuPGT3RExThFdq3fdzPWbFhn0cJF6hPLEyzkk0VKHhxAgnCn/I9IAeidDw7q2koP8CEnHSp7/FugogZ9kjRWqAO8+IixBVhWrgN4I2sH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItcG5UDS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716305709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dhL1Q+jWnYDABNtKHJSo7WSr7N/mSKlyJQWOyp5Mr2I=;
	b=ItcG5UDSx+rE26ZZtec08EfjD6dZ73qx9Zux+fds6ZDdtQeCB9M3LXKkAX8m0DtP6tQXb+
	bxvMFj1dOhxwcAQTnFKmMVXRev2WigkXnfKTyPiBeogfPOU2rv4iD6kkaxoERxewDOrRZZ
	kffj09+RlrapifyFGTrCszWBKZVlrSQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-bxhxLZPLNo-28TOPEfOt2w-1; Tue, 21 May 2024 11:35:08 -0400
X-MC-Unique: bxhxLZPLNo-28TOPEfOt2w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b364c4c4b0so12745318a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305706; x=1716910506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhL1Q+jWnYDABNtKHJSo7WSr7N/mSKlyJQWOyp5Mr2I=;
        b=vVRwSSQjHEt132YXWfjIVJVTi0Hws0MBifSZukE6Gxrw1YmvQve4nXq/XiEl5HSlS9
         m6gjWqq8L3QARS/ciLDKUqIMyLJ5K/T+pIE0zo9XNvqLPrDoAG+ayi8wlZMkQ8Pjje0O
         Hy6DsHKZY2QWYFzXejDAlLno6jDIQza7WlfnJ3ruDd7UrgqoBKSQEhI/PiysjhzIbVZu
         iGp8BQyC5pPADe3r1q1q5JsX4LjIcabK4I31dW5jdyVkE4XroIsaRf5wBgGTuPK0CSWx
         pvAZjE+1ueTKFAZdmgZ74oQMz/1qjOqUZFSJAqEcoybrvMz1xSn6lzfczOLCdeYROQxu
         Kqxg==
X-Forwarded-Encrypted: i=1; AJvYcCWPTVNYuNafbbO4RaC4e7SE/FxrSMEpWwDrKBa7rFcJ1+KTeWfPbh1sDewUOxiCGmDl0ZFUY50eIzm92tSngecI+AbEZoULVf3MBgrT
X-Gm-Message-State: AOJu0YyszgsTCjIXLhR3u5HG6R9HqB6JLAajhLpsjBfbrtaEIDXUNyp/
	B4gtHRFk0KSZ3K8W4qr5V4EULnKtDbCq6Zachg4K24Mc6BUIDzAscanUMWFxnPiZv1wFImU1fA2
	cEA1ZKPJDQu+oRWpjsFkBo2xrF2Z+5BucjsOjt2RYfP7YZDeJC031UIkN8/Jdz9hLaxaMIthj
X-Received: by 2002:a17:90a:17ef:b0:2b6:ab87:5434 with SMTP id 98e67ed59e1d1-2b6ccd9ec2amr34415214a91.35.1716305706380;
        Tue, 21 May 2024 08:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0tskduGSJKFC3yV7n4L+QWe03s7d30NZ0FNcJ84NxEFgxCHGmSxbxr/In+XYHJkoDv0vXpw==
X-Received: by 2002:a17:90a:17ef:b0:2b6:ab87:5434 with SMTP id 98e67ed59e1d1-2b6ccd9ec2amr34415189a91.35.1716305705973;
        Tue, 21 May 2024 08:35:05 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c30bsm21819678a91.39.2024.05.21.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:35:05 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net v3] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Wed, 22 May 2024 00:34:42 +0900
Message-ID: <20240521153444.535399-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nci_rx_work() receives a zero-length payload packet, it should not
discard the packet and exit the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v3
- Remove inappropriate Reported-by tag

v2
- Fix commit msg to be clearer to say
- Remove inappropriate Closes tag

 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 7a9897fbf4f4..f456a5911e7d 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1531,8 +1531,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.44.0


