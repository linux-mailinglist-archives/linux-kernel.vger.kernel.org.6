Return-Path: <linux-kernel+bounces-313228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D3496A215
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3708289465
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA16193436;
	Tue,  3 Sep 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H4ZFARnH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C61922F9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376639; cv=none; b=j6IWQbTZzYshVx6umcGK7yvctt64+StBF5GPzI2l59pXhPGCDsO/xBbRri2WzTyC9xw+7wEFXV0rB8zt3xZeuvOLGMdRCvD2hazt14iamEkN604epKuvdAUXNwsQkiD/PozmfvB0EsyBI6+PwisAU2imDKNb+pNyCICocWRyGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376639; c=relaxed/simple;
	bh=fapDmbcyv3OV3L5MVJ0ESyKv76DKH2gIdDF3OBkCKmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al6LiPYRUrgUbRALUZN6DgZLVYxuJmh3rOcF1lXgPbD7cyMxUkfhYRyZjkRFT59FWdGWJAZtCHeMxSGncTeNO9AxtDpcnZsVTYFTm5nHHuHh0zmMst3gEtAXLry0viXkwh2Bkq6qtnPjr5Ze6oGAh/KkyYCc3FIvH7LsRPvL5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H4ZFARnH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9BAE93FC04
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376636;
	bh=GKlPAS/yke2oPrCeB1Al+EppMQBQKIKtDOu8hv7kn/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=H4ZFARnHvMUb3znZMjPpYmHQhTNQaF7qfl89vPcE1bVCOdNWksqhpeHu979HCgLa3
	 hhTkEBfRhJ12wtq4csPXmJx1zFFXDdNGeYXoAXhthw7rFOZ4ciXrbRYElocZmloApG
	 9JDcrIKVywSuV6ZA6YegcYEjQjNTFYB7PBB2IZtWllnSq9za9YktNuGwdqR9mvHlwR
	 shhrQ8pZJNPIi9kXLlrR+z+q3FAoYUKkMpGfWF34vLWi9IkJ0LCrd/Ec3M+zWwlDcS
	 nTaQl8LQtzTdNDmR9EB6N84SFUdhywXq0Et343T9JE9gIqrXyMA4d/WZbLLGX28j6K
	 LgDvqMzIDZMpg==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53351fe4b2dso5594189e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376636; x=1725981436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKlPAS/yke2oPrCeB1Al+EppMQBQKIKtDOu8hv7kn/0=;
        b=IFhzV2YaCO+FmJ2m3oOiEjqDqgV7cW1cXKVA6l0YHrdGpyKRTcf8JK1VqAHG2qFPAR
         5C+JpliSXLh2HByoSINpauP77tLd2han2eC6dY/o7xUvoQ7sfwTvVhpUQfd5Y4iej0SG
         4wHGTX2C7njj2D7GhAIR0ypul2jg2+Hs+43GSSTZXlV2XkHZf4gUEAZ+HS4dcNpCeDUU
         wNZY+i0h4eu0nDVXHoTa85orTCJOG/xzuBZdqDBPX/XCTFrt/dmLh74LJ2MO39ydcop/
         MBbkiYW8c6sCAB0ZTjBn9AzVf6kHsHE1tI2zxgewhxY+lgReI1qenXahDnz3PYtX8d5+
         YNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpBuQntqNbWcHCn/E+ECB+FesLxoew1p01bhBqoJhnJ6A6666XQrp67g3jvfrWI5VFMfa2/roMiqUPXhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6zV1tw8Ohzp8soQbE1hK6gkFi3SB0CFsjAfPFNzES/d08024
	Qi/YfVB7ZFwrguWkB6wvv8tO0N0nU3Rh9nN2bGXL85RGUwvRcDM6IScoLPnzU9jPuc4+amq8HuM
	9Jqvvi/iFzau3SISo9lrwonE9qhTovsS1oVwB6bijUDdnekSIHY40u5jfdp/Eclrpcuih20k5jm
	hPxQ==
X-Received: by 2002:a05:6512:238a:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-53546afd6d3mr9430366e87.5.1725376635828;
        Tue, 03 Sep 2024 08:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xyi4/WNe4j3fu5EFB8IE3ilwNISUZWJq2BDcXmtXsVDh9f1cWld/tjAcEfAzJ5I9AOVJcA==
X-Received: by 2002:a05:6512:238a:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-53546afd6d3mr9430338e87.5.1725376635314;
        Tue, 03 Sep 2024 08:17:15 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:14 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/15] fs/fuse: handle idmappings properly in ->write_iter
Date: Tue,  3 Sep 2024 17:16:23 +0200
Message-Id: <20240903151626.264609-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- this commit added
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06ff4742ab08..dffc476f0bf2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1398,6 +1398,7 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
@@ -1412,7 +1413,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(&nop_mnt_idmap,
+		    setattr_should_drop_suidgid(idmap,
 						file_inode(file))) {
 			goto writethrough;
 		}
-- 
2.34.1


