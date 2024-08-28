Return-Path: <linux-kernel+bounces-304664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3493896235C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E567F284756
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAE161339;
	Wed, 28 Aug 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO0Zg0+u"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818C15D5CE;
	Wed, 28 Aug 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837334; cv=none; b=TBLoR5ClwW/1kpSGu+2DZfv6Xh9DvRhz+qTA11pKElMbtRE9S5vZBNBiEu48/3RjbQaQLz/aFknp7AY54zTYsVfe4Sk6usbxvwCxWlzSvDpRpunTHvYXj1trWXyQDDG6MlTyd9apWbbwTAVDfoCdkSZVIiQTqZ/DqlBwuAYu6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837334; c=relaxed/simple;
	bh=G0qFQ9oUEmOIvAA+6HRgAjEdV7UcjkbxDkfABWBdDRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qm/EhAnJGD4FXF90TFdLZCSAc6AHpvN1iRENOggxcqDXJerJg2J8SyFyM35bF+Xt0b4IyGhWTxQQeOwDtfbW0DF6108Wgw+mxwMlH140WQE3Qmej7hrhRpG353D8v2T1estHys1H5jnBJpfo3usv2Eiq7H0e4KGQDd1ErkpWbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO0Zg0+u; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86a37208b2so601550666b.0;
        Wed, 28 Aug 2024 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837331; x=1725442131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BQsCoCFEiSXVcRGxQXzqzuLe0usDHQdTEHSNrfC54g=;
        b=JO0Zg0+uu9GJFJtfG+CEgBDM3nq89+TtnseisCQ9G6MHYsujRvnQx46Yk1xaOjqMTQ
         5GUxS6t/iOx845Xi+Olmpg6ni81WWrQJ+LdnIxYYw6q2kM51bHfEfpmibdBGmC7cmZXm
         5gXZ+gksgWrtSbm5KQIc0q3c1ni7aF0BU3CJUsnpV9NC3tzIerTCHNdPFq7sfF14Ha7d
         ZySZVEHX0/AtMfz0QXASIUFaAY6pfe0Prf9Zbsq/e8uH9H0BK6Klomf93wxg0HcGRH6X
         ilp/s3ykMtH3oae6Sp8tEcbt3nuvCm7rHCcHdOiF/l9t1U6MGfeXaCUvZ+NUkBQX8lwV
         644g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837331; x=1725442131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BQsCoCFEiSXVcRGxQXzqzuLe0usDHQdTEHSNrfC54g=;
        b=AweGPkUsj83sqP4nmnaFfbEw0jtQUMOxk/s1LLy0Ha3O6CNnUTuRnpQMUIrD1vPFc1
         Ume3GPDCsbusrklPH0EL36NURZLGadFRy81tIuIUrrnokq1DI7hjRjIclyRpL147AhG8
         2Ij9EHBZZnHmkZKFrrU3yPMPAfozqK6ynX7QNZqTOjkLXluKroXiYdHk+XrQvAa1zHwx
         xDxB3ru6Qmf2Lg0E+Ap5E3vzV9ufBJLN2IdzXe4Jue5myKouSh2HF4u9emeAFDOeE4er
         4JQxzopRkpEyn7aFeV6z4utJ+FNAG2Agil1cBWyVn9CVE+ZSLcr7EWDQCSASoTogq7Ie
         roSg==
X-Forwarded-Encrypted: i=1; AJvYcCU0R6r8dl2XTNPBWRnFgyEmKyJnBz4mW0DatGa/zZA7WLJ68ifnui/IE65jtuBjjwCyzcELbbeKthu+Lhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtjrqhPHZwopIoOMBY5J4uC0cW0VW0wEHlCki5f1cs0Boz4Tt
	no1zLznEFwQha7shpdotvIuRwGbRSE9lksI/8Pvbe+mdFue0hfqD
X-Google-Smtp-Source: AGHT+IHsvmMmXLzi1s2aMB4wtmGpZMD6DO/nxH1hCgKa0l8kC5vSxDkMyu1GH+Mu5ojwuMpDIs9pjw==
X-Received: by 2002:a17:907:3da1:b0:a86:9d3d:edef with SMTP id a640c23a62f3a-a86a5188f43mr1083191366b.12.1724837330104;
        Wed, 28 Aug 2024 02:28:50 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cb8esm219239166b.67.2024.08.28.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:28:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix spelling mistake "recommened" -> "recommended"
Date: Wed, 28 Aug 2024 10:28:48 +0100
Message-Id: <20240828092848.271137-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ntfs_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..7c4eb9b61d4e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1247,7 +1247,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.ni = ni;
 	if (info->flags & VOLUME_FLAG_DIRTY) {
 		sbi->volume.real_dirty = true;
-		ntfs_info(sb, "It is recommened to use chkdsk.");
+		ntfs_info(sb, "It is recommended to use chkdsk.");
 	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
-- 
2.39.2


