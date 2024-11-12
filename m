Return-Path: <linux-kernel+bounces-405947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA29C5A76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6160FB472F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B09A1547D4;
	Tue, 12 Nov 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L6egqLuG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A070838
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418509; cv=none; b=HJ1yurZQu6l87Wqi8gRVddWtjarpnYO8jf2wghKDUtJhgk6C1P5ESwiF2fkyfPTZbMw858WGaBBZVI8TSRfg6/prY21KSyBf6LwE0RH4OoLVmNSxYcA+rKU0no6W+cZaoB4FTfWcsOhnqEVPJ2yJW5cDGoBHGAKGyvaNgv4jyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418509; c=relaxed/simple;
	bh=0mPjhSL26w+LsyPhnE05ElP18HK9dq75k99u1Eiz77A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kC0vLnuiFUb98HT7bo+Y1yQkqhLpXcZ4wRZ/SeqNc389GXasdk3vwLmkG1vFbTXXCTj31hzL0zeDCUg42OczKmHuJLNC0TWxsgc9rM3wiAja59ZyTNdAiSCo6616HZcIWDVfCR4N/BKeV5TKK2v2T3oiZV/j/z9qGpG9S/0MU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L6egqLuG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d47b38336so4359301f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731418506; x=1732023306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4uQtM40V/AAVLWbsCcG0T8laTlDVPnv9JhUGANTkL8=;
        b=L6egqLuGEPLsdlpTLcXalSBjt/UkaDyiq+pOWTYMV6zXKwLzc/zGLvM1sp8QS7wQKX
         e+CbCWZ9xIU56TgELtIxyV4/InAno21mjeGubXNkzse+U/qwxzLnZ4y3F36u15NgOtOC
         owY1zCRkqkq45UbnF3e7YSiUPQV1CDvdFciff+xNdbKFyfyuEKQiiabPinKfVG9YBgHj
         G7zxZnVq3AYX1/wMsf74XXCqiCXf0fzzCEk9yWqyPpmy9aOWdYJvhLA4mFEt8jPrXeRh
         +1vak9YIsUd2FZVzHofgp6+XYW4wcz3Oc52qFNRvm8Y3mw+SaiQa3+Ntbf8oDyjy+4qj
         mRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418506; x=1732023306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4uQtM40V/AAVLWbsCcG0T8laTlDVPnv9JhUGANTkL8=;
        b=qTKREgLeSu4seQKVqv749rdzyJ02JWXZioB6hYDGueLUlYJmTqudn8S78+BnHXUupc
         IucLAwCtbhisOdqznt4PorTILEaQ1ZditU27RQEV0ZPth5fSsB3yYbGqT7Ts38oJmnLM
         ++3Mxsgu9PUccJ/3G3hqPIMmANNsINA1q4TVPjV9M4C2DJY2n6/E8JXlxJNUAHpLG440
         Wl8ag9i78lGk0ZfEbygws5Uw1LX7+fwoAt3cNQXaWjqBPniwjaOdYcg1RMqel/2itA1Z
         Jgl1dQppnt5KOe0v5YGMyYc8HXybKB4eUznFeXuHdYRvAhYgSB7G6S3xr5poNiHzfITb
         w+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVrfzI6goJmUX/Ix+goK4wMvsGW7HxaVCcQlpTJ/PwW1GUqBdnfg6uFupPW2LGekQMGaL54H2iKplh0Zyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuXswbVPKQiDnK5b+LZPh28kShCoS1aGS4R8f8XSfc1pffgv/
	+BMoIThl9xnrGF4Uey/7zFkcifVwthpo8e2ndQ4JLNwRpaw5o7PeXEOvFjHowWI=
X-Google-Smtp-Source: AGHT+IHajeEER9F/q9qF7Wuph7Bji0x5a6RbiRsxvGe2BTVs4+IoqQQ9y3jR5ZA7i/VSAcSTGyez7g==
X-Received: by 2002:a5d:6dab:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-381f186b53cmr14933265f8f.23.1731418505982;
        Tue, 12 Nov 2024 05:35:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b3611sm241640655e9.13.2024.11.12.05.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:35:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	samuel.holland@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH v2 0/1] iommu/riscv: Add platform msi support
Date: Tue, 12 Nov 2024 14:35:05 +0100
Message-ID: <20241112133504.491984-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MSI support for a platform IOMMU. May be tested with QEMU when
including [1].

Based on linux-next commit 28955f4fa282 ("Add linux-next specific files for 20241112")

[1] https://lore.kernel.org/all/20241106133407.604587-1-dbarboza@ventanamicro.com/

v2:
 - Dropped patch1 of the v1 series since it wasn't necessary [Tomasz]
 - Improved error/warning messages [Samuel]

Andrew Jones (1):
  iommu/riscv: Add support for platform msi

 drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

-- 
2.47.0


