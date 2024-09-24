Return-Path: <linux-kernel+bounces-337517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D6984B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F691C22E43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037CE1AD9E3;
	Tue, 24 Sep 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wybKm1ld"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DF1AD415
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203453; cv=none; b=fTk31mCfLf48GcgIXHB2bJXE3bhIrfkHa51CkwtlSx1SNGhY8wbAfWfBwIWV+YEw9BUZ87OqO+TL6hsRrHZ/VYsTNDp28IrnMZlVPmdldCQ85+q8l6toQU3s73F3TWpAX0T9IvKf5ma67FXs47RouTGH/Ei5rQ0qLFkvNjKO0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203453; c=relaxed/simple;
	bh=HZ1COR0YGONUxe6LALXOBsTQqR3jecbdCznCpBgsKV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rFY5ibkWWNL25phwaskSPFtBmUq1jtcvqPN0voOlQ4bmycmz6b3+bsBbrNMd3b/CKF4SpA9f07n8kjLvxCdAT6Zh3NaIu7Vfjj7UOQLubkgGGtkXqMPXjS2sBMLIh+l+Ba7WBtpd0Xn3zCiEpLh7dfZ+BHYSrAz6vy3hNc8iFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wybKm1ld; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2146737ccso14405757b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203451; x=1727808251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=opL/u+rXDPzP8jgIWM68Kz10UL7QxmAwA+KsygDZ6JA=;
        b=wybKm1ldf4yJzCJhqH0kNEA+NV/mnTBqNVhZ706jT0BM0sJASAX+iBeY89/sxTECgu
         udmKoPJiwa5UmwGYXrQ2danBJ47N8F09djOIJ30UlbBAwUniNRi5PjwnaMjfxDo1AKiW
         731+veTVkdqFs5zpoTOJRw0VIG2RaNNQ7bxH/YqYLZPihWdWtJrWXp3w5/zaz+3jbEm/
         ERNDNYDjCAAC6ep9IA6OwbOidwv9NLg00mYcMqNWuL72uZLqsTL5oAHXQ8G3fZkxxzB4
         omiwOYntqEobr+VcECAvAWN7WJvQkkEXVWO07uH+78yT3IJarDDhlKBmfNUNnGa9XiAD
         hQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203451; x=1727808251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opL/u+rXDPzP8jgIWM68Kz10UL7QxmAwA+KsygDZ6JA=;
        b=jH1yEzpJAd/Uq5S2P1jaNieByTNPvF8cE5jxFeLnInYeZStA+EUCT58TKsu99vxMNG
         JbvdHnpkhCkrcIT8yPD2pDm+2UOnLwWY72cn7yekrVFZTWTaNYbbeCMLIZTIw8Z99r/Y
         PVGH5wiTSeVDzUzWhB1M3kQM408GozQYEAkqLPUzjb2co2+lFpQvbSF6EuPk5/t2Oq8R
         /GfoGaFkfQx0Bs1bOI7BKt/PSUUU9O22hIlvFI/Dv2FkmdxSj9HyHesmdRSskyB+jUR0
         9Cl6eYpsAFd9v7mzsuQu6f+NCOGnbYPbg4J6ZRza1ZbqSLjWeGZBZTrO/31sm41Y+U/8
         azgg==
X-Gm-Message-State: AOJu0YxIua9w/GmPmqRZhA0TwuzkNyiC44pBrP0AcbK2+dPnKCA/wPh9
	wGFcaq6q/PBNSdaNJt69ofTsQEIHZRN+uGcUZ0qWRqQO6TlVMExu4I/YLlMvN9Jo8BDMqfjFE3C
	g36K8ZAjLBQ==
X-Google-Smtp-Source: AGHT+IHm0uPwL+BamoIvPtwKlIEqmPJHv0+Z7rowDrFzsw5n5EgUKWZ1MOEFlvHEOZosOFgTFgCJdSpj1QLADA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:2892:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6e21d6e1f34mr31987b3.2.1727203450911; Tue, 24 Sep 2024
 11:44:10 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:55 +0000
In-Reply-To: <20240924184401.76043-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-4-cmllamas@google.com>
Subject: [PATCH 3/4] binder: fix freeze UAF in binder_release_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a binder reference is cleaned up, any freeze work queued in the
associated process should also be removed. Otherwise, the reference is
freed while its ref->freeze.work is still queued in proc->work leading
to a use-after-free issue as shown by the following KASAN report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_release_work+0x398/0x3d0
  Read of size 8 at addr ffff31600ee91488 by task kworker/5:1/211

  CPU: 5 UID: 0 PID: 211 Comm: kworker/5:1 Not tainted 6.11.0-rc7-00382-gfc6c92196396 #22
  Hardware name: linux,dummy-virt (DT)
  Workqueue: events binder_deferred_func
  Call trace:
   binder_release_work+0x398/0x3d0
   binder_deferred_func+0xb60/0x109c
   process_one_work+0x51c/0xbd4
   worker_thread+0x608/0xee8

  Allocated by task 703:
   __kmalloc_cache_noprof+0x130/0x280
   binder_thread_write+0xdb4/0x42a0
   binder_ioctl+0x18f0/0x25ac
   __arm64_sys_ioctl+0x124/0x190
   invoke_syscall+0x6c/0x254

  Freed by task 211:
   kfree+0xc4/0x230
   binder_deferred_func+0xae8/0x109c
   process_one_work+0x51c/0xbd4
   worker_thread+0x608/0xee8
  ==================================================================

This commit fixes the issue by ensuring any queued freeze work is removed
when cleaning up a binder reference.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8bca2de6fa24..d955135ee37a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1225,6 +1225,12 @@ static void binder_cleanup_ref_olocked(struct binder_ref *ref)
 		binder_dequeue_work(ref->proc, &ref->death->work);
 		binder_stats_deleted(BINDER_STAT_DEATH);
 	}
+
+	if (ref->freeze) {
+		binder_dequeue_work(ref->proc, &ref->freeze->work);
+		binder_stats_deleted(BINDER_STAT_FREEZE);
+	}
+
 	binder_stats_deleted(BINDER_STAT_REF);
 }
 
-- 
2.46.0.792.g87dc391469-goog


