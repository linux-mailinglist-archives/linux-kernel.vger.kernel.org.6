Return-Path: <linux-kernel+bounces-363072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0999BD91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B0D1F227BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FD1BF24;
	Mon, 14 Oct 2024 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx/8aals"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019338DFC;
	Mon, 14 Oct 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871432; cv=none; b=EdGKSPGm54y+tI5u+Ob388O58Cblkj6OlXXLYv6hg3PpkPEd/gq4iuVI+oUZu6JkS0bwk3dUuJFf8bDg9HywHIEsG/9zm8mKUgo4VwK6Od7tWmFW2YO4pt6q+zMCofasdMWVGzPf3ww54tDzpcGsLerfyOYalNIGTz0lkBGaxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871432; c=relaxed/simple;
	bh=bNteSKnYreFvHyWufODflnRTqjCSRoKvVY4jgukdpbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZGZpbRyDwYV8pdLZbBC3K5Ep39LxyLn9cJ5jpxeyjR0c3+TLhsrcK5xel348lnLXJw/0bkVHvp50Y6jIO7qqp4jV+kXw5F3AANd2BhpxTbNEBDnBNtlb94lt0M59I+E1CgUW7pNmWpek5QZIsGK6DL5rVQlVCxN8rvx7GqjJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx/8aals; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cafd36ed0so873815ad.3;
        Sun, 13 Oct 2024 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728871430; x=1729476230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8XtIqCB450e+VMFf/Ma1ifuCcLIUz75aLQRgCsC9As=;
        b=Mx/8aalsWznQlFd5ShiEK7oOC5RBHEAo/CBxyHznPK48u8nKIpWRJ/6PDRuVi14gqQ
         kCvzt8m/CCiszdWvU5wLDqDI/clP/YzWNGlflV7sGvJmHaAe6V6V/4m1yMvsli8wwkZW
         6zSup8m6UBbWx+zklflVPGb4RVOz438eFzZE9oBcaf/PXmuU31sZFisk5PYaozFnMBPG
         x6qwo6CEOtCcbou/iurutxlDxekeMxVAx5woaE0BVL/aH1ZYpQZjy0v2WjKlAkq6TPiO
         WVXBSPtmkLCKHpB3D0hMN+K56hpRs2bvKm5Tbz+uEYwtD/y4Q3Y9EkSfk4b5xr9mZx/1
         kzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728871430; x=1729476230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8XtIqCB450e+VMFf/Ma1ifuCcLIUz75aLQRgCsC9As=;
        b=MtmpFbaRp4I48X6O5+oS9JGhuFRNt+hvSpJieWDpXPYYjGo0ovNC+vNWF3fAiuhfSu
         RJFWhNAzFDBKRfyc0I3OqY+s1lbEdma6wl6hmqTG5hmQfX71DV8TzPijvknFWmEZu+vY
         tN7yrann3B78kW1KB5PD9D+AmHUpMAANy0bofrLRbE4v0P4oM9ezTI3Gr22T1wPXBIJ0
         TYj0mzJ/L0gowZKUrWBh0/xKZ+50FSJYiT1xThGMKDxl2TwZf4I8QKr6qpu6aD1flV0J
         Ha2LU9QJfmUOnCwZeDfSBGIYlI/qjVOAD+NIa9Cc/+gNMkU5HjPer8rZn56Hxhy0hLdF
         PFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzzUX41B49TCNDAHQlgrBkCiIz+5lWr14KQR/exqwQNxkwAkDzo78DWVsZXxDThI1IdBxDGrNdXyeU2zEp@vger.kernel.org, AJvYcCXMH1uPr4NxRvLP00rG9TkDN1agYhJIpn6DPyzmCbY/swaqBcuGOJRWgTGORSQDNe+vqSxO4mSl42QQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HbjYydNd5cFFO0EhZghIU/Kq2z6MxwPd2rWHOpiZr9sqUjgR
	9pHz/ktVWWdt5UikU8U0ewKWraip5zWxFVa3Vwfmq1gKeUrxNldZ
X-Google-Smtp-Source: AGHT+IHKs+nDs/o7NtLyvmjRfk3RZ9OpnxvjxX2ffV/xeBEuv2cHhDtoH5EYcBK2N21UFloGOjqChg==
X-Received: by 2002:a17:902:f549:b0:20c:ee32:7595 with SMTP id d9443c01a7336-20cee32779emr10437525ad.2.1728871430035;
        Sun, 13 Oct 2024 19:03:50 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a59asm55794795ad.113.2024.10.13.19.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 19:03:49 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	yubing.zhang@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
Date: Mon, 14 Oct 2024 10:03:41 +0800
Message-Id: <20241014020342.15974-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add compatible for the USBDP phy in the Rockchip RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
index 1f1f8863b80d..b42f1272903d 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -13,6 +13,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3576-usbdp-phy
       - rockchip,rk3588-usbdp-phy
 
   reg:
-- 
2.34.1


