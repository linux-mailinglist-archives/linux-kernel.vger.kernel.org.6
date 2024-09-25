Return-Path: <linux-kernel+bounces-339413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9F9864C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA271F259E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0F13C9C7;
	Wed, 25 Sep 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0zW/CNR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AD13C8F6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281524; cv=none; b=DBuEqDxTLQr7GTVVmQC5+Sxonil/8dRbBz0PQk8BeujtNvA28/kWtKs0Dh0cjHcJO2NVbHVN68pE03d7DwWBZ+2vzd1FxPlrDLVkL6v5EEQZAnZqmnGaqqBHAldOLusQWCKeFwl7syuO0U7uD/xbCZ95XAXOJoYpfWhOaYY9ryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281524; c=relaxed/simple;
	bh=4IztXoDnmzedD/DGGwCbWuMnFco0zL0LtDzIkgaMdFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsE0nwJrDdAxKEq0p4VDrwQufVwuTT/JnJQzS9vnIdHocBv0M4+HREjt/KD5QOD4dHEAxB+sQG4txy7ekB+OHVFIrWgoJgnEZW+q7NNJvkVvewQG07L/xtEL1/FJeQeoJRKLej6Bi4fR3Qx2v0P5lVKUcIQIv+P7NZw/XzzfaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S0zW/CNR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20551e2f1f8so82173595ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281523; x=1727886323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FZ5g7QcrBKoaqiirz8r6L7CjueOS/LSXhKJhnt7qrY=;
        b=S0zW/CNR7ueoKi0yyuROtCGZEPWO9p3+AV/MV2EAigPY5e86/UsCBtfZRwA4UIDWma
         S1PgdZqJsEqdCCK4oIW5Dx3OCxWYVAfN0ez+drz8vCsP5+rY5Ak/gdp1XWnTb0sf6dST
         yo13c0TsHee/86fP9Pw3FDuUl6c01qj+R34CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281523; x=1727886323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FZ5g7QcrBKoaqiirz8r6L7CjueOS/LSXhKJhnt7qrY=;
        b=kusstv0KsdIGXPavpyvR8fb3umfNI7YDOwPwYOUHW2CzpRwpoPqGW7V+uPB7525adt
         Dctv/mbR/0//63KiMDUqFkITlYDKbVciK/8lE4QeU4zFtu8DXdAHkPree5QNQZmSjH0S
         h1hUG7F/apCOCI4+KFJyfOtbDrLQbPVJq8yuVe1GFCnrFKAl1+ZKkagNzWBY/RjmQXAZ
         PRyonrXAlndzPeeRdq5q+HLLzRM5X37aCVW0xZjWnp09EAP/kg9i47EIscXL8vvm62lR
         /Y0c30GiOYKeC4Qx7wT6iUoPRBRPT+1J+E+JJ3NjE9YJjdPQlQZCQChelgdd9UYnJBnI
         0FsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8nQFaQjCXnK7k/KrDd8Aim1Um5wcV87VVqvej71QMR49LKYqXfi1QroFqQEw05PYvPMre62ox+9AEms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVb+xdNZML6Cqiu40UplL1BFl5rPLfoHOVMVL4PkKcL1+bFbg
	XttNDf4QUU3ucamaXu2OLT+vXWSN4ugV0ZBwSdtWzoNPhpZskkxRZYflg1gGZg==
X-Google-Smtp-Source: AGHT+IEuLsG3mUIBakDR0Qtj5wgz2xldoqosHu1rfjf/OYnO62itqm43VkTh6/qg5gZfBIHNmBOf9A==
X-Received: by 2002:a17:903:1cc:b0:1fd:791d:1437 with SMTP id d9443c01a7336-20afc415addmr48913755ad.6.1727281522770;
        Wed, 25 Sep 2024 09:25:22 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20af1858b4dsm26217325ad.263.2024.09.25.09.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:22 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] platform/chrome: cros_ec_typec: Disable auto_enter
Date: Wed, 25 Sep 2024 09:25:09 -0700
Message-ID: <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altmodes with cros_ec are either automatically entered by the EC or
entered by typecd in userspace so we should not auto enter from the
kernel.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/platform/chrome/cros_ec_typec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ec13d84d11b8..e06a0f2712ce 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -294,6 +294,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	desc.svid = USB_TYPEC_DP_SID;
 	desc.mode = USB_TYPEC_DP_MODE;
 	desc.vdo = DP_PORT_VDO;
+	desc.no_auto_enter = true;
 	amode = cros_typec_register_displayport(port, &desc,
 						typec->ap_driven_altmode);
 	if (IS_ERR(amode))
@@ -314,6 +315,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 		memset(&desc, 0, sizeof(desc));
 		desc.svid = USB_TYPEC_TBT_SID;
 		desc.mode = TYPEC_ANY_MODE;
+		desc.no_auto_enter = true;
 		amode = cros_typec_register_thunderbolt(port, &desc);
 		if (IS_ERR(amode))
 			return PTR_ERR(amode);
-- 
2.46.0.792.g87dc391469-goog


