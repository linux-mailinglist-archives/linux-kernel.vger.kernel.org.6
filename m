Return-Path: <linux-kernel+bounces-391496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAA9B87DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4906282483
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707884E1C;
	Fri,  1 Nov 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EOl9dT7r"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F84594A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422166; cv=none; b=LQU2Fi5e++nR6DkiadW3Y/Y0E1yhEkNHPEHuKhuxZzH+qgrh2W2V/bk9uzG/CfmtNGbzuxkLxio+BOz1Cbrkxn7Bq1i5FyZCK0eGfF9Wxw71hrDCXePUe3VQlmptwaZCmE+UO51QaaY3cX9HipShuZ6kxyWNU7d4SDQvBavNOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422166; c=relaxed/simple;
	bh=aGe3m9f05dLxeBPRr1eRz+KFLkuOg8ceUeij3ovk3Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnUdzKdWzAzv74/uO/SXMwhe86TkWMp3uUqcSW6gAk1RqoVEtgWn91Yw65aM8VWRjNh6xnvc2CY9CCARF6QHqtHQFFhDsg6RNfWWhxjrwZdrwUpUSSwqZxUtNvb7h+X8lacigYLjBWbsQZokpNlBL/RHia7VP9Lbi5n2u7yFcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EOl9dT7r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7203c431f93so1263842b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422160; x=1731026960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=EOl9dT7rqZ/XjE/Es3RJSORRnQSOmGvYBzkLqlURXuMRCAha7Loeei7+POyhP8uY9C
         4YQIvmTbQZPtVgIuUPSM+X9Twy+T8eKSO5/FKJjqIa9ua3K9IpiiN+fwcogFG46qCYki
         dB5tO5+fOGPLW97Ia9OplWjtER+O/Pjaps/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422160; x=1731026960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=NsUu51IUbLcJT8Y7XaZFM3B0AtfVMMPgmcT2sMCLOwadToIddJvvCZck2/Sb/sqkz/
         0ZaTuHAtLAv+VDGepvtEdD3ECikeNep36BQq3kkUMVFAinVdqHzBbVG9wUl6l8rgBFVB
         DhcotJ4vriVIyUoRo0W8BHjiFM7lJSLsO5OVfwn+lpBqIBPtRZHZ0s2qhX/GHJruy6IN
         GRoEwDl46IlVBeqkWiUWmI0FRXtn8mkTYZMtuezlBdIykDvhkdyzDsLxnDHpV5dUpGY2
         2BgZsYXVoAvzd/fxkasQ0P8CHLg5Pf1A+NOCd1Yz4X4R/E83lVVMX404yvBVYTlEn+IS
         9VEw==
X-Forwarded-Encrypted: i=1; AJvYcCVlzQhChr4sdLcCZoWOZMvG58XEv7fvrMlOk8kkujcot4Dq61OyIvvyzyn8dXo22aI+hlHu19Aas1xq4kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpweCrAK3I0n6+IfCKAzYw8OPOv4vGh6QoNMUCogfQN+wlHCA
	Ar06eZb259xIBcXgGycKGyPOC46PibnoE+/20ZxXNIkuzHMT9JyVAyO7uYgm6+Q=
X-Google-Smtp-Source: AGHT+IGknkQOlPQzMWzF3Nd5ddeqEP5+C9cHjsG5MuxNVuNJP+70dz/NU6AVLw9eSZ98XT55SfIr/w==
X-Received: by 2002:a05:6a20:c998:b0:1d9:1c20:4092 with SMTP id adf61e73a8af0-1db91d892d8mr5691359637.16.1730422159752;
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
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
Subject: [PATCH net-next v3 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  1 Nov 2024 00:48:31 +0000
Message-Id: <20241101004846.32532-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
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


