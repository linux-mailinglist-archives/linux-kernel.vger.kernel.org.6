Return-Path: <linux-kernel+bounces-343776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C0989F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D2D1C2154B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB22188711;
	Mon, 30 Sep 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCT+QaHp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86E26AEC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691800; cv=none; b=N08abGmvyjjPIsxpuKKHtw71kySWXmAT3LpxZW5jK2YrJnI8R0Hy6qenLKgxEsKw6t2q7Z64KzKjdbNJVEMlxMy8u0oPmgMOt4E14o/ikmLxYhqRNJwUlGYib+6SD7OG+hf5J7aEJu7pgRIdL1e65wQPQKK/CCw7bzxDAcAa3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691800; c=relaxed/simple;
	bh=gmlgwYG+vj6T+6t1roiX69+3s5nj6eQqICrmGsYyi2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AB2ahpjwzG/UBdCEjRsuYQM2Bcgtqkkh9nADsceEv7OncI59jVVbzNnkfRi3QwoFlcfIceIXts72BCU1tb3iQy2SCPxHnoQ7Rb8wHOqkpmYLJzJT1fh3VDk1vP7zku+G+2WkCpaImv+aRIp+xA7f0+k9GbZ+Uzh1XHjBjrxB6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCT+QaHp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398996acbeso3045031e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691797; x=1728296597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmEITXlR0ceUxPN6rul6hZDhcOAMvvwj8hZoqNcz/nE=;
        b=NCT+QaHpOAlPrBi3ALG5gMiYgd93TKhLQbUVMhnlQF3CiuLrsVvZEfukq+XZykxG/g
         X16kpPzXEWmkowjTFJWrFaOKGz6EJNQbTSyPpGzY/+v0oGKTaMSe30PcnijhfYtTJzcP
         fixRBX9qkXLh9VENPzfzNb/1MxAQs+TPqCyvYsgPeqs0GrEM30MuEF+pcAUwk6kEZ38h
         s2iaHsUtxBtGMb6qY9TPAaqmW8pl9PlpuuByNyKKgFJX8YmCY3rcOlWlOqp19Zy4f0Zk
         F2LzCNCDmh6AZWTEf+v15L4vtR1kEyY2T5rsiV1+7+9yfSh1O3u0EnUyYaeC+KgJA0in
         1HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691797; x=1728296597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmEITXlR0ceUxPN6rul6hZDhcOAMvvwj8hZoqNcz/nE=;
        b=TkGnaSCBR29ipK3mFPefPjkel0gwvLOfG7LPw2zIbGkFnN+2NmYAAGefigUJPr66+f
         h2JOeU7bHUpp3aRMujuUxs08cLm2DsviCf4bypyWcv8+N6mZN4x/ailmtP6x1mssvMgj
         nZs/1tyTmD86r9W7dt1Yb6TbJUAjEJbmPBHVTAl9Gs+/1s1DgBlxmVJxSTcj0CtDF7tF
         +eC69Ysm5YCzR3kOUNLa0PIeGkVVSzjNtqrNCwrwnQG1ukGFDglWwjmH28snd0AZkKEN
         IHZiG/YqrGh1PNNkSaSgFASq5frCy3OXJkyoifAjjrEkXskWpnR0MyfZlIaTA5FoS1fF
         Dn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW300pyWs2TSdkgRvk8K0KPnNoNqf9o14Nlwb1p3CfXatyKjTUeVj9YA7RTDDil2IMqPD5Ku7RmqKtLpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJtP0nWsY9EGrsv2//Fv6zqmKk8wQp8eVBKgtzTEPlNUGECH7
	OSoMbgF9vL0e82gL3DTTtIBqw2JZELER9ZAUZ7F8CkwNYjEGClctBbUf4ddvs9t8iw==
X-Google-Smtp-Source: AGHT+IHnQtAkIBhaWFdwFHnkp+CnZByohDf1mJVlXB2WmbSuBqwW0DU+WU4shf7k5U6O7yo+yKUZcA==
X-Received: by 2002:ac2:51ce:0:b0:539:89f7:3187 with SMTP id 2adb3069b0e04-53989f7343fmr4800401e87.47.1727691796866;
        Mon, 30 Sep 2024 03:23:16 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539903944e5sm569425e87.162.2024.09.30.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:23:16 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: akpm@linux-foundation.org,
	dvyukov@google.com
Cc: andreyknvl@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH] mm, kasan: proper instrument _kernel_nofault
Date: Mon, 30 Sep 2024 15:24:05 +0500
Message-Id: <20240930102405.2227124-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 88ad9dc30bbf("mm, kasan: instrument
copy_from/to_kernel_nofault"), both src and dst were checked which might
lead to the false-positive reports.

Regular instrument_read() for copy_from and instrument_write() for
copy_to triggers KASAN reports in mm/kasan_test_c.c
copy_from_to_kernel_nofault_oob() kunit test.

Tested on x86_64, arm64 with CONFIG_KASAN_SW_TAGS using the latest linux-next
tree, where this commit has been merged today.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/maccess.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 2c4251df46c..f752f0c0fa3 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -32,7 +32,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 		return -ERANGE;
 
 	pagefault_disable();
-	instrument_memcpy_before(dst, src, size);
+	instrument_read(src, size);
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
@@ -40,7 +40,6 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!(align & 1))
 		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
-	instrument_memcpy_after(dst, src, size, 0);
 	pagefault_enable();
 	return 0;
 Efault:
@@ -65,7 +64,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 		align = (unsigned long)dst | (unsigned long)src;
 
 	pagefault_disable();
-	instrument_memcpy_before(dst, src, size);
+	instrument_write(dst, size);
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
@@ -73,7 +72,6 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!(align & 1))
 		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
-	instrument_memcpy_after(dst, src, size, 0);
 	pagefault_enable();
 	return 0;
 Efault:
-- 
2.34.1


