Return-Path: <linux-kernel+bounces-343457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6E989B27
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294FB282A81
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E756742;
	Mon, 30 Sep 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pct16Sm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1504155316
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680533; cv=none; b=HIJklupg2Rd/uGKHObPvfYNph74L1Mc6GtvJ5HHdEzZFT0EmzFJT0sOyzXGQSXxRprcqeLfvu0Z4ZaLy8+sT1Th6StN8ErZqMeFnzyK2h/4DZKKZktJ0wxU0SCCjHJ64hWgeoSQ0ZBspZusKw6oneTIylt4H2iEEYetkYhAsOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680533; c=relaxed/simple;
	bh=n71sUNq5yEVyuCp0n69wRu9BWzJ2+s+h18rwOjG+v9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLxqGW2If1b/zKAj3AWWQB95h88HGuMwUIyXvNbE1YEJ/NV4Edu+ksBdzOg6fO7gKz4cK3kgYK3fDejYFIp6JFf03Crs0zMfwyTK4KM9KtnAYi/nKSY2ke2k1So52Dx/eisBo5O0wiOrvjemNUgyvW5Poj/51sLUJhfPVaF5ZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pct16Sm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cfee6581so6154953276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680531; x=1728285331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFkwKi7wORkaITTIVySWZ1TVCuKZibVqWlFRxA8TaE=;
        b=4pct16SmbNi5GGSyCuDziheA3t/XOmEETWR318rAlzBBV+xIGTW5KtKHcjDg6APVO6
         sl5eZkaphMrOKJzyL0DItGnvnZU9WjLUJCfVf5jWWLu7Aq0lqeKJTDbBvFar8t071w/l
         uVmcDS1x4kKGamAXflA3oYcVDrOF3476dtl6QSYK6RFmIw9dm+bG71J4TPgthNqr5YiJ
         mvhM3F95sPa6OIhY+w/breZeCu7Ml7D39rqKIK7KFfuM3z+XrF33pJ098m+Ls3ObLOgA
         jB8n+BsqiIibcFSYJtPoYcBe00kEyLnD+wROMQxHX0dl/HsCD8srCorkW7AwV+WvLm6Z
         3sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680531; x=1728285331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFkwKi7wORkaITTIVySWZ1TVCuKZibVqWlFRxA8TaE=;
        b=FaS49LYrFQq4Ywq0FvBRpLlj+xMwf3BRmcJp/wmnL4jECuffpfrvelkRcf+BoBgKw9
         tb6KZb3DqGHctrkrju+L6bW+G3Ox5v5sqB6WQA/1e0FxkZoZ57DeWL3Fv1fxbCa1E99z
         eud5QCmycaNYa5Tx7gjX4xl8hPT6ihgeWz7McZ39tTEeZ9NuPhMmPA8jDKVIBW8yz2RN
         MIeN3roP7tgdshmWTA1cRAeBvxgn51lfqwIElVvKkzccTGjw9lY6EYjToqwPeBm+PmG8
         SGGGSk8bvMNFJqR6wYdiIiDNmMXEKSkPr9kjP0aupIL6h0U+vl9I7uQW4p1isMtLIr6G
         eesA==
X-Gm-Message-State: AOJu0YzgBbWLxrPNRyRhHqrcm2NWBAFaKAlCnFzHQ32Wl2c3jMn16Hho
	4Cb1DwCKNPXvvN7tuGnTLh022t5ro5KGsEXQbNRIWPo0kS1YLKDFtGW/xPaeyg5U2cV72HJcBnP
	kfWTQLzlpeXPK5g7iMmu2t44qJ6uHQQkJNHgv5uxG4wgGLCkIwOXQ92J5wOm4Fl6cu3aWJUOQye
	KmybuxYZvhZEAiorQpmOivdcj3D/NdiA==
X-Google-Smtp-Source: AGHT+IHlT3DMxohKe03A8TS0L1Z75WqAqi49LWkf8IAgG/1tHRvVHLfRdZ6a9GNwWISbp2f0lryrnggP
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:5105:0:b0:e0e:c9bc:3206 with SMTP id
 3f1490d57ef6-e2604b3e6b8mr7576276.5.1727680530050; Mon, 30 Sep 2024 00:15:30
 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:16 +0200
In-Reply-To: <20240930071513.909462-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=ardb@kernel.org;
 h=from:subject; bh=XYVHEk+fyc+b419KXfVjv9/VU6bLywLl8KdcTe49YAY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XAMvKaXsePbde5td+dfnhwmiXT5KtMpOUj2dUMoenF
 PtWLmnoKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMxjWX4n/+KZ1mOY5Nuo17G
 w1N8j1fMPBPO8OCstkrBmZ0/Sus5axkZZtSdcld0/rF9HlvL4njeqq+1F5aYmnDrf7A/OrWtvjW CHQA=
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-9-ardb+git@google.com>
Subject: [PATCH v2 2/5] x86/pvh: Use correct size value in GDT descriptor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The limit field in a GDT descriptor is an inclusive bound, and therefore
one less than the size of the covered range.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index ce4fd8d33da4..5a196fb3ebd8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -224,7 +224,7 @@ SYM_CODE_END(pvh_start_xen)
 	.section ".init.data","aw"
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
-	.word gdt_end - gdt_start
+	.word gdt_end - gdt_start - 1
 	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
 	.word 0
 SYM_DATA_END(gdt)
-- 
2.46.1.824.gd892dcdcdd-goog


