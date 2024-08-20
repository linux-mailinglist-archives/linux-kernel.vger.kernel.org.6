Return-Path: <linux-kernel+bounces-294505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD758958E80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903002850DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB389158861;
	Tue, 20 Aug 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NcZfKhZG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AD149C4F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181347; cv=none; b=iiy0KqHhoraGHqNFKpat0iEXdEXOZbjrzgyqh7PGgjFqsPr80GsGe5QV3ja1hqCV70ce3aKRob1xVlHtNyVEMQYYOvewQclPlnJimUsQHDS19xiipy9eqp0zSG1jiBWNGhvK0TGldW+p1V5ToK2WQdWGjMzhVKTGVlV7uU5Re4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181347; c=relaxed/simple;
	bh=gdKL8hbRWI11L5b7LSvICFyHTy6FHtXPGWdK6MGtlUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mzwdnu/qqLQowSN+U9Zoq8LEn6ufleOoJKGUBPOuSG7G6HSVEDd7W+3fYi0WzilSMzeEQRC6hlQbnuaZEnqE9yzpprASVp4e5+BbDsq0EucoDmGD4ps3A0KnkFXUhGKs8PMfpI8N4HzMx4nZZBDwqkUb6nNIn+BdhJFuI/EzSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NcZfKhZG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a864097e295so20966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724181342; x=1724786142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZbe635+5O6t2X6kZNkR4Ab+v58TafrMI9+NKXhKq1I=;
        b=NcZfKhZGkEUxVOB2EL3nD0VrbX2nH6OaRmlymJ7bXvqT3AKq8M9SPSJu04fIBbKF/w
         ChC13rjqiC+J+PnhISztH905TBvIaDCkld5aHCAWbz6hJtXf4Gfvew8j439PcA6swcaQ
         J3ZbyjaQ/ydb/yH1lQb0YOHgmkVuqmTo+queU66IXHL3wazaZCpdAu4vTiQRC7S3rz5P
         YRsfncbb4fE8l2rKqM18u0pVYJtCzRZHbtiGUpZHX6NjkybzVQU3OUyGbB7wZqn56PCG
         1P1oTYCa69C/WiFbtsYeYlDJ2STztVJS2ZWewfrVYyeKy3+d2LZd/PV6ARyyl83OQjqA
         WGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724181342; x=1724786142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZbe635+5O6t2X6kZNkR4Ab+v58TafrMI9+NKXhKq1I=;
        b=ZlHxpmNdA5K702BOKaOCAJt/RRVYwAY0MBmsE0DHWEt3iGSUTVJqESCqgnrZHU0SEy
         YLb/+Iod+2l7Gmi2WpP5f1Lg+eShtI8EbSe+7cmewfWrA7kp8loII538tIUxTgCO5Nqk
         N7T0/DhM7qbVHWF/4jv9BNORKahagDliUTEX1sC0ViNk5zKkkNy9OqLo1kc8FGGlK1KK
         PqEbV2M/W7XMymytEmUA0UkTBqE6dTf51s4iKwdwJegjGZpo3ZbOIOO5rqzztGq0jLHE
         4BPqUPKSvOQteK6y/Ic9humeRgvqvb5KP2VFfUsO3QbXicufbV+U1ewGt1p45Nd1QBqb
         MIcw==
X-Forwarded-Encrypted: i=1; AJvYcCUW2BKRAfnVw2V9q2vxDBeEgN5H11OYSRipSmQaWwtcc0C3iTJL8SMNN2LEKOBWB6Alq86dYzh9dc6M0ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXp+axdhpVpTgwzjGaVOkMDIrFzim99q2QIqwSdFOQCJ6dZstU
	amBoBHck8VBhj5fPRIK6Dn0hnD51AzYQ43LR5nOMLC7uKGV5hlevP5FbmS03XYc=
X-Google-Smtp-Source: AGHT+IEfNBlN7j/ZZXnC85gBPpe+sd4HA09pzaHJJjJEGHP0iun34guDmKV7WceryENzMCN0UCScrw==
X-Received: by 2002:a17:907:7e95:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a8392a85064mr587013666b.9.1724181342049;
        Tue, 20 Aug 2024 12:15:42 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm796341466b.59.2024.08.20.12.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:15:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] ksmbd: Replace one-element arrays with flexible-array members
Date: Tue, 20 Aug 2024 21:15:20 +0200
Message-ID: <20240820191520.100224-2-thorsten.blum@toblux.com>
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
Changes in v2:
- Use <= instead of < and +1 as suggested by Namjae Jeon and Tom Talpey
- Link to v1: https://lore.kernel.org/linux-kernel/20240818162136.268325-2-thorsten.blum@toblux.com/
---
 fs/smb/server/smb2pdu.c | 4 ++--
 fs/smb/server/smb2pdu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2df1354288e6..2c0731a2751f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4579,7 +4579,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	path = &fp->filp->f_path;
 	/* single EA entry is requested with given user.* name */
 	if (req->InputBufferLength) {
-		if (le32_to_cpu(req->InputBufferLength) <
+		if (le32_to_cpu(req->InputBufferLength) <=
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
@@ -8083,7 +8083,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		if (in_buf_len < sizeof(struct copychunk_ioctl_req)) {
+		if (in_buf_len <= sizeof(struct copychunk_ioctl_req)) {
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


