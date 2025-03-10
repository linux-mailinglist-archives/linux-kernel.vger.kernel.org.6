Return-Path: <linux-kernel+bounces-554317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDCA5961E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A5B16D9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767A22A4C8;
	Mon, 10 Mar 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DXB8nGKG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704722A4DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612952; cv=none; b=aGRnQmw4ByBdp9i/vwmAnyDqfz74ACwlJi8QRqrYL1wImcoFw6uDAKkTqD3mFBxxrxrbYmK+SQcQnkZIZRoMsP8LzsRDF2iOKGlpQCeeZeGp4NuoV36aIq91joYXB/MQMIUYv7fln86jeUytzfXpSTnJELacRSeOeqaZDt1cZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612952; c=relaxed/simple;
	bh=TlMGvywFpu4PWsYOQUD+gLerou1tgqEiVMfDpC7hoA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBhCdd8CVjD45Jr+4+Q0EjUM5JbGLj2QTiG2DHvR8lOuWuTdhiOhyt7Ob2Q3wd3XCkYJyY3jMvm8u6+Ck0V3oJuqZ0kNF+Ec3k50fe4Lj5/oMUqWn3O3j79rDw4uWvdyPzEHFi/miAbRf+FFPe4dkE3jNtPoGt7TwYcxgyFDW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=fail smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DXB8nGKG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22435603572so37533855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741612950; x=1742217750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecoegn4fA/qWcBRqZDVU7bAJEZ7InNjeS9MhK8OnR7I=;
        b=DXB8nGKGBi6KB9tlksos8gJiF/RQ5nqqohl/FrRDoa5a9VgmqDBGOJVBA2HLLXNcnH
         6uFa0rCODFXB/EFpg2EigIY4aADX6F8km485ojEms4aAsBkKS8rXRQt+52vSnf/7vkU1
         ezSPm5gs0sa/fnqnGAqJqnc5dvRUm3cJg7kFDt3exgs0fLrvb4XAzR14n2hxbbuSV2PH
         QISpJY8i56gAlTRFbsZrUei9gfQSu2dD6eGiWxhnU+jKo8wqsVtrmOjRUAW9uwtlZd8Q
         TT6+V90RJut/A2ACGBisGgA2+9jJYkY9XXysKqygVT+RTJBRXYC5aGifXWs0hC6V4Z1V
         sKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612950; x=1742217750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecoegn4fA/qWcBRqZDVU7bAJEZ7InNjeS9MhK8OnR7I=;
        b=P2o3847/pzSZba+lgbrrPmUvtr/oUQVqC0pykbRHHfwbWLpZphLkb+agRbWiGpobc0
         yPHCXnmaPvDZWciCT8ZxeYalaqXUq+FRPdOmkN+odCa+11b+s/xSCCOGbxocy2KIaKYG
         0KJ0242Fzncb0FMQaTZRoOhW+30TOJDNJ+fQYmg84q7XKgvF1E7k6TA7fRFod/aMcKxq
         O5u9FH6h8G/MaCcuC1bE39UpFlKSD+KBQmmvT90IAxPBh+pTLd3WwmVlLWM4lXOpYVgR
         pjd8NGBVVdgQKzti2ciBLmiLUaBkLMRys6WuHEuRjDLmTdzZ+aPUFvr4GYTD9w3WnRAm
         vg8w==
X-Forwarded-Encrypted: i=1; AJvYcCU9alr2nkaW8uC1mISPfvySypb1cy+U88upZZRc97ROH+DnAqo+dNkzm61G3Rel9eukBk7C+SSlzkV5WCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhVTAtES/SlDuXAsZKuOQU7cOJx+fCpacfIZfV81bfh0LdxfF
	q87OQO9GRUYdX6R5saJRnc0c9Ut5rePwUn6chjMeb4azks5O4iGNtg40N7XF4yA=
X-Gm-Gg: ASbGnctWvh3jxxWo6oVJ0LwYD7g/ZOFUs0bgv7NEp8HqPCoA4K7dBms7PJquYaQiWA7
	Ry+vroW3P8dGjpwTX4EB1PUDJMKtBH5pBofHaL7UGnEl71EtTlZewAG23P0uiix4zg49WnD7JXQ
	bnUINgFwM32nZiVp5zpAFAFbhv5mOM08GnMSxrTbFkQW5aZoH4+d9DZ6TTDR4la7l3xwyUacO9a
	C1SzkYRPpVoBL17FAojb3C5FyUmyOpqax1LRzDzNdqj5Q/u+W4xaak9qCwXNMKpbTJfep+eFiUL
	d6ag2RQWNMrhtsS3VA+YqCz7W9G+7ZmoxkYClr4Ku0UghVfSgMse3JW0IvCCpBt9Nk5HjOqezHx
	8+0vSs85/Ni0NOb9scLYwcKm++HA=
X-Google-Smtp-Source: AGHT+IFu2n0g4sZs2+O2XTkLIhRuYqBot67+5l/Sfz9z48bWpPobUYWSXXb5rmxQvy1FzPZ4GNzqWA==
X-Received: by 2002:a17:902:ce0a:b0:220:df73:b639 with SMTP id d9443c01a7336-22428c07542mr213599585ad.36.1741612949902;
        Mon, 10 Mar 2025 06:22:29 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm77318785ad.61.2025.03.10.06.22.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 06:22:29 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: akpm@linux-foundation.org,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v1 0/4] riscv: iommu: Support Svnapot
Date: Mon, 10 Mar 2025 21:22:18 +0800
Message-Id: <20250310132222.58378-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the RISC-V IOMMU hardware spec, the IOMMU implementation
has the same translation process as MMU and supports Svnapot standard
extension as well. These patches add support for Svnapot in the IOMMU
driver to make 64K also an available page size during DMA mapping.

Xu Lu (4):
  mm/gup: Handle huge pte for follow_page_pte()
  iommu/riscv: Use pte_t to represent page table entry
  iommu/riscv: Introduce IOMMU page table lock
  iommu/riscv: Add support for Svnapot

 arch/riscv/include/asm/pgtable.h |   6 +
 drivers/iommu/riscv/iommu.c      | 253 +++++++++++++++++++++++++------
 include/linux/pgtable.h          |   8 +
 mm/gup.c                         |  22 ++-
 4 files changed, 235 insertions(+), 54 deletions(-)

-- 
2.20.1


