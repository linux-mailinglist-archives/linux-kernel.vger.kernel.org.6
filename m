Return-Path: <linux-kernel+bounces-252116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C1930E90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00211C208FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF931836E8;
	Mon, 15 Jul 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUw7PG7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE027457
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721027761; cv=none; b=P2CgHREIkcdvyzmjrXQ50hQWd2ey0Mnmo2uwtveY/6unFKenJ64IprieMUd4ADuAorGhxDxVWbAQn8ioP0vuVhSMKgq9LfYc3QXMa4ryz0tb9fL3krKuF2UmJ6wd8i5d3vatn4rDbJ5oVATxogHkM8kUadiCH8nGStnh9uL3lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721027761; c=relaxed/simple;
	bh=XcGpFqnDjKNKx8SfYe7aFOKVeti+RJENIxAU2UvUuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g98/UfrmlWmHutFOyblI9ZXnZS2YnCc092lvRx7Z+kxqNCoweaEnf9CppTzDvHa9BXmowfAUh/yvJv0pMSXrPF8Xks5dgn6m1LmvIWMcRnMw7GtfyBEiLNF7RiKfH7F1zjpxG7o9dxhu27JELLSiOkr1Z1P9OJFlbXRfMleHkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUw7PG7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721027758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Y2AbOnd9Mq1S+7NRXex8Vmbtv9LUYdHTykQN+yx0Do=;
	b=BUw7PG7YjsQSqwcmdH+AG+sif630ow1LwhOV2jRETd2R46UrlMiqrgQfni4/IthW1K9KwF
	kRmCW8A+9CiFnr0jzvF2sEpMD02OJpR8DHhEJKOGZQrUuBvJqMEHSPDZs9TAAg5evfSQbU
	FqMOuJqyTvOeJlGNx+CSrJZy1D8VvjY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-doPEtFVqMk2vQoSZqQtQxA-1; Mon, 15 Jul 2024 03:15:53 -0400
X-MC-Unique: doPEtFVqMk2vQoSZqQtQxA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e9c23da78so486133e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721027751; x=1721632551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y2AbOnd9Mq1S+7NRXex8Vmbtv9LUYdHTykQN+yx0Do=;
        b=j7VW4MhCD7FkaAPosDQADHIfGh4/+DoJk0u2IVep5s1BkyByXNVoW6zq+vkhpGc7YL
         osM71iXqmvR6bia3GrNxm/0tMWYnoTSN3NRxW9OD+Wmua0YDfsSmcbnWiy4fVk8lWv9q
         ybzWXQM9e/41nafJFlu1S8YYNwgq/vy0pM6mowicymHmrUpRQIZUbXuUyvzcddJIPM6F
         W1IAGT16QkBr9mdZF9dCekXCKHjZIOjRKIublgm1UbtVwM4iql60XE9XEKWdqDbKIBXa
         AohzeWLlfZuVkh5gJ2IB2OJMKBy2TiwqEivaY2A0RpfZWaGegppDHhCuZLjpaaNv0Pm6
         MjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgmcOwi0DuCkC1N4FUoEP47HzVb2Yg8S4Taw2UeJG7q9OlrRiAogdTU4zQu/YDuECQ1u4BLidAwj8aWeZ4KfV7zf4S8OJt9CwXS7AZ
X-Gm-Message-State: AOJu0Yzt9KcQmHF7zjbEsh4ON6WQtQzGi9LJU2gcvO4vc0lAfDUEEzQE
	n6cs8VElBHl9WJGSPf2/4LAIFZnCKX+icHdzl6FJoP3pCxSdcAoN/eNA0QebdqYkXdbGoQfOKD1
	Oz0H8H/BTG/PyqcinT5tNeY1k85hbpUk+dfqbVR8l0IXJfW3G5qoTsDfeJd2xcw==
X-Received: by 2002:a2e:9859:0:b0:2ec:4a95:5f05 with SMTP id 38308e7fff4ca-2eec98bbdfcmr57232711fa.3.1721027751667;
        Mon, 15 Jul 2024 00:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIxAd6BD5bhLdYSEanXaJBCdpDuS0Tp/uJ2ilToq7YjUr3fTfHTb5q7xuks66ttJZX4xDRWA==
X-Received: by 2002:a2e:9859:0:b0:2ec:4a95:5f05 with SMTP id 38308e7fff4ca-2eec98bbdfcmr57232551fa.3.1721027751282;
        Mon, 15 Jul 2024 00:15:51 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426740daf6dsm95815705e9.1.2024.07.15.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:15:50 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Marco Pagani <marpagan@redhat.com>
Subject: [PATCH] drm/scheduler: Use ternary operator in standardized manner
Date: Mon, 15 Jul 2024 09:15:33 +0200
Message-ID: <20240715071533.12936-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_init() omits the middle operand when using the ternary
operator to set the timeout_wq if one has been passed.

This is a non-standardized GNU extension to the C language [1].

It decreases code readability and might be read as a bug. Furthermore,
it is not consistent with all other places in drm/scheduler where the
ternary operator is used.

Replace the expression with the standard one.

[1] https://gcc.gnu.org/onlinedocs/gcc-14.1.0/gcc/Conditionals.html

Suggested-by: Marco Pagani <marpagan@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..02cf9c37a232 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1257,7 +1257,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->credit_limit = credit_limit;
 	sched->name = name;
 	sched->timeout = timeout;
-	sched->timeout_wq = timeout_wq ? : system_wq;
+	sched->timeout_wq = timeout_wq ? timeout_wq : system_wq;
 	sched->hang_limit = hang_limit;
 	sched->score = score ? score : &sched->_score;
 	sched->dev = dev;
-- 
2.45.0


