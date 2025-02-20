Return-Path: <linux-kernel+bounces-524046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE5A3DE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9591893E01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD21FCFDA;
	Thu, 20 Feb 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e2O79qjA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CD1FC7C1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065099; cv=none; b=CKkTzHAFmN0vXAs5mZPUTJTaBCSoyoMr7VOtWWpMiOYE9KtuBSvGo7QSCcI2O2QczpP4qYbX2PTpmYTglRTvBQ5nJiCHckUe2zk9iYPgY0jR4ESXX/4GcaKQVsL4VIjvHABBdxSX2mDT10/TN1RPNNIE4UbV4cXTt4mw9CgNc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065099; c=relaxed/simple;
	bh=GHKtQKfRX625ruMmSBwhohcDd+91MZuTfcrrZYKfjbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCj8e3vlfwonxldISUigpHc3zqKpDWxM+bipfo9kZxMYSDAFK4UQ5qclaszufrvRAoUSEuAmS9MW6Id3T+rrjoNgcxnUDoDJ+RYab6ICy9hItGLRYyoRVDNEiHwHO6TbuFcNUFX0IvhN/T5wLsfeZ15uZK+YiCT1mVqv3GL/uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e2O79qjA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso179938766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740065095; x=1740669895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=e2O79qjAkEerP3tvld2a1wczWsVMeF/NWcmqhRFwwwKbRNl88p/wd/PtHCiZuguqls
         w9BSdfYZslQhBF18tWlQioqiCkrikva6wV/cFAWlNV4EwsaCYRs4Dy5jZauBTBp8stDR
         ZVOOGQGWoarGVLkPyihKtHmn72G7a2tDov3JfTRYuyoWTBjouB1J76pNufuF3eS2z1qK
         1B3rKxzq8Cj3GBadjzcPb5JwYuiKnNk0jgAe6InPgsGVXnOmOJdZSlcw+70V0bM1pKMV
         AehqUyrcMdEUTePUumdG/FoOFjfpy2Sa00BtfOVwjfTH76LsmlVKfreprfz3QaeVegoD
         SbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065095; x=1740669895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y956Nga+wi17KckdN9/Mw3XRjcXaF3kNwC0PxZ5/5C8=;
        b=fFq2atMHF53WWCG6bh6DBMSOd7JCJgiWSUI2Lhf4hsDu+PLHlHiDH+HF3oRc9PdLYG
         OcPjgIyX7Uw0/EqsdY6fnFwcOfAakfZNje/KN9iRCmvUgdRtGMfz6crIKZIJ8wBAIJb6
         lxMu/mpmqGYY95YDAbzxbANIbRTfJfB3iqrJf5/U9KkE6KOtmM/+q3+bIZQfB4+Ow9rJ
         WoIsV+9jd3BWhYJcd1cRLQhbnjFkSLEE1Kp2MtEWpJAh1LcVRbFvm6nSras1GbDZgwQo
         48S92p9rffzUx3DsIT64FEZfHeR2+U+Kj67fqrEu6gQdh9zB216bDA1W4FVgvjXzo85n
         kwbg==
X-Forwarded-Encrypted: i=1; AJvYcCUuccrrSGIjEd5Xz7QDn27+oJBgsmc5iVMKvF+IBM+NIyBGYzCfoRk0qdy6DKbTl9zZsp98M8z1KVvw7fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIihHURfYMHDv/q7iJ4QbsFaAZuIovR9Ry3mJ52stLeV6KRi9
	3/djF505FZAedmvmbYpMfxKrSKFVIpxe4/fBMui21qoseuY30eEwwxiYeGJcYNg=
X-Gm-Gg: ASbGncuoWbTiYN5SI3i4PymMt4saFqEg1B9gFejIZmxG8IKSB3oGfDhbtYjBNhyLaOb
	ETQE2HMPYy6VLqDDBWnJnroifbtedw0zuewnIVJ7WgFcsPh9vatQj9biVAFjE29DKoimiEIXPuK
	hPWc5PftPlehJYwBrjPubxWPDJu4QKgyh6QdhC2u+mGe5v4CrooBBmgktS3O1W+9NKoCjDfE2VQ
	SWR9bjy9N3S4/S3dXoInstg3nkClDdk47ct7azsr6M8TUfjYQOA5ycPi9+OYVkXrX/wGh4IP4uD
	pSuHLgYxFLCUaUUjxf4ID5eMn1E9r+0RXsfcc94MRkVtjLsIny6mtuQKhAAPz1QXAQCZ3LH7/EZ
	rrmjk1sik1HbuKCA=
X-Google-Smtp-Source: AGHT+IGpFy9Nqr+lyOCNzWNyFcfvqTsorGUY2iR8cFQABQ8lCUVSSIHVamd16JAap5iL/T/ZJ53L+w==
X-Received: by 2002:a17:906:d554:b0:ab7:ef38:1277 with SMTP id a640c23a62f3a-abbf3885ecamr256927166b.26.1740065094910;
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f007700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f00:7700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9f3a695dsm751274266b.2.2025.02.20.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:24:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Date: Thu, 20 Feb 2025 16:24:50 +0100
Message-ID: <20250220152450.1075727-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple subrequests donate data to the same "next" request
(depending on the subrequest completion order), each of them would
overwrite the `prev_donated` field, causing data corruption and a
BUG() crash ("Can't donate prior to front").

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 8878b46589ff..cafadfe8e858 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 				   netfs_trace_donate_to_deferred_next);
 	} else {
 		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
+		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
 		trace_netfs_donate(rreq, subreq, next, excess,
 				   netfs_trace_donate_to_next);
 	}
-- 
2.47.2


