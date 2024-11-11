Return-Path: <linux-kernel+bounces-403920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862679C3CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75611C216AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00A188905;
	Mon, 11 Nov 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsVs5Ns7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BA14A4CC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323293; cv=none; b=lttHHRDj+06RwygdoeXOn+IGaithG173KJmaW6Of9xDK3IZ4E4DfOyoN6GdqpJCYXX22bB+Ls/o07v2hj73GMJ9DYy4iOr8Aggn29/OR5LB9Cwvr8WylyAxK6MxA/Bpy7D3qBnjGSyCYBtEI/EvcYgPsmWBmNuAYNjE26azhN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323293; c=relaxed/simple;
	bh=KrzJzC5LjIibjn2LH2QxndnXkbjvaFOu7KX1OY6Y2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BLexZsX7oKrySAfKyHR6Y57UAEEFtos8cxr97DlgvU5CSF90eQtnJQCUuvickviQrp/8wvZURKkcZelDeFOCbJVhQuwa9O/pIjP8u0jbP8fl/xF6EWig8fgdn1pI0U0ARo9IMt2e0tQiWjACNxgH9ONASKrhFCTcXJU6EovwhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lsVs5Ns7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso644769766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731323290; x=1731928090; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaOpQCnb58xwQNpZJwrt/dM577zB1AHFFgREUTf53Ns=;
        b=lsVs5Ns7v6s2hgGqNxi4GsbiwNcoUmoIQP60jsFv3r11zjG8IIXMXj481uoCNReRBK
         VAYa0LHFURO/l7Ip8fHRNsf1YSSiGUG3RrmhHCmfkY/GBIDJ1Xv/UwijxZFNMVUmsxFo
         93ZctszrjbbKfYKblkvcJNAf82w3MVB9dk67sdPHrvNGXIgbP0vfEgKmv77MgWfZeWjL
         uQ5MDLDQ1XoMGMMJwKpBpocZ63ar3rFTlMSzLjkzTpyseQwF7KzerFTUSES9T9MNnAmL
         YgnYcMptPu6dtMmJrm5YEv1u83Nbowu3DeHAAsXNYL7VERbNNoVRW4eVtXHfCRD6PK1a
         DedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323290; x=1731928090;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaOpQCnb58xwQNpZJwrt/dM577zB1AHFFgREUTf53Ns=;
        b=ImhT/bJ3KQzXyiVgx2V6+PbKnWeVtc6nKXT15g0C8erxzpSiubz9QmkAbTlevs702p
         GFHpO25mERZL4zbPrmLdFHDC5KqaWyLacoFxDpNgUeerQoN30kSDy5LvrkyVmPLJClVm
         UFIBHRIdWNaNll/gnWzOvjtu2dq/oqiHxwJcd/sH/eyyyf/Lx+szM9nEnTPqO/Xa2KBB
         1KqOMB/YTv2hLJnPyWqAKnzZUzMxbf2KAWLCQXItzGQ1wblOd5PTWL0wBJZSrTqJoL/6
         7tdXEpiPRX51tWy9sDGzry6/Kz6OCN8zrDqRAZGVzcrU4zn0MM5gkVXwYvGz7xuOnY08
         JL2w==
X-Forwarded-Encrypted: i=1; AJvYcCXOYkV99pM35rgUCDjlA+ZysRpWF/y+aIgNzZZS4n67f50rHt5iTRJAb5+hahe1bsDb5u9lSWHgsRTdnXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rDVbrZVJG7pNNbuvjCStb+cjSNb9r+zs9j7bPZAfm3Oxi76U
	sfXiVAU6Vh864yESamrX28wGdV80BsaRJ0Dp4hU0ODWy/9CWqu49bc75ZBJR20g=
X-Google-Smtp-Source: AGHT+IE8zTmpxJbeHHX6TsTo02EB6CL9dlS72DZFJARMZpcutHBxnoMI2RjnZgYXTYNZ3xGbE2kN8Q==
X-Received: by 2002:a17:907:3fa2:b0:a99:5f16:3539 with SMTP id a640c23a62f3a-a9eefcebbd5mr1287269866b.0.1731323289768;
        Mon, 11 Nov 2024 03:08:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deef4bsm576319966b.138.2024.11.11.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:08:09 -0800 (PST)
Date: Mon, 11 Nov 2024 14:08:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ajay Gupta <ajayg@nvidia.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Haotien Hsu <haotienh@nvidia.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: typec: fix potential array underflow in
 ucsi_ccg_sync_control()
Message-ID: <c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "command" variable can be controlled by the user via debugfs.  The
worry is that if con_index is zero then "&uc->ucsi->connector[con_index
- 1]" would be an array underflow.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index bccfc03b5986..fcb8e61136cf 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -644,6 +644,10 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 	    uc->has_multiple_dp) {
 		con_index = (uc->last_cmd_sent >> 16) &
 			UCSI_CMD_CONNECTOR_MASK;
+		if (con_index == 0) {
+			ret = -EINVAL;
+			goto unlock;
+		}
 		con = &uc->ucsi->connector[con_index - 1];
 		ucsi_ccg_update_set_new_cam_cmd(uc, con, &command);
 	}
@@ -651,6 +655,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 	ret = ucsi_sync_control_common(ucsi, command);
 
 	pm_runtime_put_sync(uc->dev);
+unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.45.2


