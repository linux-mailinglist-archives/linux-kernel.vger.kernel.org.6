Return-Path: <linux-kernel+bounces-261645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBE93BA40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EE71C22A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6F1862C;
	Thu, 25 Jul 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYFNWo3T"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE412B95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871730; cv=none; b=gyVuELFFVysbynPxg63K+TenGoxR/iC2A0T+F5cBllZEJFGHAJQ3JfUc+Mfkz1Y1Rf8hsk59jGUvqul4DMY06DYePb6+rXUzFsuuxBAqWHNT5iZRoG08tQm+oRGQZhZlWlv7pyZQGiwwTtd5JozYBh9M0NxZqvjjgIfNRQMdBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871730; c=relaxed/simple;
	bh=pk7lkvsq4/q/7RRT0lSiVWoJpROHZT97tsR2QMOJt2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e4g5fnY164AzyGRfmK5RG1Ewr17V7g1HZpL5M3ZQNZoeJdgxUIRyBhIBF7Zs2MhrDNRYf2ZbqtPERkXCLBnCPyHMbtFdRS8Dr7GDcUZzsBe/V8H3u6sZw3x72wntpWm8XXEOnz2YRby9kq8WXR5IQNyaB2V4wrvA+y64FVB3glU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYFNWo3T; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf989so510341a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871727; x=1722476527; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=RYFNWo3T0Wl4xrFTaaE4HBmDYnj+HICATYfAZ9vh6deFRW0RZF5LRwxv0btzwSxjaU
         4QWLx+EAPqnGHIpnQx1NY4RHF0kZGd4ZRqyko4vSGiHhjgA+ehxGZMKqkGmHc3CqlLP9
         8AdkH0Xhfa+JdFQZNsPORqH/Q0koIykVnIJmrBEUcMswNP0R8GkIjrVHfi3teIyiM5hR
         +pkMk0nTstCsG3zkBfDLYD3GKeRArfoHL97PrwErXZRdPGziVR/nQjn1bYU9RR116qcr
         3QOPZ7GZrJHb4ZUg/LHni/rd2m0baG/eJPAbLsbranjUZzjEcspeqluMFrwLIWBzUsdg
         GA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871727; x=1722476527;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=s/XkN+ZavLwDfwPBPP2wZNDxn6QMKg7tU/nOQwrRagy6twTl9oFTQI7ZIyHoKLnS2b
         ZKSOBFEDS7XKWXXHi48fm8VMWlp1VLSibEsNUm3FuTcVJPnjvn4DztYEnZVdHH9V+lzX
         zJnIQ3SrOaIkCKQvyOaoDFRxr30AbRaxsc9PM3AvpDj9HUsaElpDmt538Qz4B8lmPDvX
         Q6U2H1YpdVOP1grt4HfJv29EcwAbWx8pYAu0yx3cr44LAKPWTz2rbRmhQfdZFaZJnefO
         tenjz+8/3QF1Mboa6WdCRrjepSWs/HEnZcVTKWc+EY/M1gJ2FoJG2hYdrLzTL5TQ+y2n
         1Dcw==
X-Gm-Message-State: AOJu0YxxhZrsHhv8oxUIOdvgAjr3UV5lLH6fdzwp9+p47yFHXe8mZTgT
	SanQGQFH2ZyxZLVI+cpqQkhLQKToQX44/3L1AUhzQvwYNlEa1+wS7PnwGQ==
X-Google-Smtp-Source: AGHT+IEy7VPRH+50Rz7NuDLtZ+hPCJhH/xa3LT9r5958MKX935u5/zkZSZMid0RK/z8aCFJ4d4++rA==
X-Received: by 2002:a05:6402:34c3:b0:5a2:e34a:d63e with SMTP id 4fb4d7f45d1cf-5ac2c1c4887mr745587a12.28.1721871727305;
        Wed, 24 Jul 2024 18:42:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3a61sm239512a12.73.2024.07.24.18.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2024 18:42:06 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] memblock test: fix implicit declaration of function 'strscpy'
Date: Thu, 25 Jul 2024 01:41:57 +0000
Message-Id: <20240725014157.17707-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240725014157.17707-1-richard.weiyang@gmail.com>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce the usage of strscpy, which breaks the
memblock test.

Let's define it as strcpy in userspace to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/include/linux/string.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index fb8eda3019b5..41e7fa734922 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -12,6 +12,8 @@ void argv_free(char **argv);
 
 int strtobool(const char *s, bool *res);
 
+#define strscpy strcpy
+
 /*
  * glibc based builds needs the extern while uClibc doesn't.
  * However uClibc headers also define __GLIBC__ hence the hack below
-- 
2.34.1


