Return-Path: <linux-kernel+bounces-301249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97795EE33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF251F22B43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202A146D5A;
	Mon, 26 Aug 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pGLX0jLe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C61146A61
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667230; cv=none; b=BXpWPlfCPJWVk85Vv/Do6EarMu9f6J7B73Sfrx0P59DSde3z7S73UvM2NLeNbqJnEEpe4ku/8UtNgfDWpVw5ds+s1C6hPoVwyk2Rln4ztkWySA3a05QHTPr60uri7luxB4HsH0PnzR7rxcoYU0t/bOKc3zcoReiLxXnx7zAkFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667230; c=relaxed/simple;
	bh=TGI1HK/OW56cEnj1JPUc1WJBzzzkwO+nvRTtcy4SLXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw+in29XIzP/gsKGucGzgA0AVA5OGUqT2gn222pJL+pky8pY89xAgHhI6ertP+bq6k3ILBVGNjNJBMONZJYVZq9oplCB8JWMTut1YJXCxCS15RsT8UciyimjoX4Q+3q00YPnO0eeAuHdw4Yor/wLeKWNvNT64IOjUzapny+aUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pGLX0jLe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bece5b572eso657950a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724667226; x=1725272026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z07gjud24oTcgbqCvuKd+VAijUebGTMd0Q7+OuaVxsw=;
        b=pGLX0jLeapZsQoMYDZN9EpWZqYUQfS/fj7wbqyuzMmvBFyZqlqXjwNPh4+Nq85vxkR
         /j2XngqhiHobVnXA+EQ0UKRGv7I8T8Ev6NRDH3UWbAH/ka5/Con7u/J8Q/C3zM5lR5kL
         L6FfPkLvR5HmVbRStVbji9eKJV9/Uk00nqps7h/PtB4gGUOX7lwauzDsuXLicKzsprKF
         9nV/u4FIZ7BmixnVsFFsxaNGAfwlEF4ssOWBkO0smKnTUZLjkUbZkYm17yLxF9N5M6np
         3eNEuXEASy4nKC+uxqjB/0nSZTYEh0Uxymmx+NfkbBc9q6tuHDbd4jGb7OIe2J0Yyr9/
         94Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724667226; x=1725272026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z07gjud24oTcgbqCvuKd+VAijUebGTMd0Q7+OuaVxsw=;
        b=uMcuzkedr8Nr3Ee1ytOQ6HjqwUOVG8bzGy5UZRjM7uOP4xNrHOlU6XnjbaUml3eXPF
         3b7Siv/swnA/jaKYSrjV/fXzHkW2cKZn2bpUP5L1yIG1pzti7P9IGY+h1o+AbiP+M6Jd
         yT9IxGa1/PCmf92z77OcnZENWr/xgp60gw2FgebHnYnF5TLBvfhg4+wLQPIJw3C1r0g8
         jBkJeFfh/XLdUH0REQx6PucSGcdEKmG2jQj64RD6XPEJYv3SMJjEX99t/4HJ4IGpKdu0
         WqGtV7FyZdRObIN0+WPZB+Yu5Ona7vGEyay+GvTUmuPK5IB2GhSnaxNxwXUJdCOgmwfR
         6Pjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFHHZ2F6EKH8G351FXHVCHWKmPMokXaJKwhn+ZDcLzhPbkd1C8VHMimRF5ysZC6vgw20+LDne6iICwryc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RL7hKELTStuPys7t0jchkp8iR+OekmrTV/33m8f83RA6Lue4
	ORRCqW3knMrIOwCya7X64/Ltaw1GOnfBDJzWyZkypas/s3PpUg+uVF5WK7w3YTo=
X-Google-Smtp-Source: AGHT+IEV9jpKoiiBYyVHlySZz6WD5j5YMWpJxDl5FvTQKGNhudF6LglyA82Hxz6x4bVSQON8qEJw5g==
X-Received: by 2002:a17:906:6a28:b0:a86:8000:be46 with SMTP id a640c23a62f3a-a86a52b3672mr416511666b.3.1724667226265;
        Mon, 26 Aug 2024 03:13:46 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f459asm643856266b.198.2024.08.26.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:13:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] bcachefs: Annotate bch_replicas_entry_{v0,v1} with __counted_by()
Date: Mon, 26 Aug 2024 12:11:36 +0200
Message-ID: <20240826101135.31482-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array members
devs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment nr_devs before adding a new device to the devs array and
adjust the array indexes accordingly. Add a helper macro for adding a
new device.

In bch2_journal_read(), explicitly set nr_devs to 0.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/buckets.c         | 2 +-
 fs/bcachefs/journal_io.c      | 3 ++-
 fs/bcachefs/replicas.c        | 6 +++---
 fs/bcachefs/replicas_format.h | 9 +++++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index be2bbd248631..eda397c562f5 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -740,7 +740,7 @@ static int __trigger_extent(struct btree_trans *trans,
 				return ret;
 		} else if (!p.has_ec) {
 			replicas_sectors       += disk_sectors;
-			acc_replicas_key.replicas.devs[acc_replicas_key.replicas.nr_devs++] = p.ptr.dev;
+			replicas_entry_add_dev(&acc_replicas_key.replicas, p.ptr.dev);
 		} else {
 			ret = bch2_trigger_stripe_ptr(trans, k, p, data_type, disk_sectors, flags);
 			if (ret)
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 32b886feb2ca..30460bce04be 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1353,6 +1353,7 @@ int bch2_journal_read(struct bch_fs *c,
 	genradix_for_each(&c->journal_entries, radix_iter, _i) {
 		struct bch_replicas_padded replicas = {
 			.e.data_type = BCH_DATA_journal,
+			.e.nr_devs = 0,
 			.e.nr_required = 1,
 		};
 
@@ -1379,7 +1380,7 @@ int bch2_journal_read(struct bch_fs *c,
 			goto err;
 
 		darray_for_each(i->ptrs, ptr)
-			replicas.e.devs[replicas.e.nr_devs++] = ptr->dev;
+			replicas_entry_add_dev(&replicas.e, ptr->dev);
 
 		bch2_replicas_entry_sort(&replicas.e);
 
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 12b1d28b7eb4..e0880cb79345 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -122,7 +122,7 @@ static void extent_to_replicas(struct bkey_s_c k,
 			continue;
 
 		if (!p.has_ec)
-			r->devs[r->nr_devs++] = p.ptr.dev;
+			replicas_entry_add_dev(r, p.ptr.dev);
 		else
 			r->nr_required = 0;
 	}
@@ -139,7 +139,7 @@ static void stripe_to_replicas(struct bkey_s_c k,
 	for (ptr = s.v->ptrs;
 	     ptr < s.v->ptrs + s.v->nr_blocks;
 	     ptr++)
-		r->devs[r->nr_devs++] = ptr->dev;
+		replicas_entry_add_dev(r, ptr->dev);
 }
 
 void bch2_bkey_to_replicas(struct bch_replicas_entry_v1 *e,
@@ -180,7 +180,7 @@ void bch2_devlist_to_replicas(struct bch_replicas_entry_v1 *e,
 	e->nr_required	= 1;
 
 	darray_for_each(devs, i)
-		e->devs[e->nr_devs++] = *i;
+		replicas_entry_add_dev(e, *i);
 
 	bch2_replicas_entry_sort(e);
 }
diff --git a/fs/bcachefs/replicas_format.h b/fs/bcachefs/replicas_format.h
index b97208195d06..b7eff904acdb 100644
--- a/fs/bcachefs/replicas_format.h
+++ b/fs/bcachefs/replicas_format.h
@@ -5,7 +5,7 @@
 struct bch_replicas_entry_v0 {
 	__u8			data_type;
 	__u8			nr_devs;
-	__u8			devs[];
+	__u8			devs[] __counted_by(nr_devs);
 } __packed;
 
 struct bch_sb_field_replicas_v0 {
@@ -17,7 +17,7 @@ struct bch_replicas_entry_v1 {
 	__u8			data_type;
 	__u8			nr_devs;
 	__u8			nr_required;
-	__u8			devs[];
+	__u8			devs[] __counted_by(nr_devs);
 } __packed;
 
 struct bch_sb_field_replicas {
@@ -28,4 +28,9 @@ struct bch_sb_field_replicas {
 #define replicas_entry_bytes(_i)					\
 	(offsetof(typeof(*(_i)), devs) + (_i)->nr_devs)
 
+#define replicas_entry_add_dev(e, d) ({					\
+	(e)->nr_devs++;							\
+	(e)->devs[(e)->nr_devs - 1] = (d);				\
+})
+
 #endif /* _BCACHEFS_REPLICAS_FORMAT_H */
-- 
2.46.0


