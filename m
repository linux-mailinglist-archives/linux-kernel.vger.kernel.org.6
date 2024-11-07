Return-Path: <linux-kernel+bounces-399787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F019C0437
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829E1B23ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF420EA33;
	Thu,  7 Nov 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCzSWyTl"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626820ADF9;
	Thu,  7 Nov 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979347; cv=none; b=dh5lbbZ4edRen9v/t2q/i+qtBmR60HrNvSGkB9fUncEM1O/gt29KnaffANg22r4gpAfRsNXsp+nFBMEQ5dOG3ZIkJPXh7Ne2S1rbSx5e9UGLpZZHxQbQ6zxpqzOAZ88OnA0xkRODhlkOlm8fxsvEbBSuqnbeQf/7XhBpXW1cH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979347; c=relaxed/simple;
	bh=Ij+tzPSSPvTDBQ9Gr6H2PmIeNLG22aGkm0mInih5Zck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lPAeD72TG79nHIvgMX0urjFUi3sjCraiepVP5M9nrn8y6bfedSCZx7BpMcDz1WWMp6yohwhZYvHiv3i+ozjPdFKNjmsW4VxapNXnGn4R3AkVmmsUC6jTQe/vsSKZ/E+mwGpHf0efp4LT9jabqcu5t5jJRVkhPkBCBX35WgebaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCzSWyTl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so7334175e9.3;
        Thu, 07 Nov 2024 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730979344; x=1731584144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaBkOv781JMYQ+4+nvNZuXl65rn+9aoP5vlDFGjYlcg=;
        b=WCzSWyTlucTnhJvVENisKnDApH9qr50nDWwKZDCUpuKzqnLAqquI3U8aY/sZan71OU
         hkSEpMx/W3xQG1Wptrc1HF72+21iVk0V3+kHN7GpYTr2NUx3zoWaOm59Ck2FDHVMnmk6
         JG4C5MEITyxH5jCYADTEThI8F/2sS3Vq1RE4H9VdHC5QuM4NYnQtbIXoafeFseae/x4u
         9kx8XfbudqJggwkppTKoW2F3J5omS15B0/OAxJRa482ByCnw4BkkvILNg+yhhQhgxVUT
         yzJAYgZUnkmMUfC7Pl6tLuAfI5j5AhFJNiLFvVrkpgPpQwBbWB90ikZOHLrBwdiY/bjL
         MIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979344; x=1731584144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaBkOv781JMYQ+4+nvNZuXl65rn+9aoP5vlDFGjYlcg=;
        b=TkHaVQV0Bozwb/V/1+jyl9pfKFbyNgg5Kq+bEp+1bZOtm6lhMbx5QQ6Ri/PonoohWn
         fbbFV08nrWZFPE3pczUNtESMu1cL7dlDMqJCnkPwAp3flzl+AJS0TKUHB4XtjpMMFx+u
         +pSFUDvLX+ComC9UEDHc1bjZL5Ws/vt+wiBNyrCkrjBvUvztavoicqSVhEVXGy4bUeSB
         zyPQhUruWzGU0SG4vQjaodCYi9ILXNqUxN6qM/vTE2sK3jhbwR7bwur220BUq1PF4Ud+
         ojKjHtgDknKzoGL/mIvm0pdREUXssHmVxxQS19g8LYb/AcWiYyNgJ+15Cs+GcEjcX1EH
         h0BA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMl9j7CiUEHz8KobQiT1uaAoR/v38DLjdtdatFsqaEhUsJGWxWs8TaG4LIB5wQ5PKik63g0lGH4ug7mQ=@vger.kernel.org, AJvYcCW542rQKRXImmV0HpnJmWGmQeexF9AnJQYB2g1l5LcmXTFD/o/KmbcwpNEcJRBSXErMmo3D1QXDhr/vHpxqcE6ewO4MJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHK4hW4aDDx59Hyx4sOlSMVbI1ly2K059AsGML/00VT//FROEr
	1iskRSx1ebXsaAcSTPJOrEPWfPyhykBGYI/5rwCbkYBbl0p+H7rX
X-Google-Smtp-Source: AGHT+IEyM/7JxWuq9Z/OOvJe1MfE73+DdYcPVlV24qPT7Kr5Zl2BJ5O2OV5ENjYY2wp/Ki1vzRuvSQ==
X-Received: by 2002:a05:600c:1ca9:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-4328323f576mr198429105e9.2.1730979343772;
        Thu, 07 Nov 2024 03:35:43 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0561e88sm21203925e9.19.2024.11.07.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:35:43 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/x86: hp: hp-bioscfg: remove redundant if statement
Date: Thu,  7 Nov 2024 11:35:43 +0000
Message-Id: <20241107113543.17137-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The if statement performs the same action if the strcmp result is
true or false since there is identical code on both branches. The
if statement is redundant and can be replaced with just one call
to sysfs_remove_group.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 35936c05e45b..187b372123ed 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -531,14 +531,9 @@ void hp_exit_password_attributes(void)
 		struct kobject *attr_name_kobj =
 			bioscfg_drv.password_data[instance_id].attr_name_kobj;
 
-		if (attr_name_kobj) {
-			if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
-				sysfs_remove_group(attr_name_kobj,
-						   &password_attr_group);
-			else
-				sysfs_remove_group(attr_name_kobj,
-						   &password_attr_group);
-		}
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj,
+					   &password_attr_group);
 	}
 	bioscfg_drv.password_instances_count = 0;
 	kfree(bioscfg_drv.password_data);
-- 
2.39.5


