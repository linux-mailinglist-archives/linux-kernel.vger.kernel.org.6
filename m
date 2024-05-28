Return-Path: <linux-kernel+bounces-191980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEE8D16CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B05B236F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CC73474;
	Tue, 28 May 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azok4Lh3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E613C3F4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886985; cv=none; b=JfmY3NiuV3Wj+i75zvP25AQtqwXlfeqTOXap4ItxHZG+82t+czi2q89foE0UX8L6K0HKXPySpTJhOaHyv2yvlUDWY+iCF6ZUGYdht+VsC7v5GVkn5uf+Fe8j3hu9Xs8fG7e3ius65EyTpBVx7XJfJY2LW62SJejAB/lP9EZcPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886985; c=relaxed/simple;
	bh=uboriDCKWeJMPTjPITy2yzoiM+nx4vV167P9uIGhE10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5Dcl7zU/P5rth+wxCojUXBbKMpJ9/THLku0P45C/KWDOgz8P+8ZelJoTWCovqMAXiRcVCdejcPWnGXiH2akK09DriP/OKQScMoWIpF1s9D0Mf4RWBC3ynYUdvwyxToNIvhN2W9lZCrBY/kWalUcOgpjZhmLDRL3+J8ridSt58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azok4Lh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716886982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XxpobPu2s04aDHCSU8HoaN1HgFuJlZN8yBuvL8SN10g=;
	b=azok4Lh3XM9vU847YtlWAEEKTFZrDoZguCgXAPXTh6pICjRRttTR8T2wdV7HUCAZkFDY06
	xrKrn4ignrxyvp8yu6kG8USsvrFbjsh+Ok1snVWf4I1eyfyKrfaDhiH2tHSNlyjmEt+TpL
	TQ7lTbSWNAhSxCsWKwz+lVHulAGJ0gM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-YLZ8MyRlOXS9icYNxf5gTQ-1; Tue, 28 May 2024 05:03:00 -0400
X-MC-Unique: YLZ8MyRlOXS9icYNxf5gTQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e95a1f049aso4021011fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716886978; x=1717491778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxpobPu2s04aDHCSU8HoaN1HgFuJlZN8yBuvL8SN10g=;
        b=Hqa+YzhYILjkeWI0Z2F3zLmtQbWwSU9fL6uMrPEbqH8fR4mpdhKvH4U7BHWmUcAve1
         7NnhB5L8HBT1e2/w7EhS7Elc1QmffswClCNBEtIcE0ALb4cUZbo/GxpXbknXiMeQ0t6R
         Fj8XKcj7pHAJrtCykWLgOrN3u6ncNIB1ZcQGf6aTGPhVu5dbTG97W9kayTKWbSwa1+Ju
         cpOZN779rvQZKvILwXFnkVzWYQX7fehqSIG97hl42Bkahlp0GXfh8qGwsXrI4R/iMIny
         lSteefAITo6RpVTBqXCmktVpwAXilXSvB2qQEM667bVDGaXynjP12WL0dDsqzPd30/bI
         P0eA==
X-Forwarded-Encrypted: i=1; AJvYcCVSHuRsEkBlusmMxLuYhnedRZSZ+9eTdo04ZIkeVdCDsYlqa0X7m1z3txGFvGqVjAtkzpQbZNAMVK6UHg/pXH80LOPlnrAowzWSJVjb
X-Gm-Message-State: AOJu0YwpvzMTdJvHf34McFGFaZ499lE9fFkxROYPFHone/xWxw/djlFz
	TqPSSuAjGQ+dNnNNPddl2fQ7BMrVGAwXrT+aylgfaXmUtrrXQoXKiq0AUmT3P/2BrGZ5/5yTUFZ
	ULplyP5Lv2Fw4dh80nS3Mj9HljiBNSue+tXc08GGDGHhoyWCHrVgyM8a2hKfC6A==
X-Received: by 2002:a2e:a695:0:b0:2e9:85cd:a8b3 with SMTP id 38308e7fff4ca-2e985cdac72mr12031221fa.7.1716886978553;
        Tue, 28 May 2024 02:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkZpuxCf2TVJfINSNEqhmE2p4hgsQIYE/R+0c6+U2AbobsK5d7qu1h3PAfmQ+tXABzqxg2iQ==
X-Received: by 2002:a2e:a695:0:b0:2e9:85cd:a8b3 with SMTP id 38308e7fff4ca-2e985cdac72mr12030911fa.7.1716886977958;
        Tue, 28 May 2024 02:02:57 -0700 (PDT)
Received: from p1.Home ([2001:8a0:672b:c00:2848:324e:c3d8:68df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c93c6sm11112638f8f.85.2024.05.28.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:02:57 -0700 (PDT)
From: Eric Curtin <ecurtin@redhat.com>
To: linux-unionfs@vger.kernel.org (open list:OVERLAY FILESYSTEM)
Cc: Alexander Larsson <alexl@redhat.com>,
	Eric Curtin <ecurtin@redhat.com>,
	Wei Wang <weiwang@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org (open list:OVERLAY FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ovl: change error message to info for empty lowerdir
Date: Tue, 28 May 2024 10:02:40 +0100
Message-ID: <20240528090244.6746-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some deployments, an empty lowerdir is not considered an error.
The current implementation logs this scenario as an error during boot,
which can be misleading and cause unnecessary concern for users. This
commit changes the log level from pr_err to pr_info to reflect the
non-error nature of an empty lowerdir in these cases.

Reported-by: Wei Wang <weiwang@redhat.com>
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 fs/overlayfs/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 4860fcc4611bb..53170d73bb79c 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -231,7 +231,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
 	int err = -EINVAL;
 
 	if (!*name) {
-		pr_err("empty lowerdir\n");
+		pr_info("empty lowerdir\n");
 		goto out;
 	}
 	err = kern_path(name, LOOKUP_FOLLOW, path);
-- 
2.45.0


