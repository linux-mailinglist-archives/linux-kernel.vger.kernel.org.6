Return-Path: <linux-kernel+bounces-246050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804B92BD08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89E21C239DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B419CD05;
	Tue,  9 Jul 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGnHqwAK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C119CCF2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535676; cv=none; b=fJJ+t6xt8DbRJ2kbXRBswcULnJUixlO3LkqZ8ukpQp51XHzN8mZJ/3542o4v31+PyglKPMtc5TosiqdeyAUEDrpTVNYORcaJY+PUBiWWeWXa7b2Sqvswts1sSgd0Fx/3hIxHhLNsmC0GICMKRSltWFbnzWj3j3uh8SA0DW3Pttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535676; c=relaxed/simple;
	bh=bpzhk5cfR3F+pR8M1FUWFRktJXUEzVfeuMK6fUbiyOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVCep40OWCMMREymlEezxtO3rsssLfjnp+jj5z8Q7EDIrMHBcCKnWvIJkYYjMRmTQvmV6Q9jBJFqdXq42Rx5WZr2hbBtoEInsgu8lUX4VBGrLzfx3pTuvbGOJVFzbCCLS8xmsTUgGlKFuf94ebik24v2MadF4VqlB2NKGSpOKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGnHqwAK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KSGK3LaL1Mx5upY3a+zMUsotplQxAZK6hNQur1F1ok=;
	b=gGnHqwAKKphcA+0QPrut7O4zTXH168UG9u0UYpIp+Rb4+/02XO4+VYsIhtjA5jchtuMixv
	yXdeDJcqlzRihIaWI2FriMLb0J1QbDg9KjE0nzCBINRIhmD68fk4audmfA85zUTqXmt0yf
	1DpCENdTT0glHyQ09swxtt/8EewYNrE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-n9td_YVYPpapCFgPvYv8Vg-1; Tue, 09 Jul 2024 10:34:32 -0400
X-MC-Unique: n9td_YVYPpapCFgPvYv8Vg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-38acde528afso7460905ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535671; x=1721140471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KSGK3LaL1Mx5upY3a+zMUsotplQxAZK6hNQur1F1ok=;
        b=GHiUIxbrcpoKP3Ye3hE6ZgYmYUKCHvVd10KH+dtzJWm4aTD+VXGBY0F/Wq777SuFY0
         /PEOWe4d/gc1bZ1l4BI6EzMYbDOgLmnH3/RfUw4zoj3yYv9OGGw68xv/n9PN2FNJ/9IH
         xRtzzDtWfn+c2SynXyTC1Zx1TBALYRsCaucO+fGGMWoZ+nQHmLckyvOAFj8lo1XRgyoT
         Wcg5x1ZMTXpMN0jKFi6QWPXtGB51qzCqdIIT2ajtICbN35rCGYLvbjrrX99krXdKGI8P
         Hq1nJNR1wwvpHicYB6YnfAUnrqFoA1D+EpSnOVgi6QbWtvBu81+a0aenuE17WI3ti4l2
         43DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpqLEjurO8TY+fXqCe6LmRtmoJL7B5oYidF/+f1Z1yp1nIDds3aNDOSO7D1Av0YpkgXo8J0F/wx1ygbD9f06K46cFh9TYYb7+ntyXN
X-Gm-Message-State: AOJu0YzuWH9b1IfGCbdzksLdhl/5Rz5fshNxnyKCwUQxNpxvOsJHzaGy
	QPa3iyDGp5Z+ByrAY7VjeSbUj7cNGusrmQMwCKBB9Vm5UtoMmu3B8UPC7vzT+j/jnRgewri5qzZ
	BuQdccYH2Yymwh4bK6qYvUgdHrETNkgc8ofAOUIlCFgsqh5mnV3pb5w1dMUMRqg==
X-Received: by 2002:a05:6e02:19cf:b0:374:983b:6ff2 with SMTP id e9e14a558f8ab-38a5a079b58mr31038955ab.20.1720535671198;
        Tue, 09 Jul 2024 07:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCBm/l4muSrDy7yEx0OBrZXGu/5Ywn0CQg3zoXjkv0vgrA62wtGegT+1Otz+Rekjv0zwGo3g==
X-Received: by 2002:a05:6e02:19cf:b0:374:983b:6ff2 with SMTP id e9e14a558f8ab-38a5a079b58mr31038695ab.20.1720535670921;
        Tue, 09 Jul 2024 07:34:30 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm1501424a12.22.2024.07.09.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:34:30 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Remove unused struct declaration
Date: Tue,  9 Jul 2024 23:34:10 +0900
Message-ID: <20240709143410.352006-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct tipc_name_table in core.h is not used. Remove this declaration.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
index 7eccd97e0609..7f3fe3401c45 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -72,7 +72,6 @@ struct tipc_node;
 struct tipc_bearer;
 struct tipc_bc_base;
 struct tipc_link;
-struct tipc_name_table;
 struct tipc_topsrv;
 struct tipc_monitor;
 #ifdef CONFIG_TIPC_CRYPTO
-- 
2.45.2


