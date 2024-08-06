Return-Path: <linux-kernel+bounces-275969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C59948C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D89B231F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E441BDABA;
	Tue,  6 Aug 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRu/2RkO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C116D9A0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938927; cv=none; b=ZEzltAU5/2/HTbaAQZDg6d1HhJdpkKqatalqt6fdIc1k8cKbXoKBWsbwtBrA1lbItR/xfl4rWvOXmIZCFeU7cct/Twy5gC3+xUMBU1hXe0is0hvuyU/tsU4WINT+axtvaHj01+Rif7rZHaN51HL2mhCIrRW+zk0T3ob3GDXZvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938927; c=relaxed/simple;
	bh=Hftv4uJL6vqe0PQ5kdr5T5eYpB665RTddbO0b1v052g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHAg6gmKyu7PyJ3jD4SHtJ+IP27D+9HpZ9E5o54U3RIGman4sRB7DRrWr/C6EP8oJepCgOdLbyAbJjXqMhHWY/a1Ip9U8Y2IaiOo1UoXZUPuZZWb+YYDhMOxhcEFYlqCmp5MNNglnqs3Slet06srKIaecr9qheD9EJ4lW4xBn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRu/2RkO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso455226a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722938924; x=1723543724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SH17zS40z45pzSY+PjRYGaxbCUp4TsfBuwMweVoryw=;
        b=NRu/2RkOOI1DgRmbi6zqzAaIa0Oyk6P2uBnIwFp/vS3Vmp6bDvm9lTL2JocmUl+d36
         Sntf/SPCpQa1OB1NMWdcrZH+EdsI0mz2FYlx/MCJtblnAcAQJVJ27WR7ESzNE7v42UFb
         9BrqTKc0ppp9Wud/QG3ca3Sg6UCYIsyzK8B/vIV+R6rvSM0Nn4iyA/l+rCk/awFdYVCm
         oCUwxWdswHtl1+egCjTkdWlCXAWUPH4X+xVtrfyw5U9GLyjqiYhFA3+TcoEz/dxh6k4H
         nK89Zasdy7z1ZOIX/2uXJ1sWsfBSH5g3VG6J3/zrEOknOHuSou0Np2x+QhDGZt0YJtPe
         3wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938924; x=1723543724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SH17zS40z45pzSY+PjRYGaxbCUp4TsfBuwMweVoryw=;
        b=jrNF30tQi/5fIdGLxkBmOpY5dD8/sa7i6t2PvLiHn9x6ARNf1tr3iOvJWv8utORk3t
         pAZNntSyy+pZFtwzOQvqyqtepRWJyl09wu2BPIGpekdIalVQqzhDn2HW06n0CGW7pVww
         I19Ms0SG4HINY3cdhkZLW6KZQEoZ/kQQZmLhah8/2tBVItpPFb8BALUlBAnIvpgtwblQ
         o45b+7UnHBRI84KZA5BpmWK8ZOsXv2TOcBV1+U/ISnIqapbx/t7kJ8C/rmeNdn+1WOql
         /LXW+NLiayMuexJo+UnY+sIpiBSqWLdhvVis0itGfgNcKJHZgNOZQwFMmok7/cjcPup2
         BzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzJuDKnevz/sslaY33CwyyCgjRg9ui/tCESuHsKkmxc6r70rofF0thk/rDVLQaNpRQ+SDFru7dx3egzYzZxxFcRuP1ZH/f8Y8EkGf3
X-Gm-Message-State: AOJu0Yy2zXNbjUSxzFSys973XS4Xuu5TgoZnS0XPA0VWvJWfqmP/u9zJ
	/Arq9ozF/0j+p9CCGOD2TOyie9Z/Wz6adCIDSZwyrrsRpnw9dGooFwyXGA==
X-Google-Smtp-Source: AGHT+IG8pDjbJFUBnJ4udAVO+3KSjscSIDKPwHZYCJc68+q70UgWR+CVtD1Qes7ET+/DY24Lo5BvMA==
X-Received: by 2002:aa7:d5c1:0:b0:5a2:189:6306 with SMTP id 4fb4d7f45d1cf-5b7f40a71c3mr10972986a12.18.1722938923831;
        Tue, 06 Aug 2024 03:08:43 -0700 (PDT)
Received: from enno-kaukura.ad101.siemens-energy.net ([147.161.168.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b723e78sm5845900a12.59.2024.08.06.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:08:43 -0700 (PDT)
From: Andreas Oetken <ennoerlangen@gmail.com>
X-Google-Original-From: Andreas Oetken <andreas.oetken@siemens-energy.com>
To: 
Cc: Andreas Oetken <andreas.oetken@siemens-energy.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arch/nios2: arch_dma_set_uncached did not return the uncached address.
Date: Tue,  6 Aug 2024 12:08:24 +0200
Message-Id: <20240806100825.475145-1-andreas.oetken@siemens-energy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1429633945-30463-1-git-send-email-ennoerlangen@gmail.com>
References: <1429633945-30463-1-git-send-email-ennoerlangen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in arch_dma_set_uncached that results in the address
not being properly configured for uncached access.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
---
 arch/nios2/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index fd887d5f3f9a..43ae589e1624 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -73,5 +73,5 @@ void *arch_dma_set_uncached(void *ptr, size_t size)
 
 	addr |= CONFIG_NIOS2_IO_REGION_BASE;
 
-	return (void *)ptr;
+	return (void *)addr;
 }
-- 
2.39.2


