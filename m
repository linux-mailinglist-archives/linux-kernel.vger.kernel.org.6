Return-Path: <linux-kernel+bounces-240218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A57926A57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B674B234E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5358191F71;
	Wed,  3 Jul 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZG+adFp"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F8191F83
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042477; cv=none; b=Ai7Uh8K/ukNoIFPvz7L/abjRUVXgIr+uvkWIWKvZ6EdGAHlIYtlgs3vLb4TgvVX3A93XkTxeXggUiHz4ntZEsZjFOYXsRjTHWT/qLF/9e4InCXkfY00Amma4VpnTu0rsq9KAPBB7Ui0+hoZELKk1dUS/XowUeKGBB3Qr1bEIWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042477; c=relaxed/simple;
	bh=3SQBK7yezXO7kwWtIkmXEL2vpu9DXF5nv6k/vJUyD7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rfi54+mSVA+6u6A5I5gv6ngypPI+WKnpPJezaha0kyA6s0cxeHJ1/mr9U1ucC6axe+IIIyN2RIUzUgSN9iOio/nBCvDv6jK8W8JH18u68W4XzYqykLsG6EVk2uLOj3+rDkI1DK0W7UYrer8diuDooUagdZOGhZg7971Wl/tpX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZG+adFp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4256742f67fso42559325e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042473; x=1720647273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4HyZCOzf4z10ZJXfMbR5cXEKhv8Z4rIiQzSCeSlVJc=;
        b=OZG+adFp7ItEhY678btcyUdICjCuwcoEkPBfD141VbgBLJEYxe1qFbxlQI439n8FYy
         qqfWsanH71SEMvWIJtPGlUATbZ49bD5BZjwTi5ldm613e28jUH/8/k1N0Uvufam+zfCV
         JzqB0zTN2nLSuopKmduRMWQItzikSAu9TWPZbGqBF2Gda5h6LEg4x5Bojma62UOxQNRZ
         eeWAUHhqKASlHaWIM+CO+UmK8h73x4XU2mCp6F5TPAxzjhcwYUJfnrvrjU8/qEzSqIcR
         h5RMwfmr5M5MxAW9d/DFJRIEZhLqUr6wV8IkyXIz9dwQfbtfmtegWO2mNElTarW0ZyJ9
         GneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042473; x=1720647273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4HyZCOzf4z10ZJXfMbR5cXEKhv8Z4rIiQzSCeSlVJc=;
        b=o1Fsiwe1blNOOMjCfNYcMkMqmoNBk86H0fWpBO1RQKRQpQpPLzuQUtwCsBdd0oYo7y
         adkeWwGgJRnL+/VlMRK313TrkkPkOX4MDOpOo9HNDQ3yeZjSaSFnA/i1Qw8mJPCwSUrl
         7zaF9x37joiaoGwp1fcbIjE4H5WRUDsnOq6ULUoRT2hj67Vy6ZZ+9ypfvpf2rVnDiaVZ
         kGUPocQyGQcBvhf0gYgToqv4XtcGsQXVmoqy46dVSOgQ0iLZoAo0xWRIA8W+jggYvwd4
         f8HqBEeTMB9Pyk5gCefc0ejDM0bkqg3Ko07c9mBD6kO+7iQAAbO4DxVinv3rFvr868w1
         otng==
X-Gm-Message-State: AOJu0Ywsz/3fi+1ospSk7WJg9cnvkhs0aqT/9qQh0dO+5QIBBnbhVMeh
	RFj0Ix6EHCz5vW8s5w1mn69gZi/vR9/WEqBfKsGiVHNzVR1l8IwFyGnNgCQqSWk=
X-Google-Smtp-Source: AGHT+IEw7CV/3xqs6PgJNcAm2Pujx5ffrl2lLJW8OLIyI0HxoJFbk+M4rhephDDQa+Xg7zxMwmhjug==
X-Received: by 2002:a05:600c:3047:b0:422:4fcd:d4b3 with SMTP id 5b1f17b1804b1-4257a0282f9mr87750335e9.37.1720042472513;
        Wed, 03 Jul 2024 14:34:32 -0700 (PDT)
Received: from localhost.localdomain ([156.197.23.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9ef3sm16879690f8f.46.2024.07.03.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:34:32 -0700 (PDT)
From: botta633 <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] Forcing subclasses to have same name pointer as their parent class
Date: Thu,  4 Jul 2024 03:32:24 +0300
Message-ID: <20240704003224.22832-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preventing Lockdep_set_subclass from creating a new instance of the 
string literal. Hence, we will always have the class->name. This
prevents kernel panics when locking up a lock class while comparing
class locks and class names.


Signed-off-by: botta633 <bottaawesome633@gmail.com>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..df8fa5929de7 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
 			      (lock)->dep_map.wait_type_inner,		\
 			      (lock)->dep_map.wait_type_outer,		\
 			      (lock)->dep_map.lock_type)
-- 
2.45.2


