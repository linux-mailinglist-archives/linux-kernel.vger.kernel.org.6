Return-Path: <linux-kernel+bounces-227935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B7915843
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D36A2869F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0D49649;
	Mon, 24 Jun 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eVSwj4gC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865251BC2A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262117; cv=none; b=nq3Jd3gDgVLwig82aDZ6MkwCnArAA8W+qGkT6Qft5x3mEs6Ga9LOzWhLFszBTG18MUvgwHzJRhvQ6faivpvGqJiwuVv7wZnWMdJzvxfISy8LsxC4uo54i/mYQYoZtpNL92UW/mSVvk/E9akATcB4D3JmWXsvIpUw0FVv2UXaHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262117; c=relaxed/simple;
	bh=/JKN7T+zJiS+J7qH/hGZCZULxf3iWFhpdNOhLehqgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5MhrwQBXy+EWB8NpAlXkdc/uEJldsL1aKROVZ0cgzxj7VqO+xJZfAX3BpY/6wlvK5gcVlJchc9Dyku+TSbskTyRzUlIKZm5bFCOJYG+KsATREFRynx340xfK+zVW4wNwMTfsZ2htt9rBWN/M3yqX1KLK70Pdd+EGbXHXi+juqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eVSwj4gC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706738c209bso1249602b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719262116; x=1719866916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sXZy8fFmjl+2dWQsh2VTHEx+TqeWltCaGxMF+BW67w=;
        b=eVSwj4gC5Y0ek6ZdCY+YHPZMGfYEFWPXX5C0gRGHLs/4O78zDkqzbPc/zcA311J3GB
         hF2kFoiTCvKgbj+QeAECw8OeetoV5Z8CzdXMvhelmSGGF9tOhZC0K3zg94M3NVHC8qxJ
         DGW4J9azXfo+MCZHP7QkF7gCM1kN6M83sj/eYaBxnMGj4WQ7HGr2L/GPt8jQ2aDjcUuB
         JmLwpoBbrNEKJG2j/TBbwjdSlmkcOoIGJS/DMk2IXFyw8QaHRDuysHyF3G8umXFVP4AU
         VZArpEWjFc/4AXB8pPLIfbw1X9c0lgZHxdKvljTVLW5dfh/kY8WmA0Wxss6cyUD2EmUq
         PXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262116; x=1719866916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sXZy8fFmjl+2dWQsh2VTHEx+TqeWltCaGxMF+BW67w=;
        b=J+9d/WGaKOnhDK4Rs6V7IXJeLoyF/6QnSMR/wAArnT5/YUFGTo6hAYag/S8icD/P9V
         eAiL/EwbZ2CUMYFKtWPIQaellS6cGGE1dILeoQSvoJxsRdKfa3Oz3SXzFrUl0SwtBd1V
         3+KOApvasvPi/gqaqOODfNm2gjWyiYTuzi8UnAfIIt2yRF23tVkppbun2g0X1aIUGXp/
         rkxtpX4PjldnBwFQ9pQP4b67gzCcGvcMucCIDHGxhwHc+nlJfYhRqHaidtujlsrHs7PH
         KUYGanAefNOhPP7pTdKj1Fw09NBaZIFnrIcCARXnT8snTyzNZEm7HC0ib01mYVrUftIe
         V1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVfnv1FWvx/yMMPCgNBrVhrOqt5LLp+d6/2klDcfqkLV/jtJGz7qQ3SfCQLmpRneAHW/ODDQYiBS+qb0uG9Vfmbf7AM542p/93nPD4j
X-Gm-Message-State: AOJu0YwP7OsJLkEj1IpT7+OJ9DPoqs5oJtNsMRR+O5rApBqxAVcJjS3r
	/naSgfIGIAcBiVp0Ks1K+lAJeSU9ku2jMNXPcIlonZEHQqqwAx/uhxd1yg/N58P0BXX9tKoH4QQ
	KbjI=
X-Google-Smtp-Source: AGHT+IHROLAyORIu1MU6nTmKWMCgC/Gr83UJCjyNIbBhQcG3wsI2rQbFWey/4R362QhS8vyXdD8Zlw==
X-Received: by 2002:a05:6a00:bd6:b0:706:742a:1c3b with SMTP id d2e1a72fcca58-706745bbed5mr4059913b3a.8.1719262115681;
        Mon, 24 Jun 2024 13:48:35 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512900a0sm6869753b3a.149.2024.06.24.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:48:35 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ipmi: Combine identical if checks
Date: Mon, 24 Jun 2024 22:46:55 +0200
Message-ID: <20240624204654.250258-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for run_to_completion only once.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e12b531f5c2f..b7d8eb0a3432 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4870,12 +4870,12 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
 	list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
-	if (!run_to_completion)
+	if (!run_to_completion) {
 		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
 				       flags);
-
-	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
+	}
+
 	/*
 	 * We can get an asynchronous event or receive message in addition
 	 * to commands we send.
-- 
2.45.2


