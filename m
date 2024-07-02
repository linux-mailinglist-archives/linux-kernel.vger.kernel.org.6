Return-Path: <linux-kernel+bounces-238084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D498B924331
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AA9B26807
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD081BD4FD;
	Tue,  2 Jul 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um5YQS4H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9301BD4F2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936374; cv=none; b=Z9PHpd9sIejFqnIAZSfAEw1qXalI4Hv6yiohOJm1dBceGQyN1bFWLI9gfuy5/yFaG8nl2gtojHSnOY6R+gIn49jbmKXLD5m/wEMn4XSAbXcSXDc2pjlC8RSa8jaC9yU0VcOPcqjuQfoyJkoJ4e2eQTxhOtY5OuNB4DJJOlTzUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936374; c=relaxed/simple;
	bh=6bfthXh+z3FlLnjiFbGZ9DImdUQg6HnLJ/s7QzPwJlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdH7U9IT2QSTQ3ht1CxZe4jXTkJ1TRNhZkl93nQs8/1UfJdkNsAxOY7hqiL782Szxk2uZU0+spp+DVDtzcD3/KQOmVJJL+uFTQhEs2JIovvfzLi0ILW92E4zEbeKvTFMUl/rzFJRhUFpxXHdb/KICj0SfV8juIRP6itKo+MXq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um5YQS4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719936372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhomTckPXydN9WWs1SvlxsuDB1WwN1ndD9L0d+zK7Ww=;
	b=Um5YQS4HWhYrMZ5ouy+mHg2XX6Bz5eXfXF3bA7Sz87zh1EYMdTT3pyLkYY35sx5Qt5aLJt
	J96iIwsdIWTSX38ulnVdcCLZZ3O+Q+s4Ypi/qFes776km1JuHYboEwfBbfI1PI9hTJnhWt
	iGrFE4Rwksf7JmeLZUWoaiZUDBz4Cu0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-hoSoJIA6P3-ZXCE0PgJ8EA-1; Tue, 02 Jul 2024 12:06:10 -0400
X-MC-Unique: hoSoJIA6P3-ZXCE0PgJ8EA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7c3069edcso2992551a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936370; x=1720541170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhomTckPXydN9WWs1SvlxsuDB1WwN1ndD9L0d+zK7Ww=;
        b=J6a2igFTp04T3xX6bXqBarCNS8C8iY6nqjZus/GW9ZRslp7t8zDH2txw19637Yjw2R
         82LLC/9YVwBX2VZhf1Dsb8dDVg/TiTWyy6w82C4ygxU0O9NodqBj9oA516Nt/YHsWibg
         rtnMKYj4rgcLxZEEI5aNU5/XzemkkC+Gcstbd+SYrePxmkrBVVX17tjFmYDQNlKEhLnJ
         U/uJ44krAKhFlWbf2APFue0MYlGFL9/QM3PmWi9v3weikcHi2L8TuLZ6Kdr5JM0CUroX
         r+O4s2fOBWdI/chJO93Yauz5aoxHJzEDfDoXKnETYmgt/+88UWQ+WlL+Rlh1TcUrVH72
         tPnw==
X-Forwarded-Encrypted: i=1; AJvYcCU03knbLSiKdP4dt84ZwkILa076R40kMSOLEn3KMERK99qt2Y4ICq4JVUnyBjfTd4dkQuh+hbP15/tlRGxYzDM1Jl2kw3677IFvSBZR
X-Gm-Message-State: AOJu0YycTrohZ3WOSiHY7Ud7wlgSW52We+HwN1/Lhe/JgWrhOec/vbla
	eM4TpQo0W9oN8/kHngQ6Wn1PWEr4mv/MDnrC2ocabL0grtKeB9dcAkqBdLAg84/H0Mf5FbmpoUR
	tzR80vWUQKKfCtr93TPvQQuWjqVIyWUSOI/hYwsmpQ3vQT7RV4X2WQNQpsYQXbA==
X-Received: by 2002:a17:902:cec2:b0:1fa:ab4a:faea with SMTP id d9443c01a7336-1fadbce9d6fmr65165325ad.43.1719936369825;
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEotUuIOqN777VHgCHNLN6WhtC1Qu3pqhNm81uCxVDmVMCvhU4/9Nmd7+85UBA5eY+UeYtrPg==
X-Received: by 2002:a17:902:cec2:b0:1fa:ab4a:faea with SMTP id d9443c01a7336-1fadbce9d6fmr65165115ad.43.1719936369422;
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156903bsm85565195ad.208.2024.07.02.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@amazon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net 2/2] selftest: af_unix: Add test case for backtrack after finalising SCC.
Date: Wed,  3 Jul 2024 01:04:28 +0900
Message-ID: <20240702160428.10153-2-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702160428.10153-1-syoshida@redhat.com>
References: <20240702160428.10153-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

syzkaller reported a KMSAN splat in __unix_walk_scc() while backtracking
edge_stack after finalising SCC.

Let's add a test case exercising the path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index 2bfed46e0b19..d66336256580 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -14,12 +14,12 @@
 
 FIXTURE(scm_rights)
 {
-	int fd[16];
+	int fd[32];
 };
 
 FIXTURE_VARIANT(scm_rights)
 {
-	char name[16];
+	char name[32];
 	int type;
 	int flags;
 	bool test_listener;
@@ -172,6 +172,8 @@ static void __create_sockets(struct __test_metadata *_metadata,
 			     const FIXTURE_VARIANT(scm_rights) *variant,
 			     int n)
 {
+	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
+
 	if (variant->test_listener)
 		create_listeners(_metadata, self, n);
 	else
@@ -283,4 +285,23 @@ TEST_F(scm_rights, cross_edge)
 	close_sockets(8);
 }
 
+TEST_F(scm_rights, backtrack_from_scc)
+{
+	create_sockets(10);
+
+	send_fd(0, 1);
+	send_fd(0, 4);
+	send_fd(1, 2);
+	send_fd(2, 3);
+	send_fd(3, 1);
+
+	send_fd(5, 6);
+	send_fd(5, 9);
+	send_fd(6, 7);
+	send_fd(7, 8);
+	send_fd(8, 6);
+
+	close_sockets(10);
+}
+
 TEST_HARNESS_MAIN


