Return-Path: <linux-kernel+bounces-411617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75539CFCE5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863CD1F21404
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84F190499;
	Sat, 16 Nov 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKh/52YG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36F372
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731738984; cv=none; b=N3THQnbq5v0H8Aum8cCd0BRQRI+kf1uETvguc/iFgeb70nnud/7U9WusbXYflM/WtNM3faQ1r3vPe4DS/aFn/zKqdVgyXPe67GnsiQHzmv/uGiI/INzIGerJjFYQLWounBBYuW/QxVh+IgKJrfg0DAKZdyYIvcC36Y0HvqWVHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731738984; c=relaxed/simple;
	bh=BnAYoyIash7AsFghDRGEiwdIKJZ2cYTecyOKaGrUoE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BGni44kP0YmoC5wJwme3sWHZT71q/kBI6Cn1G2MfbgyFkUDCneMCNGT+8fVLsLlkHHGnckY18pIEbsE6sn0hRRQEjEHKakMn7ZNeXVGijKszMuiyuErypXCGZ3y3I4ao8k9baIpLC/nxpXQWenZg/b6q7zyhXh7FsI+fIPWOg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKh/52YG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so2002281b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731738982; x=1732343782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pycADYXvsPqAbMJpV04r/N7F/YKPiZggCjUfnMSFicw=;
        b=MKh/52YGzRvPe8KP7co4fcROgVW3HHDOIozdA2yhIaiC5Vlrekw1GbVOyQq6OCxaUz
         Z8QSqEz5doT7zgLXXef3BXvLZOCD/Nckp25r+6RpRVJBssS98OpphZLq1/a4TAi29uUJ
         w+Q5ho+VCiXeo2YB/UkmtjvovgyoRZASr/q+FtQ6RzoxBNnEoeo6U11hLULiGlI71tu1
         jczMyiRLuuts92feLH0LoQt/JCE2XU757B3lc8gIyS+5zSzi3rZEyrY/9WDvllNG2/eP
         46O+3ySK7OKnWffgrNuagex/lbaV1OH5P2NI10bHijMW6pqUoi8mSrssip5OYMHvjb21
         DIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731738982; x=1732343782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pycADYXvsPqAbMJpV04r/N7F/YKPiZggCjUfnMSFicw=;
        b=FyWxb0V46s9vCZRMYyG3Riab1TiwmQMIvOTtb/+/9QMNIIDTAWL2plX9cqTho7mpYM
         RwCIWnlJXo9GS9/w2IGxR6RMdR/TahOMmzNCO21wB8ML6GD8fbsRZDj/u/CKj2HM44wn
         aZ+sHV9fSf1kO8LydViDXTGT7bBpDBkJL0HwVImBEVhXsoAcTep2NoMPqU3hxpFZ4cXt
         wJofI7Tkj+rAOlJp/cCRAf9KIMMIgYSgoxSUgJQqRlFlH9paRJqIi5FY26QEh1F+Ro2f
         X/Lr5JNmePws+WXhHgf0j2Bp8SmbBY1bx4LJFm09UbI803kh7kVemMInor86m0lrkwBk
         PPfA==
X-Forwarded-Encrypted: i=1; AJvYcCUOsgouTL/iBnqAvfbAgHzpQW2sD/pBiPQwmfD8EXRJw6XWr7y4q+TGuoNY8gPgx9gOgXerDQIXdkt0a5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFH3OZcYORfWrXR21aRPzl6Ropi8c1qOVVg1Q7XpW/72UzBml
	lv/IqfxPuSJ22m2ScxPlh+WRJeQ7wV4Ma7puHY6ZYXu0/xUFwZUj
X-Google-Smtp-Source: AGHT+IEJAhsuPrV8jtiFjLBgGJc4XoE30r3LxCSWxDAhlvmD76ZNu5/OWCmF8gQWui0m76zZFNknYg==
X-Received: by 2002:a05:6a00:178e:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-72476cb4114mr6307397b3a.23.1731738982508;
        Fri, 15 Nov 2024 22:36:22 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:7ec9:7a9c:21a0:8333])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c04d7sm2402266b3a.95.2024.11.15.22.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 22:36:21 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] afs: Remove logically dead code
Date: Sat, 16 Nov 2024 12:06:13 +0530
Message-Id: <20241116063613.15120-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially ret is initialized to 0 and its value is then never updated 
again, thus the indicated dead code may have performed some action;
that action will never occur.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 fs/afs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b6a202fd9926..afa7c24828ec 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -502,8 +502,6 @@ static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *ctx)
 	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
 		       afs_dir_iterate_step);
 
-	if (ret == -ESTALE)
-		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
 	return ret;
 }
 
-- 
2.34.1


