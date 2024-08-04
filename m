Return-Path: <linux-kernel+bounces-274005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915269470B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A0F1C20B89
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8B13A3E4;
	Sun,  4 Aug 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv6bgBQs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607DA2A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722806938; cv=none; b=ENHvA+B4mh4qwJYBZ8J055UBJ8wFbS/LFL/A3ro2XsPs42A8UxxtTt9B6WWZxlBIqn7jv0oP9WQsxKTsKuaKjIBPWKjDiRbMHXwPLKTDVIdaDv4CMf/qL5ius2qBn+xPqkWgOZ2F05e08wxfMOV0nWzfKlHFrEklBj3evAGrqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722806938; c=relaxed/simple;
	bh=CIn0l8AVH7JDpQ/tNGw/33hziB3QQUu+j0yOjD5L89c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Stunq7DeM/PU8vyrFDPcE3ODPPac1j/BW54MQn9pK2mIHIzbpEp0pvlLR94cDkjv9YZkXIoW2xhYG20iN2QtswnFA+Cf5F/M1kNjFMeaQtA8wyGKwAKsQOREOm/H95PjcAxs8RWvrn1g2fqz1iahJ4RpqPnvWFvQ9XyFB/gwUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv6bgBQs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36bd70f6522so545007f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722806935; x=1723411735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o49KYqt93PDS8OfT34m5foHhWrJofzPvrqhq7NoC4u8=;
        b=Fv6bgBQsXybD0M/WRVyazLpg3Un+aAtPATaYS5slZCqSehtBdeO4ALQCK9U20t8z+t
         XaUVTBTUlFa80kQpH8aiJ5pBCcg03/euCj+hlNsqAiQZBeatmvb5TnRj191e4xqgNTq0
         TY6p558h+g98Clt1WRFP+rR6dPr385QQsCu+1Pj0ce4Gd/3PFRepxr0Nj+rzGbF0i3MV
         FeOuIOWSKC777ZsTAX6IhQpKOwLgGg1KhepsgW6FDb263OdK/LE7HeaVl1Py2ToD5+uY
         +1kk7Jyqq+0qpQQxCbrqJuS8E5ddZUvYvr1CW664+OllEzt0CgDB99O5bFAt/RQnQ6LQ
         D5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722806935; x=1723411735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o49KYqt93PDS8OfT34m5foHhWrJofzPvrqhq7NoC4u8=;
        b=c49+DtNZREpHs2+hfkP2XPA+8RCOJBOm8PgiSySeZCDQC6TUwCmIQ5WL7i8XUcY+b/
         j7LTYHKYARqdB6KEUmGsmgsCRgSwOBxYK7I0mdzeJDCIFNXs5IQ50ZxuVZ5Z+GBVOVp3
         Mzrgd7iXy6meym17qPEGx9VcvC7P/fpT7WTczGoUxMWDfSQR6ROgEWwnC9cX2ISC7vfk
         xEQZrLnI2bsYta3pbBvAZ07+XoRteJ3JzaMIcIQncVdyPkA6IG7vsx2yMpi3f7LyL3y7
         AbEm/jyIs6rfmQ4wx5PWXbLLM2ztdrLGbP/bZiI2YCJwd57+l68Lf6cgfsHJ7IrNtk3S
         +Jhw==
X-Forwarded-Encrypted: i=1; AJvYcCXugfPvb4/9P2inRR8licslkS1/LMfF8pmSjFSu4LIyxMhxl7JPxjXk4z2S2QY/1CDcYJ9t8n+aYpTsibfyHJo/YttDod8CI0HJWMSQ
X-Gm-Message-State: AOJu0Yz9rhdNNYhBNsmMOHJAw/azVS0qo593AHL9+2fDBr8qJmBKzU1n
	Y9FUIx/qAScLM7RNbmVsjvBv6nGsQQpkHzs2eDseqMACjFrN5+jy
X-Google-Smtp-Source: AGHT+IF53ItQ0F9ASbLyWQSTd8/tD+i/q+Bav/qFx41EVaOBhLalec4gMVsrkRgYnkgFe/bCYL3HEA==
X-Received: by 2002:a5d:6b09:0:b0:36b:8f4c:71d4 with SMTP id ffacd0b85a97d-36bbc0e6360mr6439167f8f.28.1722806934774;
        Sun, 04 Aug 2024 14:28:54 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c309sm7846383f8f.20.2024.08.04.14.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 14:28:54 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] slab: Error out on duplicate cache names when DEBUG_VM=y
Date: Sun,  4 Aug 2024 22:28:39 +0100
Message-ID: <20240804212839.685795-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicate slab cache names can create havoc for userspace tooling that
expects slab cache names to be unique. This is a reasonable expectation.

Link: https://lore.kernel.org/linux-fsdevel/2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com/
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/slab_common.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b..c4f31c887f9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
 EXPORT_SYMBOL(kmem_cache_size);
 
 #ifdef CONFIG_DEBUG_VM
+
+static bool kmem_cache_is_duplicate_name(const char *name)
+{
+	struct kmem_cache *s;
+
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!strcmp(s->name, name))
+			return true;
+	}
+
+	return false;
+}
+
 static int kmem_cache_sanity_check(const char *name, unsigned int size)
 {
 	if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
@@ -95,6 +108,12 @@ static int kmem_cache_sanity_check(const char *name, unsigned int size)
 		return -EINVAL;
 	}
 
+	if (kmem_cache_is_duplicate_name(name)) {
+		/* Duplicate names will confuse slabtop, et al */
+		pr_err("%s: name %s already exists as a cache\n", __func__, name);
+		return -EINVAL;
+	}
+
 	WARN_ON(strchr(name, ' '));	/* It confuses parsers */
 	return 0;
 }
-- 
2.46.0


