Return-Path: <linux-kernel+bounces-341861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385D98873E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935A31C21B25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9A18B48E;
	Fri, 27 Sep 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6X2g85Z"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050A166F07
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447875; cv=none; b=NZ1G5pJZndQj1k8pk1C8HjB+KIaawGUZZ7wiMQKL46c5RFlL0idWg6chV3+rtv8f2bAZlYscfkmw1vKr+gxyspCdOomGKWNqqb3Ulpts8mvj7xSAGI+pZ9VLdvjjuxn1mU5PXySJEEsmstuT3Jaj95mG+kPIUR5KFRxfxcmmS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447875; c=relaxed/simple;
	bh=CPONilJn9p7dDnQ9tE2fV1Gl586yuq9bdUBsCDhdyOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEUtK2Js0nKnX7ia3BOf4zrM5M66z+SyiG2XScabePaVENQPfqgQrhUpmg18OK1/JFTtYysqe0nphn09F3oy/8p+s3b5SQQSMChDGjrs7AyRifJonBgddjkiGir+thTMDsmpZ75H+k9BET7EIcPSEzFiwAAFR5OTSmiIT9bbkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6X2g85Z; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727447870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/+oZiPdJEZEoqA+czkrBdMMUvfRrzlg5IyCe2/VTuBs=;
	b=Y6X2g85ZAbjieSzY5Nyw6Y093bT47aK0CS5KTQsinvUPiYThFpIQ7q7Z246KPIQ1lqhe5v
	ptsU/hGkq18oboHBt9Zxl5f5zo4vT0qJ6Z7NEjCvFDxDgSs09JF4l86phnEKAfIcOebLn/
	vnMyyer9Upw2jdqSVF5y/cvoHYpW0AQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: Use struct_size() to improve get_file_alternate_info()
Date: Fri, 27 Sep 2024 16:36:42 +0200
Message-ID: <20240927143642.2086-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the output buffer length.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7121266daa02..b45e5b9ad967 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4887,7 +4887,7 @@ static void get_file_alternate_info(struct ksmbd_work *work,
 	spin_unlock(&dentry->d_lock);
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =
-		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
+		cpu_to_le32(struct_size(file_info, FileName, conv_len));
 }
 
 static int get_file_stream_info(struct ksmbd_work *work,
-- 
2.46.1


