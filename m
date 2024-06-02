Return-Path: <linux-kernel+bounces-198438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBC8D7830
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922A71F212AF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5077A1E;
	Sun,  2 Jun 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNQHQP4x"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE020DF7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717361718; cv=none; b=TDj5UAZylk+QOvJULmqxVSoqdN8oTjv4iMJ5JJhyndfYc2K/AeGqjFOOoD1JGw9Y8VR+Y1LzSpYOYO/WLwmXyZytQgotMAdzheUqyNdR4dR5vfledGBwUr03V4lHpdseLRjH09iQvkXO22inwt0+qRLOQOj2b6CnJ+bohCYoC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717361718; c=relaxed/simple;
	bh=vnLD5v2V6r/4EYQXDr8qmLCoja/KXfoQQCsJHx8a684=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJ+IgiGW3LS373nCfa+zzmhIcEFSkMumCMXJwSNle7iQbMtKsFQJPDxyU7Dt9tb5OGZ2E4YuwP8PxiEiXkI2t4v1MKIccLIHvmCqgGu9E1p8DhypsvxTGs006u17j+OYmU/H8Zuc3/EoQBL0PI2AA4m8ul7zM+q9xEGq4WLE2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNQHQP4x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4213ce259c1so1704405e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717361715; x=1717966515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9+jJCdoyUgUoVWR8URK2HsjA2h4QJFi+4fkt7w9wF4=;
        b=fNQHQP4xa8tHgo4GY9s/4GQy50HH8HyZ/oTofat2YPOWjS3KgC1Nl2B8fpKmOdH2vp
         6qEnkH1wUMEqYfAJzRdEKn/LS0WWOpdPIY79U2/0UIdexM4YMBhIKoISI/V0iAbBW2W+
         XRLU3MvVit9/4dBlKxyv1yUNq1PXDWpl26WbiEdebp0thAeYDNcybKr/dSbCkFKMWZ1+
         nAGAy99+aVEJVix6r+Jpjd1A85kQowHqHAg3ysBCaiSEKDMUWOhEhCHKLrT2GnVBiREx
         9X9LOpfbNsE6hzPU9h7c5ua3E9J+7/8HDnk6kfRU8WS+XV+Fye7affBKJ2/tO/DY9lYH
         CgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717361715; x=1717966515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9+jJCdoyUgUoVWR8URK2HsjA2h4QJFi+4fkt7w9wF4=;
        b=nBaMoehs4XWp8YzWN9yUfto1F6YTTDXt2dve70Bp9YJ/fASGDxoPN/Gn3BGfrWDbre
         OOtzTQVATErAX3AmmwpT4BLIHrsValjURaZjUMHPmzhi5W7XM+vlKPovXC+EzF6b/NqA
         xSkLhwxNG34R3lAQy4LKbC3PJqiErzbdqL8z3L9kpDqasMeqrwn04+3MIWB4usBvGQWW
         rGuAVkUXZiA+oNAaR8A06g/SUJrMUDD7Fq1NDX2hSqEmWBrkkXSuhm/aaum1K83jTflO
         Nga3baRd4ci5Jx8caa05sUxLQ8H0BkAd9egRVinFhtMMfUh8DGeoI+VVvxCXLjGlfPkf
         66jw==
X-Forwarded-Encrypted: i=1; AJvYcCWicf/n0DT5IqfdzPLzzGTFfw2mKjt56+daSvarGNpRDPAWazkL3c4yqYl0KZxV6el03Rb3k75va23TfdEd1eFx7+2Ig07WxaaNO/La
X-Gm-Message-State: AOJu0YzVF5DY2fkel9HZBN4c+F9Zq6MAWYN2gab9rksim9mainEtfmfj
	dsIMo1D6BqCa1gzvsIEvM22lJsGKeheln6+HC19A1XFkOlVsx5cd
X-Google-Smtp-Source: AGHT+IFPzLd8MFqaNRFkuOKpYrXWQomBvW3rbB2TnP51vi0zp8jmK3Bc0Qwwo/tc7AuyIPU/rVk5fw==
X-Received: by 2002:adf:edcd:0:b0:355:63e:2b6 with SMTP id ffacd0b85a97d-35e0f360a58mr4649403f8f.69.1717361714978;
        Sun, 02 Jun 2024 13:55:14 -0700 (PDT)
Received: from lucifer.home (host86-164-143-84.range86-164.btcentralplus.com. [86.164.143.84])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e84sm6965376f8f.13.2024.06.02.13.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:55:13 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] MAINTAINERS: remove myself as vmalloc reviewer
Date: Sun,  2 Jun 2024 21:55:10 +0100
Message-ID: <20240602205510.108807-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I haven't had the bandwidth to review vmalloc patches recently and I
suspect I won't be able to do so consistently moving forwards, so I
think it's best if I remove myself as reviewer for the time being.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..e5b934683540 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23976,7 +23976,6 @@ VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
 R:	Christoph Hellwig <hch@infradead.org>
-R:	Lorenzo Stoakes <lstoakes@gmail.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-- 
2.45.1


