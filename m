Return-Path: <linux-kernel+bounces-335956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986DF97ED21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54057283BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445D19CCFA;
	Mon, 23 Sep 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ltx3Yfe5"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E42AD25
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101302; cv=none; b=nQLrLtQsrVqw0bztaU2PaSA0FhpDAjVWapkvdF8VsayZvIZs1TUo9c8SFoVK93itey3NI8B9J3flelfA+YekHWqdMyNsmo+v2+cR8vQwkDkkYEmLDccUcYzLMqnqNGvL11mcIXEgNlv+6Y0qiE4Aih2gPhRwtf/fDE4MKJgJke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101302; c=relaxed/simple;
	bh=+toSuw+73TBKSfr7QVZr9PZMzXt7BLaXCEUsLRd196U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCwibQg9gqme/dw57nKZk/A4ignEzYstJklzj7dXaEOWO3UvkJWaJlggHgrOAIJ3tOJHgqomD1Kx8SH0Mv3gbEQVl+qi4mhuRwcwNPgIcEf90vlVpQZZ4wmy10U+87K9KwnVEHB1ER37yhRBlAU5TDYo+jx4XsRQ3TuYBIbiM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ltx3Yfe5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727101298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YrXhasMZTPNLx7yJ0WgCizNLa3DnzJZY8Ov+16wH9aw=;
	b=ltx3Yfe5CF5giL/8T0DPe72jIo64EFbozaGakezG09DLUfCT++WaWTbYQ/gDBnKco5rXGK
	7msPAW22T/OroKHHAcIOAIPKVYT7G4hZKWARpcVduWrCJ/lprEjcN7d63n0RKkAotzeEdC
	R6EpnMNOHIMF3OSPT4RqNuPukHFD948=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] bcachefs: Remove duplicate included headers
Date: Mon, 23 Sep 2024 16:20:29 +0200
Message-ID: <20240923142028.232365-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Thorsten Blum <thorsten.blum@toblux.com>

The header files dirent_format.h and disk_groups_format.h are included
twice. Remove the redundant includes and the following warnings reported
by make includecheck:

  disk_groups_format.h is included more than once
  dirent_format.h is included more than once

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/bcachefs_format.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 14ce726bf5a3..b97fd0f75831 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -499,8 +499,6 @@ struct bch_sb_field {
 #include "disk_groups_format.h"
 #include "extents_format.h"
 #include "ec_format.h"
-#include "dirent_format.h"
-#include "disk_groups_format.h"
 #include "inode_format.h"
 #include "journal_seq_blacklist_format.h"
 #include "logged_ops_format.h"
-- 
2.46.1


