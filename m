Return-Path: <linux-kernel+bounces-431481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80EE9E3DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6802816B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1820B804;
	Wed,  4 Dec 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9IzDfOB"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063E1BC9F0;
	Wed,  4 Dec 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325124; cv=none; b=J4BnupDUsj3Uc0r9oLfnpCREc57d/Tz08tRd7X8R9pawdsUKWxf22wl4nm4bf8fhZsmE7Isrjo2rxLQLhXtd6ihsdRUZAbPGrUPT2fkNhrw0Unt2tXALQDXLo9qvRWLC5mmvdQpnki3W3Oc1sIIN8zhyU0+j+2ewzoV07mmaWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325124; c=relaxed/simple;
	bh=sCBuah6nn6DorPuCQQxE6hYgM+ORL0NQDVYqO/lKc1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DT9jyuuXDHtSbqnra6InHYiheYPMK0Av23LtUdOpPEAsrt6zMZG1Mz8RKlgnZJR9Db5m5RuEgM1fwifqdx+lPk3KpWwnPDWm7khuvV8oM/tHQzpBhsma+TsVokvnxlfkzNWh8iNOiGxyuCoJKnSzS2OiQbT7LL6pjGtjQqDD7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9IzDfOB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385deda28b3so3501325f8f.0;
        Wed, 04 Dec 2024 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733325121; x=1733929921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulL3T8InS0Quvke01cG4yfvO65Xh+6E0FkduTMFmRhI=;
        b=j9IzDfOBUeTsgaRjT3ns0niHE8YUwJS6I0DVtuTSwxfZebUfJUBQoele7L5NZUNh5/
         c2evH1kjX4v+CjH5OiasZ3WVoJDO4sDH4FbrpQh7emqgP84Ji8GCCGcRwZRpBzfnq0rK
         hEXBqqv3XGGVSHav8O0PkRBkE7kroeR6+OLsN+Q/DcloXpjAfuozQ+pKim8wE6FjuWxt
         Cn7PgtqtxqMUShYlVm0DHSECxE5v+aDfguhx4byZK6Yi+0GoXiCoDPyF7sLrOq8skYjU
         Cm9TrGc3zOiCk6ZdBr8Y76Vh1Gk1a6htm7dFTXIBLijh0rpqvXQ4U5GsTKIu0dbR/K1n
         EeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325121; x=1733929921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulL3T8InS0Quvke01cG4yfvO65Xh+6E0FkduTMFmRhI=;
        b=KMyk23cvFb/PoP//4y91UaYoX/iK1AMel2FtODYEQZntUY5W7u6co4rx1Sb3fjDClq
         1gIcFRNGkGNFTgk352n6rxWJSwqc49Mey4iUKPAN9FLSKcAG5bY8uRq4MguscwkUR8YP
         WFyDmH+zAr3cvossFHxnsIe4Mi7R2d9b6OYrBtvckHCv7FWTv4lW1Wrv2pvzXC8xtemK
         BUunTnW21Khd2SNW9tSs2oZgzAdXs6egeSwYE6uixUcC9whqoadS93XMf6SNR8avogae
         67yHYGqV+foiMklpFwcXTujm0YO6/i4g22TyMKHuIP/4EtRFl0coFuGUG8U9wD7+XpW9
         CzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYsNN5e5PTNCsZWlKKOOfTucsulLnO67ja04ax4fSu7tpHyE0LABo7QhSHkJe8Ty/VLaAJ627rmQVk4Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gWBHa/Yw5Tvx6+v3HG+WcnVmZQ6o57D7p2Df1mEQk6Z1Ne7P
	W6wUYoQIQ1RU8Ca7rbc/ZF6DVQMq+BMliFXSfdo8NIMmm5ZCAf+B
X-Gm-Gg: ASbGnctPF5238QcVHVKGM+4h+Lncxnoehrjgw2gdmScSCsnE8BCFfXxuH/d4b20FAA8
	m6y3S+YEOY12sg+IOWQKPWUJaTaKhPDYtw0BLeRkKCDUMpttl17DWcnQiIVwn6MmW+Xf2zWqO21
	4scenRflaZsYNmrugGn8SEpNuIeLsjbAMPcaMl+QID4cjYrKolnQonk7p0IaLLaSL3IxahXbOA/
	dodXRI2I8xAwMlBz8xQb3eKMu8dYjpINFLxMC4S4M/QGwEAGtY=
X-Google-Smtp-Source: AGHT+IEVBBg1YJOhpeXi0WEdn1yE/JozVAa3iha7YuxVEquuYeILdGh0LwP7Ll4C048taQR1AQQS5g==
X-Received: by 2002:a05:6000:2d10:b0:385:dffb:4d66 with SMTP id ffacd0b85a97d-385fd3e762emr3643278f8f.17.1733325121233;
        Wed, 04 Dec 2024 07:12:01 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a710sm18360272f8f.57.2024.12.04.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:12:00 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] afs: remove redudant use of variable ret in afs_dir_iterate_contents
Date: Wed,  4 Dec 2024 15:12:00 +0000
Message-Id: <20241204151200.399599-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being initialized with 0 and is never re-assigned.
At the end of the function the check for ret being set to -ESTALE
is always false, so the check and the call to afs_invalidate_dir is
redundant. Remove ret and this check and just return 0 at the end
of the function.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/afs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b6a202fd9926..83233814bd19 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -488,7 +488,6 @@ static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *ctx)
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct iov_iter iter;
 	unsigned long long i_size = i_size_read(dir);
-	int ret = 0;
 
 	/* Round the file position up to the next entry boundary */
 	ctx->pos = round_up(ctx->pos, sizeof(union afs_xdr_dirent));
@@ -502,9 +501,7 @@ static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *ctx)
 	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
 		       afs_dir_iterate_step);
 
-	if (ret == -ESTALE)
-		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.39.5


