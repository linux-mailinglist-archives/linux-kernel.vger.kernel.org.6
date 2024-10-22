Return-Path: <linux-kernel+bounces-376682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A48D9AB4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F71A1C2275D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84B1BD01D;
	Tue, 22 Oct 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1kmPONG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF98256D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617460; cv=none; b=jOk9t8jciyGtRH2A5QD/4Zf3sJ7/lLHVxn71eFpJyjnSvVrWR3nLSs6ek7DgZU6H2p0sYQ5d7jLjkqOhOemsovkDN5Ej2HDST0W9SO+YXHwcX2ggqHssMieobLv0N61qGxwHtcUYe0I7Bh8vpVwm33k6fs8AXuk8OLWNll+JO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617460; c=relaxed/simple;
	bh=4f40dfBoHxEpPr6RULcDzDS5/7/zM+/MBm/SCblIAUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOc5XSSFzMx9Denh5YfQMaSV3YdXSL+IBDFEJDC0ORqiXlpGYGFp1WWULFy99D6kR+F4W/UQrPHFxdK1f/mqmKC/03gOExw4TeXgsnJUt/tySLrvzFkIKxqQy+gjOm7KeiXrifwfRjktkdznNzZhaZUbSZbY9k8MWK3siPpt51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1kmPONG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4244984f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729617455; x=1730222255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnlqVZ4BO/KcWRbWj4X5jgmlgSPyqQsEw0oozV3PjCg=;
        b=Q1kmPONGUltIFv5UnUQSPTJGSMqyWAEQXqocG5vXrPPdK3IR3u94L8cerM1wILwHds
         0X3NcrdMvFY2JShFYBrh0fwVNX10ZuPYF/y30Xpy6fwJgfPnTaj6xdigYPUONqnICTf/
         Gmml5DoTninZ/irJTm1vyq/mrICSx0RDrcsDIiYeyFjvOjB1Mbaz9n7p/gRJvcpbYIL6
         0FVoQl1F5zVbLyjdGbN7Yhf8Gxolq6vaTVQwn0SoDabCN1FygKhu9unPk+dxmF5jeD2G
         LAc8PSpSbH281M6QsyJT5c2sZRZfOAQiTAwmKQ113EWosoQvtWWEpA8NYj4vybrHCEbN
         opoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617455; x=1730222255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnlqVZ4BO/KcWRbWj4X5jgmlgSPyqQsEw0oozV3PjCg=;
        b=pLpe7difvqo81aSO//f/Z5oOCbnjq2FlqALulZJ/+HYrtm3QG/+6CorajyEvSiX3Df
         kfnKWjw6EL+hPYTWNyQ91DkQxbegoz5MpT5GAbx8bnsDFCzav2xyCRLUrHxdurMWojbx
         Wal9vhQWMMHdQ6lttQASNbyEbgFOdXp65SwwIS4sv/b/PJu20BcM17WdrS4w4Nts7N+A
         M9LqytS07RBzKsG//kXYRjNeA4mJ1NtkDToxtdM54XvAkN6DNSOup85FmVm+1tSjz58S
         JNfMWpDH4JmbNbEUULJM3bYodEXK9AX7f1aT5IHEbP3mVdNTSt1sOMYXrriUlmLnnj2T
         sCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyFkTQo1uEEgkE4eANH/MXQ/X4YkxGdW55Lb0i0Ma605sPzJ7E8jH3uIyzdWcVfrT9jedm/q43GiMfbz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLxZbgk+rIS7KcGE/WT5N2N/2UM0I7fWlgqPLvaB2Qi9/dRoV
	U9kItuECHl2VYXSbN6UgBp4vVhbVGbxgvAOezhWoneEETn/AF9n2Mz0RpPVYcx4=
X-Google-Smtp-Source: AGHT+IFPUocm/4nviahA9kVMkkKDFQ5l6iajdVlX1sr2xtvR0ubt2qGXvimvsdW1+ViSPBkb4GzA0Q==
X-Received: by 2002:adf:fa45:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-37ef0c05405mr2619872f8f.58.1729617455376;
        Tue, 22 Oct 2024 10:17:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc02:9a54:2a00:afff:fe18:d85c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407f4asm4944538b3a.207.2024.10.22.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:17:34 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: markus.elfring@web.de
Cc: bharathsm@microsoft.com,
	kernel-janitors@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	make24@iscas.ac.cn,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	samba-technical@lists.samba.org,
	sfrench@samba.org,
	sprasad@microsoft.com,
	tom@talpey.com,
	ematsumiya@suse.de,
	Henrique Carvalho <henrique.carvalho@suse.com>
Subject: [PATCH v2] fs_context.c: smb3_reconfigure: Handle kstrdup failures for passwords
Date: Tue, 22 Oct 2024 14:15:15 -0300
Message-ID: <20241022171515.3330183-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <5fecc08a-c3b7-4745-abc9-0f5b4de03c22@web.de>
References: <5fecc08a-c3b7-4745-abc9-0f5b4de03c22@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smb3_reconfigure(), after duplicating ctx->password and
ctx->password2 with kstrdup(), we need to check for allocation
failures.

If ses->password allocation fails, return -ENOMEM.
If ses->password2 allocation fails, free ses->password, set it
to NULL, and return -ENOMEM.

Fixes: c1eb537bf456 ("cifs: allow changing password during remount")
Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
V1 -> V2: Decoupled checks for ses->password and ses->password2. Ensured
ses->password is freed and set to NULL if ses->password2 allocation
fails. Corrected return value. Improved commit message.

 fs/smb/client/fs_context.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 28c4e576d460a..5c5a52019efad 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -920,8 +920,15 @@ static int smb3_reconfigure(struct fs_context *fc)
 	else  {
 		kfree_sensitive(ses->password);
 		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+		if (!ses->password)
+			return -ENOMEM;
 		kfree_sensitive(ses->password2);
 		ses->password2 = kstrdup(ctx->password2, GFP_KERNEL);
+		if (!ses->password2) {
+			kfree_sensitive(ses->password);
+			ses->password = NULL;
+			return -ENOMEM;
+		}
 	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
-- 
2.46.0


