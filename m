Return-Path: <linux-kernel+bounces-349863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1898FC65
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0861C216CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8626286;
	Fri,  4 Oct 2024 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH1zqtnN"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13612B8B;
	Fri,  4 Oct 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009837; cv=none; b=Mlq7eKRRv/tMPYhCP/vPIT8hCMEfge/Ssloa9gr12H9vMstLmv+swTK+KTocN61RujEBjGYbtY+WPmYtp/5dIp3OO/PCb/Cx7IFan70L2pylPf7FqPulspKwz6eSgtOXLMNJVO52Tq2pfrGteR/mA/9uLx4D200eJn6ORFtgZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009837; c=relaxed/simple;
	bh=U8f7GNRMVryVWz4B9ZYa6fztstVuImpCDpCFrhzO42g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liuXWuqrkk9XHQzVFuxKkp13n6yKnpZECAntnrtkezGlYijiyDOUnXU75Ri7YDo4yc9XkBV59SGjz25MMdbv1m4qnefrM+ZDGfZJkWkESwugWL6mzsxxQpJwlq2aOQNeukLfkiqjVLE3OvlwNEzMEYeuAbwXqSZ/qQGO6Q2rGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH1zqtnN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so227351a91.2;
        Thu, 03 Oct 2024 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728009835; x=1728614635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0tSbeFJq95saflRIntIbsJykV9m9Zowwi6pq8jbsvw=;
        b=WH1zqtnNYZMskFdyjvf6XM0sesfzvDyBzaRr0NzsaKZABazSc3F1xElWHpaSrZx5op
         xA14s02wNMlcQkgRGwKmfI1PziVbdk7Tz+6LoT/qEufTMVCRuVMvBBDh1C26x/5tfUFR
         zPAHm7LgSeVka9u44rlDxeesjKA8yII2MTNr11TsMC7/1MnOO4ehKwyIhkGNzn4rX2uq
         GEpGn9FH+sW9211F2CisF+dxzqQsmUp/tQ77WROZ9kZInA5u7yfkBaVFa7AIIxQdxWZl
         WeUosVUj9J+qdZ0GsHn8mUr+qxTf8HGxjPfHJ6iBecWMlNYa794LCGp7cKzyhMbREEAu
         5XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728009835; x=1728614635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0tSbeFJq95saflRIntIbsJykV9m9Zowwi6pq8jbsvw=;
        b=Q7WkLrn+aiAbpgYv55YOB/yQgxYjXGQPI0TJu4QyziPhVCd1o+fJL7OMvX8xI5oVKA
         NItXfXdeuW5f9RlHAK9LSloPG2eWbHlJWFoqHnkic7mLhMJM3tv67TiVcXul7ChcEzcz
         KeDV1zNEnlLU7icYfHXjCmvQWkav7d7ZvSMOGp7ZyeR1cTUxT7PsV90YfosisFjkWoEO
         GVnxbUK5qcUH5VsjbHkG7XISOVul6GADUnyhCurf+uuAdN8yJh+CNWUzqlNWc9rcWpxg
         QDbr/OgTrEqT2Epd/plx/32os+zAFkQo4ZBA7Xzp5Wj7WSAjI01yMBJzIFa4gPpJ9YXY
         AjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkjmjHUeDBi/GGR6q3TGCTu4R89wh0mQvyNHlf2Q6uMjwNvFokqv1TdPVZfummJT0O7Tc/iG/Azg/jSxDNnVn07YhuyA==@vger.kernel.org, AJvYcCV+y9kPVET15UPQYCFH6k2WDXSWUfyBGbjmyT8rT7amINBI2LboVTT2BEGAlxS2PUFDpZogclYsHsogEHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIl0NY5MohOb2OpiIvBD6ysQEqYIQv9zYKn/iijEkpWu4SOme
	tgkFfHSxkZvBhdN7fzNWultgFJzQMOvD3QpicspCWDsp7TLObNFU
X-Google-Smtp-Source: AGHT+IGL2247odX4pZ+vzhNRrd84YVpo2KB19CQy2JOU8DUlZKBQTSlqg2qUtZxbKh6WD426b5oc8Q==
X-Received: by 2002:a17:902:d502:b0:20b:4ea4:dd08 with SMTP id d9443c01a7336-20bfe0752cfmr7179665ad.6.1728009834916;
        Thu, 03 Oct 2024 19:43:54 -0700 (PDT)
Received: from crabo-Latitude-7350.. (1-34-73-169.hinet-ip.hinet.net. [1.34.73.169])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20bef706e09sm15366945ad.248.2024.10.03.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 19:43:54 -0700 (PDT)
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
Subject: [PATCHv3 1/2] platform/x86: dell-sysman: remove match on www.dell.com
Date: Fri,  4 Oct 2024 10:41:48 +0800
Message-ID: <20241004024209.201244-1-crag_wang@dell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The URL is dynamic and may change according to the OEM. It was mainly used
for old systems that do not have "Dell System" in the OEM String.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 9def7983d7d6..c05474f1ed70 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -520,8 +520,7 @@ static int __init sysman_init(void)
 {
 	int ret = 0;
 
-	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
-	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.43.0


