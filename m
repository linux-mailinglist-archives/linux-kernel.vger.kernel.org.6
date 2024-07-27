Return-Path: <linux-kernel+bounces-264218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604393E049
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775371C21138
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D0186E51;
	Sat, 27 Jul 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5YGB1U4"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538E1822F8;
	Sat, 27 Jul 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099974; cv=none; b=UVVkHZ6dRl+5FxYANODVrybzbBrsp1IxTrzYOuiVge/NaYyY87cAjdczjhNvL2nFweYHbbDFyk0dC6I3Pbq14Dtj90A6vyObmFpApjpP7kKbKQqSfDsQwkaQBgPxdwdnl1D8TtWwvLy8QusDLpMB0JIjmnOGd304QL9vGO/eGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099974; c=relaxed/simple;
	bh=uFOoqv7xiE+iGjULsWiAQxiExMlHovMWuDqtjmXBIWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8AzneXB59SXWzK5hrpkmNrDcbaMh+esNtKUX2QLTpFkr9u+n2SaFmg83SYr+U3m8dN2ETH+mJsPqHult79Us5Ry/1tpk947sW0nsfhDoIcUv49dlABPj+4M9+uIxi+5MYEn6ofvuKPgF4U2JssXeCE/Vi4Ooa3+XcsmDtI1+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5YGB1U4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa086b077so232585266b.0;
        Sat, 27 Jul 2024 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099972; x=1722704772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS0hYptGBwbcUtyiiOBrVnM45jPWgeZOxshVPFZaoz4=;
        b=c5YGB1U4V9CjI1o6XMGo7i0mySRV+Pm7sBnuB42x4K4LPjcnM539OIdoGQQ28GZUGZ
         HOt83s03ITf9VJzhYw583iXwJPrccQ/PWoRdC2/lrOgnKNR0rji/8cm72bOt6CgQM232
         B9/VY02S5ENOL+Gn7viS/bB2lus5nu4sG7Y0DQizOaSf3doqzCcSN/Ap29mWFlx8EdqC
         gdLGNsaHQhkRPe2u6asxqjRYN2BwPObR2AQSe0MG3OVukxrbXqA8G6w8ysCd9365CgY/
         T7j0lKZEpYCTcTYTiZKjKbm04M2KJW+B+9yr+inLiu8FY9/vzzm38qMuVqMB/ctNdgbf
         oGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099972; x=1722704772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS0hYptGBwbcUtyiiOBrVnM45jPWgeZOxshVPFZaoz4=;
        b=II8vloIgv6qFiAh8/omwLctawVQlVNngvix2+AuHlJDrKzKb5iszjUWhfQc1S+lobP
         Y/wUa+YLuxxf/c2eVDhvUlzgDTwfNjs0NnFZnbe6CE1YQvsZOIDDR3RcyPW4ld3fGvln
         d3iPob4nWYqh9I2kqL9TOESCrlegFeF+GC7sMfwQ8wuQ1XfNXdY/kdpMuZL1vA2b77jF
         QW5Bqv4stE7fVjy1ccLO/mmLojWsyujwqFQ9rZeisaPgbBdpZV//uY5r8kYi/kzSwpPi
         EU7v2ijX/mawfvr7l+M5wD8aY0Ln01Xb30kLGCFrlPU1RqOt0gSIjWMPVqLgAuxrpmTc
         lnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7/LdXbaIT5gRh+OauOODqG1P0CXBzWMgI+xyyj3Okfcl5wUNajOOmejuKopK1TQoDFeGKm+6F2Fd+q/VprKeDg4E2sVCl+44w523gAfV5dNQDkBxe0j1qcX/JDq8BY14CLN4mYTJo0Do=
X-Gm-Message-State: AOJu0Yxy9hAyGkbSBNSYpPCrmFWQYW4YS1Hx1jkDUApwYJNhz+oZ1rLZ
	e2MNvf2ktwm91u3uBBz9rcfu8TAQfkq8UozBZKPjriCeAoV43yGZ
X-Google-Smtp-Source: AGHT+IF+43agF2S0fhzPJ7+Px1bMsX0MK5/DDF3ySLEWhBO+DSVeIG8jr0/qu8ZqGZtiF6/9QwNAwg==
X-Received: by 2002:a17:906:c145:b0:a79:8149:967a with SMTP id a640c23a62f3a-a7d3ff9dba0mr223167666b.16.1722099971487;
        Sat, 27 Jul 2024 10:06:11 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acab4de90sm297522766b.62.2024.07.27.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:06:10 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: RobotRoss <true.robot.ross@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Sat, 27 Jul 2024 19:04:52 +0200
Message-ID: <20240727170604.9149-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727170604.9149-1-eugene.shalygin@gmail.com>
References: <20240727170604.9149-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: RobotRoss <true.robot.ross@gmail.com>

There is no hardware support, it seems the sensor was added by mistake [1].

[1] https://github.com/zeule/asus-ec-sensors/pull/58

Signed-off-by: RobotRoss <true.robot.ross@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 6bb8d7b1d219..ee396f21fac5 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -420,7 +420,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-- 
2.45.2


