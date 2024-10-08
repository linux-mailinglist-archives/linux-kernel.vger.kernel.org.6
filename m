Return-Path: <linux-kernel+bounces-355392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC309951A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E88282052
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE381E1A17;
	Tue,  8 Oct 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6xf0v5y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBA1DFDAD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397500; cv=none; b=eHTQgKeyRFPKMToxNrq4oUsVHtxP/i4sLz8uMSrM2mBH7jKwLzix9s98hKGaUwu6f3fVkSKnAcBgYydc0p82/saH9Ez0Slk094m71j0suBTg3aoqeWIW0riE6H4mQtskL9yyqCGKjekuxmdfEChq5cP1gvOSgi+1xMW5Rum9jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397500; c=relaxed/simple;
	bh=CeuYcrwiIKUYZeW77ix04H0/vwRWNAcXQgelZ4lvjyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bfp23OmFhKBp3buUnED7H7IBGSmX/kPgMz6+nSkWbfKn3Im2+4jfBcoxpBFYtR+yjkG66zn7Dhpvz0WBuexkUS3HI6/+Utl/D5mOfkBpWbpR2/sngEtfBTKFs8Kc2M5cShVMTyuxT4ZSUoYMI1KiBx3izgCt9vmEtl9CK0Zh7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6xf0v5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728397498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJP4m5ak7lZaKjWX5FdevX6+OMFvcZJshMKNLgqu15M=;
	b=B6xf0v5yNbfhXg/kZZUg37qYNn+aPhAFELu9dxv1i7OVFFHujyvMA9zJbqKM8vlzwLNpgh
	vW4/te8zEXO2U7JnPz1y11g6BUMBgiCcBomkuE0IcvilFQkWMst5+3vrDWKN0TPTEEe2xA
	i3lTHy6GVOYS6Kr5beu5yL412mcZ5SM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-bNhUfUoUMvarzcOKhu10mQ-1; Tue, 08 Oct 2024 10:24:56 -0400
X-MC-Unique: bNhUfUoUMvarzcOKhu10mQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e026caf8bso2957001b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397495; x=1729002295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJP4m5ak7lZaKjWX5FdevX6+OMFvcZJshMKNLgqu15M=;
        b=cRqq4jqfPyqkjPV+MnMHNZDz+cRUO53vvPKvX3aNZAEGVsavxOe6N6zChfLNJhgRSx
         MVCmrzF/IOGG2lqhroVXk2ErvMsSYNP9WDzzwxqihPQveVJ7LOBUfA3HFulk85TXtBSw
         D13J7hC/LT9MvVZoUB/gRSJ8pGb2FlB3k5t7gPHXS/7vm03H4HHtDGsHaCUSTHWefekf
         84X37IQXgKBeF/jAoqC7setWqU8yWGPYy2qu6UH+DSQCGqnthx5MQ3QuiRcrXpJBRQdZ
         aHaXuDzLSJ0dHdqGPEV5L4KYh/nL9j5hI4qouQfxt4h+x2ldNcTF5IX/8RH7f+JcgnhM
         RZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX84L8hiXMR7FpilX0/QTxYXEQMUf41tXIUaqGxc6OlyNABXIze2Lc773kt/Qjrn5Q3Zb89+Fe9BAJEZ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IIsTxIbJCEUFbw2hgHvTQDL6jDACaRCYsFfCiIOMP5Y084t8
	cd/CmwNSDMdV6fls/1ZvK7bWGfHB5AHXUOzXO16ucYWqG+hZ74ZBu9FRhwu51qtgpauJx12tOAn
	vQzODj2hea8TbybTsP2AhvTXzjt1PjQEgHXgMD5ne4fUX/FAmrCKqldPFyga10w==
X-Received: by 2002:a05:6a21:114f:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1d6dfacdc72mr25369366637.39.1728397495068;
        Tue, 08 Oct 2024 07:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaIoOJotr2X52JJ437h/ePALQVR8idKhgXka+qVOOdiin+Ay69AGt3bPhS1MWuoz1hsgLOLA==
X-Received: by 2002:a05:6a21:114f:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1d6dfacdc72mr25369339637.39.1728397494761;
        Tue, 08 Oct 2024 07:24:54 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:5054:ff:fe86:4eaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a1ffsm6182937b3a.132.2024.10.08.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:54 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tung.q.nguyen@endava.com,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Return -EINVAL on error from addr2str() methods
Date: Tue,  8 Oct 2024 23:24:42 +0900
Message-ID: <20241008142442.652219-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value 1 on error of the addr2str() methods are not
descriptive. Return -EINVAL instead.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/eth_media.c | 2 +-
 net/tipc/ib_media.c  | 2 +-
 net/tipc/udp_media.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/eth_media.c b/net/tipc/eth_media.c
index cb0d185e06af..fa33b333fb0d 100644
--- a/net/tipc/eth_media.c
+++ b/net/tipc/eth_media.c
@@ -42,7 +42,7 @@ static int tipc_eth_addr2str(struct tipc_media_addr *addr,
 			     char *strbuf, int bufsz)
 {
 	if (bufsz < 18)	/* 18 = strlen("aa:bb:cc:dd:ee:ff\0") */
-		return 1;
+		return -EINVAL;
 
 	sprintf(strbuf, "%pM", addr->value);
 	return 0;
diff --git a/net/tipc/ib_media.c b/net/tipc/ib_media.c
index b9ad0434c3cd..8bda3aa78891 100644
--- a/net/tipc/ib_media.c
+++ b/net/tipc/ib_media.c
@@ -49,7 +49,7 @@ static int tipc_ib_addr2str(struct tipc_media_addr *a, char *str_buf,
 			    int str_size)
 {
 	if (str_size < 60)	/* 60 = 19 * strlen("xx:") + strlen("xx\0") */
-		return 1;
+		return -EINVAL;
 
 	sprintf(str_buf, "%20phC", a->value);
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 439f75539977..78fff7ad4b2f 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -137,7 +137,7 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
 		snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
 	else {
 		pr_err("Invalid UDP media address\n");
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.46.0


