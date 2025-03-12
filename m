Return-Path: <linux-kernel+bounces-557524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835ACA5DA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0B1897722
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1423E251;
	Wed, 12 Mar 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdhyS6by"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142923BD09
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774832; cv=none; b=rJDeQGdYmWvxYtxDaKl+afhFYc4WohElWmxB6Vlg1b7PcmzqRAGdibdaGfu2s9Kv8/nTLqv16dh/W7GoP+IE26ZPcZPnPSSlUmOYeSsl1sCYT0CS5kHG7QdvLkzfPNyr64RbDtk6fmOfBHPU7fKc9wXJS3Aw18O4ZCh8GzZ4PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774832; c=relaxed/simple;
	bh=kVD1cBOvbcjfuLGnWQGwAsJLPrywxdLU+w4aBmi2vMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCWf2HddfxtBhpuN5anhJGptRK7XlDfgWozseiNVJgM+jL9IQ/3q5Vr+3uwK2e5R+/InaRq95KXF4Lhfx0cC/og6pfCkaK1syVSng5F+uIqUOzWW/QxtOxF1mtwKgONZekw6HDDg6WxEboKMzpXV1D+NeOpTJZ9xoHoEE6MP0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdhyS6by; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741774829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h0Yr5Vgm7RUBCb/M+U5Z8BVsZiNBVB+EPPiJ4rqIWDA=;
	b=fdhyS6by15tZnEiIss0zjnherR7EKzyJ8RO2EVOGvlAREz1j/6L9iNPkC96siIqld2+bme
	nodkwvdTPz6c1mSQcxRCOvf3G1ectoEQ2um01P2ktTAb3sO//Kvh1RGYkNVZxsgcWgozB4
	YkWrPZKjBICaKBiBZ23CqUwH9iVmb5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-FczwfzDINxuzBIONHPW92Q-1; Wed, 12 Mar 2025 06:20:28 -0400
X-MC-Unique: FczwfzDINxuzBIONHPW92Q-1
X-Mimecast-MFC-AGG-ID: FczwfzDINxuzBIONHPW92Q_1741774827
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d9848a7so362226f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774827; x=1742379627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0Yr5Vgm7RUBCb/M+U5Z8BVsZiNBVB+EPPiJ4rqIWDA=;
        b=aM4hAo3IVOgTJjDY/z8uYAelRMZJ4fFb/QBPQDhoOSoXCDXVePU+MmFKzPV5vgeOwb
         1dE0laMjFRW/kCfekPTzXCLQEDU68dZozhX/Ex8QCyBt0dkXln7UaDfu4SODxGigtqAI
         h/b+du1u+FwLRX1sMT+EK0W86LOGxbIenDcBy6rbPM/m/C+ihawRKKjuVfcSyGlZue3y
         he2gL91Cwxoebytq9dx5YIElu/WBTvRRZiV7vs7pM0ncITvCpe3x9D32dtV9uiTF78nb
         ZI8uIqLZRPTkEJ2JDBlNrW6luygfsK9uH8hVWRbhzZCPHalm3SnK9G/50jIpqR/zKeUw
         t3jg==
X-Forwarded-Encrypted: i=1; AJvYcCUV6qA2EfgzLpqY2KKDmfwLNjJuTPR8ZtJBUvZ7uSGgKo0EcNoApd7JRSAhlSzqioFvY7xzCAuccArJmD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CsnkevykzAESxx9n8IH542anQEiRuC1iefQHAUrw64YfTXBk
	jr42Ig5Lq7UVM65ufd6m0wqpztT2fkZb+TK0xMq+9Y9B2TeaJVd6bkq4GIcLMk2hwDZhxXkz1lT
	TnVI6Bhtd0Lr6oVBJiRrwMhmI4WGAFtYM/VmglbJZv8qMuXu4zLOtu5pLJdYHGw==
X-Gm-Gg: ASbGnct4mNC0dGpvbzDFf9IFpA1gbjcWQZy6oPz4fvCA9AQn3kGp1d84lqmI20FcQb7
	yRNge1DUaw+qD+Ldu2kpS94ZL8HqrXNC2+q9VjZAACV/ICzCDBsqabLp+7W/0pKVzb/XE53mrmY
	TGctKy0GqFgSzYnJJ3igyNCrwQ3HRuhqh8PoSiO6SLxkKVBzIqd+nwSFcukc13QUkGnXqCAHy50
	TmOkjUDZX/IxhYzCAP7Re2f+o6OgyHQQJCTGFdFVLoXuF/0/kNdSZGOrAZ2ZpRZ1MuWY5K5qFHA
	F+rPSoJkg9CYIrpBZ8FwK16NON7i+14yCq4yvfr09MWRnoI2U7URF0vgqk6fd6M=
X-Received: by 2002:a5d:6c65:0:b0:391:98b:e5b3 with SMTP id ffacd0b85a97d-3926cb6442fmr6821004f8f.14.1741774827291;
        Wed, 12 Mar 2025 03:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy2Q1sDAMgAbiGTwr0193U6ouUjNnUZZOSZ5Aaw1xNFil+VycgOfWKIaXwNWW/V12c4oR4JQ==
X-Received: by 2002:a5d:6c65:0:b0:391:98b:e5b3 with SMTP id ffacd0b85a97d-3926cb6442fmr6820992f8f.14.1741774826959;
        Wed, 12 Mar 2025 03:20:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2eecsm20457196f8f.79.2025.03.12.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:20:26 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH RESEND] MAINTAINERS: adjust file entry in QORIQ DPAA2 FSL-MC BUS DRIVER
Date: Wed, 12 Mar 2025 11:20:18 +0100
Message-ID: <20250312102018.215018-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 78fa0d19a50a ("dt-bindings: misc: fsl,qoriq-mc: convert to yaml
format") converts fsl,qoriq-mc.txt to yaml format, but misses to adjust the
file entry in QORIQ DPAA2 FSL-MC BUS DRIVER.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry in QORIQ DPAA2 FSL-MC BUS DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
Original patch was sent 8 months ago:
https://lore.kernel.org/lkml/20240708075124.73522-1-lukas.bulwahn@redhat.com/

Patch was not applied yet. No modifications in this RESEND patch other than
rebasing it to the current linux-next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67bfd9109535..e6609b78998d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19578,7 +19578,7 @@ M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
-- 
2.48.1


