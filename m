Return-Path: <linux-kernel+bounces-278510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEB94B11A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE201F21D63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE06364BC;
	Wed,  7 Aug 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2CFbXsE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C32B9C6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061827; cv=none; b=mcgWfP44TGKwimLPD7IIryw3WxPEamExBQrOCfjwd4hTy1Bmp/jJowSeWlzT6oYR1Fj4fRz4WOncalcZiZQFWEL7+1KpBx3wep/Z8kMXTm8Xhdj7PoINUhJtiT5y5WyBleClXZP8nHniJ6IU6qEUOwoYa8DXKbpii+W0oGgP1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061827; c=relaxed/simple;
	bh=AhWx8shq3C+/Tk1y7ByQxEH/soFPkbjxLYkA/RSUPF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LnoV2X678rhvJLwSqYUa4+ytjOS7ckt9nNu2VwCgJ+yVcPPPxuJKbdKgL+Nj/uedD/5KeVXygR1dziDUZfOxwdCCXnD6FkWrtM36ePZch85JbfqK9B0Se3AcsWAVss8tbRYCMtsCeHij4OKlJr2oNYBhPDMogXNUKJ/GLGgriqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2CFbXsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723061824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qb6Er//3S7bY+J6msulYpUtmZmfaC4wRqo4XSmAFS6w=;
	b=F2CFbXsEA/lHWRM0HJtaHta/+lpSV7oAvGXyZumMzGPT5aZieJNSusoqcniWMjD9mCmRUz
	hCkqWwBXTxjDKBI/YRsxHzip4JPYiviFpPLS8bf346oVrafpD6PlKy8wPT4k7rcDRR8ZdL
	KTO9VlTJsWdyMy2LH0IDLMEmm3zo9kM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-3kBGO409NZaIcCCrr1GS3g-1; Wed, 07 Aug 2024 16:16:59 -0400
X-MC-Unique: 3kBGO409NZaIcCCrr1GS3g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b79810e326so3999836d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061818; x=1723666618;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qb6Er//3S7bY+J6msulYpUtmZmfaC4wRqo4XSmAFS6w=;
        b=BFKpmNnZSVNuA1dWGdxero9ZzL/k2D/gHNHl96IX7eT8LDv1ffAICJS7tHwyjbTpfk
         L24fRiwj7pGHxvDto3FPeSS6X0ms8Wq3DbfZ9OxfWVcKfxANodHTL808sA0Q5iSvmCLi
         s3zOK37MqtDLYJuNxagm+8ISvEVpW+K7iAY88TOXVpktp3w5cQkDICZPgd646zJz2NHt
         GABavBP2NXDia9SW3PJKjbFo0NW/tRZHzjQKLKjU+sRPgEIQdftq7kXUMnSlD6GLT9z6
         qatgyBK+gM8chd8RfeV7F7CfpBixzyTnB5eWMtCq/UFBk9h8T86RmdmEKVxcLxR03Oyf
         cnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4zP35qpDeH8cb8vEZmCHuURQNk8qd8kIQc6+DcQt3oFa6x91ZhmsFvOAxjF/JgwJcUS8eKzVUpagkUf1oK50wMdg+7kao89fCCcqA
X-Gm-Message-State: AOJu0YzajWOjyUqE33WmjY0I+1LpL1xdRxOZPk3o2ZdRy7gIs2rZ8cmc
	3OtY1wVwNV7iPgsvGTA0uDkmiEe+2nfJsAMJEH8TT2StQ8FnT4YYeBEUTU7WzuAGxp3wGaSJgHq
	0AGSLH2b/ESpz2phsrcZKtaLEzr/wF6vWSwDQdYjgvWNTwMH2WZUtLn9F+Myy2ciS3EMlKw==
X-Received: by 2002:a0c:fc4e:0:b0:6bb:9b66:f264 with SMTP id 6a1803df08f44-6bb9b66f77bmr179209776d6.0.1723061818399;
        Wed, 07 Aug 2024 13:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qdsBCVnuYwTfKiz+pscv+njcbxQmxKDFNFyCtNYolxMcMZBDKsklZZjZhhaGV6vsc+u7ig==
X-Received: by 2002:a0c:fc4e:0:b0:6bb:9b66:f264 with SMTP id 6a1803df08f44-6bb9b66f77bmr179209576d6.0.1723061818110;
        Wed, 07 Aug 2024 13:16:58 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ad54sm59950786d6.31.2024.08.07.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:16:57 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 07 Aug 2024 15:15:49 -0500
Subject: [PATCH] arm64: defconfig: Enable PCI_J721E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-pci-j721e-defconfig-v1-1-b97e5f4564f6@redhat.com>
X-B4-Tracking: v=1; b=H4sIAPTVs2YC/x3MPQqAMAxA4atIZgO1/lS9ijjYNtE4VGlBBPHuF
 sdveO+BRFEowVg8EOmSJEfIqMoC3LaElVB8NmilG9Urg6cT3I2uCD2xOwLLisay9UNrOx5qyOU
 ZieX+r9P8vh+NVnInZQAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, srk@ti.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.0

Enable PCI_J721E for usage in both host and endpoint modes.
This is used by boards such as Texas Instrument's SK-AM69 and
J784S4XEVM.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 01dd286ba7ef0..e5222dbedd387 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -225,6 +225,8 @@ CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
+CONFIG_PCI_J721E_HOST=y
+CONFIG_PCI_J721E_EP=y
 CONFIG_PCI_IMX6_HOST=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y

---
base-commit: eec5d86d5bac6b3e972eb9c1898af3c08303c52d
change-id: 20240807-pci-j721e-defconfig-7bfbd95b6f93

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


