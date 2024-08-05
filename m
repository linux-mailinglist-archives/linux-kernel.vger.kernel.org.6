Return-Path: <linux-kernel+bounces-274683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D2947B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04F1282238
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B315C13E;
	Mon,  5 Aug 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g8nZY27O"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4D15B995
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862557; cv=none; b=eaItMMCauW/PJbTHWn1Dp5PggeMvXWIco1geLDVK0ZSYPWQTBXp/vr5TClPxxucC8hGZ8O86hN9lPxMByyLgYCwCcu+rFdlajiF3June0IFjImstb3cX82XreVmfpjeJeVxy9uKXlh0+pzEu8SYQSyRY2nuDAiaWv5TmvfkXDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862557; c=relaxed/simple;
	bh=2Xqu+2y/kqGayw1LhiCWd/D/5aR4Vut5ubymQlHw490=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2qCh+P9ZiFfQjYPVAdQj5A8tmCv/tvZ879POu8eeObGwuIchNrvZH2FULmPgYKDq6geiiPB8lBd0po5JScTxP62BdwS+Fla7WedXpmSV/ehGE1Cg07fHq0JXqTANhkINyfGLCZrmj4mYwJupwXyX54s11/JSzqLiUFHRk2diSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g8nZY27O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2cd07869so1261176b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862555; x=1723467355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omYHK4YJqVuB4cm7/RSntivvxRLai4c0fyHEJvres6w=;
        b=g8nZY27OWg96d/TGmk6lu2DKe7pgZeFhWNASkM3SztHrkajrK38SbMLONG21i6+mKz
         fOIYVXmp6jInFt9MgcNwYFYLZOEOWANCi+IekcEZlJVeeEIG2cHL3ZmK92NGHrpWlQlC
         WFhORBMz6xds1LL7DeaK4Q4quK1KhjgaQ/1G2Sbs2hwxRMlDzDHr+MJlRbGUx0HKh0tz
         rHcv6Z6t/H2RkTp61BNiG3C0gVVnD+dGZ8kdj7sBiSJdt8cy1/f/jB1Xga8rOZ1IFEXw
         9IMuLN1rhRmZyZIk8ZrLZmT0RD1whdwbihsKUHePA1rRiUxgGTDYCNpm4zbbJwxdUk4b
         epGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862555; x=1723467355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omYHK4YJqVuB4cm7/RSntivvxRLai4c0fyHEJvres6w=;
        b=ARt4DHbWRa8JofCURcZO3KzdwJz9X1/MnGTpclWwwVRGsChIqW4d/Fx3Nm5wYv9+IU
         kOmUwx3kIDIQSiWbeH034SOwDTaIuj564iYSOAL6Zy1i2Z0f1lWYpML1Nxpp8gPp6JjW
         mOMsvbe69ACKpnEM0bcPgXa5L83i17xR3XqR6NhZGrz1sXmI40bMxkuL6Y04M5xtXxml
         TWQvqYc0qbF1y+yhtMSxp0k0E0+A5Grxnq8v39j/mKxZYvcLoQ+6Y4WRwsBtNkeoKvdK
         AZhz2F10GePECZmFDlMqE8p0BdpnKDvFl6k646QxHSi2OzBpV5wGMLXQOdn/+UroCOWr
         Y8wg==
X-Forwarded-Encrypted: i=1; AJvYcCX+/6+/0OvyMYGseMKldCPYQr9VakyQCr68iY4cZQw+i/07BsFPN6fCTpdyxYk330FfAUyQaWRvJugiOC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzAsaqcgHf1PIGQLYIym1KMPEU5UBOwuH5QqyPVPKDN8YAwyD
	j8il/hUCVcm8m3Bvz70KTvmvpl2MRxZKUTwaNqt90I6D2WjyYIngoBj5vN5YOts=
X-Google-Smtp-Source: AGHT+IGYYukG+ok6MYSzTAxan5mNsM3B2kkWkuJBYY1IjywvHeK1bY7aqXgLyTgGlf83PVoHS2ooMA==
X-Received: by 2002:a05:6a00:21ce:b0:70d:2c09:45ff with SMTP id d2e1a72fcca58-7106d0927eemr9121873b3a.4.1722862555191;
        Mon, 05 Aug 2024 05:55:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:55:54 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 2/7] mm: introduce CONFIG_PT_RECLAIM
Date: Mon,  5 Aug 2024 20:55:06 +0800
Message-Id: <7c726839e2610f1873d9fa2a7c60715796579d1a.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This configuration variable will be used to build the code needed
to free empty user page table pages.

This feature is not available on all architectures yet, so
ARCH_SUPPORTS_PT_RECLAIM is needed. We can remove it once all
architectures support this feature.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3936fe4d26d91..c10741c54dcb1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1278,6 +1278,20 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
+config ARCH_SUPPORTS_PT_RECLAIM
+	def_bool n
+
+config PT_RECLAIM
+	bool "reclaim empty user page table pages"
+	default y
+	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
+	select MMU_GATHER_RCU_TABLE_FREE
+	help
+	  Try to reclaim empty user page table pages in paths other that munmap
+	  and exit_mmap path.
+
+	  Note: now only empty user PTE page table pages will be reclaimed.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.20.1


