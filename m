Return-Path: <linux-kernel+bounces-309983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843D9672AE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F198282D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D5183CC4;
	Sat, 31 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Nw3kvbL7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1A183CA9
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121506; cv=none; b=JxhUSuZafJjlDWI0TzeGcXmzpnlxJEV3E6V5shgwX0CLyE5dFmfSA/1RUiTUKLw1oI+AL9Ht3q/zGjnUZPv/HIDo1cGV2bKuMKlf/cm9eB8KnuITfRL9HNA55Rq46J01IeGXknCQVNQvp33ot6AsZsLrxeDu6xgTg7Htc+IwdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121506; c=relaxed/simple;
	bh=T2hdbWslzZECBvwxalAGlA16tSAIvDkTpo+V5/WXQh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwW92uesKwGEagbDbWAFzD9lCxzZr0msTN+Uq0Tz5aFIh0vWbkRHOA/tcTTf+5hYgt3XsOxFH6Gt70fN2jKXz2lEcALdrHWttKDou4v56usnjWfp7c9bKUs5hiIo+YJXz64MJqlx781Ow5H71JlrrxYScKFVsDo1/wcN4DHT/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Nw3kvbL7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2033:3865:19c8:9110:3e7:4518])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 871517FE;
	Sat, 31 Aug 2024 18:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725121434;
	bh=T2hdbWslzZECBvwxalAGlA16tSAIvDkTpo+V5/WXQh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nw3kvbL7xbcqajA8RE/VP/+tVZVlYJKVkGORFX5YWCWw0C+px5LXYozH5TDJARUNR
	 EyQs+1ohTXIK3uyBPhG/qx9UlbEInHy9c9LLt+xZfQZuFuOlk6Bv9T+eiJ2M1pegal
	 ouBt9w/CU4/DVzck+dsOpGOg2rJNg8NEJSFEx3qI=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 7/7] staging: vchiq_core: Pass enumerated flag instead of int
Date: Sat, 31 Aug 2024 21:54:35 +0530
Message-ID: <20240831162435.191084-8-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240831162435.191084-1-umang.jain@ideasonboard.com>
References: <20240831162435.191084-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass proper enumerated flag which exists, instead of an integer while
calling queue_message(). It helps with readability of the code.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 4459b35b1a87..e2e7c1989ea7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3139,7 +3139,8 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPEN:
 		status = queue_message(service->state, service, data_id,
-				       copy_callback, context, size, 1);
+				       copy_callback, context, size,
+				       QMFLAGS_IS_BLOCKING);
 		break;
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		status = queue_message_sync(service->state, service, data_id,
-- 
2.45.2


