Return-Path: <linux-kernel+bounces-401076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB069C15B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA70B23B33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15B1D0F74;
	Fri,  8 Nov 2024 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uOBRNlD3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2691D0B9E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041678; cv=none; b=nNt++nSRVVVXR7ApF3rmQtPxoIkcG2+qzjAe6GCyZZV/8zYGuSMG3HxFF6ZUB5yVCTjuFl4QljkY0asePlJicX09XfoUEI71ShAg0jOHFtzl1D29FfJAK0maQEnweh8Bcg/+oGPpsTkBQzCVs6yEY0b7FLXAEJzJMNsxWcJ6PPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041678; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6DkaqaQfFDWr8+kHtmyxvgLE5I056nfkVaBjYx9FKzm1n0H7GowN1AV/vn7tKsdTnSo46f2lzcgF7wopjiBkxBefirZbMA6AkN2ykwoXe67trC2VWlPXN1s/k5dME5N+cqObIayV1v2vZsr6qjKh7wDvUolSFQ3651hvGKymUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uOBRNlD3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1294071a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041677; x=1731646477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=uOBRNlD3YjT6Nqi6l5UXnY1lblNHzzzEaOWmekCNRm7Ma6JcoaRW86L/vI3WG/DJAh
         EemzSXZ5EQ/oYjl3omt9tnEF1MR3Eo/4ms70fqiz2QYIVnoKtbEMc9rdu4TBQbjx9aHb
         4hfQcBUyMSdHYqiMYpMIDNXLZsV3AaQYNtk0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041677; x=1731646477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=pH4TUzggGefKGmZb0oiacJHDSLcQDPm80Kw5K+KDrpIIeCLPA4iBn706M4LY5pbLFQ
         AgQOXhU7l5kKRrdUpebRsx3WU8HWVEQRn0ihNm+v2G5ttUrADalf9CNspvdVyQIwQFR9
         i3SjcpnOhGjpVK3sa2/MzJT2zec5tGM+GiiXGJkXmzCmalvHnm5XnIDhkOLwfM47Sbb1
         7RwYc8XKh9kw+OOP7x1KbcAk31UCcHavvT1t6zv+6XPJHmkejIWAKhwgckPMjs78KauB
         SU9LIEcDQnYTReDE93CFbROY3SRrOP+xefqos04s7420NlsleyA1dNs2x65+GohTzS1w
         zSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQNFc2hVE+3Lzy3iXTA2JsSv3lFcfGAO3R6eK7Hdg8bAZ3HsvarYAYWfT6rry10/NVHKrHc35lh2sp/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8LxDCF8znkwkeNCptUDZoWHhi02ZVxsROC7ksBI6tSSKCDDc
	1Wc+sr4UHRmqI/aGwc/Bn9zF7DCLwoDB1IwG4OfAl3T0YYrkNwSVVA2S3vrZsVc=
X-Google-Smtp-Source: AGHT+IGYzAbiAwauRFMMboqJSm+iCwXrgDOyCYgQe6F94CT0DzPWv4Q9veac5TXYOYehAWs9ZfUyEA==
X-Received: by 2002:a05:6a21:3d88:b0:1d9:1971:bca9 with SMTP id adf61e73a8af0-1dc22a47884mr1473874637.24.1731041676722;
        Thu, 07 Nov 2024 20:54:36 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:36 -0800 (PST)
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
Subject: [PATCH net-next v8 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  8 Nov 2024 04:53:25 +0000
Message-Id: <20241108045337.292905-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
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


