Return-Path: <linux-kernel+bounces-407141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB839C6958
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37FEB26A90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A417A92F;
	Wed, 13 Nov 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juskjPfW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226F1714BC;
	Wed, 13 Nov 2024 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479671; cv=none; b=Fp/jdAE6VGeHG44D8vo36nESqAXVyKi1FaF+iFt07+y3anB17l824JEsv6K5oGLonoy0D0F5Oy8Ckpd8zm9d8FiZ0lh1Sn9Y2ysCYcivHirGw2tbgd2G9DRF7zLzXYWEWu3YHVypJ5bwCh1k5PjciVjmxEPzoV6bpH+YWaDpTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479671; c=relaxed/simple;
	bh=iZGahcGw/ip8xIrXTDzim9l5DJiCEWJ7MHrj5I+Yseg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j97gbjo7uM3FtehazVyFdE1yxjwgMyHsBXrbLd0eQ1WDNVp2cXqVlJazPdcLw2RbRLVYGf+y2AyGlLhU7CofQ3moClEgap1FrpO64Fc9oL/8c8qLZBAZR5OpDw3y41wnm0ZntWh9izKun6j8S6l8HhwWWvMXzpJ/wJ3TC8RD7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juskjPfW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723f37dd76cso6758051b3a.0;
        Tue, 12 Nov 2024 22:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731479669; x=1732084469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvjRZrGcOUQW5mqy7FIUkoTS+9pLckU9+BVxZZoa7DQ=;
        b=juskjPfWcOVzjOslTwpfSKqwDi3PxCSU+VDt24v7LnIaAyN4jo4yK+KVhVqtHAe8Lg
         o1NyAAZlbfwNhqtcnAad2bJOntwNx067XiUsaWd07vseAkr2HpUwpTvDmXHZlUCwZbXC
         EOblpt6G0hmWe9+9JMVo4sK+Vn8Y/LIHqmybJAAavsnDNCNLtC19I3N72Mlo9wSftz0Q
         aoiGLHUZQQQ1mSkMJtCE1jaN9MernRpq76EuQF0m+Xyqz5n+Mf64MCtHsQ+YphB3qDDq
         KQ/3DSrKSOUlPDavzudkDEPccecnRR2KyudiIcQs9ZmmclnJFdvdnImXXRDoFXpcBUDD
         RaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479669; x=1732084469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvjRZrGcOUQW5mqy7FIUkoTS+9pLckU9+BVxZZoa7DQ=;
        b=imSQfm/xqVOCIFUOYZfeJksGU4nGsn+oR504Hj75JkSkdIgAhMDbuylOlZ4Id/oJew
         I6lB7sC82nuhqwt+98jAsXSXqhKkOUoc1asywmxLWbvLM3pl7KpJXtikxAwMV6N/szrd
         dDhTfPpDyHGRPHYl+6EKU64MhHPeB9eWRgfs6p1/vBPgwGqPsUl3qN6lZIlVVHP7jMbD
         U/I8E+Zd1DK2Fw0tJLDEg9rzD7h4BNfbjRqj/6uDS4hD7qz4MroqSHfNW01d5dYxozym
         MmIt4N5JKzCaXdo5z7FQ5W5l9omIOgOmIQHodNRjjpfJe4gNepOJQUEiYZdvCgHn/NFQ
         x+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVLsdBMih/Szq/AkcgmtpupSbaSghHMzwhHZsRTRBIgBg0KABv9pUkq8+UNfQulGwkhgIqpzjqF0lJbpLMs@vger.kernel.org, AJvYcCXPaP6hq9QD9+kz9PsyMJb48o7+CxM6zMpkXUkKFOswsH6CP/FbKXUFxBRZBmKcEmmP9L6VSn5o3vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEMtX5EX1RuU5K+UMBY1BrWQheVEFov+lACM74EQxHW9GFVml
	IuAqpKSMzT1VY67865DdMmeJVgwKWT6g5zKPsddoTklMHlwpirwU
X-Google-Smtp-Source: AGHT+IFPbQXqIv2ar+QII0hQpgBjXdJgL30cR+0I35z0Qeg/jgs8gSfyzyoSkqCRaIGNFonNZHvndA==
X-Received: by 2002:a05:6a00:10d2:b0:71e:6f32:df07 with SMTP id d2e1a72fcca58-7245796a213mr2177372b3a.1.1731479669057;
        Tue, 12 Nov 2024 22:34:29 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:3bdc:8c10:a:e04f:e712:3f95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72458bab30asm747572b3a.190.2024.11.12.22.34.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Nov 2024 22:34:28 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net,
	tj@kernel.org,
	akpm@linux-foundation.org,
	ptesarik@suse.com,
	xavier_qy@163.com,
	vbabka@suse.cz,
	tintinm2017@gmail.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [RFC PATCH 0/2] modernize DMA api documentation
Date: Tue, 12 Nov 2024 22:34:23 -0800
Message-Id: <20241113063425.21042-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

This patch series is inspired by the ongoing discussion in the following thread:
https://lore.kernel.org/lkml/20241111063847.GB23992@lst.de/

As part of an effort to modernize the documentation, the first patch in
this series converts the relevant document to use kernel-doc comments directly
within the source code, replacing the previous method of manually adding
documentation. This change will help streamline the documentation workflow and
ensure it remains synchronized with the code.

I am still getting below errors and wondering if there is a better
way to write this patch.

/home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:89:  
    ./mm/dmapool.c:229: WARNING: Duplicate C declaration, also defined at  
    core-api/mm-api:224. Declaration is:  
    '.. c:function:: struct dma_pool *dma_pool_create (const char *name,  
    struct device *dev, size_t size, size_t align, size_t boundary)'.

/home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:92:  
    ./mm/dmapool.c:420: WARNING: Duplicate C declaration, also defined at  
    core-api/mm-api:404. Declaration is:  
    '.. c:function:: void *dma_pool_alloc (struct dma_pool *pool, gfp_t mem_flags,  
    dma_addr_t *handle)'.

/home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:98:  
    ./mm/dmapool.c:229: WARNING: Duplicate C declaration, also defined at  
    core-api/mm-api:224. Declaration is:  
    '.. c:function:: struct dma_pool *dma_pool_create (const char *name,  
    struct device *dev, size_t size, size_t align, size_t boundary)'.

/home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:101:  
    ./mm/dmapool.c:466: WARNING: Duplicate C declaration, also defined at  
    core-api/mm-api:450. Declaration is:  
    '.. c:function:: void dma_pool_free (struct dma_pool *pool, void *vaddr,  
    dma_addr_t dma)'.

/home/ANT.AMAZON.COM/anishkmr/Downloads/linux/Documentation/core-api/dma-api:104:  
    ./mm/dmapool.c:366: WARNING: Duplicate C declaration, also defined at  
    core-api/mm-api:360.

Thank you for considering this patch. I look forward to your feedback.

anish kumar (2):
  dmapool: Improve dma api kernel-doc comments
  dmapool: Documentation: use the kernel-doc comment

 Documentation/core-api/dma-api.rst | 66 ++++++------------------------
 mm/dmapool.c                       | 40 ++++++++++++------
 2 files changed, 40 insertions(+), 66 deletions(-)

-- 
2.39.5 (Apple Git-154)


