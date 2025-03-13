Return-Path: <linux-kernel+bounces-558751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED3A5EA88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85E4189685F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C213E02D;
	Thu, 13 Mar 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7TudeMN"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEC78F37
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839966; cv=none; b=p+B0qq1DdSpvQVbI4/Mwo9Wu7Iz0VHAnIXtREDDfPFTVz8yaRWK47O4gQ6FBu35XfN2bUhEK1g/j8wbqip+1MnW5LghPWNUpvK5hdFC1QxEYq6Vkgui7sxPpax2rifAru8hYBVNDe4QZUN8bBZ/Dz8IC7kNoVSQET6lx6g4YgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839966; c=relaxed/simple;
	bh=t0i3xxB9NqroYdqkYjp3FPjZ7hOFU7ETmVWx06sy33s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBvzAaAJaKrk4ACVH8Dqrl5uRIXBlW/E+sbeOMsBY4WZcll0Cbn78db+vOfVQMDEJ/vs6gb4yK2qHZJpIrBxcCDpe/G8kUHhzjVVlTYJ3owPMrzVAfyUrpEnROWnwv51vHyeNGTWPPJTVp4/mNzKf3twWhoNuv/xGt0A2J8ucCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7TudeMN; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8ff3072a1so872776d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741839963; x=1742444763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nieNMs7+cI01uDGtEbChh5VGZnwSZ+dW8uHTjSJv+is=;
        b=J7TudeMNq2G9i5PpY0kjIjeK8eSX4fMPpxx1C6hGiDpBDiJJyWg8YxhJBbJaW/TW5j
         +3SO7EolOdZBwCbvHd9/TmZAuX+gioBGELsk3StGoDwJXUXDNoFLm+h5TzKRt25bfEa6
         gkKZ/ozHSyySS4+/VxUJ+R3tsVLEaJS8PEAazIu/stqgGbyrH0xEEJIIY5vOT+/1DWK8
         A5rXNoQmXxcqD3UUqgGre4WJb7EyYp413TR6YwaJNjPbJXeedOj/1veh3gD2x4CYWa45
         c5nYdZPaK1vpX9fP/VF+/nY9FW7u583JZteDS+K7O4igdSgV7BMXv09FxW6+J+S5zoqr
         BCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741839963; x=1742444763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nieNMs7+cI01uDGtEbChh5VGZnwSZ+dW8uHTjSJv+is=;
        b=FGqh7JOGTfOoKRulplzdIDFsKJub73kU2AMFqMSE/Yhuh56K1VSMFxwXiB7KxpsIOB
         cff37DXVdFmLbhDbHybvHphw7wKB7gRyHCjQ9RpKEZh9BaWeSK4/Q6wJct8UMVksfTbQ
         E6s4Sb9GK8wRJVjXwkAhUnZVJ8IJpCUMMEUzLjmzCln9HSSK87rvDXEFxmN6S/8gp7CS
         fzrB4kwXYHf5tsj3kxcxujiLpkpxW05oE2rjiJKuJhjgW3A/FP5Z7qN1yP+2rgLxTbdM
         YEWgSXcpa1W2HzTrP1bzVj7Gtn+Y9cNPVqMbbxrJNFXQ4KJ4Wi7zEBsz+qF7qiuPkj8R
         +apg==
X-Gm-Message-State: AOJu0YyD+AGW0FNagWf83V9rZy5W9mors0eKwn74YJ959bwvXy11f44d
	6vIhykQEeFn1sMzTAQTIo1jckwY8YFc9m/bJKgq9tw+L2Zs6mS0=
X-Gm-Gg: ASbGncvq5jLmHTPsW/chDhw85RWJRpdTKnei9CJb3P5zYRz9bH44dq6Jnbr5l+ZSnSi
	H3BoGJir+NhwAYxLylYGRBHKwRdO3+9V0JXLIZOZCp6LtHx/J5qxXHJoRGxJgE+RNhpk+pSv9Z2
	aBesgyTUoMpOrJGGDo0CGCBEZTycgtKRenjifLHIg+yWRbQCq6mcKy9k+nCitnoHzDSp8s2XYu9
	Ufbd2Jz1XftHJrGLCWoxsesNwL4Pmy543Dcas6IvvpQ4jeYYCDChpBk+qpM8ehJ894ui6HOsOAm
	ZETOi+A9nRoSdHy1If9lup+RFCse5eTjH2eysypebA==
X-Google-Smtp-Source: AGHT+IFkON6ImdZyt7KPbmMEVe2zyi0T917+yTblILKjYzPy5CsyUdH8ke3k+tpd50IvwCP7f+O75w==
X-Received: by 2002:a05:620a:450a:b0:7c3:e1ef:e44d with SMTP id af79cd13be357-7c55e6e77b6mr587745585a.0.1741839963288;
        Wed, 12 Mar 2025 21:26:03 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89b8fsm45680085a.105.2025.03.12.21.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:26:02 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: tytso@mit.edu,
	Jason@zx2c4.com
Cc: linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] virt: vmgenid: Add Null check for device
Date: Wed, 12 Mar 2025 23:26:00 -0500
Message-Id: <20250313042600.1168619-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all devices have an ACPI companion fwnode, so device might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for device not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in vmgenid_add_acpi().

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/virt/vmgenid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 66135eac3abf..0cfa2fbf0d44 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -59,6 +59,9 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 	void *virt_addr;
 	int ret = 0;
 
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
-- 
2.34.1


