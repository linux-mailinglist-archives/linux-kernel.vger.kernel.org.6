Return-Path: <linux-kernel+bounces-284610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52D95030A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7D1F22D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1919D095;
	Tue, 13 Aug 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Xzery2+L"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461219CD06
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546416; cv=none; b=N2/W+ksKh/xyD5yQvUbI/fKAdJSXc7A1u5XsNT9tOHUDTCjUAoxLwm3uE6fNvzJz7e+JZnGXwV1zztU9XfiJ9h3lUzCgnnzthQ+K1gDAC8vBQ7rSX9XSWh1SUz9pGP+kfHqcXU0mc2YJLPImUk9zY+o5RxUK1f20olcMhew1nxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546416; c=relaxed/simple;
	bh=afPCevgdcFFsmtNXdZ850iNIr+9bwUzdnNja76MSoeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZwu1Ga0Hai5VhM4ut7xPoENViCcpBd+OFr6qyU8NiBpJjLGgsSDkio6QQTp1EGJjt+isThHWnDryDb4h2kh86ef6AtOKlp7hNSrtJk+3eJeFEf+zqXE+JYkY777YTmnL86WNd2aSlH4cbqKKPtLKcj8YB0qVXFu1LUhNHW91Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Xzery2+L; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so6313197a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723546413; x=1724151213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mL6WsGMZ/qoNr9tALWa0VvXLLfikjSA2GI/ckscWigM=;
        b=Xzery2+L9GTbsweFcu9MEniP2hfFSf8xyyAKRIn4j/ABH4kn0U7g8HCMj8Rf39GNU1
         7GW0SBzSD+eBXHOrfaNxH0FfcY8x0s4P3bbn603Cx6szkM9Rb+LJXDw1rD8SFRxu7vyr
         8kbDh2aDgPLBRRLD7LaWE2b1f6+DsAFSBOHkVTLUUFd4PA9hsXqNM8cH3edEVOnXBAy9
         NBnqz13xo+BU15CBwFD+Ie+plgALGT5NJe1+qDC++vBBlMaWZ2c5n0yDBYdFZNp85KGm
         z37hc9IZg3vqHzUDZYuupdYY1F2LWiKHs/XctM05/z87CsUCU8aCszO3AQekXVbHZGOY
         oAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546413; x=1724151213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL6WsGMZ/qoNr9tALWa0VvXLLfikjSA2GI/ckscWigM=;
        b=eE0KNGWqLrH20HELf4kpNJRRLvQP0ehjHFHAH+KuPMfqM3b5fFWp1akkzF5HgnPLIf
         d4kIZjKnOrfvIL1aNO47e7zYZ+dU/mzAiZadwJSAOCMs/4JWNNragVr0DBQTUly5+ygM
         tlUdWu5aWEZ2aC80757d2KbHsq4WYQRAZDgAfFibZH8pCdA2GP9eKBz70ObZqGKcgCep
         7vq9mp/9OYbouzDosRsnKUZwnK7Qq3HpnICUUSi4EKlgjXlAwsNf/dmULANBfAoZFrUD
         e4GcFbT+ZnXNbjXzznb6hGQpCotfs4Pfxg3ldLBlvnCV0Mu3XdyUaI1+N7pX/WJv4bDZ
         ie7A==
X-Forwarded-Encrypted: i=1; AJvYcCW0iWtJdnaPxEsZZJtgF8J2O4x2pmJTNa/TGm1n3N7OVATJh/p2H0ENw50SlC3ihKeczwMo64wlsVt+PhAoYGdDkjVVmzulu0K12mRb
X-Gm-Message-State: AOJu0YyAClqBYuVHGdBrBG9M+tOYE7qLjK3bQXnIShIoCojOp9inj8yb
	VaUnnR+l4DrPD2LxCeE58FKazPrfzHr68dQe8ND2h+GLFt8lRCVyncwUGsHhXfk=
X-Google-Smtp-Source: AGHT+IHVjFzXHfV3YKBeYS9Fv1QrhBgZvi3taudAr8E7H76pEBKVWSjmLKsj+27p/1JROgS8BDE4Kg==
X-Received: by 2002:a05:6402:5112:b0:5a3:55a5:39f1 with SMTP id 4fb4d7f45d1cf-5bd44c274e2mr2274219a12.13.1723546412549;
        Tue, 13 Aug 2024 03:53:32 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f2c82sm2847889a12.14.2024.08.13.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:53:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: Annotate struct name_cache_entry with __counted_by()
Date: Tue, 13 Aug 2024 12:53:15 +0200
Message-ID: <20240813105314.58484-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..de185b23cfd0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -347,7 +347,7 @@ struct name_cache_entry {
 	int ret;
 	int need_later_update;
 	int name_len;
-	char name[];
+	char name[] __counted_by(name_len);
 };
 
 /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
-- 
2.46.0


