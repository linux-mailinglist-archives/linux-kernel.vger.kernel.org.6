Return-Path: <linux-kernel+bounces-300056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B895DE3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF8D1F22123
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA391714DD;
	Sat, 24 Aug 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="a9ThtCyY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D4155758
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507912; cv=none; b=Ni/xaa6ZHm3rOrY914IphPIKsNZuPvfBOCuwala7rytYYkeA0l+uDALWHyhgxs75dsJwsrg2an2XVAcUroIrLYeV1mqxszMoZGRJUtE4uZlY5WDypZur/PU1PeroqiUKdfB4BVOurKW4A24lbtmgBBTpPB7DSDuPBS/WHwNtr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507912; c=relaxed/simple;
	bh=P1qjlgra+xKuf75uKY++0mLXCHBirUzdlkoC/xqdFlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBiwhafPFmPBXJuhcU5kJGnfolgSnCS+Dhj+47+Da9IHkjc2gso2j71UO5TH8BWxiXeI5JRGVsD63vbJjeIromS+qeO0Gc2+CfdbN4a9ifJ4zHM9/zf3aIZTHVb2PnzJSLEChEikFyYd3LJHj7uFzVt4ACvqmIwsu9jFRSww9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=a9ThtCyY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280772333eso4621605e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724507909; x=1725112709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRYjLQs0r26czWvaNx2T4sLxT7Rxn58hBdTuSAcDUEE=;
        b=a9ThtCyYkCv+Ath02d6XsiNSHQdeSZ8JcuH14czfAYVO05Dxj4IMNLRfx+8ZMsGnyB
         ddyaz/OG10wxpTGsqOnOh6pdi+TWZENkXqfSKcv2vVA8wjUwAhcYAUDE6fKTSaYMfuRG
         BXxhJFH+vkddEDkhk4+91nWBhmtIcD9UKfXs0TgvPt+hkpAoQvqsP+y7pDLrUzjQ8yI1
         vnFm6GArUUv436DIOdSzMog0shAwQq2CvF04c5VhLpCzQtN2sXnY/oSuWHdf7+FrB2lU
         JXa1S0/i82hWRwYMILo7+3Nw06Ab1OARkyLIRm9E5fzQP2PtLVxxtyx/gXAwoxFcd/zn
         Whbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724507909; x=1725112709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRYjLQs0r26czWvaNx2T4sLxT7Rxn58hBdTuSAcDUEE=;
        b=J/7v6VTmUocd1WFsNKnhRTwVzqhWY0pXBTTLIqWWHIhcUIi8quCt6p9Q2D/ICWwRiv
         mWlAh8ifRDbzgkZorIeH1iDI+H/9FqTRf9Ck+D+JYlVGeE6d0iC4/Li1bhY8dLrTJzVQ
         tH3uPvXuf2e/f6z3smZjx3E68/8Rlb4U2KZ2JYT6rZ3GJ75uH8MQMZtAGg3Y8rqFcCNB
         zaDFex3MkB1sMIA7U+drBN7i9Ow1nw8mF0zIO7dWr0fCP3vdKYUwJWokaNghAX3u7ypH
         iHhooIK8xKKK4kCtmBJi6aRIw5TAnBzPwAzgGiiEGFapyDgZBcgtcwIfdpDRpiGRUx7X
         rQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6OmPSYp+d9S9ldLkYIGVJX13Mh/IMKmfYDWPLs/DDM+wgxmyBweCGBs6m20ndByNZfi/DVGhs5ax+FFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY91eNeSbv7nVshQ0VgobJ2t/9QzaxbvnOaDwWSuOmwvvEZYe
	gEmeAD2FKvl1WwtmVzt8ZiOVEcu44cnwN56O4uC2w6FCbVmGbtqjtpMDgOzhwOE=
X-Google-Smtp-Source: AGHT+IHrCGLci+4IDEpg/zrkzk9St5ONWrFr4kGJ5L2dzDRmvf2ZTLHku/dUdt5itzrehd3Jbt/Azg==
X-Received: by 2002:a05:6000:402a:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-373118310a2mr1933615f8f.1.1724507908944;
        Sat, 24 Aug 2024 06:58:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5ffsm407956166b.177.2024.08.24.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 06:58:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Annotate struct bch_xattr with __counted_by()
Date: Sat, 24 Aug 2024 15:57:41 +0200
Message-ID: <20240824135740.1971-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
x_name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/xattr_format.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/xattr_format.h b/fs/bcachefs/xattr_format.h
index e9f810539552..c7916011ef34 100644
--- a/fs/bcachefs/xattr_format.h
+++ b/fs/bcachefs/xattr_format.h
@@ -13,7 +13,7 @@ struct bch_xattr {
 	__u8			x_type;
 	__u8			x_name_len;
 	__le16			x_val_len;
-	__u8			x_name[];
+	__u8			x_name[] __counted_by(x_name_len);
 } __packed __aligned(8);
 
 #endif /* _BCACHEFS_XATTR_FORMAT_H */
-- 
2.46.0


