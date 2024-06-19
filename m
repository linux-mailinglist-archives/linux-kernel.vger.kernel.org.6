Return-Path: <linux-kernel+bounces-220699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E838D90E582
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB121F22A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB17D3F5;
	Wed, 19 Jun 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbXUg3j3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38407D3EF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785865; cv=none; b=s3I/WlnK4i3hkmsYTJ0tYeSjwVd4J6Ke0pUlbRuqCxpZWEWtAWTLj2v2azONr/218QaGs2ngRTpw/PpFPX2rfkGW//Mpq+JYK7cVe0WXJm2XVowOP9CCymNoiDd2J1njPDPzrNLXN26BhKMhA3p/8NiDm6fIBoYwrPa7xuVEEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785865; c=relaxed/simple;
	bh=gMbQ5x5j/oxaVpxEqTh3m3ftcFQGxLNuyjFy4At+ODQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YovbmlHcBuzIe/lmw2979uAUGC8IGKHVPzgMFGky0dLk1eaullqoNJsh62ryK6G520UE/ks+OzL6iN+7xbCYj56yRsSKjefLKmD/D9RkvWn+QNDcfe8iqkrvwH5TsZrud7PFmApVj0BsyZXmb0MI77M+VzDuOAijFdP9iXGhP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbXUg3j3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9QUnjG9G5UAVjU0gtzSEBrTZfmLXC0Hy4EAITPEAdY=;
	b=VbXUg3j3BcWKuvQVyFyEs2ooWL6plVxNpyiiXGqJKX6laaVk9y55eJEjlUR4ZiPmNRpdGR
	jfI60uUcYUbtB1VW2R6n8NrwZWu6YXaQ2oDC+OMA2raIQfxYUkRi5SqbtqNhJI3A5T4k2d
	ArZiC2weHuPSYtHjWQDd1CpplelmFK8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-mHi4w-UtMI2EYSWT4aAyXw-1; Wed, 19 Jun 2024 04:31:01 -0400
X-MC-Unique: mHi4w-UtMI2EYSWT4aAyXw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-363edbfc61dso67098f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785859; x=1719390659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9QUnjG9G5UAVjU0gtzSEBrTZfmLXC0Hy4EAITPEAdY=;
        b=vErjcIgOBrlq4u1CZEb9kHcC5rrUB1K9OnW4Ybcvivv5DqBEpy8grfO6RHX8NhRe2L
         UbvpRjZSBvdwOneDPdfzVAiYYZyOKptCKkIfQFj0HHYsJutHoMdkpBqsTjVxyHJjywZ5
         w2EvdxUliZ+G/Noe3qQk8V75iNXvh1RZaHsGCr4EjZ+pSa5FBaPDYN96r3aU7OxkfhcM
         3xDmjGn8vcruVlQxqhp9uLSuEZA69QLLVZZ9UHAH+u9i+tZ7p/a95JXb6+kC/p0POLVE
         dKWtrWOlkVTkUUcQk6gtvfiHcsMixwICaXqrGywfW8W641zXK2PrAJ4SpF/vQ1JKawy8
         +0pg==
X-Gm-Message-State: AOJu0Yzgte2v4kbkAlTmoKzLifBDIVNBVLAxzLb9Z+DEZ5qAG8hNmnRS
	QA8pZc9xpf5eE+W6uNd3OL812ulpkliR2sxAsSWWXjnfofzyN36vQKcqm0/CKuBIui8vvFa1ZPF
	YMYiq8iNvmr9STGSIkY8bRqbvJ6uuxW9zIZ3yTs5lDt6ELV+VHT4rbjgUPrkv4l40utAFl1uPu5
	NMlk+M656+H57cYVrgaodz28eChV3/lvA6oZwax7pTgam/
X-Received: by 2002:adf:f105:0:b0:362:2e9b:f113 with SMTP id ffacd0b85a97d-363176ada3bmr1609339f8f.21.1718785858976;
        Wed, 19 Jun 2024 01:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnRrCGvxkMPYQbJQL0bXRi/dcUVT+Rae1i6FGFpXKKzd5uOtKaQ9t9fQSBjF60Ds5H9qdNcQ==
X-Received: by 2002:adf:f105:0:b0:362:2e9b:f113 with SMTP id ffacd0b85a97d-363176ada3bmr1609313f8f.21.1718785858354;
        Wed, 19 Jun 2024 01:30:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609d31433dsm5202215f8f.5.2024.06.19.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:30:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Masney <bmasney@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH] mm/Kconfig: Mention arm64 in DEFAULT_MMAP_MIN_ADDR symbol help text
Date: Wed, 19 Jun 2024 10:30:38 +0200
Message-ID: <20240619083047.114613-1-javierm@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ppc64 and x86 are mentioned as architectures where a 65536 value
is reasonable but arm64 isn't listed and it is also a 64-bit architecture.

The help text says that for "arm" the value should be no higher than 32768
but it's only talking about 32-bit ARM. Adding arm64 to the above list can
make this more clear and avoid confusing users who may think that the 32k
limit would also apply to 64-bit ARM.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..f7de1e3d6c5f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -714,7 +714,7 @@ config DEFAULT_MMAP_MIN_ADDR
 	  from userspace allocation.  Keeping a user from writing to low pages
 	  can help reduce the impact of kernel NULL pointer bugs.
 
-	  For most ppc64 and x86 users with lots of address space
+	  For most arm64, ppc64 and x86 users with lots of address space
 	  a value of 65536 is reasonable and should cause no problems.
 	  On arm and other archs it should not be higher than 32768.
 	  Programs which use vm86 functionality or have some need to map
-- 
2.45.1


