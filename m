Return-Path: <linux-kernel+bounces-313231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510696A220
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1246E2822DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A886199E8D;
	Tue,  3 Sep 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HG7/5GNb"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5A1990D6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376648; cv=none; b=IgeMRi7KMkJRwnkt/eERhHuN6SdUuSRbP15mF9wjhiMh9m+iBwPB7xLy/hFLUQLyFXVxhNhmnVIzQ10jR/wcAAwBfg1J271KVmByHfEG4oYCs0OgootYSp1brSuY/xDLwYVi0C9LmMxweg8GQFazuAc91k49guHp+46cj71E4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376648; c=relaxed/simple;
	bh=I5Ej9tXxsELnQaLpNn7Un8jHm6ABGkNJE4SsL33oa8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBA8jySjhKdcp+X0apqciCw0dPKbztBQeH2p0/16q/BAABnFWyi2S2atniA9pTk80bPpd2pvJKP1WDowzDV9V5Pk/eXAx4J6NcIBZc0wU3Yz8lHk3PPyvtzc/+5pixe2DLWAgifN1Z1T2AjZV8J84lbpg2yOF+TMv51+TrAI9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HG7/5GNb; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 18A443FB55
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376645;
	bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HG7/5GNbDUmiyyRzW2SN6AoT/es/4rYyz5X5EnTFZbEKGbXE6o7QbjoFhx125lB8r
	 bJsVya2OF0F4hwMChufY16gRclm3zOaXYpRmg6Em/X7ATKCHIqbVYQxC/e1dOIRc87
	 zt3YFd6ehlrwNeLWa6kHprL3rMFkTDUKaQR48lKT80pwYWhBGikdTkElEjMK7NHjKY
	 uwuNKdDbFkuM3JAgG0d3JpMovM0bB+AwzOu3WmslxdEVapAILanKsdbRdoEnBBFejj
	 PPA2NuWszzgnbIyegRVTxdysUUoxeOQQLlP7eh0/NqvwNYPDM+fvBDUCBkNRDNeiw5
	 q0EltV9i7ORTA==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53349c739d0so1052058e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376644; x=1725981444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
        b=HYANxq+53yzKsNhKiQgBXf29WiN2TAdqX+PpK4nHsGbrACFrNldWP282LLC1SGPbhz
         vySHjHxcWVf+OQH8waM3LXGZq8x/kN6YA8MdKhSLsuDhvdCJYY41qx2bHYQzYZr+cc/P
         mHdIJA62qJx8UmLQohb13OJFUVVMrqmZoBM1pI9jV2BB5FdzDyZi9ckmlYvBAtBGbH4W
         2BBQfUCs9NPVrJMZURxftw9iLs8c0cZHZheKYWjatn3rMov8FeeA3Y51w6UKBdnS8PmW
         e7JPv+a8JsGS1KyZIdxy0yz4ILyXSIRzpQvrha+dxW9SFREnyALvlk1vUsYnanhdKvCF
         0/kA==
X-Forwarded-Encrypted: i=1; AJvYcCX6XGA/V4N3fnEDg+jrkVam9EBP54LqSNQNSwYObhm94m3dC3bC3dFF+GncuG5nvE/BInhOFGPDUAbNpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVVUgL2QV87xu9MkpKzn/95RrBNgv8A+D00UfKSFF6zfBO+EC
	b+xVCBhjwGbLPbkdbA9T1xSzjwo4NoaoRAaTDggdC7qvDyYw3EzdAN+I9H6klQRAyKNNpYrgMrQ
	T4zizqh4OFFL432Elb1TVY1Q05F5peBJfGrGuZfm5sb7DLF/I/g8xVvkzi6qAjekSjH443FH/3O
	leHQ==
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720706e87.31.1725376643656;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bq1GZV9X9d7kfysJWIp+YqAiYHgnriynd3aEYFL4ojAqTYw0oKyoeFn1hFPXtYAGSanyXw==
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720683e87.31.1725376643137;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:22 -0700 (PDT)
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
Subject: [PATCH v4 15/15] fs/fuse/virtio_fs: allow idmapped mounts
Date: Tue,  3 Sep 2024 17:16:26 +0200
Message-Id: <20240903151626.264609-16-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
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


