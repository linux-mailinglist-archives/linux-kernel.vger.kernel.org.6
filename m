Return-Path: <linux-kernel+bounces-233815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B429091BDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70261C22E50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339D158DAE;
	Fri, 28 Jun 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC0plK5w"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E3158D63
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575188; cv=none; b=h0t6vBoWv1Hcc+Ib/fwlCkZONzlLnYwIKTqowGfzK/eGeJ6JB1JzHY7YzNxEpXsfmXq+BqgGZh4R8R3mh+fsFzyqxKtdpzkP3wKrljJQ7FHBYhMsj/L80dl7ro9pKeQxjK/27H7XdOPgbcMBjDN/F8M9R+S8E8bDlu2BYwE8xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575188; c=relaxed/simple;
	bh=kXZvliVkK+p8c4vpFnhafDUylYzkJROmCl4Pfwa9a80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Er2eo8DD/4lWQ73HgNTQvJ92KS7vtmHJJ6BA713tflt+AvdO7slDdjX8QVeUcwklrvwnqR2j760M/HSCIve+b1capxC7hD6SJWnOEd1NZa57u0WZhO/kv2F+mK0fdo68ExoEddJsx2KGMk5WCzcizjQhKfVQ6yEjq382s4zJh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BC0plK5w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso4104835e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575184; x=1720179984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNmFK4pvQcIw4zFblPnZBX7k9CkJ/GPmsU3zxTOL/ZM=;
        b=BC0plK5wy+bMZ5M7QZxX+hG1wBJenqMS4xaSQLSk5EZuziQmzcQNWH6UuPMFHFKWMf
         RWiuRI5g3wM9WOF9/dkza5TRK+tsZKdqLADWLPTtZx8mGcWZ4C55EQsdCMeh7lw0b77z
         jmUshkYIdhqHPAqiHTeMo1973DOoQ8lEFBelZ/HyrNwoUag5GhSIhOFMEKaSgiVFxdzj
         zWIUvDNde2E/isjFRands/r2pYEvWi/CpC/wwUkaRFsBg/h3THzPnp1Fw/wyA72hpffS
         RBeFDADAf0CiBmkM5MUNc9TXVc1XboVjzM9kuBsiWrL2f2d0/vTWVMNncuTC03gYSGLy
         MSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575184; x=1720179984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNmFK4pvQcIw4zFblPnZBX7k9CkJ/GPmsU3zxTOL/ZM=;
        b=fFOFFDX8vj3+eogdvLsiy3Oybusb6I7HfWQozx3o2fZCJ++HykaqWFyn2hhhGz6Im7
         OpJ7HqVAuzkMI0vgxdanwJ3MX5DjdDXi1gY3QbZe8Bf2extvvB60VxGmo3p7WSdP7DA8
         hCJPSEEAdS3wcZHWqDzQRfgBBoOLS4W7x3ixIyv1kHgA6q2+FoTj0nx+CnV/GBDpExWM
         neA/ASdBZeN+O5gJn5nxcq8fIQojmilk9rKckfSPTKiXITJXlgo2K4vgVaOPYd2RcLGq
         YdZnRTU8EXcjKscB7DDpwwzcr+ql277zd5PDItUAPxkX5hD7Jbf3cKyedahvHc5KKqVr
         Okgw==
X-Gm-Message-State: AOJu0YzX+0Hmf/HiwqpQTr8pfo8ZwskzOnTwlf2q+DKnDMyYwop4LYiR
	kBqYjX1Ojwb5SMvXWZsO3P0GuMj3AuraR005j+s+GXJaSwFG0yuCxh/P8AevDiA=
X-Google-Smtp-Source: AGHT+IEMwW00lv5n9+UpT2TegQvsGdCLHhZBFtHnGVRb8dK4sf3Qm/foB9VXo773voPPdVvJwmSOWA==
X-Received: by 2002:a05:600c:a29f:b0:425:5ea6:236 with SMTP id 5b1f17b1804b1-4255ea60371mr49980105e9.28.1719575184504;
        Fri, 28 Jun 2024 04:46:24 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:23 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to privileged PD
Date: Fri, 28 Jun 2024 12:45:01 +0100
Message-Id: <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=66mOb8nUCsQyE0p1sX3pHFEKCb+HnHXXgJMDva6n2lM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9c0ruHOvc/UCsq0lfLS4sC2pklJ3nRf7pS oZ1RnIphXSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV N7RuB/9s3KAL58mhGeKvZmwEFw9ARLDI5TjcZm/9TfvF/+cmakONiwO5fR+VXS+mjtvP5liL1PP 8mNsrFSAueH4R85cItifdu3WSClT+kkjYfS73PQz2t67hJ2rgooUq9FbM4ca/FkLnWYIi42o++5 qOZiDy1MvOvyWVuhgyllLGIvEdz9Et1Cq3dbdj/DRgloAtxUyEK9ts80Cghh4lmpuFqd6VhVsEL 1HFewxgtmMqXR/4WYY1hPXa39ljEO8Ud4iDAbHRcYm5bcSywO0WBHIKaJPtv4SPD/RuUXefAdHl wO+UESYFlF0u5TykgfimjIGAg0/9buRnM34GCRaCpBP9o+mm
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Untrusted application with access to only non-secure fastrpc device
node can attach to root_pd or static PDs if it can make the respective
init request. This can cause problems as the untrusted application
can send bad requests to root_pd or static PDs. Add changes to reject
attach to privileged PDs if the request is being made using non-secure
fastrpc device node.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
 include/uapi/misc/fastrpc.h |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5680856c0fb8..a7a2bcedb37e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int is_attach_rejected(struct fastrpc_user *fl)
+{
+	/* Check if the device node is non-secure */
+	if (!fl->is_secure_dev) {
+		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
+		return -EACCES;
+	}
+	return 0;
+}
+
 static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -2099,13 +2109,19 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl, ROOT_PD);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
-		err = fastrpc_init_attach(fl, SENSORS_PD);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_attach(fl, SENSORS_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
-		err = fastrpc_init_create_static_process(fl, argp);
+		err = is_attach_rejected(fl);
+		if (!err)
+			err = fastrpc_init_create_static_process(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914d8f46..91583690bddc 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -8,11 +8,14 @@
 #define FASTRPC_IOCTL_ALLOC_DMA_BUFF	_IOWR('R', 1, struct fastrpc_alloc_dma_buf)
 #define FASTRPC_IOCTL_FREE_DMA_BUFF	_IOWR('R', 2, __u32)
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
 #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
 #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
+/* This ioctl is only supported with secure device nodes */
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
-- 
2.25.1


