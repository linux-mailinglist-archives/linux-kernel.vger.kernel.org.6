Return-Path: <linux-kernel+bounces-291113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FD955D7A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D611F21306
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AEE148856;
	Sun, 18 Aug 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CjoFcItN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B314831D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723998170; cv=none; b=qSgBpzEjMZvmWpsPr8tVDYqxKU1HVOLgBRJjB8UyhqKWHTTFvtgPQ407sxlVftnXXnSJARfMBwhQpy4bgV1203XH5JQyWwIsjYCA3OTMO4TKaQKSnse+/uYEV2bjMB9dNtjRevXe1BXTrwUAzeCU8Gz/J4UGBueQ22Nkcml2e/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723998170; c=relaxed/simple;
	bh=O0Tomsdt9hyq4ddPcU6xWCDEapUAnTnG7RN7oUVGAH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKPeiTwafRZPAAqttR+n9HBQXBYqpm3JrOjSM47hGL4l4u1UYVgKaGjo7KX2sMYbFrRLToNbwAxmGtN79dgInACvhzxeb3MN0mTQLYn1lHEkdM0JEmgvbV/cfapdCBlWsXb390LpghwaXE/JkaVCZ08iLrNSv1lnZxMUgt7LW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CjoFcItN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2967994e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723998166; x=1724602966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfuxHBlP680vgtK8qXrXclKhcPmCh6xlyBkEgzNuTQ0=;
        b=CjoFcItNKmazg98TWOM1wgZFYhaKj/kriXyMGn6PfGZxC7IyxCVhxHPTdMJATrsPkH
         xu0pFr+zvG09FrZe2pN5SPxil3+xBWT3SpkAf3Jf4nFQMFseEzaAIlExuByf/DHwz51V
         c/y4pYq21hf67EThH1ZgjeJkez3mIXR4DemliBsLUfCTnoVWwAMM38RoVT28OJ76s/RC
         XCBntIdrSsFdePlaEw2qimRrDfxDpPB2sYv+0m6OZuClvZaVu3isAKsq9sPUn12Vlh6G
         gFQGQceHG26/vGVxMUP7KKb9M8hYFm6iwuvyjRWxbQ69OaaCyPRnQ1CfnXui1eizwGw0
         1Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723998166; x=1724602966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfuxHBlP680vgtK8qXrXclKhcPmCh6xlyBkEgzNuTQ0=;
        b=urCo+jS9Xl9TuTXxc010+he8HVOCMefCUA6RQPEVdi6xKUpUH81w7h7Zsr1TaoRsNM
         eqD62tN3VD+itxBGQQXV2yItCZm1Xy0EQZRzGSY9NLqvhBp5IMLVs9lo5bVxFGMP93Gp
         b65+1PXvagHbFGWwmJJJGBoGEFCj0p5RYi2xGJy9OkTcueTADZXvc8sQk4mvdvFeiozo
         g6Y314wXH7TWmLrBUTtEhYZO2gJ5m0gyxtYBUm3HBe9vLMaz3T8bU2cWApuerjuCUIaQ
         yWg7meComvZWYPJ+gztTF3sgLgvGrRKBmuFInDpUSSPAOOg64JptAAdDsc5dXOBAS706
         BIAw==
X-Forwarded-Encrypted: i=1; AJvYcCXZQTugc5SJF+Czl/b4K2iaTyYcw0Lp7RzG5Ew58u8hszYfm8a5uhkXLcNbSRjCAnm2S1Svjje/pNAo+oIOKSD6hdY0wK2GeFVInoRM
X-Gm-Message-State: AOJu0YxiO8pUxKhvmzfvLxU6H7wNf5VQHOYR8kHJVCYHsbphpCsUXCMz
	2NNkqgj3aqx2vXjQlsiojZnwrFzoFgZFz5QgcB/9PoJiKAzFlYnq8JEcKNDMyKWhvLQSb+Q3I3z
	TNQo=
X-Google-Smtp-Source: AGHT+IG0FlrXrynRBqS7PR6AL05ABuN9aUskbcpF7J3EZEawwoUkjNpgWoDPHrN7shW4OfLVO0Umng==
X-Received: by 2002:a05:6512:4020:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-5331c6e5031mr5316218e87.51.1723998166264;
        Sun, 18 Aug 2024 09:22:46 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393457asm528231866b.117.2024.08.18.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 09:22:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ksmbd: Replace one-element arrays with flexible-array members
Date: Sun, 18 Aug 2024 18:21:37 +0200
Message-ID: <20240818162136.268325-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element arrays with flexible-array members
in the structs copychunk_ioctl_req and smb2_ea_info_req.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 fs/smb/server/smb2pdu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2df1354288e6..83667cb78fa6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4580,7 +4580,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	/* single EA entry is requested with given user.* name */
 	if (req->InputBufferLength) {
 		if (le32_to_cpu(req->InputBufferLength) <
-		    sizeof(struct smb2_ea_info_req))
+		    sizeof(struct smb2_ea_info_req) + 1)
 			return -EINVAL;
 
 		ea_req = (struct smb2_ea_info_req *)((char *)req +
@@ -8083,7 +8083,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		if (in_buf_len < sizeof(struct copychunk_ioctl_req)) {
+		if (in_buf_len < sizeof(struct copychunk_ioctl_req) + 1) {
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 3be7d5ae65a8..73aff20e22d0 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -194,7 +194,7 @@ struct copychunk_ioctl_req {
 	__le64 ResumeKey[3];
 	__le32 ChunkCount;
 	__le32 Reserved;
-	__u8 Chunks[1]; /* array of srv_copychunk */
+	__u8 Chunks[]; /* array of srv_copychunk */
 } __packed;
 
 struct srv_copychunk {
@@ -370,7 +370,7 @@ struct smb2_file_attr_tag_info {
 struct smb2_ea_info_req {
 	__le32 NextEntryOffset;
 	__u8   EaNameLength;
-	char name[1];
+	char name[];
 } __packed; /* level 15 Query */
 
 struct smb2_ea_info {
-- 
2.46.0


