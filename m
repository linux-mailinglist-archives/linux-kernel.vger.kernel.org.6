Return-Path: <linux-kernel+bounces-290152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4195500A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A4F1F2293F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E11C378B;
	Fri, 16 Aug 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QiRIvu3d"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178B1C2328
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829692; cv=none; b=GCzXclHdi1GW/gJ0zgO2w5luGSgEc9gCWMk+slzlyIk4cqsmuTFhcLPMFuHjFru3TSDNn9OSBjXwP4wB24NCiHNEDBq2GCyQjfaL+ebbvMCmx3jgMhHD/6u48DOszm5Wu2jTCuq91BzLG83aC6yc0AI8XTN1qQxLW7ilserZ7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829692; c=relaxed/simple;
	bh=ED8DTCbEuJGR/Qrj7G35OmNMRR6zwgFllY5EeapZTSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+3w+9cr7CdOgFbk8uKInGTbikZR88UWbbZqbO24qBlSbT6XnLUptwavGya4n5cW+FyD1duRUHRmwYdo+qpTTDySD+4qNxGPsLJ4x2b5jnotED77h6Kigm/dgeE29xg6MNX4E24DhEKHEDJdlW6oavLua0l/4lm0Z+9WBqoYJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QiRIvu3d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3717de33d58so1290039f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723829689; x=1724434489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LH9zkbruVaTK2T8VrF+INwjApVFGd69kX5TNyUTdefo=;
        b=QiRIvu3dlDAwXQC6o5yBk8QxvjlMU4oyrjyfkqDzuOp5aBhWIgvQ6S/hunQuQCEFqV
         1pJxCfcMT8WoKiJaSWpS1clSkqiD/aAcxqeVh+AiS7IMGTrEIzEp1A5AdamNuoz50j6+
         QXCeXMQkUwaANZ/5vS0xUhs3DKlx9hVj7q+MTsa0QhpRmNRv/yJPtDrhZDtqHKSlltX6
         XVgicbsSYXAb1QL0Ut8WWRwKgQvIhVCShlzmIKKSgVGdKL6nNZoBZhLD50mg9rEAC/dB
         v7kXRZqmoyTEh/JegQtTeaauz1utVhxrmTSBDC0ZvzQfv75GcehZ9RmqOI3BmlWJ+9jB
         G/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723829689; x=1724434489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LH9zkbruVaTK2T8VrF+INwjApVFGd69kX5TNyUTdefo=;
        b=bQZ93sJeF8dsrIM6C60u1DloQHjQjZpAoNfmGKOHn3rsWD7FZfZwPuo1/JItKpeBzv
         pc7tBTMkC6ssOaQrBj817o4YnjHAv99xLJaAssVMraeqX1VwEjhT1uRk6L4iDUII0Ooz
         9QrMANPO7QK/fVpLaFu/u3CFdeRMKNV7IYSKnzNht1nvdRj4kVmRKXa+LEItihaQefXI
         pniDzENErHPpk9MnBbuor9rqa8r3pO7Jb8a91rPvYePIGZepSqfIS7B1B6IM5hWaqbN+
         eQwiGu0lUw9F3KuheDCMocFb3ljVVDNF1pqMDJwXxdWpJL7B3rFuAIUt3yJX2zmf7Jl3
         KnkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPkD0c0lC861TVCTEp8tEP574K8YeRQozVnySPSSQx9bKfcF8nsvdqwPsUCaD4ieM1dar2KsrecxhepmzJY3KZ7R93XGZ/mPoYufng
X-Gm-Message-State: AOJu0YwHckdRrQiQC5UfknvXwm4cv7CsCjtqcQBY+XdpMrXx7SoRSiCY
	oKw58X2Tx9AHvUqQjg+SWehLkM5W/oMxkGvbHFvYtkXMP4mU3rumWK4jTxOmfg0=
X-Google-Smtp-Source: AGHT+IGN42EAJKGBhdo/IeZPjK3jFArcaSeanEHDDGTyTD5dIAoLpRaJvaU+vPeGoLsfplwhRUt/hg==
X-Received: by 2002:adf:9bd9:0:b0:368:4b61:7197 with SMTP id ffacd0b85a97d-37194453122mr1995338f8f.24.1723829689066;
        Fri, 16 Aug 2024 10:34:49 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac074sm4031492f8f.106.2024.08.16.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:34:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: gustavo@embeddedor.com,
	linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] ksmbd: Replace one-element arrays with flexible-array members
Date: Fri, 16 Aug 2024 19:33:39 +0200
Message-ID: <20240816173338.151113-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element arrays with flexible-array members
in the structs filesystem_attribute_info and filesystem_device_info.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Take struct size changes into account and do not subtract 2 additional
  bytes after feedback from Gustavo A. R. Silva
- Compare the binaries before and after the conversion and add a note
  that there are no differences
- Link to v1: https://lore.kernel.org/linux-kernel/20240816135823.87543-1-thorsten.blum@toblux.com/
---
 fs/smb/server/smb2pdu.c    | 4 ++--
 fs/smb/server/smb_common.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2df1354288e6..1ce747b4636b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5357,7 +5357,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 					"NTFS", PATH_MAX, conn->local_nls, 0);
 		len = len * 2;
 		info->FileSystemNameLen = cpu_to_le32(len);
-		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
+		sz = sizeof(struct filesystem_attribute_info) + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
 		break;
 	}
@@ -5383,7 +5383,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		len = len * 2;
 		info->VolumeLabelSize = cpu_to_le32(len);
 		info->Reserved = 0;
-		sz = sizeof(struct filesystem_vol_info) - 2 + len;
+		sz = sizeof(struct filesystem_vol_info) + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
 		break;
 	}
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 4a3148b0167f..cc1d6dfe29d5 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -213,7 +213,7 @@ struct filesystem_attribute_info {
 	__le32 Attributes;
 	__le32 MaxPathNameComponentLength;
 	__le32 FileSystemNameLen;
-	__le16 FileSystemName[1]; /* do not have to save this - get subset? */
+	__le16 FileSystemName[]; /* do not have to save this - get subset? */
 } __packed;
 
 struct filesystem_device_info {
@@ -226,7 +226,7 @@ struct filesystem_vol_info {
 	__le32 SerialNumber;
 	__le32 VolumeLabelSize;
 	__le16 Reserved;
-	__le16 VolumeLabel[1];
+	__le16 VolumeLabel[];
 } __packed;
 
 struct filesystem_info {
-- 
2.46.0


