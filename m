Return-Path: <linux-kernel+bounces-272010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE899455DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F7C1C22AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C3DDAD;
	Fri,  2 Aug 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCSmS8ir"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200F12E5B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560977; cv=none; b=plH3BnLway5p/pZ1QzCOt1hT+/wcs2TEfjZXvLHT/ILSZrpFQIEZZxssNfFV+V04FROPPXNz0RIs9kvka1k3NgYPnAZpx63ezIcNrxcPo29bibyWlNt+Ev2/gSr1Z5IrX8HaQM+sBhq8MR9QySXNsPZEcveL66NG5KLrkO37JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560977; c=relaxed/simple;
	bh=cW69NMJFEBfWn+KRRxZdeTGqvaZ1VlUhGqT1bGfvs1c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NW2d7sMkczjTlIcgnuz3SlZbPcLPxksgJEMafCGTcC1YGLwampO2ZfVO7ajKQvQP+XSKuQwgHh3BwljDl/D42gNioBHZv1GvjlidyKLL3hfauARw/dByjbsAo5GlzfMPefX0QRL0ucY8x9QAw9QGhqE1l0XbJwP+mFKrdtHMY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCSmS8ir; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab63a388bso551509166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560974; x=1723165774; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3htfNHgZGtTKSRwOgeGEYeAav5n0bsRhJ35ivdzxLI=;
        b=bCSmS8irYCJDeUpDS4wd+AdxXFBqo4y0ZE6yL8E1PyfNGxwxRKuCaunLAfilDNrkHr
         W6TuBd1F/vB9yHvf0HwUMzXOoauPG6X6auMrs1RiQpfDwAA5Wlt4AK7nhZOqw1YhrJ+/
         5B/5T8V97hlAtiBGpJEMT23tM1jSj3fxKJ2kfSDlkvSIWsgah+ai6511zuTenbwfTQ+k
         Vu84ZgW2p2bn0qnwNJkLc9AS6zuLRdvynj9ag5qZy45/ETueN7pvAbMhnugMrFz1X98g
         qt3vn0bUpVhHjoKwNiUyIKZW1fs7WZGMFoFj7NjIxPPeLdzA2wI6m34wNsHeu9KM+4IB
         ICgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560974; x=1723165774;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3htfNHgZGtTKSRwOgeGEYeAav5n0bsRhJ35ivdzxLI=;
        b=SbpYrS4jOV3v4KzbRoTwNCggZR7QZwMWbY7Y2D9EcXsrt+CMHHl7FtsTkwf4lh0Zpp
         r5BsAWDjx8syTlwWPmSp9HXbJbjMMXvJSp2I+wsGrz/tYbQP8Ic5/paBUYxVubfC1bZI
         wN5jw0+iDfQCA7t6JzL4WaKimIt6XxlyqKG20lGE475PDWNERM98aXVtqbEkXcu1blSa
         HbWgqHfuD4y51yZ0Ela433TCly8a86KCeaqB5m9uaM4c3FfuxZYox1iBTrzJw6TDzd+y
         vdfWB0W3kh/65klobRp2dZW878S79Pf8scuE5q5JxwelC6lhjIieOg/zluFgEq5EbFVo
         gH6A==
X-Gm-Message-State: AOJu0Yx8Dh6CC5pfLMjn6Wlx8BXoJ7Ykb4vSGls7RBU+oJurizOqCG4b
	x8ku0Aa7QY+mLUfxbvBywWwqslo15v395A4atl/fw3br9rndiu0V
X-Google-Smtp-Source: AGHT+IGk96XkxqZGR+9KE5YgVgC2rAoZZFUtfBkFOOk5wXY+CwMv7bMbEr3HKxnVi8q3W4MAS0niTg==
X-Received: by 2002:a05:6402:114e:b0:5a1:5692:b5f9 with SMTP id 4fb4d7f45d1cf-5b7f56fd3dbmr1500125a12.38.1722560973847;
        Thu, 01 Aug 2024 18:09:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b26d13sm406598a12.21.2024.08.01.18.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 18:09:33 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
Date: Fri,  2 Aug 2024 01:09:19 +0000
Message-Id: <20240802010923.15577-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
alloc") introduce the usage of virt_to_phys(), which is not defined in
memblock tests.

Define it in mm.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v3: use static inline as phys_to_virt
v2: move definition to mm.h
---
 tools/include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index cad4f2927983..c9e915914add 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -25,6 +25,12 @@ static inline void *phys_to_virt(unsigned long address)
 	return __va(address);
 }
 
+#define virt_to_phys virt_to_phys
+static inline phys_addr_t virt_to_phys(volatile void *address)
+{
+	return (unsigned long)address;
+}
+
 void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 static inline void totalram_pages_inc(void)
-- 
2.34.1


