Return-Path: <linux-kernel+bounces-250315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8C92F662
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315B8B20D54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5D140E23;
	Fri, 12 Jul 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsQFyxJ6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DD13DDBD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770132; cv=none; b=mJWakq9ycgn28NbPKSg5Qk2ghxcD32noH1qAVITK2SSxyawn1vXVpV+6vJEd8F+OjYZsrMd6UeAZ63SNBSGjf4dS7976SQ1oKxWkWz6BeOAC/avegpDQO0elSeKpDh+noKwuz0Yu4lTQ+Ab30DTdtaTIxlzimiadgwHWO+Fd13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770132; c=relaxed/simple;
	bh=pqzrK6GeK/Oea2X7b84rhhk47gsqAm3PBuG/cJhxz7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UYZg48rOu44G2mtFK6/jJ2/uzxAwZAlxZeCe5Ows8KLxsY1kReMFnc34EwKtSpD9KtVCzeq05scZYYKU0smZMp7T7F6eO7IyIYAYH4c1MvR/6cXsjHGyZDgamLdaagTCIwfDD3UTkveyKEAexQRFS/eMYWR2ByVRcEp2LVaZS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsQFyxJ6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c349bb81so203891966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720770128; x=1721374928; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5RbosRdgQnFVwDd+ljVq0E6BbCzylqvZnvWXsiGruzs=;
        b=DsQFyxJ6cM1VEeRfyPsuHWpGbwZyNuU3snbo5tpqMFElZ78+GxSlfNoTbEwXZcRT4j
         M7cCQnmfe73gOQaf7D640sgTN9XeUd4Ghz6lsLddtX6lE3FlCsAbD6gf4Dq1FNoHuYDm
         vdKmLhhOCekLQXIKqAxyAYWzcXD6F+3VXDrj5FqN2w5ZYgZ1HTz+sZmqPaYS8KU0UVV3
         bIU5/jajR4dwUAfKfa4n7WnF4eqphcO66UKN0IIMKlB1CFEFUVpduiqCdDu6aQjxf+6S
         7MLZKqd8haHQvkmTDCxRdbDPGevVsJ77GugEL4zIExCKp5P8ulKNEZogAOHIM6UCo8eb
         lTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770128; x=1721374928;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RbosRdgQnFVwDd+ljVq0E6BbCzylqvZnvWXsiGruzs=;
        b=bzTcqZzOqqPJI+2ElIX0moPMKhSddMzUHsyq+uCUqyRF35pKM0du8O4Wbrvs5cnOQO
         EN+Ji77dTJoXRKplkU2fOzOC8yZJZvMEmC+V3b0HlVM1FkYuzT6LASniLNkHWj1uZfCC
         ILka7cZhjk9bGkBIzbX7EJ8IXYX50q+5I4/3NrULyoYWIgQss+npIDuIDj8PYbefoCxB
         fUpKpWl51m2eDug/WCGoXeOEaDjWb6ysd45TEd8DOQZcksbcMode0z3U98CoBV0apF6+
         RYoXzDUMVbCkKrDoaOCOjFUGDq9hlD9wDawuqcuoLdfeCUYNq3q08K9MM/vxaZ8Pf0c0
         REHQ==
X-Gm-Message-State: AOJu0YzRIDIKLrbFasarjmwJ8N4rGkxKEWYJHeSaUMbwBwKhzUK6dNOC
	cYtc2XC6R4ZQLsI5eLwvvPDgEyQ3UOb9h1mAaVcl2jRI75/bS3WpxPEE8DC0
X-Google-Smtp-Source: AGHT+IFXRdSla5QBRKUmOuWe+T6FkwPV3GarVvMN/5JbBYTLiA+bQoSPUB1DbTAnWh7xWSTln5aqpQ==
X-Received: by 2002:a17:906:c154:b0:a77:d880:2c9d with SMTP id a640c23a62f3a-a780b886686mr864493366b.50.1720770127908;
        Fri, 12 Jul 2024 00:42:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff282sm320273266b.130.2024.07.12.00.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2024 00:42:07 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/2] radix tree test suite: remove the local copy of kconfig.h
Date: Fri, 12 Jul 2024 07:41:51 +0000
Message-Id: <20240712074151.27009-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240712074151.27009-1-richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The local copy of kconfig.h includes the kconfig.h from kernel source,
which is almost the same as the one in tools/include/linux.

Remove the local copy and use the common one.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux/kconfig.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 tools/testing/radix-tree/linux/kconfig.h

diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/radix-tree/linux/kconfig.h
deleted file mode 100644
index 6c8675859913..000000000000
--- a/tools/testing/radix-tree/linux/kconfig.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../../../include/linux/kconfig.h"
-- 
2.34.1


