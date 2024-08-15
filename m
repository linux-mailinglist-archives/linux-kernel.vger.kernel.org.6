Return-Path: <linux-kernel+bounces-287750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67638952C29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412B4281EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C621C184;
	Thu, 15 Aug 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ORm2gGoD"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3D2101B2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713915; cv=none; b=CYGeW79z/BjFyE3S27atJ9xjcfdcdSrZ0dWIw2zulZqAUHtnU67BFUUzEg5rFwRzgnO0QcfTgpSKyi1eABt8Y9lwNxeZBvU9S5e8cCZWMifF3QrbMwhrX5tyYA0UpoE3p44+rS4bhcAQ6p2XYK4xRDP3tsSGypVlS3DtxdxMLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713915; c=relaxed/simple;
	bh=ymy9AdLU4FnRhhiUnMjD0ZbEgyL+Q2k8uHDQ8UA+HNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdzEqN2tjqZ4Rd83ppMkIxAvPFLltu84WcbqtL6J7hZHsfGE1qKRHX1tbdoU5i43bczASw8MjGalk7SiFK7rxokrt6SWO6mQv26Y0P9odCRDeGVYJBHrl9Dhyveo4/aqwnw+sYG9wTV0tIJYCmUp7i8aOZTgsOs0Cw/sCf2Q63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ORm2gGoD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F64B3F1ED
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713912;
	bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ORm2gGoDL4V40CyxZRLO/AO48sGW16oz+oWNDdjw8iC/FvkJZsYU3eLZRNUOPUcoX
	 mNB5dXFMwjDWEb6Wkp7Nkb4cn+CkkExSjoZ5iOkNN/oApNI9B1EhxiKX5EjVGdrUCm
	 j4ON28VAam68el/G82rUir6fYK6RX6IgVTVz24W0LF5tg7Ntgkt6WLkWR42uu+2xyF
	 5rgbpd6YQwdk3x4ZZKQsf1XgOTxvyfv0l+20wMNx+8nS7IHg4KpqhQrpXFtd7d/ZQW
	 HhG/KGYLy42ia5VluUyPnWnbo1492Wo48Nw6+UsQ2ddNYxID26CMXauBcZpeenRwvZ
	 Z/OZIvz+/0G3w==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52f00bde210so875284e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713912; x=1724318712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
        b=s2GijNG2Kw0m4bkgeogC6EpXc5rXT/6v/AQeT2rdeKFYngwZ4IyWZP2Qq2HrhcL4Ri
         Q1KPEIVf+y+bbEDfBmefq7PdiQYvjaX5L5NUpcb8XcFRikjuRv09S0SB8WRFE6M0GaM8
         8mpb8dNUs8icS4XjOF/WC239r1/4BviRhQ3h3gHJdLDbKiSm9WjIOzYBOmd5l75cnS1R
         LEwLiMdcntjxOwOdWiwENBwnp0tgYQWZIWwsu6YMKqV+IG5Pc+J4qbhxTW0gM/WUfO8b
         3C8a7fcn8F0PVp2yyD5CGnF6NLijVviMyOY3PzySFmvL05SFb3lZFXZO6D+BtJES5R1i
         xqrA==
X-Forwarded-Encrypted: i=1; AJvYcCVAN/jWjvKfdzG3DUM5sGHB3vXRS/6Gu2g8mCoVd3jpJV5mvjN0jvuQ/abbFp5mRRLKouCX3xa2Ge9TbRpXR1OpilO199aeSPWCMkri
X-Gm-Message-State: AOJu0YyZcUugDuMpc9AkS9ikPhFzNrSj1NpWdnUb2fzySRbbpHc+/2lA
	iqYwXcXeo01m4p/D3vXPm5SSKflpQiEVKfv4H5fdYtuZ8F7ykAnazX4XxXBS6f2U2JVwKR3kSoG
	5PWhdVy7IkB7TGnLKlFYYdhSpgGTzzQWiotsRUDBGvMxwikR6RqOEiqOHZ2FxjQT4P1JCgHZ9YY
	2CqA==
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498326e87.41.1723713911623;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXVHcom9bqqi9GSeZiOw88lrHGMwV+yLO4NjQtn8iMbKuCv4yuzR2v2cJk7x7ywlGr+9KTSQ==
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498304e87.41.1723713911159;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:10 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 11/11] fs/fuse/virtio_fs: allow idmapped mounts
Date: Thu, 15 Aug 2024 11:24:28 +0200
Message-Id: <20240815092429.103356-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow idmapped mounts for virtiofs.
It's absolutely safe as for virtiofs we have the same
feature negotiation mechanism as for classical fuse
filesystems. This does not affect any existing
setups anyhow.

virtiofsd support:
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v3:
	- this commit added
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd5260141615..7e5bbaef6f76 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1628,6 +1628,7 @@ static struct file_system_type virtio_fs_type = {
 	.name		= "virtiofs",
 	.init_fs_context = virtio_fs_init_fs_context,
 	.kill_sb	= virtio_kill_sb,
+	.fs_flags	= FS_ALLOW_IDMAP,
 };
 
 static int virtio_fs_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
-- 
2.34.1


