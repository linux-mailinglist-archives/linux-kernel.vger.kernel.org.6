Return-Path: <linux-kernel+bounces-350616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F1990786
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9125B2362E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233971C75F6;
	Fri,  4 Oct 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALorc0hf"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65C215F51;
	Fri,  4 Oct 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055741; cv=none; b=hp8tkXPh5Eq8BPmMzrK+6Sf0pDnaJYWvyUpub0zNXhe+YvKRAtP5PoC636SqFT2q9iwU17xslX3LqJ4Dc1OTeYXUQ8PPfpABrbtv2+3eDboSHtV+AzlGov8AU+lJ7fYnnB26x3Y1D4B4ZtjTF3lyk4nybSwRk/ni/TXZCuUl/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055741; c=relaxed/simple;
	bh=pzFRJaB73DQRvH4PYh2FvNZnVu1f9fD7/4jK54rgdhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StOqlUDqZEQ1a/AApp4B6eUbDE4H7l+PUrmP0q/gj5zIRIh8+Maj985kt7MJ1xT51Hy9OLBvH7K2smfn/WSFM9KdWxtZgtYqMBupWAMAAtPCyCaSVhVw/PdcAWleCMauNSFpei1EhSO4wuOSgxgTNP14ruFYWzVYvg/w8aN6xfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALorc0hf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0752be2d1so319982a91.1;
        Fri, 04 Oct 2024 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728055739; x=1728660539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elgWMJSRvxz/8LNwzIN4oEajOoCI8mSzevRrZe29m1c=;
        b=ALorc0hfpVBsSRzaf9URKtX3Mw+XFACaJrAOnbeYao4fRV39MxknWiAZUWj2IEd740
         g9vYK4Oqj3NkA2PGRTcsMH13l/Rb1xOnxFcsmUP3Ze+kICj3xgwhfWJW5EVRv49pTnGv
         ynXyT3JbKvDW8h51OUPoSQ9v5IYTmQ9b3DR6vGVId6GVyqPnm4X1Gx8ejk88QOrluMWG
         iSO98NaKD08R/4bCKtG3jDhICwg01icaHW5KL57emYC8S0DRvhd03E7/q7F4+9IG4zcM
         0A/KEqbckjXr55CgYQ366/bNE6dz3yn92tkW8cFlta7AOmb11WZnLCov3Ig6BSwRF+jf
         oYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728055739; x=1728660539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elgWMJSRvxz/8LNwzIN4oEajOoCI8mSzevRrZe29m1c=;
        b=ej4/hZ5+uDl70TF185C2qp421xiOYeg2e7SUhZ4zABjLAmg2b4lyjHlgDcvO01bpFb
         mtjnkFgANnhBrkMfogaM1p5hjCP6Vba3U3i12UhubdtERQMC5FcPKyIKp39iiMwg0tDR
         HB68UAFc91psRj1CuRGZXNoLFNO8TypYbJExfwBwrJY7lvjvvDDA82IhXsmpIKSn6ux/
         8vmp6bo03qBpPl52euVLNZPOrnpWnQymbW0tVDEU1EDgCnFmwVs9M2gztigNF/WqG9AD
         od8u9AefDlqHtDxhdKwWqimIfosvA6JiDFyRZZfswHcnHc5dNodWzeX9nw0mk0BNVevB
         D7sA==
X-Forwarded-Encrypted: i=1; AJvYcCWOmXzBbtASISi/u8uXiZ0vbiNVfbCQbmFHjUaQTosd3EDw/wN+6ntp/HiveH2R30PxMPEeaNr/P8RJmrrBOn1xSVEVFw==@vger.kernel.org, AJvYcCXphY06CoY/1Anl8aKkwusPClkA5Fh53u4HhBooIxEWqm0lO4sy5X2ffRPwPtdQRQZ4t2PnrYzefOFHtiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+Ul4M+E/GU1kwyYamhvmg0G79IvutIqUf40LFo6hjOgvHotD
	S6DUCYCiOTaQRdgzHSkBmi81wtrKK2DtsbsE3FRjYWGSdxVd2geA
X-Google-Smtp-Source: AGHT+IHtrHcvZ/PraWbgwRPW/foIPmkbsbfGKEhfCsqX0JSFOpGw5k3+5fj3zp3liYUP66yedZcl0w==
X-Received: by 2002:a17:90a:7e87:b0:2da:6fc9:1a52 with SMTP id 98e67ed59e1d1-2e1e5dd215fmr1593740a91.0.1728055739378;
        Fri, 04 Oct 2024 08:28:59 -0700 (PDT)
Received: from crabo-Latitude-7350.. (1-34-73-169.hinet-ip.hinet.net. [1.34.73.169])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e1e7ed58ffsm1189728a91.1.2024.10.04.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:28:59 -0700 (PDT)
From: Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag_wang@dell.com>
To: mario.limonciello@amd.com,
	Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: crag.wang@dell.com,
	Crag Wang <crag_wang@dell.com>,
	Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv4 1/1] platform/x86: dell-sysman: add support for alienware products
Date: Fri,  4 Oct 2024 23:27:58 +0800
Message-ID: <20241004152826.93992-1-crag_wang@dell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alienware supports firmware-attributes and has its own OEM string.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 9def7983d7d6..40ddc6eb7562 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -521,6 +521,7 @@ static int __init sysman_init(void)
 	int ret = 0;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


