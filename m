Return-Path: <linux-kernel+bounces-308395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD35965C63
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4110B23848
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8999170A01;
	Fri, 30 Aug 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhkBbFfE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49616DEA5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009082; cv=none; b=nYLDCdnGOy2ujRxmUICniEmlnT5mJFmUr514NNQgkd0YofFPYHOfoA9N/fw+WCA0izxaQtGL0gj+K79F8bgaqzdoqQ/Yuat7AtpOI63J1AToqUDTjDpNY1U5PpH1GoHjuWNtiNW30Zui9YI20SzWQrfo94G6NSY+ejNgoxZ4DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009082; c=relaxed/simple;
	bh=0aPmNGhs9tO0fe5XRHjI2S9pL3rlk18MNAcGQLSrXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUt3DEY+LvaiGI27WnLxTauIY3oOM8w6dxu3w4Z0KLZOGgZ7HmMxl1foYjPQI2kOWxnwOHPqMnPwqKDiYsHdopYlVwgdrzfVxtogqyf2hDdGhZiXvXivg9Cv7gQ3cEohm9UHHlIzVMfNS7Dg6ygujeSQ8a6wTr3YjxZesUOye+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhkBbFfE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718706cf8aso945555f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009078; x=1725613878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBrOeXUHA3Szd7uhqfg98fjpivmBoTAKkjh8oz5/mr4=;
        b=LhkBbFfEb/0aExHuNFWHvbnAjWLGPsMcx5zrh9qb2gGbpQ/+UJzwBsyYQoA7Zc7S9Z
         UiDVAaHE+FVBTLX+cAdCqo7t3yZvqpK4T/SpKebcSvCDB3iyR5V5DG00uF1vleCxVOV1
         S/XNcwbeAbMX5gbxyT4k5g6Kj2J0cPVLC1qpJYP7oiwKVjinaX5b1VXfMMt1Wgy9BUuW
         E80jTjd8euwUE5TsT46hxbefn3Xu8EbAz6A2fhYvN/Va1G+1RCn4NJKoS5k02JV+/Gen
         9iAjmk9RIz8i12iVrNyw+v18Wx7dQRNsQuw/eUpyuIuGjsJ21rM7GCkDMXxzVhHY3TLx
         htag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009078; x=1725613878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBrOeXUHA3Szd7uhqfg98fjpivmBoTAKkjh8oz5/mr4=;
        b=aq5uq/TwoTLL1Wh2HVI9qtlAV1wptsANVdruwd/fX29Wjs3lvjVdIXZjemuoAFL9oV
         vUwcVcgfwpd0i+pG1+q0n1QXno+hz0+OuKoMnzXf3d4rke0FgDCHy6iF/2f5olS8D41E
         NS8pAnNgT4Hdu4e8fSEuCPZLy5RMndj7U8wUfpCeb5m5f55rDYcs8HZ7zoDZ/w0I4NEa
         fplXsUTskE+s+M7JwZvnKiMUb+JHswEY34gxJzL3d+FvbuaE3RcqkZB3IEBy82UKlQDE
         oYvq0+/vqy+lQ1fuzPF9CbA5s9VdZbd8iQn00DZKeOwHCYn1U0/IDAksTnhXWZ3Lhjbr
         tl8w==
X-Gm-Message-State: AOJu0YynXsiZSXbfY3+njf9Me2Jkqi3KaFsfMEQsVb1ypKdx1jNBF5vY
	lbplLlke7GfHuYKD1Xs+9stfnBQtVZvfYaXo5gBzYbABhhbuewDJsXsWVTJl
X-Google-Smtp-Source: AGHT+IH6HhU+dJiUeRAV+gtpl0IYOkJ4xHiV4c282COTxFGvkU28/aT14arC+JXRmPSdm1n2yqOnNw==
X-Received: by 2002:adf:f507:0:b0:371:87d4:8f1d with SMTP id ffacd0b85a97d-3749b54eb19mr3549436f8f.28.1725009077811;
        Fri, 30 Aug 2024 02:11:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a5edsm3414569f8f.1.2024.08.30.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:11:16 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] squashfs: Fix percpu address space issues in decompressor_multi_percpu.c
Date: Fri, 30 Aug 2024 11:10:50 +0200
Message-ID: <20240830091104.13049-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When strict percpu address space checks are enabled, then current
direct casts between the percpu address space and the generic address
space fail the compilation on x86_64 with:

decompressor_multi_percpu.c: In function ‘squashfs_decompressor_create’:
decompressor_multi_percpu.c:49:16: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer

decompressor_multi_percpu.c: In function ‘squashfs_decompressor_destroy’:
decompressor_multi_percpu.c:64:25: error: cast to ‘__seg_gs’ address space pointer from disjoint generic address space pointer

decompressor_multi_percpu.c: In function ‘squashfs_decompress’:
decompressor_multi_percpu.c:82:25: error: cast to ‘__seg_gs’ address space pointer from disjoint generic address space pointer

Add intermediate casts to unsigned long, as advised in [1] and [2].

Side note: sparse still requires __force when casting from the percpu
address space, although the documentation [2] allows casts to
unsigned long without __force attribute.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

[1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces
[2] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/squashfs/decompressor_multi_percpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 8a218e7c2390..e4d7e507b268 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -46,7 +46,7 @@ static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 	}
 
 	kfree(comp_opts);
-	return (__force void *) percpu;
+	return (void *)(__force unsigned long) percpu;
 
 out:
 	for_each_possible_cpu(cpu) {
@@ -61,7 +61,7 @@ static void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 static void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 {
 	struct squashfs_stream __percpu *percpu =
-			(struct squashfs_stream __percpu *) msblk->stream;
+			(void __percpu *)(unsigned long) msblk->stream;
 	struct squashfs_stream *stream;
 	int cpu;
 
@@ -79,7 +79,7 @@ static int squashfs_decompress(struct squashfs_sb_info *msblk, struct bio *bio,
 {
 	struct squashfs_stream *stream;
 	struct squashfs_stream __percpu *percpu =
-			(struct squashfs_stream __percpu *) msblk->stream;
+			(void __percpu *)(unsigned long) msblk->stream;
 	int res;
 
 	local_lock(&percpu->lock);
-- 
2.46.0


