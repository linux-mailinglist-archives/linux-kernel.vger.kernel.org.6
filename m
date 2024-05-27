Return-Path: <linux-kernel+bounces-190465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CA8CFEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3093C283744
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5513C3F3;
	Mon, 27 May 2024 11:13:38 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0319249FF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808417; cv=none; b=B29YnjNSMrMvsNxxUSDDObCl3e2Rd+pBu3SUKlkn9LyKoVlUWIhjqq7wzZWvWQHFPIoMGwpy0zU20CK/FLdxWhSAAng2bze+Bv4icVcgSodfppqwpA+mPevhDjyRzYyp1gyEkB0yyNXLphio5Et4e0AhPQYnKCOxyTdaONAgZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808417; c=relaxed/simple;
	bh=R2KAFyJ0ppoTQL04oRx1FgbUdLHm3uC3Pi/EGX9XWTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHKHpM2dETQhYm6R9abiVRbru1LPzl2Wzx8KZHBwoLuzTNB8/U9TZyDc+T5SxBxluvr+xO0u8/Jk5wSwuRamS9wwA8qlxF4lukiSZ8iteINxEdXtRJyJ8n00ZTw0piN1Jxbrusv+KNUr/ZmkeJeDcjqYdOMw+EIj3AY5dPGXoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44RBCpcs069126;
	Mon, 27 May 2024 19:12:51 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VntFJ17bjz2Q6g9V;
	Mon, 27 May 2024 19:09:08 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 27 May 2024 19:12:48 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: fix to remove redundant SBI_NEED_FSCK flag set
Date: Mon, 27 May 2024 19:12:37 +0800
Message-ID: <1716808357-7161-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44RBCpcs069126

Subsequent f2fs_stop_checkpoint will set cp_err, so this
SBI_NEED_FSCK flag set action is invalid.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/gc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 20e2f98..ef667fe 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1752,7 +1752,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (type != GET_SUM_TYPE((&sum->footer))) {
 			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
 				 segno, type, GET_SUM_TYPE((&sum->footer)));
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_stop_checkpoint(sbi, false,
 				STOP_CP_REASON_CORRUPTED_SUMMARY);
 			goto skip;
-- 
1.9.1


