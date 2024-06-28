Return-Path: <linux-kernel+bounces-233260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E104A91B4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897881F22687
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FCA1B7FD;
	Fri, 28 Jun 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jotAnsj2"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98118029
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540620; cv=none; b=iY3s6xTwtg6B88HF9aagDp/nin01S2C+oeO86nG+lk9OzDnwSYpFq6n3hGSPaXh59guqUTlcFtTMv7UyBjL7+r3GW1Y/hbUeJ7j4FHErUIsbkH9haAnrdczaxXkhbTXZAkw0gu8LauBDNaMCYCT6X553nU9ixIOAwqMc2Df8cvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540620; c=relaxed/simple;
	bh=6yiGXrB5WtL9mRt6YBmtrD9asCT50HPAQlO2zgkhSto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O07ZZs+BHIDUnGvQUFn31958uMslTmOvbWeq++ibPHr9rv8mC1P4yRJgmWRbs9gZbQqtaFnyCDfCAUti8IYyBTQZycxIXlBFhOXFUoskiEq9UKtBRCbcGJbjpBcMaIVvo9dHBVHDvNEMd5yxK5HNI1AgGAaZ0g6oiP4IcsOSyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jotAnsj2; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7ebd2481a89so11076439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719540618; x=1720145418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVleDmTKwwvHatuvVD4VDvqXq7pEzrykFrYLhY8PmD4=;
        b=jotAnsj2baUncnsjNINZN96vbggCy0tJern2x2cYITbU/cGau3CiokiKlzcA/TmIAN
         9Wh9W9dsv/Dkm8cQ2m4EpCO5EayBzaWAFoH36k+xq5mwV+IiXY6TvfMqjsSaCLEHfU5y
         m2TrkHt04qkc2JUWsyfZwgaG7PO29z4Tyduy8BTx2BN0E1MRgQls7gnlVdsh1wvt1CWH
         FOCsUoXXc5zcy6B/o62A40RQhBCvLzCwr5bwk2GvnLFzzBeHrcQvCVeMes12zw9iARxh
         WHZUw2UK7VUu7FCAJ7Q7i00kd/jccoimRwCrhXEFuyd7dNAM1qdfhk3X1+uOnAc+zaRz
         9Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540618; x=1720145418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVleDmTKwwvHatuvVD4VDvqXq7pEzrykFrYLhY8PmD4=;
        b=aV1SpG4WZfEdXZymYuD8D0dVRc/hvOSpb5h/UP/oy86EMnRKcu+3Z8HGTvcFzjFuOU
         xbS60D+YmQUM2+kIa4/dO+zyK/RxlEHRy0F557a+jwrR6RtIfKGRC+WEYWyXU6rGpwko
         V/jBjqyEkSvs/b9Msu7g6gvXNMCH7mXUawFFAvMn0Xk4RuALGNdV82Ze1T8g7mrguCVL
         QI1sQOBMW3ZvXKXxQ/aHSqLD8YqOQS/96uO5/90SpoG/lYTX8EqbfRCwDeqvSvdGGa3O
         WeSr665Z9Q0+aTz3/nDnWd9vDu3X0NdXmot/FHjFj1PkEN+PzXkpKOGhs27xzu+Y5Wja
         6VOw==
X-Gm-Message-State: AOJu0YwN6XBGY4ci2D2u48trz1NUcJ4zaCCpe952oXMAWBSB5EIskvZf
	d4c0XG3jai7Cgf1R8G/q2DgfVSz+A7yy/CoKbyaGB64melE7rOet+w0JQ11Kxn6JXv/q0O7FxkK
	dDA==
X-Google-Smtp-Source: AGHT+IEpN/fmeg09QXYmRk76jlfhToz/dYyee0JzLxmQtyTpf1T1lmG777C8U6WhFAylTvCpUNKFzxyYeLw=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6602:340a:b0:7f4:10e3:1671 with SMTP id
 ca18e2360f4ac-7f410e3190cmr9772639f.0.1719540618202; Thu, 27 Jun 2024
 19:10:18 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:10:11 +0000
In-Reply-To: <20240628021014.231976-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628021014.231976-1-avagin@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628021014.231976-2-avagin@google.com>
Subject: [PATCH 1/4] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all
 users have exited
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

SECCOMP_IOCTL_NOTIF_RECV promptly returns when a seccomp filter becomes
unused, as a filter without users can't trigger any events.

Previously, event listeners had to rely on epoll to detect when all
processes had exited.

The change is based on the 'commit 99cdb8b9a573 ("seccomp: notify about
unused filter")' which implemented (E)POLLHUP notifications.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/seccomp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e30b60b57614..60990264fef0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1466,7 +1466,7 @@ static int recv_wake_function(wait_queue_entry_t *wait, unsigned int mode, int s
 				  void *key)
 {
 	/* Avoid a wakeup if event not interesting for us. */
-	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR | EPOLLHUP)))
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, key);
 }
@@ -1476,6 +1476,9 @@ static int recv_wait_event(struct seccomp_filter *filter)
 	DEFINE_WAIT_FUNC(wait, recv_wake_function);
 	int ret;
 
+	if (refcount_read(&filter->users) == 0)
+		return 0;
+
 	if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
 		return 0;
 
@@ -1484,6 +1487,8 @@ static int recv_wait_event(struct seccomp_filter *filter)
 
 		if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
 			break;
+		if (refcount_read(&filter->users) == 0)
+			break;
 
 		if (ret)
 			return ret;
-- 
2.45.2.803.g4e1b14247a-goog


