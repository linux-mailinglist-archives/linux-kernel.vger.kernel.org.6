Return-Path: <linux-kernel+bounces-261045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA993B223
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114061C23508
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D35159583;
	Wed, 24 Jul 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPZD/DCn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBA1581F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829396; cv=none; b=Qe3msPvkI5Mzmi2can9z5cKhGnDZHcM073FTIVC9B3boG+bdJbuBm+3NLNixSSFmuvqAew62OiYf0XEz/9E2IgZX3V3iKfH9gPmFxghu3pfh1iHRxv91nFf8jy6EiAieT76ncyChF/nP74fTbOn6IIMaty93RosWGjuo1PhKKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829396; c=relaxed/simple;
	bh=SAjqmh/BLGtim+vtA52dOehpZeqvRWDIVdUK8nzMpbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYM+Mwr8Y+yNA7DctKGttvfq8jo273JlwH5uDKbNb7v7w+fJxMQZQeYylRQ05e8TEA/MKJgs7avLYtr5ePHfxuXK7vZKh1jSEbGBIYBpO7Y0peQ9c33Gq9L05A5NkIDbjQm3fRlpFeiPRf/PrP6a/IFtJIATOPhrEEwcBbAZvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPZD/DCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721829393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w6G0SfWDui6haP+QkrlZi2OYiAuFOXCgkThuAWcxZVo=;
	b=hPZD/DCn64ChVE3EM4jPg9L7EJUju5zI5T03D1w8Yz/2zLT+EISS1GnPn0tupb0QHRF7qq
	eeDVU9E8JNbyf/S9x6Fut5nzEkvpLxPbiBUzl9WYADUiHw7utMZw5l8pQYUOM1rk+ifLiv
	Jr5K5CrKVBZDXrumYUo/zgZnTHwoRX8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-POjVrdi1OL6xLpc8zewnGw-1; Wed, 24 Jul 2024 09:56:32 -0400
X-MC-Unique: POjVrdi1OL6xLpc8zewnGw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fca868b53cso15182555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829391; x=1722434191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6G0SfWDui6haP+QkrlZi2OYiAuFOXCgkThuAWcxZVo=;
        b=eRqxxwKtYD2DkeBUNknIR3pHJGb+WoQ5PN/PeZRycJPRPzRT2dlUBkOEagdrSmgkSz
         MKxk+tAC45mP+yuZGo6pMWzfVKVEzDi4dZhbKUQNiOJs79XCefhjZyxg26OiRJzpOzAi
         yEcbU3JtvODbaZj7E819TW8rYbLoUnYzdVE/EpGrkEROBLA/XKCF2I0cJ6fusNlOWDHJ
         aaTskBEDyWfUhjPsoQ8q/Qd0nLPitws36k13bzf3ta4a/sd15uHTywanWtGZca8cg4VV
         YsGkV5cxlxDcTVe4GKTbffYiIfkgjlXMgd2SiQKJ0pOMSRrivSdO5qHwoCaiOTZRaF4y
         THjg==
X-Forwarded-Encrypted: i=1; AJvYcCWualbGJ9JVgQeLgyefWeI8ZzX7uNSLBh/5sgZl4y5/mO2B/g/c81e0VbzRnvh+8SauoMaNIdSc63Q/LcdNJ/D8lLsYPZOM+kE4mPz4
X-Gm-Message-State: AOJu0YzcouPqYNbHkEFiz6RAE9x39shY60NIjMk8pAHt8ShFqcq5aEro
	KBpylnrOfPGfXiq/SMVuxVnoS34C25hK0i+7/zTj1veW+KbprTKij798tT5Q6K+wJrv0ZBDuaML
	mF3YfqhQLb4KBIMYS3hQGJwR3ZZpASnbfwFxvD1e/+x+CVX+NteagP9K/NrEQaw==
X-Received: by 2002:a17:902:e892:b0:1fd:6529:7436 with SMTP id d9443c01a7336-1fdd20edc9dmr31053855ad.8.1721829391297;
        Wed, 24 Jul 2024 06:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcg6fpS+w8IcgfqaKJSV23XPUmGkySpEj5lsBc/ADne3OoONkx6JCt6twOrhpHEzEPRK1Klw==
X-Received: by 2002:a17:902:e892:b0:1fd:6529:7436 with SMTP id d9443c01a7336-1fdd20edc9dmr31053585ad.8.1721829390812;
        Wed, 24 Jul 2024 06:56:30 -0700 (PDT)
Received: from ryzen.local ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm94359755ad.157.2024.07.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:56:30 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] macvlan: Return error on register_netdevice_notifier() failure
Date: Wed, 24 Jul 2024 22:56:22 +0900
Message-ID: <20240724135622.1797145-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_netdevice_notifier() may fail, but macvlan_init_module() does
not handle the failure.  Handle the failure by returning an error.

Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/macvlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 24298a33e0e9..ae2f1a8325a5 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1849,7 +1849,9 @@ static int __init macvlan_init_module(void)
 {
 	int err;
 
-	register_netdevice_notifier(&macvlan_notifier_block);
+	err = register_netdevice_notifier(&macvlan_notifier_block);
+	if (err < 0)
+		return err;
 
 	err = macvlan_link_register(&macvlan_link_ops);
 	if (err < 0)
-- 
2.45.2


