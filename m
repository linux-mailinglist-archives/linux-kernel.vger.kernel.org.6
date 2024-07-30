Return-Path: <linux-kernel+bounces-266839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F835940856
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31587B23951
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F318F2EB;
	Tue, 30 Jul 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAdTbsJh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1815ECDB;
	Tue, 30 Jul 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320613; cv=none; b=mzQKq06OP25NbD8mklwnMSz0GpnR/oOrQzdyqBBrNiiVBI0vHVssuXdqQ1U7wahOWr+gbcT/bGEoaSdHQGjovJMb2TpfwWybw5aocrouVzyKxEE/0f7MNE9Bf3I6pyyMJHkLZFblBk7DROZC9M10RhkCVQi9mI9c2e+lfTMxElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320613; c=relaxed/simple;
	bh=vgWfXJV6oh+U/d5HLqk14418pfX+0DmbJnN8OA3G+po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1UHdvfmvrZiMywgB6dSlRpWltfon6nX3smtDIofSRGqKnD+kWcVXtLzm/w+R/1xdgAdqzk4m4+ToD4CKcLr1G9VdfQ4LRjp4YLkAIoi3QXfjDx+c44KwW0VvDlt+soQDVAvRgnBlmCCqcrYrXU7JphrnCQbbLJs4QIzIlI1S34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAdTbsJh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso915836a12.0;
        Mon, 29 Jul 2024 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722320611; x=1722925411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyZR/OhdzXMfOSBXz8hteOTckbpW6XJjdSMij7DYOMY=;
        b=nAdTbsJhZXcbLv+V+iyn80ohPoMvA5tQEJMjTUvj6EeCIgQszbY8MSrIbkIK2tJENt
         FhVQohuwhoDKkKmlQ6rDo64AiqRp9UpuZjpx3id1MsSoDxGukrUc/zXZFnpu0UuCRWS+
         9dwXtAS7nnNC3SXDDv8dyAviKYhviKAK2INcGAADUVDt3pVRGkrc42+rwsQP8QAksgjp
         BDg6Tp3Xyetr4s6plv/q3qto3aUKjQQrPSIBLH5wTPfxkspBvMdYva/fS7S+9eX5JrMw
         hX/ssNtlVUyYaR+ht8pWMasDcbvbREpOooMybnDu0iPbLr6KtKO/RBkTFo2usRpozcp3
         HCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722320611; x=1722925411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyZR/OhdzXMfOSBXz8hteOTckbpW6XJjdSMij7DYOMY=;
        b=NgoFbe6uWieKuqgfSbXN5f/GyK8qCXsrRO0feOYSKbZxN2+65Wswvol4gDKvF+R1+p
         gON3k9Yq8oMy8tBnfbs5fJlt1/lRajocGjsTNG9U6sn8K0e9atmpi3j/8kDH1l+Zd7qz
         OPs+SPuYwk95999PMzrO2TYcMDfAzVuXjTmAmPEcbOWBD6cT1ICXvJx4NQqTC1B9wRHQ
         KMzQzjS+/Hqulgv/saYTRdWEHMnfmACiLvDVNhAIS6VgwAmAPMDIFxNqZoySL3p9SWpB
         6fU2rtss0elTvlqKyJKg6f6svf/uNeorBeLBxBnIIVrui2xQbNCNJ8VG4jJ//xhePlFD
         T2gg==
X-Forwarded-Encrypted: i=1; AJvYcCVxyULtj6NTnTtw4DZgwEnT5SIKF63WGlCaZIrGjkARlIEIyxgf6spRuQgSRaEQ/FYtDnzoqeTYX6wxxKd/vD/FX2G0AyYH9friXrbdeieQvxr3azGxFwBZMzuWGJj9taLv8jU2Nxl/0us=
X-Gm-Message-State: AOJu0YwsfyVGYKXvDyaBzg6TbJoJzhnz2lLSd8hWHaJWYcn3FQqHMU0a
	qz7e8yvbQD2sFFcSZAtuQ428LRh1QF2Vq+CayqjCxXYTZdxEKBkX
X-Google-Smtp-Source: AGHT+IH3lhTXI6afBWK2HVh8LjHA55TAsRQ4XXdNCo0D/juqj8GpUtpQ7r7Nv+wm9WULyoz1DIvh6Q==
X-Received: by 2002:a50:d482:0:b0:5a0:d754:5ec5 with SMTP id 4fb4d7f45d1cf-5b021d21b76mr6260613a12.26.1722320610310;
        Mon, 29 Jul 2024 23:23:30 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d76sm6826134a12.24.2024.07.29.23.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:23:29 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Ross Brown <true.robot.ross@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Tue, 30 Jul 2024 08:21:42 +0200
Message-ID: <20240730062320.5188-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730062320.5188-1-eugene.shalygin@gmail.com>
References: <20240730062320.5188-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Brown <true.robot.ross@gmail.com>

X570-E GAMING does not have VRM temperature sensor.

Signed-off-by: Ross Brown <true.robot.ross@gmail.com>
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


