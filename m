Return-Path: <linux-kernel+bounces-246831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499292C7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382BD284338
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0585F8BE7;
	Wed, 10 Jul 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="VkkZlJLj"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59E1C32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573556; cv=none; b=GTQEkePwjkdgzYBfxiIALJUYawf3pTVRnje3c9To56TeJoLkKh3ACmGiQxdtbxJO/pkmhqojfrJRA/epabWCJvLlpYP43+BqZO6B0CsNSb4K5GcJBny6ST0zukV1FnTj+jGpvaAip9ef3pyQdhTs3D/yaMNBymeNXYag6wegOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573556; c=relaxed/simple;
	bh=I1f4+j4VisWyCO8PAlPOE6YvEt3S5WJBq4/Lkq0Ma0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAoQQAwkJphqBMHFOuclUeclhhT2EF658tJw/vx98otgC1QZ3jtUHwhoW1GIr1P28NWTbGk/XBzUBin2xCUVbFUSPRCNnpsUYLpD6YkHRcwG1HS+n9pZ+6pe/Mg/3Ecd5tVCDckK7F6ap7rHJHHJIBe8WfrNrXN3idfpgMiaReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=VkkZlJLj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so6363113a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720573553; x=1721178353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZBbgYfrOWaQkS2J4LZroamEeK4UJ6L3MdngZigAzGk=;
        b=VkkZlJLj0PmMz0GvhHFYhXMc1kV1BF5S6SOhDwEsFpeQx9/cbWsNwLwpREerx0xwqs
         v0iKQiySkxmISN6ZrFgDDA0d7VWNySpt3Tq7UuAPqXI5Po0ktWD5uCZUJG+J/TTH1ddw
         j64DElYMUmtASBZ95QOSaMofpT0iHU0YzXlf3XcpXmMfvbdm38yycfKVf48m/Fy0utYE
         qmI1t3KsNUN5nIG5UMm7FLbSA5QvLHLwKIUtDL9ZHljM4/PK+ZIwqUM9jnuwRpr953p0
         bTsRyli3dZZJYuZ4KzNLP46E7VPMV/RRjER9qcBYm9p/Zfz/QtBY6XMQ3JnAikd//cLh
         L0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720573553; x=1721178353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZBbgYfrOWaQkS2J4LZroamEeK4UJ6L3MdngZigAzGk=;
        b=wDKguyAauSQfM0f9PdSw6mqpqZydeBKVAavP+RnXFO8O9eNY2Xtn/9b5U8ULAk1LU4
         Yu7vZL3zyMqI6ReZnDQyUpr6zoC50HbEvLJ3qW80WHoVkY2pFj/M7+/vPccHaSAbPKJe
         nD4dw+DgNsUJq91ViaoJufRf/WX+Xgo37ryGEIeFYTlSpRqNu7dDdNOQQ3GUMeqd6QF7
         OkwnnOl4feuUNHg9vHqHc2QVf//dKLpvsQL0qEYybVxBxFzMwwp49f98YJdFa5gPgZs3
         EAX+wsOWZKIUFXZt8Y+k7j15p+QazlPycHQ8sfFAdkVnsbz5QRk0+U4CuUmQWPciylQs
         DgXg==
X-Forwarded-Encrypted: i=1; AJvYcCVtvaL6auBJ7K/AMz0ERN4k4sWfojzoq5Fcl3chGZeMlQodi+uz2PA0Dqy6NOMBIouc57KHTjeUQfT9O9mdhXGWHWQNwcWynHq6fhQr
X-Gm-Message-State: AOJu0YzcjDMRY850puUMashyO2VIwEL6lLrLY/IWVEm1hlwlCoFy9/b1
	uzaJhz9NoO/W7YkbTu5xHzbnqtuT5rgNUKdteqFTNqwOA1KyKSmyuBpA0qkZXSs=
X-Google-Smtp-Source: AGHT+IEUZiU9U3tjKwZHU6jK9LXVcFiV2eMAM+tftl8C+0qpsA+pViZFKnH+2vEYoDdFVGAkUjkINA==
X-Received: by 2002:a05:6402:288d:b0:58e:2f0a:d5c8 with SMTP id 4fb4d7f45d1cf-594bcab1593mr2124090a12.38.1720573552910;
        Tue, 09 Jul 2024 18:05:52 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459aafsm1625844a12.78.2024.07.09.18.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:05:52 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] io_uring/napi: Remove unnecessary s64 cast
Date: Wed, 10 Jul 2024 03:05:21 +0200
Message-ID: <20240710010520.384009-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the do_div() macro casts the divisor to u32 anyway, remove the
unnecessary s64 cast and fix the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 io_uring/napi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/napi.c b/io_uring/napi.c
index 8c18ede595c4..762254a7ff3f 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -283,7 +283,7 @@ void __io_napi_adjust_timeout(struct io_ring_ctx *ctx, struct io_wait_queue *iow
 			s64 poll_to_ns = timespec64_to_ns(ts);
 			if (poll_to_ns > 0) {
 				u64 val = poll_to_ns + 999;
-				do_div(val, (s64) 1000);
+				do_div(val, 1000);
 				poll_to = val;
 			}
 		}
-- 
2.45.2


