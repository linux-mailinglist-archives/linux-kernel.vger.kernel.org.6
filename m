Return-Path: <linux-kernel+bounces-516802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E8A3778F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005E43AF321
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0F1A0BFA;
	Sun, 16 Feb 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTo1zww6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6F1A23BB
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739139; cv=none; b=Oa2DiRCfd+m2xcz8HoRikC2d4f5UtQZja15pCsrBoUZUoVkvM+T6sT9Q+J/fbwh8Zr5gR1AOhYjQ4wlYxZSfESbBos/+rWk36cpXX2+4ujTArWSWgkAYgomIGysoRija7Ycm7ogVrsO+jy7ag6uHuhq20+qQQu22rQkAWj+rOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739139; c=relaxed/simple;
	bh=aXs0vWAmuS0U8j3KJYwst5oPNJcMtkOfy6vx1+vPaD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UxAFcRQqC8DFxTodviBLTHTQs7OgTam/KQs6DK8Cj7vlh/D5xcOX39UFvbQZ6LQHH2K2exPv2A22X6NRjwhV4/js+gaz1eGYZBOEJx7CV092o4QFpiXfesgLYmKgwAQpbGH4tc5tbOi6Bwq7oujHDPeT+NUCJihkLOKB0torKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTo1zww6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso817423a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739739136; x=1740343936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkyPg/crIfWv0Cn6JEGTdKe/XqmIlkAQmtesjInAumU=;
        b=qTo1zww6FSZbLTcAJMRuG3KZoIcSmR5WH6W9vordHWTFHoWehPOLkQ6/jxP+0GW0hH
         HPaAPtW1dQNIkEZ2gy2FB0Ued6oj+lV61JRAhp1lDxL3xgRpybLt9h54PwoJsukbZG6a
         RR2lYJcMG7kBsaUQmVKKWuqaeGWwAbKnenX750NMB2jVfOCvOaRcWnFszYzQ/vI9tsRG
         XlQPrLASnGRD9ATkG0H8zgOil/E9BovNA/w5MdDlwD6TtryJwE15m4nFy2rEyh23bXLa
         7wolUuyaFLlFiwn7R2z5u6AWR8+M1MeQk7Ll1L8rzzrOhxAunt39iK9i8XJnafcoGFfm
         VJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739739136; x=1740343936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkyPg/crIfWv0Cn6JEGTdKe/XqmIlkAQmtesjInAumU=;
        b=mlb3rJzk/A6X/EbUZf/Ojl0ytal0DLRvFNPTShzbyMfGtNXsxSBqvDV024QOlY8nV8
         oPYWwRBB1alDSRm1+5hYd6ZFcPOVu7tL+TGulIujAIioVmgRo6iAdrmpUV48Zj6tGaCI
         aZdKsOi0QcuN/nXePs16g0ifTDmfYCZN6eEz5KvO1cRFcvrcykRJjJwkD513BM/CI25M
         HQW7lv/BjXQDr4kKQORiiVZ2ZgtNlW/ADALsBA1Sz4LYy0NnTlNn3c0Cn7ZS8kTXuzBd
         eOG6NleBHNUaR18mqYT6YRU7YnSKb+0OFd0VHnb/8xxQzzEK4yZSl/kTMjx5yDhAEX7J
         UP4g==
X-Forwarded-Encrypted: i=1; AJvYcCU43EvgL9yrVgb+wYG4aEsqJU/6uvy6eEtwLgAp1dZ9sSM5nCmfvK7dHABzrD93lRKHoMFRoZe/3I4TM7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqDFdtuD35nD00NK8shLxt6ofusngnVs924zmJ9wONqYLh2W8
	jaahMOSYQlbGIE+FQt41MObbLk0sFR5WegXb0raN3XTc8SQ93Im4zDZUlowHdnw=
X-Gm-Gg: ASbGncttzmRM/ZnUxJcW36FwOluXXjaChaNG+or2fEi21xj5pjvRM58UO6i/Z+TIJ1T
	hGCr8cHDXHK//ar7lfXYUBl7Yv2bWgldSKOAf9GB+Hdi7EojzagScn/cntoPuZxgVKbnqrxYagn
	8iw/zk4whcc0+OpkAvutu8Ps6ZsSZ0EFbyaLmQi5R+XTDjz0kjnhuAU+RhyO4sr/Dhm5KuTNL/G
	hcVmTJ6dMJ35ydvw1LVmAxZAYi28ba+udY0E+7z7YKrG/KIWeCEKVSiML3C0bVt5CvqAaKgpjdm
	V4pfq8EhbeWPzclVU3qs
X-Google-Smtp-Source: AGHT+IEMU++D2lnTLgi14JzxAcN1KpQU2iWjj9Zk4bircM7Q9WHx1vcmQHv39BJ+Q3JC4O7xeGXx3w==
X-Received: by 2002:a05:6402:42d2:b0:5e0:2996:72ff with SMTP id 4fb4d7f45d1cf-5e0360bdf15mr7424447a12.19.1739739136154;
        Sun, 16 Feb 2025 12:52:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1b4e99sm6273670a12.16.2025.02.16.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 12:52:15 -0800 (PST)
Date: Sun, 16 Feb 2025 23:52:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Prevent integer overflow in hdr_first_de()
Message-ID: <b78ff7ff-f260-4499-beaa-169f725abff9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "de_off" and "used" variables come from the disk so they both need to
check.  The problem is that on 32bit systems if they're both greater than
UINT_MAX - 16 then the check does work as intended because of an integer
overflow.

Fixes: 60ce8dfde035 ("fs/ntfs3: Fix wrong if in hdr_first_de")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 241f2ffdd920..44c99d35a59c 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -717,7 +717,7 @@ static inline struct NTFS_DE *hdr_first_de(const struct INDEX_HDR *hdr)
 	struct NTFS_DE *e;
 	u16 esize;
 
-	if (de_off >= used || de_off + sizeof(struct NTFS_DE) > used )
+	if (de_off >= used || size_add(de_off, sizeof(struct NTFS_DE)) > used)
 		return NULL;
 
 	e = Add2Ptr(hdr, de_off);
-- 
2.47.2


