Return-Path: <linux-kernel+bounces-336548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36037983C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D60B2240C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF1481B7;
	Tue, 24 Sep 2024 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktGbkfVQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34608C07;
	Tue, 24 Sep 2024 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727154254; cv=none; b=TqM+Q/n5EzJ/0QeP0+RkRAjJX0D1z6/LGDi+OfxLtI5A9gPvTKp3kSh5BzlDhYOL0vCF4WuJIkoL9ZiFch+HLExVTyAC8QPA+jhj3b6uoRnGFLQXEnjLxSOpucFEeW1mQx4asjtTEutIaBfEmV21zZCDkHP/txi7tAQQFhgnGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727154254; c=relaxed/simple;
	bh=Fmh/E+dnJYUIvHkpOn7fleHebNpHYxVeRk2UqAXoGy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWkwJvH5GumGQfmKzcma8NVVa/ELcY6l6kJz6BwhP0v1ocNiwL2cDR4YyJ0Dian93Mf7YB8Oux+qStDKihbCNqCqzN3jTuj4nLKG9AdChhQi7xkBMR0ecyXnXZCN1AztJZuKPR3Lu3lVGCpHUnI0SrMGduBqhyHCK+whYr0trk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktGbkfVQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20530659f78so3169755ad.1;
        Mon, 23 Sep 2024 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727154252; x=1727759052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/F1W9u6sLCdj62IgcJf0vN3w30Ewrko5oRDj4490Ak=;
        b=ktGbkfVQIUvS/+nUAa5Ov4oog7G1aCkWolbYezprgUNPfDAPH0aQm9zHhl/7CGc63J
         dgto2w5nVeXlCJNd4TWPWEvdbLQ2HW3f/lnEIhpd1vIU0KAtHZGAw/gD6BB/DahVFajO
         gAZ0Ufwk9ahU9HxOSHBp5u1Q2PTS+6eB0/YWHcba0vTsmW+yC2Uh+5AxBzQcNd3Najwg
         2fy60Fq6tT5PjbNK8eE/HtAYhnQZpWCovnqzaCiaNyoo1UAAGBDQjzaBrhVBzjqBcP0k
         EB2EvsIApZjWq1paDmLhN8OkIimhfP9YAIFLiFp5oAEvN+thVyq/RQwpCAQ7XKlEjYsF
         PbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727154252; x=1727759052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/F1W9u6sLCdj62IgcJf0vN3w30Ewrko5oRDj4490Ak=;
        b=FJE5mrsKEoYeoYm9jJNyisROYQt9PuPIPsCpXfY0xYmdGJnqVP9uZ2rD64Ns354v82
         PXWzHpg4a73ijLQ3O8nIPsuMxhuCNepfBs/BhnjhFpcz6tFasaV2r2oyqYX+6XnY0cfu
         qPCpp3Je/zUGe/NbjVVAMoiLHi6gQIorEN0hjUDpR4zI+K6TkO5Z7N9im3f1cxaFzp+L
         IfD9703al3KUMdE8WszNbgZsUAM1YJ+OtBAF2YSCq4hhHn4wjjdvfZnNt6Mj96E30J5d
         EK/CrCEX2ynjVf8Vf713BnBph6RrOFcxU6myYGmK0LEeoeC8jbTaDVXjxOUiUkJnQ7fz
         Io5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUnQj7plecgIoxt1pxmOZcuyEYRIJWdUz8FtzyJ6tqguZ/nlUVEtVcSrdSdLzosT1ANcbzixhEVTqLDK4=@vger.kernel.org, AJvYcCXoIXOkwnMQSO7+Kp18fo6JGuB1v3hIZQwlflOLJFanMejayLQhs60kRfuH/c7ORwAwRA2YaWCW6j+UFSAaxqtnviXJgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsSY3DDoxjvGlFKexXdNqiMji2MPpWQ2DzY4H8f1XrDn//wZ9
	j6h1wxzdf8Jfw5MdiQMzdMIekj0cXPHc43iEn2y5eNkLduG7GJeCUR8u2j3G
X-Google-Smtp-Source: AGHT+IFWwj2TmI0eXsGCR2P41kfBWdumGOduR0ylK1YK9uZNgEpUqoh/OovMloH1uPL3WQZjA6d/UA==
X-Received: by 2002:a17:902:db05:b0:205:60f5:4c0 with SMTP id d9443c01a7336-208d84144admr84698715ad.9.1727154252104;
        Mon, 23 Sep 2024 22:04:12 -0700 (PDT)
Received: from crabo-Latitude-7350.. (1-34-73-169.hinet-ip.hinet.net. [1.34.73.169])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af17e0195sm3371425ad.137.2024.09.23.22.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:04:11 -0700 (PDT)
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
Subject: [PATCHv2 1/1] platform/x86: dell-sysman: add support for alienware products
Date: Tue, 24 Sep 2024 13:02:55 +0800
Message-ID: <20240924050302.317522-2-crag_wang@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923063658.411071-1-crag_wang@dell.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the URL check and add alienware string for broader support.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 9def7983d7d6..68c63e1fbd27 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -521,7 +521,7 @@ static int __init sysman_init(void)
 	int ret = 0;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
-	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.43.0


