Return-Path: <linux-kernel+bounces-362671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28099B7E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C131F232C3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D91BC59;
	Sun, 13 Oct 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="25THL1yR"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A517BB4
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728782216; cv=none; b=Uk7dRhPgcWBz5K+OLAbTKOOsUdxxZCHw3zZ1qUrXKQMl90WMvrlpVpXoV+u+NXLGANWqHBYgnpV1ziSOyDmBacquXrm/oMcqX8oyOoO1zbRY1hsOA7fhilqLkT3EpjPolq8vrkl5k11jeDmuT4QXdFmUApBKnxxkN/Vu5UAhuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728782216; c=relaxed/simple;
	bh=2sx8Aw6pIh8BauKe7Gm9fE8e+XUDKbHips1LWbTjVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHch1Dk8ZqLB1Iq+B5y474wdhVM/hIDc+vdYdbXLQnDeflCn4kGRAainqamJ7kwXhGGMkuI4EhuwHKYKBQ7/d6WuvwHl8vtjCf5pPm5qCir91OF3wWDcljqEeZ6noOqJQGtt9kOL32gEBfqHYHgcMYa0CAEnml8MP06kkStEYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=25THL1yR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b10e800ba9so342533885a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1728782214; x=1729387014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FczsRXQewBGMsuxwAbQk/uMMw3IO/+eAK2xjysAOQc8=;
        b=25THL1yROoeRQQuYYCfH03Az3OjLBetDXCj7TsNpdK21VvZyHFW7O95gI7xVwDqFO9
         mO+blOBKELPNvB5X8CCa0Ib14WVv3wpRA3wszCNmfZklxCWru1Lew/Q4ljPPKjcEUsJl
         M/yJVfbR4956aQ65kJXt/Eocg55usTCTGgl70p39ckQiaNv48o9yrZpUZ2iXqHJpHP3g
         OcBi6vUb3UgoGdw+0POjGGfXOeuhfxgZGCb0JFN/yKXyvdhusAHNJIkFkpVWzYRIja32
         /JnsIA6OkEpv/hDePd1/ppgVb57v21r45ChlvkQWEBaxfaXeHFcam4pu0G/ktdQvyoLL
         po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728782214; x=1729387014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FczsRXQewBGMsuxwAbQk/uMMw3IO/+eAK2xjysAOQc8=;
        b=sBTZs7v4B067MqGIHjpFsqx8nVcjhPXCWs+h8LzIxDgyNgvRHFcJ9WQRFI9bx9fOd4
         rBpwdSaOQ/kct4RZlEgG/ditL4pCn0s9YtOewfEbyPA4Cuo/suPOSnmWmQ6MsonDilO2
         Y/3dPi6xOdrGNECdlVEj5VdtksWIYObTshx0LtN+bl/ol4RcFTzwE+8/lSOywOksxAGu
         yZp3esaGLJpcIYIbYUZKpPFChDDDQfJ2hFa6PaRdw56DY3MB4djFKNxIzpl+9kF9pNoN
         +ziRx1+cS208lnFxKsEIM1Zmldy4fc1xhXDcVDZ4t9H677DVmKGBgXsmc/bnQt24ujhl
         tEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF6bLYuoGX3X2K6y9AaxWXrfdxZxHKaeIj986aEI01xgYH/2t+FwYZpP4NvUac8yIm6AurhWrb7SUFggw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDe3uvY5mNJnskMh9zdDn3loGxT7M3cmFIOjoA/tP2buVYEtYG
	oAzKnNe478Y76nWsGjO3oZZLuUHa+t7Bmv3NWzs6m8sGjA1Vx3zbvp8Q0Osp+g==
X-Google-Smtp-Source: AGHT+IFzJtdCpPt8gfauojT4qt1RdyycnhiGIqNfQVHwxZ4FOjVEAEgQ5B9FCZU701pVGClVH6p44g==
X-Received: by 2002:a05:620a:2a06:b0:7a9:ba35:1863 with SMTP id af79cd13be357-7b11a379e26mr1144462185a.13.1728782214153;
        Sat, 12 Oct 2024 18:16:54 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497704dsm273414185a.101.2024.10.12.18.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:16:53 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ceph: extract entity name from device id
Date: Sat, 12 Oct 2024 21:16:39 -0400
Message-ID: <20241013011642.555987-4-batrick@batbytes.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013011642.555987-1-batrick@batbytes.com>
References: <20241013011642.555987-1-batrick@batbytes.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

Previously, the "name" in the new device syntax "<name>@<fsid>.<fsname>" was
ignored because (presumably) tests were done using mount.ceph which also passed
the entity name using "-o name=foo". If mounting is done without the mount.ceph
helper, the new device id syntax fails to set the name properly.

Resolves: https://tracker.ceph.com/issues/68516
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
---
 fs/ceph/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 42bdbe5b7ef9..de03cd6eb86e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -285,7 +285,9 @@ static int ceph_parse_new_source(const char *dev_name, const char *dev_name_end,
 	size_t len;
 	struct ceph_fsid fsid;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
+	struct ceph_options *opts = pctx->copts;
 	struct ceph_mount_options *fsopt = pctx->opts;
+	const char *name_start = dev_name;
 	const char *fsid_start, *fs_name_start;
 
 	if (*dev_name_end != '=') {
@@ -296,8 +298,14 @@ static int ceph_parse_new_source(const char *dev_name, const char *dev_name_end,
 	fsid_start = strchr(dev_name, '@');
 	if (!fsid_start)
 		return invalfc(fc, "missing cluster fsid");
-	++fsid_start; /* start of cluster fsid */
+	len = fsid_start - name_start;
+	kfree(opts->name);
+	opts->name = kstrndup(name_start, len, GFP_KERNEL);
+	if (!opts->name)
+		return -ENOMEM;
+	dout("using %s entity name", opts->name);
 
+	++fsid_start; /* start of cluster fsid */
 	fs_name_start = strchr(fsid_start, '.');
 	if (!fs_name_start)
 		return invalfc(fc, "missing file system name");
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


