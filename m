Return-Path: <linux-kernel+bounces-413156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4429D144C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440F728252F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E11AE01D;
	Mon, 18 Nov 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="wOQ2tS6l"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAF1AA1C5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943198; cv=none; b=m3GTOjOaHQ6WANOIQ9yTL12pt7n3VuHzUNopXXydNX08EwMNpRsYxnf0UKo+RtMJaTcP+8fZ+oDWuFw+fwy4oypFYW/2Nsz7cYrtmxRMLUUDaA1yCVD2Z93eI67/wp3hC1ZN9FrWLmNoYTAJswVtR6hnqhoy06cg2EdiXS2Pw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943198; c=relaxed/simple;
	bh=OTAgyHwKQAzNe9QHWBOL4pcfrn4VHbdGP753enF+jN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V+NOeGJ6s/3ZDN3oBBl6PX06b8EZEBJCVxnMxZRLHtbHe+9YIX1+VxlmbIH7Kxd1eQogcOvrR/HsKaPT3Gfw2ccpw1c6tm64onVrwWo6gFzQQKeer2/RARgA6aqr8zDGjUNJnrQ4C4krPM+Gms76CFhtdYEx+xlAeahCvYNgrE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=wOQ2tS6l; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1898545e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1731943192; x=1732547992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKnpzF/evUVWyiFRJwNk/oMNhYJbJ4rIzEz6848rwBI=;
        b=wOQ2tS6lUlTKyUIsSMX5CS/yzS1Thuu0OzksrRbkMB3t40YShpEsp/tEJ76o1qrtSD
         LpRFphTW5RTvPSK/4obvAgoRGliGSccpz5M9GIxFNAnF2mzsQ+yVHMQBjGazDM01OUpD
         cKiHN/g+eNaSQXmfFqoRmpe7rpo7dFrWQIYmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943192; x=1732547992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKnpzF/evUVWyiFRJwNk/oMNhYJbJ4rIzEz6848rwBI=;
        b=d65kfoaXU48KlUYAkLdKulPsiZGHOxc+QCuCNGNDkETlbfYWLS+c8iiBDCW4qgCdeS
         uyQkyXYsuOYOqVh52MyEuduexOx3oYLm/ZNhH+JK/E1XQ3369ebl8lFW3nGh4SAaA1/k
         bnAwoVSm7ZCBtfEqd8eKH+cwDS9D2An5l2C7ELy49ZKF5jvZ8MslkBTtZ6mAB55dBXye
         3yIFvIJXChMhh5v6l7HkgFUo/DgTwKjB77U2QQpvCbWnuQP0ureJlNBAKbWV4uigRU+U
         9/JtY4HOvudw4ISmiRkoHGRfXG/xMdYk1QOaABj5FMD31Mi1GmZFaMGXqc3eHv7BUNLF
         dCEw==
X-Forwarded-Encrypted: i=1; AJvYcCUS80MuTQJoyAXqmaJOgMe4CSpWUCV+qxTePZ/3YmS27jBKjFVM3/3ySSnLKmOSLHgOOcbeb4EN7gcpn2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywou0iwCrSk9jgqElhaANsFbM3CUKem+xaeENsJa161PBPEdOxY
	ilrBSIu7p2cuAfNhF6Pk8DpPv4G/etAbkqC5B6W6X7EEskGKhFhyxcpXarc2OAo=
X-Google-Smtp-Source: AGHT+IGMh+VURa9zuCTt64zmS+qjwv8VHVXqaYbqFcsqZND2XPKqiN8HRYTEfD4pR+PluX1PYo3A9g==
X-Received: by 2002:a05:6512:3baa:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-53dab2b41e8mr5690507e87.45.1731943192580;
        Mon, 18 Nov 2024 07:19:52 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c99eadbsm488494585a.39.2024.11.18.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:19:52 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Groenewald?= <andre.groenewald@streamunlimited.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Groenewald?= <andre.groenewald@streamunlimited.com>
Subject: [PATCH] Bluetooth: hci_sync: fix LE init stage 3 failure
Date: Mon, 18 Nov 2024 16:19:47 +0100
Message-Id: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A controller may indicate support for the extended advertising feature but
doesn't support the HCI_LE_Read_Number_of_Supported_Advertising_Sets
command, which will cause the initialization to fail.

Signed-off-by: André Groenewald <andre.groenewald@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e69c..c07be5813113 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4416,6 +4416,15 @@ static int hci_le_read_num_support_adv_sets_sync(struct hci_dev *hdev)
 	if (!ext_adv_capable(hdev))
 		return 0;
 
+	/* Checking for extended advertising capabilities is not enough; refine
+	 * by checking if the HCI_LE_Read_Number_of_Supported_Advertising_Sets
+	 * command is supported. Since this command is part of the LE init
+	 * stage 3, the initialization will fail whenever the command is not
+	 * supported for devices that indicate extended advertising features.
+	 */
+	if (!(hdev->commands[36] & 0x80))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev,
 				     HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 				     0, NULL, HCI_CMD_TIMEOUT);
-- 
2.34.1


