Return-Path: <linux-kernel+bounces-402570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4909C2923
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15016284824
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F604770F1;
	Sat,  9 Nov 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="SJM1fV2i"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AB40BF2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115740; cv=none; b=e69JFuMUD3ahS1EsrMiPzr98kfWiRrBlDLCbXQ84P0LVuK9jRH3xCKvGPUtMyqJeHvKU9LW+FKUGrFa7X8QzgOBJpcjmG/FQvfw4bB2nvK4v3tT2ORCCa8f0eFWwSHmFPzuyPLmA1VzzUIwB797rEq9qW6M76v1z/NeMLtpsyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115740; c=relaxed/simple;
	bh=2V+LMyhP7QCx7vipIrK/PNDo/NUYimbVbH9Zga/QRnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGNnLONdqzDyQKZszGSJjfHz7Z2PEUtI5M1S0bsCvfSqpQNVHpfSlE5wh+mqTP/LA8IyzMyRu02MRhB6SxLFfX5Zpvxr8QMV9pB/hW9WtJ27LfQamQkyzzKXlUgFhmYNCBAkqOywqsQPPAsmt8oTThAikHmZlYwV63cqWrMb00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=SJM1fV2i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb8954ec9so3701035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115738; x=1731720538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOqgPPtziEx8SGLaOYb14oaOw/i0JcmNn0bH4qe21tg=;
        b=SJM1fV2i8umSzCb58koP7j7K+NELgsaCQQQH/MkptEuEx7pohw8Zvrn2gBl5q+9kTN
         740gtHf9rrk60l0atKcx41Hw9dEeaOoTz3lTLcdJEA8JCmrh9he0hQ5P62EvXd3IM0Lm
         U2oKGJFSbo6qHB6N3d1UZzZK+VgnjvOtpRTuqAdvwSoZvEyGaXzytFDCeh682XHxCNsq
         qgBWC3nPkRI6z6DkDwZyNDrUxyalAuw3qwC0xDRHlVt8F+LhnxPJ6g4G/gcolcMJeGTH
         /WB74lgTewunqEfl7neoRJTCejvuudZRffnm/JTSoLDOxdD8L6nLlKLaFD3INJOW0BaW
         rEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115738; x=1731720538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOqgPPtziEx8SGLaOYb14oaOw/i0JcmNn0bH4qe21tg=;
        b=SlkVr0s46si9JEolS64iMNol0ouKHNbp08Kz3BPW1W36rsIUpMp5s7bNJ4ti+18jel
         puXJZgueP/Zkj4IUe9/+CyZEUwkOJ74N12UZNg3o6Bi6I0cc0Miy4trRf2BUD0T3Lf3J
         jDrZ0h4LD7dkHwgSMYtQecWnJ3MLZLBYMmgG2OV5rnNIvwR65fs/yH4pK8kXE0eeGpPA
         7kR225WGveXWVR0rCZHVD1Kvwjc375pghB7SXC+4LPLuUK/vqXoKx08UTpHhsMrPnYyH
         tPnNJh+7B1xnRIaOSnsEgcPVWgwfcSv4EyXe8TeRQNNRXQ62yjVCKj9NAF5BmDwdHmY9
         O5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9ltOeoowrfVe65ZAK7KMNaSsvu5PvL9L+z0llFfxeV1OfOYOx7eEI9O1+C+VlivaR79wFxRkFmuhKWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswNF39WhSGhkc/RJTmrFox+3d+O6CcP53zq2vXuhbkh7sJkYx
	RPnQA6OPa4wDKqQpyNauXi6x2Xc/GRky8ESZR9H14R2X9Y7XiubcPGeGNXIjooc=
X-Google-Smtp-Source: AGHT+IFOd7MaBqO9qvnNSmqC8iCKDohmW0xsMff0WgR9ONvpPAG2Els+t+TmPhLbjIw8o7WypoTk7g==
X-Received: by 2002:a17:902:f68a:b0:20c:e169:eb6a with SMTP id d9443c01a7336-2118357e1b5mr27424505ad.10.1731115737917;
        Fri, 08 Nov 2024 17:28:57 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:57 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] proc/kcore: use percpu_rw_semaphore for kclist_lock
Date: Fri,  8 Nov 2024 17:28:41 -0800
Message-ID: <83a3b235b4bcc3b8aef7c533e0657f4d7d5d35ae.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

The list of memory ranges for /proc/kcore is protected by a
rw_semaphore. We lock it for reading on every read from /proc/kcore.
This is very heavy, especially since it is rarely locked for writing.
Since we want to strongly favor read lock performance, convert it to a
percpu_rw_semaphore. I also experimented with percpu_ref and SRCU, but
this change was the simplest and the fastest.

In my benchmark, this reduces the time per read by yet another 20
nanoseconds on top of the previous two changes, from 195 nanoseconds per
read to 175.

Link: https://github.com/osandov/drgn/issues/106
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 082718f5c02f..f0d56d000816 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -69,7 +69,7 @@ static int kcore_nphdr;
 static size_t kcore_phdrs_len;
 static size_t kcore_notes_len;
 static size_t kcore_data_offset;
-static DECLARE_RWSEM(kclist_lock);
+DEFINE_STATIC_PERCPU_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
 /*
@@ -276,7 +276,7 @@ static int kcore_update_ram(void)
 	struct kcore_list *tmp, *pos;
 	int ret = 0;
 
-	down_write(&kclist_lock);
+	percpu_down_write(&kclist_lock);
 	if (!xchg(&kcore_need_update, 0))
 		goto out;
 
@@ -297,7 +297,7 @@ static int kcore_update_ram(void)
 	update_kcore_size();
 
 out:
-	up_write(&kclist_lock);
+	percpu_up_write(&kclist_lock);
 	list_for_each_entry_safe(pos, tmp, &garbage, list) {
 		list_del(&pos->list);
 		kfree(pos);
@@ -335,7 +335,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	size_t orig_buflen = buflen;
 	int ret = 0;
 
-	down_read(&kclist_lock);
+	percpu_down_read(&kclist_lock);
 	/*
 	 * Don't race against drivers that set PageOffline() and expect no
 	 * further page access.
@@ -625,7 +625,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 out:
 	page_offline_thaw();
-	up_read(&kclist_lock);
+	percpu_up_read(&kclist_lock);
 	if (ret)
 		return ret;
 	return orig_buflen - buflen;
-- 
2.47.0


