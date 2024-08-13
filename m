Return-Path: <linux-kernel+bounces-284201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122994FE69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3491A1C22B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1746556;
	Tue, 13 Aug 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PaHIMTED";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NhAkBirW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A4433DF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532997; cv=none; b=bLeCwPImu3JuDZcRNt545bnyWbRKp2cvNyLolvUZzGkTRFAMnGElXJbY+1tq+hqkxnDzGqhgW/WsyGALP3BmrJbxPXHKgW0jcCVCzd+2+Nocetmp45phH/4IuNe1xcDVIm+801NyaOVmih90/d8Ogaf3lYLDijXyIYkbwGQEeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532997; c=relaxed/simple;
	bh=CMy1xdSwN2/pKCFDQFQ5CNmNUXRuP2zIGYH9JsU1NHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAqC/ymy+2WsGtwAIKkQgKYhQ9GGJSTsL/9+QTDaGp5lcxD8Z/EoBCAu7cX1duPGRZao4RWu+xj8zGlnXlS7RLEGmw5Cq+Y31C57ox4+88F5fRniDytgf+uZIIX28PaP3Hz2yHP9rvkLd5RxAS5vCdciTkaFpXxlunTQbjQoiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PaHIMTED; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NhAkBirW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723532993; x=1755068993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VhcpyWczvZB1wJjf8doudHVlvN24X9NY+NSgrlVBitc=;
  b=PaHIMTEDAN1qaiWB9i+CkV5pa/UZZCqYZz6QUr23Z4tgyzec/7m+BXd5
   uiC/mhZieIckXH4MlhcIF7OsO5Ly9KsQuxLJuWcxwzqinyV2IUi/fzoZb
   dVGnQzJvSeHoDRCeNgXIJHC2/ePtNez5z+HgKYhgdKzptYAQf3FWaLOLs
   IuAY4olgFlvAqSMORUZjti5sWhIW7LfwrdHA0KmXxkrB6IHiuWF76wnGO
   r/1HDM0S4RM0XMYtz0IpLMdQZSczEC3oY2Ccd2HdzSMNSagSog+UwOyKS
   zPFl9eh6U5KOT0SRlkkNsXpp3o693Jw9BHlMliwdXCRxjD5r754Ym964y
   Q==;
X-CSE-ConnectionGUID: 2/JWzMLnSuCfB5NTmHLamg==
X-CSE-MsgGUID: Z1Ju+x7FTYaTGJoCCvr9Sw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375589"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:09:50 +0200
X-CheckPoint: {66BB06BE-1F-45EF2B36-F6E28480}
X-MAIL-CPID: 3E806CCE17FDBDD5AEF5D4B16866EACE_0
X-Control-Analysis: str=0001.0A782F15.66BB06BE.010F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A2D1164737;
	Tue, 13 Aug 2024 09:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723532986; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VhcpyWczvZB1wJjf8doudHVlvN24X9NY+NSgrlVBitc=;
	b=NhAkBirWBpof8LA5uEfPqvrSOpzHYDCHL/kXUWbCYcLyjdyT0luDcxEhLC4mHA/BL0k5RT
	6u9Zu+Pu8OzQvd3SW/HUlIw02ZYsgCuksAbqrVcVtWbbtfvLVzGHDM+nRY16RthwJGmuQZ
	Ip6sm8giR5lhA25l/Xjh+xBC0+DudzVZ8LlzPUwjKd/qS38/1orMZziLz3Uo+ITXpPUdt0
	o2A2YAf1tOUHrHaBl8jowRTxOJq+/3B44PDNEYgKi4SLsmyVHzbJKAG6GaJu4DkZDE9RZV
	7XbZcQkGdu0XyGtPwYLZTggcB1y5YxO8edXgeOaK7yuzwAljL7lcWEHJdLZCXw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: 
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: correct spelling of TQ-Systems
Date: Tue, 13 Aug 2024 09:09:36 +0200
Message-Id: <20240813070936.71758-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQ-Systems is written with a hyphen. The incorrect spelling with spaces
is therefore corrected.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c06fe1176e83..6b5e44bee012 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23253,7 +23253,7 @@ S:	Maintained
 F:	Documentation/hwmon/tps546d24.rst
 F:	drivers/hwmon/pmbus/tps546d24.c
 
-TQ SYSTEMS BOARD & DRIVER SUPPORT
+TQ-SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-- 
2.33.0


