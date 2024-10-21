Return-Path: <linux-kernel+bounces-373550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B249A58B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D221C20FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924183CD5;
	Mon, 21 Oct 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lhiwI1As"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9379DC7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475642; cv=none; b=A7Ubjpbz/wqJgyx/4EKzOwFnc9mHMJ4pYXgjEA4sc+poyMaOzJ1KUwE9pzp29ZaoQM48tQ52ht+rRDN9blW4w3V3hCV/DqZ0kBtRY76QQ4rj3rUAUfK1ph6LY/0YGGODk04AmQoZuLxju/Z+wEMHCII155cIkGZSvwfwKaZ1s8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475642; c=relaxed/simple;
	bh=0e84nxtTo0ZoFDbU9IHdh0nF4DdHDes+nR9YAcbdfkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3pp+8WQ1Q3qku5Cn0waTy8DeOKVwZneYP5pKNILGrU4jQDqCoMN5BDb+oxTYwBw5jXl8IDPBrz5elOR1KtODqVonnV89WMLM3dDmKD6AB6aWlZFXr0p9vRf9/E8iaTADxwzcGYmucKxzZzA3zSgzp8Pb5nObjAB5dGFkFKqWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lhiwI1As; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c693b68f5so41301525ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729475640; x=1730080440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFrcV5k7ZDwjmKi04AgmgViZJXfV02gap8kxsUW7sc8=;
        b=lhiwI1Asx/53ccFpny/+Vd1zgltvJ9LGoMvnvxf9v83LiC7Ag6E+lygWgeGZYz3Fgu
         muEz7Dee79iUJH2WnT8fXQ2T+J3aOUCIT/L7gPeVgLg3YrswXh41gRxYlqPxOGF8n/oW
         8goIPQl9fwlGnI7ne3jEsflH0kLuvUpyYoOR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475640; x=1730080440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFrcV5k7ZDwjmKi04AgmgViZJXfV02gap8kxsUW7sc8=;
        b=lgchm4rVTX0letEBR5LlC+aJlofJGnkoCkjPoc2DnIlDK2DQKcMZool80qjreWjnXY
         x4ZKOcdST+5cDy7xSFfozOHziKXSwW1tSnYKrdWKdlt6YElvApOxSFr+eAHRXYmPgFT+
         adCEGBzmRzqWzWFOqFt1dtAU6XBj/2vCdqZw2ibJpZy6g1ixsVHTnFESPVikzUyIImzV
         WgF3CGetapKScCEfkjWOV/0vxesHhrWmMDOduOsQUEtnjEX+WrnY13LP2Q9AhFgA5qbV
         hqHxgixYVzPcnEhvskXq28d7kDcolg6LmN2MQzifotcVuR0Ps0Z7apS68ySx4fRxLmMA
         BmSg==
X-Forwarded-Encrypted: i=1; AJvYcCUCuphZjWLfAnAuiw4tkDtSfNRYgaLYfr8EFY1vGMufLhCCoHWUqHHOsIq9LywIEkJJjEnpqmxGGEGXtQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtiYh94gD5g0mFZkm0isYTR40S8t9HodSUAJD6hBUVO4etVoI
	tmWTn3FtA14tsQZZs5D9PRaZEtaiJ6IWsImi8f5vhu8/KAw98wXkSzL4Hkt8tB8=
X-Google-Smtp-Source: AGHT+IHHA/oGS3p+tLHWaHAvFQTIjHcw3aME6fzgwVhWuS7b1NgLYLejs28l5AZoGl8AQkfb80AvWQ==
X-Received: by 2002:a17:903:2308:b0:20b:6d71:4140 with SMTP id d9443c01a7336-20e5a8f5fabmr135068245ad.44.1729475640402;
        Sun, 20 Oct 2024 18:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee650bsm15859985ad.34.2024.10.20.18.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:54:00 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: namangulati@google.com,
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
Subject: [PATCH net-next v2 4/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Mon, 21 Oct 2024 01:52:59 +0000
Message-Id: <20241021015311.95468-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021015311.95468-1-jdamato@fastly.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
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


