Return-Path: <linux-kernel+bounces-554009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30088A591CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F7F3ADBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93859229B13;
	Mon, 10 Mar 2025 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOoo+PAd"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CB228CAD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603688; cv=none; b=sw4mwdVXBTSMDcQo9rwL0/n6SfWhpF26KRIWt9IVtuKDb+vABbpvwP7C6T2FYO0WsPrwdYFB/bSX9bfkg1VoczALq3KJgdspSnS6jv3/MAdGXom/kxSxwem2sIls6ksHO6A0j90LpUoLeyqn+GjUbjRQOxcXB+GaXZ2H5qN3YnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603688; c=relaxed/simple;
	bh=ezePfKdiVomBp6Nu0vENgcyh212zJvF8/6B93fEyRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UukCt8KoNVXRnkZLg4aSo3N+hNeUBOsTf+erO9OsFeghPjterSgZHc4oajQiMGH/lUKfHDiYKVabl2oIWpuvyXUTxctgUGJtwzcPqi1O1FJzLqSlQuN0BCLl61hw0tTfGf2i80IMlvoHTmL2zj0fW9GES/lZf0lMZdGzEanyga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOoo+PAd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1041017f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603685; x=1742208485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0yircpCo/QVU3P+N7sKYScgPv6naVVovFtBRlbgD6Q=;
        b=KOoo+PAdvWYa2/1thUQHnSVgyLB9AJq2/pBagS62WEQkqE7IVuCiv4oq+dkl22iDX9
         Dqd99AM0bMNsRTor0H0T8NRVN2GcUQuyrCLn/hSYA0xonlbIfcMd2ImWaerXjycmVa/u
         nlm+jRvOdmwq9/CUL3Fa7IqV6gF1Bf50eDLVciP71+y3Sl2IMXD6ad24eOJ2g4gENxtW
         KPyk5BQ+UUNKj+hhKy4OAva20BdiDQvvZ9UZGLXa4WJIElgEyGcZY6lQdshSCTNAYNKY
         lyuhsFEXg0y7nfJv1cTgqMbZa+I93Taz/oKXuchZ4aM9w3+OlDIQlqRnRDmEiN+OJfSX
         kAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603685; x=1742208485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0yircpCo/QVU3P+N7sKYScgPv6naVVovFtBRlbgD6Q=;
        b=JOHvV+kS94iVoboO15i0ftq9nBaTMhu24RvionugZm4z0/PNbT2137bcjNsYirvdkp
         R3ASALcymSKqa2OxyesvAK+Q3AE4ADCG1JMPR5YXMwPSPlPH2HtuR2nN0PDmic0OeEZa
         eA1dZSi6wT7SkYjnZAGNl/FohYbftDNngp6zupZBz9VGQvJ5c022tIrTbP/tExjZuy3F
         pIx3LSz3cMegGbQobp70DYV5wQu+IYJCk4PT2PdEFQgLBPXctFlwb+hI+RZsodmtt487
         Etjuf1aU62hYMi+u/kbJ5kh51Q1GA96+xqZDXF5rQz5pu5twxZGLuR3u2n9uiCe0nDzO
         lGbw==
X-Forwarded-Encrypted: i=1; AJvYcCXDoTCAX+O57z8Z27RJj8asPoB39oPQYlQdE1PVZJ/FUZ302vqucxaf6bz6HfFgNG/n5p2SMmM/8Scm2UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZjyHI/GzuhFtX/6gyA7AjxW/GYQIKLArpEZrZL4lM33sItm/
	24I05fYAfJZFBFE2HgYrnH5/3Ok8V+y883eLDcRloq1GqreSIYYdVrnEORQrzdM=
X-Gm-Gg: ASbGncuuoK40Dozkfp4ZDg0HvYuT2QmQGfjMk9zo3EQzANweXicykYLYC9FgIdaENS5
	InmbGU6bsZU2tMq96MLzfGuBKkq/lcddUxXCDkB6LviqMaXVJg0mpZ/YPorWOWGDrXDLui4u7qQ
	rbGb8pSU2jf4HXPqwkJtRthf4WdBs6GaZMA2teHNqSNZMNMk3aL4ibiHEBBGfJ9sQs0oh2eZ7dO
	RfJvGavbfS4bbghKdDTwpeCk5xD0O3Qumf1MNYRIM+x44zWKu4Lmx+Vgm2Rk8oDswuQ9km0WX/E
	fNKjOzIs9cAAO6Ny/y7Br9T9Z0HCbAQjjw5xkNguJAqA4j3DAfN0ocj5iJ4D
X-Google-Smtp-Source: AGHT+IFlBbMsdDkibGs+3E90ni36pDU1DtBtQx2GYLaxL8v3OUzQ9CG7PxwMtpFknCcyL00KBQQ92Q==
X-Received: by 2002:a5d:47cb:0:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-3913af390a9mr5568803f8f.25.1741603684736;
        Mon, 10 Mar 2025 03:48:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2bb7sm14676793f8f.63.2025.03.10.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:48:04 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:48:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/xe: Fix uninitialized variable in xe_vm_bind_ioctl()
Message-ID: <4a74b296-8b51-4dab-a2f1-69919da1ca62@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error handling assumes that vm_bind_ioctl_check_args() will
initialize "bind_ops" but there are a couple early returns where that's
not true.  Initialize "bind_ops" to NULL from the start.

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/xe_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 22a26aff3a6e..d85759b958d0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3287,7 +3287,7 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	struct xe_exec_queue *q = NULL;
 	u32 num_syncs, num_ufence = 0;
 	struct xe_sync_entry *syncs = NULL;
-	struct drm_xe_vm_bind_op *bind_ops;
+	struct drm_xe_vm_bind_op *bind_ops = NULL;
 	struct xe_vma_ops vops;
 	struct dma_fence *fence;
 	int err;
-- 
2.47.2


