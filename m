Return-Path: <linux-kernel+bounces-373872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255819A5E37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F12F1C226CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05DF1E0E11;
	Mon, 21 Oct 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDAgRR9P"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629E1E1A3B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498147; cv=none; b=HoBAGXCeDcSfYKd+STT0TzO2nvBZKEsP20cwdLkyPd+JjsGuRfMWqfndA2Ixows7FjhHW3ATttAqRrU0VMneIcR5zEZBkkjijuzI5k4IqmArFvY9hFRm0XzxSkfFiQ0Mw+DWINf7G4KFNA9P9fbNAdnBbhvtekrnbTCC1NV0RSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498147; c=relaxed/simple;
	bh=utP1TBVPTQii8sqmMIxLHJpFjq0gZZuv3z0x3E0vmyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6FgNW4rVqH/8ZtHW2istukqnvp7Sd5OGCRC5kIVOmsDiNjcRK+RqgK9pGKwbfJ1RqAORCooswT90K0gPYYf6oobmHptgKvyCRJAyVhxj1nz4IY8T6slHcwfv3+i90lkWZR94Ft+30SPSKAMkz6wJ4XUDUjKcnvty3TBr25sVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDAgRR9P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so46826405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498143; x=1730102943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGYDCgTegQahGt6W0OyeaxxuCRjXY1E2wgBMnm57zms=;
        b=kDAgRR9Pb4iBPt67hQPM07qnTR5hekan6LZ4RrsxUtNe06uIY1B3eJunOIhR23GAa2
         RgbadrhWF0DhkSoOCWLBJTdcIO4y8DQTYM2dbDypoEKqJQfEY/YNZOwIeWsGCx8xAGsH
         VLrz0J/80u++MkRNDJjwYjW2qwf93YBbcuqwSA8I9QGwk5lH45FbJ+Vj5axKJBl5sQT8
         yljrkHxoNxbc9WK0e0ira0neTAS1MK5nPEumNtvOeqTYZqpYBq4ZxgQq5aJ5dZaYNFIk
         IKys/2lW/kQcFErxKBVQqRAhjb+MCnWXiyAmK9DKyMx/wHiDsPLYzac/MOuxXPdX0mU3
         e/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498143; x=1730102943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGYDCgTegQahGt6W0OyeaxxuCRjXY1E2wgBMnm57zms=;
        b=LZRpHqOvJk47h5xho9xLP7BGEkYR1H6y+AK/4sGNXTQ1257DEjXy20fPowX4eZMTty
         eZhORjqdCe5foikwn9bjI4rRbvdlhX4HGY4yCHEPxJi1+Iw8uIkro7hcLrUxZ1LAKLUR
         FX7KOJeE+CvbtEj9pHzzFquvBAnw16tnGROFcR6TIilht08G/e3OhXHD2PrB//C4kJ2X
         Qs1l38xxyTwGKXQiviOlmXGxTRMk5spHMOzT7g4h1VnbwT6SCs1f6RsoJGeFeNgk1Ssk
         qKonh39r8t+2GT7F2FoCecKg+480gbmjV8n7Ub1BRIM4N2zSO9axCNbh98NxgQR78Kxl
         +gZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrhBtjFEyT9n/TXXZs8CfBBjSTtQtRFY9QwzNZWvI9NoCs3sI10Q6Fe47N1by43FvovKN0Qc1MEk4ptYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCloNJ7/ekzpTi6W7mDFepY/EiznhgNGWalZON20/3vkOGjqBe
	EIJEVJkMm0b7iY7WQUUHpejbCxKNp9anSmQksYb8wHUaceudRZ6J
X-Google-Smtp-Source: AGHT+IHFQByHjFNMRT59cjPcxA3RcXY5ZiMSkbh1QNihsbwHAb2N9O3yUVyeBVPBGs/Ass4ZkQ+uMA==
X-Received: by 2002:adf:f9cb:0:b0:37c:d1ea:f1ce with SMTP id ffacd0b85a97d-37eab2e303amr11142282f8f.25.1729498143150;
        Mon, 21 Oct 2024 01:09:03 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706a7sm175925366b.141.2024.10.21.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:09:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] percpu: Cast percpu pointer in PERCPU_PTR() via unsigned long
Date: Mon, 21 Oct 2024 10:07:38 +0200
Message-ID: <20241021080856.48746-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021080856.48746-1-ubizjak@gmail.com>
References: <20241021080856.48746-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cast pointer from percpu address space to generic (kernel) address
space in PERCPU_PTR() macro via unsigned long intermediate cast [1].
This intermediate cast is also required to avoid build failure
when GCC's strict named address space checks for x86 targets [2]
are enabled.

Found by GCC's named address space checks.

[1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name
[2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/percpu-defs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index e1cf7982424f..35842d1e3879 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -221,7 +221,10 @@ do {									\
 } while (0)
 
 #define PERCPU_PTR(__p)							\
-	(typeof(*(__p)) __force __kernel *)(__p);
+({									\
+	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
+	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
+})
 
 #ifdef CONFIG_SMP
 
-- 
2.47.0


