Return-Path: <linux-kernel+bounces-370129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF809A280D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B391F2332C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599C1DF966;
	Thu, 17 Oct 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmvhvKYw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCA1DF73E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181381; cv=none; b=riJVRqsUF8vPYVN5jOP/8vBLiW0jsApuf5KzIWKbn+9VYIDMNAI+sFscbaH3Fq/eVZRR43+xHCEWJ9tACGUcHNkQAB14pTjlFkTyVaHHAnoF/GI0DTcjSNI2bE6osbvCEwuwVnfJNTQu4YduBI1z1To7x7WWg4B3nY8PdVJthDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181381; c=relaxed/simple;
	bh=gLW0fh8PPs+BaOn5rkVzGVDEOg0uLVSjRbyJUCDLGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFfW0p1+sQ180ic/jsH4jBi6KWXJHeLD+W7A1thRmbmbd5gFfpBeY8Kcxu2HwG3BfmoUQduxKz/N8E0boRzSA1ihILbjeKI1foVel68GttFOYL34k+qkySCgvWbxtMShZ1aO1VJuGYdGkTiqEUXN0NpBzydNcwLDFdNacdb0OCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmvhvKYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
	b=HmvhvKYwH7v1n5UEjU6Ef+frrk3JX+0By9YaiY0NMuCGkboUj5kQyAVEAucttVAJv5ovmr
	NxNjPK8ZVwrLgQcwGiW99scUGmFtrRMOJoOMy+zI+b6dmSqdNhBWryyx9acyZJstkVohZ5
	4u/LTSyDbfC6RHt9xqRsowqOfbx9qHc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2O0x4QyyPw6MbQ1AjD1bIw-1; Thu, 17 Oct 2024 12:09:37 -0400
X-MC-Unique: 2O0x4QyyPw6MbQ1AjD1bIw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d32dc6574so390960e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181377; x=1729786177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61B9Jq2TL9i1+pERa497eTJdtZBmCcAzgGgAjZWiZfs=;
        b=J/cDRrE8SR4IwVIfrWZzlFz7GKMfRt9szVuWEvsVmsPVlTWC47wGK9FOQiEWzRvlNH
         A3H3e/4xx+6snEseDt5xg9Wa8AUINjJkwyFxk1w7Xrglm/7lWE35ya1K6qOfLaP3mjTQ
         9OmucNsrQ8qlu2YXziVAkrdkR2gOBzyUDK1zgz/gxnXN0aZVV4EqffBcRDqt4GLaNALb
         I0A5R+mIf4ntyatIJ3rKYmPLW6wRymJRQ8jg2AgJT9af3WifWDt2p7CSaGfYLFqqAwyG
         C22wepnw8gniY0RzGLaTt29m+OIdjgYLb40SOFmrnLnChKUyRBwUFMydRlqwQ/X/jeOi
         dkUw==
X-Gm-Message-State: AOJu0YyqkdTP+t1sKbxQ0qKTQVzCRPASFE+83qJ5n8kteHnLnZ6wz/1m
	jYbga+fCn1MgwUPOH6vHUi7UOVvV2pGjx+x0+LLPsV75JW/YkMgSqG8cv+5EwcUDWwYvAZDvvlH
	zoTklTZVtKQDvZgRLYhjYUs5nSFMTHwud4SWgdg51itf0/gNjuV1BEZpWsmqRMg==
X-Received: by 2002:a05:6122:1da5:b0:50c:55f4:b529 with SMTP id 71dfb90a1353d-50d3771f4abmr12999438e0c.8.1729181377111;
        Thu, 17 Oct 2024 09:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1E9vjWvTrSbjce44G1hNH9Te68qdHoX7qBSf5wcmDSozZzJlRu1XPR/BhkCpwGTTwrN+WLw==
X-Received: by 2002:a05:6122:1da5:b0:50c:55f4:b529 with SMTP id 71dfb90a1353d-50d3771f4abmr12999408e0c.8.1729181376768;
        Thu, 17 Oct 2024 09:09:36 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a5a67sm881914e0c.42.2024.10.17.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:09:35 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH 3/3] power: reset: nvmem-reboot-mode: fix write for small cells
Date: Thu, 17 Oct 2024 12:09:04 -0400
Message-ID: <20241017160904.2803663-3-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017160904.2803663-1-jberring@redhat.com>
References: <20241017160904.2803663-1-jberring@redhat.com>
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


