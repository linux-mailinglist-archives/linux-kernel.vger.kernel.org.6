Return-Path: <linux-kernel+bounces-323311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E895A973B37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706B31F25480
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392F199931;
	Tue, 10 Sep 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Q2XzOWJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE118C025
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981277; cv=none; b=ca332F3evXLBe6DslrVq6cJDlkIppR3whiMcslxKHfUtpgASI4sPS06hvWy2h4LVUZ5DvL04MwE3lIaOO7UaqdSs2+DHBmeIumIShZTe/yPBsNj90Cmb103SlzWf1U+p2JNtQ/xAu5fI6EuKYLS+HlufluiTFBJW7XgyPg6HeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981277; c=relaxed/simple;
	bh=f6SAxokemxKlX7+3rz2BUX7OQ1UNIgehVhJM21NJzrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U3kSc8mf9R8oed1uvnTSCkLxz97BeSm1Z8Q/d4il6FaJ1CCATiGWMu75OJr5LHEHMxOva1etB6yBs5wJqIsICT0z79lsbVgWOOAGDAQypp4JgoDyLYFWvA0ZrJyMaZitIWhtyQ54FuIU1JO/VrR3dg5onlZXgf+tHvlGiGrw6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Q2XzOWJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so32990425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725981273; x=1726586073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxJKNon3GV+s7VxK5Fx0SaMdamNiUrcs/pVtSkcTB/w=;
        b=2Q2XzOWJEWTz7z7YbeiZn8BbjPn5VxgL72kHkhmODSTiiZzgeDVhJIpovkVKgJWQAh
         ZRKXvgZCNyc2zUgxJewmcW7/dp9lYy9i86OQxiorOxMwMAwzOCmEUE51z4Nl4jpKBGVG
         CF25UG6s+xWtd9mT18+LfATeSBz8OvSzYQlDoNevxNLwtmM6fhEowzA/NhwBd7EWkCRw
         K5cuIpMFbGhcENqdphKzuZnhF8Sap3NsEo0ckYtKcY/xAi+nFsyDFB8+CLeGFJrPaIiW
         AjeKEEbKp2ee8tTrCCMX/eD1lzfV85ANZ9gvpJjYdykSaizYfDy0/xNC0YdFDKNjsbdM
         MKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981273; x=1726586073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxJKNon3GV+s7VxK5Fx0SaMdamNiUrcs/pVtSkcTB/w=;
        b=rZezcyTadO23ShgJQMuAFxNWcP1iZeir9h6UDpEbKwk6XI7Y7t1W/YSy8bj19i/jll
         63Ji4BVjfDAU4kKBrco14WEUxezhZ6sVWnfDpAEkdbdXQrU3BTrt0UYJg1FHQHK6xq8b
         itzJTcy9OAoayghGfofdOhzVtCU+3w8YarOXRjl0UkynkSOnmU5j3ItW/8xOt1q+jpJB
         OfHL9ajpPsV9ggGN7+yepv5YSK4l19Y65FrG1dTlg74JUmUD8NEWpLcyCybB6SSBWak2
         V6NtbJpnB6CylADQzySkVHcHUv5KqbJyuHBGjRoNSpcbhXPD9gixMGkkY+hrJbtlpEaU
         bItg==
X-Forwarded-Encrypted: i=1; AJvYcCXcqB33hAgAtMUcAcGoJnRgf911IqWt2+Uk8v0ffoAAPyd860oVK6lKi/TyyA/aWKTDqL9GRylQm7Mah4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfZDS+DSWic5a+k6aGQBBTmaRzGRiMSq4hFlLWM2/KaGIiEy3
	JARGqpvPn81j+Di9DhUgEufDx7cHonrOnQ+DNgDlBbFQ6MDmj6TJvhnQZjf3Bb8=
X-Google-Smtp-Source: AGHT+IFGu2aNgbWA2F98/dVIS3+QyMU0k9t43zpJEzpKPedLFkteqcmYg+lg+V/5M6ri1HF4fcuEEg==
X-Received: by 2002:adf:ee52:0:b0:374:ca43:abff with SMTP id ffacd0b85a97d-378895d5596mr8823358f8f.26.1725981273073;
        Tue, 10 Sep 2024 08:14:33 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d367csm9092679f8f.68.2024.09.10.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:14:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steve French <sfrench@samba.org>,
	Enzo Matsumiya <ematsumiya@suse.de>
Cc: Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smb3: Fix complilation for gcc9
Date: Tue, 10 Sep 2024 17:14:17 +0200
Message-ID: <20240910151418.1233049-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=f6SAxokemxKlX7+3rz2BUX7OQ1UNIgehVhJM21NJzrQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm4GJKK1+6uO5IX8tg6GiF8DPH0wUEcXWVLmB4n tKdpptnMT2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZuBiSgAKCRCPgPtYfRL+ TvC0CACQ+BDQyZMWt1pfCvT4HaWBKcX1hJScwaMeNEDbJR/RTMMeID2s/3J74XvFw3Uyvqrx+3q VtIQNtg8se6zEfzjrtjKdnbRdmcmvjjrTZ3HTTymwwNdqwE74pAFEBhCRpClvlHD7rG+YCtl/ZR OcNIDA3AtOBSaH0Kok8bGQDK3SLnClENPwWFBfmHxoxVohZ2IDxNnnQoterAj7C1g8d7WPBb+Ix 10p+XYerzYkE95+s2m0r/GneJt4C+4PuB1u6W3ivbWRCXVbhrhIRXFQhatHCWJ0uxZKYt5PwmqY U8RqhYXDs/B58puS6TRrBBZC6ugDn8s8kmya98CrcfUqud8X
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Compiling an x86_64 allmodconfig on Ubuntu 20.04.6 using gcc Ubuntu
9.4.0-1ubuntu1~20.04.2) 9.4.0 fails as follows:

	$ make fs/smb/client/compress/lz77.o
	...
	  CC [M]  fs/smb/client/compress/lz77.o
	In file included from fs/smb/client/compress/lz77.c:10:
	fs/smb/client/compress/lz77.h: In function ‘__count_common_bytes’:
	fs/smb/client/compress/lz77.h:220:1: error: no return statement in function returning non-void [-Werror=return-type]
	  220 | }
	      | ^
	cc1: all warnings being treated as errors
	make[5]: *** [scripts/Makefile.build:244: fs/smb/client/compress/lz77.o] Error 1
	make[4]: *** [scripts/Makefile.build:485: fs/smb/client] Error 2
	make[3]: *** [scripts/Makefile.build:485: fs/smb] Error 2
	make[2]: *** [scripts/Makefile.build:485: fs] Error 2
	make[1]: *** [Makefile:1926: .] Error 2
	make: *** [Makefile:224: __sub-make] Error 2

That compiler seems to know about __has_builtin but not to have
__builtin_ctzll. In that case fall back to the implementation that is
also active in the #ifndef __has_builtin case.

Fixes: 0fa8d04ff36d ("smb3: mark compression as CONFIG_EXPERIMENTAL and fix missing compression operation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

feel free to squash this into the original commit.

Best regards
Uwe

 fs/smb/client/compress/lz77.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/client/compress/lz77.h b/fs/smb/client/compress/lz77.h
index 3d0d3eaa8ffb..4fb939296f39 100644
--- a/fs/smb/client/compress/lz77.h
+++ b/fs/smb/client/compress/lz77.h
@@ -200,10 +200,8 @@ static __always_inline long lz77_copy(u8 *dst, const u8 *src, size_t count)
 
 static __always_inline unsigned int __count_common_bytes(const unsigned long diff)
 {
-#ifdef __has_builtin
-#  if __has_builtin(__builtin_ctzll)
+#if defined(__has_builtin) && __has_builtin(__builtin_ctzll)
 	return (unsigned int)__builtin_ctzll(diff) >> 3;
-#  endif
 #else
 	/* count trailing zeroes */
 	unsigned long bits = 0, i, z = 0;

base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
-- 
2.45.2


