Return-Path: <linux-kernel+bounces-295907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EB95A2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569DD2813DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2291509A4;
	Wed, 21 Aug 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Dntg5lUS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081114E2E9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257794; cv=none; b=tKldwIlqEO6OSOJxH/whUKndid5LyMDdnyEG3V4G0v9d2pZi/Hm8aILRiAuIQWyfuRmZLVnCoT23B8zMtu+UmAG3rYbxgNanR3R4dmP9Bgjfva9uVPGwC+bHDBXEmtzF7vO10LKGJBLYzM4ykwLIlm6mdVA5uaPArnOFLu83Blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257794; c=relaxed/simple;
	bh=+2F3YQaCGLitcTbNdWyuZTbsn8oeYp3wyShw7o+4Dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFmgANvsY0/bgZnjTvM7r/cOXN341Af5El67echNQh7oLGmyEDRHugMcztSGXl1YUaWxyGDhnt8CJYwLd8zI1AnHMVXZkctwbp3ZZztXqmiQbUN/bBe1GPYIihwDeC+n6vZZsJICHA0b5n1Lj22NJROOnMwSY/2HYhhn4pDaJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Dntg5lUS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334832fb94so228861e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724257790; x=1724862590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQiMkF2LHLJ8ofvZ2BWlH/LDX2/cHbFn/G18VRaMIA0=;
        b=Dntg5lUSgD1wAJz+cQ0HICy+qFPjL26LwdcYD0DNIwJMeefaTInW2LCnWEIEI2mz74
         R/S645kfbW3SbXEtXOeI+BHv7L+eznTVFKj4Xraf0JSnCiXRJYE+WdNZfkJGRMCkHjuM
         KYRyCyQ5MwAyrLgZqeHKf8oDmgN1owmaKxgUEdArrAykAil5dOealcVWSzp1O9FgI5aM
         fJBQT0wlAWx7lMkE9VCvjVJfwB2NvjQ7LSGwZizs2ldvTIchDAnM+MyK3Eht9/2T3u3s
         YGuUVEzhG7oXvvRHjqi9ncCIjvPQeecT5uKHd/bg5poF2ncRBRV2pMaFEdG0l0PgyjOP
         AZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257790; x=1724862590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQiMkF2LHLJ8ofvZ2BWlH/LDX2/cHbFn/G18VRaMIA0=;
        b=AfQy2o8FIX8KY0scIA8Rv7G5adpxLzzUeNaCrR8HdkavyhEJ2oO0bt05iyy6vPc5Q0
         brEMB6lC+TqQtgcEXStSzM202KOhmgG0noNAgTj4fEewfMSxEpJNbSx0OHIznQVVnjEL
         rkriZnpC19lHXpenf+FQ9R/AoOOGnMugC2GVOwk40WmRIn6AaJkPUg+W6/yA4aXhDhYE
         yFlrI2QfnRUJ0ZzdrzKlRuaGQbxjdJv/UL/sin6AgzU61eH5kT+Lrjjw19ikQ9KP9YAs
         LXyiSleqKFKyTV7ROvQ/F3GwfGynw2XKaMTdsDNVL4XEU+we2WtOjTf90XaxTLpggwjd
         qMPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjVPPIYozfvflXa22RJbjdBAbHkdKMGWVjiy3zk/eMPtSK/VyWfXAPW8Ijd43ibJHXofQtRkwhcqvvlKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwosS1SxKJdjr0Wc22HoRzp+zK7XzgaE64/CbJDsy0Y65uxMO7+
	2vapYwwBRoqGNnCAXEXd61OXpjgGnTLREARkvsRjG8Uwq6ugfzcwiyh1YkyeOkw=
X-Google-Smtp-Source: AGHT+IFHDSmUWk0dq5DuUAdcENAjlQn2DZw21ZX5ZsRsgXG0sXCieYPYQNvWnKVi23rjGRAUfxcBeA==
X-Received: by 2002:a05:6512:b99:b0:52f:c438:883c with SMTP id 2adb3069b0e04-5334854a5cemr1026987e87.1.1724257789262;
        Wed, 21 Aug 2024 09:29:49 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8678ae3ee8sm105515666b.25.2024.08.21.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:29:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Annotate struct bucket_array with __counted_by()
Date: Wed, 21 Aug 2024 18:29:22 +0200
Message-ID: <20240821162921.86767-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
bucket to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/buckets_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets_types.h b/fs/bcachefs/buckets_types.h
index c9698cdf866f..a19460a1bb7c 100644
--- a/fs/bcachefs/buckets_types.h
+++ b/fs/bcachefs/buckets_types.h
@@ -24,7 +24,7 @@ struct bucket_array {
 	u16			first_bucket;
 	size_t			nbuckets;
 	size_t			nbuckets_minus_first;
-	struct bucket		b[];
+	struct bucket		b[] __counted_by(nbuckets);
 };
 
 struct bucket_gens {
-- 
2.46.0


