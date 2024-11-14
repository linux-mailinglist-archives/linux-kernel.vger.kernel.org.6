Return-Path: <linux-kernel+bounces-409630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058D9C8F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6643B38683
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DC18C028;
	Thu, 14 Nov 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h5B7kqKt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E9185B48
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601134; cv=none; b=qL5HC0Hhy1iz2Hu2cP95RNWVm6JxSiQJrit1Od1qrWuli3GrumbopXz1cmAlKNUaKdvegC3hRYM8PyhUhXHTc1R8aIFmGHUReAwhlmME4EzImt40ORepXHojzhqRfrhHpSyNfCIa5E0IqSWKhqWFvrR+gjT8O+jWvx189KjSRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601134; c=relaxed/simple;
	bh=NzQJBoC/AMGjdcz5fUxYJHaJ2T5WgutxrlJ2H2gtLTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPCPvBvIN0G0afEH1qNCQV1jfmPHlNBzKaKlJKrYHnD6qXgOtDg+ljwi5FhCXpOLH4LcqIyEtstAehIb/nhtIUdkPVGe4BPhmLtWS9y31sfs9y3ihtqQ6kCv1Xx7f9aChqZHYvaKKk9kE+/xkOAaWvQYw/vuakQLXB/Qnit5qUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h5B7kqKt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f1292a9bso877128e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601131; x=1732205931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgkdpOYsLIOn0iKAKl5fgt6eXL8Mzl+XIucJ8fWc9TA=;
        b=h5B7kqKtNlz0keBSJ6L9z3uNVroLZMvCO7rHbNBSELLix0MPQeWidHSSHgtozh1Qxw
         rQPbbka2ZCerR68GE6loC6UUBnuJgjWC2dipbRo1u+d/+IbwTKwgPmK0C5patPP99VO7
         Jrx2i/dCcEN1+Lx9ZJyT+zXgmHNCmGIkdvqLS5U6PvnrW6/IVPYrPNhPMzSjMsaV1jHB
         lpfIsgIl/7trYNUNxGhyFshmWivhzB7PQl7jvxvzp1JJPBrOd1VbOORPLl3Bi1X0ENjm
         EujcdBFGfqLe9w3q1AO508CZz3eVRaW7WMhf3RtuTPUodQMDt0Rk3kQ/DQ+DseJVBTN5
         RdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601131; x=1732205931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgkdpOYsLIOn0iKAKl5fgt6eXL8Mzl+XIucJ8fWc9TA=;
        b=gNPD6XXof362hMIKdnS6zYp7PRAxn0QCVpG3d1Q6PE1biMnHDv5lW+lspbvUbE9zlm
         7dxCTpZZvM40Rin3tD9cutLDSQoYnKjajQGUJj8T96MM7B+S3cgbrBP2Bzm5xALwbkrc
         MTM9z72bZkAi/0q4MR3jMiV4oyC2YxX00kH/SAiaqmukMM2nJSCPkaEPgC5lJZB5lPbq
         uekREv6KG+eTbwDLLUa/SsUUuBekbkNo5Dh9lBI6x6ELfBHyyCNfJn8u8O4RgR9a8GEL
         PCNLpGklnxuSgGT5VAdMo8qtWMbLHWOOc7/jSwayGI4SSlYMua4NxEHqhaMN09Om7t1R
         5NbA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJ/ZfIhVID7icCAqXIKlFYkiDFe5aUvMivwzLZUyvfNenG4cn1/LV/zxP3XgyLGBI8yMx6Sb/K4HtbFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzerytfxRbdmbkO5m33S+aqaw/1hlF7JW2eKyvl1qENrln+eBML
	BdyMfuAHgyHxFsQ9LGVZUjpkiuCmfhxNLu1vhwYTkBR/RpYe5XrB0lHv/29hrxQ=
X-Google-Smtp-Source: AGHT+IFd0CnkIMN5l0Pz4D+G0QBgRZi3KYTDXcb5xA9gQJqvW8wTertCqu9+xj4IWnW1G55hIkNGVw==
X-Received: by 2002:a05:6512:3ca5:b0:539:f607:1d2b with SMTP id 2adb3069b0e04-53d862b45e5mr14144215e87.7.1731601131046;
        Thu, 14 Nov 2024 08:18:51 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1f409sm24906005e9.37.2024.11.14.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:50 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 03/15] irqchip/riscv-imsic: Add support for DOMAIN_BUS_MSI_REMAP
Date: Thu, 14 Nov 2024 17:18:48 +0100
Message-ID: <20241114161845.502027-20-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike a child of an MSI NEXUS domain, a child of an MSI_REMAP domain
will not invoke init_dev_msi_info() with 'domain' equal to
'msi_parent_domain'. This is because the MSI_REMAP domain implements
init_dev_msi_info() with msi_parent_init_dev_msi_info(), which makes
'domain' point to the NEXUS (IMSIC) domain, while keeping
'msi_parent_domain' pointing to itself. The rest of the IMSIC
init_dev_msi_info() implementation works for MSI_REMAP domains,
though, so there's nothing to do to add support except accept the
token.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 5d7c30ad8855..6a7d7fefda6a 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -246,6 +246,8 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 	case DOMAIN_BUS_NEXUS:
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
+		fallthrough;
+	case DOMAIN_BUS_MSI_REMAP:
 #ifdef CONFIG_SMP
 		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
-- 
2.47.0


