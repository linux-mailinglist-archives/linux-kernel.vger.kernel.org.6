Return-Path: <linux-kernel+bounces-250742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8492FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7610A283915
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3AD17165D;
	Fri, 12 Jul 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fX6gkVcy"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5616FF48
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793177; cv=none; b=sCzUgC88hzbGf/qqQZV/3VKworQEy4JQf+BFb3bdw7tVY3WfiU3hDl8yiiFlUoYwnOPNVXglImj53Wk3j8k8JVbrBY3Z+UQ3H4F0yu0Lvfva8DZJTkI6UfcB16DLb/hUdXp5ZXHw7MEDUclM2Cxi7a4zsNkaWCADZxsy+aIX06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793177; c=relaxed/simple;
	bh=N06X/eoY1Uebyo+0qwaEwr0aawks/J5+fGM4g2wyaBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUDpBfarOUGKUh49Bmudp/yQzB2Io6255VbGb3eiJq+dytVL7gXowK7W/r2S04/4QJNaSbPoF2TcXZEZy/3J+MAH8hve7+zaiRRBVnszrIa0dN0w/NCo+B9r7g3k43/ITHMVnlbj1O3uRhK+zPmP2HsDVL5nPrw7IeReaOqid9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fX6gkVcy; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e00f348e6so1006950fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793175; x=1721397975; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvGeMLuAwhrzJn9gtgYIG8cYNqHlo6tU2+mQF6lF0yw=;
        b=fX6gkVcy3weHYb/O12GBCdcCiTIK0PYJtIdJkZhBAYC/R++x0G60O7wOT+y2JuMLki
         yallOF0lLvKmPVJqFKpwEUvj4JDtkJeDxY4JRtwRlzWYS5/rfhI8RBCgUTqFhpy3cDKS
         jcRuxvHqqdJMATer/o4ddoar48dq8PFQNwfMI9i6+GRKT3tXBTCLb44o1JVGtAa8K3fg
         gFnkwoyv93tiUzcFBwXGXMeamr1Gz6c16gVOXQIri/1Bhh2KMZUXPCLkPQDMP6FLpmpY
         JC7qtFh1PJiwsfJPIP3qcVj//G7cwP8xPu/dtMXlQLnS1EPhxb4obxMFSA9WO25CioIS
         RZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793175; x=1721397975;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvGeMLuAwhrzJn9gtgYIG8cYNqHlo6tU2+mQF6lF0yw=;
        b=MdJx5EkhrVJeg663lwNWmlUZtBS1fXDtqCs+dlQCUdBSVijuu549/xz2dpxWDBOWys
         G5qW9lAqXpP9qv9MFGTVM2uEc04eWZv7zxLgl0eIV088IW92rBQwXDwIYMuYyyf2/a+Z
         zUSPF5iMjFrTLOCUf1GK75ecL6SHm/oSqoruagmYN5sdfWYhElpz8YAE+KU1SVNbeCiT
         e/wPd8p/J8aIlNpUTfyeF3RpnlQd8vd24eBWaCfbpcPQjdrffeVuTIJlxeAxtl7C6Ynj
         kge7jJJOUCwX/FaRrQn1uK8JU2u/t6JJQTSMIRLe9C3eiV5gHV+zAP2lQi80fVXeX0BG
         u8tw==
X-Forwarded-Encrypted: i=1; AJvYcCXaixlFdv3S+eHNKt01nCmWwTd7AoMB2wzgI1q4SXTRhvxBjPxbIIWQgKV+9t8yYSB6g2azOyzfzwm+gEK0nv5DYxJ9RHG6aJvpWnh+
X-Gm-Message-State: AOJu0YzDrSCt4O9ECJtneufdb53Q74t8rHAOxbfZPW4L2OuVxqdEzc0P
	rAYynyYQn+DT+P8rSHlByz22tYCS+rTnPaTih/5gmcsgeG9dT9DuGBOGDQ93blc=
X-Google-Smtp-Source: AGHT+IHtlDnTv4HuxsnriRgYqH4/N/EK8AvwLk/fKhC8ywuVcO8avOC/Y0CnrzNEReTN5UcGHI/41w==
X-Received: by 2002:a05:6870:a353:b0:25e:2923:a373 with SMTP id 586e51a60fabf-25eae7a3377mr9210983fac.15.1720793174935;
        Fri, 12 Jul 2024 07:06:14 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa5afa68sm2180190fac.28.2024.07.12.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:06:14 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:06:12 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srujana Challa <schalla@marvell.com>
Cc: vattunuru@marvell.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vdpa/octeon_ep: Fix error code in octep_process_mbox()
Message-ID: <623e885b-1a05-479e-ab97-01bcf10bf5b8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -EINVAL for invalid signatures.  Don't return success.

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Nag mode: When we add a new driver, then could we use the patch prefix for the
driver not for the subsystem only.

 BAD: net: add driver for abc123
GOOD: net/abc123: add driver for abc123

 drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index 7fa0491bb201..11bd76ae18cf 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -140,7 +140,7 @@ static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid, void *bu
 	val = octep_read_sig(mbox);
 	if ((val & 0xFFFF) != MBOX_RSP_SIG) {
 		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d response\n", id);
-		return ret;
+		return -EINVAL;
 	}
 
 	val = octep_read_sts(mbox);
-- 
2.43.0


