Return-Path: <linux-kernel+bounces-380239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3579AEAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754DE28425D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CC1F7075;
	Thu, 24 Oct 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3pI33Ag"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D81EF958
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784485; cv=none; b=XX7PPPFt2kwNUzMAXeWWx6rUajiAmxezct42xhJZ5/b0Jgyom5g+NjGr4fe+Uc8gLng/PJmR5K4+EkdLoKtYyrvY1FsY5OJAs6ct2KsYLqAx3vMKA8Ve919FUrUOeOaRYtxDCePlwsx1LeGo3MuNWde1TfiICv15MCxC3t2HQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784485; c=relaxed/simple;
	bh=gLW0fh8PPs+BaOn5rkVzGVDEOg0uLVSjRbyJUCDLGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=get5qiUP3IWacm783s2KpJnKB8RGb3rM24aNqNqGrdRNw70FgdmFh0JIrMfHfd+DgxkgX8LDQvTzV1Kur2pYumH8+gG2bddDFHPhCpZIJgLUsBBNo+anKLFNmQZTH+twQh6zJJHiMATpAx5xaP9wlyu71P+Zet6IeP1Lvy18zKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3pI33Ag; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
	b=F3pI33AgsWV6FSPvVqdCZ1/kKGBfEhBDrX7WVmHkxhBNL3I/WNsQPlTC3b8zV1UsOfktsA
	m0Rpmmk4J+Pri4t47wjFVVKDVLYmCIrC38Pmh9CHY54S8Bc8ucw545bojHeGJFwKxSRGoD
	tpjNef5PEsiFaBPRzSaUIEWSWz+TQZ4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-ci9PAvmEMC-QyqQe7VaSeQ-1; Thu, 24 Oct 2024 11:41:21 -0400
X-MC-Unique: ci9PAvmEMC-QyqQe7VaSeQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d385a8f9fso326451e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784481; x=1730389281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
        b=vcgrcvrpiOUHt/HsvgIO54ixl6pu/P/QxapwY3Fgxf+IDeDGLNipfwyM8HlqhPokSm
         97KLxsZ8TYz6Fyg3eNACJCeQaS4/8/P9z8Lu29PENBkLujMa/HbnqZOwCc8XBKqbU36C
         NnqSerUB3O+EfBSQyB2BdFI2tLx4jcqHCvW3l1VeMoRkA+l662tvdu7RN6YCJWX9Iqy0
         noHALPrVqYfsS2ME7pEF0QjrHa1ofHvtnF2583V1VBSGAyeCk5jXRIUVbsvNOLM9w5FZ
         U8OaqMgpVWBbqjCkeWhGmvV18zUwxLNpeTj92vzCOQkyElO0VKGrPQPpfBLA/UZw1ar0
         SxJg==
X-Gm-Message-State: AOJu0Yy2y+WGNac6fEStriLO+qywfg2pPkkyC+UL4FJ7PT9feguhl2lN
	U7df/7YKIfAmLMbRUgYxQwKhH3h3bR9ZrW/jdXSWyEmIT+dBDamZrcTzGZ682TGHt0CkwVkzBmJ
	XZ1m0A0gXzxAuW+K0/WumaxPuxYkX22rMl22YPRQ3721g33sObi3D23+JjwlqRw==
X-Received: by 2002:a05:6122:3c52:b0:50d:4257:5bde with SMTP id 71dfb90a1353d-50feafaf2cfmr3108142e0c.5.1729784481027;
        Thu, 24 Oct 2024 08:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjcqYJKGQfUcpv5jcBoHcpWCXghuty7VZY+BBqG0fKgtkBaCSWPzjKiT1o+ltrBGA2G2CTQ==
X-Received: by 2002:a05:6122:3c52:b0:50d:4257:5bde with SMTP id 71dfb90a1353d-50feafaf2cfmr3108126e0c.5.1729784480567;
        Thu, 24 Oct 2024 08:41:20 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:19 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 3/3] power: reset: nvmem-reboot-mode: fix write for small cells
Date: Thu, 24 Oct 2024 11:40:50 -0400
Message-ID: <20241024154050.3245228-4-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241024154050.3245228-1-jberring@redhat.com>
References: <20241024154050.3245228-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
that is smaller than 32 bits, which resulted in
nvmem_reboot_mode_write() failing. Using nvmem_cell_write_variable_u32()
fixes this by writing only the least-significant byte of the magic value
when the size specified in device tree is only one byte.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc4..b52eb879d1c1 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -24,7 +24,7 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write_variable_u32(nvmem_rbm->cell, magic);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
-- 
2.46.2


