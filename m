Return-Path: <linux-kernel+bounces-298836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83295CC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8B51C212A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571518455E;
	Fri, 23 Aug 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AlP+oVmv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="szyg5AMw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BD18455C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414838; cv=none; b=nE3W+9azHnDU3NTMQcJdOHzAQTn/v3SyZWBDMMFw8VHgiUF/dAWKePtF/ByLZdNn/OrfRvbl9dSKxRQhGtQACeof+7bcEDvegG5IuN2U33QngRUlnsQcmeRMrHIbJgGnmWbXcupeqfyG+WGH9PPJQurmQZ1XX4iryjGGfDVLYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414838; c=relaxed/simple;
	bh=uSVrhrv6Dc7wuCwjo33hnUT0DxnS5caUjWj4Ol+DrLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ji3BhjqcKEMwcz4FUPKqssgHocSe7TrXuP6pt/HjpE9TCOnQ6YSxTlZ0hA+HsCjziLNORYSVAFadr+Tj1TWyKXjcIoVXOv9ry2n+4sKZsMhUkEKphs5WlQPDZr0CU3eATYfvk0UyBNOVuTPQKOin6YR1i3A+Gs/ep3PZW41lh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AlP+oVmv; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=szyg5AMw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724414834; x=1755950834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ihSUvSsm7Y8t7CNtMvS4+H5qmgcvWj9X9pKNtLPIO64=;
  b=AlP+oVmvUnovPPNrxkxLFbgcoj2yd88xdMf9bcnl4+u4sV2u0dVzDWjD
   FBhbFkGMS2fFrhzhEuCtew6pe6wZ5jUb4GDu7A8tBTy8/awvTucF6MPk2
   mNYMVE8IRvFQLFqXZymgk0M1uMrj0bg06ryL2US6BUOHAYJKLKxN8Y7EZ
   VcAUGvQSYni250SnmJ9ReKE8Rz8tQp0kmjDwxq5BQA5f2rUSj4HS8IVA2
   7HiGx6dfXnthclre6CT1KKNJh6ZJfTSHYPRACBUIuOVVOaqkCjutbT8eM
   WGZo1FL53if83UHTH2a6yqxRIIP97BtnHQWifOvRPSdHXB0uY2Lt/wauc
   Q==;
X-CSE-ConnectionGUID: EF7zU0P+TaW+BrQ25TKWGw==
X-CSE-MsgGUID: 5v9bj1SUTlGwigFBwcZaQQ==
X-IronPort-AV: E=Sophos;i="6.10,170,1719871200"; 
   d="scan'208";a="38559731"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Aug 2024 14:07:11 +0200
X-CheckPoint: {66C87B6F-B-AFDE3C8E-D8665302}
X-MAIL-CPID: E6B497D7F3DD345CB49F5550C7320772_4
X-Control-Analysis: str=0001.0A782F1C.66C87B6F.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 046631691A1;
	Fri, 23 Aug 2024 14:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724414827; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ihSUvSsm7Y8t7CNtMvS4+H5qmgcvWj9X9pKNtLPIO64=;
	b=szyg5AMwLtb9vU57/T85+WWVqh4khxM/CqtW/EAImnw54yzWSrFAerHz/gjUUszZPcCOAo
	n6bIuQuuEWKoSOZB/TeMMLPT5/KPze5/AqrwURuYgoyC+amG/av+rbK4/AaBvrzSbGvVgN
	gwHwJ+MF5XEikF1QhKbFhhsAuH/IlND/iXz/BwFLj3U1A0eWkmeC2m5fIWNoBsfa2EHU3K
	PjUzGvUo1JkWfs9HudNQ+q+3MNMt6cZAc1tT6Tn44tREuJuz8I0qzcIB8bLHgIRQoXDLdI
	UWi9L5jomlPZS66/wIf/LJkgHymqZNQh3qd5yJ/lvHYkcaY7RjtznEaPcCo5iQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: 
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH Resend v2 1/1] MAINTAINERS: Fix 32-bit i.MX platform paths
Date: Fri, 23 Aug 2024 14:07:04 +0200
Message-Id: <20240823120705.3672820-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The original patch was created way before the .dts movement on arch/arm.
But it was patch merged after the .dts reorganization. Fix the arch/arm
paths accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Another try to get these entries fixed.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 899ec8cb221bb..89ebaaeda0ea0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23373,9 +23373,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
+F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
 F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
-- 
2.34.1


