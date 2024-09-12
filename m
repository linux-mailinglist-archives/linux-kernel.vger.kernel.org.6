Return-Path: <linux-kernel+bounces-326458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E09768A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610911C22529
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9A1A304C;
	Thu, 12 Sep 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ9tnwPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C91A2622;
	Thu, 12 Sep 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142761; cv=none; b=LOPF50jZzONAwQsuYBVebv3FMTy6r0cbDJrOycQ5PYHUkA8gtor+ldkfi7lJGx5xC28ZxKBJAEDjZ2xS2/vh4yec7bHq3Gl7SAVEbRsiC6sRyJK4/u2PSgH6BjgZjZ4xowbQPGHUhAsNS0DzuCyj/sy+sd1zDS1N1uW5v3yIyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142761; c=relaxed/simple;
	bh=Tvx8ty3Re4/zz/tINhZ29nrFM+JFehh/c4aSeICembc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1ctZG1ExliZYEl1j9UgbL5fWkBhYzqHPGSa5Fulyvqo5R4YZ3AhKSu51miqxaGMdsLg+9qVtaj4u8vH7dkv2uR6YcFWiRCAIQZMm96FcHStG0pmPerKqeOFvML3buYdO6ODlALCsIDknDcedbM/TV9X+RS9QWLZ09rATSdjcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ9tnwPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D45C4CEC5;
	Thu, 12 Sep 2024 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142760;
	bh=Tvx8ty3Re4/zz/tINhZ29nrFM+JFehh/c4aSeICembc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJ9tnwPpM2G25d3OmnOAmTtGzM5P3l3CSxCTDInOpkBInXcFQUKlmaOv2kBKhBOfF
	 Zi8APJLcxptc702OSQ9NrnmCGcDuWfyKlAR2YGfWot4QvXPiacXQVkdMqwTeBUJtAg
	 m0oeE8tEoZjdb9rTng2fWxtBqVcQr918w0nybgi5VmZSEcLD3jH/fPbBvzhloAXEpV
	 Ca6PQTJJAH2S40ual5jkHraw0ucZwABlmW2s4Ctp3IWQXKDWLx7dRZwEZYRusMCKQm
	 UKisrwFZltPioNgpc7mNzSPUiDX6CzSq/yq98FTUmProhEIqZ7FMl7cHaSEYtELwtH
	 DsQOXrasPGfkQ==
Received: by pali.im (Postfix)
	id 7FE5CC01; Thu, 12 Sep 2024 14:05:55 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] cifs: Show debug message when SFU Fifo type was detected
Date: Thu, 12 Sep 2024 14:05:45 +0200
Message-Id: <20240912120548.15877-5-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912120548.15877-1-pali@kernel.org>
References: <20240912120548.15877-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For debugging purposes it is a good idea to show detected SFU type also for
Fifo. Debug message is already print for all other special types.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d8c39989840e..70c32b40ede0 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -541,6 +541,7 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *path,
 	fattr->cf_mode &= ~S_IFMT;
 
 	if (fattr->cf_eof == 0) {
+		cifs_dbg(FYI, "Fifo\n");
 		fattr->cf_mode |= S_IFIFO;
 		fattr->cf_dtype = DT_FIFO;
 		return 0;
-- 
2.20.1


