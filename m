Return-Path: <linux-kernel+bounces-393088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0329B9BB4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AD91F21DC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15302147C91;
	Sat,  2 Nov 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l7WjGY82"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECD13C914
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508866; cv=none; b=RZpp0MAwiZfoJrO79VbSbU67lZiF/3AVgpass0Of+NgTlksAJtc5e/YKNKN6I+TsYnKG1dCBGb1YmCdKolWIgJcOmIg6hJHkaBWh3MNVbbsaquLK3L47CYZoPGfRpeY/5IwCPVIb+6sDxCu5dWbrZC7HJ7JTMj31dzgBJLnr+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508866; c=relaxed/simple;
	bh=aGe3m9f05dLxeBPRr1eRz+KFLkuOg8ceUeij3ovk3Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msfd9TN554MVQ5JDIx0bPB4dbmrUFJAq3ubvZ0s/4UyMAbJYble7RtpyJ7eLcbQBSgssN+ydNg35adESrrQmLSuQ4yMsG9b3La+NQbThecvXsIWviXeHT+daKkjLVIUHqoyYUWwEcLiwiU8kL171Kn+eIw9F7ZYEw1/r5O3xQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l7WjGY82; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2201021b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730508864; x=1731113664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=l7WjGY82k1YP3jA4b37cYD3lu+tQvIJkqrWsQ+sdgtl5H83r6rpiF1HgpRwlRxHEbz
         HyEN0N0LAjCTXpPK+6k1vz60Wsf0E4IyateEsRyL79icvns/Ip9UW0Xmt+YWjEtK8P3w
         GkKFM4xjvxJyqssdlYC6go8IQJ+2iFUJTHJGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508864; x=1731113664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=l/TdQ+8To/1PfXS8MKIUkEE5HQukiU99RVTkoyhkE/ZADSxloAzD6Qh8kbQAVCOlBC
         vM5FFhDaPuunMMPUbDJsYLKPBtWX0MlmwFB4MHlh89MsAD3vTVK6V398VXtqCa1ASrRW
         dUn5jMws3TRLymtk9rJA3Lt4D2yAAFGnj0h2xqwTK+9kkDrkYjdadC8NwEpnoEBocx5Z
         RlqpQVHs4tHslAkty8S9y3H9mcqaF06jIW7PwE9EBtyCIElJzGTT5FbGuMSeOVcZ8Z4H
         NP0iEOPHAj8s/CtpG3VChjnyM5TTMX/4Nk4cRW2VRB/szOC8s4fYWYug9NxMToPGVyxX
         U8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxjCldJqfSur+L5JN94haO4Av6fXUVkLiOcardogYk8Ko6gcnCRibu8S+L4CPiE4G8VWEzi2/LrRY4aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0uL9PemFdPOLZL/o79ZQGyXn810UcRNlxeJaiweyue1ibQfk
	sh8ucRjW9dpgSYQILhNLDZr+tCjkSEHgi5GduBG91/08s5lvms2xTlcqzpvXOm8=
X-Google-Smtp-Source: AGHT+IEKO8LXs+HcMd2xwJnlgb7iI5KufhZvOye2VutdYjLwD3cTjYX6770t38m/OwP2/Vrzm4umNw==
X-Received: by 2002:a05:6a00:8c9:b0:71e:410:4764 with SMTP id d2e1a72fcca58-720c98a3d19mr8908845b3a.8.1730508864358;
        Fri, 01 Nov 2024 17:54:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc3152fesm3274549b3a.195.2024.11.01.17.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:54:23 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Sat,  2 Nov 2024 00:52:00 +0000
Message-Id: <20241102005214.32443-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: <20241102005214.32443-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


