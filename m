Return-Path: <linux-kernel+bounces-282227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EE94E10F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047F41F214A7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D549637;
	Sun, 11 Aug 2024 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SVB/G7x9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55A4D8A2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723378760; cv=none; b=B0xtC6qBooC+MrD5O/FFCj5mIeWWUsb4Drqmz5Jkb9jv/vbWaNI4olkrG2SrrxdunfFhwpJDvcSIvs8g+R39EDVgz4fJD3u8FmWb4+8BTuc4b6B5MRte6UXxjvYTnbXUopXS3b+n6nD97ofXkAyWgpefMomUIEn8PW0CwmSCoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723378760; c=relaxed/simple;
	bh=3THWZrnCdxgnYfH8MMSmKFUk7cd+A+Ovt5MCn7efbvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHIpckTykqY4wjtKQdTRHrsA61eateB1vX6LjysQavDW+ujHY+VMKN074BfsgBSfghlVfb/EbJZTlijdqipCgxtZBFOgPLnMFtOqkH+m2GId1e8EK76VidrF2XtWDvy5otT3nK5w0DIB0E14J2Z71dDvhO0ZYhQBGSvtEpG/3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SVB/G7x9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efd530a4eso4671681e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723378757; x=1723983557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP70h5sOAav0dcTN2sWxjb2tAt3WMCTYkQx1cJFN3BA=;
        b=SVB/G7x9xrqyaiugcAw8YnRjd4EJSIYD3LECHCbdDcyntQ16KzinEyOMjqA/bNgRZ+
         hDYOmy5OtsUg41y5IN5PAuzUgsU/48XGy4e54KRFNGjsXpPhlBnpxNURichQMTscATi7
         3KF4Oq5PWAukJdDI19sqMCND07Tzr8oDca/23rteEL3d6ZmdXmo8C0UCThiDzgZHUd7g
         0M7R3W1jGh2HwutO3EkRdNqr2HrF/b/DfOr6z3sbpdHoMYyjy8bG1xrNb5ZD7mFK3Zim
         zMLHW0UShdA3gCZimkdgjGaUpNF18vNBOpIgqeHgBEWn9soUhkSr7ikeoq4vyX06r1bu
         fJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723378757; x=1723983557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP70h5sOAav0dcTN2sWxjb2tAt3WMCTYkQx1cJFN3BA=;
        b=SuI0GotCFswFF+RCRVfCCM4FLVuJ1tpDWCOuYQMH1EzQgMC1WQ1ItazcPgqV4iZdQ4
         ZT8YQa91ortlRd94pOI6oGLCEs0+P8Ifv4VaXFfnrYAeLo34c2pqIuOV79FYYo8bvF5Q
         p4cjTWZvb4dtY6+kCntU/kwZ3aPJ6Hsa5ilDaABS0yL5xrM3GeECS/lySn1393L2hAgm
         Iwc84vU8Gizt+rZsx5HxT2wk0P5RYzbcQjsYCFBBPNMuG2qep9XaSJ19wl+xPSNpJfjG
         Ohm3jUGMxEE3QRZwx20Gkz4ysw27TmrnQ/fqq/F42+zBvybut3jWkkCn4lz3Av9rjlBo
         Cl+A==
X-Forwarded-Encrypted: i=1; AJvYcCXWOP82b1SEWopwAc0MIoO9bfb4tJrnpVTsEwmrQpYyjw4b/xpbTEpdoCV0axQSj7HpwvYm+qHTXN/7lput7CkllgR4+ROzyINTC2a4
X-Gm-Message-State: AOJu0YzmzkaiuUjX/qWfQJEVULuvKlMYTPAFzwySoQQKCqbwr70ZmXcS
	Rh9koF9LEB0p4tJW4fkwZEF5AU8t06ngp34cD2kJq1XAoOatSZAhtX33aBzFai9bKPuRCwX2KAk
	v
X-Google-Smtp-Source: AGHT+IEXj75gYbZxGPL3C+2QgkpuQN10QPxBcziNY/qe5bJnu2lhrqOwXI6sj69mDovW8m9xxYPsbw==
X-Received: by 2002:a05:6512:1094:b0:52e:9670:e40b with SMTP id 2adb3069b0e04-530eea25075mr4956639e87.39.1723378756786;
        Sun, 11 Aug 2024 05:19:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1235sm144196566b.55.2024.08.11.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:19:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Sun, 11 Aug 2024 14:18:10 +0200
Message-ID: <20240811121809.127561-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kfree() already checks if its argument is NULL, an additional
check before calling kfree() is unnecessary and can be removed.

Remove it and thus also the following Coccinelle/coccicheck warning
reported by ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/read.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a6103333b666..81bd1b9aba17 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -48,8 +48,7 @@ static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
-	if (rhdr->res.scratch != NULL)
-		kfree(rhdr->res.scratch);
+	kfree(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
-- 
2.46.0


