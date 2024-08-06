Return-Path: <linux-kernel+bounces-275530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5E9486E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40916B22B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E92AE72;
	Tue,  6 Aug 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmjZat5a"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE815E88
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906219; cv=none; b=NADhvNZqbUHnp3jFB/Z5sL1DDI6U00KG8LMnCFbktCeIXL+B19YpeAmuOO1go/ixQAaUiZN82zgQYclhtceJqcDArvxxTVJ+HkegP5chWBB2A/OV37CG6f13Sz2NKExllLww2LGowTQnliT54XUen6GqmXS9Chd4YKYvYEnKwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906219; c=relaxed/simple;
	bh=pk7lkvsq4/q/7RRT0lSiVWoJpROHZT97tsR2QMOJt2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uYbph1ltXrTcgQZ8SZo38SDeTog8pvNQPlqUgvdr1dM69yzhcLNasduPln2FVxkKwoQs+w4EdatFmLwlPQT1N5tcOTFrw6dn/oFyUjfoq5No/A0QFIkANFDN8Lub1f51WKsInlnHVFkhweFZj575nKk8kym/9y+QUyXSUmkDoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmjZat5a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-369c609d0c7so46563f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906217; x=1723511017; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=UmjZat5aS2YXbzXJEDavH34f+XjKNNiHsegnirbdQwtUjJOceqqmVQJ7EJb3OPmv4S
         H/0RD+3jmF2Cbm9vwPdN6h9gGEDEAlNHflKXALb/OpUX1lKWCNbKvWsMsKsKGb13H3KV
         zcdBQmbrdVUYHlomByci2ZndActp4CuxqPe0MgUMvzaBEThgFUuh+jSojQ4gTtodrI2v
         cXdav3aeKX5eHNUbYlzlL3lKd31YDy85vwzsn0I7ASMNbtHKUc6ibZ26mN2KtSOSeCS+
         xID/0Bc/KkM8eAF9cmtBemOn6L+rXzhbmsySFOHaf/U4JgcM5S+TbVs2Fy0smzKP2HxK
         Qydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906217; x=1723511017;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9S6gbxwdSBJfdbb/Z4n1WtX6iDsEmG4mLp80lBudU=;
        b=n1H2T4mBelVWvGO9N+GYxZjl60IlhnI8OZaWr/w62dfkm5+hoY9TN/067y/6nlF9dh
         83annzb3V8sdcZYaB1IbKhiucYRcpqLQEVc0SuYgPi4r/SDNaKyXIGTBcz9E1/1YcbBA
         8mMEX0lPetudpjB+nFPTOAnjDhA0s+O15K1VdbvC+Ar7qSzkOWAt65taDCgOQJQIWeuq
         eVwufmbnrSUY7x2jOrRpq0qzrb2Wk0cLBNSlInN7O4Q4pTcONEVdwcMbk/ihesyeiXRC
         5f3bP/tA1ZcKN9H+aJm8f4vF1HbbwLq8DRt9koB6ox3Tgjq7+E91mwaK4joq7bZ50vXg
         osug==
X-Gm-Message-State: AOJu0Yxvllzw6O9K7AGmiDNhxsO+26OQb8MZ3baA8VydQ/EEHwZ2d5Zn
	pN7B+PXd2u3QosAkH+GslW0KvXIbmnnwJ4tFprSlm0BJUl+V+oTg
X-Google-Smtp-Source: AGHT+IFOjaD0QRaWTraWGT8ewzbBmgOZWO2WZvbgW373+/rfGS0vP9WSqHSco9kNwtVcIvWjJ653GA==
X-Received: by 2002:a05:6000:8:b0:366:ec30:adcd with SMTP id ffacd0b85a97d-36bbc0e09d3mr10399765f8f.7.1722906216631;
        Mon, 05 Aug 2024 18:03:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec755bsm503344466b.200.2024.08.05.18.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 18:03:36 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 5/5] memblock test: fix implicit declaration of function 'strscpy'
Date: Tue,  6 Aug 2024 01:03:19 +0000
Message-Id: <20240806010319.29194-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240806010319.29194-1-richard.weiyang@gmail.com>
References: <20240806010319.29194-1-richard.weiyang@gmail.com>
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


