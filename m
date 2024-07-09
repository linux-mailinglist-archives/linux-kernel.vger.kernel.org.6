Return-Path: <linux-kernel+bounces-246579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7992C3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107FCB21030
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6A17B056;
	Tue,  9 Jul 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Yn8EjW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F417B027
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552531; cv=none; b=RsFbfdQxSMzuczQd3aGLpJBRMC/pVmBn8559392ep2dCRg48+Tuos+zY4Pe9Div+bklIFSBrsWx111RGIrnpHfazeH8SImnAs3qxLJbyINLprdvayXu/DhctWwU8qRKREEdCtIeGVYJyAckaSvb3/rKRlz/zTebnIHa+NppwXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552531; c=relaxed/simple;
	bh=l9YKWHNugysqRnclia1mnLEFda0Foyt6pZ1B9ssZsmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IwqBOq/N1qLkANQruFPnzRbBrIuO6mA+8gbSlB5o+neGToErllRcQZ2128sMHJt47onZ0UzKfMer1WRTpnzIUKY1y8NeU5XOV3W4ZlfSTdDmY1zE4bISOMU2LFQetXNJo+4ciHrKeWgPJt48isJ0OSKb88K3NR9pN+CAo/2V8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Yn8EjW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso2690095a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720552528; x=1721157328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVvD7435hpIemm43JrTkj0xQf9NKCpeT4z04Es1zZLk=;
        b=X9Yn8EjW8Q1ugBmWfmGGTLNBpwlfLHGTpS2mqzdvVBTL+TFdU/lcYEfs3yn4/dyplv
         /Hpsksgfb2wIE6HKwZbjB/VGpKROriEX2CwOWOE1Sj4tuGoUCj39JDtx6unIKOU7B7Aj
         qIdjWV4mLNaSSAe0gx6PtFB6ECBaazrvISQvMIr64VaFGWNs31uPXJOFQAGELqPM6r0g
         E/8g43RFDuPGQj6aAiSuFIU9UOD38LImFqtzmAUK8+u4iUGSPRsZOBVHxz7OlzyxQqFB
         AfySXxNpP8swszxRE359/pOub3YqZ1MifHeF0KKCbZ6kjueuoDvUPtnM4KWs+OGP+BVn
         aK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552528; x=1721157328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVvD7435hpIemm43JrTkj0xQf9NKCpeT4z04Es1zZLk=;
        b=GZKSh+/MOmQyhWiymmSukv1oDD3pAxdEQVa4PaMDSvcQIyz8bVkZ0R77bmbQ8C6Nd8
         r2fBdYnWamRstqy9Po1Cz2fAZaXrPYtxM/Qx+oxKaFUltWk0HqzQEEcfLcwNOcoYSBO0
         RJCOHz7QIOqlPr0WYNbMZ6R2M4H1rcYrLrNoa5KzxBskA7sLsLoVPYiReLFZTHl0iLSx
         8VW+zvkzElc/vanf3frU8VjO1lVTnvZ4Taccf2uvpdeQY3zvJhW+Pw/WAtcijVTEdox8
         G7+X9BwB9Ft1XqzLI+LkfXeshdniip/65wYs2hpXXeZlDOkKRYaGSkfzBy7T8A+TizBp
         vWrw==
X-Gm-Message-State: AOJu0YyY3sPekHJix4MQsQl4ug1PsAwKmWIm1ZPjLU03bmKLxIDNwcfW
	j8ymFm24ZAjiR6Zg1FbY1WfDwkSPOXdKwPLJ5rGLGDfoPi4Fbj3b6xWUGqCv
X-Google-Smtp-Source: AGHT+IG/IkLwTpdYXOdTbDjXJysGuHHmuIQhCOFXnoI3QtXxIfRS9eyG5HH9ftXNI9ZKe6BDUeLbqQ==
X-Received: by 2002:a05:6a20:7484:b0:1c2:8d0a:8e9d with SMTP id adf61e73a8af0-1c29820b872mr3856486637.7.1720552528256;
        Tue, 09 Jul 2024 12:15:28 -0700 (PDT)
Received: from localhost.localdomain ([50.39.170.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2b6bcsm19658455ad.78.2024.07.09.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:15:27 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:15:26 -0700
From: Tyler Taormina <taormina.dev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: Remove redundant parentheses
Message-ID: <Zo2MTjKCM_UaLIGx@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Unnecessary parentheses around (...)

Signed-off-by: Tyler Taormina <taormina.dev@gmail.com>
---
 drivers/staging/vme_user/vme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 0cd370ab1008..5c1d1c9b7b70 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -274,7 +274,7 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
 		mutex_lock(&slave_image->mtx);
 		if (((slave_image->address_attr & address) == address) &&
 		    ((slave_image->cycle_attr & cycle) == cycle) &&
-		    (slave_image->locked == 0)) {
+		    slave_image->locked == 0) {
 			slave_image->locked = 1;
 			mutex_unlock(&slave_image->mtx);
 			allocated_image = slave_image;
@@ -473,7 +473,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
 		if (((master_image->address_attr & address) == address) &&
 		    ((master_image->cycle_attr & cycle) == cycle) &&
 		    ((master_image->width_attr & dwidth) == dwidth) &&
-		    (master_image->locked == 0)) {
+		    master_image->locked == 0) {
 			master_image->locked = 1;
 			spin_unlock(&master_image->lock);
 			allocated_image = master_image;
@@ -849,7 +849,7 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
 		/* Find an unlocked and compatible controller */
 		mutex_lock(&dma_ctrlr->mtx);
 		if (((dma_ctrlr->route_attr & route) == route) &&
-		    (dma_ctrlr->locked == 0)) {
+		    dma_ctrlr->locked == 0) {
 			dma_ctrlr->locked = 1;
 			mutex_unlock(&dma_ctrlr->mtx);
 			allocated_ctrlr = dma_ctrlr;
@@ -1218,9 +1218,9 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
 	u32 aspace = vme_get_aspace(am);
 
 	list_for_each_entry(handler, &bridge->vme_error_handlers, list) {
-		if ((aspace == handler->aspace) &&
-		    (address >= handler->start) &&
-		    (address < handler->end)) {
+		if (aspace == handler->aspace &&
+		    address >= handler->start &&
+		    address < handler->end) {
 			if (!handler->num_errors)
 				handler->first_error = address;
 			if (handler->num_errors != UINT_MAX)
@@ -1307,7 +1307,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
 		return -EINVAL;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		dev_err(bridge->parent, "Invalid interrupt level\n");
 		return -EINVAL;
 	}
@@ -1357,7 +1357,7 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
 		return;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		dev_err(bridge->parent, "Invalid interrupt level\n");
 		return;
 	}
@@ -1405,7 +1405,7 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
 		return -EINVAL;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		dev_warn(bridge->parent, "Invalid interrupt level\n");
 		return -EINVAL;
 	}
-- 
2.39.2


