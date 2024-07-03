Return-Path: <linux-kernel+bounces-238762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A1924FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAD928ED01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67345028;
	Wed,  3 Jul 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxbk4nCG"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13C39FEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977785; cv=none; b=lyQtjsWETAVZJxKDh0fXav2bAOL9l46KfMztQE/YtHydE5+QWvFF2uPg7Fof8STVhceNd8/kFkOsYTdpvyTcJocC0YLv9/9FWk+BNzspwq3iTfg9sMWCkmzcyBMUEMZo0zYTNRFCheHaJseciInYtluL9QiePOK/KP1jrXKiScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977785; c=relaxed/simple;
	bh=QeCToHbPzWcpfWXXN0pXnJv0lCpyhXKVWAK1z/fEb7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KI0XuhAWC5NpMLN5aA9zBcnuCyZYiuYKl4Ai+kcxmP4XVl6+3OYE7r/VymNslYPNC2Uf4UCSrfzSHLvL7QutCAMgna6ie01y6aDn9N3TEsbmEWQ84JO8Jef37MvT2LBSMO/RSUHiw1pVyEg+w2vzKI3JarOpQEe3jP56OxdazQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxbk4nCG; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03b0e73f14so7253276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977782; x=1720582582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvgJeZKGGm17GDbCpMSw1b9wVEFwhXIl35XREnILA4o=;
        b=Nxbk4nCGinfAYrtWFYIkFCZWs5ZAyaavpVl4zt6PAUl0KFRjRbKhFUugD0o3y77yhi
         C+p51xVN+ce62IXMHueiCGDpbA4qw3EB3W8jPhmQkyIqXrYuvYCCVYfPARd9MQIAkKBR
         JpzbOZAsZtzeXI8o2fzuo1uthykYdzum+nAx2q8m7s9zw6xdbfV/Lx2RJFuIPiXkquoK
         8KPCgTqNywYgMhiN0NzzXPi/y7B4SeZKN+I557Vz2wUg5L5ekQxgmH5USwWU6X0wCpVN
         y5pws+k7FBDq7MZlPyYb1us0ZaeXOQSb+09dilhzWexK/RxH3+X26aCqojiNfun0pHOA
         9LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977782; x=1720582582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvgJeZKGGm17GDbCpMSw1b9wVEFwhXIl35XREnILA4o=;
        b=HvSVE7wg5OERhMMWsNdLyIwA/v4XTsJo4cuMXrzbXwQdqp7uiCmzYJ7mLKPF2wuVQJ
         oLyuCyAQir5AvxmjEOmO1mAMkRtXOLNp31xkbP+DbzChLE/pXFpoo8jWA2gP9IDJz/wv
         FxEQ7qivgagk8hZ7fnqKLXin11V2UY+K5jUcMn5yzuQHBtKvqgqPWjh27QQ7cEYi9DFC
         sRQ4aJZy0eW+yq6V+a+WSb1Z/OHgKq2+NG8332cbI62oQch4dCj4SmFvwRnIMQTvhWej
         oVm9S+SDRfZDaQcSsN0yiWeYzUkMI9tIJQESXdr/cywgAuNQziB1AZQvH98AAhJ+woej
         Aq9Q==
X-Gm-Message-State: AOJu0Yy/0JlyoNp5j1h1D+oPJIYuQ8ANXlfwEG4BydoFcNuaw1J0b8f1
	tgHhYpbQroxXjJ4rfIFyGgPqRylONxIkxtxCSis91oPFFO+uwopEM/5kxw==
X-Google-Smtp-Source: AGHT+IEMxrB5TU29/Sg7Vd7BZZpIeNwKEjqmuJYkr2a2JsIy1hWgorAseX3NUmjTy2OHvdVREG+ddQ==
X-Received: by 2002:a25:ab32:0:b0:e03:a4ba:856f with SMTP id 3f1490d57ef6-e03a4ba8622mr3241381276.53.1719977782470;
        Tue, 02 Jul 2024 20:36:22 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c9e0ee3sm7250544a12.60.2024.07.02.20.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:22 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/6] workqueue: Init rescuer before alloc and link pwqs
Date: Wed,  3 Jul 2024 11:38:53 +0800
Message-Id: <20240703033855.3373-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240703033855.3373-1-jiangshanlai@gmail.com>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Swap the order of the allocations for rescuer and pwqs to prepare for
making alloc_and_link_pwqs() and the wq enlistment into the same
wq_pool_mutex and cpu hotplug locks protection.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0dd9a12befb5..810ea55c0ac9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5704,11 +5704,11 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 			goto err_unreg_lockdep;
 	}
 
-	if (alloc_and_link_pwqs(wq) < 0)
+	if (wq_online && init_rescuer(wq) < 0)
 		goto err_free_node_nr_active;
 
-	if (wq_online && init_rescuer(wq) < 0)
-		goto err_destroy;
+	if (alloc_and_link_pwqs(wq) < 0)
+		goto err_free_rescuer;
 
 	/*
 	 * wq_pool_mutex protects global freeze state and workqueues list.
@@ -5730,6 +5730,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_rescuer:
+	destroy_rescuer(wq);
 err_free_node_nr_active:
 	if (wq->flags & WQ_UNBOUND)
 		free_node_nr_active(wq->node_nr_active);
-- 
2.19.1.6.gb485710b


