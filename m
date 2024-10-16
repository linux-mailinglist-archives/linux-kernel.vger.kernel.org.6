Return-Path: <linux-kernel+bounces-367186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F399FF96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B821F25983
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC217D378;
	Wed, 16 Oct 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbUkCbnK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154457CBE;
	Wed, 16 Oct 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050035; cv=none; b=ldn8+G6bo3DeuCE1qm/IFR/x3nUhTdX0+VLYwg/k78bUx2C7MwDiCwcjjLS8gSwob6cQArWfDOEsVed01VgLL4Tu5FTLrD2bkkfAwBqIxgxsFC4h5Exi6m1ePgkh6QOdbsspnKyHA4wXwPFDJRC1LRD90fjnF7ffHJRGt6rSCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050035; c=relaxed/simple;
	bh=KQ3QR+LU7/O30RBWv0q2fn+Gsfca611jNyhD0cCDgJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkLzNuQDUNmqO3yFr+nouRYgk228Juxwl7UsgtdWQSkhwUhK94XvUrL0u2m5VACYbSE3ANeRZOBVWYTk16JEJ8mwj7iv4eR/5caUDsyurd7w8W3dVnIXAxsjOJh4emCltRN9gzc0D1ZMRAAxT9miDyT/X0tOJybE9m/7jpXrfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbUkCbnK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f8490856so3085249e87.2;
        Tue, 15 Oct 2024 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050031; x=1729654831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JiFXThj5h3MdZHktHicma4TZYkvCSjOEzEat0CqUdw=;
        b=QbUkCbnKUkuUkWBxvfBuyXaGW+illEQRfVrifMKOPxDhPSHFthO2X0KpOhOsxm73lf
         jIhGKdPBlax1hWwhjHulzFZ9RHcDw9/lWW1guc0c71eIy6q+La7yyfGiqQalbucvlNCd
         LrPVmWtrAyWrV0UOjJWleFyNtsUk2mamAoYAieY3Nz7I28Ynyt/BF7sl0mq7HXSzslFr
         sSGDYZon6xFgnu8EKhg282sCkvbddqIUi4ATk705bK6ixv0Y3A3TrpGqcw1g8DJdnmLq
         RtIcT7cOScINLzOgjtgna8jg/+bxm5N+8MjoBziZNgdctyt7n1NjfKwnP59mSFSopycl
         ykGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050031; x=1729654831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JiFXThj5h3MdZHktHicma4TZYkvCSjOEzEat0CqUdw=;
        b=SEHJKwkms7hM/EK9SELHXPLYPMI0N34iAz9HsfxxYbAWyO2Vz/X2uNuPBzXVZUyH70
         ogoGlhqeJ0DL3S7JOhIy1ZVNP+1N63AhWWY4SKkBGZbxz8nKMu8tRNh1MKUMU8UmuOV3
         dedGUsDuVKJG1dkRzEDtBkpFEsRBpEp+uxk7fKUf+avElIe/5jpG7pylWiZVUZlIN56b
         SMaIvaM2KpP+pzmJuwIDTW3LYTda+oQgHLYFjdZ8l+o9UadjvQ7MBVhM5UtKzTH6cyNf
         HqKfEwOfv1WqHhLmhbwbSs0gQRJIJrBmfP269TZjHHfTrE2scwk5kjBTdhBtQLsckYtS
         xOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVebruyoxWJTxhxeFeczYRc9ucoEWqLEl4t/Bh3ouYJ2pqYGhmAd+VEWFWpgnxMuZJxnDPtoKFkBZRyFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzQ5RchGGGh83hGOFjTpVy2ssMUpFQ+ZMlU7lZLwBPjuDgFTW
	0pCMO3wqduYn5zUfHQ4Nt/c1z3syvt3dD+nzl606xxdq3N1qZwrr4K6w9FUe
X-Google-Smtp-Source: AGHT+IHiH2hluzM7nU0gxSD//kBiOjWqI2gV9MMP3luxK+fK2+YJDkStCi8lZvQS3b0rM9egRZx4aQ==
X-Received: by 2002:a05:6512:1086:b0:539:8b49:8939 with SMTP id 2adb3069b0e04-539da588443mr7857372e87.41.1729050031090;
        Tue, 15 Oct 2024 20:40:31 -0700 (PDT)
Received: from localhost.localdomain ([109.195.41.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00006796sm323205e87.195.2024.10.15.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:40:30 -0700 (PDT)
From: Ilya Dudikov <ilyadud25@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org
Cc: Ilya Dudikov <ilyadud@mail.ru>,
	perex@perex.cz,
	lgirdwood@gmail.com,
	mario.limonciello@amd.com
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
Date: Wed, 16 Oct 2024 10:40:37 +0700
Message-ID: <20241016034038.13481-1-ilyadud25@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Dudikov <ilyadud@mail.ru>

ASUS Vivobook E1404FA needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Ilya Dudikov <ilyadud@mail.ru>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ace6328e91e3..d06c162701d2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -325,6 +325,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1404FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.0


