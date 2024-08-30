Return-Path: <linux-kernel+bounces-309201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D7966751
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E5A1C24973
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA301B81CA;
	Fri, 30 Aug 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0IhsJLVd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90813BAE2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036601; cv=none; b=qaSoi2YSjMaqaK+qlAJDdythY0IIf5vjrGe05VpvXG60HBiMnimIs5VBsa2dN9SRCkYDrdV6RMqP8QhfkUKhj6MCexKYhzPIcI7QFTe/1rmRp1qsYHJHNgTiLVKCw5X9uibLB/ocFzSARVlBzJSOdKUGdHBGmQNfONB2ZEXcFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036601; c=relaxed/simple;
	bh=lrlNIF9WdimAsN6kBCmQgiO59m2L6o8gvGS5OgtlvNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtWtOAC2BiYwFLc8ZpnK9g0irZUoiZrqZMQ/cLVh6aqOTRpP2fc8XrFyRPyzMUYs9H9wpEC7ciMJLM3Yfj/Q6seNNguTTNeDhSXMyUSOeHE4PSKCQI+kLOmanSt6U9Af2rXk26IjdUirBo64Bn/yKNKJf9VRZnux8Nue37iKrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0IhsJLVd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bbd3bed1bso1042405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725036597; x=1725641397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxeqqbczVIAQ0z8tAayFbvj/rLvPdhZbbzHN6wdCAB0=;
        b=0IhsJLVdfTvA9VUY6D03spMLrDwmsD9cZ6mWVehJTrTUTUF95T2B3lYn6uAKhMJh69
         Hm2oWPlr+2Kzog8L+Ka+CNNsvye4o+QreOXadmNeWQobz7p1ne6MOQXYpGulXOT3eoAe
         ag6Y2fKDXQFyl5oAyZk7Zk+CSaV40pw84Bmr9o7wLVedpRvgmkj2jfK4DujA1aDLOYp7
         Pa8hCKcPEYeXZVVWZvAwXisocp1dJ/b4InyFqJiF8bCVUtU3vS1PCa2imwMB+iOk1m4W
         kYYOkPET/KxnkcjgS6x5DLwXItwH+IMpZLwKaP0xqrjyFutxPbTYkPphIXlpQJ0eNEjh
         gQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725036597; x=1725641397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxeqqbczVIAQ0z8tAayFbvj/rLvPdhZbbzHN6wdCAB0=;
        b=hkmVyOkZbv/CB6riVAlXJRwarWOakkiKHsNeXGC/zpCumWQAmcVbHVmhDuwvXcJvEx
         5zXMVhYPPpDoqOssRj+o2v3N/pjqZSD69YYvy+x7XLqr4iEcYKtucA5ZJV45U4/sskoE
         xSrCjTAtnXYyjeHshGI3Hr5/YkkqbDp+R+bBbkkpnfvLdqkuqVRZlbZHOyGt7qdC9hE4
         b1tyiLOM1jeeapHsM/x2CPCINQS4RwQggMNqXcPAU72/zxzlfW0TdVKnzCG1H/LcvbUG
         97jn2wMOc2nrx4q7kSg3+sBoWysxgZi3hBi72wIqWBFJQ+tvoIVZSoK+fw+Nq6E3COWL
         x1dg==
X-Forwarded-Encrypted: i=1; AJvYcCXWVJmNj7Zo5/i/jHv5uQBvdiPjHZ8BUVkMLDR8pr+4AfMdHO/Vipxjn7Nt3eFWSpk4g5yld3qkPJ8qJ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4WuQ/kwj2xfddX5ceflAj4xZzXy6ypoMSS0gFWzFUb1qxEuE
	OwLpctJfNdqygPAyPlypi7JD8nWycnWeJQaNf8zzTzSnt8Llmwv010c/VuVz+hXAAyuqWbwbbN4
	q
X-Google-Smtp-Source: AGHT+IHVpIRujWjY8Uin/hP/ps2qq/oyP8IvmuiAvN5GTMctBy9RS3M0uk0uyECJzYkFe9vWMq5KxQ==
X-Received: by 2002:a05:600c:1554:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-42bbb43d5e4mr12224585e9.4.1725036597441;
        Fri, 30 Aug 2024 09:49:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425811sm87276285e9.40.2024.08.30.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:49:56 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jack@suse.cz,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] isofs: Annotate struct SL_component with __counted_by()
Date: Fri, 30 Aug 2024 18:49:03 +0200
Message-ID: <20240830164902.112682-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
text to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/isofs/rock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ee9660e9671c..7755e587f778 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -44,7 +44,7 @@ struct RR_PN_s {
 struct SL_component {
 	__u8 flags;
 	__u8 len;
-	__u8 text[];
+	__u8 text[] __counted_by(len);
 } __attribute__ ((packed));
 
 struct RR_SL_s {
-- 
2.46.0


