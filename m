Return-Path: <linux-kernel+bounces-409631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD249C8F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA87B28B081
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A318C93B;
	Thu, 14 Nov 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oHbOPHBU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF618A92A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601136; cv=none; b=Rimbu6Kshd9Y5lfutidn69v+c936jg5FC3x9Z/vInpuuYVb5ydvp3b+IQkUJShvscpYnZo/A3bLgTK7rR/SUCLzBn97I0RtjKsvNe9rkt9kIZBv/6WsARvwY7JMUpL0K4y5mP4A+oOPwsZFvZdXWzvox7HFnbRgfQPAnKspkEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601136; c=relaxed/simple;
	bh=0mPWdQkW2KKBDaAhQDqapvf02Htw+fq40OqWkKngxqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsJNGTvVXyufk4bJbcBZVM+E7UbLMArkJSC/StRDTCG/kR/GKAoa2tCHqDmAOTeoaiDDNc/KbKoX+4OT0et6K/ELysBWFgMP9LH/10jBy20nCuK13Zm4dhrzr5IcXVgxbcLrd9FrUHWvber7koFBZI1FsJ4soHtpiGDvutPD2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oHbOPHBU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431695fa98bso6928265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601132; x=1732205932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3RScEb/zQMeNBIY0PtZD1/ZjJQ2IegD9nNkwkqM6gc=;
        b=oHbOPHBUelHfY0VEbF0nTmwmxbT5sLJwpWWYtzvmb48Fx+muiDlYOrzYqK+2RW7F5c
         gCRJK3btEmsj1XrAz7nO9vE+d1I+Taeglw3B3cErFh7V6pMpzrF0QwMgJ92XZmUtIEcQ
         Yue6uT096Iyc58nVKpJ+Jpoe22VG1VokY0zMrcNia0AcLC8hv0CNOEwmgp+nBt+ZrMC9
         z1msiUAqTSxt62HmbtiQ3rVAtDIBtAr2dJYL0tUUoaDGLKRcwHovCSZ9WagjA7zAR3bS
         61pPNa8NoyHD3IyJYH1h/gmUUpGuJHaLOjxED+467qRemMjtl8cCjCnOSuRFqOPQu27K
         hfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601132; x=1732205932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3RScEb/zQMeNBIY0PtZD1/ZjJQ2IegD9nNkwkqM6gc=;
        b=D8+ZWXUQcHaoF1M0zlMTNIT7V4AG/Z5W1O/hpacxsLE3QWLeW6aqRgZMb36lq4SM9A
         1TuaQj24L5Pfnu6zHyLmMjEUNtFO1ng/wnm8rdUHcPn4S2O0SCAeBclQAquuk8lkvG3q
         5oTBwVqKAX0306cJckoSNHm/nwm9ef8PTHFtv7U8B6Jn5cCQPchXW5tawyfCqxm90x//
         njOHVedHCFlrhV0ChslhQgkkJsSiaceO/KIaETkZpaOnZAgcL7gWa8MfzrcPsz6Ydnv+
         8nVjiWNf8USxVlWJliq1WgV6bgOUiMYey9rcVteNDcBCS7AfxeyIQddlsJk9QPsB0NEH
         2hdA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJte4vepWRoBeTQ4ZJRGjCyxZlI4Y0eBNr+LXL/NqBHjbfWUd92CoVMy4tHunpf6nF/azW/g6CJ4gsyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxik+AlItxlNtn6zJogfDklXYMYeCsgOWSoggmxo1WJeJLuqxEY
	7NI6Fy6VnljRAO8LwcA2cBzEMVJppyold9ejiOVtWYTQjPm659qEUPjEh0qtXe4=
X-Google-Smtp-Source: AGHT+IETarykQuvm6+z3/CASGfAXpcrdoszeWN3rsEIL+bc92gQplNjgpnYXoIwCDFze+tOTvORF1Q==
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-432b751e28fmr192523985e9.32.1731601132365;
        Thu, 14 Nov 2024 08:18:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab72184sm24967935e9.2.2024.11.14.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:51 -0800 (PST)
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
Subject: [RFC PATCH 04/15] iommu/riscv: report iommu capabilities
Date: Thu, 14 Nov 2024 17:18:49 +0100
Message-ID: <20241114161845.502027-21-ajones@ventanamicro.com>
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capabilities required by VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8a05def774bd..3fe4ceba8dd3 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1462,6 +1462,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1526,6 +1537,7 @@ static void riscv_iommu_release_device(struct device *dev)
 static const struct iommu_ops riscv_iommu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.47.0


