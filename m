Return-Path: <linux-kernel+bounces-303348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C9960B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BFE284587
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8C1BF810;
	Tue, 27 Aug 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JgL/ulg/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140C19CCE7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762959; cv=none; b=gKKMsbz2PtCpiQ0vf4Wefm/crGlARmO57NysUcaxyvSYnlwxMv95FaeEfZrKvBW9Tkhl/cDYT0efmwDlF2ph+v5Eumjf/7vJmL+gs340CjRsv/5n4OtQfy2lND8ENE9/6FBfKJQDHpbWUlzIQYBM0cM0beXVtwI/pfhGMtqEDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762959; c=relaxed/simple;
	bh=wscF2ITDjL+zA0jES7wvT52POg2jmCcdiSKrj3iQL20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRq0Sk9svHzGt3WzFjKiK9YnwCwGzQV+RmW3OEBp3HktXDSaTMg778FyxU3cxEPTbjyWVmt1wBrZ+7dtpXMkkgUM56+kcegmemdPQYZXyzkgvv3kyrOy6Ugr82TcQpL2jcJC9AaCtVvE6Hb1KkdslDjF4q/bhgpbROCeVxJ6sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JgL/ulg/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281ddd3ae8so3628725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724762956; x=1725367756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7tHPmr1c4+0oZPwNoAX8qZLaMbelgh9RbQRLc/3HQo=;
        b=JgL/ulg/2Z2Mj2WEr+h+Wz37L/IJdeSH5F+gfayj1E9o+9nnAnu2mm2qkJvxzhFeKn
         w14SAHwowv0zBNN2wAHuLSMTXnHc6j7kNdK77SZ20/RQR11xohOiPV4agD+M4HnCEUiz
         qFVLHguerMHYQJv1hzA+kBEP/KYjgs/u4Q29ckrgxXCCF4059prR/oxzkc1kPBu6+0G4
         qR3cDjiA8Yib3YSxxJYKCt2wNiZxSMF9acHwMow3YbPtYaSr6STb2PnOYn9jELphGpoC
         vwTvr2gUdtVea+9NUh6yhA2upFlVWNnE15tmMZMH9ZZHq0YjnurbC9J773rzU2CPIwxa
         2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762956; x=1725367756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7tHPmr1c4+0oZPwNoAX8qZLaMbelgh9RbQRLc/3HQo=;
        b=h1Oshlq9i896pr9T9z8C3xGnr1G5XMv5we2oyueAbA2EkYCAXeQTr3Sak5lR5vZ0R1
         JgSoBtv4El0L07gKjLMBVy+3EBj9b7Y/mpZAMvltc7nogqBE0tXbR1iVoKGU6kwUGO/G
         iHRbm5l++xgTarVExqAdl/C7B3AwnLvl9a8n8h47HiJ0j0ykmzHJgqZxNfZHRs38d4dj
         tCi6lXLjk5KCtpepOhX8DtWyBhD99uypneUXFbyDPhkTWTlGU8uVPHk3Zc+djjBp/1jI
         lJ2cW1V3IdoH2tz1xhKLt2McYB5n0Z7gHQ8VuVgQsS4vJPMVhiOVx7tB2maZ8sejzF/K
         rFuA==
X-Forwarded-Encrypted: i=1; AJvYcCXdoyqDPgEPbZeWfNyk5JdpPH14u76crPxvGqmFgR/YFCrw0IE4+9VjvBsIO6FtR4kvZ55dgcB2LvI4Ufk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpUo6j37rF8FksIuieLMYthoqPzpHGIzMgRW07KpKVorGu9ZA
	c/xvoae/bFiOGx+1H5RqrL//4je311xmSYL8RtAiAaSkdCSljPRTGAGL3vo1BvVTo14YbdwBNGE
	T
X-Google-Smtp-Source: AGHT+IH/VZhYdTzKRXtBrAVvHca6e6ly//DPo9FBNebV2MpbS/nxnzOZskjXpyL/QDH+VENRiMxe/Q==
X-Received: by 2002:a05:600c:3c99:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-42acc8dd868mr60882815e9.2.1724762955347;
        Tue, 27 Aug 2024 05:49:15 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm184042295e9.26.2024.08.27.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:49:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dsterba@suse.com,
	gustavoars@kernel.org,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] affs: Replace one-element array with flexible-array member
Date: Tue, 27 Aug 2024 14:48:40 +0200
Message-ID: <20240827124839.81288-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element array with a modern flexible-array
member in the struct affs_root_head.

Add a comment that most struct members are not used, but kept as
documentation.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/affs/amigaffs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 1b973a669d23..da3217ab6adb 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -49,12 +49,13 @@ struct affs_short_date {
 
 struct affs_root_head {
 	__be32 ptype;
+	/* The following fields are not used, but kept as documentation. */
 	__be32 spare1;
 	__be32 spare2;
 	__be32 hash_size;
 	__be32 spare3;
 	__be32 checksum;
-	__be32 hashtable[1];
+	__be32 hashtable[];
 };
 
 struct affs_root_tail {
-- 
2.46.0


