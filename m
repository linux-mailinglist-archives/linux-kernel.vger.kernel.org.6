Return-Path: <linux-kernel+bounces-402661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5959C2A36
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2491C20EFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25D146A87;
	Sat,  9 Nov 2024 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IFnhriQn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6B145A16
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128591; cv=none; b=S58xUvZOgc8xuUScUfy44hPSMmqiQya2kcMyJ4VkvcCFz3eEyUQGqOI26QrbhSaXL1/P0aiQzsgLkpq/gR33IhDBr4dPXxQTgWIs7dYUoj5ySg8MZKLU/YCSp/yS+iSR/fTFHSVOCzLL/xNX/BRCySqHkN2m4LaiBJGA84j+xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128591; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xor7m7QhAgbXmZprTKbcZPPNnoCRpF1APjmE2lscB0mr1A/r89vK0EdSvJmmhDvXZ90rNt/om9w+TKcBag+I5lv3YvHD4QeX7/4W3JYe/knH90R0QOE/lCVcym2TlrrwL8Ec6YCELgGlosfJL9sO97wCIKPzTfjFLlvnSOae1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IFnhriQn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb7139d9dso27821525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 21:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731128590; x=1731733390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=IFnhriQnBCTn70E//Jl2nn7JfCbUV9ayUVk6rayOUdaQstJCVSb2cqiOAMssJK2NPa
         DCAMemM5+bnH0DPL0jtuZuuqiMjFrHQM2ZnruRJB8ow80ExTJOp9Vgkdd/HEjB7MTGHr
         adYFlcPQZBNC2QOXdKNB9d4Y8GKI4D6CYaaAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731128590; x=1731733390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=OsEU4g2JAxUWMNirp2qwu0DVflbOaHjE3JKO0hHWVC9GxVc6fYWpAv7DC5r9qFwRxa
         KoDkKhsA/svXZ1+eC/f2SoNZJykOT1M9g90akSjqhIKZQaPXdrmRXsXMllY7+Ui5wR3y
         Ms8rZjiUtEEPipEgI0D/rn2c9SA9MZ6PDa2nzX9pv10HIZFvTZt9ZQXJoJ0xaOWgp4n4
         8N0KknC4MGvxC9TyGbAiBgtTeW/n2tt2b9Ex0OJqBvvn2WFUY3kx5fD52SMaupQ5anW7
         YGAALpazzIuJRIwYx3Fh4OQKOdq2ppUykpP8kqKsQ4gr4XAveZorkaGAFW2BTYR7/Q36
         Dm5w==
X-Forwarded-Encrypted: i=1; AJvYcCUMLe3jnuQFzFcnFiUojnqhJwAIu7AodYwe/KhU0l/6B1Q7CCm99dADSFFjRDtJfNB4n7QDvGNSAe6HIjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqVnIGtMaqqcgGvfdd4io4TcpMElJcXbYwJeWbxmvZCYJ8NCQ
	L/YDJ8NuJKMdpFPh9/S3mzRnHFHOjrdVdydecrHodK88VBf05jK9200s0Ps94Nw=
X-Google-Smtp-Source: AGHT+IGzmRuVCERnRF29spRVxccerJag0s3xixY3WGrpRZL96j0U/eDHAABtUMvfvWyq5b9qA5cGxA==
X-Received: by 2002:a17:903:41c3:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-21183d34368mr57616805ad.19.1731128589606;
        Fri, 08 Nov 2024 21:03:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5853csm39182305ad.186.2024.11.08.21.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:03:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
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
Subject: [PATCH net-next v9 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Sat,  9 Nov 2024 05:02:33 +0000
Message-Id: <20241109050245.191288-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241109050245.191288-1-jdamato@fastly.com>
References: <20241109050245.191288-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
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


