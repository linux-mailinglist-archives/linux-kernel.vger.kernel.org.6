Return-Path: <linux-kernel+bounces-275529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BF9486DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E612847E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7328683;
	Tue,  6 Aug 2024 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi4lqq+D"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0A8F77
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906219; cv=none; b=NiKbzRtGhlxrTVauwe5tuxaeQuFzJyUH0QoUIG3HYVXmkVE3W7h7bXOvKNLytPNw6GrGbWkFh7wBL17/1DgUZmw43Gq62DDSp9fZejggbDu50Dr8p6i3Mn3uz0lungslKyRqaMZRy+qXzia2slEa40OmsmyyhUEhysIzi8RNfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906219; c=relaxed/simple;
	bh=maHef5ggs1ts45wIzJE7VDz5VzmJJUpzw7iq/Ex4uNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EvfJI2Yc5O9kPWMvbUDgFGzLV+ECfxxtzwLkgoxCDnnir4t6XYyytwlON4NffJc6UGcHEtX3I/tt1xz8F8vzwXFTuxrbRWwr9KZtbp0+/VkIi4U5ZdNuuoWGX8kLV7ObgVI04tsly+XQWZMetPVVkdDxqJgx8A/xovFHZl1BpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi4lqq+D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so180620e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906216; x=1723511016; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=Oi4lqq+Doqrn7+7udwWuor5jd7n8UmQumqm89DmlryzI0e2DO7z1NIRIkf51Ti5jMD
         FUrFj1fSwv9nHOCMelwJfisZkHUR8kdh8/krSSHosfEz4yFLv+VRCLYiTcXg5dZINjjI
         E2YEv+MKjdorQeYnfV/A9Qj/4okNzg1ce8+i0WwGGRMilTHXFiZRVz3/LIiCrwuWPRHb
         5SSKw0OxY66U8FJ8b1OyOCbD+lJ+tm7cFVlKuqhdjS7JpgKT+9nDGab67kCAjV6QqlY6
         GL+zOhI53IvR9GWbCqRQggw/OlGmejcmfjFu/PLbe0T8ZrREH+ppjD4NapZLIo/FOiDc
         /adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906216; x=1723511016;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+JPYPQt1yTaGk3WXPjbRRDMHWDKLDoRYgnwrc901qQ=;
        b=fOLe7cfmc6wjpPuqonOELpEUDucgNVJzVwp7CbYTVc4cz+8zhd8PtNfLGqmi3ao761
         Peff3hXbcvOOrZBhdjCmN2JHasjD4NmYlRdXEC6AUIgPvZtDNr2Ek+PPe8rewfHLtv3V
         oKnPD82Vptg1M/ull9YMioDDai/dn+OUWEHGulfyRE7JcchRKSyTMuxX8RsXAJQyprBg
         jpsTwWJIphvG/6w7HdPPcTpP4IrPWlQbh5XyXq4jrdtBRgssyJpXP3n67DJjwekJZeH1
         gM2+6O1bopJPB8c02wW/Mh+9QzqWoXquCI663YGTJaDNFpSCV+aeWx0IcKRi0xMbyt0A
         lOEA==
X-Gm-Message-State: AOJu0YwG4+kRvJwkLD/uFvbHzP3YQCP77GBmbMBeb21bKnrDMVlD2VIl
	huuMLh5xiASGgI02M4sqaSmzG5EdI1v/zAKYZwTXMeU4YBA9DV0vB8Uk2g==
X-Google-Smtp-Source: AGHT+IE/q26foaVdZOAAgEyB1LRSKN7pTHr9KjgvgXh7B+nLaKPXZvk3iKr5A0UKZz5QZmH2IbT23A==
X-Received: by 2002:a05:6512:220d:b0:52e:a60e:3a08 with SMTP id 2adb3069b0e04-530bb3663f1mr9106692e87.11.1722906215561;
        Mon, 05 Aug 2024 18:03:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42825sm505488766b.123.2024.08.05.18.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 18:03:34 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 4/5] memblock test: fix implicit declaration of function 'isspace'
Date: Tue,  6 Aug 2024 01:03:18 +0000
Message-Id: <20240806010319.29194-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240806010319.29194-1-richard.weiyang@gmail.com>
References: <20240806010319.29194-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of isspace().

Let's include <linux/ctype.h> in kernel.h to fix this.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: include ctype.h in kernel.h
---
 tools/testing/memblock/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
index c16d9cd2d1ae..4d1012d5be6e 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -9,5 +9,6 @@
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 
 #endif
-- 
2.34.1


